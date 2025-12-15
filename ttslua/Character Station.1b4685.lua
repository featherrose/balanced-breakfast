function onLoad()
  --Player["White"].pingTable(self.getPosition())

  local playmatStationGUID = Global.getVar("playmatStationGUID")
  local characterStationGUID = Global.getVar("characterStationGUID")
  local arenaStationGUID = Global.getVar("arenaStationGUID")

  playmatStation = getObjectFromGUID(playmatStationGUID)
  characterStation = getObjectFromGUID(characterStationGUID)
  arenaStation = getObjectFromGUID(arenaStationGUID)

  local myGUID = self.getGUID()
  waldoCompassGUID = [[373de9]]
  waldoSextantGUID = [[93fabc]]

  decalScale = {
    x = 2.146,
    y = 3.0675,
    z = 1, }
  decalSize = 120
  --decalReferenceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sj2idgS.png]]
  decalReferenceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sP61UtR.png]]
  decalReferencePosition = { x = 0, y = 0.363, z = 0, }

  -- UI elements are fully transparent by default. The "hover image" is actually a tooltip.
  transparencyValue = 0
  if Global.getVar("debugFlag") == true and Global.getVar("debugLevel") >= 2 then
    transparencyValue = 0.5
  end

  if Global.getVar("debugFlag") == true then printToAll("Benchmarking, Character Station loading at: "..os.time()) end

  -- This is an attempt to manually set my own unique identifiers for generated cards without using GUIDs, since those can be rewritten by the engine at any time.
  universalMemoIndex = 0

  -- Deactivating a panel sets panels[ownerGUID].active to false.
  panels = {}
  panels[myGUID] = { active = true, } -- Character Station
  --panels["0e101c"] = { active = false, } -- main select screen
  panels["55bad3"] = { active = false, } -- Season 1 roster panel
  panels["174b13"] = { active = false, } -- Season 2 roster panel
  panels["df4011"] = { active = false, } -- Season 3 roster panel
  panels["e178a2"] = { active = false, } -- Season 4 roster panel
  panels["6bbda6"] = { active = false, } -- Season 5 roster panel
  panels["5ef208"] = { active = false, } -- Season 6 roster panel
  panels["5f4d0d"] = { active = false, } -- Season 7 roster panel

  -- This is just a list of all the player colors.
  allPlayers = { "Red", "Blue", "Yellow", "Green", "Orange", "Purple", "White", "Pink", "Brown", "Teal"}

  -- These global variables store whether or not the relevant color is currently choosing their Normals.
  selectNormals = {
    Red = false,
    Blue = false,
    Orange = false,
    Purple = false,
    Yellow = false,
    Green = false,
    White = false,
    Pink = false,
    Teal = false,
    Brown = false,
    Black = false,
  }

  -- These global variables store whether or not the relevant color is currently in Info Mode.
  infoMode = {
    Red = false,
    Blue = false,
    Orange = false,
    Purple = false,
    Yellow = false,
    Green = false,
    White = false,
    Pink = false,
    Teal = false,
    Brown = false,
    Black = false,
  }

  -- Each player's currently selected Normals.
  currentNormalsTable = {
    Red = "Default (Alternate)",
    Blue = "Default (Alternate)",
    Orange = "Default (Alternate)",
    Purple = "Default (Alternate)",
    Yellow = "Default (Alternate)",
    Green = "Default (Alternate)",
    White = "Default (Alternate)",
    Pink = "Default (Alternate)",
    Teal = "Default (Alternate)",
    Brown = "Default (Alternate)",
    Black = "Default (Alternate)",
  }

  -- By default, players spawn Normals as if they were this character.
  normalsCharacter = {
    Red = [[Waldo (Fan-Made)]],
    Blue = [[Waldo (Fan-Made)]],
    Orange = [[Waldo (Fan-Made)]],
    Purple = [[Waldo (Fan-Made)]],
    Yellow = [[Waldo (Fan-Made)]],
    Green = [[Waldo (Fan-Made)]],
    White = [[Waldo (Fan-Made)]],
    Pink = [[Waldo (Fan-Made)]],
    Teal = [[Waldo (Fan-Made)]],
    Brown = [[Waldo (Fan-Made)]],
    Black = [[Waldo (Fan-Made)]],
  }

  normalsSetLists = {
    UNNormals = {}
  }

--[=[---------------------------------------------------------------------------
  These global variables are used by "onObjectSearchStart", "onObjectSearchEnd", and "onObjectDestroy".
  When a player starts searching an object, the nil value is replaced with that object's GUID.
  When they finish searching it and/or when it's destroyed, the value is cleared.
  If the value is nil when the player clicks a select screen button, that click is ignored.
  The point of this is to prevent clicks from passing through the on-screen search window in TTS,
  since scripted UI elements actually can catch clicks through TTS' built-in UI elements.
--]=]
  activeSearchRed = nil
  activeSearchBlue = nil
  activeSearchYellow = nil
  activeSearchGreen = nil
  activeSearchOrange = nil
  activeSearchPurple = nil
  activeSearchWhite = nil
  activeSearchTeal = nil
  activeSearchPink = nil
  activeSearchBrown = nil

  -- "Disorganized Play" rewards: vanity card backs.
  vanityBacks = {}
  vanityBacks["tirankin"] = {
    Papelne = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6AqbRXf.jpg]],
  }

  -- This global variable causes certain cards to automatically rotate when dropped on a board.
  markerScript = [===[
function onDrop(player_color)
local myRotation = self.getRotation()
local myPosition = self.getPosition()
local newY = myRotation[2]
local modY = 0
local rotate = false
local rotationType = "StarboardLarboard"

if player_color == "Red" or player_color == "Orange" or player_color == "Yellow" then
  modY = 35
elseif player_color == "White" or player_color == "Pink" then
  modY = 35
  rotationType = "ForeAft"
elseif player_color == "Blue" or player_color == "Purple" or player_color == "Green" then
  modY = -35
elseif player_color == "Teal" or player_color == "Brown" then
  modY = -35
  rotationType = "ForeAft"
end
--print("test 1")

if rotationType == "StarboardLarboard" then

  if myRotation[2] < 60 or myRotation[2] > 300 then
    newY = 0
    rotate = true
  elseif myRotation[2] > 120 and myRotation[2] < 240 then
    newY = 180
    rotate = true
  end
  --print("test 2A")

  -- center line
  if myPosition[3] > -3 and myPosition[3] < 3 then
    -- center board
    if myPosition[1] > -17 and myPosition[1] < 17 and ( player_color == "Red" or player_color == "Blue" ) then
      newY = newY+modY
    -- larboard
    elseif myPosition[1] > -87 and myPosition[1] < -53 and ( player_color == "Orange" or player_color == "Purple" ) then
      newY = newY+modY
    -- starboard
    elseif myPosition[1] > 53 and myPosition[1] < 87 and ( player_color == "Yellow" or player_color == "Green" ) then
      newY = newY+modY
    end -- end center / larboard / starboard test
  end -- end center line test

elseif rotationType == "ForeAft" then

  if myRotation[2] > 30 and myRotation[2] < 150 then
    newY = 90
    rotate = true
  elseif myRotation[2] > 210 and myRotation[2] < 330 then
    newY = 270
    rotate = true
  end
  --print("test 2B")

  -- center line
  if myPosition[1] > -3 and myPosition[1] < 3 then
    -- aft
    if myPosition[3] > -87 and myPosition[3] < -53 and ( player_color == "White" or player_color == "Teal" ) then
      newY = newY+modY
    -- fore
    elseif myPosition[3] > 53 and myPosition[3] < 87 and ( player_color == "Pink" or player_color == "Brown" ) then
      newY = newY+modY
    end -- end aft / fore test
  end -- end center line test

end -- end RotationType test
--print("test 3")

if rotate == true then
  self.setRotationSmooth({
      x = myRotation[1],
      y = newY,
      z = myRotation[3],
    }, false)
end
end
]===]

  blankTooltip = [[
............
.          .
.          .
............]]


--[=[---------------------------------------------------------------------------

  When a character is registered:
    - Add the character to the appropriate random select tables (randomSeasons).
    - If the character has referenceChip data, add it to the referenceChipList.
    - If the character has a secret password, record it in passwordsTable.

  Secret passwords structure:
    - passwordsTable contains all registered passwords.
    - Each player has their own entry in playerPasswords (formerly passwordEntries).
    - - Use PlayerInstance.steam_id.
    - When a player clicks a character, its name is appended to that playerPasswords entry.
    - When a player clicks a Random button, that player's playerPasswords entry is checked against each entry in passwordsTable.
    - - If an entry matches, override the character roll with that entry's index.
    - - After checking all entries, clear that player's entry in playerPasswords.

  This does mean that clicking a Random button on a panel actually just runs the Random function on Character Station.
--]=]
  playerPasswords = {}
  passwordsTable = {}

  -- This will contain the random lists (one for each season, plus All, Any and Legal).
  -- Why both All and Any? All isn't actually available to players. It's an internal table.
  randomSeasons = {
    All = {},
    Any = {},
    Legal = {},
  }
  --debugLog{"created randomSeasons", 1}

  -- This table stores the data-owners for registered Normals.
  -- It should also store whether or not they have Toggle UI elements.
  registeredNormals = {}

  -- This table stores the Toggle UI IDs and ownerGUIDs for Normals.
  -- Specifically, the keys for the table entries are: [ownerGUID..toggleID]
  normalsToggleTable = {}
  normalsToggleTable[myGUID.."Normals Toggle: Default"] = { ownerGUID = myGUID, active = true, }

  globalXmlTable = {}
  characterStationXmlTable = {}
  normalsListXmlTable = {}

  row1Z = 31.5
  row2Z = 1.2
  row3Z = -30.62
  column1X = -29.56
  column2X = -32.5
  column3X = -26.62
  column4X = 0
  column5X = 26.62
  column6X = 32.5
  characterStationIconY = -100

  normalsToggleX = -50
  normalsToggleZ = row2Z
  normalsToggleY = -110

  normalsDropdownX = 17.9 -- right from 9.9
  normalsDropdownZ = 0

  --normalsDropdownOffsetX = 0.2 -- right from 0.1, left from 2
  --normalsDropdownOffsetY = 2 -- up from 1, down from 3

  -- This table is traversed in order to determine element draw order (i.e., images with greater indices are drawn on top of those with lesser indices).
  systemElements = {
    {
      id = "Character Station Base",
      image = "CharacterStation",
      active = true,
      height = 100,
      width = 100,
      position = { x = 0, z = 0, y = (characterStationIconY*1.2), }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 1, g = 1, b = 1, a = 1 },
      clickable = "false",
      --onClick = self.getGUID().."/uiClick_SelectNormals",
      --hoverImage = "",
      hoverColor = { r = 1, g = 1, b = 1, a = 0, },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
    {
      id = "Info",
      tooltip = [[Info]],
      active = true,
      height = 24,
      width = 24,
      position = { x = column4X, z = row1Z, y = characterStationIconY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 0, g = 1, b = 1, a = transparencyValue },
      clickable = "true",
      -- TODO: Restore this. onClick = self.getGUID().."/uiClick_Info",
      --hoverImage = "",
      hoverColor = { r = 1, g = 1, b = 1, a = 0, },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
    {
      id = "SpawnNormals",
      tooltip = [[Spawn a set
of Normals]],
      active = true,
      height = 24,
      width = 24,
      position = { x = column2X, z = row1Z, y = characterStationIconY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 0.5, g = 0.5, b = 0.5, a = transparencyValue },
      clickable = "true",
      onClick = self.getGUID().."/uiClick_SpawnNormals",
      --hoverImage = "",
      hoverColor = { r = 1, g = 1, b = 1, a = 0, },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
    {
      id = "SelectBans",
      tooltip = [[Disable
Characters]],
      active = true,
      height = 24,
      width = 24,
      position = { x = column6X, z = row1Z, y = characterStationIconY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 0.5, g = 0.5, b = 0.5, a = transparencyValue },
      clickable = "true",
      --onClick = self.getGUID().."/uiClick_SpawnNormals",
      --hoverImage = "",
      hoverColor = { r = 1, g = 1, b = 1, a = 0, },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
    {
      id = "SelectNormals",
      tooltip = [[Choose your
active Normals]],
      active = true,
      height = 24,
      width = 24,
      position = { x = column1X, z = row2Z, y = characterStationIconY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 1, g = 1, b = 1, a = transparencyValue },
      clickable = "true",
      onClick = self.getGUID().."/uiClick_SelectNormals",
      --hoverImage = "",
      hoverColor = { r = 1, g = 1, b = 1, a = 0, },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
    {
      id = "RandomLegal",
      tooltip = [[Random
Legal]],
      active = true,
      height = 24,
      width = 24,
      position = { x = column3X, z = row3Z, y = characterStationIconY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 0, g = 0, b = 1, a = transparencyValue },
      clickable = "true",
      onClick = myGUID.."/uiClick_Random",
      hoverTooltip = blankTooltip,
      --[[ 2023-08-19: Disabling hover images to attempt to improve load times.
      hoverImage = "RandomLegal",
      --]]
      hoverColor = { r = 1, g = 1, b = 1, a = 1 },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
    {
      id = "RandomAny",
      tooltip = [[Random
Any]],
      active = true,
      height = 24,
      width = 24,
      position = { x = column4X, z = row3Z, y = characterStationIconY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 0, g = 1, b = 0, a = transparencyValue },
      clickable = "true",
      onClick = myGUID.."/uiClick_Random",
      hoverTooltip = blankTooltip,
      --[[ 2023-08-19: Disabling hover images to attempt to improve load times.
      hoverImage = "RandomAny",
      --]]
      hoverColor = { r = 1, g = 1, b = 1, a = 1, },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
    {
      id = "Random0",
      tooltip = [[Random Boss
(Here be monsters)]],
      active = true,
      height = 24,
      width = 24,
      position = { x = column5X, z = row3Z, y = characterStationIconY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 1, g = 0, b = 0, a = transparencyValue },
      clickable = "true",
      onClick = myGUID.."/uiClick_Random",
      hoverTooltip = blankTooltip,
      --[[ 2023-08-19: Disabling hover images to attempt to improve load times.
      hoverImage = "RandomS0",
      --]]
      hoverColor = { r = 1, g = 1, b = 1, a = 1, },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
  }

  if Global.getVar("debugFlag") == true then printToAll("Benchmarking, Character Station, looping through players at: "..os.time()) end

  -- Loop through players to perform various individual setup tasks.
  playerDropdownIndexList = {
    Red = nil,
    Blue = nil,
    Yellow = nil,
    Green = nil,
    Orange = nil,
    Purple = nil,
    White = nil,
    Teal = nil,
    Pink = nil,
    Brown = nil,
  }
  for i,thisPlayer in ipairs(allPlayers) do

    local highlightColor = {
      r = Color[thisPlayer][1],
      g = Color[thisPlayer][2],
      b = Color[thisPlayer][3],
      a = 0.5,}

    -- The "highlight" elements need to be drawn under the other elements, so we insert them at position 1.

    table.insert(systemElements, 1, {
      id = "SelectNormalsHighlight"..thisPlayer,
      active = false,
      height = 23,
      width = 23,
      position = { x = column1X, z = row2Z, y = (characterStationIconY*1.3), }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = highlightColor,
      --clickable = "false",
      --onClick = self.getGUID().."/uiClick_SelectNormals",
      --hoverImage = "",
      hoverColor = { r = 1, g = 1, b = 1, a = 0, },
      visibilityString = thisPlayer,
    })
    table.insert(systemElements, 1, {
      id = "InfoModeHighlight"..thisPlayer,
      active = false,
      height = 23,
      width = 23,
      position = { x = column4X, z = row1Z, y = (characterStationIconY*1.3), }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = highlightColor,
      --clickable = "false",
      --onClick = self.getGUID().."/uiClick_SelectNormals",
      --hoverImage = "",
      hoverColor = { r = 1, g = 1, b = 1, a = 0, },
      visibilityString = thisPlayer,
    })

    local selectNormalsModeText = [[Click a character to use their Normals
(right-click to use reskins when available).]]

    table.insert(globalXmlTable, { -- Panel element
      tag = "Panel",
        attributes = {
          id = "SelectNormalsModeIndicator"..thisPlayer,
          active = false,
          visibility = thisPlayer,
        }, -- end attributes for Panel
        children = {
          {-- Image element.
            tag = "Text",
            attributes = {
              id = "SelectNormalsModeTextShadowDR"..thisPlayer,
              text = selectNormalsModeText,
              --active = false,
              fontSize = 28,
              position = "2 -352 0", -- x z -y
              color = [[rgba(0,0,0,1)]],
            }, -- end attributes for Image
          }, -- end Image element
          {-- Image element.
            tag = "Text",
            attributes = {
              id = "SelectNormalsModeTextShadowUR"..thisPlayer,
              text = selectNormalsModeText,
              --active = false,
              fontSize = 28,
              position = "2 -348 0", -- x z -y
              color = [[rgba(0,0,0,1)]],
            }, -- end attributes for Image
          }, -- end Image element
          {-- Image element.
            tag = "Text",
            attributes = {
              id = "SelectNormalsModeTextShadowUL"..thisPlayer,
              text = selectNormalsModeText,
              --active = false,
              fontSize = 28,
              position = "-2 -348 0", -- x z -y
              color = [[rgba(0,0,0,1)]],
            }, -- end attributes for Image
          }, -- end Image element
          {-- Image element.
            tag = "Text",
            attributes = {
              id = "SelectNormalsModeTextShadowDL"..thisPlayer,
              text = selectNormalsModeText,
              --active = false,
              fontSize = 28,
              position = "-2 -352 0", -- x z -y
              color = [[rgba(0,0,0,1)]],
            }, -- end attributes for Image
          }, -- end Image element
          {-- Image element.
            tag = "Text",
            attributes = {
              id = "SelectNormalsModeText"..thisPlayer,
              text = selectNormalsModeText,
              --active = false,
              fontSize = 28,
              position = "0 -350 0", -- x z -y
              color = [[White]],
            }, -- end attributes for Image
          }, -- end Image element
        }, -- end children for Panel
    })

    local infoModeTextPositionX = 0
    local infoModeTextPositionZ = 300
    local infoModeText = [[Click stuff for info! Right-click for different info!
Click the Info button again to disable.]]

    table.insert(globalXmlTable, { -- Panel element
      tag = "Panel",
        attributes = {
          id = "InfoModeModeIndicator"..thisPlayer,
          active = false,
          visibility = thisPlayer,
        }, -- end attributes for Panel
        children = {
          {-- Image element.
            tag = "Text",
            attributes = {
              id = "InfoModeModeTextShadowDR"..thisPlayer,
              text = infoModeText,
              --active = false,
              fontSize = 20,
              position = (infoModeTextPositionX+2).." "..(infoModeTextPositionZ-2).." 0", -- x z -y
              color = [[rgba(0,0,0,0.7)]],
            }, -- end attributes for Image
          }, -- end Image element
          {-- Image element.
            tag = "Text",
            attributes = {
              id = "InfoModeModeTextShadowDL"..thisPlayer,
              text = infoModeText,
              --active = false,
              fontSize = 20,
              position = (infoModeTextPositionX-2).." "..(infoModeTextPositionZ-2).." 0", -- x z -y
              color = [[rgba(0,0,0,0.7)]],
            }, -- end attributes for Image
          }, -- end Image element
          {-- Image element.
            tag = "Text",
            attributes = {
              id = "InfoModeModeTextShadowUR"..thisPlayer,
              text = infoModeText,
              --active = false,
              fontSize = 20,
              position = (infoModeTextPositionX+2).." "..(infoModeTextPositionZ+2).." 0", -- x z -y
              color = [[rgba(0,0,0,0.7)]],
            }, -- end attributes for Image
          }, -- end Image element
          {-- Image element.
            tag = "Text",
            attributes = {
              id = "InfoModeModeTextShadowUL"..thisPlayer,
              text = infoModeText,
              --active = false,
              fontSize = 20,
              position = (infoModeTextPositionX-2).." "..(infoModeTextPositionZ+2).." 0", -- x z -y
              color = [[rgba(0,0,0,0.7)]],
            }, -- end attributes for Image
          }, -- end Image element
          {-- Image element.
            tag = "Text",
            attributes = {
              id = "InfoModeModeText"..thisPlayer,
              text = infoModeText,
              --active = false,
              fontSize = 20,
              position = infoModeTextPositionX.." "..infoModeTextPositionZ.." 0", -- x z -y
              color = [[rgba(1,1,1,1)]],
            }, -- end attributes for Image
          }, -- end Image element
        }, -- end children for Panel
    })

    -- Each set of "diverse" Normals, plus Default, has a Toggle UI element.
    -- Whenever Normals are set from one of those, it is updated accordingly.
    -- Every single set of Normals has a Dropdown element.
    normalsListXmlTable = {
      { tag = "Option", value = "Default", },
      { tag = "Option", value = "Default (Alternate)", attributes = { selected = "true", }, },
    }
    --[=[ This should be made redundant by looping through the Normals in the setup loop.
    for thisNormalsSet,normalsTable in pairsByKeys(normalsSheets) do
      table.insert(normalsListXmlTable, {-- Dropdown child.
        tag = "Option", value = thisNormalsSet,
        -- attributes = { id = "NormalsDropdownChild"..thisPlayer..thisNormalsSet, } -- This was a nice idea, but child elements don't seem to accept IDs.
      })
    end -- finish looping through all Normals for all players
    --]=]

    playerDropdownIndexList[thisPlayer] = (#characterStationXmlTable + 1)
    table.insert(characterStationXmlTable,{ -- Panel containing Dropdown to work around the visibility bug.
    tag = "Panel",
      attributes = {
        id = "NormalsDropdownPanel"..thisPlayer,
        visibility = thisPlayer,
      },
      children = {
        {-- Dropdown element.
          tag = "Dropdown",
          children = normalsListXmlTable,
          attributes = {
            id = "NormalsDropdownItem"..thisPlayer,
            --scale = "0.5 0.5 0.5",
            height = 40,
            width = 200,
            scale = "0.3 0.3 0.3",
            position = normalsDropdownX.." "..normalsDropdownZ.." "..characterStationIconY,
            --offsetXY = normalsDropdownOffsetX..normalsDropdownOffsetY,
            onValueChanged = myGUID.."/uiDropdown_ChooseNormals",
            textColor = "#000000",
            --backgroundColors = "#FF0000|#00FF00|#0000FF|#666666",
            itemBackgroundColors = "#000000|#000000|#000000|#000000",
            dropdownBackgroundColor = "#555555",
            itemTextColor = "#FFFFFF", -- text of items in the dropdown list
            checkColor = "#FFFFFF",
            --arrowColor = "#FFFFFF",
            --dropdownBackgroundColor = "#000000",
            --scrollbarColors = "#999999|#999999|#999999|#999999",
          }, -- end attributes for Dropdown
      } -- end Dropdown element
    } -- end Panel children
  }) -- end Panel
  end -- finish looping through players

  if Global.getVar("debugFlag") == true then printToAll("Benchmarking, Character Station, writing Global UI at: "..os.time()) end

  -- Write the Global UI.
  Global.UI.setXmlTable(globalXmlTable)

  -- TODO: Probably have the Character Station loop through all characters for the referenceChips.
  --[===[
  referenceChipList = {}
  referenceChipStates = {}

  for charName,thisChar in pairs(charTable) do
    debugLog{ "per-char loop: "..charName, 2, {1,1,1} }

    -- If the character has referenceChip data, add it to referenceChipList.
    if thisChar.referenceChip != nil then
      --debugLog{ "   referenceChip!", 3}
      referenceChipList[charName] = thisChar.referenceChip
      if charName == [[Tinker Knight]] then
        referenceChipList["Tinker Knight (Exceed)"] = { Name = "Custom_Tile",
          Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
          Nickname = "Tinker Knight (Exceed)",
          Description = [[S4, Difficulty 4 (Advanced)]],
          CustomImage = {
            ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OYJVUwl.jpg]],
            ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8lPTWmb.jpg]],
            CustomTile = { Thickness = 0.1, Stretch = true, }
          }
        }
      end
    end -- end 'if thisChar.referenceChip != nil'
    --debugLog{"finished reference chips", 1}

  end -- Finish looping through charTable.

  -- Dumb joke I want to keep.
  referenceChipStates[33] = referenceChipList["Super Skull Man 33"]

  -- Order the referenceChipList alphabetically, then loop through it to add each referenceChip as a State to the reference tile objects.
  for charEntryKey,thisChip in pairsByKeys(referenceChipList) do
    thisChip.LuaScript = [==[
function onStateChange(old_state_guid)
self.setTags({
  "ReferenceChip"
})
end
]==]
    if charEntryKey != [[Super Skull Man 33]] then
      table.insert(referenceChipStates, thisChip)
    end
  end

  --debugLog{ "attempting to spawn referenceChips"}
  -- [=[
  referenceChipData = {
    Name = "Custom_Tile",
    Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
    Nickname = [[Reference Card (Hover for Info)]],
    Description = [[Currently displaying Normal Attacks.
For a character reference:
Right-click > States > Select Character]],
    Tags = {
      "ReferenceChip"
    },
    Tooltip = true,
    HideWhenFaceDown = false,
    Hands = false,
    CustomImage = {
      ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EqUoAFw.jpg]],
      ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
      ImageScalar = 1.0,
      WidthScale = 0.0,
      CustomTile = { Thickness = 0.1, Stretch = true }
    },
    States = referenceChipStates
  }

  -- If there are no reference tile objects, regenerate all of them.
  local existingReferenceChips = getObjectsWithTag([[ReferenceChip]])
  if #existingReferenceChips == 0 then
    debugLog{" creating reference tiles", 2}
    -- This isn't an ideal solution, but we're moving in a particular direction...
    spawnObjectData({ data = referenceChipData,
      position = { x = -21.5, y = 0.96, z = -6.5 },
      rotation = { x = 0, y = 180, z = 0} })
    spawnObjectData({ data = referenceChipData,
      position = { x = -21.5, y = 0.96, z = 6.5 },
      rotation = { x = 0, y = 0, z = 0} })
    spawnObjectData({ data = referenceChipData,
      position = { x = -92.5, y = 0.96, z = -6.5 },
      rotation = { x = 0, y = 180, z = 0} })
    spawnObjectData({ data = referenceChipData,
      position = { x = -92.5, y = 0.96, z = 6.5 },
      rotation = { x = 0, y = 0, z = 0} })
    spawnObjectData({ data = referenceChipData,
      position = { x = 92.5, y = 0.96, z = -6.5 },
      rotation = { x = 0, y = 180, z = 0} })
    spawnObjectData({ data = referenceChipData,
      position = { x = 92.5, y = 0.96, z = 6.5 },
      rotation = { x = 0, y = 0, z = 0} })
    spawnObjectData({ data = referenceChipData,
      position = { x = -6.5, y = 0.96, z = 92.5 },
      rotation = { x = 0, y = 270, z = 0} })
    spawnObjectData({ data = referenceChipData,
      position = { x = 6.5, y = 0.96, z = 92.5 },
      rotation = { x = 0, y = 90, z = 0} })
    spawnObjectData({ data = referenceChipData,
      position = { x = -6.5, y = 0.96, z = -92.5 },
      rotation = { x = 0, y = 270, z = 0} })
    spawnObjectData({ data = referenceChipData,
      position = { x = 6.5, y = 0.96, z = -92.5 },
      rotation = { x = 0, y = 90, z = 0} })
  else
    debugLog{" no references needed", 2}
  end
  --]===]
  --debugLog{"finished reference chips", 1}

  for thisPanelGUID,thisPanelTable in pairs(panels) do
    local thisPanel = getObjectFromGUID(thisPanelGUID)
    if thisPanel != nil then
      debugLog{"calling setup for panel: "..thisPanelGUID, 3, {0,1,1}}
      thisPanelTable.active = true
      thisPanel.call("setup") -- Daisy chain this?
      for i,thisPlayer in ipairs(allPlayers) do
        characterStationXmlTable = updateNormalsDropdown({
          playerColor     = thisPlayer,     -- string; required
          currentXml      = characterStationXmlTable,      -- table; defaults to self.UI.getXmlTable()
          updateXml       = false,       -- boolean; defaults to false
        })
      end -- end 'for i,thisPlayer in ...'
    end -- end 'if thisPanel != nil'
  end -- end 'for i,thisPanelGUID in ipairs(panels)'

  if Global.getVar("debugFlag") == true then printToAll("Benchmarking, Character Station, writing self UI at: "..os.time()) end

  self.UI.setXmlTable(characterStationXmlTable)

  finishedSetup = true

  if Global.getVar("debugFlag") == true then printToAll("Benchmarking, Character Station, finished onLoad at: "..os.time()) end

end -- end onLoad



-- A bunch of the setup functionality is broken out to mirror the Roster panel code structure.
function setup()

  -- Apparently, using a local variable to store a common function call improves performance.
  -- This is because global variables require a table lookup.
  local debugLog = debugLog
  local myGUID = self.getGUID()

  --[=[---------------------------------------------------------------------------
  normalsSheets keys are names of Normal sets.
  The sets that are currently recognized are "Normals", "UNNormals", and
  The suffix " (Alternate)" is used to denote an alter with the same style.
  The numeric values in the normalsSheets entries are the card IDs for the respectively-named cards.
  A card ID indicates exactly where on an image grid the card is located.
  00 means the top-left grid location.
  01 means the grid location to the right of 00.
  So, for example, a 4x2 grid will have the following card IDs:
    00 01 02 03
    04 05 06 07
  --]=]

  normalsSheets = {}
  normalsSheets["Default"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1pnJnEb.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    }, --[[ end deck ]]
    UNNormals = { suffix = [[ (UN)(N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/c3GN98a.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    }, --[[ end deck ]]
    GGSTNormals = { suffix = [[ (GGST)(N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/N6uVAKz.jpg",
      Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Default (Alternate)"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jWGO1lx.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    }, --[[ end deck ]]
    UNNormals = { suffix = [[ (UN)(N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://i.imgur.com/c3GN98a.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    }, --[[ end deck ]]
    GGSTNormals = { suffix = [[ (GGST)(N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://i.imgur.com/N6uVAKz.jpg",
      Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]

  -- Fan-made Normals.
  normalsSheets["cpat"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/y4HGW1w.jpg",
      Grasp = "07", Cross = "06", Assault = "05", Dive = "04", Spike = "03", Sweep = "02", Focus = "01", Block = "00",
    }, --[[ end deck ]]
    UNNormals = { suffix = [[ (UN)(N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MtVksqg.jpg",
      Grasp = "07", Cross = "06", Assault = "05", Dive = "04", Spike = "03", Sweep = "02", Focus = "01", Block = "00",
    }, --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Cursed"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 3, gridHeight = 3, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Pbf8wji.png",
      Grasp = "07", Cross = "06", Assault = "05", Dive = "04", Spike = "03", Sweep = "02", Focus = "01", Block = "00",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["DooM"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 4, faceURL = "https://i.imgur.com/xtJE8Vg.png",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Esper Noir"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MeT3502.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Final Fantasy"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LsOgd2S.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["GBA"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://i.imgur.com/opP0lFg.png",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Hollow Knight"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aHLUa1W.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Magic: The Gathering"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kOhOHEv.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Mega Man"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://i.imgur.com/LJ7UWuC.png",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["MissingNo."] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9csfxDP.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Rugal"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 3, gridHeight = 3, faceURL = "https://i.imgur.com/kTKtLO9.png",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Zangetsu"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 4, faceURL = "https://steamusercontent-a.akamaihd.net/ugc/1710779516255573111/3902E9A8656948FD1E6180A7D85B123C2794F46A/",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]

  --[=[---------------------------------------------------------------------------
  charTable entry template:
  charTable["CHARACTERNAME"] = {
  season = "5", -- string, expects one of: "1", "2", "3", "4", "5", "6".
  legal = false, -- optional
  secret = false, -- optional
  assetName = "NinethePhantom",
  excludeFromRandomAny = true, -- if true, omit from "Random Any"
  attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Yr2fNEk.jpg]],
  charCard = "Nine the Phantom (C)",
  deck = {
    { deckID = "2", faceURL = "https://i.imgur.com/Yr2fNEk.jpg",
      backURL = "https://i.imgur.com/Yr2fNEk.jpg",
      gridWidth = 5, gridHeight = 2,
      hiddenBack = true,
      cardList = { { cardID = "00",
          cardNickname = "Lapis Lazuli of Lamentation ;7 (S)", copies = 1, reference = true, },
        { cardID = "01",
          cardNickname = "Emerald of Enmity ;6 (S)", copies = 1, reference = true, },
        { cardID = "02",
          cardNickname = "Morganite of Malice ;5 (S)", copies = 1, reference = true, },
        { cardID = "03",
          cardNickname = "Coral of Catastrophe ;4 (S)", copies = 1, reference = true, },
        { cardID = "04",
          cardNickname = "Kunzite of Keep Breaker ;3 (S)", copies = 1, reference = false, separate = true, },
        { cardID = "05",
          cardNickname = "Amethyst of Annihilation ;2 (S)", copies = 1, reference = false, separate = true, },
        { cardID = "06",
          cardNickname = "Navy Pressure ;1 (S)", copies = 1, reference = false, separate = true, },
        { cardID = "07",
          cardNickname = "Azurite Inferno ;8 (U)", copies = 1, reference = false, separate = true, },
        { cardID = "08",
          cardNickname = "Flame Punisher ;0 (U)", copies = 1, reference = false, separate = true, },
        { cardID = "09",
          cardNickname = "Colorless Void ;9 (U)",
          copies = 1,
          reference = true,
          separate = true,
        },
        }, -- end cardList
      }, -- end subdeck 2
    { deckID = "4",
      faceURL = "https://i.imgur.com/Yr2fNEk.jpg",
      backURL = "https://i.imgur.com/Yr2fNEk.jpg",
      gridWidth = 1, gridHeight = 1,
      hiddenBack = false,
      cardList = {
        { cardID = "00",
          cardNickname = "Season Mechanics Reference (C)",
          cardDescription = "BlazBlue",
          copies = 1,
          reference = false,
          separate = true, },
        }, -- end cardList
      }, -- end subdeck
    { deckID = "3",
      faceURL = "https://i.imgur.com/Yr2fNEk.jpg",
      backURL = "https://i.imgur.com/Yr2fNEk.jpg",
      gridWidth = 1, gridHeight = 1,
      hiddenBack = false,
      cardList = { { cardID = "00",
          cardNickname = "Nine the Phantom (C)",
          copies = 1,
          reference = false,
          cardScript = [[function onLoad()\r\nprint(\"This is a card.\")\r\nend]],
        },
        }, -- end cardList
      }, -- end subdeck
  },
  normals = [[normalsSheets key]],
  position = { z = -4.29000091552734, y = 0.6, x = 12.3900003433228},
  }
  --]=]

  --[=[---------------------------------------------------------------------------
      For custom Normals, add a "normalsList" member item to the appropriate charTable entry in the following format:
        normalsList = {
          [[Grasp]], [[Grasp]],
          [[Cross]], [[Cross]],
          [[Assault]], [[Assault]],
          [[Dive]], [[Dive]],
          [[Spike]], [[Spike]],
          [[Sweep]], [[Sweep]],
          [[Focus]], [[Focus]],
          [[Block]], [[Block]],
          },
      Note that this uses the actual CARD NAME, on the assumption that all normalSheets entries will have entries for every named Normal.
      You can also specify a decklist in the standard format by adding a "normalsDeck" member item, e.g.:
        normalsDeck = { deckID = [[2]], faceURL = [[SOMEURLHERE]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Grasp ;7 (N)]], copies = 1, reference = true, },
            { cardID = [[00]],
                cardNickname = [[Grasp ;7 (N)]], copies = 1, reference = false, },
            { cardID = [[01]],
              cardNickname = [[Cross ;6 (N)]], copies = 2, reference = true, },
            { cardID = [[02]],
              cardNickname = [[Assault ;5 (N)]], copies = 2, reference = true, },
            { cardID = [[03]],
              cardNickname = [[Spike ;4 (N)]], copies = 2, reference = true, },
            { cardID = [[04]],
              cardNickname = [[Focus ;1 (N)]], copies = 2, reference = true, },
            { cardID = [[05]],
              cardNickname = [[Dive ;4 (N)]], copies = 2, reference = true, },
            { cardID = [[06]],
              cardNickname = [[Sweep ;2 (N)]], copies = 2, reference = true, },
            }, -- end cardList
          }
      Normals do not currently support the "separate" member item ("separate = true" or "separate = false").
  --]=]


  --[=[ Format for costumes:
  costumes = {
    { -- costume begins
      costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
      costumeName = "COSTUMENAME",
      costumeDescription = [[CHARACTERNAME © Nintendo.
  Thanks to Moriatti for assisting with implementation!]],
      costumeNormals = [[COSTUMENORMALS]], -- Optional: Normals style
      costumeAttackBack = [[COSTUMEATTACKBACK]], -- Optional: card back for attacks
      costumeOwner = { [[tirankin]], [[Jungy]], }, -- Optional: the costume is only accessible for players in this table.
      costumeFavorite = { [[tirankin]], }, -- Optional: the costume is prioritized for players in this table (but available regardless).
      costumePassword = [[Seijun]], -- Optional: the costume is only accessible based on this password. The last character in the password must always be the costume's base character.
      costumePasswordFavorite = [[Renea | Seijun]], -- Optional: the costume is prioritized based on this password (but available regardless). The last character in the password must always be the costume's base character.
      costumeDeck = { This table should be a copy of the base character's entire deck, with changes made as desired. }, -- end deck
      }, -- costume ends
    }, -- end costume list --]=]

    charTable = {}

  local sansAttackScript = [=====[function onLoad()
    sansPants = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NuG9t5m.png]]
    if self.getName() == [[Twinkle ;7 (S)]] then
      sansFaces = { [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZBcXr5e.png]] } -- attack face glint gold
      sansBodies = {
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HS2AtzF.png]], -- torso neutral
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dT5OtzY.png]], -- torso shrug
          legs = sansPants, },
        }
      sansIcons = {
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qbXN9xW.png]], -- winking icon
        [[]], [[]], [[]], [[]], -- empty (x4)
      }
    elseif self.getName() == [[Double Cross ;6 (S)]] then
      sansFaces = {
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IAzeV8B.png]], -- attack face side wink
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RsZ8tp6.png]], -- attack face side smile
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vGSUKmX.png]], -- attack face side neutral
      }
      sansBodies = {
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/S5rPNT7.png]], -- left 2
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WZem7h1.png]], -- left 3
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KxbrdzY.png]], -- left 4
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/j25cPdM.png]], -- left 5
          legs = sansPants, },
      }
      sansIcons = {
        [[https://i.imgur.com/qbXN9xW.png]], -- winking icon
        [[]], [[]], [[]], [[]], -- empty (x4)
      }
    elseif self.getName() == [[* don't come back. ;5 (S)]] then
      sansFaces = {
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XIO83KG.png]], -- attack face wink
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GNeJv6y.png]], -- attack face smile
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Khydg0y.png]], -- attack face neutral
      }
      sansBodies = {
        { body = [[https://i.imgur.com/HS2AtzF.png]], -- torso neutral
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OYhxJHn.png]], -- up 3
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Z8QaC1Y.png]], -- up 4 / down 2
          legs = sansPants, },
      }
      sansIcons = {
        [[https://i.imgur.com/qbXN9xW.png]], -- winking icon
        [[]], [[]], [[]], [[]], -- empty (x4)
      }
    elseif self.getName() == [[Weight of Sin ;4 (S)]] then
    sansFaces = {
        [[https://i.imgur.com/XIO83KG.png]], -- attack face wink
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iaQEUNs.png]], -- attack face worried
        [[https://i.imgur.com/Khydg0y.png]], -- attack face neutral
      }
      sansBodies = {
        { body = [[https://i.imgur.com/Z8QaC1Y.png]], -- up 4 / down 2
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/BKNoWPt.png]], -- up 5 / down 1
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EJKFzOg.png]], -- down 3
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uHZjiqu.png]], -- down 4
          legs = sansPants, },
      }
      sansIcons = {
        [[https://i.imgur.com/qbXN9xW.png]], -- winking icon
        [[]], [[]], [[]], [[]], -- empty (x4)
      }
    elseif self.getName() == [[Betrayal ;1 (S)]] then
      sansFaces = {
        [[https://i.imgur.com/iaQEUNs.png]], -- attack face worried
        [[https://i.imgur.com/Khydg0y.png]], -- attack face neutral
        [[https://i.imgur.com/Khydg0y.png]], -- attack face neutral (2)
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/npDoCyu.png]], -- attack face empty eyes
        [[https://i.imgur.com/npDoCyu.png]], -- attack face empty eyes (2)
      }
      sansBodies = {
        { body = [[https://i.imgur.com/HS2AtzF.png]], -- torso neutral
          legs = sansPants, },
        { body = [[https://i.imgur.com/HS2AtzF.png]], -- torso neutral (2)
          legs = sansPants, },
        { body = [[https://i.imgur.com/HS2AtzF.png]], -- torso neutral (3)
          legs = sansPants, },
        { body = [[https://i.imgur.com/dT5OtzY.png]], -- torso shrug
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Vu1A6SI.png]], -- torso flex
          legs = sansPants, },
        { body = [[https://i.imgur.com/Vu1A6SI.png]], -- torso flex (2)
          legs = sansPants, },
      }
      sansIcons = {
        [[https://i.imgur.com/qbXN9xW.png]], -- winking icon
        [[]], [[]], [[]], [[]], -- empty (x4)
      }
    elseif self.getName() == [[BURN IN HELL. ;4 (U)]] then
      sansFaces = { [[https://i.imgur.com/npDoCyu.png]], } -- attack face empty eyes
      sansBodies = {
        { body = [[https://i.imgur.com/HS2AtzF.png]], -- torso neutral
          legs = sansPants, },
        { body = [[https://i.imgur.com/HS2AtzF.png]], -- torso neutral (2)
          legs = sansPants, },
        { body = [[https://i.imgur.com/HS2AtzF.png]], -- torso neutral (3)
          legs = sansPants, },
        { body = [[https://i.imgur.com/HS2AtzF.png]], -- torso neutral (4)
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9xjerMN.png]], -- torso shrug bloody both
          legs = sansPants, },
        { body = [[https://i.imgur.com/9xjerMN.png]], -- torso shrug bloody both (2)
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4y7bIp6.png]], -- torso shrug bloody left
          legs = sansPants, },
        { body = [[https://i.imgur.com/4y7bIp6.png]], -- torso shrug bloody left (2)
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qctUjtd.png]], -- torso shrug bloody right
          legs = sansPants, },
      }
      sansIcons = {
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1gFjbTA.png]], -- icon glint (blue)
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TReex4q.png]], -- icon glint (gold)
        [[]], [[]], [[]], [[]], -- empty (4)
      }
    elseif self.getName() == [[MERCY ;6 (U)]] then
      sansFaces = {
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JOvtRAW.png]], -- attack face glint blue
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uEn3HUr.png]], -- attack face closed eyes
        [[https://i.imgur.com/XIO83KG.png]], -- attack face wink
        [[https://i.imgur.com/GNeJv6y.png]], -- attack face smile
        [[https://i.imgur.com/GNeJv6y.png]], -- attack face smile (2)
        [[https://i.imgur.com/Khydg0y.png]], -- attack face neutral
        [[https://i.imgur.com/Khydg0y.png]], -- attack face neutral (2)
      }
      sansBodies = {
        { body = [[https://i.imgur.com/HS2AtzF.png]], -- torso neutral
          legs = sansPants, },
        { body = [[https://i.imgur.com/HS2AtzF.png]], -- torso neutral (2)
          legs = sansPants, },
        { body = [[https://i.imgur.com/HS2AtzF.png]], -- torso neutral (3)
          legs = sansPants, },
        { body = [[https://i.imgur.com/dT5OtzY.png]], -- torso shrug
          legs = sansPants, },
        { body = [[https://i.imgur.com/dT5OtzY.png]], -- torso shrug (2)
          legs = sansPants, },
        { body = [[https://i.imgur.com/S5rPNT7.png]], -- left 2
          legs = sansPants, },
        { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nzyP2lM.png]], -- up 1
          legs = sansPants, },
      }
      sansIcons = {
        [[https://i.imgur.com/1gFjbTA.png]], -- icon glint (blue)
        [[https://i.imgur.com/TReex4q.png]], -- icon glint (gold)
        [[]], [[]], -- empty (2)
      }
    end

    activeDecals = {}

    -- Chance of dog.
    if (math.random(1, 1000) / 1000) <= (1/100) then
      resetCard()
      dogAttackDelusions()
    else
      resetCard()
    end
  end

  function resetCard()
    local thisCardFaces = sansFaces
    local thisCardBodies = sansBodies
    local thisCardIcons = sansIcons

    local decalPosition = { x = 0, y = 0.4, z = 0, }
    local decalRotation = { x = 90, y = 180, z = 0, }
    local decalScale = { x = ]=====]..decalScale.x..[=====[, y = ]=====]..decalScale.y..[=====[, z = ]=====]..decalScale.z..[=====[, }
    local decalSize = ]=====]..decalSize..[=====[

    -- If the GMNotes for this card end in '.reference', it's a reference card.
    if string.match(self.getGMNotes(), '.*%.reference$') then
      table.insert(activeDecals, {
        position = { x = decalPosition.x, y = ]=====]..decalReferencePosition.y..[=====[, z = decalPosition.z, },
        rotation = decalRotation,
        scale = decalScale,
        size = decalSize,
        name = [[referenceDecal]],
        url = [[]=====]..decalReferenceURL..[=====[]],
      })
    end

    -- Randomize the face decal.
    local count = 0
    for i in ipairs(thisCardFaces) do count = count+1 end
    local faceDecal = thisCardFaces[math.random(1, count)]

    -- Randomize the body and legs decals. (They're associated with each other.)
    count = 0
    for i in ipairs(thisCardBodies) do count = count+1 end
    local bodyDecal = thisCardBodies[math.random(1, count)]

    -- Randomize the icon decal.
    count = 0
    for i in ipairs(thisCardIcons) do count = count+1 end
    local iconDecal = thisCardIcons[math.random(1, count)]

    -- If there's a face decal, add it to the list.
    if faceDecal != nil and faceDecal != [[]] then
      table.insert(activeDecals, {
        position = { x = decalPosition.x, y = 0.33, z = decalPosition.z, },
        rotation = decalRotation,
        scale = decalScale,
        size = decalSize,
        name = [[attackface]],
        url = faceDecal,
      })
    end

    -- If there's a body decal, add it to the active decal set.
    if bodyDecal.body != nil and bodyDecal.body != [[]] then
      table.insert(activeDecals, {
        position = { x = decalPosition.x, y = 0.31, z = decalPosition.z, },
        rotation = decalRotation,
        scale = decalScale,
        size = decalSize,
        name = [[attackbody]],
        url = bodyDecal.body,
      })
    end

    -- If there's a legs decal, add it to the active decal set.
    if bodyDecal.legs != nil and bodyDecal.legs != [[]] then
      table.insert(activeDecals, {
        position = { x = decalPosition.x, y = 0.32, z = decalPosition.z, },
        rotation = decalRotation,
        scale = decalScale,
        size = decalSize,
        name = [[attacklegs]],
        url = bodyDecal.legs,
      })
    end

    -- If there's an icon decal, add it to the active decal set.
    if iconDecal != nil and iconDecal != [[]] then
      table.insert(activeDecals, {
        position = { x = decalPosition.x, y = 0.325, z = decalPosition.z, },
        rotation = decalRotation,
        scale = decalScale,
        size = decalSize,
        name = [[attackicon]],
        url = iconDecal,
      })
    end

    -- Apply the decals.
    self.setDecals(activeDecals)
  end -- end resetCard()

  function dogAttackDelusions()
    Wait.frames(function ()
      -- decals holds the decals we are about to apply.
      local decals = {}

      -- Filling these in to save typing and readability later.
      local referenceDecal = {
        position = { x = 0, y = 0.37, z = 0, },
        rotation = { x = 90, y = 180, z = 0, },
        scale = { x = ]=====]..decalScale.x..[=====[, y = ]=====]..decalScale.y..[=====[, z = ]=====]..decalScale.z..[=====[, },
        size = ]=====]..decalSize..[=====[,
        name = [[referenceDecal]],
        url = [[]=====]..decalReferenceURL..[=====[]],
      }
      local dogDecal1 = {
        position = { x = 0, y = 0.37, z = 0, },
        rotation = { x = 90, y = 180, z = 0, },
        scale = { x = ]=====]..decalScale.x..[=====[, y = ]=====]..decalScale.y..[=====[, z = ]=====]..decalScale.z..[=====[, },
        size = ]=====]..decalSize..[=====[,
        name = [[attackdog1]],
        url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LgCp6Bt.png]],
      }
      local dogDecal2 = {
        position = { x = 0, y = 0.37, z = 0, },
        rotation = { x = 90, y = 180, z = 0, },
        scale = { x = ]=====]..decalScale.x..[=====[, y = ]=====]..decalScale.y..[=====[, z = ]=====]..decalScale.z..[=====[, },
        size = ]=====]..decalSize..[=====[,
        name = [[attackdog2]],
        url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qO0bWVt.png]],
      }

      local carryingTooManyDogs = false

      -- Add all the same details, but update any relevant dogs.
      for i,thisDecal in pairs(activeDecals) do

        -- If the decal shows dog frame 1...
        if thisDecal.url == [[https://i.imgur.com/LgCp6Bt.png]] then

          -- ...update it to show dog frame 2.
          thisDecal.name = [[attackdog2]]
          thisDecal.url = [[https://i.imgur.com/qO0bWVt.png]]
          carryingTooManyDogs = true

        --If the decal shows dog frame 2...
        elseif thisDecal.url == [[https://i.imgur.com/qO0bWVt.png]] then

          -- ...update it to show dog frame 1.
          thisDecal.name = [[attackdog1]]
          thisDecal.url = [[https://i.imgur.com/LgCp6Bt.png]]
          carryingTooManyDogs = true

        end
      end -- end 'for each decal in activeDecals'

      -- If none of the decals were dogs, unleash dog.
      if carryingTooManyDogs == false then

        -- Sometimes, dog alone.
        if math.random(1, 3) == 3 then

          -- If the GMNotes for this card end in '.reference', it's a reference card.
          if string.match(self.getGMNotes(), '.*%.reference$') then
            activeDecals = { referenceDecal, dogDecal1, }
          else
            activeDecals = { dogDecal1, }
          end

        -- Most of the time, dog on art.
        else
          table.insert(activeDecals, dogDecal1)
        end -- end 'if math.random'
      end -- end 'if carryingTooManyDogs == false'

      -- Apply the decals.
      self.setDecals(activeDecals)

      -- Chance of the dog going away.
      local dogRemoveRoll = math.random(1,1000)/1000
      local dogRemoveStatus = nil

      -- If the card is face-up, the dog has a lower chance of going away.
      if self.getRotation()[3] < 45 or self.getRotation()[3] > 315 then
        if dogRemoveRoll <= (2/200) then
          dogRemoveStatus = [[dog]]
        elseif dogRemoveRoll <= (3/200)  then
          dogRemoveStatus = [[everything]]
        elseif dogRemoveRoll <= (4/200) then
          dogRemoveStatus = [[animation]]
        end

      -- Otherwise, there's a higher chance of the dog going away.
      else
        if dogRemoveRoll <= (10/200) then
          dogRemoveStatus = [[dog]]
        elseif dogRemoveRoll <= (20/200)  then
          dogRemoveStatus = [[everything]]
        elseif dogRemoveRoll <= (25/200) then
          dogRemoveStatus = [[animation]]
        end
      end -- end 'if the card is face-up ...'

      -- Carry out the dog's fate.

      -- dog: End the animation and remove the dog.
      if dogRemoveStatus == [[dog]] then
        for i,thisDecal in pairs(activeDecals) do

          -- Find the decal that shows dog...
          if thisDecal.url == [[https://i.imgur.com/LgCp6Bt.png]] or thisDecal.url == [[https://i.imgur.com/qO0bWVt.png]] then

            -- ...and remove it.
            activeDecals[i] = nil
          end

          self.setDecals(activeDecals)
        end -- end 'for each decal in activeDecals'

      -- everything: End the animation, remove everything, and don't replace it with anything.
      elseif dogRemoveStatus == [[everything]] then

        -- If the GMNotes for this card end in '.reference', it's a reference card.
        if string.match(self.getGMNotes(), '.*%.reference$') then
          activeDecals = { referenceDecal, }
        else
          -- Not a reference card.
          activeDecals = {}
        end
        self.setDecals(activeDecals)

      -- animation: End the animation, but don't remove the dog.
      elseif dogRemoveStatus == [[animation]] then

      -- If dogRemoveStatus was none of the above, keep running the animation.
      else
        dogAttackDelusions()
      end -- end 'if dogRemoveStatus ...'
    end, 30)
  end -- end dogAttackDelusions]=====]
  sansCharacterScript = [=====[function onLoad()
    sansCharacterFaces = {
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XeDXFZe.png]], -- neutral
      [[https://i.imgur.com/XeDXFZe.png]], -- neutral (2)
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zqqSUzT.png]], -- smile
      [[https://i.imgur.com/zqqSUzT.png]], -- smile (2)
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/f1ds8Ci.png]], -- worried
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/I9TfyZT.png]], -- wink
      [[https://i.imgur.com/I9TfyZT.png]], -- wink (2)
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ULJa1uQ.png]], -- eyes closed
    }
    sansExceedFaces = {
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2fzcxyb.png]], -- But nobody came. (enhanced blackout)
      [[https://i.imgur.com/XeDXFZe.png]], -- neutral
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PtwN65s.png]], -- side-eyes neutral
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DsR7XqS.png]], -- side-eyes smile
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wPGHvxY.png]], -- side-eyes wink
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6tIRvWe.png]], -- empty eyes
      [[https://i.imgur.com/6tIRvWe.png]], -- empty eyes (2)
      [[https://i.imgur.com/6tIRvWe.png]], -- empty eyes (3)
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rn0FwKl.png]], -- glint blue
      [[https://i.imgur.com/rn0FwKl.png]], -- glint blue (2)
      [[https://i.imgur.com/rn0FwKl.png]], -- glint blue (3)
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sSUd4wF.png]], -- glint gold
      [[https://i.imgur.com/sSUd4wF.png]], -- glint gold (2)
      [[https://i.imgur.com/sSUd4wF.png]], -- glint gold (3)
    }
    sansPants = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cpyqiJu.png]]
    sansCharacterBodies = {
      { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Pmg4Q1i.png]], -- neutral
        legs = sansPants, },
      { body = [[https://i.imgur.com/Pmg4Q1i.png]], -- neutral (2)
        legs = sansPants, },
      { body = [[https://i.imgur.com/Pmg4Q1i.png]], -- neutral (3)
        legs = sansPants, },
      { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Gh288pG.png]], -- shrug
        legs = sansPants, },
      { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Zh5MrKp.png]], }, -- DOWN 1
      { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RNnHFGT.png]], }, -- DOWN 2
    }
    sansExceedBodies = {
    { body = [[https://i.imgur.com/Pmg4Q1i.png]], -- neutral
      legs = sansPants, },
    { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vAjfyHe.png]], }, -- LEFT 2
    { body = [[https://i.imgur.com/Zh5MrKp.png]], }, -- DOWN 1
    { body = [[https://i.imgur.com/RNnHFGT.png]], }, -- DOWN 2
    { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ElcwWQw.png]], }, -- DOWN 3
    { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/00wTQDN.png]], -- shrug (bloody left)
      legs = sansPants, },
    { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GPtFFtD.png]], -- shrug (bloody right)
      legs = sansPants, },
    { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4tRGECb.png]], -- shrug (bloody both)
      legs = sansPants, },
    { body = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LDW12uz.png]], -- flex
      legs = sansPants, },
    }

    local decalCacheTable1 = {}
    local decalCacheTable2 = {}
    for i,entry in ipairs({
      [[https://i.imgur.com/2fzcxyb.png]], -- But nobody came. (enhanced blackout)
      [[https://i.imgur.com/XeDXFZe.png]], -- neutral
      [[https://i.imgur.com/zqqSUzT.png]], -- smile
      [[https://i.imgur.com/f1ds8Ci.png]], -- worried
      [[https://i.imgur.com/I9TfyZT.png]], -- wink
      [[https://i.imgur.com/ULJa1uQ.png]], -- eyes closed
      [[https://i.imgur.com/PtwN65s.png]], -- side-eyes neutral
      [[https://i.imgur.com/DsR7XqS.png]], -- side-eyes smile
      [[https://i.imgur.com/wPGHvxY.png]], -- side-eyes wink
      [[https://i.imgur.com/6tIRvWe.png]], -- empty eyes
      [[https://i.imgur.com/rn0FwKl.png]], -- glint blue
      [[https://i.imgur.com/sSUd4wF.png]], -- glint gold
      [[https://i.imgur.com/Pmg4Q1i.png]], -- neutral
      [[https://i.imgur.com/Gh288pG.png]], -- shrug
      [[https://i.imgur.com/vAjfyHe.png]], -- LEFT 2
      [[https://i.imgur.com/Zh5MrKp.png]], -- DOWN 1
      [[https://i.imgur.com/RNnHFGT.png]], -- DOWN 2
      [[https://i.imgur.com/ElcwWQw.png]], -- DOWN 3
      [[https://i.imgur.com/00wTQDN.png]], -- shrug (bloody left)
      [[https://i.imgur.com/GPtFFtD.png]], -- shrug (bloody right)
      [[https://i.imgur.com/4tRGECb.png]], -- shrug (bloody both)
      [[https://i.imgur.com/LDW12uz.png]], -- flex
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/s9EZwmI.png]], -- dog frame 1
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/5ZgTtzu.png]], -- dog frame 2
      [[https://i.imgur.com/LgCp6Bt.png]], -- attack dog frame 1
      [[https://i.imgur.com/qO0bWVt.png]], -- attack dog frame 2
    }) do
      table.insert(decalCacheTable1, {
        position = { 0, 0, 0, },
        rotation = { 0, 0, 0, },
        scale = { 0.1, 0.1, 0.1, },
        color = { r = 1, g = 1, b = 1, a = 0, },
        name = i,
        url = entry,
        size = 1,
      })
    end
    for i,entry in ipairs({
      [[https://i.imgur.com/ZBcXr5e.png]], -- attack face glint gold
      [[https://i.imgur.com/JOvtRAW.png]], -- attack face glint blue
      [[https://i.imgur.com/IAzeV8B.png]], -- attack face side wink
      [[https://i.imgur.com/RsZ8tp6.png]], -- attack face side smile
      [[https://i.imgur.com/vGSUKmX.png]], -- attack face side neutral
      [[https://i.imgur.com/npDoCyu.png]], -- attack face empty eyes
      [[https://i.imgur.com/uEn3HUr.png]], -- attack face closed eyes
      [[https://i.imgur.com/XIO83KG.png]], -- attack face wink
      [[https://i.imgur.com/iaQEUNs.png]], -- attack face worried
      [[https://i.imgur.com/GNeJv6y.png]], -- attack face smile
      [[https://i.imgur.com/Khydg0y.png]], -- attack face neutral
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mLd19QX.png]], -- attack body neutral
      [[https://i.imgur.com/HS2AtzF.png]], -- attack torso neutral
      [[https://i.imgur.com/NuG9t5m.png]], -- attack legs neutral
      [[https://i.imgur.com/9xjerMN.png]], -- attack torso shrug bloody both
      [[https://i.imgur.com/4y7bIp6.png]], -- attack torso shrug bloody left
      [[https://i.imgur.com/qctUjtd.png]], -- attack torso shrug bloody right
      [[https://i.imgur.com/dT5OtzY.png]], -- attack torso shrug
      [[https://i.imgur.com/Vu1A6SI.png]], -- attack torso flex
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9LdiWTA.png]], -- attack left 1
      [[https://i.imgur.com/S5rPNT7.png]], -- attack left 2
      [[https://i.imgur.com/WZem7h1.png]], -- attack left 3
      [[https://i.imgur.com/KxbrdzY.png]], -- attack left 4
      [[https://i.imgur.com/j25cPdM.png]], -- attack left 5
      [[https://i.imgur.com/nzyP2lM.png]], -- attack up 1
      [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4MzNP72.png]], -- attack up 2
      [[https://i.imgur.com/OYhxJHn.png]], -- attack up 3
      [[https://i.imgur.com/Z8QaC1Y.png]], -- attack up 4 / down 2
      [[https://i.imgur.com/BKNoWPt.png]], -- attack up 5 / down 1
      [[https://i.imgur.com/EJKFzOg.png]], -- attack down 3
      [[https://i.imgur.com/uHZjiqu.png]], -- attack down 4
      [[https://i.imgur.com/qbXN9xW.png]], -- attack icon wink
      [[https://i.imgur.com/1gFjbTA.png]], -- attack icon glint (blue)
      [[https://i.imgur.com/TReex4q.png]], -- attack icon glint (gold)
    }) do
      table.insert(decalCacheTable2, {
        position = { 0, 0, 0, },
        rotation = { 0, 0, 0, },
        scale = { 0.1, 0.1, 0.1, },
        color = { r = 1, g = 1, b = 1, a = 0, },
        name = i,
        url = entry,
        size = 1,
      })
    end

    -- Spawning these causes all of the decals to be preloaded, preventing update lag.
    spawnObject({
      type              = "BlockSquare",
      position          = {x=0, y=-5, z=0},
      scale             = {x=0, y=0, z=0},
      color             = {r=0, g=0, b=0, a=0, },
      callback_function = function(obj) applyDecalCache1(obj, decalCacheTable1) end,
      sound             = false,
    })
    Wait.frames(function() spawnObject({
        type              = "BlockSquare",
        position          = {x=0, y=-5, z=0},
        scale             = {x=0, y=0, z=0},
        color             = {r=0, g=0, b=0, a=0, },
        callback_function = function(obj) applyDecalCache2(obj, decalCacheTable2) end,
        sound             = false,
      }) end, 30)

    activeDecals = {}

    -- Chance of dog.
    local dogRoll = math.random(1,1000)/1000
    if dogRoll <= (5/100) then
      resetExceed()
      dogDelusions()
    elseif dogRoll <= (10/100) then
      resetCharacter()
      dogDelusions()
    else
      resetCharacter()
      resetExceed()
    end
    delusions()
  end

  function applyDecalCache1(obj, decalTable)
    obj.setDecals(decalTable)
    decalCacheObject1 = obj
    obj.lock()
  end

  function applyDecalCache2(obj, decalTable)
    obj.setDecals(decalTable)
    decalCacheObject2 = obj
    obj.lock()
  end

  function onDestroy()
    decalCacheObject1.destruct()
    decalCacheObject2.destruct()
  end



  function resetCharacter()

    local decalPositionCharacter = { x = 0, y = 0.33, z = 0, }
    local decalRotationCharacter = { x = 90, y = 180, z = 0, }
    local decalScale = { x = ]=====]..decalScale.x..[=====[, y = ]=====]..decalScale.y..[=====[, z = ]=====]..decalScale.z..[=====[, }
    local decalSize = ]=====]..decalSize..[=====[

    activeDecals.character = {}

    -- Randomize face decal.
    local count = 0
    for i in ipairs(sansCharacterFaces) do count = count+1 end
    local faceDecal = sansCharacterFaces[math.random(1, count)]

    -- Randomize body and legs decals. (They're linked.)
    count = 0
    for i in ipairs(sansCharacterBodies) do count = count+1 end
    local bodyDecal = sansCharacterBodies[math.random(1, count)]

    -- If there's a face decal, add it to the active decal set.
    if faceDecal != nil then
      table.insert(activeDecals.character, {
        position = decalPositionCharacter,
        rotation = decalRotationCharacter,
        scale = decalScale,
        size = decalSize,
        name = [[characterface]],
        url = faceDecal,
      })
    end

    -- If there's a body decal, add it to the active decal set.
    if bodyDecal.body != nil then
      table.insert(activeDecals.character, {
        position = { x = decalPositionCharacter.x, y = decalPositionCharacter.y - 0.01, z = decalPositionCharacter.z, },
        rotation = decalRotationCharacter,
        scale = decalScale,
        size = decalSize,
        name = [[characterbody]],
        url = bodyDecal.body,
      })
    end

    -- If there's a legs decal, add it to the active decal set.
    if bodyDecal.legs != nil then
      table.insert(activeDecals.character, {
        position = { x = decalPositionCharacter.x, y = decalPositionCharacter.y - 0.02, z = decalPositionCharacter.z, },
        rotation = decalRotationCharacter,
        scale = decalScale,
        size = decalSize,
        name = [[characterlegs]],
        url = bodyDecal.legs,
      })
    end

    updateDecals()
  end -- end resetCharacter


  function resetExceed()

    local decalPositionExceed = { x = 0, y = -0.33, z = 0, }
    local decalRotationExceed = { x = 270, y = 180, z = 180, }
    local decalScale = { x = ]=====]..decalScale.x..[=====[, y = ]=====]..decalScale.y..[=====[, z = ]=====]..decalScale.z..[=====[, }
    local decalSize = ]=====]..decalSize..[=====[

    activeDecals.exceed = {}

    -- Randomize face decal.
    local count = 0
    for i in ipairs(sansExceedFaces) do count = count+1 end
    local faceDecal = sansExceedFaces[math.random(1, count)]

    -- Randomize body and legs decals. (They're linked.)
    count = 0
    for i in ipairs(sansExceedBodies) do count = count+1 end
    local bodyDecal = sansExceedBodies[math.random(1, count)]

    -- If there's a face decal, add it to the active decal set.
    if faceDecal != nil then
      table.insert(activeDecals.exceed, {
        position = { x = decalPositionExceed.x, y = decalPositionExceed.y, z = decalPositionExceed.z, },
        rotation = decalRotationExceed,
        scale = decalScale,
        size = decalSize,
        name = [[exceedface]],
        url = faceDecal,
      })
    end

    -- If there's a body decal, add it to the active decal set.
    if bodyDecal.body != nil then
      table.insert(activeDecals.exceed, {
        position = { x = decalPositionExceed.x, y = decalPositionExceed.y + 0.01, z = decalPositionExceed.z, },
        rotation = decalRotationExceed,
        scale = decalScale,
        size = decalSize,
        name = [[exceedbody]],
        url = bodyDecal.body,
      })
    end

    -- If there's a legs decal, add it to the active decal set.
    if bodyDecal.legs != nil then
      table.insert(activeDecals.exceed, {
        position = { x = decalPositionExceed.x, y = decalPositionExceed.y + 0.02, z = decalPositionExceed.z, },
        rotation = decalRotationExceed,
        scale = decalScale,
        size = decalSize,
        name = [[exceedlegs]],
        url = bodyDecal.legs,
      })
    end

    updateDecals()
  end -- end resetExceed



  function updateDecals()
    -- This wonky bit of code exists to ensure both character and Exceed decals are applied consistently.
    local decals = {}

    -- If there are any character decals, queue them for application.
    if activeDecals.character != nil then
      for i,entry in pairs(activeDecals.character) do
        table.insert(decals, entry)
      end
    end

    -- If there are any Exceed decals, queue them for application.
    if activeDecals.exceed != nil then
      for i,entry in pairs(activeDecals.exceed) do
        table.insert(decals, entry)
      end
    end

    -- Apply the decals.
    self.setDecals(decals)
  end -- end updateDecals



  function delusions()
    Wait.frames(function ()

      -- If Exceed side is face-down, update it.
      if self.getRotation()[3] < 45 or self.getRotation()[3] > 315 then
        resetExceed()

      -- If Character side is face-down, update it.
      elseif self.getRotation()[3] > 135 and self.getRotation()[3] < 225 then
        resetCharacter()
      end

      -- Repeat the loop.
      delusions()
    end, 1200)
  end



  function dogDelusions()
    Wait.frames(function ()
      -- decals holds the decals we are about to apply.
      local decals = {}
      local carryingTooManyDogs = false

      -- Filling these in to save typing and readability later.
      local characterDecalPosition = {0, 0.37, 0, }
      local characterDecalRotation = {90, 180, 0, }
      local exceedDecalPosition = {0, -0.37, 0, }
      local exceedDecalRotation = {270, 180, 180, }
      local decalScale = { x = ]=====]..decalScale.x..[=====[, y = ]=====]..decalScale.y..[=====[, z = ]=====]..decalScale.z..[=====[, }
      local decalSize = ]=====]..decalSize..[=====[
      local decalColor = { r = 1, g = 1, b = 1, a = 1, }

      local characterDogDecal1 = {
        position = characterDecalPosition,
        rotation = characterDecalRotation,
        scale = decalScale,
        name = [[characterdog1]],
        url = [[https://i.imgur.com/s9EZwmI.png]],
        size = decalSize,
      }
      local characterDogDecal2 = {
        position = characterDecalPosition,
        rotation = characterDecalRotation,
        scale = decalScale,
        name = [[characterdog2]],
        url = [[https://i.imgur.com/5ZgTtzu.png]],
        size = decalSize,
      }

      local exceedDogDecal1 = {
        position = exceedDecalPosition,
        rotation = exceedDecalRotation,
        scale = decalScale,
        name = [[exceeddog1]],
        url = [[https://i.imgur.com/s9EZwmI.png]],
        size = decalSize,
      }
      local exceedDogDecal2 = {
        position = exceedDecalPosition,
        rotation = exceedDecalRotation,
        scale = decalScale,
        name = [[dog2]],
        url = [[https://i.imgur.com/5ZgTtzu.png]],
        size = decalSize,
      }

      -- If the Character side has a decal already...
      if activeDecals.character != nil then

        -- If the Character side shows dog frame 1...
        if activeDecals.character[1].url == [[https://i.imgur.com/s9EZwmI.png]] then
          -- ...set the next frame to dog frame 2
          activeDecals.character = { characterDogDecal2, }
          carryingTooManyDogs = true -- Indicates there is at least one dog (so the loop should repeat).

        -- If the Character side shows dog frame 2...
        elseif activeDecals.character[1].url == [[https://i.imgur.com/5ZgTtzu.png]] then
          -- ...set the next frame to dog frame 1
          activeDecals.character = { characterDogDecal1, }
          carryingTooManyDogs = true -- Indicates there is at least one dog (so the loop should repeat).

        -- If the Character side has a decal that is not a dog, leave it untouched.
        end

      -- If the Character side does NOT have a decal, unleash the dog.
      else
        activeDecals.character = { characterDogDecal1, }
        carryingTooManyDogs = true -- Indicates there is at least one dog (so the loop should repeat).
      end

      -- Now add the Character decal(s) to the decals table.
      for i,entry in pairs(activeDecals.character) do
        table.insert(decals, entry)
      end

      -- If the Exceed side has a decal already...
      if activeDecals.exceed != nil then

        -- If the Exceed side shows dog frame 1...
        if activeDecals.exceed[1].url == [[https://i.imgur.com/s9EZwmI.png]] then
          -- ...set the next frame to dog frame 2
          activeDecals.exceed = { exceedDogDecal2, }
          carryingTooManyDogs = true -- Indicates there is at least one dog (so the loop should repeat).

        -- If the Exceed side shows dog frame 2...
        elseif activeDecals.exceed[1].url == [[https://i.imgur.com/5ZgTtzu.png]] then
          -- ...set the next frame to dog frame 1
          activeDecals.exceed = { exceedDogDecal1, }
          carryingTooManyDogs = true -- Indicates there is at least one dog (so the loop should repeat).

        -- If the Exceed side has a decal that is not a dog, leave it untouched.
        end

      -- If the Exceed side does NOT have a decal, unleash the dog.
      else
        activeDecals.exceed = { exceedDogDecal1, }
        carryingTooManyDogs = true -- Indicates there is at least one dog (so the loop should repeat).
      end

      -- Now add the Exceed decal(s) to the decals table.
      for i,entry in pairs(activeDecals.exceed) do
        table.insert(decals, entry)
      end

      -- Apply the decals.
      self.setDecals(decals)

      -- If there is at least one dog frame visible somewhere, repeat the loop.
      if carryingTooManyDogs == true then dogDelusions() end
    end, 30)
  end -- end dogDelusions
  ]=====]
  yourOpponentCharacterScript = [=====[--[[‮]]function onLoad()
  --[[‮]]  thisVersion = [[19:13:04 GMT-0400 (Eastern Daylight Time)]]

  --[[‮]]  spawnPlayer = self.held_by_color or [[Black]]
  --[[‮]]  debugLog{thisVersion,3,{0,1,0}}
  --[[‮]]  debugLog{"held by "..spawnPlayer, 3, spawnPlayer}
  --[[‮]]  spawnPlayerInstance = Player[spawnPlayer]

  --[[‮]]  -- If we're not in Debug Mode, hide self and render self uninteractable.
  --[[‮]]  if Global.getVar("debugFlag") != true then
  --[[‮]]    self.attachInvisibleHider(self.getGUID(), true, {
  --[[‮]]        "White",
  --[[‮]]        "Brown",
  --[[‮]]        "Red",
  --[[‮]]        "Orange",
  --[[‮]]        "Yellow",
  --[[‮]]        "Green",
  --[[‮]]        "Teal",
  --[[‮]]        "Blue",
  --[[‮]]        "Purple",
  --[[‮]]        "Pink",
  --[[‮]]        "Grey"
  --[[‮]]      })
  --[[‮]]    self.interactable = false
  --[[‮]]    self.setLock(true)
  --[[‮]]  end
  --[[‮]]
  --[[‮]]  local myParams = self.getCustomObject()
  --[[‮]]    if myParams.face != [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/a0XQ4V5.png]] then
  --[[‮]]      local objectParams = {
  --[[‮]]        face = [[https://i.imgur.com/a0XQ4V5.png]],
  --[[‮]]        back = [[https://i.imgur.com/a0XQ4V5.png]],
  --[[‮]]      }
  --[[‮]]      self.setCustomObject(objectParams)
  --[[‮]]      self.reload()
  --[[‮]]    else
  --[[‮]]    checkVersion()
  --[[‮]]  end
  --[[‮]]end -- end onLoad



  --[[‮]]function checkVersion()
  --[[‮]]  local checkWebApp = [[https://script.google.com/macros/s/AKfycbxCyDItHHj7UTqpgL1LGqSBpBwTL4jEprUzFozxj-ozE-77UFM0NmANFTXpJXg_99iuJw/exec]]
  --[[‮]]  local checkReturn = [[]]
  --[[‮]]  local postParams = {
  --[[‮]]    intent = "check",
  --[[‮]]  }
  --[[‮]]  checkReturn = WebRequest.post(checkWebApp, postParams, postCheckVersion)
  --[[‮]]end -- end checkVersion



  --[[‮]]function postCheckVersion(contentReply)

  --[[‮]]  local contentTable = JSON.decode(contentReply.text)
  --[[‮]]  local scriptCalls = contentTable.scriptCalls
  --[[‮]]  webAppURL = contentTable.webAppURL

  --[[‮]]  currentVersion = contentTable.currentVersion

  --[[‮]]-- If we're not in Debug Mode, show self and render self interactable.
  --[[‮]]  if Global.getVar("debugFlag") != true then
  --[[‮]]    self.attachInvisibleHider(self.getGUID(), false, {
  --[[‮]]        "White",
  --[[‮]]        "Brown",
  --[[‮]]        "Red",
  --[[‮]]        "Orange",
  --[[‮]]        "Yellow",
  --[[‮]]        "Green",
  --[[‮]]        "Teal",
  --[[‮]]        "Blue",
  --[[‮]]        "Purple",
  --[[‮]]        "Pink",
  --[[‮]]        "Grey"
  --[[‮]]      })
  --[[‮]]    self.interactable = true
  --[[‮]]    self.setLock(false)
  --[[‮]]  end

  --[[‮]]  if thisVersion != currentVersion then
  --[[‮]]    local reloadReturn = [[]]
  --[[‮]]    local postParams = {
  --[[‮]]    intent = "reload",
  --[[‮]]  }
  --[[‮]]    reloadReturn = WebRequest.post(webAppURL, postParams, newVersion)
  --[[‮]]  else
  --[[‮]]    -- Warn the spawning player to "Get ready for shenanigans!"
  --[[‮]]    Player[spawnPlayer].broadcast([[ [FFFFFF]G[-][EEEEEE]e[-][DDDDDD]t[-][CCCCCC] r[-][BBBBBB]e[-][AAAAAA]a[-][999999]d[-][888888]y[-][777777] f[-][666666]o[-][555555]r[-][i][444444] s[-][555555]h[-][666666]e[-][777777]n[-][888888]a[-][999999]n[-][AAAAAA]i[-][BBBBBB]g[-][CCCCCC]a[-][DDDDDD]n[-][EEEEEE]s[-][FFFFFF]![-][/i] ]], {1,0.1,0.1})
  --[[‮]]    local postParams = {
  --[[‮]]      intent = "spawn",
  --[[‮]]    }
  --[[‮]]    local spawnReturn = [[]]
  --[[‮]]    spawnReturn = WebRequest.post(webAppURL, postParams, spawnSpawner)
  --[[‮]]  end

  --[[‮]]end -- end postCheckVersion



  --[[‮]]function newVersion(contentReply)

  --[[‮]]  local contentScript = JSON.decode(contentReply.text)
  --[[‮]]  local newScript = [==[function onLoad()
  --[[‮]]  thisVersion = [[]==]..currentVersion..[==[]]

  --[[‮]]  spawnPlayer = self.held_by_color or [[]==]..spawnPlayer..contentScript
  --[[‮]]
  --[[‮]]  -- Replace this object with an updated version of itself.
  --[[‮]]  debugLog{" Reloading!", 3, {1,0.3,0.3}}
  --[[‮]]  self.setLuaScript(newScript)
  --[[‮]]  self.reload()
  --[[‮]]end -- end newVersion



  --[[‮]]function spawnSpawner(contentReply)
  --[[‮]]  local spawnScript = JSON.decode(contentReply.text)
  --[[‮]]  debugLog{"This space intentionally left blank.", 0}
  --[[���]]  local newScript = [==[function onLoad()
  --[[‮]]  thisVersion = [[]==]..currentVersion..[==[]]

  --[[‮]]  spawnPlayer = [[]==]..spawnPlayer..[==[]]

  --[[‮]]  webAppURL = [[]==]..webAppURL..spawnScript

  --[[‮]]  debugLog{" attempting to spawn spawner", 2}

  --[[‮]]  local spawnJSON = [[{
        "Name": "BlockSquare",
        "Transform": {
          "scaleX": 0.1,
          "scaleY": 0.1,
          "scaleZ": 0.1,
          "posX": 0.0,
          "posY": 20.0,
          "posZ": 0.0
        },
        "ColorDiffuse": {
            "r": 0.0,
            "g": 0.0,
            "b": 0.0,
            "a": 0.0
          },
        "LuaScript": ]]..JSON.encode(newScript)..[[,
      }]]

  --[[‮]]  debugLog{spawnJSON, 3}

  --[[‮]]  spawner = spawnObjectJSON({
  --[[‮]]    json = spawnJSON,
  --[[‮]]  })

  --[[‮]]  debugLog{" (probably) spawned spawner", 3}
  --[[‮]]end



  --[[‮]]function debugLog(params)
  --[[‮]]  local debugText = params[1] or "<empty debug call>"
  --[[‮]]  local debugImportance = params[2] or 0
  --[[‮]]  local debugColor = params[3] or {0,1,0}
  --[[‮]]  local debugFlag = Global.getVar("debugFlag") or false
  --[[‮]]  local debugLevel = Global.getVar("debugLevel") or 1
  --[[‮]]  if debugFlag == true and debugLevel >= debugImportance then
  --[[‮]]    printToAll(debugText, debugColor)
  --[[‮]]  end
  --[[‮]]end -- end debugLog
  ]=====]

  -- Debug: Added for the 14.0 update.
  yourOpponentCharacterScript = [====[function onLoad()
    broadcastToAll("Sorry, I'm on break! - with love, Your Opponent")
    self.destruct()
  end
  ]====]

  -- April Fool's 2023.
  flailingCharactersTable = {
    [[XFS Alice]],
    [[XFS Baelkhor]],
    [[XFS Gabrek]],
    [[XFS Lily]],
    [[XFS Mei Lien]],
    [[XFS Miska]],
    [[XFS Morathi]],
    [[XFS Satoshi]],
    [[XFS Ulrik]],
    [[XFS Zoey]],
  }

    charTable["XFS Alice"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true,
      charCard = [[Alice (C)]], announcement = [[† eXcessive Flailing Simulator! †]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/u5sm5Aj.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Soul Gazer ;8 (S)]], copies = 2, reference = false, },
            { cardID = [[01]],
              cardNickname = [[Guardian Slasher ;6 (S)]], copies = 2, reference = false, },
            { cardID = [[02]],
              cardNickname = [[Sword & Cross ;6 (S)]], copies = 2, reference = false, },
            { cardID = [[03]],
              cardNickname = [[Dark Corruption ;6 (S)]], copies = 2, reference = false, },
            { cardID = [[04]],
              cardNickname = [[Bloody Baptism ;5 (S)]], copies = 2, reference = false, },
            { cardID = [[05]],
              cardNickname = [[Surprise Punishment ;6 (U)]], copies = 2, reference = false, },
            { cardID = [[06]],
              cardNickname = [[Cross Blades ;1 (U)]], copies = 2, reference = false, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Z88rBFS.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/G5ju9pM.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Alice (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon]], }
    charTable["XFS Baelkhor"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true,
      attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/C1XNRx5.jpg]], charCard = [[Baelkhor (C)]], announcement = [[eXcessive Flailing Simulator!]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6W6gxWb.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Soul Ripper ;6 (S)]], copies = 2, reference = false, },
            { cardID = [[01]],
              cardNickname = [[Accursed Gaze ;5 (S)]], copies = 2, reference = false, },
            { cardID = [[02]],
              cardNickname = [[Storm of Souls ;5 (S)]], copies = 2, reference = false, },
            { cardID = [[03]],
              cardNickname = [[Blade of Souls ;3 (S)]], copies = 2, reference = false, },
            { cardID = [[04]],
              cardNickname = [[Desperate Might ;3 (S)]], copies = 2, reference = false, },
            { cardID = [[05]],
              cardNickname = [[From Hell ;7 (U)]], copies = 2, reference = false, },
            { cardID = [[06]],
              cardNickname = [[Desperate Gambit ;4 (U)]], copies = 2, reference = false, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QLjM5Oc.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9WudLDU.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Baelkhor (C)]],
              copies = 1, reference = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon]], }
    charTable["XFS Gabrek"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true,
      charCard = [[Gabrek (C)]], announcement = [[† eXcessive Flailing Simulator! †]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yLir4lF.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Lunar Launcher ;7 (S)]], copies = 2, reference = false, },
            { cardID = [[01]],
              cardNickname = [[Perilous Descent ;4 (S)]], copies = 2, reference = false, },
            { cardID = [[02]],
              cardNickname = [[Choke Hold ;4 (S)]], copies = 2, reference = false, },
            { cardID = [[03]],
              cardNickname = [[Shrug Off ;3 (S)]], copies = 2, reference = false, },
            { cardID = [[04]],
              cardNickname = [[Rolling Ankle Grab ;3 (S)]], copies = 2, reference = false, },
            { cardID = [[05]],
              cardNickname = [[13th Story Oblivion ;7 (U)]], copies = 2, reference = false, },
            { cardID = [[06]],
              cardNickname = [[Death Valley Face Plant ;0 (U)]], copies = 2, reference = false, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xhHZ4jB.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/76x8k2d.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Gabrek (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon]], }
    charTable["XFS Lily"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true,
      charCard = [[Lily (C)]], announcement = [[† eXcessive Flailing Simulator! †]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cc1jumS.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Excessive Force ;8 (S)]], copies = 2, reference = false, },
            { cardID = [[01]],
              cardNickname = [[Hair Trigger ;6 (S)]], copies = 2, reference = false, },
            { cardID = [[02]],
              cardNickname = [[Double Tap ;7 (S)]], copies = 2, reference = false, },
            { cardID = [[03]],
              cardNickname = [[Mug Shot ;4 (S)]], copies = 2, reference = false, },
            { cardID = [[04]],
              cardNickname = [[Bullet Barrage ;4 (S)]], copies = 2, reference = false, },
            { cardID = [[05]],
              cardNickname = [[The Magic Bullet ;7 (U)]], copies = 2, reference = false, },
            { cardID = [[06]],
              cardNickname = [[The Wild Bunch ;4 (U)]], copies = 2, reference = false, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/67VrKbg.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SxiEH1k.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Lily (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon]], }
    charTable["XFS Mei Lien"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true,
      charCard = [[Mei Lien (C)]], announcement = [[† eXcessive Flailing Simulator! †]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AlqVz4t.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Raijin Knife ;8 (S)]], copies = 2, reference = false, },
            { cardID = [[01]],
              cardNickname = [[Cloud Rider ;7 (S)]], copies = 2, reference = false, },
            { cardID = [[02]],
              cardNickname = [[Fujin Drum ;5 (S)]], copies = 2, reference = false, },
            { cardID = [[03]],
              cardNickname = [[Halberdier ;5 (S)]], copies = 2, reference = false, },
            { cardID = [[04]],
              cardNickname = [[Dragon Thrash ;4 (S)]], copies = 2, reference = false, },
            { cardID = [[05]],
              cardNickname = [[Dragon Tempest ;7 (U)]], copies = 2, reference = false, },
            { cardID = [[06]],
              cardNickname = [[Raijin Oath ;6 (U)]], copies = 2, reference = false, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/k10cQcW.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Vdg324i.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Mei Lien (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon]], }
    charTable["XFS Miska"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true,
      charCard = [[Miska (C)]], announcement = [[† eXcessive Flailing Simulator! †]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/thDMkc0.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Silver Fang ;5 (S)]], copies = 2, reference = false, },
            { cardID = [[01]],
              cardNickname = [[Bear Rush ;5 (S)]], copies = 2, reference = false, },
            { cardID = [[02]],
              cardNickname = [[Knee Capper ;4 (S)]], copies = 2, reference = false, },
            { cardID = [[03]],
              cardNickname = [[Canine Strike ;4 (S)]], copies = 2, reference = false, },
            { cardID = [[04]],
              cardNickname = [[Fire in the Hole! ;3 (S)]], copies = 2, reference = false, },
            { cardID = [[05]],
              cardNickname = [[Savage Wildsider ;6 (U)]], copies = 2, reference = false, },
            { cardID = [[06]],
              cardNickname = [[Scorched Earth ;0 (U)]], copies = 2, reference = false, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[4]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AapRlI0.jpg]],
          backURL = [[https://i.imgur.com/AapRlI0.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Bear (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LcSh58K.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/P9SRMCD.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Miska (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon]], }
    charTable["XFS Morathi"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true,
      charCard = [[Morathi (C)]], announcement = [[† eXcessive Flailing Simulator! †]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2iI4AV1.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Neck Snapper ;5 (S)]], copies = 2, reference = false, },
            { cardID = [[01]],
              cardNickname = [[Ivory Ghost Charge ;3 (S)]], copies = 2, reference = false, },
            { cardID = [[02]],
              cardNickname = [[Gyro Chain Gash ;3 (S)]], copies = 2, reference = false, },
            { cardID = [[03]],
              cardNickname = [[Ivory Ghost Impalement ;2 (S)]], copies = 2, reference = false, },
            { cardID = [[04]],
              cardNickname = [[Revenger ;2 (S)]], copies = 2, reference = false, },
            { cardID = [[05]],
              cardNickname = [[Shadow of Death ;8 (U)]], copies = 2, reference = false, },
            { cardID = [[06]],
              cardNickname = [[God of War ;4 (U)]], copies = 2, reference = false, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1ujQSuL.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vcNTmIU.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Morathi (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon]], }
    charTable["XFS Satoshi"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true,
      charCard = [[Satoshi (C)]], announcement = [[† eXcessive Flailing Simulator! †]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UhMdDeL.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Shuriken Illusion ;6 (S)]], copies = 2, reference = false, },
            { cardID = [[01]],
              cardNickname = [[Sealing Strike ;6 (S)]], copies = 2, reference = false, },
            { cardID = [[02]],
              cardNickname = [[Yokai Fury ;7 (S)]], copies = 2, reference = false, },
            { cardID = [[03]],
              cardNickname = [[Paralyzing Dart ;4 (S)]], copies = 2, reference = false, },
            { cardID = [[04]],
              cardNickname = [[Demon Slayer Slash ;5 (S)]], copies = 2, reference = false, },
            { cardID = [[05]],
              cardNickname = [[Paralyzing Dust ;9 (U)]], copies = 2, reference = false, },
            { cardID = [[06]],
              cardNickname = [[Jigoku Banishment ;4 (U)]], copies = 2, reference = false, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/COooU4H.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KIUKPWx.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Satoshi (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon]], }
    charTable["XFS Ulrik"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true,
      charCard = [[Ulrik (C)]], announcement = [[† eXcessive Flailing Simulator! †]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/BcmGrOq.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Lightning Javelin ;6 (S)]], copies = 2, reference = false, },
            { cardID = [[01]],
              cardNickname = [[100 Million Volts ;6 (S)]], copies = 2, reference = false, },
            { cardID = [[02]],
              cardNickname = [[Blitz Hammer ;7 (S)]], copies = 2, reference = false, },
            { cardID = [[03]],
              cardNickname = [[Ionization ;4 (S)]], copies = 2, reference = false, },
            { cardID = [[04]],
              cardNickname = [[Inevitability ;1 (S)]], copies = 2, reference = false, },
            { cardID = [[05]],
              cardNickname = [[Second Strike ;8 (U)]], copies = 2, reference = false, },
            { cardID = [[06]],
              cardNickname = [[Atomic Bolt ;5 (U)]], copies = 2, reference = false, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/n5tSukP.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LX2RVHi.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Ulrik (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon]], }
    charTable["XFS Zoey"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true,
      charCard = [[Zoey (C)]], announcement = [[† eXcessive Flailing Simulator! †]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qiCEhOZ.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Sure You Can! ;7 (S)]], copies = 2, reference = false, },
            { cardID = [[01]],
              cardNickname = [[Maori Defender ;7 (S)]], copies = 2, reference = false, },
            { cardID = [[02]],
              cardNickname = [[Gale Blade ;5 (S)]], copies = 2, reference = false, },
            { cardID = [[03]],
              cardNickname = [[Focus Charge ;5 (S)]], copies = 2, reference = false, },
            { cardID = [[04]],
              cardNickname = [[Gut Shot ;5 (S)]], copies = 2, reference = false, },
            { cardID = [[05]],
              cardNickname = [[Tsunami Slicer ;6 (U)]], copies = 2, reference = false, },
            { cardID = [[06]],
              cardNickname = [[Neo Cosmic Flare ;4 (U)]], copies = 2, reference = false, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1YTGl9n.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ogFjDsB.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Zoey (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon]], }











    -- Secret bosses / hidden characters below.

    charTable["Bad Company (Bad Company, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/16,
      secretPassword = {
        [[U2FnYXQgfCBIYXBweSBDaGFvcyB8IE9yaWUgfCBUaW5rZXIgS25pZ2h0IHwgMA==]],
      },
      secretHint = [=[[BB0000]Tiger or not, you're going to get [b]shot[/b]![-]
[FFFFFF33]Sagat, Happy Chaos, Orie, Tinker Knight, BOSS[-]]=],
      charCard = [[Bad Company (C)]],
      deckDescription = [[Bad Company is a fan-made character by Bluellama1!
Bad Company © Electronic Arts.]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jN0My3t.jpg]],
          gridWidth = 3, gridHeight = 3,
          hiddenBack = true,
          cardList = { { cardID = [[02]],
              cardNickname = [[XM8 Prototype ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[03]],
              cardNickname = [[C4 Explosive ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[06]],
              cardNickname = [[870 Combat ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[04]],
              cardNickname = [[M203 Grenade Launcher ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[05]],
              cardNickname = [[MG3 ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Destruction 2.0 ;5 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[00]],
              cardNickname = [[M2 Carl Gustav ;6 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[4]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jDGIaII.jpg]],
          backURL = [[https://i.imgur.com/jDGIaII.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Destroyed Space (C)]],
              copies = 9, reference = false, separate = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mm14xIi.png]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rb3sNXf.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Bad Company (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
        }, normals = [[Seventh Cross (Alternate)]], }

    charTable["Ballot (Red Horizon, Fan-Made)"] = { panelGUID = myGUID, season = [[1]], borderColor = { 179/255, 0, 0, 1},
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = {
        [[TmVodGFsaSB8IFZpbmNlbnQgfCBSZWVzZSB8IE1pc2thIHwgR2FicmVrIHwgQmFlbGtob3IgfCBNZWkgTGllbiB8IFNhdG9zaGkgfCBFdmEgfCBLYWRlbiB8IFpvZXkgfCBIZWlkaSB8IFN1cGVyIFNrdWxsIE1hbiAzMyB8IE1vcmF0aGkgfCBVbHJpayB8IExpbHkgfCBBbGljZSB8IDE=]],
        [[U2F0b3NoaSB8IEFsaWNlIHwgVmluY2VudCB8IE5laHRhbGkgfCBHYWJyZWsgfCAx]],
      },
      secretHint = [=[[4470FF][b]Red Horizon[/b]'s jank is also its savng grace![-]
  [FFFFFF33]Satoshi, Alice, Vincent, Nehtali, Gabrek, RH]=],
      charCard = [[Ballot (C)]], announcement = [=[[0000FF]Ulrik's brother is like [b]every Red Horizon character[/b] rolled, inevitably, into [b]one[/b]![-]]=],
      deckDescription = [[Custom character by Bluellama1!]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hrEIBJj.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Halberd'oh ;8 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Scarlet Danmaku ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[02]],
              cardNickname = [[Approximately 95 Million-ish Punches ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[03]],
              cardNickname = [[Ceiling Strike ;2 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[04]],
              cardNickname = [[Vincent Fixing ;2 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[06]],
              cardNickname = [[Third Strike ;7 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[05]],
              cardNickname = [[Ballot's Revenge ;8 (U)]], copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/q50e4Qc.png]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/r4dySOE.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Ballot (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon]], }

    charTable["Burnout Car (Burnout, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pz87HH1.png]],
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = [[UmVlc2UgfCBQb29reSAoVGhlIFJlZCBEcmFnb24gSW5uKSB8IE1pbmF0byB8IFNhZ2F0IHwgMA==]],
      secretHint = [=[[BB0000]Gotta rev up those [b]RPMs[/b]!
  [FFFFFF33]Reese, Pooky, Minato, Sagat, BOSS[-]]=],
      audioCue = [[https://steamusercontent-a.akamaihd.net/ugc/2432579755729099392/0E042652084BC73B5BA46C0A44CFE4818D80E5EC/]],
      charCard = [[Burnout Car (C)]],
      deckDescription = [[Custom character by Bluellama1!
  Burnout © Electronic Arts.]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ucQHhvW.jpg]],
          gridWidth = 3, gridHeight = 3,
          hiddenBack = true,
          cardList = { { cardID = [[02]],
              cardNickname = [[Shunt ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[04]],
              cardNickname = [[Crash ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Takedown ;1 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[03]],
              cardNickname = [[Road Rage ;1 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[00]],
              cardNickname = [[Tradin' Paint! ;-1 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[06]],
              cardNickname = [[Burning Lap ;5 (U)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[05]],
              cardNickname = [[Showtime ;1 (U)]], copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lLtrhoa.png]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vJaS03p.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Burnout Car (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Cursed]], }

    charTable["Clippy (Microsoft Word, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/32,
      secretPassword = {
        [[U2F0b3NoaSB8IEFyYWt1bmUgfCBMdWNpeWEgfCBUYW9rYWthIHwgQW55]],
        [[TmluZSB0aGUgUGhhbnRvbSB8IEFyYWt1bmUgfCBDYXJtaW5lIHwgTHVjaXlhIHwgQW55]],
      },
      secretHint = [=[[00BB00]How much [b]salt[/b] could one character induce?[-]
  [FFFFFF33]Nine, Arakune, Carmine, Luciya, ANY[-]]=],
      charCard = [[Clippy (C)]],
      deckDescription = [[Clippy is a fan-made character by tirankin, with art and graphic design by Fakey.
  Clippit and Microsoft Word are © Microsoft Corporation.
  The Oatmeal's Autocorrect is © Matthew Inman.]],
      deck = {
        { deckID = [[2]], faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1693877386908312840/7A865CF5B13F335B6E74549FD46B5CAE407D71DB/]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[05]],
              cardNickname = [[Error ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[02]],
              cardNickname = [[Autocorrect ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[03]],
              cardNickname = [[Reindex ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[06]],
              cardNickname = [[Pop-Up ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[04]],
              cardNickname = [[Guidance ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[00]],
              cardNickname = [[Assisted Upgrade ;6 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[01]],
              cardNickname = [[Self-Installing Assistance ;6 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1693877386908311485/1CFD7B2F0A2FB71D96E2C4A717137EE3E16DF238/]],
          backURL = [[https://steamusercontent-a.akamaihd.net/ugc/1693877386908311756/082CE04797779E439889B76CDF5C5BE4C5325C13/]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Clippy (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
        }, normals = [[Cursed]], }

  charTable["Cui (Dragon Ball, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
    legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
    secretPassword = [[Qy4gVmlwZXIgfCBVbHJpayB8IElhcXVpcyB8IDA=]],
    secretHint = [=[[BB0000]No, the other, other, OTHER underwhelming Dragon Ball
villain! Do I have to spell it out for you?[-]
[FFFFFF33]C. Viper, Ulrik, Iaquis, BOSS]]=],
    charCard = [[Cui (C)]],
    deckDescription = [[Custom character by Bluellama1!
Cui © Shueisha Inc.]],
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cR87JEh.png]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://i.imgur.com/fuHt7K1.png]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[04]],
            cardNickname = [[Flash Beam ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[00]],
            cardNickname = [[Bomb Strike ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[02]],
            cardNickname = [[Continuous Energy Bullet ;2 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[01]],
            cardNickname = [[Finger Beam ;1 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[03]],
            cardNickname = [[Exploding Wave ;1 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[05]],
            cardNickname = [[Ah! Lord Frieza! ;7 (U)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[06]],
            cardNickname = [[Dastardly Impact ;6 (U)]], copies = 2, reference = true, bannedInLag = false },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://i.imgur.com/TRoajWC.png]],
        backURL = [[https://i.imgur.com/yQdqiF0.png]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Cui (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], }

    charTable["Culex (Super Mario RPG, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://i.imgur.com/N0K4ik2.png]],
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = [[TW9sZSBLbmlnaHQgfCBQb2xhciBLbmlnaHQgfCBTcGVjdGVyIEtuaWdodCB8IFByb3BlbGxlciBLbmlnaHQgfCBaZXJvbWF0IHwgMA]],
      secretHint = [=[[BB0000]Vanda's herald leads [b]knights[/b] of [b]fire, water, earth,[/b] and [b]wind[/b]![-]
  [FFFFFF33]Mole, Polar, Specter, Propeller, BOSS[-]]=],
      charCard = [[Culex (C)]],
      deckDescription = [[April Fool's boss by PolterGhost!
"His fight mechanics in SMRPG involves him having twice as many turns as you, so I tried to do that in Exceed as well." - PolterGhost
Culex & Super Mario RPG © Nintendo.]],
      deck = {
        { deckID = [[2]], faceURL = [[https://i.imgur.com/HeJoZGu.png]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[02]],
              cardNickname = [[Glare ;7 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[04]],
              cardNickname = [[Corona ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[Diamond Saw ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[05]],
              cardNickname = [[Petal Blast ;4 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Boulder ;2 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[00]],
              cardNickname = [[Meteor Blast ;5 (U)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Dark Star ;3 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[7]],
          faceURL = [[https://i.imgur.com/FdQKEv7.png]],
          backURL = [[https://i.imgur.com/jETzKkh.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Wind Crystal (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[6]],
          faceURL = [[https://i.imgur.com/tihNUAi.png]],
          backURL = [[https://i.imgur.com/wWtcDTD.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Earth Crystal (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[5]],
          faceURL = [[https://i.imgur.com/zouu2EB.png]],
          backURL = [[https://i.imgur.com/wothbwr.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Water Crystal (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[4]],
          faceURL = [[https://i.imgur.com/8Zn9kJO.png]],
          backURL = [[https://i.imgur.com/xW7c9Kw.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Fire Crystal (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/0nHxTKA.png]],
          backURL = [[https://i.imgur.com/lSppaq8.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Culex (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Final Fantasy]], }

    charTable["Culex (Multiplayer) (Super Mario RPG, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://i.imgur.com/N0K4ik2.png]],
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/32,
      secretPassword = {
        [[WmVyb21hdCB8IE1vbGUgS25pZ2h0IHwgUG9sYXIgS25pZ2h0IHwgU3BlY3RlciBLbmlnaHQgfCBQcm9wZWxsZXIgS25pZ2h0IHwgMA==]],
        [[TW9sZSBLbmlnaHQgfCBQb2xhciBLbmlnaHQgfCBTcGVjdGVyIEtuaWdodCB8IFByb3BlbGxlciBLbmlnaHQgfCBaZXJvbWF0IHwgMA==]],
      },
      secretHint = [=[[BB0000]Vanda's herald leads [b]knights[/b] of [b]fire, water, earth,[/b] and [b]wind[/b]![-]
[FFFFFF33]Mole, Polar, Specter, Propeller, Zeromat, BOSS[-]]=],
      charCard = [[Culex (2 Opponents) (C)]],
      deckDescription = [[April Fool's multiplayer boss by PolterGhost!
"His fight mechanics in SMRPG involves him having twice as many turns as you, so I tried to do that in Exceed as well." - PolterGhost
Super Mario RPG © Nintendo.]],
      deck = {
        { deckID = [[8]],
          faceURL = [[https://i.imgur.com/FHTjmPW.png]],
          backURL = [[https://i.imgur.com/FsmEjW3.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Mechanics Reference: Team Leader & Advantage (C)]],
              cardDescription = [[Team Battles]], copies = 1, reference = false, separate = true, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[9]],
          faceURL = [[https://i.imgur.com/AMGIyEZ.png]],
          backURL = [[https://i.imgur.com/VhpWd1J.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Mechanics Reference: Team Actions & Defeated (C)]],
              cardDescription = [[Team Battles]], copies = 2, reference = false, separate = true, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[10]],
          faceURL = [[https://i.imgur.com/P5QNSex.png]],
          backURL = [[https://i.imgur.com/mjt16qm.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Mechanics Reference: Boss (2 Opponents) (C)]],
              cardDescription = [[Team Battles]], copies = 1, reference = false, separate = true, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://i.imgur.com/WqQLNFM.png]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[02]],
              cardNickname = [[Glare ;7 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[04]],
              cardNickname = [[Corona ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[Diamond Saw ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[05]],
              cardNickname = [[Petal Blast ;4 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Boulder ;2 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[00]],
              cardNickname = [[Meteor Blast ;5 (U)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Dark Star ;3 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[7]],
          faceURL = [[https://i.imgur.com/8B60uuD.png]],
          backURL = [[https://i.imgur.com/jETzKkh.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Wind Crystal (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[6]],
          faceURL = [[https://i.imgur.com/XZXtw6J.png]],
          backURL = [[https://i.imgur.com/wWtcDTD.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Earth Crystal (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[5]],
          faceURL = [[https://i.imgur.com/j1rS4sN.png]],
          backURL = [[https://i.imgur.com/wothbwr.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Water Crystal (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[4]],
          faceURL = [[https://i.imgur.com/IJKIumy.png]],
          backURL = [[https://i.imgur.com/xW7c9Kw.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Fire Crystal (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/lZo8TR8.png]],
          backURL = [[https://i.imgur.com/8eIbhnK.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Culex (2 Opponents) (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normalsDeck = { deckID = [[1]], faceURL = [[https://i.imgur.com/uOkQk6Z.jpg]],
        gridWidth = 3, gridHeight = 3,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Grasp ;7 (MPB)(N)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Cross ;6 (MPB)(N)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Assault ;5 (MPB)(N)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Dive ;4 (MPB)(N)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Spike ;3 (MPB)(N)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Sweep ;2 (MPB)(N)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Focus ;1 (MPB)(N)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Block ;0 (MPB)(N)]], copies = 2, reference = true, },
          }, -- end cardList
        }
      }

    charTable["Danica Patrick (Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mgqLC4z.png]],
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = [[QWxpY2UgfCBKdW5vIChFc3BlciBYKSB8IEplbWluYSAoRXNwZXIgWCkgfCBNaW5hdG8gfCAw]],
      secretHint = [=[[BB0000]The [b]Boss Tier Trinity[/b] got [b]a new ride[/b]![-]
[FFFFFF33]Alice, Juno, Jemina, Minato, BOSS[-]]=],
      charCard = [[Danica Patrick (C)]],
      deckDescription = [[Custom character by Moriatti!
Danica Patrick ©, uh, herself, probably?]],
      deck = {
        { deckID = [[4]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RB9oKDS.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2udPstj.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: Transformations & Overdrive (C)]],
              cardDescription = [[Seventh Cross & BlazBlue]], copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uMAYOyE.jpg]],
          gridWidth = 3, gridHeight = 3,
          hiddenBack = true,
          cardList = { { cardID = [[01]],
              cardNickname = [[Jump the Sonic ;6 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Space Storming ;6 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[04]],
              cardNickname = [[Driveby Handstand ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[00]],
              cardNickname = [[Flight Hurteen ;4 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[02]],
              cardNickname = [[Pit Stop ;3 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[05]],
              cardNickname = [[The Queen of Cars ;6 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[A Racecar Named Disaster ;5 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dAcTEXT.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/viyMBKv.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Danica Patrick (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Cursed]], }

    charTable["Dante (from the Devil May Cry™ series) (Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = [[WnNvbHQgfCBac29sdCB8IFpzb2x0IHwgWnNvbHQgfCAw]],
      secretHint = [=[[BB0000]That [b]Seventh Cross antihero[/b] sure looks familiar![-]
[FFFFFF33]Zsolt, Zsolt, Zsolt, Zsolt, BOSS[-]]=],
      charCard = [[Dante (From The Devil May Cry™ Series) (C)]],
      deckDescription = [[Custom character by Bluellama!
Dante and Devil May Cry™ © Capcom]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/d0P6Bba.jpg]],
          gridWidth = 3, gridHeight = 3,
          hiddenBack = true,
          cardList = { { cardID = [[04]],
              cardNickname = [[Ebony & Ivory ;7 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Full Throttle ;6 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[High Time ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[02]],
              cardNickname = [[Million Stab ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[05]],
              cardNickname = [[Royal Revenge ;2 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[00]],
              cardNickname = [[Divine Dragon ;4 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[01]],
              cardNickname = [[Stinger ;3 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UBt9YbV.png]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KEZLk6F.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Dante (from the Devil May Cry™ series) (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Seventh Cross (Alternate)]], }

    charTable["Dark Souls (Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = [[R2FicmVrIHwgUmFjaGVsIEFsdWNhcmQgfCBJYXF1aXMgfCBTcGVjdGVyIEtuaWdodCB8IEFueQ==]],
      secretHint = [=[[00BB00]Who counts as undead? It's a [b]grey[/b] área![-]
[FFFFFF33]Gabrek, Rachel, Iaquis, Specter, ANY]]=],
      charCard = [[The Player Character (C)]],
      deckDescription = [[Custom character by tirankin!
Dark Souls © FromSoftware.]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/azXFDum.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Seize the Day ;8 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[01]],
              cardNickname = [[Dash Through ;7 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[02]],
              cardNickname = [[Transgression ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Wild Slash ;4 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[04]],
              cardNickname = [[Counter ;0 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[05]],
              cardNickname = [[Moonlight Greatsword ;7 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[Divine Blessing ;3 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DlbCVtk.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/L5tNiUX.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[The Player Character (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon]], }

    charTable["Doom Speedrunner (Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://imgur.com/OHOc2Cl.mp4]],
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = [[R2FsZHJlZCB8IFJlbmVhIHwgRmlnaHQgKEEgUm9ib3QgTmFtZWQgRmlnaHQpIHwgTm9lbCBWZXJtaWxsaW9uIHwgQW55]],
      secretHint = [=[[00BB00]Let's practice [b]gun[/b] safety![-]
[FFFFFF33]Galdred, Renea, Fight, Noel, ANY[-]]=],
      --audioCue = [[https://cdn.discordapp.com/attachments/254481795490250754/827052880682680410/d_e1m1.mp3]],
      quoteFunction = function (announcementPlayer)
        broadcastToAll([[NEW GAME]], {1,0.3,0.3})
        Wait.frames(function () announcementPlayer.broadcast([[EPISODE: EXCEED]], {0.8,0.8,0}) end, 60)
        Wait.frames(function () announcementPlayer.broadcast([[SKILL LEVEL: ULTRA-VIOLENCE]], {0.7,0,0}) end, 120)
        Wait.frames(function () broadcastToAll([[NOW ENTERING: ARENA]],{1,0,0}) end, 210)
      end,
      charCard = [[DooM (C)]],
      deckDescription = [[Custom character by PolterGhost!
DOOM © Id Software.]],
      deck = {
        { deckID = [[2]], faceURL = [[https://i.imgur.com/xtJE8Vg.png]],
          gridWidth = 4, gridHeight = 4,
          hiddenBack = true,
          cardList = { { cardID = [[08]],
              cardNickname = [[Ol' Reliable ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[12]],
              cardNickname = [[BOOM!! ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[09]],
              cardNickname = [[Pinpoint Peppering ;4 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[10]],
              cardNickname = [[Blast Radius ;3 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[11]],
              cardNickname = [[Pinky Slicer ;1 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[13]],
              cardNickname = [[Blue Balled ;5 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[14]],
              cardNickname = [[Plasma Tracers ;3 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/HZgZeDH.png]],
          backURL = [[https://imgur.com/H5PFd57.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[DooM (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[DooM]], }

    charTable["Dudes of Hazmat (Dudes of Hazmat, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://i.imgur.com/wTx8sqt.png]],
      legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/16,
      secretPassword = {
        [[UmVuZWEgfCBWaW5jZW50IHwgR2lvdmFubmEgfCBHb2xkbGV3aXMgRGlja2luc29uIHwgQW55]],
        [[UmVuZWEgfCBWaW5jZW50IHwgR29sZGxld2lzIERpY2tpbnNvbiB8IEdpb3Zhbm5hIHwgQW55]],
      },
      secretHint = [=[[00BB00][b]R[/b]eally [b]V[/b]exing [b]G[/b]overnment [b]G[/b]runts![-]
[FFFFFF33]Renea, Vincent, Giovanna, Goldlewis, ANY[-]]=],
      charCard = [[Bad Company (C)]],
      deckDescription = [[Dudes of Hazmat is a fan-made character by Ven!
Dudes of Hazmat © Animation by Drue Langlois.
(The cards aren't animated. The videos are.)]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sBY8iAY.png]],
          gridWidth = 3, gridHeight = 3,
          hiddenBack = true,
          cardList = { { cardID = [[04]],
              cardNickname = [[Mascot Mauler ;7 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[06]],
              cardNickname = [[Righteous Indignation ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[03]],
              cardNickname = [[Trash Grab ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[02]],
              cardNickname = [[DROP-KICK! ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[05]],
              cardNickname = [[Mussel Masher ;2 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Can of Whoop-Ass ;5 (U)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[00]],
              cardNickname = [[Toxic Waste Chase ;4 (U)]], copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6pjeQmJ.png]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qBSfoo0.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Dudes of Hazmat (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
        }, normals = [[Cursed]], }

    charTable["Fortuna (Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/16,
      secretPassword = {
        [[TWlza2EgfCBUb3VybmVsb3VzZSB8IFBvb2t5IChUaGUgUmVkIERyYWdvbiBJbm4pIHwgUGxhdGludW0gdGhlIFRyaW5pdHkgfCBBbnk=]],
        [[VG91cm5lbG91c2UgfCBNaXNrYSB8IFBvb2t5IChUaGUgUmVkIERyYWdvbiBJbm4pIHwgUGxhdGludW0gdGhlIFRyaW5pdHkgfCBBbnk=]],
      },
      secretHint = [=[[00BB00][b]Dogs playing poker[/b] sure rings a [b]bell[/b]!
[FFFFFF33]Miska, Tournelouse, Pooky, Platinum, ANY[-]]=],
      charCard = [[Fortuna (C)]],
      deckDescription = [[Custom character by Andarel!]],
      deck = {
        { deckID = [[2]], faceURL = [[https://i.imgur.com/01O45vy.jpg]],
          gridWidth = 3, gridHeight = 3,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Long Shot ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[05]],
              cardNickname = [[Play Fast ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[04]],
              cardNickname = [[Wild Card ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[03]],
              cardNickname = [[Pocket Aces ;2 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[06]],
              cardNickname = [[Fold ;2 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[02]],
              cardNickname = [[Straight ;7 (U)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Play the Odds ;4 (U)]], copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/g9O3VTw.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9u4LXfy.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Fortuna (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[The Red Dragon Inn]], }

    charTable["Giant Spearman (Warioland, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = [[TmVodGFsaSB8IFZpbmNlbnQgfCBQb29reSAoVGhlIFJlZCBEcmFnb24gSW5uKSB8IFRyZWFzdXJlIEtuaWdodCB8IDA=]],
      secretHint = [=[[BB0000][b]Infamous low tiers[/b] team up to compound their weaknesses!
[FFFFFF33]Nehtali, Vincent, Pooky, Treasure, BOSS[-]]=],
      --audioCue = [[https://cdn.discordapp.com/attachments/487059391116476419/827055396924555314/OOT_Error.wav]],
      charCard = [[Giant Spearman (C)]],
      deckDescription = [[Your Foe is dangerous, be careful!]], announcement = [[† Dangerously Canon! †]],
      deck = {
        { deckID = [[2]], faceURL = [[https://i.imgur.com/wK0Y3PB.png]],
          gridWidth = 3, gridHeight = 3,
          hiddenBack = true,
          cardList = { { cardID = [[02]],
              cardNickname = [[Minigame! ;6 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[04]],
              cardNickname = [[Phoenix Descent ;6 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[Sealed Strike ;6 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[05]],
              cardNickname = [[Self-Slaying Slash ;2 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Rolled Ankle Grab ;3 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[00]],
              cardNickname = [[Another Timeline ;6 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[01]],
              cardNickname = [[The Face Room ;2 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/vnorBHB.png]],
          backURL = [[https://i.imgur.com/YNQLgEC.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Giant Spearman (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Cursed]], }

    charTable["A Gorilla (Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = [[TW9yYXRoaSB8IE1vcmF0aGkgfCBNb3JhdGhpIHwgTW9yYXRoaSB8IDA=]],
      secretHint = [=[[BB0000]The god of war pales before the ape of wrath!
[FFFFFF33]Morathi, Morathi, Morathi, Morathi, BOSS[-]]=],
      charCard = [[A Gorilla (C)]],
      deckDescription = [[Custom character by Bluellama1!]],
      deck = {
        { deckID = [[2]], faceURL = [[https://i.imgur.com/o1X13KH.jpeg]],
          gridWidth = 3, gridHeight = 3,
          hiddenBack = true,
          cardList = { { cardID = [[03]],
              cardNickname = [[Squash ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[02]],
              cardNickname = [[Slam ;2 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[05]],
              cardNickname = [[Punch ;2 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[Smash ;1 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[04]],
              cardNickname = [[Kick ;1 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[01]],
              cardNickname = [[Get Shot And Die ;5 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[00]],
              cardNickname = [[Rustle ;1 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/kF99P10.png]],
          backURL = [[https://i.imgur.com/aOmyeIG.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[A Gorilla (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Red Horizon (Alternate)]], }

    charTable["Julius Belmont (Castlevania, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBackReturnFunction = function ()
        local attackBackList = {
          [[https://i.imgur.com/A8KDKXo.png]], -- Julius is literally Zsolt
          [[https://i.imgur.com/8HyOA5v.png]], -- bishonen oil painting, eclipse
          [[https://i.imgur.com/8XQlZW4.png]], -- Julius, red, howling moon
          [[https://i.imgur.com/tlqtj6r.png]], -- Generic, red eclipse, pixel castle
          [[https://i.imgur.com/BZPsVtK.png]], -- Generic, red moon, castle
          [[https://i.imgur.com/XlKNpVy.png]], -- Generic, blue, simple eclipse
        }
        local attackBackIndex = math.random(1, #attackBackList)
        return attackBackList[attackBackIndex]
      end,
      attackBack = [[https://i.imgur.com/Fc44Twg.png]],
      legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/16,
      secretPassword = [[VmluY2VudCB8IFpzb2x0IHwgVGhlIEJlaGVhZGVkIChEZWFkIENlbGxzKSB8IE51LTEzIHwgQW55]],
      secretHint = [=[[00BB00]Whip 'em into a nu shape!
[FFFFFF33]Vincent, Zsolt, Beheaded, Nu-13, ANY[-]]=],
      charCard = [[Julius Belmont (C)]],
      deckDescription = [[Custom character by Petersonian!
Julius Belmont © Konami.]],
      deck = {
        { deckID = [[4]],
          faceURL = [[https://i.imgur.com/P36xiNG.png]],
          backURL = [[https://i.imgur.com/P36xiNG.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: Critical (C)]],
              copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://i.imgur.com/tFhNXJX.png]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[04]],
              cardNickname = [[Axe Throw ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Whip Crack ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[00]],
              cardNickname = [[Uppercut ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[03]],
              cardNickname = [[Crucifix ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[02]],
              cardNickname = [[Holy Water ;2 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[05]],
              cardNickname = [[Omnia Vanitas ;3 (U)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[06]],
              cardNickname = [[Holy Cross ;2 (U)]], copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/8qtANox.png]],
          backURL = [[https://i.imgur.com/qWps6Lf.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Julius Belmont (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[GBA]], }

    charTable["The Knight (Hollow Knight, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Pr7GxI1.jpg]],
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/32,
      secretPassword = [[TmluZSB0aGUgUGhhbnRvbSB8IEFyYWt1bmUgfCBJYXF1aXMgfCBMaXRjaGkgRmF5ZSBMaW5nIHwgQW55]],
      secretHint = [=[[00BB00]Fakey and the Taximeta really [b]nail[/b]ed it with this custom character![-]
[FFFFFF33]Nine, Arakune, Iaquis, Litchi, ANY[-]]=],
      charCard = [[The Knight (C)]],
      deckDescription = [[The Knight is a fan-made character by Fakey and the Taximeta.
Hollow Knight is © Team Cherry.]],
      deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/RB9oKDS.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            cardDescription = [[Seventh Cross]], copies = 0, reference = true, separate = false, },
        }, -- end cardList
      }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3T6NMlV.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[06]],
            cardNickname = [[Howling Wraiths ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[05]],
            cardNickname = [[World Sense ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[04]],
            cardNickname = [[Monarch Wings ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[03]],
            cardNickname = [[Desolate Dive ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[02]],
            cardNickname = [[Crystal Heart ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[01]],
            cardNickname = [[Descending Dark ;1 (U)]], copies = 2, reference = true, bannedInLag = true },
          { cardID = [[00]],
            cardNickname = [[Shade Soul ;4 (U)]], copies = 2, reference = true, bannedInLag = true },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1693877386908296943/0EE18DC1979CAA609E42CAFC098CD87C8308235A/]],
        backURL = [[https://steamusercontent-a.akamaihd.net/ugc/1693877386908297249/F14EEB417082C76B46286F0D4B4E69972513AE94/]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[The Knight (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
      }, normals = [[Hollow Knight]], }

    charTable["Last Legs (Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/32,
      secretPassword = [[Q2FybCAoQXV0b21hdGEpIHwgUmVtaWxpc3MgfCBMaWx5IHwgRmlnaHQgKEEgUm9ib3QgTmFtZWQgRmlnaHQpIHwgQW55]],
      secretHint = [=[[00BB00]My [b]Windows typewriter[/b] is on its last legs![-]
[FFFFFF33]Carl Swangee, Remiliss, Lily, Fight, ANY[-]]=],
      charCard = [[Last Legs (C)]],
      deckDescription = [[Last Legs is a fan-made character by tirankin, with art by Kat and frames by PolterGhost.]],
      normalsDeck = { cardList = {
          }, -- end cardList
        }, -- end normalsDeck
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TbLeEUE.jpg]],
          gridWidth = 3, gridHeight = 3,
          hiddenBack = true,
          cardList = { { cardID = [[02]],
              cardNickname = [[Backlash Field ;6 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Orbital Blast ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[04]],
              cardNickname = [[Quaking Step ;4 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[05]],
              cardNickname = [[Meteoric Impact ;2 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[Disintegration Ray ;1 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[07]],
              cardNickname = [[Bide ;0 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[00]],
              cardNickname = [[Core Breach ;7 (U)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Re-Entry ;3 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UbSOgcg.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/B4PC2kQ.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Last Legs (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
        }, normals = [[N/A]], }

    charTable["Mega Man (Mega Man, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vGWVuau.png]],
      legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/16,
      secretPassword = { [[TW9yYXRoaSB8IEVua2lkdSB8IEdhYnJlayB8IEF4bCBMb3cgfCAw]], },
      secretHint = [=[[00BB00]Rock is [b]mega[/b] cool![-]
[FFFFFF33]Morathi, Enkidu, Gabrek, Axl Low, BOSS[-]]=],
      charCard = [[Mega Man (C)]],
      deckDescription = [[Custom character by Bluellama!
Mega Man © Capcom]],
      deck = {
        { deckID = [[2]], faceURL = [[https://i.imgur.com/NxJQ2NI.jpeg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Mega Buster ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Top Spin ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[02]],
              cardNickname = [[Thunder Beam ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[03]],
              cardNickname = [[Super Arm ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[04]],
              cardNickname = [[Metal Blade ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[05]],
              cardNickname = [[Super Adapter ;3 (U)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[06]],
              cardNickname = [[Black Hole Bomb ;4 (U)]], copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/eI1AgVQ.png]],
          backURL = [[https://i.imgur.com/dhPPYcs.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Mega Man (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Mega Man]], }

    -- In MissingNo.'s case, I deemed it clearer to omit searchable Speed values for Water Gun.
    charTable["MissingNo. (Pokémon, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/16,
      secretPassword = [[SmVtaW5hIChFc3BlciBYKSB8IEplbWluYSAoRXNwZXIgWCkgfCBKZW1pbmEgKEVzcGVyIFgpIHwgSmVtaW5hIChFc3BlciBYKSB8IEFueQ==]],
      secretHint = [=[[00BB00]There's a Number of characters in the module, but [b]one is Missing from print[/b]![-]
  [FFFFFF33]Jemina, Jemina, Jemina, Jemina, BOSS[-]]=],
      charCard = [[??? (C)]],
      deckDescription = [[Custom character by Andarel!
  Pokémon is © The Pokémon Company.]],
      deck = {
        { deckID = [[4]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4LKTGlc.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9MhEvpJ.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: MissingNo. (C)]],
              cardDescription = [[MissingNo.]], copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mMsCkRv.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Payday ;7 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Water Gun (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[02]],
              cardNickname = [[Bind ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[03]],
              cardNickname = [[Water Gun (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[04]],
              cardNickname = [[Water Gun (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[05]],
              cardNickname = [[Pound ;8 (U)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[06]],
              cardNickname = [[Sky Attack ;1 (U)]], copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Zl1Gv6H.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pXVJmMo.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[??? (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[MissingNo.]], }

    charTable["Noir (Esper X, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = [[U2hvdmVsIEtuaWdodCAoU2hvdmVsIEtuaWdodCkgfCBUaW5rZXIgS25pZ2h0IHwgU2VpanVuIHwgRGV2cmlzIChNYWdlIFdhcnMpIHwgMA==]],
      secretHint = [=[[BB0000]Facing overpowered Boost characters may lead to [b]Post-Testing Stress Disorder[/b]![-]
[FFFFFF33]Shovel Knight, Tinker, Seijun, Devris, BOSS[-]]=],
      charCard = [[rioN (C)]],
      deckDescription = [[Custom character by tirankin. Noir is a parody of Rion, a L99 early access fighter!]],
      deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/id242dc.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Darkest Scarlet ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[01]],
            cardNickname = [[Incendiary Magenta ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[02]],
            cardNickname = [[Corrupt Amber ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[03]],
            cardNickname = [[Prismatic Distortion ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[04]],
            cardNickname = [[Stainless ;2 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[05]],
            cardNickname = [[Whiteout ;5 (U)]], copies = 2, reference = true, bannedInLag = true },
          { cardID = [[06]],
            cardNickname = [[Prima Materia ;5 (U)]], copies = 2, reference = true, bannedInLag = true },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ap3esOD.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UpsHNMg.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[rioN (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
      }, normals = [[Esper Noir]], }

    charTable["Norin the Wary (Magic: The Gathering, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = [[UmFjaGVsIEFsdWNhcmQgfCBVbHJpayB8IFByb3BlbGxlciBLbmlnaHQgfCBIeWRlIHwgMA==]],
      secretHint = [=[[BB0000]It's ruph fighting [b]characters who can Retreat 1 and Strike[/b]![-]
[FFFFFF33]Rachel, Ulrik, Propeller, Hyde, BOSS[-]]=],
      charCard = [[Norin the Wary (C)]],
      deckDescription = [[Custom character by Ven!
Norin & MTG are © Hasbro.]],
      deck = {
        { deckID = [[4]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4g1kDuk.jpg]],
          backURL = [[https://i.imgur.com/4g1kDuk.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Reference: Symbols on Cards (C)]], copies = 0, reference = true, cardDescription = [[Magic: The Gathering]] },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZgtFFlk.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Lightning Elemental ;7 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[01]],
              cardNickname = [[Sabretooth Tiger ;6 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[02]],
              cardNickname = [[Goblin Shrine ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Viscid Lemures ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[04]],
              cardNickname = [[Animate Wall ;1 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[05]],
              cardNickname = [[Jade Statue ;3 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[Lhurgoyf ;1 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1834660136491875084/9B3B08E33A828218773F87699BF2CE5DD71645B6/]],
          backURL = [[https://steamusercontent-a.akamaihd.net/ugc/1834660136491875657/DB4156CAC8AC4821F4752048573E52E423F38D45/]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Norin the Wary (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Magic: The Gathering]], }

    charTable["The Reaper (Megami Tensei, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/32,
      secretPassword = [[U3BlY3RlciBLbmlnaHQgfCBBeGwgTG93IHwgTHVjaXlhIHwgVGVzdGFtZW50IHwgMA==]],
      secretHint = [=[[BB0000]Four scythes. No escape. Endless [b]salt[/b].[-]
[FFFFFF33]Specter Knight, Axl Low, Luciya, Testament, BOSS]]=],
      quoteFunction = function (announcementPlayer)
        broadcastToAll([[It's Death!]], {1,0.2,0.2})
        Wait.frames(function () announcementPlayer.broadcast([[Get out of there!]], {1,0,0}) end, 120)
      end,
      charCard = [[The Reaper (C)]],
      deckDescription = [[Custom character by Bluellama1!
The Reaper is a public domain character.
Persona 3, 4, and 5 are © ATLUS. I think.]],
      deck = {
        { deckID = [[4]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/BTJrSBs.png]],
          backURL = [[https://i.imgur.com/BTJrSBs.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Status Effect: Curse (C)]], copies = 1, reference = true, separate = true, cardDescription = [[Megami Tensei]] },
            }, -- end cardList
        }, -- end subdeck
        { deckID = [[5]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ycNIXot.png]],
          backURL = [[https://i.imgur.com/ycNIXot.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: Status Effects (C)]], copies = 1, reference = true, separate = true, cardDescription = [[Megami Tensei]] },
            }, -- end cardList
        }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://i.imgur.com/AqsjpbZ.png]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[01]],
              cardNickname = [[One Shot Kill ;7 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[02]],
              cardNickname = [[Hellfire ;7 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Glacial Blast ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[00]],
              cardNickname = [[Vile Assault ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[04]],
              cardNickname = [[Deathbound ;1 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[Maeigaon ;6 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[05]],
              cardNickname = [[Megidolaon ;6 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/SquU61Y.png]],
          backURL = [[https://i.imgur.com/T0iDQbj.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[The Reaper (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Seventh Cross (Alternate)]], }

    charTable["Rugal Bernstein (King of Fighters, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Hkh8c1T.jpg]],
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/128,
      secretPassword = [[U2NoYXJsYWNocm90IHwgSGVpaGFjaGkgfCBJZ25peiB8IE51LTEzIHwgMA==]],
      secretHint = [=[[BB0000]You must defeat [b]Shin[/b] Long to stand a chance against the mightiest and most evil boss character ever![-]
  [FFFFFF11]Scharlachrot, Heihachi, Igniz, Nu-13, BOSS[-]]=],
      audioCue = [[https://steamusercontent-a.akamaihd.net/ugc/2432579755729099948/BEE2AC31DA22CCC21F744189F263BCF846311FC2/]],
      charCard = [[Rugal Bernstein (C)]],
      deckDescription = [[Custom character by Bluellama1!]],
      deck = {
        { deckID = [[2]], faceURL = [[https://i.imgur.com/dtEQ5DP.png]],
          gridWidth = 3, gridHeight = 3,
          hiddenBack = true,
          cardList = { { cardID = [[02]],
              cardNickname = [[Genocide Cutter ;7 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[04]],
              cardNickname = [[Reppuken ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[God Press ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[05]],
              cardNickname = [[Dark Barrier ;4 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Kaiser Wave ;3 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[00]],
              cardNickname = [[Gigantic Pressure ;5 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[01]],
              cardNickname = [[Destruction Omega ;3 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/vrPMeTl.png]],
          backURL = [[https://i.imgur.com/EMQdRSs.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Rugal Bernstein (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Rugal]], }

    charTable["Sans (UNDERTALE, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = { [[RW1vZ2luZSB8IEVtb2dpbmUgfCBOb2VsIFZlcm1pbGxpb24gfCBSZW1pbGlzcyB8IDA=]],
        [[RGFuIHwgRGFuIHwgRCdKYW5ldHRlIHwgQXJha3VuZSB8IDA=]] },
      secretHint = [=[[BB0000][b]🎵The 🎵first 🎵four 🎵notes[/b] of MEGALOVANIA are really catchy![-]
  [FFFFFF33]Dan, Dan, D'Janette, Arakune, BOSS[-]]=],
      audioCue = [[https://steamusercontent-a.akamaihd.net/ugc/1666859915892650452/AB1DE195C6FB7E887EC8F4DB1C1DF4A181E64042/]], -- MEGALOVANIA copyright Toby Fox
      quoteFunction = function (announcementPlayer)
        announcementPlayer.broadcast([[* you are REALLY not going to like what happens next.]], {1,1,0})
        Wait.frames(function () announcementPlayer.broadcast([[* You felt your sins crawling on your back.]], {0.8,0.6,0}) end, 180)
        Wait.frames(function () broadcastToAll([[* You feel like you're going to have a bad time.]], {1,0,0}) end, 420)
        playmatStation.call("setMat", {
          clickPlayer = announcementPlayer,
          clickMatName = [[Mettaton&Undyne]],
          clickVariant = 3,
        })
      end,
      missFunction = function ()
        broadcastToAll([[* But nobody came.]], {0,0,0})
      end,
      charCard = [[Sans (C)]],
      deckDescription = [[Custom character by tirankin, graphic design by Moriatti!
      Sans and UNDERTALE are copyright Toby Fox.]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/k4isJP0.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Twinkle ;7 (S)]], copies = 2, reference = true, cardScript = sansAttackScript, bannedInLag = true },
            { cardID = [[01]],
              cardNickname = [[Double Cross ;6 (S)]], copies = 2, reference = true, cardScript = sansAttackScript, bannedInLag = true },
            { cardID = [[02]],
              cardNickname = [[* don't come back. ;5 (S)]], copies = 2, reference = true, cardScript = sansAttackScript, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Weight of Sin ;4 (S)]], copies = 2, reference = true, cardScript = sansAttackScript, bannedInLag = true },
            { cardID = [[04]],
              cardNickname = [[Betrayal ;1 (S)]], copies = 2, reference = true, cardScript = sansAttackScript, bannedInLag = true },
            { cardID = [[05]],
              cardNickname = [[BURN IN HELL. ;4 (U)]], copies = 2, reference = true, cardScript = sansAttackScript, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[MERCY ;6 (U)]], copies = 2, reference = true, cardScript = sansAttackScript, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Kc9R0io.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SxdUAy2.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Sans (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", cardScript = sansCharacterScript, },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Esper X]], }

    charTable["Sagas (Indines, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://i.imgur.com/1ENDiXq.png]],
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      -- Servi: Specter, Enkidu, Rachel, Vincent, Iaquis
      secretPassword = [[Tm9lbCBWZXJtaWxsaW9uIHwgTnUtMTMgfCBKaW4gS2lzYXJhZ2kgfCBIYWt1bWVuIHwgQW55]],
      secretHint = [=[[00BB00][b]the eye of time[/b] beholds [b]her reflection[/b]
  [FF44FF][b]erutuf sih[/b] segduj [b]drows tneicna eht[/b][-]
  [FFFFFF33]Noel, Nu-13, Jin, Hakumen, ANY[-]]=],
      charCard = [[Sagas (C)]],
      deckDescription = [[Custom character by PolterGhost!
  Sagas & Indines © Level 99 Games.]],
      deck = {
        { deckID = [[4]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Il80NAz.jpg]],
          backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: Transformations (C)]], cardDesc = [[Renea]],
              copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://i.imgur.com/jAdJ5gZ.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[05]],
              cardNickname = [[Uncanny Reflection ;5 (S)(S) 5; noitcelfeR ynnacnU]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Repelling Staff ;4 (S)(S) 4; ffatS gnillepeR]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[04]],
              cardNickname = [[Shadow Stalker ;4 (S)(S) 4; reklatS wodahS]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[02]],
              cardNickname = [[Crippling Strike ;3 (S)(S) 3; ekirtS gnilppirC]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[06]],
              cardNickname = [[Blank Slate ;3 (S)(S) 3; etalS knalB]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[00]],
              cardNickname = [[Soul Mirror ;7 (U)(U) 7; rorriM luoS]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Assimilation ;5 (U)(U) 5; noitalimissA]], copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[5]],
          faceURL = [[https://i.imgur.com/ArYdQZn.png]],
          backURL = [[https://i.imgur.com/j4gxuPW.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Moonlit Mirror (C)]],
              copies = 1, reference = false, separate = true,  },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/ULRHkt4.png]],
          backURL = [[https://i.imgur.com/1HDb3zh.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Shadow of Servi (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Seventh Cross (Alternate)]], }

    charTable["Majora (The Legend of Zelda, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1eit82i.png]],
      legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/16,
      secretPassword = { [[RGV2cmlzIChNYWdlIFdhcnMpIHwgQWxpY2UgfCBXYWduZXIgfCBOdS0xMyB8IEFueQ==]],
        [[RGV2cmlzIChNYWdlIFdhcnMpIHwgQWxpY2UgfCBXYWxkc3RlaW4gfCBOdS0xMyB8IEFueQ==]] },
      secretHint = [=[[00BB00]DAWN OF THE FIRST DAY: [b]13[/b] HOURS REMAIN[-]
[FFFFFF33]Devris, Alice, Wagner, Nu-13, ANY[-]]=],
      charCard = [[Majora (C)]],
      deckDescription = [[Custom character by Jungy!
  Skull Kid & Majora © Nintendo.]],
      deck = {
        { deckID = [[2]], faceURL = [[https://i.imgur.com/Xtz7eZv.jpeg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Laser ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[01]],
              cardNickname = [[Lashing Whip ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[02]],
              cardNickname = [[Stomping Lunge ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[03]],
              cardNickname = [[Incarnation Of Majora ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[04]],
              cardNickname = [[Rending Claws ;2 (S)]], copies = 2, reference = true, bannedInLag = false },
            { cardID = [[05]],
              cardNickname = [[Wrath of Majora ;5 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[Moonfall ;2 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/RYDcnUj.png]],
          backURL = [[https://i.imgur.com/g0VA4Bl.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Skull Kid (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Seventh Cross (Alternate)]], }

      charTable["Shin Beheaded (Dead Cells, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
        legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/16,
        secretPassword = { [[VGhlIEJlaGVhZGVkIChEZWFkIENlbGxzKSB8IFRoZSBCZWhlYWRlZCAoRGVhZCBDZWxscykgfCBUaGUgQmVoZWFkZWQgKERlYWQgQ2VsbHMpIHwgVGhlIEJlaGVhZGVkIChEZWFkIENlbGxzKSB8IDA=]], },
        secretHint = [=[[00BB00]What if [b]The Beheaded[/b] had released much earlier?[-]
[FFFFFF33]Beheaded, Beheaded, Beheaded, Beheaded, BOSS[-]]=],
        charCard = [[The Beheaded (C)]],
        deckDescription = [[Fan-made parody by Bluellama and Moriatti!]],
        deck = {
          { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Tx2wIIi.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[03]],
                cardNickname = [[Infantry Bow ;6 (S)]], copies = 2, reference = true, bannedInLag = true, },
              { cardID = [[07]],
                cardNickname = [[Twin Daggers ;6 (S)]], copies = 2, reference = true, bannedInLag = true, },
              { cardID = [[01]],
                cardNickname = [[Dive Attack ;5 (S)]], copies = 2, reference = true, bannedInLag = true, },
              { cardID = [[02]],
                cardNickname = [[Wrenching Whip ;5 (S)]], copies = 2, reference = true, bannedInLag = true, },
              { cardID = [[00]],
                cardNickname = [[Nut Cracker ;3 (S)]], copies = 2, reference = true, bannedInLag = true, },
              { cardID = [[04]],
                cardNickname = [[Assault Shield ;2 (S)]], copies = 2, reference = true, bannedInLag = true, },
              { cardID = [[05]],
                cardNickname = [[Wave of Denial ;7 (U)]], copies = 2, reference = true, bannedInLag = true, },
              { cardID = [[06]],
                cardNickname = [[Phaser ;4 (U)]], copies = 2, reference = true, bannedInLag = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[6]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/L3F9Ud0.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cI6TGjC.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Tactics (C)]], copies = 1, reference = false, separate = true, cardSnap = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[5]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JJBszgP.jpg]],
            backURL = [[https://i.imgur.com/cI6TGjC.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Survival (C)]], copies = 1, reference = false, separate = true, cardSnap = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[4]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CvazfAy.jpg]],
            backURL = [[https://i.imgur.com/cI6TGjC.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Brutality (C)]], copies = 1, reference = false, separate = true, cardSnap = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aGBsbck.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/c5ZfZTR.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[The Beheaded (C)]], copies = 1, reference = false, cardMemo = "nonstackable", bannedInLag = true },
              }, -- end cardList
            }, -- end subdeck
        }, normals = [[Dead Cells]], }

    charTable["Soma Cruz (Castlevania, Fan-Made)"] = { panelGUID = myGUID, season = [[2]], borderColor = { 0, 0, 0, 1},
      attackBackReturnFunction = function ()
        local attackBackList = {
          [[https://i.imgur.com/oMkFuuB.png]], -- Flower, eclipse, castle
          [[https://i.imgur.com/WrSEDLq.png]], -- Soma, girlfriend, two other people
          [[https://i.imgur.com/JLmOPoN.png]], -- yellow
          [[https://i.imgur.com/L0FhlkS.png]], -- Soma, almost monochrome, light blue
          [[https://i.imgur.com/LfJLPNm.png]], -- Soma close-up, sepia
          [[https://i.imgur.com/tlqtj6r.png]], -- Generic, red eclipse, pixel castle
          [[https://i.imgur.com/BZPsVtK.png]], -- Generic, red moon, castle
          [[https://i.imgur.com/XlKNpVy.png]], -- Generic, blue, simple eclipse
        }
        local attackBackIndex = math.random(1, #attackBackList)
        return attackBackList[attackBackIndex]
      end,
      attackBack = [[https://i.imgur.com/w80lBT8.png]],
      legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/16,
      secretPassword = { [[VG91cm5lbG91c2UgfCBOZWh0YWxpIHwgQmFlbGtob3IgfCBEJ0phbmV0dGUgfCBBbnk=]], },
      secretHint = [=[[00BB00]Climb the ranks, raise some hell![-]
[FFFFFF33]Tournelouse, Nehtali, Baelkhor, D'Janette, ANY[-]]=],
      charCard = [[Soma Cruz (C)]],
      deckDescription = [[Custom character by Petersonian!
Castlevania © Konami]],
      deckReturnFunction = function ()
        --[[
          Since each image has seven different cards on it, it makes more sense
          to construct the reference table based on the images, rather than
          based on the individual cards.
          If each image had seven variations of one card, we'd construct the
          reference table based on the cards instead.
        --]]
        local somaSheets = {}
        somaSheets[1] = {
          sheetURL = [[https://i.imgur.com/WmBeVyX.png]],
    			card00 = [[Guts Upper ;7 (S)]],
    			card01 = [[Spear Throw ;4 (S)]],
    			card02 = [[Plasma Blast ;3 (S)]],
    			card03 = [[Claimh Solais ;2 (S)]],
    			card04 = [[Flying Kick ;5 (S)]],
    			card05 = [[Hellfire ;4 (U)]],
    			card06 = [[Inner Spirit ;5 (U)]], }
        somaSheets[2] = {
          sheetURL = [[https://i.imgur.com/o0yg4jG.png]],
    			card00 = [[Pocket Knife ;7 (S)]],
    			card01 = [[Fire Ball ;4 (S)]],
    			card02 = [[Balmung ;3 (S)]],
    			card03 = [[Balore Punch ;2 (S)]],
    			card04 = [[Black Panther ;5 (S)]],
    			card05 = [[Positron Rifle ;4 (U)]],
    			card06 = [[Inner Spirit ;5 (U)]], }
        somaSheets[3] = {
          sheetURL = [[https://i.imgur.com/WAt3q7w.png]],
    			card00 = [[Cagnazzo ;7 (S)]],
    			card01 = [[Gun ;4 (S)]],
    			card02 = [[Longinus ;3 (S)]],
    			card03 = [[Death's Scythe ;2 (S)]],
    			card04 = [[Slide Tackle ;5 (S)]],
    			card05 = [[Evil Gallop ;4 (U)]],
    			card06 = [[Inner Spirit ;5 (U)]], }
        somaSheets[4] = {
          sheetURL = [[https://i.imgur.com/yI27Ixh.png]],
    			card00 = [[Cestus ;7 (S)]],
    			card01 = [[Siren's Spell ;4 (S)]],
    			card02 = [[Stone Beam ;3 (S)]],
    			card03 = [[Final Sword ;2 (S)]],
    			card04 = [[Ogre Rush ;5 (S)]],
    			card05 = [[Legion Laser ;4 (U)]],
    			card06 = [[Inner Spirit ;5 (U)]], }
        somaSheets[5] = {
          sheetURL = [[https://i.imgur.com/6MI4Dmq.png]],
    			card00 = [[Energy Guyser ;7 (S)]], -- [sic]
    			card01 = [[Katana Throw ;4 (S)]],
    			card02 = [[Last Scream ;3 (S)]],
    			card03 = [[Excalibur ;2 (S)]],
    			card04 = [[Kali Rush ;5 (S)]],
    			card05 = [[Dark Inferno ;4 (U)]],
    			card06 = [[Inner Spirit ;5 (U)]], }
        somaSheets[6] = {
          sheetURL = [[https://i.imgur.com/LTuTcZP.jpeg]],
    			card00 = [[Guts Straight ;7 (S)]],
    			card01 = [[Eagle Shot ;4 (S)]],
    			card02 = [[Hrunting ;3 (S)]],
    			card03 = [[Demon Cleaving Holy Sword ;2 (S)]],
    			card04 = [[Magic Vacuum ;5 (S)]],
    			card05 = [[Napalm Flare ;4 (U)]],
    			card06 = [[Inner Spirit ;5 (U)]], }
        somaSheets[7] = {
          sheetURL = [[https://i.imgur.com/43QtGKv.png]],
    			card00 = [[High Jump ;7 (S)]],
    			card01 = [[Bone Toss ;4 (S)]],
    			card02 = [[Piercing Beam ;3 (S)]],
    			card03 = [[Alastor ;2 (S)]],
    			card04 = [[Valmanway ;5 (S)]],
    			card05 = [[Mega Twister ;4 (U)]],
    			card06 = [[Inner Spirit ;5 (U)]], }
        local somaSheet00 = math.random(1, 7)
        local somaSheet01 = math.random(1, 7)
        local somaSheet02 = math.random(1, 7)
        local somaSheet03 = math.random(1, 7)
        local somaSheet04 = math.random(1, 7)
        local somaSheet05 = math.random(1, 7)
        local somaSheet06 = math.random(1, 7)
        deckReturnTable = {
          { deckID = [[10]],
            faceURL = [[https://i.imgur.com/a2iiXr4.png]],
            backURL = [[https://i.imgur.com/a2iiXr4.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                cardDescription = [[Castlevania]], copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
          { deckID = [[2]], faceURL = somaSheets[somaSheet00].sheetURL,
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = somaSheets[somaSheet00].card00, copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
          { deckID = [[3]], faceURL = somaSheets[somaSheet04].sheetURL,
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[04]],
                cardNickname = somaSheets[somaSheet04].card04, copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
          { deckID = [[4]], faceURL = somaSheets[somaSheet01].sheetURL,
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[01]],
                cardNickname = somaSheets[somaSheet01].card01, copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
          { deckID = [[5]], faceURL = somaSheets[somaSheet02].sheetURL,
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[02]],
                cardNickname = somaSheets[somaSheet02].card02, copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
          { deckID = [[6]], faceURL = somaSheets[somaSheet03].sheetURL,
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[03]],
                cardNickname = somaSheets[somaSheet03].card03, copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
          { deckID = [[7]], faceURL = somaSheets[somaSheet06].sheetURL,
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[06]],
                cardNickname = somaSheets[somaSheet06].card06, copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
          { deckID = [[8]], faceURL = somaSheets[somaSheet05].sheetURL,
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[05]],
                cardNickname = somaSheets[somaSheet05].card05, copies = 2, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
          { deckID = [[9]],
            faceURL = [[https://i.imgur.com/vtX4hlT.png]],
            backURL = [[https://i.imgur.com/RitsPO1.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Soma Cruz (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
              }, -- end cardList
            }, -- end subdeck
        }
        return deckReturnTable
      end,
      deck = nil, normals = [[GBA]], }

    charTable["Three Precept Enkidu (Fan-Made)"] = { panelGUID = myGUID, season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1},
      attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/t1HaZBs.jpg]],
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/64,
      secretPassword = [[RW5raWR1IHwgRW5raWR1IHwgRW5raWR1IHwgRW5raWR1IHwgRW5raWR1IHwgRW5raWR1IHwgNg==]],
      secretHint = [=[[4470FF]Precepts all the way down![-]
[FFFFFF33]Enkidu, Enkidu, Enkidu, Enkidu, Enkidu, Enkidu, UN[-]]=],
      charCard = [[Three Precept Enkidu (C)]],
      deckDescription = [[Parody character by Cynder!]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Kcq08Ye.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Three Precept Strike ;5 (S)]], copies = 18, reference = true, bannedInLag = false },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/updlWJD.jpg]],
          backURL = [[https://i.imgur.com/ri2i0MT.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Three Precept Enkidu (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normalsDeck = { deckID = [[1]], faceURL = [[https://i.imgur.com/VnB5fWe.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Grasp, Three Precept ;7 (N)]], copies = 2, reference = false, },
          { cardID = [[01]],
            cardNickname = [[Cross, Three Precept ;6 (N)]], copies = 2, reference = false, },
          { cardID = [[02]],
            cardNickname = [[Assault, Three Precept ;5 (N)]], copies = 2, reference = false, },
          { cardID = [[03]],
            cardNickname = [[Dive, Three Precept ;4 (N)]], copies = 2, reference = false, },
          { cardID = [[04]],
            cardNickname = [[Spike, Three Precept ;3 (N)]], copies = 2, reference = false, },
          { cardID = [[05]],
            cardNickname = [[Sweep, Three Precept ;2 (N)]], copies = 2, reference = false, },
          { cardID = [[06]],
            cardNickname = [[Focus, Three Precept ;1 (N)]], copies = 2, reference = false, },
          { cardID = [[07]],
            cardNickname = [[Block, Three Precept ;0 (N)]], copies = 2, reference = false, },
          }, -- end cardList
        }
      }

    charTable["Tony Hawk (Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = [[R3VpbGUgfCBSZWVzZSB8IEFrdW1hIHwgVGhlIEJlaGVhZGVkIChEZWFkIENlbGxzKSB8IDA=]],
      secretHint = [=[[BB0000][b]GRAB[/b] some air with high-damage shotos![-]
  [FFFFFF33]Guile, Reese, Akuma, Beheaded, BOSS[-]]=],
      charCard = [[Tony Hawk (C)]],
      deckDescription = [[Custom character by Bluellama!
  Tony Hawk ©, uh, himself, probably?]],
      deck = {
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/eDMOWLm.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[02]],
              cardNickname = [[Gymnast Plant ;6 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[00]],
              cardNickname = [[Airwalk to Fakie ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Ollie 540 ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[01]],
              cardNickname = [[FS Hurricane ;3 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[04]],
              cardNickname = [[Stalefish ;2 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[05]],
              cardNickname = [[Kickflip McTwist ;3 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[06]],
              cardNickname = [[The 900 ;0 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MZGTM8I.png]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/F4AU2n8.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Tony Hawk (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Street Fighter]], }

    charTable["Trillion (Trillion: God of Destruction, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/n0iorc0.jpg]],
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/32,
      secretPassword = { [[VGFpc2VpIHwgVG91cm5lbG91c2UgfCBac29sdCB8IEdlb2ZmcmV5IHwgMA==]],
        [[U3lkbmV5ICYgU2VyZW5hIHwgRCdKYW5ldHRlIHwgU2VpanVuIHwgRXVnZW5pYSB8IDA=]],
        [[VGFpc2VpIHwgSWFxdWlzIHwgUmVtaWxpc3MgfCBTeWRuZXkgJiBTZXJlbmEgfCBEJ0phbmV0dGUgfCBVbWluYSB8IE1pbmF0byB8IFRvdXJuZWxvdXNlIHwgWnNvbHQgfCBDZWxpbmthIHwgTHVjaXlhIHwgU3lydXMgfCBTZWlqdW4gfCBFdWdlbmlhIHwgR2FsZHJlZCB8IFJlbmVhIHwgRW1vZ2luZSB8IEdlb2ZmcmV5IHwgMA==]] },
      secretHint = [=[[BB0000]Trillion's a [b]Seventh Cross[/b] styled Boss Tier fighter, and her game is about [b]time marching on[/b]![-]
  [FFFFFF33]Taisei, Tournelouse, Zsolt, Geoffrey[-]]=],
      charCard = [[OverLord of Gluttony, Perpell (C)]],
      deckDescription = [[Custom character by NepNepington!
  Trillion © Idea Factory International.]],
      deck = {
        { deckID = [[4]],
          faceURL = [[https://i.imgur.com/RB9oKDS.jpg]],
          backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: Transformations (C)]],
              cardDescription = [[Seventh Cross]], copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/samSTm7.jpg]],
          gridWidth = 3, gridHeight = 3,
          hiddenBack = true,
          cardList = { { cardID = [[06]],
              cardNickname = [[Eating Frenzy ;7 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[05]],
              cardNickname = [[First Act: The Arrival ;7 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[04]],
              cardNickname = [[Chomp, Chomp! ;7 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[03]],
              cardNickname = [[Last Supper ;4 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[02]],
              cardNickname = [[Let's Eat Together! ;2 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[00]],
              cardNickname = [[Final Act: The End ;6 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[01]],
              cardNickname = [[Second Act: A World in Chaos ;2 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wm1Mhhl.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XLpG90f.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[OverLord of Gluttony, Perpell (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Seventh Cross]], }

    charTable["Ultimate Zangetsu (Bloodstained, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
      attackBack = [[https://steamusercontent-a.akamaihd.net/ugc/1710779437619259447/30215A50FBB328E2033029713DD76A651B9FFBB3/]],
      legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
      secretPassword = [[QmFlbGtob3IgfCBNZWkgTGllbiB8IFpvZXkgfCBHYWJyZWsgfCAw]],
      secretHint = [=[[BB0000]The S1 version of Ultimate Zangetsu is borrowing [b]Zorro's signature move[/b]![-]
  [FFFFFF33]Baelkhor, Mei Lien, Zoey, Gabrek, BOSS[-]]=],
      --audioCue = [[https://cdn.discordapp.com/attachments/254481795490250754/827052877276381224/Fight.mp3]],
      quoteFunction = function (announcementPlayer)
        announcementPlayer.broadcast([[Fight...]], {1,1,0})
        Wait.frames(function() broadcastToAll([[...as if your life depended on it.]],{1,1,0}) end, 60)
      end,
      charCard = [[Zangetsu, Ultimate Swordsman (C)]],
      deckDescription = [[Custom character by PolterGhost!
  Zangetsu © 505 Games.]],
      deck = {
        { deckID = [[2]], faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1710779516255573111/3902E9A8656948FD1E6180A7D85B123C2794F46A/]],
          gridWidth = 4, gridHeight = 4,
          hiddenBack = true,
          cardList = { { cardID = [[12]],
              cardNickname = [[Empty Blade ;7 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[08]],
              cardNickname = [[Blade Shower ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[09]],
              cardNickname = [[Flying Vajra ;4 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[11]],
              cardNickname = [[Wild God's Blade ;3 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[10]],
              cardNickname = [[Eternity ;1 (S)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[13]],
              cardNickname = [[Cleave the Moon ;4 (U)]], copies = 2, reference = true, bannedInLag = true },
            { cardID = [[14]],
              cardNickname = [[Ultimate Sealing ;3 (U)]], copies = 2, reference = true, bannedInLag = true },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1710779516255637267/94D3341411E4F1015716D6B30F6F9DD15224409E/]],
          backURL = [[https://steamusercontent-a.akamaihd.net/ugc/1710779516255637493/980D5AD66BC4CE88D9DB92EC240204ED65634D2B/]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Zangetsu, Ultimate Swordsman (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normals = [[Zangetsu]], }

      charTable["Waldo (Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1}, assetName = [[Waldo]],
        legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/64,
        --secretPassword = [[]],
        --secretHint = [=[]=],
        charCard = [[Wally (C)]],
        deckDescription = [[Custom character by tirankin!
  Where's Wally? (and Where's Waldo?) © Martin Handford.]],
        deck = {
          { deckID = [[4]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Hz47eLi.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/g2IXyWb.jpg]],
            gridWidth = 4, gridHeight = 4,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Jump the Shark ;6 (S)]], copies = 1, reference = true, bannedInLag = false },
              { cardID = [[01]],
                cardNickname = [[Purifying Chime ;6 (S)]], copies = 1, reference = true, bannedInLag = false },
              { cardID = [[02]],
                cardNickname = [[Tuning Satisfaction ;5 (S)]], copies = 3, reference = true, bannedInLag = false },
              { cardID = [[03]],
                cardNickname = [[Barnstorming ;5 (S)]], copies = 1, reference = true, bannedInLag = false },
              { cardID = [[04]],
                cardNickname = [[Drill Through ;5 (S)]], copies = 1, reference = true, bannedInLag = false },
              { cardID = [[05]],
                cardNickname = [[Treasure Hunter ;4 (S)]], copies = 1, reference = true, bannedInLag = false },
              { cardID = [[06]],
                cardNickname = [[Withering Toxin ;3 (S)]], copies = 1, reference = true, bannedInLag = false },
              { cardID = [[07]],
                 cardNickname = [[Called Shot ;3 (S)]], copies = 1, reference = true, bannedInLag = false },
               { cardID = [[08]],
                 cardNickname = [[Explosive Cocktail ;3 (S)]], copies = 1, reference = true, bannedInLag = false },
               { cardID = [[09]],
                 cardNickname = [[Bus Stop ;3 (S)]], copies = 1, reference = true, bannedInLag = false },
               { cardID = [[12]],
                 cardNickname = [[Symphony of the Deep ;7 (U)]], copies = 1, reference = true, bannedInLag = false },
               { cardID = [[13]],
                 cardNickname = [[King of Cards ;6 (U)]], copies = 1, reference = true, bannedInLag = false },
               { cardID = [[14]],
                 cardNickname = [[Distant Lands ;6 (U)]], copies = 1, reference = true, bannedInLag = false },
               { cardID = [[15]],
                 cardNickname = [[Cave In ;1 (U)]], copies = 1, reference = true, bannedInLag = false },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UWBlXE9.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aZPVRBE.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Wally (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
              }, -- end cardList
            }, -- end subdeck
        }, normals = [[The Enchantress]], }

      charTable["Your Opponent Ω (Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
        legal = false, excludeFromRandomAny = false, -- This means they can spawn via Random Any!
        secret = true, secretChance = 1/16,
        secretPassword = [[RGFuIHwgRGFuIHwgRGFuIHwgRGFuIHwgQW55]],
        secretHint = [=[[00BB00]Ever Feel Like Your Opponent Is Playing [b]4D[/b] Chess?[-]
[FFFFFF33]Dan, Dan, Dan, Dan, ANY[-]]=],
        quoteFunction = function (announcementPlayer)
          local randomNumber = 1+math.random(0,1000000)/1000000
          local randomR = math.random(16,255)/255
          local randomG = math.random(10,255)/255
          local randomB = math.random(16,255)/255
          local randomA = math.random(64,255)/255
          broadcastToAll([[Project Ωολ, Version ]]..randomNumber, {randomR,randomG,randomB,randomA})
          Info.name = [[Exceed... Or Is It?]]
          Wait.frames(function() announcementPlayer.broadcast([[‮(.dnuora ekop ot rotide lanretxe na esu uoy fi skrow ylno ekoj sihT)‭]], {randomR,randomG,randomB,randomA}) end, 300)
        end,
        charCard = [[Your Opponent Ω (C)]],
        deckDescription = [[Custom character by tirankin!]],
        normalsDeck = { cardList = {
            }, -- end cardList
          }, -- end normalsDeck
        --[=[
        normalsDeck = { deckID = [[2]], faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1666858288775268975/41AA159F361FFB3CB23D61B3C67F3B4C10B49E28/]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Ω]], cardDescription = [[Ω]], copies = 1, reference = false, bannedInLag = true, cardScript = [[function onLoad() self.destruct() end]] },
            }, -- end cardList
          }, -- end normalsDeck
          --]=]
        deck = {
        { deckID = [[3]],
          faceURL = [[https://i.imgur.com/a0XQ4V5.png]],
          backURL = [[https://i.imgur.com/a0XQ4V5.png]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Your Opponent...? (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", cardSnap = false, cardScript = yourOpponentCharacterScript, },
            }, -- end cardList
          }, -- end subdeck
        }, normals = [[Don't worry, I can handle those myself.]], }

      charTable["Yakumo Yukari (Touhou, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
        attackBack = [[https://steamusercontent-a.akamaihd.net/ugc/1710779437619259447/30215A50FBB328E2033029713DD76A651B9FFBB3/]],
        legal = false, excludeFromRandomAny = true, secret = true, secretChance = 1/16,
        secretPassword = [[V2FsZHN0ZWluIHwgSGFwcHkgQ2hhb3MgfCBBcmFrdW5lIHwgVGFva2FrYSB8IDA=]],
        secretHint = [=[[BB0000]She Who Lurks is up to something, but [b]what[/b]?![-]
[FFFFFF33]Waldstein, Happy Chaos, Arakune, Taokaka, BOSS[-]]=],
        --audioCue = [[https://cdn.discordapp.com/attachments/254481795490250754/827052877276381224/Fight.mp3]],
        quoteFunction = function (announcementPlayer)
          announcementPlayer.broadcast([[Look, I'm here now.]], {1,1,0})
          playmatStation.call("setMat", {
            clickPlayer = announcementPlayer,
            clickMatName = [[shewholurks]],
            --clickVariant = 3,
          })
        end,
        charCard = [[Yakumo Yukari (C)]],
        deckDescription = [[Custom character by Jungy!
Touhou © ZUN.]],
        deck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/1n2yI1l.png]],
            backURL = [[https://i.imgur.com/1n2yI1l.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Mechanics Reference: Yukari (C)]],
                copies = 1, reference = false, separate = true,
                cardScript = [=[function onLoad()
  self.destruct()
end

function onDestroy()
  local myPosition = self.getPosition()
  spawnObjectData({
    data = {
      Name = "Custom_PDF",
      Transform = {
        scaleX = 2.8,
        scaleY = 0.2,
        scaleZ = 2.8,
      },
      CustomPDF = {
        PDFUrl = [[https://steamusercontent-a.akamaihd.net/ugc/2488875930161111749/B30CAC6F6FBAD9E123CF38FDDE2AC2E247911C58/]],
        PDFPassword = "",
        PDFPage = 0,
        PDFPageOffset = 0,
      }
    },
    position = myPosition,
  })
  spawnObjectData({
    data = {
      Name = "Custom_PDF",
      Transform = {
        scaleX = 2.8,
        scaleY = 0.2,
        scaleZ = 2.8,
      },
      CustomPDF = {
        PDFUrl = [[https://steamusercontent-a.akamaihd.net/ugc/2488875930161111749/B30CAC6F6FBAD9E123CF38FDDE2AC2E247911C58/]],
        PDFPassword = "",
        PDFPage = 0,
        PDFPageOffset = 0,
      }
    },
    position = {
      x = myPosition.x,
      y = myPosition.y+1,
      z = myPosition.z,
    },
  })
end]=] },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/UO0j2Is.png]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[03]],
                cardNickname = [[Border of Fighting And Card Games ;5 (S)]], copies = 2, reference = true, bannedInLag = true },
              { cardID = [[04]],
                cardNickname = [[Curse of Dreams of Reality ;4 (S)]], copies = 2, reference = true, bannedInLag = true },
              { cardID = [[02]],
                cardNickname = [[Bewitching Butterfly Living in the Zen Temple ;4 (S)]], copies = 2, reference = true, bannedInLag = true },
              { cardID = [[06]],
                cardNickname = [[Ride the Waves, Fight the Ocean ;3 (S)]], copies = 2, reference = true, bannedInLag = true },
              { cardID = [[05]],
                cardNickname = [[Border of Legal Attack Triggers ;3 (S)]], copies = 2, reference = true, bannedInLag = true },
              { cardID = [[01]],
                cardNickname = [[Boundary of Life and Death ;4 (U)]], copies = 2, reference = true, bannedInLag = true },
              { cardID = [[00]],
                cardNickname = [[Trip to the Old Station ;3 (U)]], copies = 2, reference = true, bannedInLag = true },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://i.imgur.com/UzPcrD5.png]],
            backURL = [[https://i.imgur.com/PORVygU.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Yakumo Yukari (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
              }, -- end cardList
            }, -- end subdeck
        }, normals = [[Cursed]], }




  -- Custom season: Bluellama1's Guilty Gear
  charTable["Ky Kiske (Guilty Gear, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
    legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/16,
    secretPassword = [[SGVpZGkgfCBSeXUgfCBTYWdhdCB8IEppbiBLaXNhcmFnaSB8IEFueQ==]],
    secretHint = [=[[00BB00]He's no [b]bad guy[/b], but he is his [b]counterpart[/b]![-]
[FFFFFF33]Heidi, Ryu, Sagat, Jin, ANY[-]]=],
    charCard = [[Ky Kiske (C)]],
    deckDescription = [[Custom character by Bluellama!
Ky Kiske & Guilty Gear © ARC SYSTEM WORKS]],
    deck = {
      { deckID = [[2]], faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1830155996109061888/EA672E3F5460C8E94F7184E5536ABA52C1C2F28E/]],
        gridWidth = 3, gridHeight = 3,
        hiddenBack = true,
        cardList = { { cardID = [[06]],
            cardNickname = [[Vapor Thrust ;7 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[02]],
            cardNickname = [[Stun Edge ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[04]],
            cardNickname = [[Stun Dipper ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[03]],
            cardNickname = [[Charged Stun Edge ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[05]],
            cardNickname = [[Greed Sever ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[01]],
            cardNickname = [[Sacred Edge ;7 (U)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[00]],
            cardNickname = [[Ride The Lightning ;2 (U)]], copies = 2, reference = true, bannedInLag = false },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1842534970160698801/5EFEC3BF61ECF9B0B1523E97AE090CFCB5000B5E/]],
        backURL = [[https://steamusercontent-a.akamaihd.net/ugc/1842534970160699180/99291BE8936B78801349C181506B024FB2D1B55B/]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Ky Kiske (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross (Alternate)]], }
  --
  charTable["Potemkin (Guilty Gear, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
    legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/16,
    secretPassword = [[TW9yYXRoaSB8IFphbmdpZWYgfCBJcm9uIFRhZ2VyIHwgV2FsZHN0ZWluIHwgQW55]],
    secretHint = [=[[00BB00]These [b]huge dudes[/b] are [b]reaching out[/b] to you![-]
[FFFFFF33]Morathi, Zangief, Tager, Waldstein, ANY[-]]=],
    charCard = [[Potemkin (C)]],
    deckDescription = [[Custom character by Bluellama!
Potemkin & Guilty Gear © ARC SYSTEM WORKS]],
    deck = {
      { deckID = [[2]], faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1842534970160753863/1130350794E6849E2BEE20E0D314FE7D327AEF1A/]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Slidehead ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[01]],
            cardNickname = [[F.D.B. ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[02]],
            cardNickname = [[Potemkin Buster ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[03]],
            cardNickname = [[Heat Knuckle ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[04]],
            cardNickname = [[Hammerfall ;1 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[05]],
            cardNickname = [[Heavenly Potemkin Buster ;3 (U)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[06]],
            cardNickname = [[Giganter ;1 (U)]], copies = 2, reference = true, bannedInLag = false },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1842534970160755790/5DD9DB7A56C69E4C024EC5A2764753A3E0DD38FB/]],
        backURL = [[https://steamusercontent-a.akamaihd.net/ugc/1842534970160756446/213DA64E3187248CB64D3E534C2C538E7D9EDB67/]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Potemkin (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable",
          cardScript = [=[function onLoad() self.use_snap_points = false end]=] },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross (Alternate)]], }
  --
  charTable["Sol Badguy (Guilty Gear, Fan-Made)"] = { panelGUID = myGUID, season = [[0]], borderColor = { 0, 0, 0, 1},
    legal = false, excludeFromRandomAny = false, secret = true, secretChance = 1/16,
    secretPassword = [[UmVlc2UgfCBac29sdCB8IEtlbiB8IFJhZ25hIHRoZSBCbG9vZGVkZ2UgfCBBbnk=]],
    secretHint = [=[[00BB00]Don't feel guilty about maining [b]red shotos[/b]![-]
[FFFFFF33]Reese, Zsolt, Ken, Ragna, ANY[-]]=],
    charCard = [[Sol Badguy (C)]],
    deckDescription = [[Custom character by Bluellama!
Sol Badguy & Guilty Gear © ARC SYSTEM WORKS]],
    deck = {
      { deckID = [[2]], faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1842534970160559616/96C61EF365018E226BD3EEF5E09AFDD7D2E1B817/]],
        gridWidth = 3, gridHeight = 3,
        hiddenBack = true,
        cardList = { { cardID = [[04]],
            cardNickname = [[Sidewinder ;6 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[00]],
            cardNickname = [[Gunflame ;5 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[06]],
            cardNickname = [[Wild Throw ;4 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[03]],
            cardNickname = [[Bandit Bringer ;3 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[05]],
            cardNickname = [[Fafnir ;1 (S)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[01]],
            cardNickname = [[Tyrant Rave ver Beta ;7 (U)]], copies = 2, reference = true, bannedInLag = false },
          { cardID = [[02]],
            cardNickname = [[Dragon Install ;0 (U)]], copies = 2, reference = true, bannedInLag = false },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1842534970160583353/3C2B562CDD3BCD14CECBC90C66FDF72199C35328/]],
        backURL = [[https://steamusercontent-a.akamaihd.net/ugc/1842534970160583609/9B6807EC422E39D3F9789B37BFE134FEDB0A2F99/]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Sol Badguy (C)]], copies = 1, reference = false, bannedInLag = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross (Alternate)]], }
  -- end character table entries

  imageFactor1 = 31.15  -- multiplied by position.x to generate first value in the UI element position string
  imageFactor2 = -31.45 -- multiplied by position.z to generate second value in the UI element position string
  imageFactor3 = 1      -- multiplied by position.y to generate third value in the UI element position string
  btnFactor1 = -0.01 -- multiplied by position.x to set X value for decorative buttons
  btnFactor2 =  0.01   -- multiplied by position.y to set Y value for decorative buttons
  btnFactor3 =  0.01 -- multiplied by position.z to set Z value for decorative buttons
  btnScale = 54 -- used for scale of decorative buttons

  playerToggleIndexList = {
    Red = nil,
    Blue = nil,
    Yellow = nil,
    Green = nil,
    Orange = nil,
    Purple = nil,
    White = nil,
    Teal = nil,
    Pink = nil,
    Brown = nil,
  }

  -- Loop through players to set up Normals toggles.
  for i,thisPlayer in ipairs(allPlayers) do

    local invertColor = Color[thisPlayer]
    invertColor = {
      r = 1-invertColor[1],
      g = 1-invertColor[2],
      b = 1-invertColor[3],
      a = 1,}
    local invertColorString = "rgba("..invertColor.r..","..invertColor.g..","..invertColor.b..","..invertColor.a..")"
    invertColorString = invertColorString.."|"..invertColorString.."|#C8C8C8"

    playerToggleIndexList[thisPlayer] = (#characterStationXmlTable + 1)
    table.insert(characterStationXmlTable, {
      tag = "Toggle",
      attributes = {
        id = thisPlayer..[[ Normals Toggle: Default]],
        colors = invertColorString,
        isOn = true,
        onClick = self.getGUID().."/uiClick_NormalsToggle",
        position = normalsToggleX.." "..normalsToggleZ.." "..normalsToggleY,
        scale = 0.5,
        visibility = thisPlayer,
        allowSwitchOff = false,
      }, -- end attributes for Toggle
    }) -- end Toggle

    self.createButton({
        click_function = 'click_Button',
        function_owner = self,
        width          = btnScale,
        height         = btnScale,
        color          = {0.2, 1, 1, transparencyValue},
        position       = {
          x = tonumber(normalsToggleX)*btnFactor1,
          y = tonumber(normalsToggleY)*btnFactor2,
          z = tonumber(normalsToggleZ)*btnFactor3,
        },
        tooltip        = [[Default
Normals]],
    })

  end -- finish looping through players

  -- Register all the Normals in Character Station.
  for normalsName,normalsTable in pairs(normalsSheets) do
    debugLog{"normalsName (registration call, Character Station): "..normalsName, 5}
    local supportedNormals = {}
    for thisSet,setTable in pairs(normalsTable) do
      supportedNormals[thisSet] = true
    end
    --[=[ Uncomment for remote execution.
    characterStation.call("registerNormals", {
      normalsName = normalsName,
      ownerGUID = self.getGUID(),
      sets = supportedNormals,
    }) --]=]
    -- [=[ Uncomment for local execution.
    registerNormals({
      normalsName = normalsName,
      ownerGUID = myGUID,
      sets = supportedNormals
    }) --]=]
  end -- finish looping through Normals

  -- [=[

  btnScale = 120 -- The buttons we're about to make are larger than the toggle button.

  for charName,thisChar in pairs(charTable) do
    debugLog{ "per-char loop: "..charName, 5, {1,1,1} }

    local seasons = { thisChar.season, }
    if not thisChar.excludeFromRandomAny == true then table.insert(seasons, "Any") end
    if thisChar.legal == true then table.insert(seasons, "Legal") end

    debugLog{"about to register character: "..charName, 5}
    debugLog{" season: "..thisChar.season, 5}
    registerCharacter({
      ownerGUID = self.getGUID(),
      characterName = charName,
      seasons = seasons,
      secretChance = thisChar.secretChance,
      secretPassword = thisChar.secretPassword, -- This might not work when it passes tables.
      active = true,
    })

--[=[   ----------------------------------------------------------------------
    Add a UI element for this character to the table which will be used to set this object's XML.
    This element displays a tooltip that shows a preview of the character.
    It's also the thing which actually catches clicks and activates the spawn function.
--]=]
    -- Determine what border color will be used for this UI element (well, for its tooltip).
    thisChar.borderColor = thisChar.borderColor
    -- If there was neither a character-specific nor a season-wide entry, default to invisible.
    thisChar.borderColor = thisChar.borderColor or { 1, 1, 1, 0 }
    local borderColorString = "rgba("..thisChar.borderColor[1]..","..thisChar.borderColor[2]..","..thisChar.borderColor[3]..","..thisChar.borderColor[4]..")" or "rgba(1,1,1,0)"
    --debugLog{ "borderColorString: "..borderColorString, 3}

    -- If there's a position for the UI element, actually set up and insert the UI element.
    if thisChar.position != nil then
      --debugLog{"inserting systemElement entry for character "..charName, 3}

      -- Determine this UI element's position string.
      local positionTable = {
        x = imageFactor1*thisChar.position.x,
        z = imageFactor2*thisChar.position.z,
        y = imageFactor3*thisChar.position.y,
      }

      -- If this character's tooltip backdrop should be different from usual, use it instead of the blank backdrop.
      local thisTooltip = thisChar.assetTooltip or blankTooltip

      -- Insert the element into the table.
      --debugLog{ "inserting XML for: "..thisChar.assetName, 1, {0,1,1} }
      table.insert(systemElements, {-- Image element.
        id = charName,
        height = 24,
        width = 24,
        position = positionTable,
        rotation = { x = 0, y = 0, z = 0, },
        color = { r = 0, g = 0.7, b = 1, a = transparencyValue, },
        clickable = "true",
        onClick = self.getGUID().."/uiClick_Character",
        tooltip = charName,
        --[[ 2023-08-19: Disabling hover images to attempt to improve load times.
        hoverTooltip = thisTooltip,
        hoverColor = { r = 1, g = 1, b = 1, a = 1, },
        hoverImage = thisChar.assetName,
        --]]
        visibilityString = "Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black",
      }) -- Finish inserting XML table entry.
    elseif charName == [[Waldo (Fan-Made)]] then -- Added for April Fool's 2022

      debugLog{"Waldoing", 3}
      local newWaldoX = math.random(-1100, 1100)
      local newWaldoZ = math.random(-1300, 900)
      local compassX = newWaldoX
      local compassZ = newWaldoZ+860
      local sextantX = newWaldoX-80
      local sextantZ = newWaldoZ

      if compassZ == 0 then compassZ = 0.01 end
      if sextantZ == 0 then sextantZ = 0.01 end

      local waldoCompassAngle = (180 / math.pi) * math.atan( compassX / compassZ )
      local waldoSextantAngle = (180 / math.pi) * math.atan( sextantX / sextantZ )

      waldoCompassAngle = 270 + waldoCompassAngle
      waldoSextantAngle = 270 + waldoSextantAngle

      local newWaldoPosition = {
        x = newWaldoX,
        y = 1,
        z = newWaldoZ
      }

      local waldoCompass = getObjectFromGUID(waldoCompassGUID)
      if waldoCompass != nil then
        local waldoCompassPosition = waldoCompass.getPosition()
        if waldoCompassPosition.x > -36 and waldoCompassPosition.x < -33
        and waldoCompassPosition.z > -1.5 and waldoCompassPosition.z < 1.5 then
          waldoCompass.setRotation({
            x = waldoCompass.getRotation().x,
            y = waldoCompassAngle,
            z = waldoCompass.getRotation().z,
          })
        end
      end
      local waldoSextant = getObjectFromGUID(waldoSextantGUID)
      if waldoSextant != nil then
        local waldoSextantPosition = waldoSextant.getPosition()
        if waldoSextantPosition.x > 33 and waldoSextantPosition.x < 36
        and waldoSextantPosition.z > -8 and waldoSextantPosition.z < -5 then
          waldoSextant.setRotation({
            x = waldoSextant.getRotation().x,
            y = waldoSextantAngle,
            z = waldoSextant.getRotation().z,
          })
        end
      end

      --debugLog{"inserting systemElement for Waldo", 3}
      table.insert(systemElements, {
        id = charName,
        height = 24,
        width = 24,
        active = "true",
        position = newWaldoPosition,
        --position = "-3000 1800 0.5",
        --position = "3000 -4000 0.5",
        rotation = { x = 0, y = 0, z = 0, },
        --scale = "10 60 60",
        color = { r = 0, g = 1, b = 1, a = transparencyValue, },
        clickable = "true",
        onClick = self.getGUID().."/uiClick_Character",
        hoverTooltip = blankTooltip,
        hoverColor = { r = 1, g = 1, b = 1, a = 1, },
        hoverImage = thisChar.assetName,
        visibilityString = "Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black",
      })
      waldoPosition = {
        x = newWaldoX,
        y = 1,
        z = (newWaldoZ)
      }
    end
  end -- Finish looping through charTable.
  debugLog{"finished looping through charTable", 5, {1,1,1}}

  debugLog{"beginning loop through systemElements", 5, {1,1,1}}
  for drawOrder,thisElement in ipairs(systemElements) do
    debugLog{"thisElement.id: "..thisElement.id, 5}
    local imageElementAttributes = {
      id = thisElement.id,
      image = thisElement.image,
      active = thisElement.active,
      height = thisElement.height,
      width = thisElement.width,
      position = thisElement.position.x.." "..thisElement.position.z.." "..thisElement.position.y, -- x z -y
      rotation = thisElement.rotation.x.." "..thisElement.rotation.z.." "..thisElement.rotation.y,
      color = "rgba("..thisElement.color.r..","..thisElement.color.g..","..thisElement.color.b..","..thisElement.color.a..")",
      raycastTarget = thisElement.clickable,
      onClick = thisElement.onClick,
    }
    if thisElement.hoverImage == "Waldo" then
      imageElementAttributes.tooltip = thisElement.hoverTooltip
      imageElementAttributes.tooltipTextColor = "rgba(1,1,1,0)"
      imageElementAttributes.tooltipBorderColor = "rgba(0,0,0,0)"
      imageElementAttributes.tooltipBackgroundColor = "rgba("..thisElement.hoverColor.r..","..thisElement.hoverColor.g..","..thisElement.hoverColor.b..","..thisElement.hoverColor.a..")"
      imageElementAttributes.tooltipBackgroundImage = thisElement.hoverImage
      imageElementAttributes.tooltipPosition = "Above"
      imageElementAttributes.tooltipOffset = "-45"
      imageElementAttributes.visibility = thisElement.visibilityString
    end
      -- 2023-08-19: Disabled hover images to attempt to improve load times.
      -- 2023-08-28: Added hover image processing back in specifically for Waldo.
    table.insert(characterStationXmlTable, {-- Image element.
      tag = "Image",
      attributes = imageElementAttributes, -- end attributes for Image
    })

    -- If applicable, create a decorative button to make the text tooltip show up properly.
    debugLog{" attempting to create decorative button", 5}
    if thisElement.tooltip != nil then
      self.createButton({
          click_function = 'click_Button',
          function_owner = self,
          width          = btnScale,
          height         = btnScale,
          color          = {0.2, 1, 1, transparencyValue},
          position       = {
            x = thisElement.position.x*btnFactor1,
            y = thisElement.position.y*btnFactor2,
            z = thisElement.position.z*btnFactor3,
          },
          tooltip        = thisElement.tooltip,
      })
    end
  end -- finish looping through systemElements
  --]=]

  -- Each character panel should set its own UI elements.
  -- When any of the Normals for that panel are selected, the Character Station adjusts that player's Normals setting. This probably "propagates" a signal out to each panel to update the Normals setting display.
  -- Each panel handles its own UI elements and character table.
  -- Each panel has its own Random button and its own Normals button.
  -- Each panel also registers its characters in the Character Station for use in the Random Any and Random Legal buttons (and the Bag of Lag).
  -- When a panel is hidden, its UI is uninteractable.
  -- When a character is clicked, it sends information to the Character Station.
  -- Universal Normal information is contained in the Character Station.
  -- The Character Station generates the decks/bags using information passed to it.

  --math.randomseed(os.clock())

  self.UI.setXmlTable(characterStationXmlTable)

  if Global.getVar("debugFlag") != true then
    self.interactable = false
  end

end -- end setup



-- This is a dead function. It exists to catch clicks we don't want to do anything.
function click_Button(player, value, id)
end



function deckToHand(obj, name, color)
  obj.setLock(false)
end -- end deckToHand



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
end -- end debugLog



--[=[
deactivateNormals({
  -- Takes one or both parameters.
  normalsName = normalsName, -- string; used to identify a specific Normals entry by name
  ownerGUID = ownerGUID, -- string; used to specify an ownerGUID to match against
})
--]=]
function deactivateNormals(params)
  local normalsName = params.normalsName
  local ownerGUID   = params.ownerGUID

  -- If a specific entry was provided along with ownerGUID, deregister that entry, but only if its ownerGUID matches.
  if type(ownerGUID) == "string" and type(normalsName) == "string" then
    debugLog{"deactivating a single set of Normals <"..normalsName.."> if it matches ownerGUID: "..ownerGUID, 5}
    local entryGUID = registeredNormals[normalsName].ownerGUID
    if ownerGUID == entryGUID then
      deactivateNormals({ normalsName = normalsName })
    end
  -- If an ownerGUID was provided without a specific Normals entry, loop through them all.
  elseif type(ownerGUID) == "string" and type(normalsName) != "string" then
    debugLog{"deactivating all Normals matching ownerGUID: "..ownerGUID, 5}
    for thisNormals,normalsTable in pairs(registeredNormals) do
      deactivateNormals({ normalsName = thisNormals, ownerGUID = ownerGUID, })
    end -- finish looping through all Normal entries
  -- If a specific entry was provided with no ownerGUID, deregister that entry.
  elseif type(ownerGUID) != "string" and type(normalsName) == "string" then
    debugLog{"deactivating a single set of Normals <"..normalsName..">", 5}
    if registeredNormals[normalsName] != nil then
      registeredNormals[normalsName].active = false
      for i,thisPlayer in ipairs(allPlayers) do
        if currentNormalsTable[thisPlayer] == normalsName then
          debugLog{"warning: player "..thisPlayer.."'s Normals have been deactivated; resetting to default", 1, {1,1,0}}
          updatePlayerNormals({
            alternate = true,
            newNormals = [[Default (Alternate)]],
            ownerGUID = self.getGUID(),
            playerColor = thisPlayer,
            updateDropdown = false,
          })
        end
      end -- finish looping through players
    else
      debugLog{"warning: attempt to deactivate <"..normalsName.."> could not find specified Normals in registry", 1, {1,1,0}}
    end
  -- If no specific entry was provided and no ownerGUID was provided, something's wrong.
  elseif type(ownerGUID) != "string" and type(normalsName) != "string" then
    debugLog{"error: deactivateNormals running on non-string value (ownerGUID type "..type(ownerGUID)..", normalsName type "..type(normalsName)..")", 0, {1,0,0}}
    return
  end -- finish type check for input parameters
end -- end deactivateNormals



function getBagData(params)
  local debugLog         = debugLog
  local characterCard    = params.characterCard
  local deckName         = params.deckName
  local deckDescription  = params.deckDescription or charTable[deckName].deckDescription or [[]] -- Usually nil.
  local deckIDOffset     = params.deckIDOffset
  local deckList         = params.deckList
  local characterNormals = params.deckNormals
  local lag              = params.lag or false -- Determines whether the object data is finalized before being returned.
  local normalsScript    = params.deckNormalsScript or [[]]
  local normalsSet       = params.deckNormalsSet or [[Normals]]
  local normalsDeck      = params.deckNormalsDeck -- Overrides any other attempt to set the character's Normals.
  local isCostume        = params.isCostume or false -- Used only to modify the notifications sent to the player.

  local playerColor      = params.playerColor
  local playerReference  = Player[playerColor]

  local alternate        = params.alternate
  if alternate == nil then alternate = false end

  -- Added for April Fool's 2024.
  local glitchMode = Global.getVar("glitchMode")
  if glitchMode == true then
    if alternate == true then alternate = false
    elseif alternate == false then alternate = true
    end
  end

  local playerNormals    = currentNormalsTable[playerColor]
  local currentNormals   = nil

  local alternateNormals = false
  -- Use alternateNormals if the characterNormals is already (Alternate), or if alternate mode is on.
  debugLog{"identifying alternateNormals status", 5, {0,1,0.7}}
  if alternate == true then
    debugLog{"setting alternateNormals to true based on alternate mode flag", 3, {1,0.3,0.7}}
    alternateNormals = true
  elseif type(characterNormals) == [[string]] then
    if string.sub(characterNormals, -12) == [[ (Alternate)]] then
      debugLog{"setting alternateNormals to true based on content of characterNormals", 3, {1,0.3,0.7}}
      alternateNormals = true
    end
  end

  local lockBag          = params.lockBag
  if lockBag == nil then lockBag = true end

  -- These were added later.
  local altattackBack    = params.altbackURL
  local charPosition     = params.deckPosition
  local normalsList      = params.charNormalsList

  local cardColor = {}
  if params.cardColor == nil then
    cardColor[1] = 0.713235259
    cardColor[2] = 0.713235259
    cardColor[3] = 0.713235259
    cardColor[4] = 1
  else
    cardColor[1] = params.cardColor[1]
    cardColor[2] = params.cardColor[2]
    cardColor[3] = params.cardColor[3]
    cardColor[4] = params.cardColor[4]
    if params.cardColor[1] == nil then cardColor[1] = 0.713235259 end
    if params.cardColor[2] == nil then cardColor[2] = 0.713235259 end
    if params.cardColor[3] == nil then cardColor[3] = 0.713235259 end
    if params.cardColor[4] == nil then cardColor[4] = 1 end
  end
  debugLog{"getBagData, cardColor: "..cardColor[1]..","..cardColor[2]..","..cardColor[3]..","..cardColor[4], 4}

  local backURL = params.backURL or [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/igYZhPh.png]]

  -- Use alternate attack back, if available, in alternate mode.
  -- This doesn't interact with alternateUsed or alternateExists because it's just the attack back.
  if alternate == true and altattackBack != nil then
    backURL = altattackBack
  end

  -- The clicks are caught by UI elements, which Grey actually CAN interact with.
  -- Nobody actually expects this, so we should ignore Grey's clicks.
  if playerColor == "Grey" then return end

  local screenRotation = self.getRotation()
  local xPositionOffset = 0
  local zPositionOffset = 0
  local yPositionOffset = 0
  local facingFactor = 1
  if screenRotation.z >= 90 and screenRotation.z < 270 then
    facingFactor = -1
  end

  local charPosition = {}
  charPosition.x = 0
  charPosition.y = 0
  charPosition.z = 0

  if charPosition != nil then
    charPosition.x = charPosition.x or 0
    charPosition.y = charPosition.y or 0
    charPosition.z = charPosition.z or 0
  end

  if screenRotation.y >= 45 and screenRotation.y < 135 then
    xPositionOffset = -1.1*facingFactor*charPosition.z
    yPositionOffset = charPosition.y
    zPositionOffset = -1.1*charPosition.x
  elseif screenRotation.y >= 135 and screenRotation.y < 225 then
    xPositionOffset = -1.1*facingFactor*charPosition.x
    yPositionOffset = facingFactor*charPosition.y
    zPositionOffset = 1.1*charPosition.z
  elseif screenRotation.y >= 225 and screenRotation.y < 315 then
    xPositionOffset = 1.1*facingFactor*charPosition.z
    yPositionOffset = facingFactor*charPosition.y
    zPositionOffset = 1.1*charPosition.x
  elseif screenRotation.y >= 315 or screenRotation.y < 45 then
    xPositionOffset = 1.1*facingFactor*charPosition.x
    yPositionOffset = facingFactor*charPosition.y
    zPositionOffset = -1.1*charPosition.z
  end

  local playerHandTransform = playerReference.getHandTransform() or {
    position = {
      x = xPositionOffset + self.getPosition().x,
      y = 10 + yPositionOffset + self.getPosition().y,
      z = zPositionOffset + self.getPosition().z,
    },
    rotation = self.getRotation(),
  }
  local bagTransform = {
    posX = playerHandTransform.position.x,
    posY = playerHandTransform.position.y,
    posZ = playerHandTransform.position.z,
    scaleX = 0.9,
    scaleY = 0.6,
    scaleZ = 0.9,
  }
  local transformFacingYou = {
    scaleX = 1.25,
    scaleY = 1.0,
    scaleZ = 1.25,
    rotX = 0,
    rotY = (playerHandTransform.rotation.y+180),
    rotZ = 0,
  }
  local transformFacingAway = {
    scaleX = 1.25,
    scaleY = 1.0,
    scaleZ = 1.25,
    rotX = 0,
    rotY = (playerHandTransform.rotation.y),
    rotZ = 0,
  }

  --debugLog{"getBagData: identifying Normals: "..os.time(), 2, {1,0.3,0.3}}
  local normalsSubdeck = {}

  -- If the character explicitly predefines a Normals subdeck, use that.
  --debugLog{ " playerNormals prior to explicit Normals subdeck check: "..playerNormals, 2, {1,1,0} }
  if normalsDeck != nil then
    debugLog{ " unique Normals for "..deckName, 3, {1,1,0} }
    normalsSubdeck = normalsDeck
    currentNormals = deckName
  -- Otherwise, generate a Normals subdeck based on the player's current Normals selection.
  else
    currentNormals,normalsSubdeck = getNormalsSubdeck({
      alternateNormals = alternateNormals,
      playerNormals    = playerNormals,
      isCostume        = isCostume,
      characterNormals = characterNormals,
      normalsScript    = normalsScript,
      normalsSet       = normalsSet,
      playerColor      = playerColor,
      normalsList      = normalsList,
    })
  end -- finish generating normals subdeck

  -- Correct deckID if an offset was given.
  -- Should only be relevant to Bag of Lag and similar formats.
  if deckIDOffset != nil and normalsSubdeck["deckID"] != nil then
    normalsSubdeck["deckID"] = (normalsSubdeck["deckID"] + deckIDOffset)
  end
  --debugLog{ " playerNormals subsequent to explicit Normals subdeck check: "..playerNormals, 2, {1,1,0} }


  --debugLog{ "normals Subdeck value, faceURL: "..normalsSubdeck.faceURL, 1, {0, 1, 0} }

  --debugLog{ "   current Normals: "..playerNormals, 0 }
  --debugLog{ "   normals frontURL: "..normalsSubdeck["faceURL"], 2 }


  --local deckNickname = clickedObject.getName()
  --debugLog{"getBagData: assembling Normals: "..os.time(), 2, {1,0.3,0.3}}
  deckDescription = deckDescription or deckName
  deckDescription = deckDescription..[[

<Normals: ]]..currentNormals..[[>]]
  local deckIDList = {}
  local deckCardList = {}
  local deckCustomDeckList = {}

  local normalIDList = {}
  local normalCardList = {}
  local normalCustomDeckList = {}

  local characterIDList = {}
  local characterCardList = {}
  local characterCustomDeckList = {}

  local nonNormalIDList = {}
  local nonNormalCardList = {}
  local nonNormalCustomDeckList = {}

  local referenceIDList = {}
  local referenceCardList = {}
  local referenceCustomDeckList = {}

  local separateIDList = {}
  local separateCardList = {}
  local separateCustomDeckList = {}

  if normalsSubdeck["deckID"] != nil then
    debugLog{ " normals Subdeck non-loop", 4, {1,1,0,} }
    if deckCustomDeckList[normalsSubdeck["deckID"]] == nil then
      deckCustomDeckList[normalsSubdeck["deckID"]] = {
        FaceURL = normalsSubdeck["faceURL"],
        BackURL = backURL,
        NumWidth = normalsSubdeck["gridWidth"],
        NumHeight = normalsSubdeck["gridHeight"],
        BackIsHidden = normalsSubdeck["hiddenBack"],
        UniqueBack = false,
        Type = 0,
      }
    end
    if normalCustomDeckList[normalsSubdeck["deckID"]] == nil then
      normalCustomDeckList[normalsSubdeck["deckID"]] = {
        FaceURL = normalsSubdeck["faceURL"],
        BackURL = backURL,
        NumWidth = normalsSubdeck["gridWidth"],
        NumHeight = normalsSubdeck["gridHeight"],
        BackIsHidden = normalsSubdeck["hiddenBack"],
        UniqueBack = false,
        Type = 0,
      }
    end
  end -- end 'if normalsSubdeck["deckID"] != nil'

  -- Loop through the Normals and add them to the data table.
  for j,thisNormal in ipairs(normalsSubdeck["cardList"]) do
    --debugLog{ "    normals cardList loop", 2, {0,1,1,} }
    --debugLog{" normals faceURL: "..normalsSubdeck["faceURL"], 2}
    -- 'thisNormal' should be one of the individual cards.
    local copies = thisNormal["copies"]
    if copies == nil then copies = 1 end

    local normalDecals = {}
    if thisNormal["cardDecals"] != nil then
      for key,val in ipairs(thisNormal["cardDecals"]) do
        table.insert(normalDecals, val)
      end
    end

    local normalCardDesc = thisNormal["cardDescription"]
    if normalCardDesc == nil then normalCardDesc = deckName end

    local normalScriptAppendix = thisNormal["cardScript"]
    if normalScriptAppendix == nil then normalScriptAppendix = [[]] end

    --debugLog{ "normalAppendix: "..normalAppendix, 5, {1,0,1}}

    while copies > 0 do
      local normalAppendix = getCardData({
        cardBack        = backURL,
        cardDecals      = normalDecals,
        cardDescription = normalCardDesc,
        cardFace        = normalsSubdeck["faceURL"],
        cardGMNotes     = normalCardDesc.."."..normalsSubdeck["deckID"].."."..thisNormal["cardID"],
        cardNickname    = thisNormal["cardNickname"],
        cardID          = thisNormal["cardID"],
        cardScript      = normalScriptAppendix,
        cardSnap        = true,
        deckID          = normalsSubdeck["deckID"],
        gridWidth       = normalsSubdeck["gridWidth"],
        gridHeight      = normalsSubdeck["gridHeight"],
        hiddenBack      = normalsSubdeck["hiddenBack"],
        tooltip         = normalsSubdeck["tooltip"],
        transform       = transformFacingYou,
      })
      --debugLog{ "        normals per-copy loop", 3, {1,1,1,} }
      if lag != true then
        -- Normal processing.
        if thisNormal["separate"] == true then
          table.insert(separateIDList, normalsSubdeck["deckID"]..thisNormal["cardID"])
          table.insert(separateCardList, normalAppendix)
        else
          table.insert(deckIDList, normalsSubdeck["deckID"]..thisNormal["cardID"])
          table.insert(deckCardList, normalAppendix)
        end -- end 'if thisNormal["separate"] == true'
      elseif thisNormal["bannedInLag"] != true and copies == 1 then
        -- Bag of Lag processing.
        if thisNormal["separate"] == true then
          table.insert(separateIDList, normalsSubdeck["deckID"]..thisNormal["cardID"])
          table.insert(separateCardList, normalAppendix)
        else
          table.insert(normalIDList, normalsSubdeck["deckID"]..thisNormal["cardID"])
          table.insert(normalCardList, normalAppendix)
        end -- end 'if thisCard["separate"] == true'
      end -- end 'if lag != true'
      copies = copies-1
    end -- end per-copy loop
  end -- end per-card Normals loop



  --debugLog{"getBagData: checking URLs: "..os.time(), 2, {1,0.3,0.3}}

  local alternateUsed = false
  local alternateExists = false
  -- Handle each subdeck in the deck list.
  for i,thisSubdeck in ipairs(deckList) do
    --debugLog{ "    subdeck loop", 1 }

    -- Correct deckID if an offset was given.
    -- Should only be relevant to Bag of Lag and similar formats.
    if thisSubdeck["deckID"] != nil and deckIDOffset != nil then
      thisSubdeck["deckID"] = (thisSubdeck["deckID"] + deckIDOffset)
    end

------------Rewrite this section
    local thisCardFace = thisSubdeck["faceURL"]
    local thisCardBack = thisSubdeck["backURL"] or backURL

    -- If alternate mode is on, use the replacement face URL.
    if thisSubdeck["altfaceURL"] != nil then
      alternateExists = true
      if alternate == true then
        thisCardFace = thisSubdeck["altfaceURL"]
        alternateUsed = true
        --debugLog{"       alternate face enabled",1}
      end
    end
    if thisSubdeck["altbackURL"] != nil then
      alternateExists = true
      if alternate == true then
        thisCardBack = thisSubdeck["altbackURL"]
        alternateUsed = true
        --debugLog{"       alternate back enabled",1}
      end
    end
------------------------------
    -- Add the appropriate subdecks to the Custom Deck Lists.
    local deckCustomDeckListSubdeck = {
      FaceURL = thisCardFace,
      BackURL = thisCardBack,
      NumWidth = thisSubdeck["gridWidth"],
      NumHeight = thisSubdeck["gridHeight"],
      BackIsHidden = thisSubdeck["hiddenBack"],
      UniqueBack = false,
      Type = 0,
    }
    if deckCustomDeckList[thisSubdeck["deckID"]] == nil then
      deckCustomDeckList[thisSubdeck["deckID"]] = deckCustomDeckListSubdeck
    end
    if referenceCustomDeckList[thisSubdeck["deckID"]] == nil then
      referenceCustomDeckList[thisSubdeck["deckID"]] = deckCustomDeckListSubdeck
    end
    if separateCustomDeckList[thisSubdeck["deckID"]] == nil then
      separateCustomDeckList[thisSubdeck["deckID"]] = deckCustomDeckListSubdeck
    end
    if nonNormalCustomDeckList[thisSubdeck["deckID"]] == nil then
      nonNormalCustomDeckList[thisSubdeck["deckID"]] = deckCustomDeckListSubdeck
    end
    if characterCustomDeckList[thisSubdeck["deckID"]] == nil then
      characterCustomDeckList[thisSubdeck["deckID"]] = deckCustomDeckListSubdeck
    end

    -- Handle each card in the card list inside this subdeck.
    --debugLog{"getBagData: looping through subdeck cardList: "..os.time(), 2, {1,0.3,0.3}}
    for j,thisCard in ipairs(thisSubdeck["cardList"]) do
      --debugLog{ "      cardList loop", 2 }
      -- 'thisCard' should be one of the individual cards.
      local copies = thisCard["copies"] or 1
      local cardDecals = {}
      if thisCard["cardDecals"] != nil then
        for key,val in ipairs(thisCard["cardDecals"]) do
          table.insert(cardDecals, val)
        end
      end

      local thisCardDesc = thisCard["cardDescription"] or deckName
      local scriptAppendix = thisCard["cardScript"] or [[]]

      local cardTooltip = thisCard["tooltip"]
      local cardNickname = thisCard["cardNickname"]
      local cardCount = "x"..thisCard["copies"]

      -- If it's a reference copy that is also in the deck, remove decals.
      -- Add this card to the reference ID List and Card List if it needs a reference copy.
      if thisCard["reference"] == true and lag != true then
        local refCardTooltip = cardTooltip
        local refCardDesc = thisCardDesc
        local refCardNickname = cardNickname
        if thisCard["copies"] > 0 then
          -- If it's a reference copy that has a nonstandard number of copies in deck, change the tooltip to reflect the number of copies.
          if thisCard["copies"] != 2 then
            refCardTooltip = true
            refCardDesc = thisCard["cardNickname"]
            refCardNickname = cardCount
          end
        end -- if copies > 0
        local referenceCardListAppendix = getCardData({
          cardBack        = thisCardBack,
          cardDecals      = {},
          cardDescription = refCardDesc,
          cardFace        = thisCardFace,
          cardGMNotes     = deckName.."."..thisSubdeck["deckID"].."."..thisCard["cardID"]..".reference",
          cardMemo        = thisCard["cardMemo"],
          cardNickname    = refCardNickname,
          cardID          = thisCard["cardID"],
          cardScript      = scriptAppendix,
          cardSnap        = thisCard["cardSnap"],
          deckID          = thisSubdeck["deckID"],
          gridWidth       = thisSubdeck["gridWidth"],
          gridHeight      = thisSubdeck["gridHeight"],
          hiddenBack      = thisSubdeck["hiddenBack"],
          reference       = true,
          tooltip         = refCardTooltip,
          transform       = transformFacingYou,
        })
        table.insert(referenceIDList, thisSubdeck["deckID"]..thisCard["cardID"])
        table.insert(referenceCardList, referenceCardListAppendix)
      end -- end 'if thiscard["reference"] == true'

      while copies > 0 do
        -- April Fool's 2023
        local glitchMode = Global.getVar("glitchMode")
        if glitchMode == true then
          -- April Fool's 2025
          local melfChance = math.random(1, 2096)
          local debugLevel = Global.getVar("debugLevel")
          if debugLevel > 9 then melfChance = 1 end
          -- As of January 2025, the Marvel wiki reports 2091 appearances for Hulk.
          -- Theoretically, the chance of Melf appearing in Exceed should change as his appearance ratio changes over time.
          if cardNickname == characterCard and melfChance < 6 then
            debugLog{"You're not -", 1}
            scriptAppendix = scriptAppendix..[===[

function onDrop()
  local myObjectData = self.getCustomObject()
  local currentBack = myObjectData.back
  if hasBeenMelfed == nil and currentBack != [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vXY319B.png]] then
    local myXmlTable = self.UI.getXmlTable()
    hasBeenMelfed = true
  -- [==[
    table.insert(myXmlTable, {-- Image element.
      tag = "Image",
      attributes = {
        id = self.getGUID().."MelfButton",
        image = [[MelfButton]],
        active = "true",
        height = 100,
        width = 100,
        position = "0 -100 50", -- x z -y
        rotation = "0 180 180",
        color = "rgba(1,1,1,1)",
        raycastTarget = "true",
        onClick = self.getGUID().."/uiClick_Melf",
        --[=[ Tooltip probably unnecessary here.
        tooltip = [[
.............
.           .
.............]],
        tooltipTextColor = "rgba(1,1,1,0)",
        tooltipBorderColor = "rgba(0,0,0,0)",
        tooltipBackgroundColor = "rgba(1,1,1,1)",
        tooltipBackgroundImage = [[MelfButton]],
        tooltipPosition = "Above",
        tooltipOffset = "-45",
        --]=]
        visibility = "Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black",
      }, -- end attributes for Image
    })
    self.UI.setXmlTable(myXmlTable)
  --]==]
  end -- end 'if hasBeenMelfed == nil'
end -- end onObjectDrop

function uiClick_Melf(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end
  if player.color == [[Grey]] then
    player.broadcast([[Stahp.]])
    return
  end
  local myObjectData = self.getCustomObject()
  myObjectData.back = [[https://i.imgur.com/vXY319B.png]]
  self.setCustomObject(myObjectData)
  self.reload()
end -- end uiClick_Melf
]===]
          end -- end Melf
          if not string.match(cardNickname, '.*% %(C%)$') then
            local glitchDataCorruptionChance = math.random(1, 30)
            if glitchDataCorruptionChance == 1 then
              local glitchDataCorruptionTable = {
                { name = [[Assault]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7mgU5Sy.jpg]], },
                { name = [[Cube Pusher]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KPxLDWI.jpg]], },
                { name = [[Guard]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RvmIVhE.jpg]], },
                { name = [[Kaplow!]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/X14sbcE.jpg]], },
                { name = [[Slam Evil]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/q4HsWdq.jpg]], },
                { name = [[Zzzap!]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NwLuGNw.jpg]], },
                { name = [[Bloodthirst]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8JPJSbn.jpg]], },
                { name = [[Bug Zapper]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AAUa9xv.jpg]], },
                { name = [[Called Shot]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8JvJIHw.jpg]], },
                { name = [[Cat's Cradle]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Mav7HNG.jpg]], },
                { name = [[Eviscerate]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pWMtJz6.jpg]], },
                { name = [[Gunblaze]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/X0MmMFX.jpg]], },
                { name = [[Hydra Helix]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MLaFdC1.jpg]], },
                { name = [[Mantis Strike]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lzj4Nzv.jpg]], },
                { name = [[Nuclear Option]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mszbdvD.jpg]], },
                { name = [[Power Short]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/enDFeYg.jpg]], },
                { name = [[Talon Sweep]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bMGYGrY.jpg]], },
                { name = [[Violent Transgression]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/G1wGoOK.jpg]], },
                { name = [[Axe Kick]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9Xa4734.jpg]], },
                { name = [[Hadoken]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/G9JVXvC.jpg]], },
                { name = [[Metsu Hadoken]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/A2L3Wdf.jpg]], },
                { name = [[Metsu Shoryuken]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CmGhHeW.jpg]], },
                { name = [[Airship Bomber]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8doyaDN.jpg]], },
                { name = [[Aqua Mine]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PXyn6VN.jpg]], },
                { name = [[Barrier Lantern]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NPNvOOx.jpg]], },
                { name = [[Fire Wave]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/k17XLxm.jpg]], },
                { name = [[Flail]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4YiYtDu.jpg]], },
                { name = [[Focus]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ai9g3XY.jpg]], },
                { name = [[Healing Hammer]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IbfiIKz.jpg]], },
                { name = [[High Drive]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4M3EfCV.jpg]], },
                { name = [[Shield Boomerang]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cs6PqKb.jpg]], },
                { name = [[Triple Dose]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Iucx8zy.jpg]], },
                { name = [[All Green]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zkPxAN7.jpg]], },
                { name = [[Break Shot]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JX8Krax.jpg]], },
                { name = [[Con Tenerezza]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZJLCsRi.jpg]], },
                { name = [[Electric Chair]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ySRf06m.jpg]], },
                { name = [[Flash Suppressor]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/avnLvUR.jpg]], },
                { name = [[Full Metal Heavy Weapon]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rYQzr6P.jpg]], },
                { name = [[Patriot Apocalypse]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bwdBIpk.jpg]], },
                { name = [[Spin Kick]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HwdOX4r.jpg]], },
                { name = [[The Ultimate Bang]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XsqUVV9.jpg]], },
                { name = [[Violent Ice]],
                  url = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AaI4tSe.jpg]], },
              }
              local glitchDataCorruptionValue = math.random(1, #glitchDataCorruptionTable)
              table.insert(cardDecals, {
                name = glitchDataCorruptionTable[glitchDataCorruptionValue].name,
                url = glitchDataCorruptionTable[glitchDataCorruptionValue].url,
                position = vector(0, 0.34, 0),
                rotation = vector(90, 180, 0),
                scale = vector(2.146, 3.0675, 1),
                size = 120,
              })
              if lag == false then
                printToColor([[WARNING: Card data appears to be corrupted; restoring ]]..glitchDataCorruptionTable[glitchDataCorruptionValue].name..[[ from backup.]], playerColor, {1,1,0})
              end
            end -- end 'if glitchDataCorruptionChance == 1'
          end -- end 'if not string.match(cardNickname, '.*% %(C%)$')'
        end -- end 'if glitchMode == true'

        local cardListAppendix = getCardData({
          cardBack        = thisCardBack,
          cardDecals      = cardDecals,
          cardDescription = thisCardDesc,
          cardFace        = thisCardFace,
          cardGMNotes     = deckName.."."..thisSubdeck["deckID"].."."..thisCard["cardID"],
          cardMemo        = thisCard["cardMemo"],
          cardNickname    = cardNickname,
          cardID          = thisCard["cardID"],
          cardScript      = scriptAppendix,
          cardSnap        = thisCard["cardSnap"],
          deckID          = thisSubdeck["deckID"],
          gridWidth       = thisSubdeck["gridWidth"],
          gridHeight      = thisSubdeck["gridHeight"],
          hiddenBack      = thisSubdeck["hiddenBack"],
          tooltip         = thisCard["tooltip"],
          transform       = transformFacingYou,
        })
        --debugLog{ "        per-copy loop", 2 }
        if copies == 1 and thisCard["bannedInLag"] != true and lag == true then
          -- Bag of Lag processing.
          cardListAppendix.Description = cardCount.." - "..cardListAppendix.Description
          if cardNickname == characterCard then
            table.insert(characterIDList, thisSubdeck["deckID"]..thisCard["cardID"])
            table.insert(characterCardList, cardListAppendix)
          elseif thisCard["separate"] == true then
            table.insert(separateIDList, thisSubdeck["deckID"]..thisCard["cardID"])
            table.insert(separateCardList, cardListAppendix)
          else
            table.insert(nonNormalIDList, thisSubdeck["deckID"]..thisCard["cardID"])
            table.insert(nonNormalCardList, cardListAppendix)
          end -- end 'if thisCard["separate"] == true'
        else
          -- Normal processing.
          if thisCard["separate"] == true then
            table.insert(separateIDList, thisSubdeck["deckID"]..thisCard["cardID"])
            table.insert(separateCardList, cardListAppendix)
          else
            table.insert(deckIDList, thisSubdeck["deckID"]..thisCard["cardID"])
            table.insert(deckCardList, cardListAppendix)
          end -- end 'if thisCard["separate"] == true'
        end
        copies = copies-1
      end -- end per-copy loop
    end -- end per-card loop
  end -- end per-subdeck loop

  if alternateUsed == true then
    deckName = deckName.." (Alternate)"
  end

  local combinedData = {}

  if lag == true then
    combinedData = {}
    combinedData["normalIDList"] = returnTableCopy(normalIDList)
    combinedData["normalCardList"] = returnTableCopy(normalCardList)
    combinedData["normalCustomDeckList"] = returnTableCopy(normalCustomDeckList)
    combinedData["nonNormalIDList"] = returnTableCopy(nonNormalIDList)
    combinedData["nonNormalCardList"] = returnTableCopy(nonNormalCardList)
    combinedData["nonNormalCustomDeckList"] = returnTableCopy(nonNormalCustomDeckList)
    combinedData["separateIDList"] = returnTableCopy(separateIDList)
    combinedData["separateCardList"] = returnTableCopy(separateCardList)
    combinedData["separateCustomDeckList"] = returnTableCopy(separateCustomDeckList)
    combinedData["characterIDList"] = returnTableCopy(characterIDList)
    combinedData["characterCardList"] = returnTableCopy(characterCardList)
    combinedData["characterCustomDeckList"] = returnTableCopy(characterCustomDeckList)
  else
    combinedData = {
      Name = "Bag",
      Transform = bagTransform,
      Nickname = deckName,
      Description = [[Contains cards for ]]..deckName,
      GMNotes = "",
      Memo = "selfdestruct",
      ColorDiffuse = cardColor,
      Locked = lockBag,
      Grid = true,
      Snap = true,
      IgnoreFoW = false,
      MeasureMovement = false,
      DragSelectable = true,
      Autoraise = true,
      Sticky = true,
      Tooltip = true,
      GridProjection = false,
      HideWhenFaceDown = false,
      Hands = true,
      ContainedObjects = {},
      LuaScript = [==[function onLoad()
    -- Index of the current state.
    currentStateIndex = self.getStateId()
    if currentStateIndex != -1 then
      self.addContextMenuItem([=[[FF33FF]P[-][FF3399]a[-][FF3333]l[-][FF9933]e[-][FFFF33]t[-][99FF33]t[-][33FF33]e[-] [33FF99]S[-][33FFFF]w[-][3399FF]a[-][3333FF]p[-]]=], costumeNotify, true)
    end
  end

  function costumeNotify(playerColor)
    local playerReference = Player[playerColor]
    playerReference.broadcast([[Use the "State" menu to choose a costume!]])
  end]==],
    }
    --[=[ Originally, I wanted to have a context menu item that handled costume swaps itself.
    This ended up being pretty inefficient, since it was deconstructing and reconstructing the object each time.

    function changeCostume(playerColor)
      --printToAll("clicked by "..playerColor)

      -- This includes data on the current state because getData() is comprehensive.
      local currentStateData = self.getData()

      local newObjectData = {}
      local newStatesTable = {}
      local nextStateIndex = nil

      if currentStateData["States"][currentStateIndex+1] == nil then
        nextStateIndex = 1
      else
        nextStateIndex = currentStateIndex+1
      end

      if nextStateIndex == nil then
        -- If none of the states were supposed to be next, then the next one should be the first one.
        nextStateIndex = 1
      end

      -- Get the data for the next state, which will overwrite this object's current state.
      newObjectData = returnTableCopy(currentStateData["States"][nextStateIndex])

      -- Gather the data for the new incarnation of the "States" property.
      newStatesTable = returnTableCopy(currentStateData["States"])

      -- Clear the "States" property of the data so we can turn it into an entry in the new/upcoming "States" property.
      currentStateData["States"] = nil

      -- Remove the next state from the new "States" property (since the "States" table should not contain the current state).
      newStatesTable[nextStateIndex] = nil

      -- Populate the new "States" property with the current state information.
      newStatesTable[currentStateIndex] = returnTableCopy(currentStateData)

      -- Apply the new "States" property to the table which will become the object's new state.
      newObjectData["States"] = newStatesTable

      spawnObjectData({
        data = newObjectData,
        position = self.getPosition(),
        callback_function = function(obj) obj.setLock(false) end,
      })
      self.destruct()

    end

    function returnTableCopy(sourceTable)
      local returnTable = {}
      if sourceTable != nil then
        for key,value in pairs(sourceTable) do
          if type(value) == "table" then
            returnTable[key] = returnTableCopy(value)
          else
            returnTable[key] = value
          end
        end
      else
        return nil
      end
      return returnTable
    end -- end returnTableCopy
    --]=]

    --debugLog{"getBagData: adding reference decks: "..os.time(), 2, {1,0.3,0.3}}
    -- References being listed first should mean they get added to the bottom of the bag.
    local referenceDecal = getReferenceDecal()
    if #referenceIDList != 0 then
      table.insert(combinedData.ContainedObjects, {
        Name = "Deck",
        Transform = transformFacingYou,
        Nickname = deckName..[[ Reference]],
        Description = [[A reference for ]]..deckName..[['s unique attacks]],
        GMNotes = "", Memo = "", ColorDiffuse = cardColor,
        Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
        Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
        DeckIDs = referenceIDList,
        CustomDeck = referenceCustomDeckList,
        ContainedObjects = referenceCardList,
        AttachedDecals = { referenceDecal, },
      })
      table.insert(combinedData.ContainedObjects, {
        Name = "Deck",
        Transform = transformFacingAway,
        Nickname = deckName..[[ Reference]],
        Description = [[A reference for ]]..deckName..[['s unique attacks]],
        GMNotes = "", Memo = "", ColorDiffuse = cardColor,
        Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
        Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
        DeckIDs = referenceIDList,
        CustomDeck = referenceCustomDeckList,
        ContainedObjects = referenceCardList,
        AttachedDecals = { referenceDecal, },
      })
    end -- finish adding (two) references

    --debugLog{ "finished adding references to combinedData table", 3}

    --deckDescription = JSON.encode(deckDescription)

    -- Load the actual character deck in the middle.
    --debugLog{"getBagData: adding main deck: "..os.time(), 2, {1,0.3,0.3}}
    if #deckIDList == 1 then
      -- If there's only one card in the deck, add it as a card, not a deck.
      table.insert(combinedData.ContainedObjects, deckCardList[1])
    elseif #deckIDList != 0 then
      table.insert(combinedData.ContainedObjects, {
        Name = "Deck",
        Transform = transformFacingYou,
        Nickname = deckName,
        Description = deckDescription,
        GMNotes = "", Memo = "", ColorDiffuse = cardColor,
        Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
        Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
        DeckIDs = deckIDList,
        CustomDeck = deckCustomDeckList,
        ContainedObjects = deckCardList,
      })
    end -- finish adding main deck
    --debugLog{ "finished adding main deck to combinedData table", 3}

    -- Adding the separate deck to the end should mean it loads as the topmost item.
    --debugLog{"getBagData: adding separate deck: "..os.time(), 2, {1,0.3,0.3}}
    if #separateIDList == 1 then
      table.insert(combinedData.ContainedObjects, separateCardList[1])
    elseif #separateIDList != 0 then
      table.insert(combinedData.ContainedObjects, {
        Name = "Deck",
        Transform = transformFacingYou,
        Nickname = deckName..[[ Side Cards]],
        Description = [[Cards that begin outside of ]]..deckName..[['s deck]],
        GMNotes = "", Memo = "", ColorDiffuse = cardColor,
        Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
        Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
        DeckIDs = separateIDList,
        CustomDeck = separateCustomDeckList,
        ContainedObjects = separateCardList,
      })
    end -- finish adding side cards

  end -- end 'if lag == true'

  --debugLog{ "finished adding side deck to combinedData table", 3}

  return combinedData,alternateUsed,alternateExists
end -- end getBagData



-- [==========[
--[=[
  getCardData({
    cardColor       = {
      r = --float,
      g = --float,
      b = --float,
      a = --float,
    },
    cardBack        = -- string,
    cardDecals      = -- table,
    cardDescription = -- string,
    cardFace        = -- string,
    cardGMNotes     = -- string,
    cardMemo        = -- string, -- Used for various custom "tags".
    cardNickname    = -- string,
    cardID          = -- string or int,
    cardScript      = -- string,
    cardSnap        = -- string,
    deckID          = -- string or int,
    gridWidth       = -- string or int,
    gridHeight      = -- string or int,
    hiddenBack      = -- boolean,
    reference       = -- boolean,
    tooltip         = -- boolean,
    transform = {
      scaleX = --float,
      scaleY = --float,
      scaleZ = --float,
      rotX   = --float,
      rotY   = --float,
      rotZ   = --float,
    }
  }) -- returns a data table representing a single card
--]=]
function getCardData(params)
  local cardBack        = params.cardBack        or [[]]
  local cardColor       = params.cardColor or {}
    cardColor.r = cardColor.r or 0.713235259
    cardColor.g = cardColor.g or 0.713235259
    cardColor.b = cardColor.b or 0.713235259
    cardColor.a = cardColor.a or 1
  local cardDescription = params.cardDescription or [[]]
  local cardFace        = params.cardFace        or [[]]
  local cardID          = params.cardID          or [[00]]
  local cardGMNotes     = params.cardGMNotes     or [[]]
  local cardMemo        = params.cardMemo
  if cardMemo == nil then
    cardMemo = getCardMemo()
  else
    cardMemo = cardMemo..getCardMemo()
  end
  local cardNickname    = params.cardNickname    or [[]]
  local cardScript      = params.cardScript      or [[]]
  local cardSnap        = params.cardSnap
  if cardSnap == nil then cardSnap = true end
  local cardDecals      = params.cardDecals      or nil
  local deckID          = params.deckID          or 1
  local gridWidth       = params.gridWidth       or 1
  local gridHeight      = params.gridHeight      or 1
  local hiddenBack      = params.hiddenBack
  if hiddenBack == nil then hiddenBack = true end
  local reference       = params.reference       or false
  local tooltip         = params.tooltip         or false
  local transform       = params.Transform or {}
    transform.scaleX = transform.scaleX or 1.25
    transform.scaleY = transform.scaleY or 1.0
    transform.scaleZ = transform.scaleZ or 1.25
    transform.rotX   = transform.rotX   or 0
    transform.rotY   = transform.rotY   or 0
    transform.rotZ   = transform.rotZ   or 0

  local returnData = {
    Name = "Card",
    Transform = {
      scaleX = transform.scaleX,
      scaleY = transform.scaleY,
      scaleZ = transform.scaleZ,
      rotX = transform.rotX,
      rotY = transform.rotY,
      rotZ = transform.rotZ,
    },
    Nickname = cardNickname,
    Description = cardDescription,
    GMNotes = cardGMNotes,
    Memo = cardMemo,
    ColorDiffuse = {
      r = cardColor.r,
      g = cardColor.g,
      b = cardColor.b,
      a = cardColor.a,
    },
    Locked = false,
    Grid = true,
    Snap = cardSnap,
    IgnoreFoW = false,
    MeasureMovement = false,
    DragSelectable = true,
    Autoraise = true,
    Sticky = true,
    Tooltip = tooltip,
    GridProjection = false,
    HideWhenFaceDown = hiddenBack,
    Hands = true,
    CardID = deckID..cardID,
    SidewaysCard = false,
    CustomDeck = {},
    LuaScript = cardScript,
    AttachedDecals = {},
  }

  --debugLog{"cardNickname: "..cardNickname, 5}
  if cardDecals != nil then
    for index,thisDecal in ipairs(cardDecals) do
      --debugLog{" looping through card decals, index "..index, 3}
      local cardDecal = {}
      cardDecal.Transform = {
        posX = thisDecal.position.x,
        posY = thisDecal.position.y,
        posZ = thisDecal.position.z,
        rotX = thisDecal.rotation.x,
        rotY = thisDecal.rotation.y,
        rotZ = thisDecal.rotation.z,
        scaleX = thisDecal.scale.x,
        scaleY = thisDecal.scale.y,
        scaleZ = thisDecal.scale.z,
        --scaleX = 1.92496347,
        --scaleY = 2.75000238,
        --scaleZ = 42.307682
      }
      cardDecal.ColorDiffuse = {
        r = 0.713235259,
        g = 0.713235259,
        b = 0.713235259,
        a = 0.5
      }
      cardDecal.CustomDecal = {
        Name = thisDecal.name,
        ImageURL = thisDecal.url,
        Size = thisDecal.size,
      }
      table.insert(returnData["AttachedDecals"], cardDecal)
    end -- end 'for index,thisDecal in ipairs(cardDecals)'
  end

  --debugLog{"getCardData: adding CustomDeck entry: "..os.time(), 2, {1,0.3,0.3}}

  returnData.CustomDeck[deckID] = {
    FaceURL = cardFace,
    BackURL = cardBack,
    NumWidth = gridWidth,
    NumHeight = gridHeight,
    BackIsHidden = hiddenBack,
    UniqueBack = false,
    Type = 0,
  }

  local refDecal = getReferenceDecal()
  --debugLog{"reference value: "..reference, 2}
  if reference == true then
    --debugLog{"applying reference", 3, {0,1,1}}
    -- Add the reference decal.
    table.insert(returnData["AttachedDecals"], refDecal)
  end -- finish 'if reference == true'
  return returnData
end -- end getCardData
--]==========]



function getCardMemo()
  universalMemoIndex = universalMemoIndex+1
  return universalMemoIndex
end -- end getCardMemo



function getCurrentNormals(params)
  local playerColor = params.playerColor
  return currentNormalsTable[playerColor]
end



function getNormalsBagData(params)
  local debugLog         = debugLog
  local charEntry        = params.charEntry or {}
  local deckName         = params.deckName
  local deckDescription  = params.deckDescription or charTable[deckName].deckDescription or [[]] -- Usually nil.
  local isCostume        = params.isCostume or false -- Used only to modify the notifications sent to the player.
  local characterNormals = params.deckNormals
  local normalsScript    = params.deckNormalsScript or [[]]
  local normalsSet       = params.deckNormalsSet or [[Normals]]
  local normalsDeck      = params.deckNormalsDeck
  local normalsList      = params.charNormalsList
  local playerColor      = params.playerColor
  local playerReference  = Player[playerColor]

  debugLog{"characterNormals: "..characterNormals, 4}

  local alternate        = params.alternate
  if alternate == nil then alternate = false end

  local playerNormals = currentNormalsTable[playerColor]
  local currentNormals = nil

  local alternateNormals = false
  -- Use alternateNormals if the characterNormals are already (Alternate), or if alternate mode is on.
  debugLog{"identifying alternateNormals status", 5, {0,1,0.7}}
  if type(characterNormals) == [[string]] then
    if string.sub(characterNormals, -12) == [[ (Alternate)]] then
      debugLog{"setting alternateNormals to true based on content of characterNormals", 3, {1,0.3,0.7}}
      alternateNormals = true
    elseif alternate == true then
      debugLog{"setting alternateNormals to true based on alternate mode flag", 3, {1,0.3,0.7}}
      alternateNormals = true
    end
  end

  local lockBag         = params.lockBag
  if lockBag == nil then lockBag = true end

  local cardColor = {}
  cardColor[1] = params.cardColor[1] or 0.713235259
  cardColor[2] = params.cardColor[2] or 0.713235259
  cardColor[3] = params.cardColor[3] or 0.713235259
  cardColor[4] = params.cardColor[4] or 1

  local backURL = params.backURL or [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/igYZhPh.png]]

  -- Use alternate attack back, if available and specified.
  -- This doesn't interact with alternateUsed or alternateExists because it's just the attack back.
  if alternateBack == true and charEntry.altattackBack != nil then
    backURL = charEntry.altattackBack
  end

  -- The clicks are caught by UI elements, which Grey actually CAN interact with.
  -- Nobody actually expects this, so we should ignore Grey's clicks.
  if playerColor == "Grey" then return end

  local screenRotation = self.getRotation()
  local xPositionOffset = 0
  local zPositionOffset = 0
  local yPositionOffset = 0
  local facingFactor = 1
  if screenRotation.z >= 90 and screenRotation.z < 270 then
    facingFactor = -1
  end

  local charPosition = {}
  charPosition.x = 0
  charPosition.y = 0
  charPosition.z = 0

  if charEntry.position != nil then
    charPosition.x = charEntry.position.x or 0
    charPosition.y = charEntry.position.y or 0
    charPosition.z = charEntry.position.z or 0
  end

  if screenRotation.y >= 45 and screenRotation.y < 135 then
    xPositionOffset = -1.1*facingFactor*charPosition.z
    yPositionOffset = charPosition.y
    zPositionOffset = -1.1*charPosition.x
  elseif screenRotation.y >= 135 and screenRotation.y < 225 then
    xPositionOffset = -1.1*facingFactor*charPosition.x
    yPositionOffset = facingFactor*charPosition.y
    zPositionOffset = 1.1*charPosition.z
  elseif screenRotation.y >= 225 and screenRotation.y < 315 then
    xPositionOffset = 1.1*facingFactor*charPosition.z
    yPositionOffset = facingFactor*charPosition.y
    zPositionOffset = 1.1*charPosition.x
  elseif screenRotation.y >= 315 or screenRotation.y < 45 then
    xPositionOffset = 1.1*facingFactor*charPosition.x
    yPositionOffset = facingFactor*charPosition.y
    zPositionOffset = -1.1*charPosition.z
  end

  local playerHandTransform = playerReference.getHandTransform() or {
    position = {
      x = xPositionOffset + self.getPosition().x,
      y = 10 + yPositionOffset + self.getPosition().y,
      z = zPositionOffset + self.getPosition().z,
    },
    rotation = self.getRotation(),
  }
  local bagTransform = {
    posX = playerHandTransform.position.x,
    posY = playerHandTransform.position.y,
    posZ = playerHandTransform.position.z,
    scaleX = 0.9,
    scaleY = 0.6,
    scaleZ = 0.9,
  }
  local transformFacingYou = {
    scaleX = 1.25,
    scaleY = 1.0,
    scaleZ = 1.25,
    rotX = 0,
    rotY = (playerHandTransform.rotation.y+180),
    rotZ = 0,
  }
  local transformFacingAway = {
    scaleX = 1.25,
    scaleY = 1.0,
    scaleZ = 1.25,
    rotX = 0,
    rotY = (playerHandTransform.rotation.y),
    rotZ = 0,
  }

  --debugLog{"getNormalsBagData: identifying Normals: "..os.time(), 5, {1,0.3,0.3}}
  local normalsSubdeck = {}

  -- If the character explicitly predefines a Normals subdeck, use that.
  --debugLog{ " currentNormals prior to explicit Normals subdeck check: "..currentNormals, 2, {1,1,0} }
  --debugLog{ " player Normals prior to explicit Normals subdeck check: "..currentNormalsTable[playerColor], 2, {1,1,0} }
  if normalsDeck != nil then
    debugLog{ " unique Normals for "..deckName, 3, {1,1,0} }
    normalsSubdeck = normalsDeck
    currentNormals = deckName
  -- Otherwise, generate a Normals subdeck based on the player's current Normals selection.
  else
    currentNormals,normalsSubdeck = getNormalsSubdeck({
      alternateNormals = alternateNormals,
      playerNormals    = playerNormals,
      isCostume        = isCostume,
      characterNormals = characterNormals,
      normalsScript    = normalsScript,
      normalsSet       = normalsSet,
      playerColor      = playerColor,
      normalsList      = normalsList,
    })
  end -- finish generating normals subdeck
  --debugLog{ " currentNormals subsequent to explicit Normals subdeck check: "..currentNormals, 2, {1,1,0} }
  --debugLog{ " player Normals subsequent to explicit Normals subdeck check: "..currentNormalsTable[playerColor], 2, {1,1,0} }

  --debugLog{ "normals Subdeck value, faceURL: "..normalsSubdeck.faceURL, 1, {0, 1, 0} }

  --debugLog{ "   current Normals: "..currentNormals, 0 }
  --debugLog{ "   normals frontURL: "..normalsSubdeck["faceURL"], 2 }

  --local deckNickname = clickedObject.getName()
  --debugLog{"getBagData: assembling Normals: "..os.time(), 2, {1,0.3,0.3}}
  deckName = [[<Normals: ]]..currentNormals..[[>]]
  deckDescription = [[<Normals: ]]..currentNormals..[[>]]
  local deckIDList = {}
  local deckCardList = {}
  local deckCustomDeckList = {}

  local separateIDList = {}
  local separateCardList = {}
  local separateCustomDeckList = {}

  if normalsSubdeck["deckID"] != nil then
    --debugLog{ " normals Subdeck non-loop", 1, {1,1,0,} }
    if deckCustomDeckList[normalsSubdeck["deckID"]] == nil then
      deckCustomDeckList[normalsSubdeck["deckID"]] = {
        FaceURL = normalsSubdeck["faceURL"],
        BackURL = backURL,
        NumWidth = normalsSubdeck["gridWidth"],
        NumHeight = normalsSubdeck["gridHeight"],
        BackIsHidden = normalsSubdeck["hiddenBack"],
        UniqueBack = false,
        Type = 0,
      }
    end
  end -- end 'if normalsSubdeck["deckID"] != nil'

  -- Loop through the Normals and add them to the data table.
  for j,thisNormal in ipairs(normalsSubdeck["cardList"]) do
    --debugLog{ "    normals cardList loop", 2, {0,1,1,} }
    --debugLog{" normals faceURL: "..normalsSubdeck["faceURL"], 2}
    -- 'thisNormal' should be one of the individual cards.
    local copies = thisNormal["copies"] or 1
    local normalDecals = {}
    if thisNormal["cardDecals"] != nil then
      for key,val in ipairs(thisNormal["cardDecals"]) do
        table.insert(normalDecals, val)
      end
    end
    local normalCardDesc = thisNormal["cardDescription"] or deckName
    local normalScriptAppendix = thisNormal["cardScript"] or [[]]
    local normalAppendix = getCardData({
      cardBack        = backURL,
      cardDecals      = normalDecals,
      cardDescription = normalCardDesc,
      cardFace        = normalsSubdeck["faceURL"],
      cardGMNotes     = normalCardDesc.."."..normalsSubdeck["deckID"].."."..thisNormal["cardID"],
      cardNickname    = thisNormal["cardNickname"],
      cardID          = thisNormal["cardID"],
      cardScript      = normalScriptAppendix,
      cardSnap        = true,
      deckID          = normalsSubdeck["deckID"],
      gridWidth       = normalsSubdeck["gridWidth"],
      gridHeight      = normalsSubdeck["gridHeight"],
      hiddenBack      = normalsSubdeck["hiddenBack"],
      tooltip         = normalsSubdeck["tooltip"],
      transform       = transformFacingYou,
    })

    --debugLog{ "normalAppendix: "..normalAppendix, 5, {1,0,1}}

    while copies > 0 do
      --debugLog{ "        normals per-copy loop", 3, {1,1,1,} }
      if thisNormal["separate"] == true then
        table.insert(separateIDList, normalsSubdeck["deckID"]..thisNormal["cardID"])
        table.insert(separateCardList, normalAppendix)
      else
        table.insert(deckIDList, normalsSubdeck["deckID"]..thisNormal["cardID"])
        table.insert(deckCardList, normalAppendix)
      end -- end if then statement
      copies = copies-1
    end -- end per-copy loop
  end -- end per-card Normals loop

  local combinedData = {
    Name = "Bag",
    Transform = bagTransform,
    Nickname = deckName,
    Description = [[Contains Normals as spawned for ]]..deckName,
    GMNotes = "",
    Memo = "selfdestruct",
    ColorDiffuse = cardColor,
    Locked = lockBag,
    Grid = true,
    Snap = true,
    IgnoreFoW = false,
    MeasureMovement = false,
    DragSelectable = true,
    Autoraise = true,
    Sticky = true,
    Tooltip = true,
    GridProjection = false,
    HideWhenFaceDown = false,
    Hands = true,
    ContainedObjects = {},
  }

  --debugLog{"getBagData: adding main deck: "..os.time(), 2, {1,0.3,0.3}}
  if #deckIDList == 1 then
    -- If there's only one card in the deck, add it as a card, not a deck.
    table.insert(combinedData.ContainedObjects, deckCardList[1])
  elseif #deckIDList != 0 then
    table.insert(combinedData.ContainedObjects, {
      Name = "Deck",
      Transform = transformFacingYou,
      Nickname = deckName,
      Description = deckDescription,
      GMNotes = "", Memo = "", ColorDiffuse = cardColor,
      Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
      Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
      DeckIDs = deckIDList,
      CustomDeck = deckCustomDeckList,
      ContainedObjects = deckCardList,
    })
  end -- finish adding main deck
  --debugLog{ "finished adding main deck to combinedData table", 3}

  -- Adding the separate deck to the end should mean it loads as the topmost item.
  --debugLog{"getBagData: adding separate deck: "..os.time(), 2, {1,0.3,0.3}}
  if #separateIDList == 1 then
    table.insert(combinedData.ContainedObjects, separateCardList[1])
  elseif #separateIDList != 0 then
    table.insert(combinedData.ContainedObjects, {
      Name = "Deck",
      Transform = transformFacingYou,
      Nickname = deckName..[[ Side Cards]],
      Description = [[Cards that begin outside of ]]..deckName..[['s deck]],
      GMNotes = "", Memo = "", ColorDiffuse = cardColor,
      Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
      Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
      DeckIDs = separateIDList,
      CustomDeck = separateCustomDeckList,
      ContainedObjects = separateCardList,
    })
  end -- finish adding side cards

  --debugLog{ "finished adding side deck to combinedData table", 3}

  return combinedData
end -- end getNormalsBagData



function getNormalsSubdeck(params)
  local characterNormals       = params.characterNormals
  local characterNormalsScript = params.normalsScript
  local normalsSet             = params.normalsSet
  local playerColor            = params.playerColor
  local playerReference        = Player[playerColor]
  local playerNormals          = params.playerNormals
  local alternateNormals       = params.alternateNormals
  local isCostume              = params.isCostume
  local normalsSubdeck         = {}

  local normalsList            = params.normalsList
  if normalsList == nil then
    debugLog{ "no normalsList provided; assuming default set", 3, {1,1,0} }
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Assault]], [[Assault]], [[Dive]], [[Dive]], [[Spike]], [[Spike]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], }
  end

  local currentNormals = nil

  -- If the 'alternateNormals' parameter is not supplied, set it to true if the player's current Normals are alternate.
  if alternateNormals == nil then
    if type(playerNormals) == [[string]] then
      if string.sub(playerNormals, -12) == [[ (Alternate)]] then
        alternateNormals = true
      end
    end
  end -- finish checking alternateNormals status

  -- Normals precedence is as follows:
  -- 1. Player-set Normals, unless they are set to "Default" or "Default (Alternate)".
  -- 2. Character-specific Normals, if they exist.
  -- 3. "Seventh Cross"

  debugLog{ " current normalsSet: "..normalsSet, 4 } -- e.g., UNNormal

  -- Precedence check for player Normals.
  if playerNormals != nil and playerNormals != [[Default]] and playerNormals != [[Default (Alternate)]] then
    debugLog{"player Normals are set and non-default", 3, {0,1,1}}
    if registeredNormals[playerNormals] != nil then
      debugLog{"   registeredNormals check passed (player Normals are registered)", 5}
      -- Verify that the requisite Normals set exists for the specified Normals.
      local normalsPanelGUID = registeredNormals[playerNormals].ownerGUID
      if registeredNormals[playerNormals].sets[normalsSet] == nil then
        if isCostume == false then playerReference.broadcast("Warning: <"..playerNormals.."> does not support ("..normalsSet..")", {1,1,0}) end
        debugLog{"   warning: player Normals validation failure (player Normals entry exists, but does not include the specified Normals set)", 0, {1,1,0}}
        --playerNormals = nil
      elseif registeredNormals[playerNormals].active != true or panels[normalsPanelGUID].active != true then
        if isCostume == false then playerReference.broadcast("Warning: <"..playerNormals.."> (or its panel) is inactive", {1,1,0}) end
        debugLog{"   warning: player Normals validation failure (player Normals entry exists, but it or its corresponding panel is inactive)", 0, {1,1,0}}
        --playerNormals = nil
      else
        debugLog{"   player Normals validation success (player Normals entry exists and includes the specified Normals set)", 4}
        currentNormals = playerNormals
      end
    else
      debugLog{"warning: registeredNormals check failed (player Normals are not registered)", 1, {1,1,0}}
    end
  -- Precedence check for character-specific Normals.
  else
    debugLog{"player Normals are not set, or are set to defaults", 5}
    debugLog{"applying default: character-specific Normals", 4}

    local characterNormalsBase = characterNormals
    local characterNormalsAlternate = characterNormals
    local characterAlternateAvailable = false
    local characterBaseAvailable = true
    debugLog{" character-specific Normals: "..characterNormals, 2}

    -- If the specified Normals already have the alternate suffix, determine the base.
    if string.sub(characterNormals, -12) == [[ (Alternate)]] then
      characterNormalsBase = string.sub(characterNormals, 1, (string.len(characterNormals)-12))
      if alternateNormals == nil then alternateNormals = true end
    -- Otherwise, determine the alternate version.
    else
      characterNormalsAlternate = characterNormals..[[ (Alternate)]]
    end

    if alternateNormals == nil then alternateNormals = false end

    -- If the alternate does not exist, reject its usage.
    if registeredNormals[characterNormalsAlternate] == nil then
      debugLog{"   warning: alternate does not exist", 0, {1,1,0}}
      characterAlternateAvailable = false
    else
      -- Verify that the requisite Normals set exists for the specified Normals.
      local normalsPanelGUID = registeredNormals[characterNormalsAlternate].ownerGUID
      if registeredNormals[characterNormalsAlternate].sets[normalsSet] == nil then
        if alternateNormals == true and isCostume == false then playerReference.broadcast("Warning: <"..characterNormalsAlternate.."> does not support ("..normalsSet..")", {1,1,0}) end
        debugLog{"   warning: alternate validation failure (alternate exists, but does not include the specified Normals set)", 0, {1,1,0}}
        characterAlternateAvailable = false
      elseif registeredNormals[characterNormalsAlternate].active != true or panels[normalsPanelGUID].active != true then
        if alternateNormals == true and isCostume == false then playerReference.broadcast("Warning: <"..characterNormalsAlternate.."> (or its panel) is inactive", {1,1,0}) end
        debugLog{"   warning: alternate validation failure (alternate exists, but it or its corresponding panel is inactive)", 0, {1,1,0}}
        characterAlternateAvailable = false
      else
        debugLog{"   alternate validation success (alternate exists and includes the specified Normals set)", 4}
        characterAlternateAvailable = true
      end
    end

    -- If the base form does not exist, reject its usage.
    if registeredNormals[characterNormalsBase] == nil then
      debugLog{"   warning: base does not exist", 0, {1,1,0}}
      characterBaseAvailable = false
    else
      -- Verify that the requisite Normals set exists for the specified Normals.
      local normalsPanelGUID = registeredNormals[characterNormalsBase].ownerGUID
      if registeredNormals[characterNormalsBase].sets[normalsSet] == nil then
        if alternateNormals == false and isCostume == false then playerReference.broadcast("Warning: <"..characterNormalsBase.."> does not support ("..normalsSet..")", {1,1,0}) end
        debugLog{"   warning: base validation failure (base exists, but does not include the specified Normals set)", 0, {1,1,0}}
        characterBaseAvailable = false
      elseif registeredNormals[characterNormalsBase].active != true or panels[normalsPanelGUID].active != true then
        if alternateNormals == false and isCostume == false then playerReference.broadcast("Warning: <"..characterNormalsBase.."> (or its panel) is inactive", {1,1,0}) end
        debugLog{"   warning: base validation failure (base exists, but it or its corresponding panel is inactive)", 0, {1,1,0}}
        characterBaseAvailable = false
      else
        debugLog{"   base validation success (base exists and includes the specified Normals set)", 4}
        characterBaseAvailable = true
      end
    end

    -- Info messages.
    debugLog{"- characterNormalsBase: "..characterNormalsBase, 5}
    debugLog{"- characterNormalsAlternate: "..characterNormalsAlternate, 5}
    if characterAlternateAvailable == true then debugLog{"- characterAlternateAvailable: true", 5}
    else debugLog{"- characterAlternateAvailable: false", 5} end
    if characterBaseAvailable == true then debugLog{"- characterBaseAvailable: true", 5}
    else debugLog{"- characterBaseAvailable: false", 5} end

    if alternateNormals == true and characterAlternateAvailable == true then
      debugLog{"- - alternateNormals: true", 5}
      debugLog{"- - characterAlternateAvailable: true", 5}
      currentNormals = characterNormalsAlternate
    elseif alternateNormals == true and characterAlternateAvailable == false and characterBaseAvailable == true then
      debugLog{"- - alternateNormals: true", 5}
      debugLog{"- - characterAlternateAvailable: false", 5}
      debugLog{"- - characterBaseAvailable: true", 5}
      currentNormals = characterNormalsBase
    elseif alternateNormals == false and characterBaseAvailable == true then
      debugLog{"- - alternateNormals: false", 5}
      debugLog{"- - characterBaseAvailable: true", 5}
      currentNormals = characterNormalsBase
    elseif alternateNormals == false and characterBaseAvailable == false and characterAlternateAvailable == true then
      debugLog{"- - alternateNormals: false", 5}
      debugLog{"- - characterBaseAvailable: false", 5}
      debugLog{"- - characterAlternateAvailable: true", 5}
      currentNormals = characterNormalsAlternate
    end

    if currentNormals == nil then debugLog{"error: currentNormals is nil", 0, {1,0,0}}
    else debugLog{"currentNormals: "..currentNormals, 5} end
  end -- end check for player Normals being nil or default

  -- Last, desperate measure.
  if currentNormals == nil then
    currentNormals = [[Default (Alternate)]]
  end

  local currentNormalsOwnerGUID = registeredNormals[currentNormals].ownerGUID

  if registeredNormals[currentNormals].sets[normalsSet] == nil then
    playerReference.broadcast("Error: <"..currentNormals.."> does not support ("..normalsSet.."). Resetting to (Normals).", {1,0,0})
    normalsSet = [[Normals]]
  elseif registeredNormals[currentNormals].active != true or panels[currentNormalsOwnerGUID].active != true then
    playerReference.broadcast("Fatal Error: <"..currentNormals.."> or its corresponding panel is inactive.", {1,0,0})
    return
  end

  debugLog{"Normals precedence checks complete", 4, {1,0,1}}

  -- Now, generate the subdeck.

  debugLog{ " currentNormals: "..currentNormals, 5 }
  debugLog{ " normalsSet: "..normalsSet, 5 }

  local currentNormalsOwner = getObjectFromGUID(currentNormalsOwnerGUID)
  local ownerNormalsSheets = currentNormalsOwner.getVar("normalsSheets")
  local currentNormalsSheet = returnTableCopy(ownerNormalsSheets[currentNormals][normalsSet])
  local currentNormalsSuffix = currentNormalsSheet.suffix or [[ (N)]]

  --[=[ Formerly the home of the following code:
  if normalsDeck != nil then
    debugLog{ " unique Normals", 1, {1,1,0} }
    normalsSubdeck = normalsDeck
    currentNormals = deckName
  else
  --]=]

  -- if normalsDeck wasn't specified, create a subdeck table based on the values in the normalsSheets entry for this player color's currently-selected Normals.
  debugLog{ "normalsSubdeck is an empty table", 3, {1, 0.3, 0.3} }

  normalsSubdeck = {
    deckID = "1",
    faceURL = currentNormalsSheet.faceURL,
    --altfaceURL = currentNormalsSheet.altfaceURL,
    gridWidth = currentNormalsSheet.gridWidth,
    gridHeight = currentNormalsSheet.gridHeight,
    hiddenBack = true,
    cardList = {}
  }

  -- Populate this subdeck's cardList table based on the normalsList in the charTable entry for this character.
  -- If there is none, it uses the default Normals distribution. (This was set up at the beginning of this function.)
  for i,normalsListItem in ipairs(normalsList) do
    debugLog{ "i loop, normalsListItem: "..normalsListItem, 3, {1,0.5,0} }
    --debugLog{ "normals Subdeck value, Grasp: "..currentNormalsSheet["Grasp"], 1, {0, 1, 0} }
    --debugLog{ "cardID: "..currentNormalsSheet[normalsListItem], 1, {0,1,0} }

    local speedKeyword = nil
    if normalsListItem == [[Grasp]] then
      speedKeyword = " ;7"
    elseif normalsListItem == [[Cross]] then
      speedKeyword = " ;6"
    elseif normalsListItem == [[Assault]] then
      speedKeyword = " Slash ;5"
    elseif normalsListItem == [[Slash]] then
      speedKeyword = " Assault ;5"
    elseif normalsListItem == [[Dive]] then
      speedKeyword = " ;4"
    elseif normalsListItem == [[Spike]] then
      speedKeyword = " Dust ;3"
    elseif normalsListItem == [[Dust]] then
      speedKeyword = " Spike ;3"
    elseif normalsListItem == [[Sweep]] then
      speedKeyword = " ;2"
    elseif normalsListItem == [[Focus]] then
      speedKeyword = " ;1"
    elseif normalsListItem == [[Block]] then
      speedKeyword = " ;0"
    end

    local thisCardSuffix = normalsListItem..currentNormalsSuffix
    if speedKeyword != nil then thisCardSuffix = normalsListItem..speedKeyword..currentNormalsSuffix end

    debugLog{ "building Normals subdeck, element: "..normalsListItem, 3}
    debugLog{ "card ID: "..currentNormalsSheet[normalsListItem], 3}

    table.insert(normalsSubdeck.cardList, {
      cardID = currentNormalsSheet[normalsListItem] or "00",
      cardNickname = thisCardSuffix,
      cardDescription = currentNormalsSheet.cardDescription or currentNormals,
      cardScript = characterNormalsScript or [[]],
      copies = 1,
    })
  end -- end normalsList loop

  return currentNormals,normalsSubdeck
end -- end getNormalsSubdeck



function getRandomCharacter(season, passedPlayer)
  --local season = params[1]
  --debugLog{ "retrieving random deck from "..season, 3, {0.6, 0.6, 0.9} }

  local randomID = [[]]
  local ownerGUID = nil
  local secretChance = nil
  local characterOwner = nil
  local playerReference = nil
  local characterEntry = nil

  if type(passedPlayer) == "string" then
    playerReference = Player[passedPlayer]
  else
    playerReference = passedPlayer
  end

  -- Randomly rolling a character sometimes results in a secret character.
  -- However, these characters are not guaranteed to spawn (unless a secret password is used).
  -- This is implemented by "rerolling" until either the spawn chance succeeds or a non-secret character is rolled.

  -- validResult is a flag that is set to true when one of those things happens.
  -- It's also set to true if the player's "password" matches a secret character password.
  local validResult = false

  -- If the player's current "password" (the sequence of characters they've spawned) matches a secret character's password, spawn them.

  -- Update the player's current password string.
  passwordUpdate({
    playerReference = playerReference,
    appendix = season,
  })

  --[=[
  -- If the player hasn't clicked anything, their playerPasswords entry will be nil.
  if playerPasswords[playerReference.steam_id] != nil then
    -- All passwords must end with the appropriate season number or name for the random button that spawns them.
    playerPasswords[playerReference.steam_id] = playerPasswords[playerReference.steam_id]..[[ | ]]..season
  else
    playerPasswords[playerReference.steam_id] = season
  end
  --]=]
  debugLog{ "player password: "..playerPasswords[playerReference.steam_id], 2}
  local passwordLength = 0

  for secretName,secretCode in pairs(passwordsTable) do
    -- If there's only one password for the character, it's a string.
    if type(secretCode) == [[string]] then
      local codeLength = string.len(secretCode)
      -- Check only the END of the player's entered password. This way you don't have to "clear" your entry.
      if string.sub(playerPasswords[playerReference.steam_id], -1*codeLength) == secretCode
      and codeLength >= passwordLength then
        --debugLog{ "active type: "..type(randomSeasons["All"][secretName].active), 2, {1,0,1}}
        debugLog{ "password match: "..secretName, 3}
        passwordLength = codeLength
        randomID = secretName

        ownerGUID = randomSeasons["All"][randomID].ownerGUID
        secretChance = randomSeasons["All"][randomID].secretChance
        characterOwner = getObjectFromGUID(ownerGUID)
        local characterTable = characterOwner.getVar("charTable")
        characterEntry = characterTable[randomID]

        -- This bypasses the random roll afterward.
        validResult = true
      end -- end check for end of the player's entered password
    -- If there's multiple passwords for the character, check them all.
    elseif type(secretCode) == [[table]] then
      for subcodeIndex,secretSubcode in pairs(secretCode) do
        local codeLength = string.len(secretSubcode)
        -- Check only the END of the player's entered password. This way you don't have to "clear" your entry.
        if string.sub(playerPasswords[playerReference.steam_id], -1*codeLength) == secretSubcode
        and codeLength >= passwordLength then
          --debugLog{ "active type: "..type(randomSeasons["All"][secretName].active), 2, {1,0,1}}
          debugLog{ "password match: "..secretName, 3}
          passwordLength = codeLength
          randomID = secretName

          ownerGUID = randomSeasons["All"][randomID].ownerGUID
          secretChance = randomSeasons["All"][randomID].secretChance
          characterOwner = getObjectFromGUID(ownerGUID)
          local characterTable = characterOwner.getVar("charTable")
          characterEntry = characterTable[randomID]

          -- This bypasses the random roll afterward.
          validResult = true
        end -- end check for end of the player's entered password
      end -- end for loop which checks each of multiple passwords for the character
    end -- end 'if type(secretCode)'
  end -- end 'for secretName,secretCode in pairs(passwordsTable)'

  -- This line of code means that the random buttons are always "enders" for passwords.
  playerPasswords[playerReference.steam_id] = nil

  -- We don't want to issue a hint more than once if it happens to need to be rerolled more than once.
  local hinted = false

  while validResult == false do

    debugLog{"   season: "..season, 3}
    local count = 0
    local seasonCharacters = {}
    for eachCharacter,characterTable in pairs(randomSeasons[season]) do
      debugLog{"eachCharacter: "..eachCharacter, 5}
      --debugLog{"active type: "..type(characterTable.active), 1}
      local panelGUID = characterTable.ownerGUID
      if characterTable.active == true and panels[panelGUID].active == true then
        debugLog{"   active: true", 4, {0.5,0.5,0.5}}
        count = count+1
        -- Populate a new table with numeric keys.
        table.insert(seasonCharacters, eachCharacter)
      end
    end
    debugLog{"   count: "..count, 5}

    if count > 0 then

      randomID = seasonCharacters[math.random(1, count)]
      ownerGUID = randomSeasons[season][randomID].ownerGUID
      secretChance = randomSeasons[season][randomID].secretChance
      characterOwner = getObjectFromGUID(ownerGUID)

      debugLog{ "   result: "..randomID, 3, {0.9, 0.7, 0.7} }

      local characterTable = characterOwner.getVar("charTable")
      characterEntry = characterTable[randomID]

      debugLog{"characterEntry type: "..type(characterEntry), 4, {0, 1, 1}}
      debugLog{"charTable type: "..type(characterTable), 4, {0, 1, 1}}

      --debugLog{printTable(characterTable), 2}

      -- If the randomly-selected character is a secret, they are not guaranteed to spawn.
      local glitchMode = Global.getVar("glitchMode")

      if secretChance != nil and secretChance != 1 then
        local effectiveSecretChance = secretChance
        -- Glitch Mode enables April Fool's Exceed, where custom characters are easy to spawn.
        if glitchMode == true and randomID != [[Rugal Bernstein (King of Fighters, Fan-Made)]] then
          effectiveSecretChance = 1
        end
        debugLog{[[  spawn threshold: ]]..effectiveSecretChance, 4, {1, 1, 1}}
        local secretRoll = math.random(1,1024)
        --debugLog{[[  die roll result: ]]..secretRoll, 1, {0.8, 0.8, 0.8}}
        secretRoll = secretRoll/1024
        debugLog{[[    effective result: ]]..secretRoll, 4, {1, 1, 1}}

        -- If the roll result falls within this range, spawn a secret character.
        if secretRoll <= effectiveSecretChance then
          debugLog{"   spawning a secret"}
          -- If the secret character has an associated password...
          if characterEntry.secretPassword != nil then
            --debugLog{"      password logic", 2, {0.8,0.8,0.8}}

            -- If the secretPassword is a string, provide some kind of clue to the player about its contents.
            if type(characterEntry.secretPassword) == [[string]] then
              local thisPassword = dec(characterEntry.secretPassword)

              -- Determine how many criteria are in the password.
              local separators = 0
              local passwordSegments = {}
              --debugLog{" counting segments ...", 2, {1,1,0}}
              for sep in string.gmatch(thisPassword, "[^|]- | ") do
                separators = separators+1
                passwordSegments[separators] = string.sub(sep, 1, (string.len(sep)-3) )
                --debugLog{"segment: "..passwordSegments[separators], 2}
              end

              -- If there is a formal hint for the character, print that.
              if characterEntry.secretHint != nil then
                playerReference.print(characterEntry.secretHint, {0.4, 0.4, 0.4})
              end

              -- Print one character from the password.
              local randomSegment = math.random(1, #passwordSegments)

              -- If the character is Rugal, almost always print the third character.
              if randomID == [[Rugal Bernstein (King of Fighters, Fan-Made)]] then
                if math.random(1, 10) < 10 then randomSegment = 4 end
              end

              local tauntIndex = math.random(1, 2)
              if tauntIndex == 1 then
                playerReference.print([=[[BBBBBB]Look! The "[-]]=]..passwordSegments[randomSegment]..[=[[BBBBBB]" is reacting![-]]=], {0.8, 0.8, 0.8})
                playerReference.print([=[[b]The seal has been broken![/b]]=], {0.8, 0.8, 1})
              elseif tauntIndex == 2 then
                playerReference.print([=[[BBBBBB]You crafty Humans.
  The sin of contaminating my sacred ]=]..passwordSegments[randomSegment]..[=[

  is an idiocy worthy of total death.]=], {0.8, 0.8, 0.8})
                playerReference.print([=[[b]Will you stand your ground?[/b]]=], {0.8, 0.8, 1})
              end

              --local separatorCount = (string.len(separators) / 3)
              --debugLog{"separatorCount: "..separatorCount, 2}

              -- This used to output the entire password wholesale.
              --playerReference.print("[b]Password:[/b][-] <"..characterEntry.secretPassword..">", {0.8, 0.8, 0.8})

            -- If it's a table, pick one of the passwords at random and provide a clue as to its contents.
            elseif type(characterEntry.secretPassword) == [[table]] then
              local thisPassword = characterEntry.secretPassword
              local passwordIndex = math.random(1,#thisPassword)
              --debugLog{"passwordIndex: "..passwordIndex, 2}
              local thisPassword = thisPassword[passwordIndex]
              thisPassword = dec(thisPassword)

              -- Determine how many criteria are in the password.
              local separators = 0
              local passwordSegments = {}
              --debugLog{" counting segments ...", 2, {1,1,0}}
              for sep in string.gmatch(thisPassword, "[^|]- | ") do
                separators = separators+1
                passwordSegments[separators] = string.sub(sep, 1, (string.len(sep)-3) )
                --debugLog{"segment: "..passwordSegments[separators], 2}
              end

              -- If there is a formal hint for the character, print that.
              if characterEntry.secretHint != nil then
                playerReference.print(characterEntry.secretHint, {0.4, 0.4, 0.4})
              end

              -- Print one character from the password.
              playerReference.print([=[[BBBBBB]Look! The "[-]]=]..passwordSegments[math.random(1, #passwordSegments)]..[=[[BBBBBB]" is reacting![-]]=], {0.8, 0.8, 0.8})
              playerReference.print([=[[b]The seal has been broken![/b]]=], {0.8, 0.8, 1})

            end -- end 'if type(characterEntry.secretPassword) == [[table]]'
          end -- end 'if characterEntry.secretPassword != nil'
        validResult = true
        -- If the roll failed, hint that there's a secret here.
        elseif secretRoll >= 3/4 and hinted == false then
          debugLog{"   failed to spawn a secret"}
          if characterEntry.missFunction != nil then
            characterEntry.missFunction(playerReference)
            hinted = true
          else
            local hintRoll = math.random(1,2)
            local hintMessage = [[There is no one here.]]
            if hintRoll == 1 then
              -- Referencing Super Mario RPG: Legend of the Seven Stars.
              hintMessage = [[It's been sealed.]]
            end
            -- Referencing Shin Megami Tensei.
            broadcastToAll(hintMessage,{-2,-2,-2})
            hinted = true
          end
        end -- end 'if secretRoll ...'
      else
        -- If the rolled character isn't a secret, there's no need to reroll.
        debugLog{"   not a secret"}
        validResult = true

        -- ...But if glitchMode is active and the player has enough points, reroll anyway.
        if glitchMode == true then
          local playerScore = Global.call("getPlayerPrizes", {playerReference = playerReference})
          if playerScore > 100 then
            validResult = false
            Global.call("givePrizeToPlayer", {
              playerReference = playerReference,
              multiplier = -1,
              points = 100,
              secret = true,
            })
            playerReference.broadcast("Boring character detected: "..randomID..". Spent points to reroll!", {0,1,1})
          end -- end 'if playerScore > 100'
        end -- end 'if glitchMode == true'
      end -- end 'if characterEntry.secret == true'
    -- No active characters found in the specified season.
    else
      playerReference.broadcast("Error: No active characters in season "..season, {1,0,0})
      --debugLog{"error: no active characters for season "..season, 0, {1,0,0}}
      return nil
    end -- end 'if count > 0'
  end -- end 'while validResult == false'

  debugLog{"characterEntry type: "..type(characterEntry), 5}

  -- If this character has an audio cue, play it.
  if characterEntry.audioCue != nil then
    --debugLog{[[   audio cue exists]],2,{1,1,0}}
    MusicPlayer.repeat_track = false
    MusicPlayer.setCurrentAudioclip({url=characterEntry.audioCue,title=randomID..[[ audio cue]]})
  end

  -- If this character has a quote function, use it.
  if characterEntry.quoteFunction != nil then
    characterEntry.quoteFunction(playerReference)
  -- If not, but the character IS a secret character, use a random generic warning line.
  elseif characterEntry.secret == true then
    -- Generic warning lines.
    local quoteFunctions = {
      function (announcementPlayer)
        -- Referencing boss fight splash screen from Darius.
        announcementPlayer.broadcast([[WARNING!]], {1,0,0})
        Wait.frames(function () announcementPlayer.broadcast([[A HUGE BATTLESHIP]], {1,1,1}) end, 90)
        Wait.frames(function () broadcastToAll(randomID, {0.1,1,0.7}) end, 210)
        Wait.frames(function () broadcastToAll([[IS APPROACHING FAST]], {1,1,1}) end, 330)
      end,
      function (announcementPlayer)
        -- Referencing boss fight splash screen from Ikaruga.
        announcementPlayer.broadcast([[WARNING!]], {1,0,0})
        Wait.frames(function () announcementPlayer.broadcast([[The big enemy is approaching at full throttle.]], {1,0.7,0}) end, 90)
        Wait.frames(function () announcementPlayer.broadcast([[According to the data, it is identified as "]]..randomID..[[".]], {1,0.7,0}) end, 210)
        Wait.frames(function () broadcastToAll([[NO REFUGE]],{1,0,0}) end, 330)
      end,
      function (announcementPlayer)
        -- Referencing Burroughs from Shin Megami Tensei IV.
        announcementPlayer.broadcast([[WARNING!]], {1,1,0})
        Wait.frames(function () announcementPlayer.broadcast([[I detect a very dangerous demon nearby.]], {1,0.7,0}) end, 90)
        Wait.frames(function () broadcastToAll([[You should consider getting out of here.]],{1,0,0}) end, 210)
      end,
      function (announcementPlayer)
        -- Referencing boss fight narration from Catherine.
        announcementPlayer.broadcast([[The ]]..randomID..[[ has appeared.]], {1,0.3,0})
        Wait.frames(function () broadcastToAll([[It's the killer.]],{1,0.7,0}) end, 90)
        Wait.frames(function () broadcastToAll([[Do not die.]],{1,0,0}) end, 210)
      end,
      function (announcementPlayer)
        -- Referencing a community meme, and also Jaws.
        broadcastToAll([[You're gonna need a bigger truck.]],{0.6,0.3,0})
      end,
      function (announcementPlayer)
        -- Referencing Esfir from Bullet <3.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([[Crushing force overwhelming!]],{1,0.5,0.7}) end, 90)
        Wait.frames(function () broadcastToAll([[Try and stand up, only to get knocked down!]],{1,0,0}) end, 210)
      end,
      function (announcementPlayer)
        -- Referencing Ling Ling from Bullet <3.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([[Difficult code cracking impossibility!]],{0.1,0.1,1}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Mariel from Bullet <3.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([[Big machine hazard comes forth!]],{0.9,0.9,0.5}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Adelheid from Bullet <3.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([[Song will forget you!]],{0.2,0.2,0.2}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Senka from Bullet <3.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([[Bullet of Murder Killer!]],{0.1,0.1,1}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Rie from Bullet <3.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([[Shady crime beat up time!]],{1,0.1,0}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Young-Ja from Bullet <3.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([[She will scare, so be prepare!]],{0.7,0.7,0.7,0.7}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Ekolu from Bullet <3.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([[Shape of deaths!]],{0.4,0.4,0}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Rose from Bullet *.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () announcementPlayer.broadcast([[Zombie approach!]], {0,0,0,0.9}) end, 90)
        Wait.frames(function () broadcastToAll([[Girl of dead smiles and camerawork!]],{1,1,1,0.9}) end, 210)
      end,
      function (announcementPlayer)
        -- Referencing YNN from Bullet *.
        broadcastToAll([[Now back to your regularly scheduled episode of Free For All!]],{0.9,0.6,0})
      end,
      function (announcementPlayer)
        -- Referencing Jill from Bullet *.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([=[[FF9900]Fire[-] [FF0000]explode[-] [99FF00]big time[-]!]=]) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Jane Doe from Bullet *.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([[Outside space judgment race!]],{0,0.7,0}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing the chef duo from Bullet *.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([=[[33FF33]Big[-] [FF3333]yammy[-] [3333FF]likely[-]!]=]) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Planil from Bullet *.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([[Double mind trouble!]],{0.1,0.3,1}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Balance from Bullet *.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([[Clean you up forever!]],{0.6,0,0.8}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Memory from Bullet *.
        announcementPlayer.broadcast([[WARNING!]], {1,0,1})
        Wait.frames(function () broadcastToAll([[Rare cat kill lots!]],{0,0,0}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Suguri from Bullet O.
        announcementPlayer.broadcast([[WARNING!]], {0.9,0.6,0})
        Wait.frames(function () broadcastToAll([[High speed fast flying!]],{0.7,0.7,0.7}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Sora from Bullet O.
        announcementPlayer.broadcast([[WARNING!]], {0.9,0.6,0})
        Wait.frames(function () broadcastToAll([[Blast explosion!]],{0,1,1}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Sora from Bullet O.
        announcementPlayer.broadcast([[WARNING!]], {0.9,0.6,0})
        Wait.frames(function () broadcastToAll([[Pierce precision!]],{0,1,1}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Sora from Bullet O.
        announcementPlayer.broadcast([[WARNING!]], {0.9,0.6,0})
        Wait.frames(function () broadcastToAll([[Laser hits at long!]],{0,1,1}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing Marc from Bullet O.
        announcementPlayer.broadcast([[WARNING!]], {0.9,0.6,0})
        Wait.frames(function () broadcastToAll([[Fight plane inbound!]],{155/255, 14/255, 39/255}) end, 180)
      end,
      function (announcementPlayer)
        -- Referencing QP from Bullet O.
        announcementPlayer.broadcast([[WARNING!]], {0.9,0.6,0})
        Wait.frames(function () broadcastToAll([=[[964B00]Ener[-][FFFDB0]gy increased opt[-][964B00]ions![-]]=]) end, 180)
      end,
    }
    local count = 0
    for i,thisFunction in pairs(quoteFunctions) do
      count = count+1
    end
    quoteFunctions[math.random(1,count)](playerReference)
  end
  return randomID, ownerGUID
end -- end getRandomCharacter



function getReferenceDecal()
  local decalScale = {
    x = 2.146,
    y = 3.0675,
    z = 1, }
  local decalSize = 120
  --decalReferenceURL = [[https://i.imgur.com/sj2idgS.png]]
  local decalReferenceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ymFmLKz.png]]
  local decalReferencePosition = { x = 0, y = 0.363, z = 0, }

  local decalTable = {}
  decalTable.Transform = {
    posX = decalReferencePosition.x,
    posY = decalReferencePosition.y,
    posZ = decalReferencePosition.z,
    rotX = 90,
    rotY = 180,
    rotZ = 0,
    scaleX = decalScale.x,
    scaleY = decalScale.y,
    scaleZ = decalScale.z,
    --scaleX = 1.92496347,
    --scaleY = 2.75000238,
    --scaleZ = 42.307682
  }
  decalTable.ColorDiffuse = {
    r = 0.713235259,
    g = 0.713235259,
    b = 0.713235259,
    a = 0.5
  }
  decalTable.CustomDecal = {
    Name = [[Decal]],
    ImageURL = decalReferenceURL,
    Size = decalSize,
  }
  return decalTable
end -- end getReferenceDecal



function getSelectNormalsStatus(params)
  local playerColor = params.playerColor
  local playerStatus = selectNormals[playerColor]
  return playerStatus
end -- end getSelectNormalsStatus



function normalsToggleClick(params)
  local alternate = params.alternate
  local newNormals = params.newNormals
  local ownerGUID = params.ownerGUID
  local playerColor = params.playerColor
  local toggleID = params.toggleID
  local toggleKey = toggleID

  if type(playerColor) != [[string]] then
    debugLog{"error: playerColor type is "..type(playerColor)..", not a string", 0, {1,0,0}}
    return
  elseif type(toggleID) != [[string]] then
    debugLog{"error: toggleID type is "..type(toggleID)..", not a string", 0, {1,0,0}}
    return
  elseif type(ownerGUID) != [[string]] then
    debugLog{"error: ownerGUID type is "..type(ownerGUID)..", not a string", 0, {1,0,0}}
    return
  end

  if alternate == true then debugLog{"alternate true", 5, {1,1,1}}
  elseif alternate == false then debugLog{"alternate false", 5, {0.5,0.5,0.5}} end

  toggleKey = string.sub(toggleID, string.len(playerColor)+2 )
  --debugLog{"toggleID sans playerColor: "..toggleKey, 3}

  newNormals = string.sub(toggleKey, 17)
  --debugLog{"toggleKey sans prefix: "..toggleKey, 5}

  if string.sub(toggleKey, -12) == [[ (Alternate)]] then
    toggleKey = string.sub(toggleKey, 1, (string.len(toggleKey)-12) )
  end

  --debugLog{"  current suffix: "..string.sub(toggleKey, -12), 3}
  if alternate == true and string.sub(newNormals, -12) != [[ (Alternate)]] then
    --debugLog{"   appending suffix", 3}
    newNormals = newNormals..[[ (Alternate)]]
  elseif alternate == false and string.sub(newNormals, -12) == [[ (Alternate)]] then
    --debugLog{"   removing suffix", 3}
    newNormals = string.sub(newNormals, 1, (string.len(newNormals)-12) )
  end

  -- Keys in the normalsToggleTable prepend ownerGUIDs to toggleKey.
  toggleKey = ownerGUID..toggleKey

  --debugLog{"   playerColor: "..playerColor, 3, {0,1,1}}
  debugLog{"   newNormals: "..newNormals, 2, {1,1,1}}
  debugLog{"   ownerGUID: "..ownerGUID, 5, {0,1,1}}
  debugLog{"   toggleID: "..toggleID, 5, {0,1,1}}
  debugLog{"   toggleKey: "..toggleKey, 5, {0,1,1}}

  -- Update the player's Normals. This also updates any relevant toggles.
  updatePlayerNormals({
    alternate = alternate,
    newNormals = newNormals,
    ownerGUID = ownerGUID,
    playerColor = playerColor,
    toggleID = toggleID,
    toggleKey = toggleKey,
    --updateDropdown = false,
  })
end -- end normalsToggleClick



function onChat(message, player)
  local playerColor = player.color
  if message == "!normals" or message == "!Normals" then
    local playerNormals = getCurrentNormals({ playerColor = playerColor })
    if playerNormals != nil then
      broadcastToColor("Current Normals: "..playerNormals, playerColor)
    end
  elseif message == "!password" then
    if type(playerPasswords[player.steam_id]) == [[string]] then
      broadcastToColor("Current password: "..playerPasswords[player.steam_id], player.color)
    else
      broadcastToColor("Current password is "..type(playerPasswords[player.steam_id]), player.color)
    end
  -- Hints for secret passwords.
  elseif message == "!ballot" or message == "!Ballot" then
    broadcastToAll(charTable["Ballot (Red Horizon, Fan-Made)"].secretHint)
    return false
  elseif message == "!burnoutcar" or message == "!Burnout Car" then
    broadcastToAll(charTable["Burnout Car (Burnout, Fan-Made)"].secretHint)
    return false
  elseif message == "!clippy" or message == "!Clippy" then
    broadcastToAll(charTable["Clippy (Microsoft Word, Fan-Made)"].secretHint)
    return false
  elseif message == "!culex" or message == "!Culex" then
    broadcastToAll(charTable["Culex (Super Mario RPG, Fan-Made)"].secretHint)
    return false
  elseif message == "!danicapatrick" or message == "!Danica Patrick" then
    broadcastToAll(charTable["Danica Patrick (Fan-Made)"].secretHint)
    return false
  elseif message == "!dante" or message == "!Dante" or message == "!dantefromthedevilmaycryseries" then
    broadcastToAll(charTable["Dante (from the Devil May Cry™ series) (Fan-Made)"].secretHint)
    return false
  elseif message == "!darksouls" or message == "!Dark Souls" or message == "!thedarksoulsofexceedcharacters" then
    broadcastToAll(charTable["Dark Souls (Fan-Made)"].secretHint)
    return false
  elseif message == "!doomspeedrunner" or message == "!Doom Speedrunner" then
    broadcastToAll(charTable["Doom Speedrunner (Fan-Made)"].secretHint)
    return false
  elseif message == "!fortuna" or message == "!Fortuna" then
    broadcastToAll(charTable["Fortuna (Fan-Made)"].secretHint)
    return false
  elseif message == "!giantspearman" or message == "!Giant Spearman" then
    broadcastToAll(charTable["Giant Spearman (Warioland, Fan-Made)"].secretHint)
    return false
  elseif message == "!theknight" or message == "!The Knight" then
    broadcastToAll(charTable["The Knight (Hollow Knight, Fan-Made)"].secretHint)
    return false
  elseif message == "!lastlegs" or message == "!Last Legs" then
    broadcastToAll(charTable["Last Legs (Fan-Made)"].secretHint)
    return false
  elseif message == "!majora" or message == "!Majora" or message == "!Skull Kid" then
    broadcastToAll(charTable["Majora (The Legend of Zelda, Fan-Made)"].secretHint)
    return false
  elseif message == "!missingno" or message == "!MissingNo." then
    broadcastToAll(charTable["MissingNo. (Pokémon, Fan-Made)"].secretHint)
    return false
  elseif message == "!noir" or message == "!Noir" then
    broadcastToAll(charTable["Noir (Esper X, Fan-Made)"].secretHint)
    return false
  elseif message == "!norin" or message == "!Norin the Wary" then
    broadcastToAll(charTable["Norin the Wary (Magic: The Gathering, Fan-Made)"].secretHint)
    return false
  -- Rugal is expressly disallowed from ever having functionality that makes it easier to spawn him.
  elseif message == "!rugalbernstein" or message == "!Rugal Bernstein" or message == "!rugal" or message == "!Rugal" then
    player.broadcast("[000000][b]No.[/b][-]")
    return false
  elseif message == "!sagas" or message == "!Sagas" or message == "!servi" then
    broadcastToAll(charTable["Sagas (Indines, Fan-Made)"].secretHint)
    return false
  elseif message == "!sans" or message == "!Sans" then
    broadcastToAll(charTable["Sans (UNDERTALE, Fan-Made)"].secretHint)
    return false
  elseif message == "!superskullman33" or message == "!Super Skull Man 33" then
    player.print("If only you could make infinite copies in real life!", {1,1,1})
    return false
  elseif message == "!tonyhawk" or message == "!Tony Hawk" then
    broadcastToAll(charTable["Tony Hawk (Fan-Made)"].secretHint)
    return false
  elseif message == "!trillion" or message == "!Trillion" then
    broadcastToAll(charTable["Trillion (Trillion: God of Destruction, Fan-Made)"].secretHint)
    return false
  elseif message == "!ultimatezangetsu" or message == "!Zangetsu, Ultimate Swordsman" then
    broadcastToAll(charTable["Ultimate Zangetsu (Bloodstained, Fan-Made)"].secretHint)
    return false
  elseif message == "!waldo" or message == "!Waldo" then
    player.broadcast("Sorry, no password for him! (But look over there!)")
    local pingPosition = {
        x = (waldoPosition.z+(math.random(350, 450))) / 12,
        y = 1,
        z = (waldoPosition.x+math.random(-50,50)) / -12,
      }
    player.pingTable(pingPosition)
    return false
  elseif message == "!youropponent" or message == "Your Opponent" then
    broadcastToAll(charTable["Your Opponent Ω (Fan-Made)"].secretHint)
    return false
  end -- end message == "!normals" or message == "!Normals" then

  --local debugLog = debugLog
  if message == "!deckoflag" or message == "!bagoflag" then
    if player.steam_name == "tirankin" or player.steam_name == "Feather Rose" then
      broadcastToAll("Prepare yourself!", {1,0.7,1})
      -- TODO: Repair the Bag of Lag.

      --Global.setVar("debugFlag", true)
      --Global.setVar("debugLevel", 3)

      local lagOfNormalIDList = {}
      local lagOfNormalCustomDeckList = {}
      local lagOfNormalCardList = {}

      local lagOfNonNormalIDList = {}
      local lagOfNonNormalCustomDeckList = {}
      local lagOfNonNormalCardList = {}

      local lagOfSeparateIDList = {}
      local lagOfSeparateCustomDeckList = {}
      local lagOfSeparateCardList = {}

      local lagOfCharacterIDList = {}
      local lagOfCharacterCustomDeckList = {}
      local lagOfCharacterCardList = {}

      local backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/igYZhPh.png]]
      local randomBackTable = {
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PGG10qQ.jpg]], -- Red Horizon lightning card back.
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/a2A0JO5.jpg]], -- Red Horizon "Good Guys" half-poster (and Random S1 hover image).
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/e5iNSvu.jpg]], -- Red Horizon "Bad Guys" half-poster.
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6JsaDT6.jpg]], -- Seventh Cross cast poster (and Random S2 hover image).
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/A6kNI35.jpg]], -- Random S4 hover image.
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rmGkMZt.jpg]], -- Season 3 cast poster (and Random S3 hover image).
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/B6nFbAm.jpg]], -- Random Boss hover image.
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fEemYJl.jpg]], -- BlazBlue character select card back.
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6NCMUGq.jpg]], -- Randomy Any hover image.
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OjfmPyx.jpg]], -- Exceed Organized Play poster (and Random Legal hover image).
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/G2lQzgA.jpg]], -- Red Horizon "Cursed" (Bag Doods) half-poster.
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/10BKnKu.jpg]], -- BlazBlue Under Construction card back.
        [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NLZ0guj.jpg]], -- Random S5 hover image.
      }
      local count = 0
      for i in pairs(randomBackTable) do
        count = count+1
      end
      backURL = randomBackTable[math.random(1, count)]

      local deckIDOffset = 0

      for characterName,characterTable in pairs(randomSeasons["All"]) do
        local ownerGUID = characterTable.ownerGUID

        local alternate = false
        local onlyNormals = false

        local playerReference = player
        local characterOwner = nil
        local ownerCharacters = {}
        local characterEntry = {}
        local characterDeck = {}
        local characterData = {}

        if type(ownerGUID) == [[string]] then

          characterOwner = getObjectFromGUID(ownerGUID)
          characterEntry = returnTableCopy(characterOwner.getVar("charTable")[characterName])
          characterCard = characterEntry.charCard

          local deckNormals       = characterEntry.normals
          local deckNormalsSet    = characterEntry.normalsSet
          local deckNormalsDeck   = characterEntry.normalsDeck
          local deckNormalsScript = characterEntry.normalsScript
          local altbackURL        = characterEntry.altattackBack
          local charPosition      = characterEntry.position

          if characterEntry.deckReturnFunction != nil then
            characterDeck = characterEntry.deckReturnFunction()
          else
            characterDeck = returnTableCopy(characterEntry.deck)
          end -- end 'if characterEntry.deckReturnFunction != nil'

            -- [=[ Bag of Lag

          characterData,alternateUsed,alternateExists = getBagData({
            deckName          = characterName,
            deckDescription   = [[Bag of Lag]],
            deckIDOffset      = deckIDOffset,
            characterCard     = characterCard,
            deckList          = characterDeck,
            deckNormals       = characterEntry.normals,
            deckNormalsSet    = characterEntry.normalsSet,
            deckNormalsDeck   = characterEntry.normalsDeck,
            deckNormalsScript = characterEntry.normalsScript,
            lag               = true,
            playerColor       = playerColor,
            alternate         = false,
            --cardColor         = cardColor,
            backURL           = backURL,
            altbackURL        = characterEntry.altattackBack,
            charPosition      = characterEntry.position,
          })

          -- Why yes, I could have written this much more efficiently.
          -- Anyway.
          for index,thisCard in pairs(characterData["normalCardList"]) do
            table.insert(lagOfNormalCardList, thisCard)
          end
          for index,thisCustomDeck in pairs(characterData["normalCustomDeckList"]) do
            table.insert(lagOfNormalCustomDeckList, thisCustomDeck)
          end
          for index,thisID in pairs(characterData["normalIDList"]) do
            table.insert(lagOfNormalIDList, thisID)
          end

          for index,thisCard in pairs(characterData["nonNormalCardList"]) do
            table.insert(lagOfNonNormalCardList, thisCard)
          end
          for index,thisCustomDeck in pairs(characterData["nonNormalCustomDeckList"]) do
            table.insert(lagOfNonNormalCustomDeckList, thisCustomDeck)
          end
          for index,thisID in pairs(characterData["nonNormalIDList"]) do
            table.insert(lagOfNonNormalIDList, thisID)
          end

          for index,thisCard in pairs(characterData["separateCardList"]) do
            table.insert(lagOfSeparateCardList, thisCard)
          end
          for index,thisCustomDeck in pairs(characterData["separateCustomDeckList"]) do
            table.insert(lagOfSeparateCustomDeckList, thisCustomDeck)
          end
          for index,thisID in pairs(characterData["separateIDList"]) do
            table.insert(lagOfSeparateIDList, thisID)
          end

          for index,thisCard in pairs(characterData["characterCardList"]) do
            table.insert(lagOfCharacterCardList, thisCard)
          end
          for index,thisCustomDeck in pairs(characterData["characterCustomDeckList"]) do
            table.insert(lagOfCharacterCustomDeckList, thisCustomDeck)
          end
          for index,thisID in pairs(characterData["characterIDList"]) do
            table.insert(lagOfCharacterIDList, thisID)
          end

          -- table.remove(costumeTable, highestCostumePriorityIndex)
          --]=]

          --[=[
          deck = {
            { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GozQIFa.jpg]],
              altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/si2vJLo.jpg]],
              gridWidth = 4, gridHeight = 2,
              hiddenBack = true,
              cardList = { { cardID = [[00]],
                  cardNickname = [[Sure You Can! ;7 (S)]], copies = 2, reference = true, },
                { cardID = [[01]],
                  cardNickname = [[Maori Defender ;6 (S)]], copies = 2, reference = true, },
                { cardID = [[02]],
                  cardNickname = [[Gale Blade ;5 (S)]], copies = 2, reference = true, },
                { cardID = [[03]],
                  cardNickname = [[Focus Charge ;5 (S)]], copies = 2, reference = true, },
                { cardID = [[04]],
                  cardNickname = [[Gut Shot ;4 (S)]], copies = 2, reference = true, },
                { cardID = [[05]],
                  cardNickname = [[Tsunami Slicer ;6 (U)]], copies = 2, reference = true, },
                { cardID = [[06]],
                  cardNickname = [[Neo Cosmic Flare ;4 (U)]], copies = 2, reference = true, },
                }, -- end cardList
            }, -- end subdeck 2
            { deckID = [[3]],
              faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/b95JPw8.jpg]],
              backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6aoVnck.jpg]],
              altfaceURL = [[https://i.imgur.com/4WbIPSK.png]], -- April Fool's Exceed 2023
              altbackURL = [[https://i.imgur.com/g2pxQPE.png]], -- April Fool's Exceed 2023
              -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AI3BuCB.jpg]],
              -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Izay9qo.jpg]],
              --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9JhJMw1.jpg]],
              --altbackURL = [[https://i.imgur.com/ogFjDsB.jpg]],
              gridWidth = 1, gridHeight = 1,
              hiddenBack = false,
              cardList = { { cardID = [[00]],
                  cardNickname = [[Zoey (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
                }, -- end cardList
            }, -- end subdeck
          --]=]

          -- TODO: Have this take into account the actual offset required.
          -- This may entail refactoring the non-lag generation code to ignore prescribed deckIDs...
          deckIDOffset = deckIDOffset+10

          debugLog{"(sampling) charCard: "..characterEntry.charCard, 3, {1,1,0}}
        else
          debugLog{"Error: no ownerGUID!", 0, {255/255, 0/255, 0/255} }
          debugLog{"ownerGUID type: "..type(ownerGUID)}
        end -- end 'if type(ownerGUID) == [[string]]'
      end -- end 'for characterName,characterTable in pairs(randomSeasons["All"])'
      --printToAll("about to print Characters collection...")
      --printToAll(printTable(lagOfCharacter))

      local cardColor = {
        r = 0.713235259,
        g = 0.713235259,
        b = 0.713235259,
        a = 1
      }

      local bagOfLag = {
        Name = "Bag",
        Transform = {
          scaleX = 3,
          scaleY = 3,
          scaleZ = 3,
          rotX = 0, rotY = 0, rotZ = 0,
        },
        Nickname = "Bag of Lag",
        Description = [[Contains all the cards.]],
        GMNotes = "",
        Memo = "selfdestruct",
        ColorDiffuse = {(128/255), (128/255), (128/255)},
        Locked = false,
        Grid = true,
        Snap = true,
        IgnoreFoW = false,
        MeasureMovement = false,
        DragSelectable = true,
        Autoraise = true,
        Sticky = true,
        Tooltip = true,
        GridProjection = false,
        HideWhenFaceDown = false,
        Hands = true,
        ContainedObjects = {},
        LuaScript = [[]],
      }

      print(printTable(lagOfNormalCardList))

      table.insert(bagOfLag.ContainedObjects, {
        Name = "Deck",
        Transform = {
          scaleX = 1.25,
          scaleY = 1.0,
          scaleZ = 1.25,
          rotX = 0, rotY = 0, rotZ = 0,
        },
        Nickname = "Normals",
        Description = "One of every Normal, from every character.",
        GMNotes = "", Memo = "", ColorDiffuse = cardColor,
        Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
        Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
        DeckIDs = lagOfNormalIDList,
        CustomDeck = lagOfNormalCustomDeckList,
        ContainedObjects = lagOfNormalCardList,
      })

      table.insert(bagOfLag.ContainedObjects, {
        Name = "Deck",
        Transform = {
          scaleX = 1.25,
          scaleY = 1.0,
          scaleZ = 1.25,
          rotX = 0, rotY = 0, rotZ = 0,
        },
        Nickname = "Non-Normals",
        Description = "One of almost every non-Normal, from every character.",
        GMNotes = "", Memo = "", ColorDiffuse = cardColor,
        Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
        Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
        DeckIDs = lagOfNonNormalIDList,
        CustomDeck = lagOfNonNormalCustomDeckList,
        ContainedObjects = lagOfNonNormalCardList,
      })

      table.insert(bagOfLag.ContainedObjects, {
        Name = "Deck",
        Transform = {
          scaleX = 1.25,
          scaleY = 1.0,
          scaleZ = 1.25,
          rotX = 0, rotY = 0, rotZ = 0,
        },
        Nickname = "Separate",
        Description = "One of almost every card that starts outside any character's deck.",
        GMNotes = "", Memo = "", ColorDiffuse = cardColor,
        Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
        Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
        DeckIDs = lagOfSeparateIDList,
        CustomDeck = lagOfSeparateCustomDeckList,
        ContainedObjects = lagOfSeparateCardList,
      })

      table.insert(bagOfLag.ContainedObjects, {
        Name = "Deck",
        Transform = {
          scaleX = 1.25,
          scaleY = 1.0,
          scaleZ = 1.25,
          rotX = 0, rotY = 0, rotZ = 0,
        },
        Nickname = "Character",
        Description = "One of every character card.",
        GMNotes = "", Memo = "", ColorDiffuse = cardColor,
        Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
        Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
        DeckIDs = lagOfCharacterIDList,
        CustomDeck = lagOfCharacterCustomDeckList,
        ContainedObjects = lagOfCharacterCardList,
      })

      spawnObjectData({
        data = bagOfLag,
        position = {22, 12, 0},
      })

      --printTable(lagOfNormal)
      --printTable(lagOfNonNormal)

      --[========[
      local cardColor = {
        r = -0.713235259,
        g = -0.713235259,
        b = -0.713235259,
        a = 0.9,
      }

      local lagData = {}
      local lagCustomDeckList = {}

      local alternate = true



      local deckDescription = "The Deck of Lag"

      local deckIDList = {}
      local deckCardList = {}
      local deckCustomDeckList = {}

      local characterIDList = {}
      local characterCardList = {}
      local characterCustomDeckList = {}

      local separateIDList = {}
      local separateCardList = {}
      local separateCustomDeckList = {}

      local normalIDList = {}
      local normalCardList = {}
      local normalCustomDeckList = {}

      local appendix = {}

      local count = 0

      -- For each sheet of Normals...
      -- TODO: registeredNormals
      Global.setVar("debugFlag", true)
      for normalsName,normalsTable in pairs(registeredNormals) do
        debugLog{"normalsName: "..normalsName, 2}
        for normalsSet,normalsSetTable in pairs(normalsTable.sets) do
          debugLog{"  normalsSet: "..normalsSet, 2}
          local currentNormalsOwner = getObjectFromGUID(normalsTable.ownerGUID)
          local ownerNormalsSheets = currentNormalsOwner.getVar("normalsSheets")
          local currentNormalsSheet = returnTableCopy(ownerNormalsSheets[normalsName][normalsSet])
          local currentNormalsSuffix = currentNormalsSheet.suffix or [[ (N)]]
          -- Loop through all registered Normals entries...
          for currentNormals,thisSheet in pairs(currentNormalsSheet) do

            -- TODO: this.

            if normalsSubdeck["deckID"] != nil then
              debugLog{ " normals Subdeck non-loop", 4, {1,1,0,} }
              if deckCustomDeckList[normalsSubdeck["deckID"]] == nil then
                deckCustomDeckList[normalsSubdeck["deckID"]] = {
                  FaceURL = normalsSubdeck["faceURL"],
                  BackURL = backURL,
                  NumWidth = normalsSubdeck["gridWidth"],
                  NumHeight = normalsSubdeck["gridHeight"],
                  BackIsHidden = normalsSubdeck["hiddenBack"],
                  UniqueBack = false,
                  Type = 0,
                }
              end
            end -- end 'if normalsSubdeck["deckID"] != nil'

            -- Loop through the Normals and add them to the data table.
            for j,thisNormal in ipairs(normalsSubdeck["cardList"]) do
              --debugLog{ "    normals cardList loop", 2, {0,1,1,} }
              --debugLog{" normals faceURL: "..normalsSubdeck["faceURL"], 2}
              -- 'thisNormal' should be one of the individual cards.
              local copies = thisNormal["copies"] or 1
              local normalDecals = {}
              if thisNormal["cardDecals"] != nil then
                for key,val in ipairs(thisNormal["cardDecals"]) do
                  table.insert(normalDecals, val)
                end
              end
              local normalCardDesc = thisNormal["cardDescription"] or deckName
              local normalScriptAppendix = thisNormal["cardScript"] or [[]]

              --debugLog{ "normalAppendix: "..normalAppendix, 5, {1,0,1}}

              while copies > 0 do
                local normalAppendix = getCardData({
                  cardBack        = backURL,
                  cardDecals      = normalDecals,
                  cardDescription = normalCardDesc,
                  cardFace        = normalsSubdeck["faceURL"],
                  cardGMNotes     = normalCardDesc.."."..normalsSubdeck["deckID"].."."..thisNormal["cardID"],
                  cardNickname    = thisNormal["cardNickname"],
                  cardID          = thisNormal["cardID"],
                  cardScript      = normalScriptAppendix,
                  cardSnap        = true,
                  deckID          = normalsSubdeck["deckID"],
                  gridWidth       = normalsSubdeck["gridWidth"],
                  gridHeight      = normalsSubdeck["gridHeight"],
                  hiddenBack      = normalsSubdeck["hiddenBack"],
                  tooltip         = normalsSubdeck["tooltip"],
                  transform       = transformFacingYou,
                })
                --debugLog{ "        normals per-copy loop", 3, {1,1,1,} }
                if thisNormal["separate"] == true then
                  table.insert(separateIDList, normalsSubdeck["deckID"]..thisNormal["cardID"])
                  table.insert(separateCardList, normalAppendix)
                else
                  table.insert(deckIDList, normalsSubdeck["deckID"]..thisNormal["cardID"])
                  table.insert(deckCardList, normalAppendix)
                end -- end if then statement
                copies = copies-1
              end -- end per-copy loop
            end -- end per-card Normals loop








            -- For each set of Normals...
            for normalsSubsetIndex,thisSubset in pairs(thisSheet) do
              count = count+1
              thisDeckID = count
              --debugLog{ "   normals: "..currentNormals, 1, {1, 1, 0} }
              -- If alternate mode is on, use the replacement face URL.
              local cardFace = thisSubset["faceURL"]
              local cardBack = backURL
              if alternate == true then
                cardFace = thisSubset["altfaceURL"] or cardFace
              end
              -- 'thisSubdeck' should be the value, meaning one of the subdeck tables.
              --debugLog{ "         cardFace: "..cardFace, 2, {0, 1, 0} }
              appendix = [[
              "]]..thisDeckID..[[": {
                      "FaceURL": "]]..cardFace..[[",
                      "BackURL": "]]..cardBack..[[",
                      "NumWidth": ]]..thisSubset["gridWidth"]..[[,
                      "NumHeight": ]]..thisSubset["gridHeight"]..[[,
                      "BackIsHidden": true,
                      "UniqueBack": false,
                      "Type": 0
                    },
            ]]
              normalCustomDeckList[thisDeckID] = {
                FaceURL = cardFace,
                BackURL = cardBack,
                NumWidth = thisSubset["gridWidth"],
                NumHeight = thisSubset["gridHeight"],
                BackIsHidden = true,
                UniqueBack = false,
                Type = 0,
              }

              -- For each of the 8 standard Normals...
              for index,thisNormal in pairs({ "Grasp", "Cross", "Assault", "Dive", "Spike", "Sweep", "Focus", "Block"}) do
                debugLog{ "      this normal: "..thisNormal, 1, {0.7,0.7,0} }
                debugLog{ "   indexed normal: "..thisSubset[thisNormal], 1, {0.5,0.5,0} }
                local cardDesc = currentNormals
                local cardListAppendix = getCardData({
                  cardColor       = cardColor,
                  cardBack        = cardBack,
                  cardDescription = cardDesc,
                  cardFace        = cardFace,
                  cardGMNotes     = cardDesc.."."..thisDeckID.."."..thisSubset[thisNormal],
                  cardNickname    = thisNormal,
                  cardID          = thisSubset[thisNormal],
                  deckID          = thisDeckID,
                  gridWidth       = thisSubset["gridWidth"],
                  gridHeight      = thisSubset["gridHeight"],
                  hiddenBack      = true,
                })

                table.insert(normalIDList, thisDeckID..thisSubset[thisNormal])
                table.insert(normalCardList, cardListAppendix)
              end -- end per-Normal loop
            end -- end per-Normal-set loop
          end -- end per-Normal-sheet loop
        end
      end
      if true then return end

      -- For each entry in charTable...
      for i in pairs(charTable) do
        local thisChar = charTable[i]
        local deckName = i
        local deckList = thisChar.deck

        -- For each subdeck in the deck...
        for j,thisSubdeck in ipairs(deckList) do
          count = count+1
          -- Handle each subdeck in the deck list.
          --debugLog{ "    subdeck loop", 1 }
          local thisDeckID = count
          local cardBack = backURL
          if thisSubdeck["backURL"] != nil then
            --debugLog{ "unique card back", 0, {0.4,0.4,0.4,} }
            cardBack = thisSubdeck["backURL"]
          end

          -- If alternate mode is on, use the replacement face URL.
          local cardFace = thisSubdeck["faceURL"]
          if alternate == true then
            cardFace = thisSubdeck["altfaceURL"] or cardFace
          end
          -- 'thisSubdeck' should be the value, meaning one of the subdeck tables.
          --debugLog{ "         cardFace: "..cardFace, 2, {0, 1, 0} }
          appendix = [[
          "]]..thisDeckID..[[": {
                  "FaceURL": "]]..cardFace..[[",
                  "BackURL": "]]..cardBack..[[",
                  "NumWidth": ]]..thisSubdeck["gridWidth"]..[[,
                  "NumHeight": ]]..thisSubdeck["gridHeight"]..[[,
                  "BackIsHidden": ]]..thisSubdeck["hiddenBack"]..[[,
                  "UniqueBack": false,
                  "Type": 0
                },
        ]]
          deckCustomDeckList = deckCustomDeckList..appendix
          characterCustomDeckList = characterCustomDeckList..appendix
          separateCustomDeckList = separateCustomDeckList..appendix
          --debugLog{ "         appendix: "..appendix, 3, {1, 1, 0.3} }

          -- Handle each card in the card list inside this subdeck.
          for j,thisCard in ipairs(thisSubdeck["cardList"]) do
            --debugLog{ "      cardList loop", 2 }
            --debugLog{ "         cardFace: "..cardFace, 2, {0, 1, 0} }
            --debugLog{ "         cardBack: "..cardBack, 2, {0, 1, 0} }
            local thisCardDesc = thisCard["cardDescription"] or deckName
            local scriptAppendix = thisCard["cardScript"] or [[]]
            local cardDecals = thisCard["cardDecals"]

            cardListAppendix = getCardData({
              cardColor       = cardColor,
              cardBack        = cardBack,--string,
              cardDecals      = cardDecals,
              cardDescription = thisCardDesc,--string,
              cardFace        = cardFace,--string,
              cardGMNotes     = deckName.."."..thisDeckID.."."..thisCard["cardID"],
              cardMemo        = thisCard["cardMemo"],
              cardNickname    = thisCard["cardNickname"],--string,
              cardID          = thisCard["cardID"],--string or int,
              cardScript      = scriptAppendix,--string,
              cardSnap        = thisCard["cardSnap"],--string
              deckID          = thisDeckID,--string or int,
              gridWidth       = thisSubdeck["gridWidth"],--string or int,
              gridHeight      = thisSubdeck["gridHeight"],--string or int,
              hiddenBack      = thisSubdeck["hiddenBack"],--string (like boolean),
              tooltip         = thisCard["tooltip"],--string (like boolean)
            })
            if thisCard["cardNickname"] == thisChar["charCard"] and thisCard["bannedInLag"] != true then
              --debugLog{ " adding to character deck: "..thisCard["cardNickname"], 2, {0.7, 0.7, 0} }
              -- If the card's name exactly matches the character card name, add it to the Character Deck (as long as it isn't banned from Lag formats).
              characterIDList = characterIDList..thisDeckID..thisCard["cardID"]..[[,
  ]]
              characterCardList = characterCardList..cardListAppendix
            elseif thisCard["reference"] == true and thisCard["separate"] != true and thisCard["bannedInLag"] != true then
              --debugLog{ " adding to attack deck: "..thisCard["cardNickname"], 2, {1, 0, 0.7} }
              -- If the card would normally generate a reference, would be in a deck, and is not separate (and it isn't banned from Lag formats), add it to the Attack Deck.
              if thisCard["copies"] != 0 then
                deckIDList = deckIDList..thisDeckID..thisCard["cardID"]..[[,
  ]]
                deckCardList = deckCardList..cardListAppendix
              end
            else
              local copies = thisCard["copies"] or 1
              while copies > 0 do
                --debugLog{ " adding to other deck: "..thisCard["cardNickname"], 2, {0, 0.7, 0.7} }
                -- Otherwise, add it to the deck of other stuff.
                separateIDList = separateIDList..thisDeckID..thisCard["cardID"]..[[,
    ]]
                separateCardList = separateCardList..cardListAppendix
                copies = copies-1
              end
            end
            --debugLog{ "         appendix: "..appendix, 3, {0.7, 0.9, 0} }
          end -- end "for each card in cardList"
        end -- end "for each subdeck in deck"
      end -- end "for each entry in charTable"

      local middleJSON = [[",
      "GMNotes": "",
      "Memo": "",
      "ColorDiffuse": ]]..cardColorString..[[,
      "Locked": false,
      "Grid": true,
      "Snap": true,
      "IgnoreFoW": false,
      "MeasureMovement": false,
      "DragSelectable": true,
      "Autoraise": true,
      "Sticky": true,
      "Tooltip": true,
      "GridProjection": false,
      "HideWhenFaceDown": false,
      "Hands": false,
      "SidewaysCard": false,
      "DeckIDs": [
    ]]

      local lagJSON = [[]]
      lagJSON = [=========[
      {
            "Name": "Bag",
            "Transform": {
              "scaleX": 2.0,
              "scaleY": 2.0,
              "scaleZ": 2.0
            },
            "Nickname": "The Bag of Lag",
            "Description": "Contains all the cards.",
            "GMNotes": "",
            "Memo": "selfdestruct",
            "ColorDiffuse": ]=========]..cardColorString..[=========[,
            "Locked": false,
            "Grid": true,
            "Snap": true,
            "IgnoreFoW": false,
            "MeasureMovement": false,
            "DragSelectable": true,
            "Autoraise": true,
            "Sticky": true,
            "Tooltip": true,
            "GridProjection": false,
            "HideWhenFaceDown": false,
            "Hands": true,
            "ContainedObjects": [
    ]=========]

      -- Normals being loaded first should mean they're at the bottom of the bag.
      if normalIDList != [[]] then
        lagJSON = lagJSON..[=========[
    {
          "Name": "Deck",
          "Transform": {
            "scaleX": 1.0,
            "scaleY": 1.0,
            "scaleZ": 1.0
          },
          "Nickname": "Normals",
          "Description": "Deck of Lag: Normals]=========]..middleJSON..normalIDList..[=========[
          ],
          "CustomDeck": {
          ]=========]..normalCustomDeckList..[=========[
          },
          "ContainedObjects": [
    ]=========]..normalCardList..[=========[
    ],
          "GUID": "312698"
        },]=========]
      end -- finish adding Normals

      -- Separate cards.
      if separateIDList != [[]] then
        lagJSON = lagJSON..[=========[
    {
          "Name": "Deck",
          "Transform": {
            "scaleX": 1.0,
            "scaleY": 1.0,
            "scaleZ": 1.0
          },
          "Nickname": "Unique & Separate Cards",
          "Description": "Deck of Lag: Other]=========]..middleJSON..separateIDList..[=========[
          ],
          "CustomDeck": {
          ]=========]..separateCustomDeckList..[=========[
          },
          "ContainedObjects": [
    ]=========]..separateCardList..[=========[
    ],
          "GUID": "312698"
        },]=========]
      end -- finish adding side cards

      -- Load the character cards in the middle.
      if characterIDList != [[]] then
        lagJSON = lagJSON..[=========[
    {
      "Name": "Deck",
      "Transform": {
        "scaleX": 1.0,
        "scaleY": 1.0,
        "scaleZ": 1.0
      },
      "Nickname": "Character Cards",
      "Description": "Deck of Lag: Characters]=========]..middleJSON..characterIDList..[=========[
      ],
      "CustomDeck": {
      ]=========]..characterCustomDeckList..[=========[
      },
      "ContainedObjects": [
    ]=========]..characterCardList..[=========[
    ],
        "GUID": "312695"
      },]=========]
    end -- finish adding character cards

    -- Adding the Deck of Lag to the end should mean it loads as the topmost item.
    if deckIDList != [[]] then
      lagJSON = lagJSON..[=========[
  {
        "Name": "Deck",
        "Transform": {
          "scaleX": 1.0,
          "scaleY": 1.0,
          "scaleZ": 1.0
        },
        "Nickname": "Attack Cards",
        "Description": "Deck of Lag: Attacks]=========]..middleJSON..deckIDList..[=========[
        ],
        "CustomDeck": {
        ]=========]..deckCustomDeckList..[=========[
        },
        "ContainedObjects": [
  ]=========]..deckCardList..[=========[
  ],
        "GUID": "312696"
      },]=========]
    end -- finish adding main deck

    -- Add the rules to the top of the bag.
    lagJSON = lagJSON..[=========[
    {
      "Name": "Notecard",
      "Transform": {
        "scaleX": 1.0,
        "scaleY": 1.0,
        "scaleZ": 1.0,
      },
      "Nickname": "Mystery Deck Draft (2)",
      "Description": "III. Repeat II, but pass to the right.\r\n\r\nIV. Players may replace their default character with a character they drafted. They then choose 14 cards to combine with a Normals set to form their deck.\r\n\r\nV. FIGHT!",
      "GMNotes": "",
      "Memo": "",
      "ColorDiffuse": {
        "r": 1.0,
        "g": 1.0,
        "b": 1.0
      },
      "Locked": false,
      "Grid": true,
      "Snap": true,
      "IgnoreFoW": false,
      "MeasureMovement": false,
      "DragSelectable": true,
      "Autoraise": true,
      "Sticky": true,
      "Tooltip": true,
      "GridProjection": false,
      "HideWhenFaceDown": false,
      "Hands": false,
      "LuaScript": "",
      "LuaScriptState": "",
      "XmlUI": "",
      "GUID": "0362f2"
    },
    {
      "Name": "Notecard",
      "Transform": {
        "scaleX": 1.0,
        "scaleY": 1.0,
        "scaleZ": 1.0,
      },
      "Nickname": "Mystery Deck Draft (1)",
      "Description": "I. The Deck of Lag shall contain 1 copy of every* non-Normal attack and character card.\r\n\r\nII. Deal a pack of 10 cards to each player.\r\nA) Each player chooses one card to keep, then sets the rest aside.\r\nB) When all players have chosen one, they pass their packs to the left.\r\nC) Repeat until each player has 10 cards.",
      "GMNotes": "",
      "Memo": "",
      "ColorDiffuse": {
        "r": 1.0,
        "g": 1.0,
        "b": 1.0
      },
      "Locked": false,
      "Grid": true,
      "Snap": true,
      "IgnoreFoW": false,
      "MeasureMovement": false,
      "DragSelectable": true,
      "Autoraise": true,
      "Sticky": true,
      "Tooltip": true,
      "GridProjection": false,
      "HideWhenFaceDown": false,
      "Hands": false,
      "LuaScript": "",
      "LuaScriptState": "",
      "XmlUI": "",
      "GUID": "0362f2"
    },
    {
      "Name": "Notecard",
      "Transform": {
        "scaleX": 1.0,
        "scaleY": 1.0,
        "scaleZ": 1.0,
      },
      "Nickname": "Mystery Deck Tour",
      "Description": "I. The Deck of Lag shall contain one copy of every* attack and character card.\r\n\r\nII. Shuffle it and deal 30 to each player.\r\n\r\nIII. Each player draws a random* character to be their starting character.\r\n\r\nIV. FIGHT!",
      "GMNotes": "",
      "Memo": "",
      "ColorDiffuse": {
        "r": 1.0,
        "g": 1.0,
        "b": 1.0
      },
      "Locked": false,
      "Grid": true,
      "Snap": true,
      "IgnoreFoW": false,
      "MeasureMovement": false,
      "DragSelectable": true,
      "Autoraise": true,
      "Sticky": true,
      "Tooltip": true,
      "GridProjection": false,
      "HideWhenFaceDown": false,
      "Hands": false,
      "LuaScript": "",
      "LuaScriptState": "",
      "XmlUI": "",
      "GUID": "0362f4"
    },
    {
      "Name": "Notecard",
      "Transform": {
        "scaleX": 1.0,
        "scaleY": 1.0,
        "scaleZ": 1.0,
      },
      "Nickname": "Surviving Mystery Deck (2)",
      "Description": "C) Unique cards are spawned as necessary to resolve effects. They are not automatically placed anywhere, though, so effects that merely move Markers around will do nothing.\r\n\r\nD) Unique cards are NOT spawned just because something checks if they exist. Attacks that calculate Range from unique cards are dead unless you can acquire the component.",
      "GMNotes": "",
      "Memo": "",
      "ColorDiffuse": {
        "r": 1.0,
        "g": 1.0,
        "b": 1.0
      },
      "Locked": false,
      "Grid": true,
      "Snap": true,
      "IgnoreFoW": false,
      "MeasureMovement": false,
      "DragSelectable": true,
      "Autoraise": true,
      "Sticky": true,
      "Tooltip": true,
      "GridProjection": false,
      "HideWhenFaceDown": false,
      "Hands": false,
      "LuaScript": "",
      "LuaScriptState": "",
      "XmlUI": "",
      "GUID": "0362f3"
    },
    {
      "Name": "Notecard",
      "Transform": {
        "scaleX": 1.0,
        "scaleY": 1.0,
        "scaleZ": 1.0,
      },
      "Nickname": "Surviving Mystery Deck (1)",
      "Description": "A) Characters may be included in decks. Characters are named, invalid, and worth 1 Force.\r\n\r\nB) Players have \"As an action, you may discard your character from the board to play a Normal Mode character from your hand in the same space if possible.\"",
      "GMNotes": "",
      "Memo": "",
      "ColorDiffuse": {
        "r": 1.0,
        "g": 1.0,
        "b": 1.0
      },
      "Locked": false,
      "Grid": true,
      "Snap": true,
      "IgnoreFoW": false,
      "MeasureMovement": false,
      "DragSelectable": true,
      "Autoraise": true,
      "Sticky": true,
      "Tooltip": true,
      "GridProjection": false,
      "HideWhenFaceDown": false,
      "Hands": false,
      "LuaScript": "",
      "LuaScriptState": "",
      "XmlUI": "",
      "GUID": "0362f3"
    },
    {
      "Name": "Notecard",
      "Transform": {
        "scaleX": 1.0,
        "scaleY": 1.0,
        "scaleZ": 1.0,
      },
      "Nickname": "Mystery Deck Info",
      "Description": "The Bag of Lag contains these rules, plus four decks:\r\n- Specials & Ultras\r\n- Characters (excluding banned characters)\r\n- Normals\r\n- Other (unique cards, attacks that begin out of play, and any banned cards)\r\n\r\nBuild your Deck of Lag by combining these as appropriate to your chosen format.",
      "GMNotes": "",
      "Memo": "",
      "ColorDiffuse": {
        "r": 1.0,
        "g": 1.0,
        "b": 1.0
      },
      "Locked": false,
      "Grid": true,
      "Snap": true,
      "IgnoreFoW": false,
      "MeasureMovement": false,
      "DragSelectable": true,
      "Autoraise": true,
      "Sticky": true,
      "Tooltip": true,
      "GridProjection": false,
      "HideWhenFaceDown": false,
      "Hands": false,
      "LuaScript": "",
      "LuaScriptState": "",
      "XmlUI": "",
      "GUID": "0362f5"
    },]=========]


          lagJSON = lagJSON..[=========[
          ],
          "Rigidbody": {
            "Mass": "50",
            "Drag": 0.1,
            "AngularDrag": 0.1,
            "UseGravity": true
          },
          "GUID": "cc2048"
        }
    ]=========]

      -- Actually spawn the Bag of Lag.
      if deckIDList != [[]] or characterIDList != [[]] or separateIDList != [[]] then
        spawnObjectJSON({
          json = lagJSON,
          position = {0, 20, 0},
        })
        broadcastToAll(player.steam_name.." HAS SUMMONED THE BAG OF LAG!", player.color)
        --[==[]==]
          MusicPlayer.repeat_track = false
          MusicPlayer.setCurrentAudioclip({url="https://steamusercontent-a.akamaihd.net/ugc/1666859915892650452/AB1DE195C6FB7E887EC8F4DB1C1DF4A181E64042/",title="MEGALOVANIA copyright Toby Fox"})
        --]==]
        return false
      end
    --]========]
    else
      player.broadcast("Sorry, this feature is currently undergoing maintenance.", {1,0.7,1})
    end -- end 'if player.steam_name == "tirankin"'
  end -- end "if message == !deckoflag"
end -- end onChat


function onObjectDestroy(dying_object)
  thisGUID = dying_object.getGUID()
  --debugLog{ "dying object: "..thisGUID, 1}
  for i,thisPlayer in pairs({ "Red", "Blue", "Yellow", "Green", "Orange", "Purple" }) do
    playerSearch = _G["activeSearch"..thisPlayer]
    if playerSearch == thisGUID then
      --debugLog{ "i: "..i, 4, {1,1,0} }
      --debugLog{ "Search for player: "..thisPlayer, 1, {0.9, 0.9, 0.3} }
      --debugLog{ "   searchID: "..playerSearch, 2, {0,1,0} }
      _G["activeSearch"..thisPlayer] = nil
    end
  end
end -- end onObjectDestroy



function onObjectDrop(player_color, obj)
  -- Added for April Fool's 2021. Then left in.
  if obj.getName() == [[Hakumen (C)]] then
    local oldScale = {
      x = obj.getScale().x,
      y = obj.getScale().y,
      z = obj.getScale().z
    }
    local newScale = {
      x = oldScale.x*1.01,
      y = oldScale.y*1.01,
      z = oldScale.z*1.01
    }
    obj.setScale(newScale)
  end
end -- end onObjectDrop



function onObjectLeaveContainer(container, obj)
  -- When an object is removed from a self-destruct bag, eliminate the source.
  debugLog{ "object left container: "..container.getName(), 5 }

  -- Leftover April Fool's joke.
  if obj.getName() == [[Secret Skull Man 33]] then
    broadcastToAll("Careful with that. If something goes wrong, delete the object and change colors, or rehost the server.")
  end

  local note = container.getMemo() or [[]]

  --debugLog{ " note: "..note, 3}

  -- If the note is "selfdestruct", destroy the container.
  local destructible = string.find(note, "selfdestruct")
  if destructible != nil then
    --debugLog{ " destructing", 3}
    --debugLog{ "  held by color: "..container.held_by_color, 3}
    if #container.getObjects() == 0 then
        container.destruct()
    end
  end
end -- end onObjectLeaveContainer



function onObjectSearchEnd(obj, player_color)
  if player_color == "Red" or player_color == "Blue" or player_color == "Yellow" or player_color == "Green" or player_color == "Orange" or player_color == "Purple" then
    --debugLog{ player_color.." stopped searching", 2, {1, 1, 0} }
    _G["activeSearch"..player_color] = nil
  end
end -- end onObjectSearchEnd



function onObjectSearchStart(obj, player_color)
  if player_color == "Red" or player_color == "Blue" or player_color == "Yellow" or player_color == "Green" or player_color == "Orange" or player_color == "Purple" then
    --debugLog{ player_color.." started searching", 2, {1, 1, 0} }
    _G["activeSearch"..player_color] = obj.getGUID()
  end
end -- end onObjectSearchStart



function onPlayerChangeColor(player_color)
  if player_color != "Grey" and player_color != "Black" then
    --debugLog{ "player changed color to "..player_color, 2, player_color }
    if selectNormals[player_color] == true then
      uiClick_SelectNormals(Player[player_color], "-1", "SelectNormals")
    end
  end

  --[=[ Example call for addNormalsSet.
  addNormalsSet({
    {
      setName = [[Taokaka]], subdecks = {
        Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aytQYfM.jpg",
          cardIDs = { Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07", }, },
      }, -- end subdeck list
    }, -- end deck table
    {
      setName = [[Vatista]], subdecks = {
        UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iJ2OqiY.jpg",
          cardIDs = { Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07", }, }
      }, -- end subdeck list
    } -- end deck table
  })
  --]=]
end -- end onPlayerChangeColor



function onPlayerConnect(player)
  local reloadXml = self.UI.getXmlTable()
  self.UI.setXmlTable(reloadXml)
end -- end onPlayerConnect



-- Copy/pasted from Lua documentation. Traverses a table following the order of its keys.
function pairsByKeys (t, f)
      local a = {}
      for n in pairs(t) do table.insert(a, n) end
      table.sort(a, f)
      local i = 0      -- iterator variable
      local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
      end
      return iter
end -- end pairsByKeys



function printTable(thisTable, indentation)
  local indent = indentation or [[]]
  indent = indent.."_ "
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
  elseif type(thisTable) == [[function]] then
    printString = printString..[=[[00FFFF]is a function[-]]=]
  else
    --local value = thisTable or "nil"
    printString = printString..[=[[00FFFF]value: ]=]..thisTable..[=[[-]]=]
    --printToAll(indent.."value: "..thisTable, {0,1,1})
  end
  return printString
end -- end printTable



function passwordUpdate(params)
  local playerColor = params.playerColor
  local playerReference = params.playerReference
  local appendix = params.appendix

  if playerReference == nil then
    playerReference = Player[playerColor]
  end

  debugLog{" player color: "..playerReference.color, 5}
  debugLog{" player steam_id: "..playerReference.steam_id, 5}
  debugLog{" password appendix: "..appendix, 5}
  if playerPasswords[playerReference.steam_id] != nil then
    -- Append to the player's current playerPasswords entry.
    debugLog{"   appending to password entry", 4, {1,1,0}}
    playerPasswords[playerReference.steam_id] = playerPasswords[playerReference.steam_id]..[[ | ]]..appendix
  else
    debugLog{"   creating password entry", 4, {0,1,1}}
    -- If the player hasn't clicked anything, their playerPasswords entry will be nil.
    playerPasswords[playerReference.steam_id] = appendix
  end
end -- end passwordUpdate



function registerCharacter(params)
  local ownerGUID    = params.ownerGUID
  local character    = params.characterName
  local secretChance = params.secretChance or 1
  local password     = params.secretPassword

  local seasons      = params.seasons
  if seasons == nil then seasons = { "Any", } end

  local active       = params.active
  if active == nil then active = true end

  if type(character) != [[string]] then
    debugLog{"error: registerCharacter run with character type "..type(character), 0, {1,0,0}}
    --debugLog{"   character type: "..type(character), 0, {1,1,0}}
    --debugLog{"   ownerGUID type: "..type(ownerGUID), 0, {1,1,0}}
    return
  else

    local activeString = nil
    if active == true then
      debugLog{"   active: true", 4, {1,1,0}}
      activeString = "active"
    else
      debugLog{"   active: false", 4, {1,1,0}}
      activeString = "inactive"
    end

    debugLog{"registering "..character, 4}

    -- "All" is a special entry in randomSeasons.
    -- It always contains all registered characters.
    if randomSeasons["All"][character] != nil then
      debugLog{"character "..character.." already registered; attempting to set to "..activeString, 4}
      if type(ownerGUID) != [[string]] then
        debugLog{"no ownerGUID to match; setting character "..character.." to "..activeString, 4}
        randomSeasons["All"][character].active = active
      elseif randomSeasons["All"][character].ownerGUID == ownerGUID then
        debugLog{"setting character "..character.." matching ownerGUID: "..ownerGUID.." to "..activeString, 4}
        randomSeasons["All"][character].active = active
      else
        debugLog{"warning: character "..character.." did not match ownerGUID: "..ownerGUID, 0, {1,1,0}}
      end
    else
      --debugLog{"      registering character "..character.." to season [[All]] with ownerGUID: "..ownerGUID.." as "..activeString, 3}
      randomSeasons["All"][character] = { ownerGUID = ownerGUID, secretChance = secretChance, active = active, }
    end -- finish 'if randomSeasons["All"][character] != nil'

    -- Handle all the non-"All" seasons.
    for i,thisSeason in ipairs(seasons) do
      -- If the character's season isn't registered at all, set it up.
      if randomSeasons[thisSeason] == nil then
        debugLog{"   instantiating season "..thisSeason, 3}
        randomSeasons[thisSeason] = {}
      else
        if randomSeasons[thisSeason][character] != nil then
          debugLog{"character "..character.." already registered in season "..thisSeason.." board; attempting to set to "..activeString, 4}
          if type(ownerGUID) != [[string]] then
            debugLog{"no ownerGUID to match; setting character "..character.." to "..activeString, 4}
            randomSeasons[thisSeason][character].active = active
          elseif randomSeasons[thisSeason][character].ownerGUID == ownerGUID then
            debugLog{"setting character "..character.." matching ownerGUID: "..ownerGUID.." to "..activeString, 4}
            randomSeasons[thisSeason][character].active = active
          else
            debugLog{"warning: character "..character.." in season "..thisSeason.." did not match ownerGUID: "..ownerGUID, 0, {1,1,0}}
          end
        else
          --debugLog{"      registering "..character.." to season "..thisSeason.." board as "..activeString, 3}
          randomSeasons[thisSeason][character] = { ownerGUID = ownerGUID, secretChance = secretChance, active = active, }
        end -- end 'if randomSeasons[thisSeason][character] != nil'
      end -- end 'if randomSeasons[thisSeason] == nil'
    end -- finish looping through seasons table

    -- If the character has a password, add it to passwordsTable.
    if password != nil and passwordsTable[character] == nil then
      -- If the password is a string, it's the only password.
      if type(password) == [[string]] then
        -- Decode it and add it to the table.
        passwordsTable[character] = dec(password)
      -- If the password is a table, there are multiple passwords.
      elseif type(password) == [[table]] then
        passwordsTable[character] = {}
        -- Decode and insert each of the passwords in the table.
        for i,pass in ipairs(password) do
          table.insert(passwordsTable[character], dec(pass))
        end -- finish adding passwords from the table of passwords
      end -- finish type check
    end -- finish 'if password != nil and ...'
  end -- finish checking type of character parameter
end -- end registerCharacter



--[=[
registerNormals({
  normalsName = normalsName, -- string; used to identify the Normals by name
  ownerGUID = ownerGUID, -- string; denotes the GUID of the data-owner for a given set of Normals
  toggleID = toggleID, -- string; denotes the ID of a UI element, sans the owner GUID and player color
  sets = { Normals = true, UNNormals = true, }, -- table; each key in this table denotes a supported set of Normals
})
--]=]
function registerNormals(params)
  local normalsName = params.normalsName
  local ownerGUID = params.ownerGUID
  local toggleID = params.toggleID

  local sets = nil
  if params.sets != nil then
    sets = returnTableCopy(params.sets)
  end

  -- If neither normalsName nor ownerGUID are provided, kick an error.
  if type(normalsName) != "string" and type(ownerGUID) != "string" then
    debugLog{"error: registerNormals running on non-string value (type "..type(normalsName)..")", 0, {1,0,0}}
    return
  -- if ownerGUID is provided but normalsName is not, reactivate all Normals with the specified ownerGUID.
  elseif type(normalsName) != "string" and type(ownerGUID) == "string" then
    for thisNormals,normalsTable in pairs(registeredNormals) do
      if normalsTable.ownerGUID == ownerGUID then
        debugLog{"activating registered Normals <"..thisNormals.."> matching ownerGUID: "..ownerGUID, 4}
        normalsTable.active = true
      else
        debugLog{"registered Normals <"..thisNormals.."> do not match ownerGUID: "..ownerGUID, 4}
      end
    end
  -- If normalsName is provided but ownerGUID is not, reactivate the specified Normals if they are registered.
  elseif type(normalsName) == "string" and type(ownerGUID) != "string" then
    if registeredNormals[normalsName] != nil then
      debugLog{"activating registered Normals <"..normalsName..">", 4}
      registeredNormals[normalsName].active = true
    else
      debugLog{"error: could not activate unregistered Normals <"..normalsName..">", 0, {1,0,0}}
    end
  -- If normalsName and ownerGUID are provided, either register or activate a Normals entry.
  elseif type(normalsName) == "string" and type(ownerGUID) == "string" then
    debugLog{"registering or activating Normals <"..normalsName..">", 4, {0,1,1}}

    -- The standard Normals are supported by default.
    if sets == nil then
      sets = { Normals = true, }
    end

    -- If the specified Normals are already registered, activate them, but only if they match the given ownerGUID.
    if registeredNormals[normalsName] != nil then
      if registeredNormals[normalsName].ownerGUID == ownerGUID then
        debugLog{"reactivating registered Normals <"..normalsName.."> matching ownerGUID: "..ownerGUID, 4}
        registeredNormals[normalsName].active = true
      else
        debugLog{"warning: ownerGUID of registered Normals <"..normalsName.."> did not match ownerGUID: "..ownerGUID, 0, {1,1,0}}
      end
    -- If the specified Normals are not registered, create a new entry for them.
    else
      registeredNormals[normalsName] = { ownerGUID = ownerGUID, sets = sets, active = true, toggleID = toggleID, }
    end -- finish checking if the specified Normals are registered

    -- If a toggleID is supplied, either activate or register it.
    if type(toggleID) == [[string]] and type(ownerGUID) == [[string]] then
      -- If the specified Normals toggle has already been registered, activate it.
      if normalsToggleTable[ownerGUID..toggleID] != nil then
        debugLog{" activating normalsToggleTable entry: "..ownerGUID..toggleID, 3, {1,0,1}}
        normalsToggleTable[ownerGUID..toggleID].active = true
      -- If the specified Normals toggle hasn't been registered, register it.
      else
        debugLog{" registering normalsToggleTable entry: "..ownerGUID..toggleID, 3, {1,0,1}}
        normalsToggleTable[ownerGUID..toggleID] = { active = true, ownerGUID = ownerGUID, }
      end
    end -- finish checking toggleID

  end -- finish checking types of input parameters
end -- end registerNormals



function resetSelectNormalsStatus(params)
  local playerColor = params.playerColor
  local playerReference = Player[playerColor]
  if selectNormals[playerColor] == true then
    uiClick_SelectNormals(playerReference, "-1", "SelectNormals")
  end
end -- end resetSelectNormalsStatus



function returnTableCopy(sourceTable)
  local returnTable = {}
  if sourceTable != nil then
    for key,value in pairs(sourceTable) do
      --print("   key: "..key)
      if type(value) == "table" then
        --print("table")
        returnTable[key] = returnTableCopy(value)
      else
        --print("value type: "..type(value))
        returnTable[key] = value
      end
    end
  else
    --print("sourceTable is nil")
    return nil
  end
  return returnTable
end -- end returnTableCopy



function setPanelState(params)
  local panelGUID = params.ownerGUID
  local newState = params.state

  if panelGUID == nil then
    debugLog{"error: no panelGUID supplied", 0, {1,0,0}}
    return
  end

  if panels[panelGUID] == nil then
    debugLog{"error: no panel for panelGUID "..panelGUID, 0, {1,0,0}}
  else
    if newState == nil then
      newState = not panels[panelGUID].active
    end
    if newState != panels[panelGUID].active then
      panels[panelGUID].active = newState

      -- If the active state was updated, update the Normals dropdowns (since some of the Normals sets are probably inactive now).
      local myXmlTable = self.UI.getXmlTable()
      for i,thisPlayer in ipairs(allPlayers) do
        myXmlTable = updateNormalsDropdown({
          playerColor     = thisPlayer,     -- string; required
          currentXml      = myXmlTable,      -- table; defaults to self.UI.getXmlTable()
          updateXml       = false,       -- boolean; defaults to false
        })
      end -- end 'for i,thisPlayer in ...'
      self.UI.setXmlTable(myXmlTable)

    else
      debugLog{"warning: panel "..panelGUID.." state already matches new state", 1, {1,1,0}}
    end
  end

  if panels[panelGUID].active == true then
    debugLog{"panels["..panelGUID.."] set to active", 2}
  else
    debugLog{"panels["..panelGUID.."] set to inactive", 2}
  end
end -- end setPanelState



--[=[
spawnDeck({
  characterName   = -- string,
  ownerGUID       = -- string,
  playerColor     = -- string,
  deckList        = -- table (optional, and probably not a good idea),
  alternate       = -- boolean (optional, defaults to false),
  onlyNormals     = -- boolean (optional, defaults to false),
  deckDescription = -- string (optional)
})
--]=]
function spawnDeck(params)
  local debugLog        = debugLog
  local deckName        = params.characterName
  local characterCard   = params.charCard
  local ownerGUID       = params.ownerGUID
  local deckDescription = params.deckDescription -- Usually nil.
  local playerColor     = params.playerColor
  local randomRoll      = params.randomRoll
  local alternate       = params.alternate or false
  local onlyNormals     = params.onlyNormals or false

  local playerReference = Player[playerColor]
  local characterOwner = nil
  local ownerCharacters = {}
  local characterEntry = {}

  -- April Fool's 2023
  local flailingMode = Global.getVar("flailingMode")
  if flailingMode == true and ownerGUID != self.getGUID() then
    randomRoll = true
    ownerGUID = self.getGUID()
    local flailingNumber = math.random(1, #flailingCharactersTable)
    deckName = flailingCharactersTable[flailingNumber]
  end

  if type(deckName) != [[string]] then
    debugLog{"error: attempted to spawn deck for non-string characterName!", 0, {1,0,0}}
    return
  end

  if infoMode[playerColor] == true then
    player.broadcast([[This space intentionally (temporarily) left blank.]])
    --[=[ TODO: Fill this out.
    local rightClickColor = {1,0.65,0.55}
    local leftClickColor = {0.80,0.65,1}
    player.print([[--------]], {0.3,0.3,0.3})
    if value == "-1" then -- Left-click
      player.broadcast([[[FF4444]Left-click[-] to use whatever Normals your character would use in print.
[00FFFF]Right-click[-] to use reskinned versions of those Normals (if available).]])
      player.print([[This changes your current Normals setting.]])
      player.print([[[FF4444]Left-click:[-] Set Normals to <Default>.]], leftClickColor)
      player.print([[[00FFFF]Right-click:[-] Set Normals to <Default (Alternate)>.]], rightClickColor)
    else -- Right-click
      player.print([[When you spawn a character using the module's built-in character spawning functionality, they can use different Normals if those Normals support their Normals set (e.g., Normals, UNNormals).]])
      player.print([[Many Normals have reskins available; this usually entails visual improvements to make cards easier to distinguish from one another or text modifications to make effects easier to understand. (Reskins never change functionality.)]])
    end
    -- Since a toggle is being clicked, take care not to change the actual entry.
    local checkString = string.sub(id, string.len(player.color))
    checkString = string.sub(checkString, 19)
    if checkString == getCurrentNormals({ playerColor = player.color }) then
      self.UI.setAttributes(id, { isOn = true, })
    else
      self.UI.setAttributes(id, { isOn = false, })
    end
    --]=]
    return
  end

  -- If this character wasn't rolled randomly, update the player's current password string.
  if randomRoll != true then
    passwordUpdate({
      playerReference = playerReference,
      appendix = deckName,
    })
  end

  if type(ownerGUID) == [[string]] then
    characterOwner  = getObjectFromGUID(ownerGUID)
    ownerCharacters = characterOwner.getVar("charTable")
    characterEntry  = returnTableCopy(ownerCharacters[deckName])
  end

  if characterOwner == nil then characterOwner = self end
  if characterCard == nil then characterCard = characterEntry.charCard end

  --debugLog{"spawnDeck characterOwner type: "..type(characterOwner), 2}
  --debugLog{"spawnDeck ownerCharacters type: "..type(ownerCharacters), 2}
  --debugLog{"spawnDeck characterEntry type: "..type(characterEntry), 2}

  local deckList        = returnTableCopy(params.deckList)
  if characterEntry.deckReturnFunction != nil then
    deckList = characterEntry.deckReturnFunction()
  end
  if deckList == nil then deckList = returnTableCopy(characterEntry.deck) end

  local normalsList     = returnTableCopy(characterEntry.normalsList)
  if normalsList == nil then
    debugLog{"spawnDeck: no normalsList found for "..deckName, 3, {1, 0, 0} }
  else
    debugLog{"spawnDeck: normalsList found OK for "..deckName, 3, {0, 1, 0} }
  end
  -- The normalsList is replaced in "getNormalsSubdeck" instead.
  --if normalsList == nil then normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Assault]], [[Assault]], [[Dive]], [[Dive]], [[Spike]], [[Spike]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], } end

  if deckDescription == nil and deckName != nil then deckDescription = characterEntry.deckDescription end
  if deckDescription == nil then deckDescription = [[]] end

  -- Add the character's announcement(s) to the global list of announcements.
  if characterEntry.announcement != nil then
    --debugLog{" adding announcement: "..characterEntry.announcement, 2}
    Global.call("addAnnouncement", { announcement = characterEntry.announcement })
  end
  if characterEntry.announcementList != nil then
    for i,announcementListItem in pairs(characterEntry.announcementList) do
      --debugLog{" adding announcement list item: "..announcementListItem, 2}
      Global.call("addAnnouncement", { announcement = announcementListItem })
    end
  end

  -- [=[ Added for April Fool's 2022.
  debugLog{"Waldoing", 3}
  local newWaldoX = math.random(-1100, 1100)
  local newWaldoZ = math.random(-1300, 900)
  local compassX = newWaldoX
  local compassZ = newWaldoZ+860
  local sextantX = newWaldoX-80
  local sextantZ = newWaldoZ

  if compassZ == 0 then compassZ = 0.01 end
  if sextantZ == 0 then sextantZ = 0.01 end

  local waldoCompassAngle = (180 / math.pi) * math.atan( compassX / compassZ )
  local waldoSextantAngle = (180 / math.pi) * math.atan( sextantX / sextantZ )

  waldoCompassAngle = 270 + waldoCompassAngle
  waldoSextantAngle = 270 + waldoSextantAngle

  local newWaldoPosition = {
    x = newWaldoX,
    y = 1,
    z = newWaldoZ
  }
  waldoPosition = {
    x = newWaldoX,
    y = 1,
    z = (newWaldoZ),
  }

  local waldoCompass = getObjectFromGUID(waldoCompassGUID)
  if waldoCompass != nil then
    local waldoCompassPosition = waldoCompass.getPosition()
    if waldoCompassPosition.x > -36 and waldoCompassPosition.x < -33
    and waldoCompassPosition.z > -1.5 and waldoCompassPosition.z < 1.5 then
      waldoCompass.setRotation({
        x = waldoCompass.getRotation().x,
        y = waldoCompassAngle,
        z = waldoCompass.getRotation().z,
      })
    end
  end
  local waldoSextant = getObjectFromGUID(waldoSextantGUID)
  if waldoSextant != nil then
    local waldoSextantPosition = waldoSextant.getPosition()
    if waldoSextantPosition.x > 33 and waldoSextantPosition.x < 36
    and waldoSextantPosition.z > -8 and waldoSextantPosition.z < -5 then
      waldoSextant.setRotation({
        x = waldoSextant.getRotation().x,
        y = waldoSextantAngle,
        z = waldoSextant.getRotation().z,
      })
    end
  end

  self.UI.setAttributes([[Waldo (Fan-Made)]], {
    position = newWaldoPosition.x.." "..newWaldoPosition.z.." "..newWaldoPosition.y,
  })
  --]=]

  local screenRotation = characterOwner.getRotation()
  local xPositionOffset = 0
  local zPositionOffset = 0
  local yPositionOffset = 0
  local facingFactor = 1
  if screenRotation.z >= 90 and screenRotation.z < 270 then
    facingFactor = -1
  end

  local charPosition = {}
  charPosition.x = 0
  charPosition.y = 0
  charPosition.z = 0

  if characterEntry.position != nil then
    charPosition.x = characterEntry.position.x or 0
    charPosition.y = characterEntry.position.y or 0
    charPosition.z = characterEntry.position.z or 0
  end

  if screenRotation.y >= 45 and screenRotation.y < 135 then
    xPositionOffset = -1.1*facingFactor*charPosition.z
    yPositionOffset = charPosition.y
    zPositionOffset = -1.1*charPosition.x
  elseif screenRotation.y >= 135 and screenRotation.y < 225 then
    xPositionOffset = -1.1*facingFactor*charPosition.x
    yPositionOffset = facingFactor*charPosition.y
    zPositionOffset = 1.1*charPosition.z
  elseif screenRotation.y >= 225 and screenRotation.y < 315 then
    xPositionOffset = 1.1*facingFactor*charPosition.z
    yPositionOffset = facingFactor*charPosition.y
    zPositionOffset = 1.1*charPosition.x
  elseif screenRotation.y >= 315 or screenRotation.y < 45 then
    xPositionOffset = 1.1*facingFactor*charPosition.x
    yPositionOffset = facingFactor*charPosition.y
    zPositionOffset = -1.1*charPosition.z
  end

  local playerHandTransform = playerReference.getHandTransform() or {
    position = {
      x = xPositionOffset + characterOwner.getPosition().x,
      y = 10 + yPositionOffset + characterOwner.getPosition().y,
      z = zPositionOffset + characterOwner.getPosition().z,
    },
    rotation = characterOwner.getRotation(),
  }

  local cardColor = {}
  cardColor[1] = 0.713235259
  cardColor[2] = 0.713235259
  cardColor[3] = 0.713235259
  cardColor[4] = 1

  if characterEntry.borderColor != nil then
    debugLog{"updating cardColor with borderColor", 1}
    cardColor[1] = characterEntry.borderColor[1] or 0.713235259
    cardColor[2] = characterEntry.borderColor[2] or 0.713235259
    cardColor[3] = characterEntry.borderColor[3] or 0.713235259
    cardColor[4] = characterEntry.borderColor[4] or 1
  end

  -- Added for April Fool's 2021.
  local foilRoll = math.random(1,40)
  local glitchMode = Global.getVar("glitchMode")
  if foilRoll == 1 then
    playerReference.print([[ [9BFF37]A [-][37FF37]r[-][37FF9B]a[-][37FFFF]r[-][379BFF]e [-][3737FF]f[-][9B37FF]o[-][FF37FF]i[-][FF379B]l [-][FF3737]s[-][FF9B37]l[-][FFFF37]e[-][9BFF37]e[-][37FF37]v[-][37FF9B]e[-][37FFFF]d[-][379BFF] d[-][3737FF]e[-][9B37FF]c[-][FF37FF]k[-]![b] Everything's gotten brighter!]], {0.8,0.8,0.8})
    cardColor[1] = 5+(cardColor[1]*10)
    cardColor[2] = 5+(cardColor[2]*10)
    cardColor[3] = 5+(cardColor[3]*10)
  -- Added for April Fool's 2024
  elseif glitchMode == true then
    if foilRoll > 30 then
      -- Added for April Fool's 2025.
      playerReference.print([[Bonus!]], {255/255, 255/255, 255/255})
      Global.call("givePrizeToPlayer", {
        playerReference = playerReference,
        multiplier = 10,
      })
    elseif foilRoll > 25 then
      playerReference.broadcast([[Happy Valentine's Day!]], {245/255, 112/255, 206/255})
      cardColor[1] = 5
      cardColor[2] = 2
      cardColor[3] = 4
    elseif foilRoll > 20 then
      playerReference.broadcast([[Happy St. Patrick's Day!]], {50/255, 255/255, 50/255})
      cardColor[1] = 0
      cardColor[2] = 5
      cardColor[3] = 0
    elseif foilRoll > 19 then
      playerReference.broadcast([[Happy Mother's Day!]], {1,1,1})
    elseif foilRoll > 18 then
      playerReference.broadcast([[Happy Father's Day!]], {1,1,1})
    elseif foilRoll > 17 then
      playerReference.broadcast([[Happy Boxing Day!]], {1,1,1})
    elseif foilRoll > 16 then
      playerReference.broadcast([[Happy Cinco de Mayo!]], {1,1,1})
    elseif foilRoll > 15 then
      playerReference.broadcast([[Happy Rosh Hashanah!]], {1,1,1})
    elseif foilRoll > 14 then
      playerReference.broadcast([[Happy Halloween!]], {1,1,1})
    elseif foilRoll > 13 then
      playerReference.broadcast([[Happy Thanksgiving!]], {1,1,1})
    elseif foilRoll > 12 then
      playerReference.broadcast([[Happy New Year!]], {1,1,1})
    elseif foilRoll > 11 then
      playerReference.broadcast([[Happy unbirthday!]], {1,1,1})
    end
  end

  -- Set the attack back to the character's unique attack back, or to the default card back if there isn't one.
  local backURL = characterEntry.attackBack
  if backURL == nil then backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/igYZhPh.png]] end
  if characterEntry.attackBackReturnFunction != nil then
    backURL = characterEntry.attackBackReturnFunction()
  end

  -- Determine if this player has a table of vanity backs.
  local vanityBackTable = vanityBacks[playerReference.steam_name]
  if vanityBackTable == nil then vanityBackTable = vanityBacks[playerReference.steam_id] end

  -- If this player has a vanity back set for this character, override the predetermined back.
  if vanityBackTable != nil then
    backURL = vanityBackTable[deckName] or backURL
  end

  -- Meme cardback added for April Fool's 2021.
  local memeBackRoll = math.random(1,120) -- Formerly 1/40.

  -- Added for April Fool's 2024.
  local glitchMode = Global.getVar("glitchMode")
  if glitchMode == true then
    memeBackRoll = math.random(1,10)
  end

  if memeBackRoll == 1 then
    backURL = [[https://i.imgur.com/wTx8sqt.png]]
    -- Added for April Fool's 2025.
    Global.call("givePrizeToPlayer", {
      playerReference = playerReference,
      multiplier = 6,
      points = memeBackRoll,
    })
  -- Meme cardbacks added for April Fool's 2023.
  elseif memeBackRoll == 2 then
    backURL = [[https://i.imgur.com/IrKNc0U.png]]
    -- Added for April Fool's 2025.
    Global.call("givePrizeToPlayer", {
      playerReference = playerReference,
      multiplier = 2,
      points = memeBackRoll,
    })
  elseif memeBackRoll == 3 then
    backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3r47nAm.jpg]]
    -- Added for April Fool's 2025.
    Global.call("givePrizeToPlayer", {
      playerReference = playerReference,
      multiplier = 1.9,
      points = memeBackRoll,
    })
  end

  -- Each UNLOCKED costume, including the primary one, will be inserted in the costumeTable.
  local costumeTable = {}

  -- The index of the costumeTable entry that has the highest costumePriority.
  local highestCostumePriorityIndex = 1

  -- This got a little more complicated because we want to be able to override which State is the default.
  local deckNormals     = characterEntry.normals
  local deckNormalsSet  = characterEntry.normalsSet
  local deckNormalsDeck = characterEntry.normalsDeck
  local deckNormalsScript   = characterEntry.normalsScript
  local altbackURL      = characterEntry.altattackBack
  local charPosition    = characterEntry.position
  local charNormalsList = normalsList

  --debugLog{"cardColor: "..cardColor[1]..","..cardColor[2]..","..cardColor[3]..","..cardColor[4], 2}

  costumeTable[1] = {
    priority = 1,
    jsonParams = {
      deckName          = deckName,
      deckDescription   = deckDescription,
      characterCard     = characterCard,
      deckList          = deckList,
      deckNormals       = deckNormals,
      deckNormalsSet    = deckNormalsSet,
      deckNormalsDeck   = deckNormalsDeck,
      deckNormalsScript = deckNormalsScript,
      playerColor       = playerColor,
      alternate         = alternate,
      cardColor         = cardColor,
      backURL           = backURL,
      altbackURL        = altbackURL,
      charPosition      = charPosition,
      charNormalsList   = charNormalsList,
    },
  }

  -- Costume handling.
  --debugLog{"Costume handling: "..os.time(), 2, {1,0.3,0.3}}
  if characterEntry.costumes != nil then
    --debugLog{" 1 or more costumes", 0}
    local unlockedCostumeCount = 0

    -- Loop through the costumes and add them to the costume table.
    for costumeIndex,thisCostume in ipairs(characterEntry.costumes) do
      -- This variable checks whether the costume is "unlocked" for the player.
      local isUnlocked = true

      -- First, if this costume has a password, confirm that it has been unlocked.
      if thisCostume.costumePassword != nil then
        isUnlocked = false
        local codeLength = string.len(thisCostume.costumePassword)

        -- Check only the END of the player's entered password.
        if string.sub(passwordEntries[playerReference.steam_id], -1*codeLength) == thisCostume.costumePassword then
          isUnlocked = true
        end -- end password comparison
      end -- end password check

      -- Then, if this costume has a "costumeOwner" table, confirm that the spawning player is one of the owners.
      if isUnlocked == true and thisCostume.costumeOwner != nil then
        isUnlocked = false
        -- Checks each entry in the "costumeOwner" table.
        for ownerIndex,thisOwner in ipairs(thisCostume.costumeOwner) do
          -- Checks against name OR Steam ID.
          if playerReference.steam_name == thisOwner or playerReference.steam_id == thisOwner then
            isUnlocked = true
          end -- finish checking this entry in the costumeOwner table
        end -- finish checking costumeOwner table
      end -- finish check for costumeOwner table

      if isUnlocked == true then
        unlockedCostumeCount = unlockedCostumeCount+1
        -- costumePriority determines which costumes override each other for the default. Higher is "stronger".
        -- The default costume has a priority of 1, meaning this must be 1 or higher to override default.
        local costumePriority = thisCostume.costumePriority or 0

        -- Some costumes may have a different priority when not left-clicked.
        if alternate == true then
          costumePriority = thisCostume.alternatePriority or costumePriority
        end

        -- If this costume is registered as a "favorite" for a specific player, check for that.
        if thisCostume.costumeFavorite != nil then
          -- Check each entry in the costumeFavorite table.
          for ownerFavoriteIndex,thisOwnerFavorite in ipairs(thisCostume.costumeFavorite) do
            -- Checks against name OR Steam ID.
            if playerReference.steam_name == thisOwnerFavorite or playerReference.steam_id == thisOwnerFavorite then
              costumePriority = 99
            end -- finish checking this entry in costumeFavorite
          end -- finish checking costumeFavorite table
        end -- finish checking favorite owners

        -- If there's a password which prioritizes this costume (rather than unlocking it), check for that.
        if thisCostume.costumePasswordFavorite != nil then
          local codeLength = string.len(thisCostume.costumePasswordFavorite)

          -- Check only the END of the player's entered password.
          if string.sub(passwordEntries[playerReference.steam_id], -1*codeLength) == thisCostume.costumePasswordFavorite then
            costumePriority = 98
          end -- end password comparison
        end

        --[=[
          If this costume's priority is equal to or greater than the priority of the current highest-priority costume,
          set the highestCostumePriorityIndex (i.e., the index of the costume with the highest priority) to its index in the costume table.
        --]=]
        if costumePriority >= costumeTable[highestCostumePriorityIndex].priority then
          --debugLog{"updating highest-priority costume: "..costumePriority, 1}
          -- The +1 here is to account for the costumeTable including the primary costume as well as alternates.
          highestCostumePriorityIndex = unlockedCostumeCount+1
        end

        -- If this player has a vanity back set for this character, override the predetermined back.
        local costumeBackURL = backURL
        if thisCostume.costumeAttackBack != nil then
          costumeBackURL = thisCostume.costumeAttackBack
        end
        if vanityBackTable != nil then
          if vanityBackTable[thisCostume.costumeName] != nil then
            costumeBackURL = vanityBackTable[thisCostume.costumeName]
          end
        end

        --debugLog{"costumeBackURL: "..costumeBackURL, 1}
        --debugLog{"costumeAttackBack: "..thisCostume.costumeAttackBack}

        -- If the costume is set to use a different Normals style (e.g., Seventh Cross), that overrides the default.
        local costumeNormals = characterEntry.normals
        if thisCostume.costumeNormals != nil then
          costumeNormals = thisCostume.costumeNormals
        end

        -- I can't currently think of a reason that a costume would use a different set of Normals (e.g., UNNormals) than the base character.
        -- If that ever happens, I can override this variable's value by adding some code after it is set.
        local costumeNormalsSet = characterEntry.normalsSet
        -- This got a little more complicated because we want to be able to override which State is the default.
        local costumeName        = thisCostume.costumeName
        local costumeDescription = thisCostume.costumeDescription
        local costumeDeck        = thisCostume.costumeDeck
        local costumeNormalsDeck = thisCostume.costumeNormalsDeck
        local costumeNormalsList = characterEntry.normalsList
        local costumeColor       = thisCostume.costumeColor or cardColor
        local deckNormalsScript  = characterEntry.normalsScript
        local altbackURL         = characterEntry.altattackBack
        local charPosition       = characterEntry.position
        local charNormalsList    = normalsList

        --debugLog{"inserting unlockedCostumeCount: "..unlockedCostumeCount+1, 1, {1,0.4,0.4}}
        --debugLog{"costumeColor: "..costumeColor[1]..","..costumeColor[2]..","..costumeColor[3], 2}

        costumeTable[unlockedCostumeCount+1] = {
          priority = costumePriority,
          jsonParams = {
            deckName          = costumeName,
            deckDescription   = costumeDescription,
            characterCard     = characterCard,
            deckList          = costumeDeck,
            deckNormals       = costumeNormals,
            deckNormalsSet    = costumeNormalsSet,
            deckNormalsDeck   = costumeNormalsDeck,
            deckNormalsScript = deckNormalsScript,
            playerColor       = playerColor,
            alternate         = alternate,
            cardColor         = costumeColor,
            backURL           = costumeBackURL,
            altbackURL        = altbackURL,
            charPosition      = charPosition,
            charNormalsList   = charNormalsList,
            --lockBag         = lockBag,
          },
        }

        --debugLog{"combinedData UNLOCKED", 4, {0,0.8,0.7}}
      end -- end "if isUnlocked == true"
    end -- end costume loop
  end -- end costume handling

  -- Set the main character data to the data of the highest-priority costume.
  local characterParams = costumeTable[highestCostumePriorityIndex].jsonParams
  -- Lock the bag that will be spawned in as the active State to prevent unwanted interactions.
  -- (It gets unlocked by the callback function, deckToHand.)
  characterParams.lockBag = true
  local characterData = {}
  local alternateUsed = false
  local alternateExists = false

  debugLog{"playerReference type: "..type(playerReference), 1}

  local selectNormalsMode = getSelectNormalsStatus({playerColor = playerColor})


  -- If the player is currently set to choose their Normals instead of spawning a character, do that instead of spawning a character.
  if onlyNormals != true and selectNormalsMode == true then
    debugLog{"onlyNormals false, selectNormalsMode true", 2}

    normalsCharacter[playerColor] = deckName
    --debugLog{"characterParams.deckNormals: "..printTable(characterParams.deckNormals),3}
    -- Every character should have their default Normals listed in their data, but just in case...
    if characterParams.deckNormals != nil then
      updatePlayerNormals({
        alternate = alternate,
        newNormals = characterParams.deckNormals,
        ownerGUID = ownerGUID,
        playerColor = playerColor,
        -- updateDropdown = false,
      })
      resetSelectNormalsStatus({ playerColor = playerColor })
    else
      playerReference.broadcast("No Normals found for that selection.")
    end

  -- Otherwise, spawning Normals or a character.
  else
    -- If passed the "onlyNormals" parameter, spawn only a set of Normals.
    if onlyNormals == true then
      debugLog{"onlyNormals true!",2}
      --debugLog{"printing table "..printTable(characterParams), 1}
      characterData = getNormalsBagData(characterParams)
      deckName = [[Normals for ]]..deckName
    -- Otherwise, determine the full character data.
    else
      debugLog{"onlyNormals false, selectNormalsMode false!",2}
      characterData,alternateUsed,alternateExists = getBagData(characterParams)
      table.remove(costumeTable, highestCostumePriorityIndex)

      -- Loop through the additional (non-primary) costumes to add them as additional states.
      debugLog{"State handling: "..os.time(), 2, {1,0.3,0.3}}
      local costumeCount = 0
      local costumeData = {}
      for additionalCostumeIndex,thisCostume in ipairs(costumeTable) do
        debugLog{"additionalCostumeIndex: "..additionalCostumeIndex, 2}
        --[=[
          The +1 is here because additional States start indexed at 2.
          TTS infers the current state based on which number is missing from the list of states.
          In other words, if there's one State and it's listed as 1, then the CURRENT State becomes State 2.
          If there's one State and it's listed as 4, then the current State is registered as State 1, and States 2 and 3 are empty, but still in the list.
          It's real jank.
        --]=]
        local costumeState = additionalCostumeIndex+1
        local costumeParams = costumeTable[additionalCostumeIndex].jsonParams
        costumeParams.isCostume = true

        -- Costumes created as additional States shouldn't be locked (character bags are only locked to prevent interactions on spawn).
        costumeParams.lockBag = false
        costumeData[costumeState] = getBagData(costumeParams)
        costumeCount = costumeCount+1
        --debugLog{" printing costumeData ------ ", 4}
        --debugLog{printTable(costumeData), 4}
      end -- end additional costume loop

      -- Create the final combined data table for the bag to be spawned.
      characterData["States"] = costumeData
      --debugLog{ " COMBINED DATA TABLE", 5, {1,0,1}}
      --debugLog{printTable(characterData), 5}

      if costumeCount > 0 then
        playerReference.broadcast([=[[i]~ Palette Swap: Right-click the bag and choose "State"! ~[/i]]=])
      end
      deckName = deckName..[[ + references]]
    end -- end 'if onlyNormals == true'

    -- Actually spawn the bag.
    --debugLog{"Actually spawning: "..os.time(), 2, {1,0.3,0.3}}
    --debugLog{ " playerHandTransform.position: "..playerHandTransform.position.x..", "..playerHandTransform.position.y..", "..playerHandTransform.position.z, 3}
    --debugLog{printTable(characterData), 4}
    spawnObjectData({
      data = characterData,
      position = playerHandTransform.position,
      callback_function = function(obj) deckToHand(obj, futureName, playerColor) end,
    })


    debugLog{ "Spawning character bag!", 0, {0.2, 1, 0.2} }
    --local broadcastColor = Color[player.color]
    local broadcastColor = {}
    broadcastColor[1] = cardColor[1]+0.5
    broadcastColor[2] = cardColor[2]+0.5
    broadcastColor[3] = cardColor[3]+0.5
    if alternateUsed == false and alternateExists == true then
      playerReference.broadcast(deckName..[[ added to your hand!
(For alternative cosmetics, right-click instead!)]], broadcastColor)
    --elseif onlyNormals[playerReference.color] == true then
    --  playerReference.broadcast([[Normals for ]]..deckName..[[ added to your hand!]], broadcastColor)
    else
      playerReference.broadcast(deckName..[[ added to your hand!]], broadcastColor)
    end
    --Player[player.color].pingTable(playerHandTransform.position)
    --debugLog{"Finished spawnDeck"..os.time(), 2, {1,0.3,0.3}}
  end -- end 'if onlyNormals != true and selectNormalsMode == true'
end -- end spawnDeck



function spawnRandomCharacter(params)
  local season = params.season
  local playerColor = params.playerColor
  local alternate = params.alternate
  local playerReference = Player[playerColor]

  if infoMode[playerColor] == true then
    player.broadcast([[This space intentionally (temporarily) left blank.]])
    --[=[ TODO: Fill this out.
    local rightClickColor = {1,0.65,0.55}
    local leftClickColor = {0.80,0.65,1}
    player.print([[--------]], {0.3,0.3,0.3})
    if value == "-1" then -- Left-click
      player.broadcast([[[FF4444]Left-click[-] to use whatever Normals your character would use in print.
[00FFFF]Right-click[-] to use reskinned versions of those Normals (if available).]])
      player.print([[This changes your current Normals setting.]])
      player.print([[[FF4444]Left-click:[-] Set Normals to <Default>.]], leftClickColor)
      player.print([[[00FFFF]Right-click:[-] Set Normals to <Default (Alternate)>.]], rightClickColor)
    else -- Right-click
      player.print([[When you spawn a character using the module's built-in character spawning functionality, they can use different Normals if those Normals support their Normals set (e.g., Normals, UNNormals).]])
      player.print([[Many Normals have reskins available; this usually entails visual improvements to make cards easier to distinguish from one another or text modifications to make effects easier to understand. (Reskins never change functionality.)]])
    end
    -- Since a toggle is being clicked, take care not to change the actual entry.
    local checkString = string.sub(id, string.len(player.color))
    checkString = string.sub(checkString, 19)
    if checkString == getCurrentNormals({ playerColor = player.color }) then
      self.UI.setAttributes(id, { isOn = true, })
    else
      self.UI.setAttributes(id, { isOn = false, })
    end
    --]=]
    return
  end

  -- The season is often passed as a UI element ID, which are generally formatted as "Random2" instead of just "2".
  if string.sub(season, 1, 6) == [[Random]] then
    season = string.sub(season, 7)
  end

  local characterName, ownerGUID = getRandomCharacter(season, playerReference)

  if characterName == nil then
    debugLog{"error: random roll failed!", 0, {1,0,0}}
  else
    spawnDeck({
      characterName = characterName,
      ownerGUID = ownerGUID,
      playerColor = playerColor,
      alternate = alternate,
      randomRoll = true,
    })
  end

end -- end spawnRandomCharacter



function uiClick_Character(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end
  if player.color == [[Grey]] then
    player.broadcast([[Spectators cannot spawn characters.]])
    return
  end
  if infoMode[player.color] == true then
    player.broadcast([[This space intentionally (temporarily) left blank.]])
    --[=[ TODO: Fill this out.
    local rightClickColor = {1,0.65,0.55}
    local leftClickColor = {0.80,0.65,1}
    player.print([[--------]], {0.3,0.3,0.3})
    if value == "-1" then -- Left-click
      player.broadcast([[[FF4444]Left-click[-] to use whatever Normals your character would use in print.
[00FFFF]Right-click[-] to use reskinned versions of those Normals (if available).]])
      player.print([[This changes your current Normals setting.]])
      player.print([[[FF4444]Left-click:[-] Set Normals to <Default>.]], leftClickColor)
      player.print([[[00FFFF]Right-click:[-] Set Normals to <Default (Alternate)>.]], rightClickColor)
    else -- Right-click
      player.print([[When you spawn a character using the module's built-in character spawning functionality, they can use different Normals if those Normals support their Normals set (e.g., Normals, UNNormals).]])
      player.print([[Many Normals have reskins available; this usually entails visual improvements to make cards easier to distinguish from one another or text modifications to make effects easier to understand. (Reskins never change functionality.)]])
    end
    -- Since a toggle is being clicked, take care not to change the actual entry.
    local checkString = string.sub(id, string.len(player.color))
    checkString = string.sub(checkString, 19)
    if checkString == getCurrentNormals({ playerColor = player.color }) then
      self.UI.setAttributes(id, { isOn = true, })
    else
      self.UI.setAttributes(id, { isOn = false, })
    end
    --]=]
    return
  end

  --debugLog{ "uiClick_Character clicked by "..player.color, 0 }
  --debugLog{ "   value: "..value, 3 }
  --debugLog{ "      id: "..id, 3 }
  --local clickedObject = getObjectFromGUID(id)
  --local deckList = charTable[id].deck

  -- If NOT clicked with the left mouse button, alternate mode is on.
  local alternate = false
  if value != "-1" then
    --debugLog{ "   alternate mode is on", 1, {0, 1, 1} }
    alternate = true
  end

  spawnDeck({
    characterName = id,
    ownerGUID = self.getGUID(),
    --deckList = deckList,
    playerColor = player.color,
    alternate = alternate
  })
end -- end uiClick_Character



function uiClick_Info(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end
  if infoMode[player.color] == true then
    if value != "-1" then -- Non-left-click
      player.broadcast([[[FF4444]Left-click[-] to toggle Info Mode; [00FFFF]right-click[-] for this info.
Check the in-game chat window for details.]])
      player.print([[--------]], {0.3,0.3,0.3})
      player.print([[While Info Mode is active, click anything in the module to obtain information about that object.. eventually.]])
      player.print([[Not much is implemented right now. It's in the works.]])
      player.print([[[FF4444]Left-click:[-] The object's basic functions are broadcast on-screen and listed in your chat box. Left-click functions bear a salmon hue; right-click functions are azure. Lengthy details will be reserved for your chat.]], {1,0.65,0.55})
      player.print([[[00FFFF]Right-click:[-] Additional information about the object, if any, will be listed in your chat box. Sometimes, this amounts to little more than my own casual remarks.]], {0.80,0.65,1})
      return
    else -- Left-click
    end
  end
  debugLog{"Character Station: uiClick_Info", 0}
  --debugLog{" - id: "..id, 1}
  --debugLog{" - value: "..value, 1}
  --debugLog{" - isOn: "..self.UI.getAttribute("InfoMode"..player.color, "isOn")}

  local currentValue = infoMode[player.color]
  local newValue = false

  --[=[
  if value == "-2" then -- Right-click
    debugLog{"spawning a set of Normals", 3}
    spawnDeck({
      deckName        = normalsCharacter[player.color],
      --deckList        = params.deckList
      player = player,
      --alternate       = false,
      onlyNormals     = true,
    })
  else
    ...
  end
  --]=]

  if currentValue == true then newValue = false
  elseif currentValue == false then newValue = true
  end

  self.UI.setAttribute("InfoModeHighlight"..player.color, "active", newValue)
  Global.UI.setAttribute("InfoModeModeIndicator"..player.color, "active", newValue)

  infoMode[player.color] = newValue
end -- end uiClick_Info



function uiClick_NormalsToggle(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end
  if infoMode[player.color] == true then
    local rightClickColor = {1,0.65,0.55}
    local leftClickColor = {0.80,0.65,1}
    player.print([[--------]], {0.3,0.3,0.3})
    if value == "-1" then -- Left-click
      player.broadcast([[[FF4444]Left-click[-] to use whatever Normals your character would use in print.
[00FFFF]Right-click[-] to use reskinned versions of those Normals (if available).]])
      player.print([[This changes your current Normals setting.]])
      player.print([[[FF4444]Left-click:[-] Set Normals to <Default>.]], leftClickColor)
      player.print([[[00FFFF]Right-click:[-] Set Normals to <Default (Alternate)>.]], rightClickColor)
    else -- Right-click
      player.print([[When you spawn a character using the module's built-in character spawning functionality, they can use different Normals if those Normals support their Normals set (e.g., Normals, UNNormals).]])
      player.print([[Many Normals have reskins available; this usually entails visual improvements to make cards easier to distinguish from one another or text modifications to make effects easier to understand. (Reskins never change functionality.)]])
    end
    -- Since a toggle is being clicked, take care not to change the actual entry.
    local checkString = string.sub(id, string.len(player.color))
    checkString = string.sub(checkString, 19)
    if checkString == getCurrentNormals({ playerColor = player.color }) then
      self.UI.setAttributes(id, { isOn = true, })
    else
      self.UI.setAttributes(id, { isOn = false, })
    end
    return
  end

  local alternate = false
  if value != [[-1]] then alternate = true end

  debugLog{self.getGUID()..[[ ran uiClick_NormalsToggle]], 2}
  debugLog{"   player: "..player.color, 5}
  debugLog{"   value: "..value, 5}
  debugLog{"   id: "..id, 5}

  -- [=[ Uncomment for local execution.
  normalsToggleClick({
    alternate = alternate,
    ownerGUID = self.getGUID(),
    playerColor = player.color,
    toggleID = id,
  })
  --]=]
  --[=[ Uncomment for remote execution.
  characterStation.call("normalsToggleClick", {
    playerColor = player.color,
    alternate = alternate,
    toggleID = id,
  })
  --]=]
end -- end function uiClick_NormalsToggle



function uiClick_Random(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end
  if player.color == [[Grey]] then
    player.broadcast([[Spectators cannot spawn characters.]])
    return
  end
  if infoMode[player.color] == true then
    player.broadcast([[This space intentionally (temporarily) left blank.]])
    --[=[ TODO: Fill this out.
    local rightClickColor = {1,0.65,0.55}
    local leftClickColor = {0.80,0.65,1}
    player.print([[--------]], {0.3,0.3,0.3})
    if value == "-1" then -- Left-click
      player.broadcast([[[FF4444]Left-click[-] to use whatever Normals your character would use in print.
[00FFFF]Right-click[-] to use reskinned versions of those Normals (if available).]])
      player.print([[This changes your current Normals setting.]])
      player.print([[[FF4444]Left-click:[-] Set Normals to <Default>.]], leftClickColor)
      player.print([[[00FFFF]Right-click:[-] Set Normals to <Default (Alternate)>.]], rightClickColor)
    else -- Right-click
      player.print([[When you spawn a character using the module's built-in character spawning functionality, they can use different Normals if those Normals support their Normals set (e.g., Normals, UNNormals).]])
      player.print([[Many Normals have reskins available; this usually entails visual improvements to make cards easier to distinguish from one another or text modifications to make effects easier to understand. (Reskins never change functionality.)]])
    end
    -- Since a toggle is being clicked, take care not to change the actual entry.
    local checkString = string.sub(id, string.len(player.color))
    checkString = string.sub(checkString, 19)
    if checkString == getCurrentNormals({ playerColor = player.color }) then
      self.UI.setAttributes(id, { isOn = true, })
    else
      self.UI.setAttributes(id, { isOn = false, })
    end
    --]=]
    return
  end

  local season = id
  local playerColor = player.color
  local alternate = false

  -- If NOT clicked with the left mouse button, alternate mode is on.
  if value != "-1" then
    --debugLog{ "   alternate mode is on", 1, {0, 1, 1} }
    alternate = true
  end

  -- Setting up spawnRandomCharacter to accept a table of parameters allows us to call it from panels.
  spawnRandomCharacter({
    season = season,
    playerColor = playerColor,
    alternate = alternate,
  })
end -- end uiClick_Random



function uiClick_SelectNormals(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end
  if infoMode[player.color] == true then
    player.broadcast([[This space intentionally (temporarily) left blank.]])
    --[=[ TODO: Fill this out.
    local rightClickColor = {1,0.65,0.55}
    local leftClickColor = {0.80,0.65,1}
    player.print([[--------]], {0.3,0.3,0.3})
    if value == "-1" then -- Left-click
      player.broadcast([[[FF4444]Left-click[-] to use TTS-optimized Normals.
[00FFFF]Right-click[-] to use reskinned versions of those Normals (if available).]])
      player.print([[This changes your current Normals setting.]])
      player.print([[[FF4444]Left-click:[-] Set Normals to <Default>.]], leftClickColor)
      player.print([[[00FFFF]Right-click:[-] Set Normals to <Default (Alternate)>.]], rightClickColor)
    else -- Right-click
      player.print([[When you spawn a character using the module's built-in character spawning functionality, they can use different Normals if those Normals support their Normals set (e.g., Normals, UNNormals).]])
      player.print([[Many Normals have reskins available; this usually entails visual improvements to make cards easier to distinguish from one another or text modifications to make effects easier to understand. (Reskins never change functionality.)]])
    end
    -- Since a toggle is being clicked, take care not to change the actual entry.
    local checkString = string.sub(id, string.len(player.color))
    checkString = string.sub(checkString, 19)
    if checkString == getCurrentNormals({ playerColor = player.color }) then
      self.UI.setAttributes(id, { isOn = true, })
    else
      self.UI.setAttributes(id, { isOn = false, })
    end
    --]=]
    return
  end
  --debugLog{"Character Station: uiClick_SelectNormals", 0}
  --debugLog{" - id: "..id, 1}
  --debugLog{" - value: "..value, 1}
  --debugLog{" - isOn: "..self.UI.getAttribute("SelectNormals"..player.color, "isOn")}

  local currentValue = selectNormals[player.color]
  local newValue = false

  --[=[
  if value == "-2" then -- Right-click
    debugLog{"spawning a set of Normals", 3}
    spawnDeck({
      deckName        = normalsCharacter[player.color],
      --deckList        = params.deckList
      player = player,
      --alternate       = false,
      onlyNormals     = true,
    })
  else
    ...
  end
  --]=]

  if currentValue == true then newValue = false
  elseif currentValue == false then newValue = true
  end

  self.UI.setAttribute("SelectNormalsHighlight"..player.color, "active", newValue)
  Global.UI.setAttribute("SelectNormalsModeIndicator"..player.color, "active", newValue)

  selectNormals[player.color] = newValue
end -- end uiClick_SelectNormals



function uiClick_SpawnNormals(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end
  if infoMode[player.color] == true then
    player.broadcast([[This space intentionally (temporarily) left blank.]])
    --[=[ TODO: Fill this out.
    local rightClickColor = {1,0.65,0.55}
    local leftClickColor = {0.80,0.65,1}
    player.print([[--------]], {0.3,0.3,0.3})
    if value == "-1" then -- Left-click
      player.broadcast([[[FF4444]Left-click[-] to use whatever Normals your character would use in print.
[00FFFF]Right-click[-] to use reskinned versions of those Normals (if available).]])
      player.print([[This changes your current Normals setting.]])
      player.print([[[FF4444]Left-click:[-] Set Normals to <Default>.]], leftClickColor)
      player.print([[[00FFFF]Right-click:[-] Set Normals to <Default (Alternate)>.]], rightClickColor)
    else -- Right-click
      player.print([[When you spawn a character using the module's built-in character spawning functionality, they can use different Normals if those Normals support their Normals set (e.g., Normals, UNNormals).]])
      player.print([[Many Normals have reskins available; this usually entails visual improvements to make cards easier to distinguish from one another or text modifications to make effects easier to understand. (Reskins never change functionality.)]])
    end
    -- Since a toggle is being clicked, take care not to change the actual entry.
    local checkString = string.sub(id, string.len(player.color))
    checkString = string.sub(checkString, 19)
    if checkString == getCurrentNormals({ playerColor = player.color }) then
      self.UI.setAttributes(id, { isOn = true, })
    else
      self.UI.setAttributes(id, { isOn = false, })
    end
    --]=]
    return
  end
  debugLog{"uiClick_SpawnNormals value: "..value..", type "..type(value), 2}

  local alternate = false
  if value == [[-2]] then alternate = true end

  local characterName = normalsCharacter[player.color]

  if randomSeasons["All"][characterName] != nil then
    spawnDeck({
      characterName   = normalsCharacter[player.color],
      ownerGUID       = randomSeasons["All"][characterName].ownerGUID,
      playerColor     = player.color,
      alternate       = alternate,
      onlyNormals     = true,
    })
  else
    player.broadcast([[Error: The characterName for uiClick_SpawnNormals is missing.
Please notify tirankin.]], {1,0,0})
    debugLog{"error: player "..player.color.."'s normalsCharacter is nil", 0, {1,0,0}}
  end
end -- end uiClick_SpawnNormals



function uiDropdown_ChooseNormals(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end
  if infoMode[player.color] == true then
    player.broadcast([[This space intentionally (temporarily) left blank.]])
    --[=[ TODO: Fill this out.
    local rightClickColor = {1,0.65,0.55}
    local leftClickColor = {0.80,0.65,1}
    player.print([[--------]], {0.3,0.3,0.3})
    if value == "-1" then -- Left-click
      player.broadcast([[[FF4444]Left-click[-] to use whatever Normals your character would use in print.
[00FFFF]Right-click[-] to use reskinned versions of those Normals (if available).]])
      player.print([[This changes your current Normals setting.]])
      player.print([[[FF4444]Left-click:[-] Set Normals to <Default>.]], leftClickColor)
      player.print([[[00FFFF]Right-click:[-] Set Normals to <Default (Alternate)>.]], rightClickColor)
    else -- Right-click
      player.print([[When you spawn a character using the module's built-in character spawning functionality, they can use different Normals if those Normals support their Normals set (e.g., Normals, UNNormals).]])
      player.print([[Many Normals have reskins available; this usually entails visual improvements to make cards easier to distinguish from one another or text modifications to make effects easier to understand. (Reskins never change functionality.)]])
    end
    -- Since a toggle is being clicked, take care not to change the actual entry.
    local checkString = string.sub(id, string.len(player.color))
    checkString = string.sub(checkString, 19)
    if checkString == getCurrentNormals({ playerColor = player.color }) then
      self.UI.setAttributes(id, { isOn = true, })
    else
      self.UI.setAttributes(id, { isOn = false, })
    end
    --]=]
    -- TODO: Set this up so it correctly doesn't update the selection.
  end
  --debugLog{"uiDropdown_ChooseNormals executed by player "..player.color, 2}
  debugLog{"  value: "..value, 2}
  debugLog{"     id: "..id, 2}

  local alternate = false
  if string.sub(value, -12) != [[ (Alternate)]] then
    alternate = false
  elseif string.sub(value, -12) == [[ (Alternate)]] then
    alternate = true
  end

  updatePlayerNormals({
    alternate = alternate,
    newNormals = value,
    playerColor = player.color,
    updateDropdown = false,
  })
end -- end uiDropdown_ChooseNormals



--[=[
updateNormalsDropdown({
  playerColor     = playerColor,     -- string; required
  currentXml      = currentXml,      -- table; defaults to self.UI.getXmlTable()
  selectedNormals = selectedNormals, -- string; defaults to "Default", appropriately enough
  updateXml       = updateXml,       -- boolean; defaults to false
}) --]=]
function updateNormalsDropdown(params)

  -- TODO: Investigate performance of this function.
  debugLog{"Character Station: updateNormalsDropdown", 3}

  local playerColor = params.playerColor
  if playerColor == nil then
    debugLog{"error: no playerColor specified for updateNormalsDropdown", 0, {1,0,0}}
    return
  end

  local updateXml = params.updateXml
  if updateXml == nil then updateXml = false end

  local selectedNormals = params.selectedNormals
  if selectedNormals == nil then
    debugLog{"warning: no selectedNormals supplied to updateNormalsDropdown", 0, {1,1,0}}
    if currentNormalsTable[playerColor] != nil then
      selectedNormals = currentNormalsTable[playerColor]
    else
      selectedNormals = "Default"
    end
    debugLog{" default value: "..selectedNormals, 0, {0,1,0}}
  end

  --debugLog{"   selected Normals: "..selectedNormals, 2, {0,1,1}}

  local currentXml = nil
  if params.currentXml != nil then
    currentXml = returnTableCopy(params.currentXml)
  else
    currentXml = self.UI.getXmlTable()
  end

  -- Find the index of the Xml element that needs to be edited.
  local playerDropdownIndex = playerDropdownIndexList[playerColor]

  -- Rebuild the playerNormalsListXmlTable, ordering it by its keys.
  playerNormalsListXmlTable = {
    { tag = "Option", value = "Default", },
    { tag = "Option", value = "Default (Alternate)", attributes = {}, },
  }

  if selectedNormals == "Default (Alternate)" then
    playerNormalsListXmlTable[2].attributes.selected = "true"
  end

  for thisNormals,normalsTable in pairsByKeys(registeredNormals) do
    --debugLog{"normalsTable.ownerGUID: "..normalsTable.ownerGUID, 2, {1,0,1}}
    if normalsTable.active == true and panels[normalsTable.ownerGUID].active == true then
      local thisChild = { tag = "Option", value = thisNormals, attributes = {}, }
      --debugLog{" checking item: "..thisNormals, 3}
      if thisNormals == selectedNormals then
        --debugLog{"selecting item: "..thisNormals, 3}
        thisChild.attributes.selected = "true"
      end
      table.insert(playerNormalsListXmlTable, thisChild)
    end
  end -- finish looping through Normals sets
  --debugLog{"playerListDropdownIndex: "..playerListDropdownIndex, 1}
  currentXml[playerDropdownIndex].children[1].children = playerNormalsListXmlTable

  if updateXml == true then
    self.UI.setXmlTable(currentXml)
  end

  return currentXml
end -- end updateNormalsDropdown



function updatePlayerNormals(params)

  debugLog{"Character Station: updatePlayerNormals", 2}

  local newNormals = params.newNormals
  local ownerGUID = params.ownerGUID
  local playerColor = params.playerColor
  local playerReference = Player[playerColor]
  local toggleID = params.toggleID
  local toggleKey = params.toggleKey
  local alternate = params.alternate
  local alternatesAvailable = false

  local oldNormals = currentNormalsTable[playerColor]
  debugLog{"oldNormals: "..oldNormals, 2, {1,1,1}}

  if newNormals == nil then
    debugLog{"error: updatePlayerNormals: newNormals value is nil", 0, {1,0,0}}
    return
  elseif oldNormals == nil then
    debugLog{"error: updatePlayerNormals: oldNormals value is nil", 0, {1,0,0}}
    return
  end

  if type(registeredNormals[newNormals]) != [[table]] then
    debugLog{"error: newNormals <"..newNormals.."> not registered as a table!", 0, {1,0,0}}
  elseif type(registeredNormals[oldNormals]) != [[table]] then
    debugLog{"error: oldNormals <"..oldNormals.."> not registered as a table!", 0, {1,0,0}}
  end

  if ownerGUID == nil then
    ownerGUID = registeredNormals[newNormals].ownerGUID
  end

  --if oldNormals == [[Default]] then oldNormals = [[(default)]]
  --elseif oldNormals == [[Default (Alternate)]] then oldNormals = [[(default) (Alternate)]] end

  local oldNormalsOwnerGUID = registeredNormals[oldNormals].ownerGUID
  local oldNormalsToggleKey = oldNormalsOwnerGUID..[[Normals Toggle: ]]..oldNormals

  local oldNormalsBase = oldNormals
  -- If the specified Normals already have the alternate suffix, determine the base.
  if string.sub(oldNormals, -12) == [[ (Alternate)]] then
    oldNormalsBase = string.sub(oldNormals, 1, (string.len(oldNormals)-12))
  end

  local newNormalsBase = newNormals
  local newNormalsAlternate = newNormals
  -- If the specified Normals already have the alternate suffix, determine the base.
  if string.sub(newNormals, -12) == [[ (Alternate)]] then
    newNormalsBase = string.sub(newNormals, 1, (string.len(newNormals)-12))
  -- Otherwise, determine the alternate version.
  else
    newNormalsAlternate = newNormals..[[ (Alternate)]]
  end

  -- If the alternate does not exist, reject its usage.
  if registeredNormals[newNormalsAlternate] == nil then
    alternate = false
    alternatesAvailable = false
  else
    local panelGUID = registeredNormals[newNormalsAlternate].ownerGUID
    if registeredNormals[newNormalsAlternate].active != true or panels[panelGUID].active != true then
      debugLog{"   alternates for new Normals inactive, or panel inactive", 5}
      alternate = false
      alternatesAvailable = false
    else
      alternatesAvailable = true
    end
  end

  debugLog{"newNormals: "..newNormals, 2, {1,0,1}}
  debugLog{"newNormalsAlternate: "..newNormalsAlternate, 4}
  debugLog{"newNormalsBase: "..newNormalsBase, 4}

  -- If the 'alternate' parameter is not supplied, reverse-engineer it from the specified Normals.
  if alternate == nil then
    if newNormals == newNormalsAlternate and registeredNormals[newNormalsAlternate] != nil then
      local panelGUID = registeredNormals[newNormalsAlternate].ownerGUID
      if registeredNormals[newNormalsAlternate].active == true and panels[panelGUID] == true then
        alternate = true
      else
        alternate = false
      end
    else
      alternate = false
    end
  -- If the 'alternate' parameter is supplied as true, use the alternate.
  elseif alternate == true then
    debugLog{"alternate: true", 3}
    newNormals = newNormalsAlternate
  -- If the 'alternate' parameter is supplied as false, use the base.
  elseif alternate == false then
    debugLog{"alternate: false", 3}
    newNormals = newNormalsBase
  end

  if toggleKey == nil then
    toggleKey = ownerGUID..[[Normals Toggle: ]]..newNormalsBase
  end

  if toggleID == nil then
    toggleID = playerColor..[[ Normals Toggle: ]]..newNormalsBase
  end
  -- e.g. toggleID: White Normals Toggle: Street Fighter
  -- e.g. toggleKey: df4011Normals Toggle: Street Fighter

  debugLog{"toggleID: "..toggleID, 4, {1,1,0}}
  debugLog{"toggleKey: "..toggleKey, 4, {1,1,0}}

  -- Verify that the specified Normals exist.
  if registeredNormals[newNormals] == nil then
    --debugLog{"error: specified Normals not registered", 0, {1,0,0}}
    return
  else
    if registeredNormals[newNormals].active != true then
      --debugLog{"error: specified Normals are inactive", 0, {1,0,0}}
    end
  end

  local changeCurrentToggle = false
  local notificationString = [[Normals set to ]]..newNormals..[[.]]

  if oldNormals != newNormals then

    local updateDropdown = params.updateDropdown
    if updateDropdown == nil then updateDropdown = true end -- Changed this default.

    if updateDropdown == true then
      updateNormalsDropdown({ selectedNormals = newNormals, playerColor = playerColor, updateXml = true, })
    end -- end 'if updateDropdown == true'

    if alternate == true then
      notificationString = [[Normals set to ]]..newNormals..[[. (Left-click for originals.)]]
    elseif alternate == false and alternatesAvailable == true then
      notificationString = [[Normals set to ]]..newNormals..[[. (Right-click for reskins.)]]
    end

    playerReference.broadcast(notificationString)
    currentNormalsTable[playerColor] = newNormals

    -- Update the toggle (if any) for the old Normals.
    local unselectedColorString = [[#FFFFFF|]]..playerColor..[[|#C8C8C8]]
    local oldNormalsOwner = getObjectFromGUID(oldNormalsOwnerGUID)
    local oldNormalsToggleID = playerColor.." Normals Toggle: "..oldNormalsBase

    --debugLog{"updating UI for previous owner "..oldNormalsOwnerGUID..", toggleID "..oldNormalsToggleID..", to "..unselectedColorString, 5}
    oldNormalsOwner.UI.setAttributes(oldNormalsToggleID, { isOn = false, colors = unselectedColorString, })
  end -- end 'if oldNormals != newNormals'

  local invertColor = Color[playerColor]
  invertColor = {
    r = 1-invertColor[1],
    g = 1-invertColor[2],
    b = 1-invertColor[3],
    a = 1,}
  local invertColorString = "rgba("..invertColor.r..","..invertColor.g..","..invertColor.b..","..invertColor.a..")"
  --debugLog{ "invertColor: "..invertColorString, 5}

  local selectedColorString = playerColor..[[|]]..playerColor..[[|#C8C8C8]]
  if alternate == true then selectedColorString = invertColorString..[[|]]..invertColorString..[[|]]..[[|#C8C8C8]] end

  -- Update the toggle (if any) for the new Normals.
  if normalsToggleTable[toggleKey] == nil then
    --debugLog{"warning: new Normals toggle "..toggleKey.." is not registered in normalsToggleTable", 0, {1,1,0}}
  else
    if normalsToggleTable[toggleKey].active != true then
      --debugLog{"error: new Normals toggle "..toggleKey.." is not active", 0, {1,0,0}}
    else

      --debugLog{"oldNormals: "..oldNormals, 4}
      --debugLog{"oldNormalsToggleKey: "..oldNormalsToggleKey, 5}
      --debugLog{"oldNormalsOwnerGUID: "..oldNormalsOwnerGUID, 5}

      local newNormalsOwner = getObjectFromGUID(ownerGUID)

      --debugLog{"updating UI for current owner "..ownerGUID..", toggleID "..toggleID..", to "..selectedColorString, 5}
      newNormalsOwner.UI.setAttributes(toggleID, { isOn = true, colors = selectedColorString, })

    end -- finish checking active status of given toggleKey
  end -- finish checking for entry corresponding to given toggleKey
end -- end updatePlayerNormals



-- working lua base64 codec (c) 2006-2008 by Alex Kloss
-- compatible with lua 5.0
-- http://www.it-rfc.de
-- licensed under the terms of the LGPL2

-- bitshift functions (<<, >> equivalent)
-- shift left
function lsh(value,shift)
	return modulo((value*(2^shift)), 256)
end

-- shift right
function rsh(value,shift)
	return modulo(math.floor(value/2^shift), 256)
end

-- return single bit (for OR)
function bit(x,b)
	return (modulo(x, 2^b) - modulo(x, 2^(b-1)) > 0)
end

-- logic OR for number values
function lor(x,y)
	result = 0
	for p=1,8 do result = result + (((bit(x,p) or bit(y,p)) == true) and 2^(p-1) or 0) end
	return result
end

-- encryption table
local base64chars = {[0]='A',[1]='B',[2]='C',[3]='D',[4]='E',[5]='F',[6]='G',[7]='H',[8]='I',[9]='J',
[10]='K',[11]='L',[12]='M',[13]='N',[14]='O',[15]='P',[16]='Q',[17]='R',[18]='S',[19]='T',[20]='U',
[21]='V',[22]='W',[23]='X',[24]='Y',[25]='Z',[26]='a',[27]='b',[28]='c',[29]='d',[30]='e',[31]='f',
[32]='g',[33]='h',[34]='i',[35]='j',[36]='k',[37]='l',[38]='m',[39]='n',[40]='o',[41]='p',[42]='q',
[43]='r',[44]='s',[45]='t',[46]='u',[47]='v',[48]='w',[49]='x',[50]='y',[51]='z',[52]='0',[53]='1',
[54]='2',[55]='3',[56]='4',[57]='5',[58]='6',[59]='7',[60]='8',[61]='9',[62]='-',[63]='_'}

-- function encode
-- encodes input string to base64.
function enc(data)
	local bytes = {}
	local result = ""
	for spos=0,string.len(data)-1,3 do
		for byte=1,3 do bytes[byte] = string.byte(string.sub(data,(spos+byte))) or 0 end
		result = string.format('%s%s%s%s%s',
			result,
			base64chars[rsh(bytes[1],2)],
			base64chars[lor(lsh((modulo(bytes[1], 4)),4), rsh(bytes[2],4))] or "=",
			((string.len(data)-spos) > 1) and base64chars[lor(lsh(
				modulo(bytes[2], 16)
			,2), rsh(bytes[3],6))] or "=",
			((string.len(data)-spos) > 2) and base64chars[(modulo(bytes[3], 64))] or "="
		)
	end
	return result
end -- end enc

-- decryption table
local base64bytes = {['A']=0,['B']=1,['C']=2,['D']=3,['E']=4,['F']=5,['G']=6,['H']=7,['I']=8,['J']=9,
['K']=10,['L']=11,['M']=12,['N']=13,['O']=14,['P']=15,['Q']=16,['R']=17,['S']=18,['T']=19,['U']=20,
['V']=21,['W']=22,['X']=23,['Y']=24,['Z']=25,['a']=26,['b']=27,['c']=28,['d']=29,['e']=30,['f']=31,
['g']=32,['h']=33,['i']=34,['j']=35,['k']=36,['l']=37,['m']=38,['n']=39,['o']=40,['p']=41,['q']=42,
['r']=43,['s']=44,['t']=45,['u']=46,['v']=47,['w']=48,['x']=49,['y']=50,['z']=51,['0']=52,['1']=53,
['2']=54,['3']=55,['4']=56,['5']=57,['6']=58,['7']=59,['8']=60,['9']=61,['-']=62,['_']=63,['=']=nil}

-- function decode
-- decode base64 input to string
function dec(data)
	local chars = {}
	local result=""
	for dpos=0,string.len(data)-1,4 do
		for char=1,4 do chars[char] = base64bytes[(string.sub(data,(dpos+char),(dpos+char)) or "=")] end
		result = string.format('%s%s%s%s',
			result,
			string.char(lor(lsh(chars[1],2), rsh(chars[2],4))),
			(chars[3] ~= nil) and string.char(lor(lsh(chars[2],4), rsh(chars[3],2))) or "",
			(chars[4] ~= nil) and string.char(lor(modulo(lsh(chars[3],6), 192), (chars[4]))) or ""
		)
	end
	return result
end

-- The code above was apparently written expecting the 'math.mod' function, which returns 1 value (not 2).
-- This function performs that task instead.
function modulo(value, mod)
  local returnValue = (value % mod)
  return returnValue
end































--[====[

function combinationLock()

end -- end combinationLock



--[=[
The following code is lifted from the match recorder object.
I intend to fold it in to this object.
--]=]
function matchRecordPrep(uiTable)
-- We'll start with a single case, then expand to the other two.
-- In this case, we'll start with Red vs. Blue.
  victor = "Draw"
  condition = "Knockout"
  player1 = "Red"
  player2 = "Blue"
  fighter1 = ""
  fighter2 = ""
  hide1 = "False"
  hide2 = "False"
  visibilityString = [[Red|Blue|Black]]
  offsetY = -400
  rotation = 180
  charOffsetX = 200
  charOffsetY = (110+offsetY)
  --local character1OffsetY              = -400
  --local character2OffsetY              = -400+offsetY
  local character1Rotation             = "0 0 0"
  local character2Rotation             = "0 0 0"
  local character1HeaderOffsetX        = 200
  local character1HeaderOffsetY        = 110+offsetY
  local character1NameInputOffsetX     = 200
  local character1NameInputOffsetY     = 60+offsetY
  local character1PrivateToggleOffsetX = 200
  local character1PrivateToggleOffsetY = 10+offsetY
  local character1VictorToggleOffsetX  = 37
  local character1VictorToggleOffsetY  = -14+offsetY
  local uiElements = {}
  playersTables = {
    { -- begin Red vs. Blue table entry
      drawToggleX = -10.5,
      drawToggleY = -14,-- -40,
      offsetY = -400,
      outcomeX = 0,
      outcomeY = -20,
      player1 = "Red",
      player2 = "Blue",
      rotation = "0 0 0",
      toggleGroupX = 0,
      toggleGroupY = 80,
      victorHeaderX = 0,
      victorHeaderY = 85,
      players = { -- begin "players" subtable
        { color = "Red", opposite = "Blue",
          headerX = 200,
          headerY = 110,
          nameInputX = 200,
          nameInputY = 60,
          privateToggleX = 200,
          privateToggleY = 20,
          victorToggleX = 45,
          victorToggleY = -14,
        }, -- end Red player entry
        { color = "Blue", opposite = "Red",
          headerX = -200,
          headerY = 110,
          nameInputX = -200,
          nameInputY = 60,
          privateToggleX = -200,
          privateToggleY = 20,
          victorToggleX = -45,
          victorToggleY = -14,
        } -- end Blue player entry
      } -- end "players" subtable
    }, -- end Red vs. Blue table entry
    { -- begin Yellow vs. Green table entry
      drawToggleX = -10.5,
      drawToggleY = -14,-- -40,
      offsetY = 1900,
      outcomeX = 0,
      outcomeY = -20,
      player1 = "Yellow",
      player2 = "Green",
      rotation = "0 0 0",
      toggleGroupX = 0,
      toggleGroupY = 80,
      victorHeaderX = 0,
      victorHeaderY = 85,
      players = { -- begin "players" subtable
        { color = "Yellow", opposite = "Green",
          headerX = 200,
          headerY = 110,
          nameInputX = 200,
          nameInputY = 60,
          privateToggleX = 200,
          privateToggleY = 20,
          victorToggleX = 45,
          victorToggleY = -14,
        }, -- end Yellow player entry
        { color = "Green", opposite = "Yellow",
          headerX = -200,
          headerY = 110,
          nameInputX = -200,
          nameInputY = 60,
          privateToggleX = -200,
          privateToggleY = 20,
          victorToggleX = -45,
          victorToggleY = -14,
        } -- end Green player entry
      } -- end "players" subtable
    }, -- end Yellow vs. Green
    { -- begin Orange vs. Purple table entry
      drawToggleX = -10.5,
      drawToggleY = -14,-- -40,
      offsetY = -2350,
      outcomeX = 0,
      outcomeY = -20,
      player1 = "Orange",
      player2 = "Purple",
      rotation = "0 0 0",
      toggleGroupX = 0,
      toggleGroupY = 80,
      victorHeaderX = 0,
      victorHeaderY = 85,
      players = { -- begin "players" subtable
        { color = "Orange", opposite = "Purple",
          headerX = 200,
          headerY = 110,
          nameInputX = 200,
          nameInputY = 60,
          privateToggleX = 200,
          privateToggleY = 20,
          victorToggleX = 45,
          victorToggleY = -14,
        }, -- end Yellow player entry
        { color = "Purple", opposite = "Orange",
          headerX = -200,
          headerY = 110,
          nameInputX = -200,
          nameInputY = 60,
          privateToggleX = -200,
          privateToggleY = 20,
          victorToggleX = -45,
          victorToggleY = -14,
        } -- end Purple player entry
      } -- end "players" subtable
    }, -- end Orange vs. Purple
  } -- end playersTables

  for j,thesePlayers in ipairs(playersTables) do
    local toggleEntries = {}
    local visibilityString = thesePlayers.player1.."|"..thesePlayers.player2.."|Black|Grey"
    --printToAll("player1: "..thesePlayers.player1)
    --printToAll("player2: "..thesePlayers.player2)
    table.insert(toggleEntries, { -- Toggle element for the Draw Victor.
        tag = "Toggle",
        --value = "Draw",
        attributes = {
          id = "Draw",
          onValueChanged = "setVictor",
          textColor = "Gray",
          width = "0",
          height = "0",
          offsetXY = thesePlayers.drawToggleX.." "..thesePlayers.drawToggleY,
          rotation = thesePlayers.rotation,
          colors = "White|Gray|Black",
          --position = "0 -15 0",
          visibility = visibilityString,
          isOn = "true",
        }, -- end Toggle attributes
      }) -- end Toggle
    -- Loop through the "players" subtable to add their respective UI elements.
    for i,thisPlayer in ipairs(thesePlayers.players) do
      --printToAll("   player loop: "..thisPlayer.color)
      --printToAll("      headerX: "..thisPlayer.headerX)
      --printToAll("      headerY: "..thisPlayer.headerY)
      --printToAll("      privateToggleX: "..thisPlayer.privateToggleX)
      --printToAll("      privateToggleY: "..thisPlayer.privateToggleY)
      --printToAll("      nameInputX: "..thisPlayer.nameInputX)
      --printToAll("      nameInputY: "..thisPlayer.nameInputY)
      --printToAll("      victorToggleX: "..thisPlayer.victorToggleX)
      --printToAll("      victorToggleY: "..thisPlayer.victorToggleY)
      local visibilityString = thisPlayer.color.."|"..thisPlayer.opposite.."|Black|Grey"
      table.insert(uiTable, {-- Text element.
          tag = "Text",
          attributes = {
            text = thisPlayer.color.." Character",
            offsetXY = thisPlayer.headerX.." "..(thisPlayer.headerY+thesePlayers.offsetY),
            rotation = thesePlayers.rotation,
            fontSize = "32",
            color = thisPlayer.color,
            visibility = visibilityString,
          }, -- end attributes for Text
        }) -- end Text element
    table.insert(uiTable, { -- Toggle element.
          tag = "Toggle",
          attributes = {
            onValueChanged = "setHide",
            id = thisPlayer.color..' Private Toggle',
            offsetXY = thisPlayer.privateToggleX.." "..(thisPlayer.privateToggleY+thesePlayers.offsetY),
            rotation = thesePlayers.rotation,
            text = "Keep my name private",
            textColor = "White",
            width = "200",
            --tooltip = "Hide your Steam name on the public sheet.",
            --tooltipPosition = "Below",
            --tooltipBackgroundColor = [[rbga(0,0,0,0)]],
            visibility = visibilityString,
          }, -- end Toggle attributes
        }) -- end Toggle element
    table.insert(uiTable, {-- InputField element.
          tag = "InputField",
          attributes = {
            onEndEdit = "setFighter",
            id = thisPlayer.color..' Name Input',
            resizeTextForBestFit = "true",
            offsetXY = thisPlayer.nameInputX.." "..(thisPlayer.nameInputY+thesePlayers.offsetY),
            rotation = thesePlayers.rotation,
            width = "220",
            height = "40",
            visibility = visibilityString,
          }, -- end attributes for InputField
        }) -- end InputField element
    table.insert(toggleEntries, { -- Toggle element.
      tag = "Toggle",
      --value = player2,
      attributes = {
        id = thisPlayer.color..' Victor Toggle',
        onValueChanged = "setVictor",
        textColor = thisPlayer.color,
        width = "200",
        --height = "0",
        offsetXY = thisPlayer.victorToggleX.." "..thisPlayer.victorToggleY,
        rotation = thesePlayers.rotation,
        colors = "White|"..thisPlayer.color.."|Black",
        --position = "-45 15 0",
        visibility = visibilityString,
      }, -- end Toggle attributes
    }) -- end Toggle
    end

    --printToAll("   toggleGroupX: "..thesePlayers.toggleGroupX)
    --printToAll("   toggleGroupY: "..thesePlayers.toggleGroupY)
    --printToAll("   rotation: "..thesePlayers.rotation)

    table.insert(uiTable, { -- ToggleGroup element.
      tag = "ToggleGroup",
      attributes = {
        --id = player1..player2..' Data Victor',
        width = "0",
        height = "0",
        offsetXY = thesePlayers.toggleGroupX.." "..(thesePlayers.toggleGroupY+thesePlayers.offsetY),
        rotation = thesePlayers.rotation,
        --tooltip = "Who won?",
        --tooltipOffset = 50,
        --tooltipPosition = "Below",
        --tooltipBackgroundColor = [[rbga(0,0,0,0)]],
        scale = "1.5 1.5",
      }, -- end ToggleGroup attributes
      children = toggleEntries,
    }) -- end ToggleGroup
    table.insert(uiTable, {-- Text element.
        tag = "Text",
        attributes = {
          text = "Victor",
          offsetXY = thesePlayers.victorHeaderX.." "..(thesePlayers.victorHeaderY+thesePlayers.offsetY),
          rotation = thesePlayers.rotation,
          fontSize = "24",
          color = "Grey",
          visibility = visibilityString,
        }, -- end attributes for Text
      }) -- end Text element
    table.insert(uiTable, {-- Dropdown element.
        tag = "Dropdown",
        children = {
          { tag = "Option", value = "Knockout", attributes = { rotation = thesePlayers.rotation, }, },
          { tag = "Option", value = "Deckout", attributes = { rotation = thesePlayers.rotation, }, },
          { tag = "Option", value = "Concession", attributes = { rotation = thesePlayers.rotation, }, },
          { tag = "Option", value = "Inconclusive", attributes = { rotation = thesePlayers.rotation, }, },
        }, -- end Dropdown children
        attributes = {
          id = thesePlayers.player1..thesePlayers.player2..' Outcome',
          onValueChanged = "setCondition",
          --[=[ position = "0 0 200",
          Setting the position to "0 0 Z" where Z is any substantial value will introduce a glitch where the dropdown contents appear at a different... "elevation" than the dropdown itself.
          Stranger still, setting the position to "0 0 0" STILL introduces the glitch, but in a less obvious fashion. Not setting a position at all is the workaround. ]=]
          --width = "120",
          offsetXY = thesePlayers.outcomeX.." "..(thesePlayers.outcomeY+thesePlayers.offsetY),
          rotation = thesePlayers.rotation,
          --visibility = visibilityString,
          --[=[
          Setting visibility of a Dropdown while setting the XML works, yet kicks an "Object reference not set to an instance of an object error."
          This error occurs regardless of whether the XML is set in editor or written by this function.
          In order to avoid spitting a meaningless error to the end user, we'll have to set this specific attribute afterward.]=]
          --tooltip = "How did the game end?",
          --tooltipOffset = 10,
          --tooltipPosition = "Above",
          --tooltipBackgroundColor = [[rbga(0,0,0,0)]],
        }, -- end attributes for Dropdown
      }) -- end Dropdown
  end
--[==[
----------------------- Submit button. -----------------------
    { -- Button element.
      tag = "Button",
      value = "Submit",
      attributes = {
        onClick = "saySomething",
        id = player1..player2..' Data Submit',
        position = "0 -60 0",
        width = "60",
        height = "30",
        colors = "#333333|#333333|#333333",
        fontStyle = "Bold",
        visibility = visibilityString,
        tooltip = "Submit game result to the match result database.",
        tooltipPosition = "Below",
      }, -- end attributes for Button
    }, -- end Button
----------------------- End submit button. -----------------------
  }-- end setXMLTable

  for i,v in ipairs(uiElements) do
    printToAll("inserting element "..i)
    table.insert(uiTable, v)
  end
--]==]
  return uiTable
end -- end matchRecordPrep

--[=====[
function setCondition(player, option, id)
  condition = option
end

function setFighter(player, option, id)
  if id == player1..' Data Character' then
    fighter1 = option
  elseif id == player2..' Data Character' then
    fighter2 = option
  end
  if fighter1 != "" and fighter2 != "" then
    self.UI.setAttribute(player1..player2..' Data Submit', "colors", "#33DD33|#66FF66|#33DD33")
  end
end

function setHide(player, option, id)
  if id == player1..' Data Toggle' then
    hide1 = option
  elseif id == player2..' Data Toggle' then
    hide2 = option
  end
end

function setVictor(player, option, id)
  if option == "True" then
    --print(id)
    victor = id
    --printToAll("victor set: "..victor)
  end
end

function saySomething(player, option, id)
    if fighter1 == "" or fighter2 == "" then
      return
    end
    local STAT_URL = "https://script.google.com/macros/s/AKfycbyV_1p2_1DvjRE6nxDZq8MiQzwiagy4yL0cyxW6/exec"
    local publicName1 = player1
    local publicName2 = player2
    if hide1 == "True" then
      publicName1 = player1
    elseif hide1 == "False" then
      publicName1 = Player[player1].steam_name
    end
    if hide2 == "True" then
      publicName2 = player2
    elseif hide2 == "False" then
      publicName2 = Player[player2].steam_name
    end
    local GameRecord = {
      player1Color = player1,
      player2Color = player2,
      player1ID = Player[player1].steam_id,
      player2ID = Player[player2].steam_id,
      player1Name = publicName1,
      player2Name = publicName2,
      player1Fighter = fighter1,
      player2Fighter = fighter2,
      victoriousPlayer = victor,
      victoryType = condition,
      player1Life = "P1L",
      player2Life = "P2L",
    }
    --WebRequest.post(STAT_URL, GameRecord, function(w) log(w.text) end)
    printToAll(player.steam_name.." selected: "..option)
    printToAll("color1: "..player1, player1)
    printToAll("color2: "..player2, player2)
    printToAll("victor: "..victor)
    printToAll("method: "..condition)
    printToAll("fighter1: "..fighter1, player1)
    printToAll("fighter2: "..fighter2, player2)
    printToAll("hide name 1: "..hide1, player1)
    printToAll("hide name 2: "..hide2, player2)
    self.UI.setAttribute(player1..player2..' Data Submit', "onClick", "")
    self.UI.setAttribute(player1..player2..' Data Submit', "colors", "#DD6666|#DD6666|#DD3333")
    Wait.frames(function ()
      self.UI.setAttribute(player1..player2..' Data Submit', "onClick", "saySomething")
      self.UI.setAttribute(player1..player2..' Data Submit', "colors", "#33DD33|#66FF66|#33DD33")
    end, 600)
end
--]=====]

--]====]