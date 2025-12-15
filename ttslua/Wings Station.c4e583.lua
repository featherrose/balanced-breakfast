function onLoad()

  playmatStation = getObjectFromGUID([[b70028]])

  -- This is just a shortcut for effects that need to hide something from all players.
  allPlayers = {
    "Red",
    "Blue",
    "Yellow",
    "Green",
    "Orange",
    "Purple",
    "White",
    "Teal",
    "Pink",
    "Brown",
    "Black",
    "Grey"
  }

  --uninteractableObjects = Global.getVar("uninteractableObjects")
  local visibilityString = [[Black]]
  local activeCheck = {}

  for i,thisPlayerName in ipairs(allPlayers) do
    local isActive = playmatStation.call("getPlayerStatus", { player = thisPlayerName })
    activeCheck[thisPlayerName] = isActive
    if isActive == true then
      visibilityString = visibilityString..[[|]]..thisPlayerName
    end
  end

  uiXmlTable = {}

  if activeCheck["White"] == true and activeCheck["Teal"] == true then
    table.insert(uiXmlTable, {--Toggle element.
      tag = "Toggle",
      attributes = {
        id = [[ToggleAftWings]],
        colors = [[rgba(1,1,1,1)|rgba(0.5,0.5,0.5,1)|rgba(1,1,1,0.6)|rgba(0.75,0.75,0.75,0.1)]],
        onValueChanged = self.getGUID()..'/uiClick_ToggleWings',
        position = "0 -3400 -250", -- x z -y
        offsetXY = "0 0 0",
        rotation = "45 0 180",
        scale = "3 3 3",
        visibility = visibilityString,
        --visibility = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black]],
        isOn = [[True]],
      }, -- end attributes for Toggle
    }) -- end Toggle element
  end

  if activeCheck["Pink"] == true and activeCheck["Brown"] == true then
    table.insert(uiXmlTable, {--Toggle element.
      tag = "Toggle",
      attributes = {
        id = [[ToggleForeWings]],
        colors = [[rgba(1,1,1,1)|rgba(0.5,0.5,0.5,1)|rgba(1,1,1,0.6)|rgba(0.75,0.75,0.75,0.1)]],
        onValueChanged = self.getGUID()..'/uiClick_ToggleWings',
        position = "0 3400 -250", -- x z -y
        offsetXY = "0 0 0",
        rotation = "-45 0 0",
        scale = "3 3 3",
        visibility = visibilityString,
        --visibility = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black]],
        isOn = [[True]],
      }, -- end attributes for Toggle
    }) -- end Toggle element
  end

  if activeCheck["Orange"] == true and activeCheck["Purple"] == true then
    table.insert(uiXmlTable, {--Toggle element.
      tag = "Toggle",
      attributes = {
        id = [[ToggleLarboardWings]],
        colors = [[rgba(1,1,1,1)|rgba(0.5,0.5,0.5,1)|rgba(1,1,1,0.6)|rgba(0.75,0.75,0.75,0.1)]],
        onValueChanged = self.getGUID()..'/uiClick_ToggleWings',
        position = "-3400 0 -250", -- x z -y
        offsetXY = "0 0 0",
        rotation = "0 -45 90",
        scale = "3 3 3",
        visibility = visibilityString,
        --visibility = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black]],
        isOn = [[True]],
      }, -- end attributes for Toggle
    }) -- end Toggle element
  end

  if activeCheck["Yellow"] == true and activeCheck["Green"] == true then
    table.insert(uiXmlTable, {--Toggle element.
      tag = "Toggle",
      attributes = {
        id = [[ToggleStarboardWings]],
        colors = [[rgba(1,1,1,1)|rgba(0.5,0.5,0.5,1)|rgba(1,1,1,0.6)|rgba(0.75,0.75,0.75,0.1)]],
        onValueChanged = self.getGUID()..'/uiClick_ToggleWings',
        position = "3400 0 -250", -- x z -y
        offsetXY = "0 0 0",
        rotation = "0 45 270",
        scale = "3 3 3",
        visibility = visibilityString,
        --visibility = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black]],
        isOn = [[True]],
      }, -- end attributes for Toggle
    }) -- end Toggle element
  end

  self.UI.setXmlTable(uiXmlTable)

  itemDataTables = {
    ToggleAftWings = {},
    ToggleForeWings = {},
    ToggleLarboardWings = {},
    ToggleStarboardWings = {},
  }
  --[=[
  local state = JSON.decode(script_state)
  if state != nil then
    itemDataTables.ToggleAftWings = state.ToggleAftWings
    itemDataTables.ToggleForeWings = state.ToggleForeWings
    itemDataTables.ToggleLarboardWings = state.ToggleLarboardWings
    itemDataTables.ToggleStarboardWings = state.ToggleStarboardWings
  end
  itemDataTablesString = JSON.encode(itemDataTables)
  --]=]
  --itemDataAft = {}
  --itemDataFore = {}
  --itemDataLarboard = {}
  --itemDataStarboard = {}
  --[=[
  itemsAft = {
    getObjectFromGUID('ff6c59'), -- Aft Wing
    getObjectFromGUID('a743b5'), -- Aft Shelf
    getObjectFromGUID('c33d52'), -- Aft coin
    getObjectFromGUID('44efa8'), -- Aft full mat
    getObjectFromGUID('20a5eb'), -- White half mat
    getObjectFromGUID('a93880'), -- White selection area
    getObjectFromGUID('be7761'), -- White hidden area
    getObjectFromGUID('58fbf4'), -- White selection instructions
    getObjectFromGUID('5b2d98'), -- White selection bag
    getObjectFromGUID('dc6578'), -- White Reference Areas
    getObjectFromGUID('1535a8'), -- White Reference Generator
    getObjectFromGUID('2f6462'), -- White Life counter
    getObjectFromGUID('66f138'), -- Teal half mat
    getObjectFromGUID('fef26b'), -- Teal selection area
    getObjectFromGUID('f525b9'), -- Teal hidden area
    getObjectFromGUID('4d5ada'), -- Teal selection instructions
    getObjectFromGUID('593aab'), -- Teal selection bag
    getObjectFromGUID('9dd0ec'), -- Teal Reference Areas
    getObjectFromGUID('53fcd9'), -- Teal Reference Generator
    getObjectFromGUID('f65e3d'), -- Teal Life counter
  }
  --]=]

  -- Identify wings and supports.
  wingStarboard = getObjectFromGUID('8315f0')
  wingLarboard = getObjectFromGUID('5abdcf')
  wingFore = getObjectFromGUID('19c47a')
  wingAft = getObjectFromGUID('ff6c59')

  shelfStarboard = getObjectFromGUID('43b2d3')
  shelfLarboard = getObjectFromGUID('a6d0f1')
  shelfFore = getObjectFromGUID('ee2fe6')
  shelfAft = getObjectFromGUID('a743b5')

  --scriptingArea = getObjectFromGUID('59ea4f')

  scriptingAreaList = {
    ToggleAftWings = {
      guid = [[59ea4f]],
      position = { x = 0, y = 2, z = -72.5, },
      scale = { x = 87, y = 10, z = 58, },
      rotation = { x = 0, y = 0, z = 0, },
      player1 = [[White]],
      player2 = [[Teal]],
    },
    ToggleForeWings = {
      guid = [[7858f1]],
      position = { x = 0, y = 2, z = 72.5, },
      scale = { x = 87, y = 10, z = 58, },
      rotation = { x = 0, y = 180, z = 0, },
      player1 = [[Pink]],
      player2 = [[Brown]],
    },
    ToggleLarboardWings = {
      guid = [[89282d]],
      position = { x = -72.5, y = 2, z = 0, },
      scale = { x = 87, y = 10, z = 58, },
      rotation = { x = 0, y = 270, z = 0, },
      player1 = [[Orange]],
      player2 = [[Purple]],
    },
    ToggleStarboardWings = {
      guid = [[287038]],
      position = { x = 72.5, y = 2, z = 0, },
      scale = { x = 87, y = 10, z = 58, },
      rotation = { x = 0, y = 90, z = 0, },
      player1 = [[Yellow]],
      player2 = [[Green]],
    },
  }

  basePlr1 = getObjectFromGUID('6c3c09') -- Blue
  basePlr2 = getObjectFromGUID('5e9f6e') -- Red
  basePlr3 = getObjectFromGUID('90de45') -- Green
  basePlr4 = getObjectFromGUID('8c1616') -- Yellow
  basePlr5 = getObjectFromGUID('7e0a75') -- Purple
  basePlr6 = getObjectFromGUID('628627') -- Orange
  basePlr7 = getObjectFromGUID('544ba5') -- Brown
  basePlr8 = getObjectFromGUID('ac2440') -- Pink
  basePlr9 = getObjectFromGUID('fef26b') -- Teal
  basePlr10 = getObjectFromGUID('a93880') -- White

  -- Set wings to uninteractable.
  --if debugFlag != true then
  for i,markUninteractable in ipairs({
    wingStarboard,
    wingLarboard,
    wingAft,
    wingFore,
    shelfStarboard,
    shelfLarboard,
    shelfAft,
    shelfFore,
    basePlr1,
    basePlr2,
    basePlr3,
    basePlr4,
    basePlr5,
    basePlr6,
    basePlr7,
    basePlr8,
    basePlr9,
    basePlr10,
  }) do
    if markUninteractable != nil then
      markUninteractable.interactable = false
      Global.call("addUninteractable", { GUID = markUninteractable.getGUID() })
    end
  end

  --self.interactable = false
  --[=[
  wingStarboard.interactable = false
  wingLarboard.interactable = false
  wingAft.interactable = false
  wingFore.interactable = false
  shelfStarboard.interactable = false
  shelfLarboard.interactable = false
  shelfAft.interactable = false
  shelfFore.interactable = false
  basePlr1.interactable = false
  basePlr2.interactable = false
  basePlr3.interactable = false
  basePlr4.interactable = false
  basePlr5.interactable = false
  basePlr6.interactable = false
  basePlr7.interactable = false
  basePlr8.interactable = false
  basePlr9.interactable = false
  basePlr10.interactable = false
  Global.call("addUninteractable", { GUID = wingStarboard.getGUID() })
  Global.call("addUninteractable", { GUID = wingLarboard.getGUID() })
  Global.call("addUninteractable", { GUID = wingAft.getGUID() })
  Global.call("addUninteractable", { GUID = wingFore.getGUID() })
  Global.call("addUninteractable", { GUID = shelfStarboard.getGUID() })
  Global.call("addUninteractable", { GUID = shelfLarboard.getGUID() })
  Global.call("addUninteractable", { GUID = shelfAft.getGUID() })
  Global.call("addUninteractable", { GUID = shelfFore.getGUID() })
  Global.call("addUninteractable", { GUID = basePlr1.getGUID() })
  Global.call("addUninteractable", { GUID = basePlr2.getGUID() })
  Global.call("addUninteractable", { GUID = basePlr3.getGUID() })
  Global.call("addUninteractable", { GUID = basePlr4.getGUID() })
  Global.call("addUninteractable", { GUID = basePlr5.getGUID() })
  Global.call("addUninteractable", { GUID = basePlr6.getGUID() })
  Global.call("addUninteractable", { GUID = basePlr7.getGUID() })
  Global.call("addUninteractable", { GUID = basePlr8.getGUID() })
  Global.call("addUninteractable", { GUID = basePlr9.getGUID() })
  Global.call("addUninteractable", { GUID = basePlr10.getGUID() })
  --]=]

  --uiClick_ToggleWings({ color = [[White]] }, [[False]], [[ToggleAftWings]])
  --uiClick_ToggleWings({ color = [[Pink]] }, [[False]], [[ToggleForeWings]])
  --uiClick_ToggleWings({ color = [[Orange]] }, [[False]], [[ToggleLarboardWings]])
  --uiClick_ToggleWings({ color = [[Yellow]] }, [[False]], [[ToggleStarboardWings]])
  --end
  if Global.getVar("debugFlag") != true then
    self.setLock(true)
    self.interactable = false
    Global.call("addUninteractable", { GUID = self.getGUID() })
  end
