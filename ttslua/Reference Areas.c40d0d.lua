function onSave ()
  -- [[
  local saveData = {}
  if layoutObject1 != nil then
    --printToAll("saving layout1GUID: "..layoutObject1)
    saveData.layoutObject1GUID = layoutObject1
  end
  if layoutObject2 != nil then
    --printToAll("saving layout2GUID: "..layoutObject2)
    saveData.layoutObject2GUID = layoutObject2
  end

  return JSON.encode(saveData)
  --]]
end

function onLoad(save_data)
  -- [[
  layoutObject1 = nil
  layoutObject2 = nil

  local saveData = JSON.decode(save_data)
  if saveData != nil then
    if saveData.layoutObject1GUID != nil then
      --printToAll("loading layout1GUID: "..saveData.layoutObject1GUID)
      if getObjectFromGUID(saveData.layoutObject1GUID) != nil then
        --printToAll("destroying layoutObject1")
        getObjectFromGUID(saveData.layoutObject1GUID).destruct()
      end
    end
    if saveData.layoutObject2GUID != nil then
      --printToAll("loading layout2GUID: "..saveData.layoutObject2GUID)
      if getObjectFromGUID(saveData.layoutObject2GUID) != nil then
        --printToAll("destroying layoutObject2")
        getObjectFromGUID(saveData.layoutObject2GUID).destruct()
      end
    end
    --textObject.destruct()
    self.setVectorLines({})
  end
  --]]

  self.UI.setXmlTable({
    {-- Image element.
      tag = "Image",
      attributes = {
        id = self.getGUID(),
        height = 60,
        width = 320,
        position = "0 0 -75",
        rotation = "0 0 0",
        color = "rgba(1,1,1,1)", -- Fully transparent by default. Change this to debug element positions.
        raycastTarget = "true",
        onClick = self.getGUID().."/click_ReferenceArea",
      }, -- end attributes for Image
    }, -- end Image element.
    {-- Text element.
      tag = "Text",
      attributes = {
        text = "Reference Areas",
        offsetXY = "0 0 0",
        position = "0 0 -75",
        rotation = "0 0 180",
        fontSize = "40",
        color = "Black",
      }, -- end attributes for Text
    },
    {-- Text element.
      tag = "Text",
      attributes = {
        id = self.getGUID().."Instructions",
        text = [[]],
      offsetXY = "0 0 0",
      position = "0 -600 -75",
      rotation = "0 0 180",
      fontSize = "72",
      color = "rgba(1,1,1,0.1)",
      }
    }
  })

end -- end onLoad



