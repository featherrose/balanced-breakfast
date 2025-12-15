function onLoad()
  newBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/igYZhPh.png]]
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
        placeholder = [[You can drop a card here to read its card back URL!]],
        fontSize = 72,
        resizeTextForBestFit = true,
        lineType = [[MultiLineSubmit]],
      }, -- end attributes for InputField
    }, -- end InputField element.
  })
end

-- [=[
function input_func(player, value, id)
  newBack = value
  self.UI.setXmlTable({
    {-- InputField element.
      tag = "InputField",
      attributes = {
        id = self.getGUID(),
        text = newBack,
        height = 280,
        width = 340,
        scale = "4 4 1",
        position = "0 0 5",
        rotation = "0 180 180",
        colors = [[rgba(1,1,1,1)|rgba(0.8,0.8,0.8,1)|rgba(0.8,0.8,1,1)|rgba(0,0,0,1)|rgba(0,0,0,1)]],
        raycastTarget = "true",
        onEndEdit = self.getGUID().."/input_func",
        placeholder = [[You can drop a card here to read its card back URL!]],
        fontSize = 72,
        resizeTextForBestFit = true,
        lineType = [[MultiLineSubmit]],
      }, -- end attributes for InputField
    }, -- end InputField element.
  })
end
--]=]

function onObjectDrop(color, obj)
    --print("Obj" .. obj.getName()) --debug
--    local objectName = obj.getName()
--    local objectNick = obj.name
--    print(objectName)
--    print(objectNick)
  if obj.getGUID() != self.getGUID() then
    if obj.tag == 'Card' or obj.tag == 'Deck' then
      if nearMe(obj) then
        local textJSON = obj.getJSON()
        local backIndex = string.find(textJSON, [["BackURL": "]])
        local backIndexEnd = string.find(textJSON, [["]], backIndex+12)
        local backURL = string.sub(textJSON, backIndex+12, backIndexEnd-1)
        if obj.tag == 'Card' and self.getRotation()[3] > 90 and self.getRotation()[3] < 270 and backURL != [[]] then
          --printToAll("Reading back URL", {0, 1, 1})
          self.UI.setXmlTable({
            {-- InputField element.
              tag = "InputField",
              attributes = {
                id = self.getGUID(),
                text = backURL,
                height = 280,
                width = 340,
                scale = "4 4 1",
                position = "0 0 5",
                rotation = "0 180 180",
                colors = [[rgba(0,1,1,1)|rgba(0.8,0.8,0.8,1)|rgba(0.8,0.8,1,1)|rgba(0,0,0,1)|rgba(0,0,0,1)]],
                raycastTarget = "true",
                onEndEdit = self.getGUID().."/input_func",
                placeholder = [[You can drop a card here to read its card back URL!]],
                fontSize = 72,
                resizeTextForBestFit = true,
                lineType = [[MultiLineSubmit]],
              }, -- end attributes for InputField
            }, -- end InputField element.
          })
          newBack = backURL
        elseif self.getRotation()[3] <= 90 or self.getRotation()[3] >= 270 and backURL != [[]] then
          --printToAll("Attempting to set back URL")

          local oldSetting1 = [["BackIsHidden": false]]
          local newSetting1 = [["BackIsHidden": true]]
          local oldSetting2 = [["UniqueBack": true]]
          local newSetting2 = [["UniqueBack": false]]

          --printToAll("   existing backURL: " .. backURL)
          --printToAll("   new backURL: " .. newBack)

          --printToAll("Checking for one of the default back images...")
          --local textModified1 = string.gsub(textJSON, [[http://cloud%-3.steamusercontent.com/ugc/773984798842631902/F74DDA0374F87E8DF4AE269ED5A0D394C4917FFD/]], backURL)

          --printToAll("Modifying existing backURL so it functions in the search expression")
          local replacementURL = string.gsub(backURL, [[%-]], [[%%-]])
          --printToAll("   adjusted replacementURL: " .. replacementURL)

          --printToAll("Searching and replacing existing backURL with new backURL")
          local textModified2 = string.gsub(textJSON, replacementURL, newBack)

          --printToAll("Hiding backs...")
          local textModified3 = string.gsub(textModified2, oldSetting1, newSetting1)

          --printToAll("Disabling unique backs...")
          --local textModified4 = string.gsub(textModified3, oldSetting2, newSetting2)

          --printToAll("Spawning new object...")
          local thisPosition = self.getPosition()
          local thisRotation = obj.getRotation()
          spawnObjectJSON({
            json              = textModified3,
            position          = {thisPosition[1], thisPosition[2]+5, thisPosition[3]}, -- Vector [x=0, y=3, z=0],
            rotation          = {thisRotation[1], thisRotation[2], thisRotation[3]+180}, -- Vector [x=0, y=0, z=0],
            scale             = obj.getScale(),-- Vector [x=1, y=1, z=1],
            --callback_function = -- string,
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