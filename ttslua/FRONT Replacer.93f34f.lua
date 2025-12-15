function onLoad()
  newFace = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GR65zOQ.jpg]]
  self.UI.setXmlTable({
    {-- InputField element.
      tag = "InputField",
      attributes = {
        id = self.getGUID(),
        height = 280,
        width = 340,
        scale = "4 4 1",
        position = "0 0 5",
        rotation = "0 180 180",
        colors = [[rgba(1,1,1,1)|rgba(0.8,0.8,0.8,1)|rgba(0.8,0.8,1,1)|rgba(0,0,0,1)|rgba(0,0,0,1)]],
        raycastTarget = "true",
        onEndEdit = self.getGUID().."/input_func",
        placeholder = [[You can drop a card here to read its card face URL!]],
        fontSize = 72,
        resizeTextForBestFit = true,
        lineType = [[MultiLineSubmit]],
      }, -- end attributes for InputField
    }, -- end InputField element.
  })
end

function input_func(player, value, id)
  newFace = value
  self.UI.setXmlTable({
    {-- InputField element.
      tag = "InputField",
      attributes = {
        id = self.getGUID(),
        text = newFace,
        height = 280,
        width = 340,
        scale = "4 4 1",
        position = "0 0 5",
        rotation = "0 180 180",
        colors = [[rgba(1,1,1,1)|rgba(0.8,0.8,0.8,1)|rgba(0.8,0.8,1,1)|rgba(0,0,0,1)|rgba(0,0,0,1)]],
        raycastTarget = "true",
        onEndEdit = self.getGUID().."/input_func",
        placeholder = [[You can drop a card here to read its card face URL!]],
        fontSize = 72,
        resizeTextForBestFit = true,
        lineType = [[MultiLineSubmit]],
      }, -- end attributes for InputField
    }, -- end InputField element.
  })
end

function onObjectDrop(color, obj)
    --print("Obj" .. obj.getName()) --debug
--    local objectName = obj.getName()
--    local objectNick = obj.name
--    print(objectName)
--    print(objectNick)
  if obj.getGUID() != self.getGUID() then
    if obj.tag == 'Card' then
      if nearMe(obj) then
        local textJSON = obj.getJSON()
        local faceIndex = string.find(textJSON, [["FaceURL": "]])
        local faceIndexEnd = string.find(textJSON, [["]], faceIndex+12)
        local faceURL = string.sub(textJSON, faceIndex+12, faceIndexEnd-1)
        if obj.tag == 'Card' and self.getRotation()[3] > 90 and self.getRotation()[3] < 270 and faceURL != [[]] then
          --printToAll("Reading face URL", {0, 1, 1})
          self.UI.setXmlTable({
            {-- InputField element.
              tag = "InputField",
              attributes = {
                id = self.getGUID(),
                text = faceURL,
                height = 280,
                width = 340,
                scale = "4 4 1",
                position = "0 0 5",
                rotation = "0 180 180",
                colors = [[rgba(0,1,1,1)|rgba(0.8,0.8,0.8,1)|rgba(0.8,0.8,1,1)|rgba(0,0,0,1)|rgba(0,0,0,1)]],
                raycastTarget = "true",
                onEndEdit = self.getGUID().."/input_func",
                placeholder = [[You can drop a card here to read its card face URL!]],
                fontSize = 72,
                resizeTextForBestFit = true,
                lineType = [[MultiLineSubmit]],
              }, -- end attributes for InputField
            }, -- end InputField element.
          })
          newFace = faceURL
        elseif self.getRotation()[3] <= 90 or self.getRotation()[3] >= 270 and faceURL != [[]] then
          --printToAll("Attempting to set face URL")

          --local oldSetting1 = [["BackIsHidden": false]]
          --local newSetting1 = [["BackIsHidden": true]]
          local oldSetting2 = [["UniqueBack": true]]
          local newSetting2 = [["UniqueBack": false]]

          --printToAll("   existing faceURL: " .. faceURL)
          --printToAll("   new faceURL: " .. newFace)

          --printToAll("Checking for one of the default face images...")
          --local textModified1 = string.gsub(textJSON, [[http://cloud%-3.steamusercontent.com/ugc/773984798842631902/F74DDA0374F87E8DF4AE269ED5A0D394C4917FFD/]], faceURL)

          --printToAll("Modifying existing faceURL so it functions in the search expression")
          local replacementURL = string.gsub(faceURL, [[%-]], [[%%-]])
          --printToAll("   adjusted replacementURL: " .. replacementURL)

          --printToAll("Searching and replacing existing faceURL with new faceURL")
          local textModified2 = string.gsub(textJSON, replacementURL, newFace)

          --printToAll("Hiding faces...")
          --local textModified3 = string.gsub(textModified2, oldSetting1, newSetting1)

          --printToAll("Disabling unique faces...")
          --local textModified4 = string.gsub(textModified3, oldSetting2, newSetting2)

          --printToAll("Spawning new object...")
          local thisPosition = self.getPosition()
          local thisRotation = obj.getRotation()
          spawnObjectJSON({
            json              = textModified2,
            position          = {thisPosition[1], thisPosition[2]+5, thisPosition[3]}, -- Vector [x=0, y=3, z=0],
            rotation          = {thisRotation[1], thisRotation[2], thisRotation[3]+180}, -- Vector [x=0, y=0, z=0],
            scale             = obj.getScale(),-- Vector [x=1, y=1, z=1],
            --callface_function = -- string,
            --sound             = -- bool,
            --params            = -- Table,
            --snap_to_grid      = -- bool,
          })
        end -- end rotation check and fork
      end -- end if nearMe
    end -- end if Card or Deck
  end -- end if not self
end -- end onObjectDrop

function nearMe(obj)
    if obj.getGUID() != self.getGUID() then
      --printToAll("obj: " .. obj.getGUID())
      --printToAll("selfPos: " .. self.getPosition().x)
      return withinArea(self, obj)
    end
    return
end

function withinArea(area, obj)
    local ap = area.getPosition()
    local as = area.getScale()
    local op = obj.getPosition()
    return op[1] > ap[1] - as[1]*8 and op[1] < ap[1] + as[1]*8 and op[3] > ap[3] - as[3]*10 and op[3] < ap[3] + as[3]*10
end