end -- end onLoad



function debugLog(params)
  local debugText = params[1] or "<empty debug call>"
  local debugImportance = params[2] or 0
  local debugColor = params[3] or {0,1,0}
  --debugText = debugText or "<empty debug call>"
  --debugImportance = debugImportance or 0
  --debugColor = debugColor or {1,1,1}
  local debugFlag = Global.getVar("debugFlag") or false
  local debugLevel = Global.getVar("debugLevel") or 1
  if debugFlag == true and debugLevel >= debugImportance then
    printToAll(debugText, debugColor)
  end
end


--[=[
function onSave()
  local state = itemDataTablesJSON
  --debugLog{printTable(state), 3}
  return state
end
--]=]



function printTable(thisTable, indentation)
  local indent = indentation or [[]]
  indent = indent.." "
  local printString = [[]]
  if type(thisTable) == [[table]] then
    for key,val in pairs(thisTable) do
      if type(key) == "number" then
        printString = printString..[=[

[AAAAAA]]=]
      else
        printString = printString..[=[

[FFFFFF]]=]
      end
      printString = printString..indent..[[key: ]]..key..[=[[-], ]=]
      --printToAll(indent.."key: "..key)
      printString = printString..printTable(val, indent)
    end
  elseif type(thisTable) == [[boolean]] then
    if thisTable then
      printString = printString..[=[[00FF00]value: true[-]]=]
      --printToAll(indent.."value: true", {0,1,0})
    else
      printString = printString..[=[[FFFF00]value: false[-]]=]
      --printToAll(indent.."value: false", {1,1,0})
    end
  elseif type(thisTable) == [[nil]] then
    printString = printString..[=[[FF0000]is nil[-]]=]
  else
    --local value = thisTable or "nil"
    printString = printString..[=[[00FFFF]value: ]=]..thisTable..[=[[-]]=]
    --printToAll(indent.."value: "..thisTable, {0,1,1})
  end
  return printString