function click_ReferenceArea(player, value, id)
  if player.color == [[Grey]] then
    return
  end
  if layoutObject1 == nil or layoutObject2 == nil then
    --printToAll("No attachments")
    local minusX = -8.5
    local plusX = 8.5
    local minusZ = -2
    local plusZ = -6
    local offsetX = 0
    local offsetZ = -5
    local lineOffsetX = 0
    local lineOffsetZ = -5
    local newPosition = {
      x = self.getPosition().x,
      y = self.getPosition().y + 2.5,
      z = self.getPosition().z
    }
    local rotY = 0
    -- Snap to a 90 degree rotation.
    -- This is frankly just to make the math easier for determining where to place the new LayoutZones.
    if self.getRotation().y >= 45 and self.getRotation().y < 135 then
      --minusX = -2
      --plusX = -6
      --minusZ = -8.5
      --plusZ = 8.5
      lineOffsetX = 0
      lineOffsetZ = 5
      offsetX = 5
      offsetZ = 0
      newPosition.x = newPosition.x-5
      newPosition.z = newPosition.z
      self.setRotation({x = 0, y = 90, z = 0})
    elseif self.getRotation().y >= 135 and self.getRotation().y < 225 then
      --minusX = -8.5
      --plusX = 8.5
      --minusZ = -2
      --plusZ = -6
      lineOffsetX = 0
      lineOffsetZ = 5
      offsetX = 0
      offsetZ = -5
      newPosition.x = newPosition.x
      newPosition.z = newPosition.z+5
      self.setRotation({x = 0, y = 180, z = 0})
    elseif self.getRotation().y >= 225 and self.getRotation().y < 315 then
      --minusX = -2
      --plusX = -6
      --minusZ = -8.5
      --plusZ = 8.5
      lineOffsetX = 0
      lineOffsetZ = 5
      offsetX = -5
      offsetZ = 0
      newPosition.x = newPosition.x+5
      newPosition.z = newPosition.z
      self.setRotation({x = 0, y = 270, z = 0})
    else
      --minusX = -8.5
      --plusX = 8.5
      --minusZ = -2
      --plusZ = -6
      lineOffsetX = 0
      lineOffsetZ = 5
      offsetX = 0
      offsetZ = 5
      newPosition.x = newPosition.x
      newPosition.z = newPosition.z-5
      self.setRotation({x = 0, y = 0, z = 0})
    end
    rotY = self.getRotation().y+180

    local layoutTransform1 = {
      posX = newPosition.x,
      posY = newPosition.y,
      posZ = newPosition.z,
      rotX = 0,
      rotY = rotY,
      rotZ = 0,
      scaleX = 17,
      scaleY = 6,
      scaleZ = 2,
    }
    local layoutTransform2 = {
      posX = newPosition.x-offsetX,
      posY = newPosition.y,
      posZ = newPosition.z-offsetZ,
      rotX = 0,
      rotY = rotY,
      rotZ = 0,
      scaleX = 17,
      scaleY = 6,
      scaleZ = 2,
    }

    local layoutZoneData = {
      Options = {
        Direction = 0,
        MeldDirection = 0,
        NewObjectFacing = 1,
        TriggerForFaceUp = true,
        TriggerForFaceDown = true,
        TriggerForNonCards = false,
        AllowSwapping = true,
        MaxObjectsPerNewGroup = 13,
        MaxObjectsPerGroup = 0,
        MeldSort = 5,
        MeldReverseSort = false,
        MeldSortExisting = true,
        StickyCards = false,
        HorizontalSpread = 1.4,
        VerticalSpread = 0.0,
        HorizontalGroupPadding = 0.0,
        VerticalGroupPadding = 0.0,
        SplitAddedDecks = true,
        CombineIntoDecks = false,
        CardsPerDeck = 0,
        AlternateDirection = false,
        Randomize = false,
        InstantRefill = false,
        ManualOnly = false
      },
      GroupsInZone = {},
    }

    local layoutData1 = {
      Name = [[LayoutZone]],
      Transform = layoutTransform1,
      ColorDiffuse = { r = 0, g = 0, b = 0, a = 0, },
      LayoutGroupSortIndex = 0,
      --Value = 0,
      Locked = true,
      --Grid = true,
      --Snap = true,
      --IgnoreFoW = false,
      --MeasureMovement = false,
      --DragSelectable = true,
      --Autoraise true,
      --"Sticky": true,
      --"Tooltip": true,
      --"GridProjection": false,
      --"HideWhenFaceDown": false,
      --Hands": false,
      LayoutZone = layoutZoneData,
    }
    local layoutData2 = {
      Name = [[LayoutZone]],
      Transform = layoutTransform2,
      ColorDiffuse = { r = 0, g = 0, b = 0, a = 0, },
      LayoutGroupSortIndex = 0,
      Locked = true,
      LayoutZone = layoutZoneData,
    }

    local tempObject1 = spawnObjectData({
      data = layoutData1,
      callback_function = function(obj)
        layoutObject1 = obj.getGUID()
        hideLayoutObject(obj)
      end,
    })
    local tempObject2 = spawnObjectData({
      data = layoutData2,
      callback_function = function(obj)
        layoutObject2 = obj.getGUID()
        hideLayoutObject(obj)
      end,
    })

    -- Create the vector line outlines.
    self.UI.setAttributes(self.getGUID().."Instructions", {
      text = [[Drop a set of reference cards here.




(Toggle these off afterward to prevent
them from rearranging themselves later.)
]]
    })
    local lineColor = {1,1,1,0.2}
    local lineThickness = 0.1
    --offsetZ = math.abs(offsetZ)
    --offsetX = math.abs(offsetX)
    self.setVectorLines({
      { points = {
          { minusX, 0, minusZ},
          { minusX, 0, plusZ}, },
        color = lineColor,
        thickness = lineThickness,
        rotation = {0,0,0} },
      { points = {
          { minusX, 0, plusZ},
          { plusX, 0, plusZ}, },
        color = lineColor,
        thickness = lineThickness,
        rotation = {0,0,0} },
      { points = {
          { plusX, 0, plusZ},
          { plusX, 0, minusZ}, },
        color = lineColor,
        thickness = lineThickness,
        rotation = {0,0,0} },
      { points = {
          { plusX, 0, minusZ},
          { minusX, 0, minusZ}, },
        color = lineColor,
        thickness = lineThickness,
        rotation = {0,0,0} },
      { points = {
          { minusX-lineOffsetX, 0, minusZ-lineOffsetZ},
          { minusX-lineOffsetX, 0, plusZ-lineOffsetZ}, },
        color = lineColor,
        thickness = lineThickness,
        rotation = {0,0,0} },
      { points = {
          { minusX-lineOffsetX, 0, plusZ-lineOffsetZ},
          { plusX-lineOffsetX, 0, plusZ-lineOffsetZ}, },
        color = lineColor,
        thickness = lineThickness,
        rotation = {0,0,0} },
      { points = {
          { plusX-lineOffsetX, 0, plusZ-lineOffsetZ},
          { plusX-lineOffsetX, 0, minusZ-lineOffsetZ}, },
        color = lineColor,
        thickness = lineThickness,
        rotation = {0,0,0} },
      { points = {
          { plusX-lineOffsetX, 0, minusZ-lineOffsetZ},
          { minusX-lineOffsetX, 0, minusZ-lineOffsetZ}, },
        color = lineColor,
        thickness = lineThickness,
        rotation = {0,0,0} },
    })
  else
    if getObjectFromGUID(layoutObject1) != nil then
      --printToAll("destroying layoutObject1")
      getObjectFromGUID(layoutObject1).destruct()
      layoutObject1 = nil
    end
    if getObjectFromGUID(layoutObject2) != nil then
      --printToAll("destroying layoutObject2")
      getObjectFromGUID(layoutObject2).destruct()
      layoutObject2 = nil
    end
    --textObject.destruct()
    self.UI.setAttributes(self.getGUID().."Instructions", {
      text = [[]]
    })
    self.setVectorLines({})
  end