end -- end printTable



function uiClick_ToggleWings(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end

  debugLog{" uiClick_ToggleWings toggle value: "..value, 2}
  debugLog{" uiClick_ToggleWings toggle id: "..id, 1}

  local hiddenObjects = Global.getVar("hiddenObjects")
  local uninteractableObjects = Global.getVar("uninteractableObjects")

  local itemDataTable = itemDataTables[id]
  local scriptingArea = getObjectFromGUID(scriptingAreaList[id].guid)
  local scriptingAreaStats = scriptingAreaList[id]

  local player1 = scriptingAreaStats.player1
  local player2 = scriptingAreaStats.player2
  --local newPosition = scriptingAreaStats.position
  --local newScale = scriptingAreaStats.scale
  --local newRotation = scriptingAreaStats.rotation

  --scriptingArea.setPosition(newPosition)
  --scriptingArea.setScale(newScale)
  --scriptingArea.setRotation(newRotation)

  --[=[
  if id == [[ToggleAftWings]] then
    player1 = [[White]]
    player2 = [[Teal]]
  elseif id == [[ToggleForeWings]] then
    player1 = [[Pink]]
    player2 = [[Brown]]
  elseif id == [[ToggleLarboardWings]] then
    player1 = [[Orange]]
    player2 = [[Purple]]
  elseif id == [[ToggleStarboardWings]] then
    player1 = [[Yellow]]
    player2 = [[Green]]
  end
  --]=]

  if value == [[False]] then
    if player.color != player1 and player.color != player2 and player.color != [[Black]] and #Player.getPlayers() != 1 then
      self.UI.setAttributes(id, { isOn = [[True]] })
      broadcastToColor([[Only players seated at that table can disable it.]], player.color)
      return
    end
    playmatStation.call("disablePlayer", { player = player1 })
    playmatStation.call("disablePlayer", { player = player2 })
    for i,item in ipairs(scriptingArea.getObjects()) do
      -- The Red and Blue selection areas and character bags are exceptions.
      if item.getGUID() != basePlr1.getGUID()
      and item.getGUID() != basePlr2.getGUID()
      and item.getGUID() != [[b65b2c]]
      and item.getGUID() != [[016f70]] then
        debugLog{" item hide: "..item.getGUID(), 3}
        local itemData = item.getData()
        table.insert(itemDataTable, itemData)
        --print("type: "..item.type)
        destroyObject(item)
        --item.attachInvisibleHider("AftToggle", true, allPlayers)
        --item.unregisterCollisions()
      end
    end
  elseif value == [[True]] then
    playmatStation.call("enablePlayer", { player = player1 })
    playmatStation.call("enablePlayer", { player = player2 })
    for i,itemData in ipairs(itemDataTable) do
      debugLog{" item show: "..itemData.GUID, 3}
      local callbackFunction = function(spawned_object) end

      -- If the object is in the global list of hidden objects, hide it.
      if hiddenObjects[itemData.GUID] == true then
        if uninteractableObjects[itemData.GUID] == true then
          debugLog{"   should be hidden and uninteractable", 3}
          callbackFunction = hideUninteractableObject
        else
          debugLog{"   should be hidden", 3}
          callbackFunction = hideObject
        end
      else
        if uninteractableObjects[itemData.GUID] == true then
          debugLog{"   should be uninteractable", 3}
          callbackFunction = uninteractableObject
        end
      end

      spawnObjectData({ data = itemData, callback_function = callbackFunction })
      itemDataTable[i] = nil
    end -- finish looping through itemDataTable
  end
  --itemDataTablesString = JSON.encode(itemDataTables)
end -- end uiClick_ToggleWings



function hideObject(object)
  debugLog{"attaching invisible hider for "..object.getGUID(), 4}
  object.attachInvisibleHider(object.getGUID(), true, allPlayers)
end

function uninteractableObject(object)
  debugLog{"setting uninteractable: "..object.getGUID(), 4}
  object.interactable = false
end

function hideUninteractableObject(object)
  debugLog{"attaching invisible hider and setting uninteractable: "..object.getGUID(), 4}
  object.attachInvisibleHider(object.getGUID(), true, allPlayers)
  object.interactable = false
end