end



function hideLayoutObject(obj)
  obj.attachInvisibleHider(obj.getGUID(), false, {
    "White",
    "Brown",
    "Red",
    "Orange",
    "Yellow",
    "Green",
    "Teal",
    "Blue",
    "Purple",
    "Pink",
    "Grey"
  })
  obj.jointTo(self, {
    type             = "Fixed",-- string (required - "Fixed", "Hinge", or "Spring"),
    --collision        = -- bool,
    --break_force      = -- float,
    --break_torque     = -- float,
    --axis             = -- Vector,
    --anchor           = -- Vector,
    --connected_anchor = -- Vector,
    --motor_force      = -- float,
    --motor_velocity   = -- float,
    --motor_free_spin  = -- bool,
    --spring           = -- float [10],
    --damper           = -- float [0.2],
    --max_distance     = -- float,
    --min_distance     = -- float,
  })
end



function onDestroy()
  if layoutObject1 != nil then
    local destroyingObject1 = getObjectFromGUID(layoutObject1)
    if destroyingObject1 != nil then
      --printToAll("onDestroy: layoutObject1")
      destroyingObject1.destruct()
      layoutObject1 = nil
    end
  end
  if layoutObject2 != nil then
    local destroyingObject2 = getObjectFromGUID(layoutObject2)
    if destroyingObject2 != nil then
      --printToAll("onDestroy: layoutObject2")
      destroyingObject2.destruct()
      layoutObject2 = nil
    end
  end
  --textObject.destruct()
  --[=[
  self.UI.setAttributes(self.getGUID().."Instructions", {
    text = [[]]
  })
  --]=]
  --self.setVectorLines({})
end