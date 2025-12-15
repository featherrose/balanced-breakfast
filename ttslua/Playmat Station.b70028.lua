-- Playmat Station
function onLoad(script_state)

  local saveState = JSON.decode(script_state)

  local characterStationGUID = Global.getVar("characterStationGUID")

  characterStation = getObjectFromGUID(characterStationGUID)

  if Global.getVar("debugFlag") == true then printToAll("Benchmarking, Playmat Station, loading at: "..os.time()) end

  -- This is just a shortcut for effects that need to hide something from all players.
  allPlayers = {
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
    "Black",
    "Grey"
  }

  -- This tracks which players are considered seated based on the status of the wings.
  playerStatusCount = 10
  playerStatusList = {
    Red = true,
    Blue = true,
    Yellow = true,
    Green = true,
    Orange = true,
    Purple = true,
    White = true,
    Teal = true,
    Pink = true,
    Brown = true,
    Black = false,
    Grey = false,
  }

  if saveState != nil then
    for eachPlayer,status in pairs(saveState.playerStatusList) do
      debugLog{"status check: "..eachPlayer, 4}
      playerStatusList[eachPlayer] = status
    end
  end

  -- April Fool's Exceed 2024
  glitchMatList = {
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/C1SF0Zw.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YlMq0wI.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/e26Byuz.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7K1a51n.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UxkXYqL.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7Qqik3T.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pUix6q1.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Uio2uFO.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0M2PdXY.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8MwtnlW.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TLi3Qi7.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ygb7k4u.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/F35IbSd.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RTLzSyO.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QDILbJV.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lvLHQHR.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KAfyPiw.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QjRkE6p.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CyRADR0.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RFjm2lj.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ja39qhQ.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1vaUwrN.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sapPIyv.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qizU65a.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/amt2jiU.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wTrmsp5.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/D3nvmRq.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cKhuNYL.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aDl5rO8.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0hzpJlg.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/52qwXHN.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pDpJ6gn.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4gMx0L8.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/24DMdZ8.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mSR60KB.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1HYQ7BW.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mdbJGi3.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Z58BzHO.jpg]],
    [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nMHNqMG.jpg]]
  }

  playerPairs = {
    Red = {
      opposingPlayer = [[Blue]],
      -- lifeTracker = getObjectFromGUID([[41ab1d]]),
      lifeTrackerGUID = [[41ab1d]],
      lifePositionModifier = { x = 1, y = 1, z = 1 },
      lifePositionOffsetX = 0,
      lifePositionOffsetZ = 0,
      lifePositionSwap = false,
      currentMat = [[GGST]],
      currentVariant = 1,
      --playmat = getObjectFromGUID([[675010]]),
      playmatGUID = [[675010]],
      playmatPosition = [[Center]],
      playmatRotationX = 0.08,
      playmatRotationY = 0,
      playmatRotationZ = 0,
      halfButtonText = [[←]],
    },
    Blue = {
      opposingPlayer = [[Red]],
      -- lifeTracker = getObjectFromGUID([[c1df1c]]),
      lifeTrackerGUID = [[c1df1c]],
      lifePositionModifier = { x = -1, y = 1, z = -1 },
      lifePositionOffsetX = 0,
      lifePositionOffsetZ = 0,
      lifePositionSwap = false,
      currentMat = [[GGST]],
      currentVariant = 1,
      --playmat = getObjectFromGUID([[edde1b]]),
      playmatGUID = [[edde1b]],
      playmatPosition = [[Center]],
      playmatRotationX = 0.08,
      playmatRotationY = 180,
      playmatRotationZ = 0,
      halfButtonText = [[→]],
    },
    Yellow = {
      opposingPlayer = [[Green]],
      -- lifeTracker = getObjectFromGUID([[85bf68]]),
      lifeTrackerGUID = [[85bf68]],
      lifePositionModifier = { x = 1, y = 1, z = 1 },
      lifePositionOffsetX = 70,
      lifePositionOffsetZ = 0,
      lifePositionSwap = false,
      currentMat = [[255]],
      currentVariant = 1,
      --playmat = getObjectFromGUID([[82d0de]]),
      playmatGUID = [[82d0de]],
      playmatPosition = [[Starboard]],
      playmatRotationX = 0.08,
      playmatRotationY = 0,
      playmatRotationZ = 0,
      halfButtonText = [[←]],
    },
    Green = {
      opposingPlayer = [[Yellow]],
      -- lifeTracker = getObjectFromGUID([[388734]]),
      lifeTrackerGUID = [[388734]],
      lifePositionModifier = { x = -1, y = 1, z = -1 },
      lifePositionOffsetX = 70,
      lifePositionOffsetZ = 0,
      lifePositionSwap = false,
      currentMat = [[255]],
      currentVariant = 1,
      --playmat = getObjectFromGUID([[0fef37]]),
      playmatGUID = [[0fef37]],
      playmatPosition = [[Starboard]],
      playmatRotationX = 0.08,
      playmatRotationY = 180,
      playmatRotationZ = 0,
      halfButtonText = [[→]],
    },
    Orange = {
      opposingPlayer = [[Purple]],
      -- lifeTracker = getObjectFromGUID([[221281]]),
      lifeTrackerGUID = [[221281]],
      lifePositionModifier = { x = 1, y = 1, z = 1 },
      lifePositionOffsetX = -70,
      lifePositionOffsetZ = 0,
      lifePositionSwap = false,
      currentMat = [[MuseDash]],
      currentVariant = 1,
      --playmat = getObjectFromGUID([[12e7cc]]),
      playmatGUID = [[12e7cc]],
      playmatPosition = [[Larboard]],
      playmatRotationX = 0.08,
      playmatRotationY = 0,
      playmatRotationZ = 0,
      halfButtonText = [[←]],
    },
    Purple = {
      opposingPlayer = [[Orange]],
      -- lifeTracker = getObjectFromGUID([[63cd60]]),
      lifeTrackerGUID = [[63cd60]],
      lifePositionModifier = { x = -1, y = 1, z = -1 },
      lifePositionOffsetX = -70,
      lifePositionOffsetZ = 0,
      lifePositionSwap = false,
      currentMat = [[MuseDash]],
      currentVariant = 1,
      --playmat = getObjectFromGUID([[6aacbb]]),
      playmatGUID = [[6aacbb]],
      playmatPosition = [[Larboard]],
      playmatRotationX = 0.08,
      playmatRotationY = 180,
      playmatRotationZ = 0,
      halfButtonText = [[→]],
    },
    White = {
      opposingPlayer = [[Teal]],
      -- lifeTracker = getObjectFromGUID([[2f6462]]),
      lifeTrackerGUID = [[2f6462]],
      lifePositionModifier = { x = 1, y = 1, z = -1 },
      lifePositionOffsetX = 0,
      lifePositionOffsetZ = -70,
      lifePositionSwap = true,
      currentMat = [[Bascule]],
      currentVariant = 1,
      --playmat = getObjectFromGUID([[20a5eb]]),
      playmatGUID = [[20a5eb]],
      playmatPosition = [[Aft]],
      playmatRotationX = 0.08,
      playmatRotationY = 90,
      playmatRotationZ = 0,
      halfButtonText = [[↑]],
    },
    Teal = {
      opposingPlayer = [[White]],
      -- lifeTracker = getObjectFromGUID([[f65e3d]]),
      lifeTrackerGUID = [[f65e3d]],
      lifePositionModifier = { x = -1, y = 1, z = 1 },
      lifePositionOffsetX = 0,
      lifePositionOffsetZ = -70,
      lifePositionSwap = true,
      currentMat = [[Bascule]],
      currentVariant = 1,
      --playmat = getObjectFromGUID([[66f138]]),
      playmatGUID = [[66f138]],
      playmatPosition = [[Aft]],
      playmatRotationX = 0.08,
      playmatRotationY = 270,
      playmatRotationZ = 0,
      halfButtonText = [[↓]],
    },
    Pink = {
      opposingPlayer = [[Brown]],
      -- lifeTracker = getObjectFromGUID([[6f9030]]),
      lifeTrackerGUID = [[6f9030]],
      lifePositionModifier = { x = 1, y = 1, z = -1 },
      lifePositionOffsetX = 0,
      lifePositionOffsetZ = 70,
      lifePositionSwap = true,
      currentMat = [[SkullGirls]],
      currentVariant = 3,
      --playmat = getObjectFromGUID([[fedcc0]]),
      playmatGUID = [[fedcc0]],
      playmatPosition = [[Fore]],
      playmatRotationX = 0.08,
      playmatRotationY = 90,
      playmatRotationZ = 0,
      halfButtonText = [[↑]],
    },
    Brown = {
      opposingPlayer = [[Pink]],
      -- lifeTracker = getObjectFromGUID([[dfb25f]]),
      lifeTrackerGUID = [[dfb25f]],
      lifePositionModifier = { x = -1, y = 1, z = 1 },
      lifePositionOffsetX = 0,
      lifePositionOffsetZ = 70,
      lifePositionSwap = true,
      currentMat = [[SkullGirls]],
      currentVariant = 3,
      --playmat = getObjectFromGUID([[7bd8c6]]),
      playmatGUID = [[7bd8c6]],
      playmatPosition = [[Fore]],
      playmatRotationX = 0.08,
      playmatRotationY = 270,
      playmatRotationZ = 0,
      halfButtonText = [[↓]],
    },
  }

  if saveState != nil then
    for player,matInfo in pairs(saveState.playerPairs) do
      debugLog{"mat info check: "..player, 4}
      playerPairs[player].currentMat = matInfo.currentMat
      playerPairs[player].currentVariant = matInfo.currentVariant
    end
  end

  standardSnapPoints = {
    { position = { x = -7.055741, y = 0.592245042, z = 0 } },
    { position = { x = -5.29180574, y = 0.592245042, z = 0 } },
    { position = { x = -3.52787042, y = 0.592245042, z = 0 } },
    { position = { x = -1.76393521, y = 0.592245042, z = 0 } },
    { position = { x = 1.25402921E-09, y = 0.592245042, z = 0 } },
    { position = { x = 1.76393521, y = 0.592245042, z = 0 } },
    { position = { x = 3.52787042, y = 0.592245042, z = 0 } },
    { position = { x = 5.29180574, y = 0.592245042, z = 0 } },
    { position = { x = 7.055741, y = 0.592245042, z = 0 } },
    { position = { x = -6.657264, y = 0.592247, z = 5.64814663 },
      rotation = { x = 0.0, y = 0.0, z = 180.0 },
      rotation_snap = true },
    { position = { x = 4.65692043, y = 0.5922401, z = -5.648222 },
      rotation = { x = 0.0, y = 180.0, z = 180.0 },
      rotation_snap = true },
    { position = { x = 6.65733957, y = 0.5922425, z = -5.648222 },
      rotation = { x = 0.0, y = 180.0, z = 180.0 },
      rotation_snap = true },
    { position = { x = -4.65676451, y = 0.592244267, z = 5.64806938 },
      rotation = { x = 0.0, y = 0.0, z = 180.0 },
      rotation_snap = true }
  } -- end standardSnapPoints

  playmatsTable = {}

-- Setting up playmat settings and button parameters.
    playmatsTable["RedHorizon"] = {
  	  GUID = [[018120]],
      label = 'Red Horizon',
      tooltip = 'Official S1 playmat!',
      variants = 1,
      currentVariant = 1,
      variantList = {
		       { image = [[https://steamusercontent-a.akamaihd.net/ugc/792000083429082383/3D5E89DCBF8D4E9B848F6CCDBF92780AFFEFB093/]],
              sample = [[https://steamusercontent-a.akamaihd.net/ugc/792000083429082383/3D5E89DCBF8D4E9B848F6CCDBF92780AFFEFB093/]] },
      },
      fullboardSize = {1.04, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {49.4, 1, 6},
      miniboardRotation = {0, 180, 0},
      lifePositionLeft = { x = 11.48, y = 1.25, z = 7.65},
      lifePositionRight = { x = 11.48, y = 1.25, z = 7.65},
      matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position =  { x = 7.27233648, y = 0.59224534, z = 0.00268713757 } },
        { position =  { x = 5.45435143, y = 0.59224534, z = 0.002688982 } },
        { position =  { x = 3.636363, y = 0.59224534, z = 0.002686882 } },
        { position =  { x = 1.8195231, y = 0.59224534, z = 0.00264568673 } },
        { position =  { x = 0.0003952867, y = 0.59224534, z = 0.00268716156 } },
        { position =  { x = -1.81759381, y = 0.59224534, z = 0.002685132 } },
        { position =  { x = -3.63558125, y = 0.59224534, z = 0.002686589 } },
        { position =  { x = -5.453566, y = 0.59224534, z = 0.00268564257 } },
        { position =  { x = -7.271555, y = 0.5922452, z = 0.00268403627 } },
        { position =  { x = 6.967375, y = 0.5894397, z = -5.826448 },
          rotation =  { x = 0.0, y = 180.0, z = 0.0 },
          rotation_snap = true },
        { position =  { x = -7.111958, y = 0.591215, z = 5.9400363 },
          rotation =  { x = 0.0, y = 0.0, z = 0.0 },
          rotation_snap = true },
        { position =  { x = -4.970759, y = 0.614681065, z = 5.902611 },
          rotation =  { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position =  { x = 4.955902, y = 0.5926101, z = -5.902629 },
          rotation =  { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      }, -- end snapPoints
    }

----------------------------------------------

    playmatsTable["SeventhCross"] = {
  	  GUID = [[5d79ad]],
      label = 'Seventh Cross',
      tooltip = 'Official S2 playmat!',
      variants = 1,
      currentVariant = 1,
      variantList = {
        { image = [[https://steamusercontent-a.akamaihd.net/ugc/792000083429086245/D464BB20C4826E42081724AC1B9D5558CA3349B8/]],
           sample = [[https://steamusercontent-a.akamaihd.net/ugc/792000083429086245/D464BB20C4826E42081724AC1B9D5558CA3349B8/]] },
        --[=[ April Fool's Exceed 2023
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QWLC5sP.jpg]],
          sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/FfETsUm.jpg]] },
        --]=]
      },
      fullboardSize = {1.06, 0.17, 1.06},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {49.4, 1, 6},
      miniboardRotation = {0, 180, 0},
      lifePositionLeft = { x = 15.23, y = 1.25, z = 3.1},
      lifePositionRight = { x = 15.23, y = 1.25, z = 3.1},
      matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position =  { x = 7.130721, y = 0.5922434, z = 9.73997E-07 } },
        { position =  { x = 5.34804058, y = 0.5922433, z = 7.05353671E-07 } },
        { position =  { x = 3.56536055, y = 0.5922424, z = 5.60589342E-07 } },
        { position =  { x = 1.78380251, y = 0.5922433, z = -4.36825176E-05 } },
        { position =  { x = -1.78268027, y = 0.5922433, z = -1.94243327E-07 } },
        { position =  { x = -3.56536055, y = 0.5922433, z = -5.160015E-07 } },
        { position =  { x = -5.34804058, y = 0.5922433, z = -7.38942845E-07 } },
        { position =  { x = -7.130721, y = 0.592243254, z = -1.13154022E-06 } },
        { position =  { x = 4.319296E-08, y = 0.592241466, z = 4.91402252E-09 } },
        { position =  { x = -6.967852, y = 0.6047976, z = 6.16299963 },
          rotation = { x = 0.0, y = 0.0, z = 0.0 },
          rotation_snap = true },
        { position =  { x = 7.068872, y = 0.595866859, z = -6.08224726 },
          rotation = { x = 0.0, y = 180.0, z = 0.0 },
          rotation_snap = true },
        { position =  { x = -4.93036938, y = 0.606836736, z = 6.16053534 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position =  { x = 4.936446, y = 0.6025556, z = -6.16210556 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      }, -- end snapPoints
    }

    playmatsTable["StreetFighter"] = {
	    GUID = [[3cc91e]],
  		label = 'Street Fighter',
  		tooltip = 'Official S3 playmat!',
  		variants = 1,
  		currentVariant = 1,
  		variantList = {
  			   { image = [[https://steamusercontent-a.akamaihd.net/ugc/792000083429074405/0A22BE88471F2EC896087D4C652E1043EB652C95/]],
              sample = [[https://steamusercontent-a.akamaihd.net/ugc/792000083429074405/0A22BE88471F2EC896087D4C652E1043EB652C95/]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		--miniboardPosition = {49.4, 1, 0},
  		miniboardRotation = {0, 180, 0},
  		lifePositionLeft = { x = 13.5, y = 1.25, z = 3},
  		lifePositionRight = { x = 13.5, y = 1.25, z = 3},
  		matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = 7.000685, y = 0.592243254, z = 2.04175217E-06 } },
        { position = { x = 5.25051165, y = 0.592245162, z = 2.00494787E-06 } },
        { position = { x = 3.500341, y = 0.592243254, z = 1.14188174E-06 } },
        { position = { x = 1.75127184, y = 0.592243254, z = -4.220263E-05 } },
        { position = { x = 9.19866352E-07, y = 0.592243254, z = -3.80208036E-07 } },
        { position = { x = -1.750171, y = 0.592243254, z = 9.05154849E-08 } },
        { position = { x = -3.50034165, y = 0.592245162, z = 4.74634732E-07 } },
        { position = { x = -5.25051165, y = 0.592243254, z = 3.8990882E-07 } },
        { position = { x = -7.0006814, y = 0.592243254, z = -7.98082965E-07 } },
        { position = { x = 6.951458, y = 0.6006233, z = -6.06740427 },
          rotation = { x = 0.0, y = 180.0, z = 0.0 },
          rotation_snap = true },
        { position = { x = -6.90864038, y = 0.5937023, z = 6.048241 },
          rotation = { x = 0.0, y = 0.0, z = 0.0 },
          rotation_snap = true },
        { position = { x = -4.838735, y = 0.5979734, z = 6.04717159 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.84945965, y = 0.6051328, z = -6.047847 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      }, -- end snapPoints
    }

    playmatsTable["SkullGirls"] = {
  	  GUID = [[dc0d8f]],
      label = 'SkullGirls',
      tooltip = 'Fan design by SeijiTataki!',
      variants = 1,
      currentVariant = 1,
      variantList = {
		       { image = [[https://steamusercontent-a.akamaihd.net/ugc/792000083429070701/E54C154D00B9D47DA49D6E8B4189F938786C3280/]],
              sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qCtnoIu.jpg]] },
      },
      fullboardSize = {1.04, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {49.4, 1, -6},
      miniboardRotation = {0, 180, 0},
      lifePositionLeft = { x = 13.5, y = 1.25, z = 3},
      lifePositionRight = { x = 13.5, y = 1.25, z = 3},
      matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = 7.21917, y = 0.5922435, z = 2.675702E-06 } },
        { position = { x = 5.41437674, y = 0.5922435, z = 4.197246E-06 } },
        { position = { x = 3.60958385, y = 0.5922435, z = 2.77762138E-06 } },
        { position = { x = 1.8059299, y = 0.5922435, z = -4.095715E-05 } },
        { position = { x = 3.16740966E-06, y = 0.5922435, z = 1.97677E-06 } },
        { position = { x = -1.80479169, y = 0.5922435, z = 2.01577336E-06 } },
        { position = { x = -3.609583, y = 0.5922435, z = 2.44255739E-06 } },
        { position = { x = -5.41437435, y = 0.5922435, z = 1.4219537E-06 } },
        { position = { x = -7.21916771, y = 0.5922435, z = -5.65227538E-07 } },
        { position = { x = -7.164442, y = 0.606305063, z = 5.90829372 },
          rotation = { x = 0.0, y = 0.0, z = 0.0 },
          rotation_snap = true },
        { position = { x = 7.17910528, y = 0.593144357, z = -5.909349 },
          rotation = { x = 0.0, y = 180.0, z = 0.0 },
          rotation_snap = true },
        { position = { x = -5.14236975, y = 0.5945173, z = 5.907585 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 5.137111, y = 0.603945732, z = -5.90895748 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["AprilFools"] = {
  	  GUID = [[f61156]],
      label = 'v_v',
      tooltip = 'Fan design by TaxiCAB!',
      variants = 1,
      currentVariant = 1,
      variantList = {
		       { image = [[https://steamusercontent-a.akamaihd.net/ugc/792000083429078875/B6DD8B1F459E437A767E0356704196BD73493E84/]],
              sample = [[https://steamusercontent-a.akamaihd.net/ugc/792000083429078875/B6DD8B1F459E437A767E0356704196BD73493E84/]] },
      },
      fullboardSize = {3, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.15, 0.1, 0.05},
      --miniboardPosition = {54.9, 30, 0},
      miniboardRotation = {0, 180, 270},
      lifePositionLeft = { x = -10.88, y = 1, z = 3.11},
      lifePositionRight = { x = -3, y = 3.25, z = 12},
      matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = 5.273541, y = 0.592240453, z = -5.894084 },
          rotation = { x = 3.00196348E-06, y = 178.848114, z = -1.075002E-09 },
          rotation_snap = true },
        { position = { x = 7.68716145, y = 0.5922345, z = -0.491815448 },
          rotation = { x = 9.866294E-06, y = 354.999969, z = -6.551721E-06 },
          rotation_snap = true },
        { position = { x = 5.464491, y = 0.5922345, z = -0.3125016 },
          rotation = { x = -2.024783E-05, y = 20.0000381, z = -0.000318140053 },
          rotation_snap = true },
        { position = { x = 3.60851, y = 0.5922345, z = -0.0518718176 },
          rotation = { x = 1.57207942, y = 279.001648, z = -0.00042886255 },
          rotation_snap = true },
        { position = { x = 1.77546859, y = 0.5922345, z = 0.189229891 },
          rotation = { x = 0.8240679, y = 336.013062, z = 1.34795177 },
          rotation_snap = true },
        { position = { x = -1.801186, y = 0.5922345, z = -0.3750051 },
          rotation = { x = -8.777881E-05, y = 299.999878, z = -0.0007090777 },
          rotation_snap = true },
        { position = { x = -4.387443, y = 0.5922345, z = -0.6741812 },
          rotation = { x = -1.40901529E-05, y = 6.076232, z = -0.0003632247 },
          rotation_snap = true },
        { position = { x = -6.07627869, y = 0.5922345, z = 0.3123758 },
          rotation = { x = 0.6071917, y = 18.96741, z = 358.582642 },
          rotation_snap = true },
        { position = { x = -6.96330452, y = 0.5922345, z = -0.60555613 },
          rotation = { x = 359.457733, y = 335.000427, z = 358.5749 },
          rotation_snap = true },
        { position = { x = -7.70176458, y = 0.5922345, z = -0.0836375356 },
          rotation = { x = 0.00110354158, y = 356.971863, z = 0.00777606526 },
          rotation_snap = true },
        { position = { x = -5.81511641, y = 0.592228532, z = 5.953835 },
          rotation = { x = 2.39994552E-05, y = 353.005768, z = -1.0314925E-05 },
          rotation_snap = true },
        { position = { x = -8.043716, y = 0.592228532, z = 6.49316025 },
          rotation = { x = 1.32556479E-05, y = 0.999994338, z = 1.08029026E-05 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Sonic"] = {
  	  GUID = [[acc515]],
      label = 'Sonic',
      tooltip = 'Fan design by BeanieBoyBob!',
      variants = 1,
      currentVariant = 1,
      variantList = {
		       { image = [[https://steamusercontent-a.akamaihd.net/ugc/792000083429091364/5879605CA7DC2649CE13396A880A1036934EBA6D/]],
              sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/m2bTOB1.jpg]] },
      },
      fullboardSize = {1.05, 0.17, 1.05},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {49.4, 1, -12},
      miniboardRotation = {0, 180, 0},
      lifePositionLeft = { x = 13.5, y = 1.25, z = 3},
      lifePositionRight = { x = 13.5, y = 1.25, z = 3},
      matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = 5.50578928, y = 0.5922435, z = 8.20340745E-07 } },
        { position = { x = 7.352305, y = 0.5922414, z = 1.09731252E-06 } },
        { position = { x = 3.6727767, y = 0.5922414, z = 5.43422857E-07 } },
        { position = { x = 1.82963693, y = 0.5922414, z = 2.52522881E-07 } },
        { position = { x = -7.359056, y = 0.5922433, z = -1.10044209E-06 } },
        { position = { x = -5.529419, y = 0.5922433, z = -8.3763473E-07 } },
        { position = { x = -3.68290377, y = 0.5922433, z = -5.519377E-07 } },
        { position = { x = -1.85326684, y = 0.5922433, z = -2.80802965E-07 } },
        { position = { x = 5.121084E-10, y = 0.5922435, z = -1.68925274E-09 } },
        { position = { x = 7.16823959, y = 0.6048521, z = -5.994843 },
          rotation = { x = 0.0, y = 180.0, z = 0.0 },
          rotation_snap = true },
        { position = { x = -7.125637, y = 0.599588335, z = 5.998759 },
          rotation = { x = 0.0, y = 0.0, z = 0.0 },
          rotation_snap = true },
        { position = { x = -4.99009275, y = 0.6076418, z = 5.98938942 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 5.017516, y = 0.5899363, z = -6.00054455 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["LegalWuhu"] = {
  		GUID = [[dbfae8]],
  		label = 'Legal Wuhu',
  		tooltip = 'Fan design by Moriatti!',
  		variants = 1,
  		currentVariant = 1,
  		variantList = {
  			   { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IjpvO65.png]],
              sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RtZog7v.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 15.23, y = 1.25, z = 3.1},
  		lifePositionRight = { x = 15.23, y = 1.25, z = 3.1},
  		matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.81144252E-08, y = 0.5922387, z = 1.530511E-07 } },
        { position = { x = -7.16702461, y = 0.592238665, z = -9.834694E-05 } },
        { position = { x = -5.3629303, y = 0.5922387, z = -8.177834E-06 } },
        { position = { x = -3.58077049, y = 0.592241168, z = -4.91331448E-05 } },
        { position = { x = -1.78215992, y = 0.5922441, z = -2.44528146E-05 } },
        { position = { x = 1.76382577, y = 0.5922392, z = 2.315015E-06 } },
        { position = { x = 3.558836, y = 0.5922429, z = 4.88490878E-05 } },
        { position = { x = 5.34648, y = 0.5922417, z = 7.337064E-05 } },
        { position = { x = 7.14693451, y = 0.592242539, z = 9.807879E-05 } },
        { position = { x = -7.03730536, y = 0.592248, z = 5.88228655 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.91448736, y = 0.5922479, z = 5.882112 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.91630936, y = 0.592235148, z = -5.85151148 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 7.04554367, y = 0.5922322, z = -5.85990334 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["GarouMarkoftheTrain"] = {
  		GUID = [[432915]],
  		label = [[Garou Mark
of the Train]],
  		tooltip = 'Fan design by Moriatti!',
  		variants = 1,
  		currentVariant = 1,
  		variantList = {
  			   { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1I0VXCS.png]],
              sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XKn63C3.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 15.23, y = 1.25, z = 3.1},
  		lifePositionRight = { x = 15.23, y = 1.25, z = 3.1},
  		matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.81144252E-08, y = 0.5922387, z = 1.530511E-07 } },
        { position = { x = -7.16702461, y = 0.592238665, z = -9.834694E-05 } },
        { position = { x = -5.3629303, y = 0.5922387, z = -8.177834E-06 } },
        { position = { x = -3.58077049, y = 0.592241168, z = -4.91331448E-05 } },
        { position = { x = -1.78215992, y = 0.5922441, z = -2.44528146E-05 } },
        { position = { x = 1.76382577, y = 0.5922392, z = 2.315015E-06 } },
        { position = { x = 3.558836, y = 0.5922429, z = 4.88490878E-05 } },
        { position = { x = 5.34648, y = 0.5922417, z = 7.337064E-05 } },
        { position = { x = 7.14693451, y = 0.592242539, z = 9.807879E-05 } },
        { position = { x = -7.03730536, y = 0.592248, z = 5.88228655 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.91448736, y = 0.5922479, z = 5.882112 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.94072247, y = 0.5922378, z = -5.96289968 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 7.084798, y = 0.5922347, z = -5.96287251 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Pokefloats"] = {
  		GUID = [[8efffa]],
  		label = 'Pokefloats',
  		tooltip = 'Fan design by Moriatti!',
  		variants = 1,
  		currentVariant = 1,
  		variantList = {
  			   { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Nf6nBxY.png]],
              sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/k3jQBhV.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 15.23, y = 1.25, z = 3.1},
  		lifePositionRight = { x = 15.23, y = 1.25, z = 3.1},
  		matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.81144252E-08, y = 0.5922387, z = 1.530511E-07 } },
        { position = { x = -7.16702461, y = 0.592238665, z = -9.834694E-05 } },
        { position = { x = -5.3629303, y = 0.5922387, z = -8.177834E-06 } },
        { position = { x = -3.58077049, y = 0.592241168, z = -4.91331448E-05 } },
        { position = { x = -1.78215992, y = 0.5922441, z = -2.44528146E-05 } },
        { position = { x = 1.76382577, y = 0.5922392, z = 2.315015E-06 } },
        { position = { x = 3.558836, y = 0.5922429, z = 4.88490878E-05 } },
        { position = { x = 5.34648, y = 0.5922417, z = 7.337064E-05 } },
        { position = { x = 7.14693451, y = 0.592242539, z = 9.807879E-05 } },
        { position = { x = -7.03730536, y = 0.592248, z = 5.88228655 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.91448736, y = 0.5922479, z = 5.882112 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.94072247, y = 0.5922378, z = -5.96289968 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 7.084798, y = 0.5922347, z = -5.96287251 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["OstrheinsburgChapel"] = {
  		GUID = [[5d2353]],
  		label = [[Ostrheinsburg
Chapel]],
  		tooltip = 'Fan design by Moriatti!',
  		variants = 1,
  		currentVariant = 1,
  		variantList = {
  			   { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4ZR7gZK.png]],
              sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RIiobtb.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 15.23, y = 1.25, z = 3.1},
  		lifePositionRight = { x = 15.23, y = 1.25, z = 3.1},
  		matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.81144252E-08, y = 0.5922387, z = 1.530511E-07 } },
        { position = { x = -7.03730536, y = 0.592248, z = 5.88228655 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.91448736, y = 0.5922479, z = 5.882112 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.94072247, y = 0.5922378, z = -5.96289968 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 7.084798, y = 0.5922347, z = -5.96287251 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -7.43567944, y = 0.592245042, z = -9.843602E-05 } },
        { position = { x = -5.587726, y = 0.592237353, z = -8.149994E-06 } },
        { position = { x = -3.71783972, y = 0.592245042, z = -4.92012659E-05 } },
        { position = { x = -1.86440337, y = 0.592245042, z = -2.45038227E-05 } },
        { position = { x = 1.86440337, y = 0.592245042, z = -4.48100946E-05 } },
        { position = { x = 3.71783972, y = 0.592245042, z = -0.00011987472 } },
        { position = { x = 5.587726, y = 0.592245042, z = -0.0003531264 } },
        { position = { x = 7.43567944, y = 0.592245042, z = -1.03568109E-05 } }
      } -- end snapPoints
    }

    playmatsTable["ShotoShowdown"] = {
  		GUID = [[70b48c]],
  		label = [[Shoto
Showdown]],
  		tooltip = 'Fan design by Chikage!',
  		variants = 4,
  		currentVariant = 1,
  		variantList = {
    			{ image = [[https://i.imgur.com/5eMpC5U.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/eu1fZXF.jpg]] },
    			{ image = [[https://i.imgur.com/dinkZAZ.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PqqS45e.jpg]] },
    			{ image = [[https://i.imgur.com/eq4ydid.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/S7ApaBc.jpg]] },
    			{ image = [[https://i.imgur.com/Wh0MubL.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TF1MCBB.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
  		lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
  		matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.055741, y = 0.592245042, z = -1.19089418E-06 } },
        { position = { x = -5.29180574, y = 0.592245042, z = 5.720136E-07 } },
        { position = { x = -3.52787042, y = 0.592245042, z = -1.90391438E-05 } },
        { position = { x = -1.76393521, y = 0.592245042, z = -5.90666048E-07 } },
        { position = { x = 1.25402921E-09, y = 0.592245042, z = -4.78217927E-08 } },
        { position = { x = 1.76393521, y = 0.592245042, z = 3.26311238E-07 } },
        { position = { x = 3.52787042, y = 0.592245042, z = 1.85104491E-05 } },
        { position = { x = 5.29180574, y = 0.592245042, z = -1.36505719E-06 } },
        { position = { x = 7.055741, y = 0.592245042, z = 1.33497565E-07 } },
        { position = { x = -6.657264, y = 0.592247, z = 5.64814663 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.65677071, y = 0.5922437, z = 5.64806461 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.65692663, y = 0.592244267, z = -5.64822674 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 6.657328, y = 0.5922419, z = -5.64822674 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Sagat&Bison"] = {
  		GUID = [[bf881d]],
  		label = [[Sagat &
Bison]],
  		tooltip = 'Fan design by Chikage!',
  		variants = 4,
  		currentVariant = 1,
  		variantList = {
    			{ image = [[https://i.imgur.com/TRkC8NN.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/P6luosR.jpg]] },
    			{ image = [[https://i.imgur.com/g11bfU5.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/FPfCd29.jpg]] },
    			{ image = [[https://i.imgur.com/AEsZi0l.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/adwEeZP.jpg]] },
    			{ image = [[https://i.imgur.com/bNQunsd.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4XJPJbh.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
  		lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
  		matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.055741, y = 0.592245042, z = -1.19089418E-06 } },
        { position = { x = -5.29180574, y = 0.592245042, z = 5.720136E-07 } },
        { position = { x = -3.52787042, y = 0.592245042, z = -1.90391438E-05 } },
        { position = { x = -1.76393521, y = 0.592245042, z = -5.90666048E-07 } },
        { position = { x = 1.25402921E-09, y = 0.592245042, z = -4.78217927E-08 } },
        { position = { x = 1.76393521, y = 0.592245042, z = 3.26311238E-07 } },
        { position = { x = 3.52787042, y = 0.592245042, z = 1.85104491E-05 } },
        { position = { x = 5.29180574, y = 0.592245042, z = -1.36505719E-06 } },
        { position = { x = 7.055741, y = 0.592245042, z = 1.33497565E-07 } },
        { position = { x = -6.657264, y = 0.592247, z = 5.64814663 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.657327, y = 0.592244267, z = 5.64403534 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.65692663, y = 0.5922419, z = -5.64823151 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 6.6578846, y = 0.5922419, z = -5.644207 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Chun-Li&Cammy"] = {
  		GUID = [[3297a8]],
  		label = [[Chun-Li &
Cammy]],
  		tooltip = 'Fan design by Chikage!',
  		variants = 4,
  		currentVariant = 1,
  		variantList = {
    			{ image = [[https://i.imgur.com/jGwoH4u.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/FXXcdZ3.jpg]] },
    			{ image = [[https://i.imgur.com/gBxV3ji.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2wN8jGj.jpg]] },
    			{ image = [[https://i.imgur.com/jRHaGPG.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8CMrzWY.jpg]] },
    			{ image = [[https://i.imgur.com/hqPijCK.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YMk5LIE.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		--miniboardPosition = {-30.5, 1.37, -19},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
  		lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
  		matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.055741, y = 0.592245042, z = -1.19089418E-06 } },
        { position = { x = -5.29180574, y = 0.592245042, z = 5.720136E-07 } },
        { position = { x = -3.52787042, y = 0.592245042, z = -1.90391438E-05 } },
        { position = { x = -1.76393521, y = 0.592245042, z = -5.90666048E-07 } },
        { position = { x = 1.25402921E-09, y = 0.592245042, z = -4.78217927E-08 } },
        { position = { x = 1.76393521, y = 0.592245042, z = 3.26311238E-07 } },
        { position = { x = 3.52787042, y = 0.592245042, z = 1.85104491E-05 } },
        { position = { x = 5.29180574, y = 0.592245042, z = -1.36505719E-06 } },
        { position = { x = 7.055741, y = 0.592245042, z = 1.33497565E-07 } },
        { position = { x = -6.657264, y = 0.592247, z = 5.64814663 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.65677071, y = 0.592244267, z = 5.64806 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.65692663, y = 0.5922425, z = -5.64823151 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 6.657328, y = 0.5922425, z = -5.64823151 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Naoto&Akihiko"] = {
  		GUID = [[c6e144]],
  		label = [[Naoto &
Akihiko]],
  		tooltip = 'Fan design by Chikage!',
  		variants = 4,
  		currentVariant = 1,
  		variantList = {
    			{ image = [[https://i.imgur.com/U8GhHnU.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7ox2Oh8.jpg]] },
    			{ image = [[https://i.imgur.com/8kCuDoT.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4A1ujah.jpg]] },
    			{ image = [[https://i.imgur.com/iZHNKPY.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/B9ZMbq0.jpg]] },
    			{ image = [[https://i.imgur.com/5sRiujm.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AFr0VUW.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		--miniboardPosition = {-30.5, 1.37, -19},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
  		lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
  		matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.055741, y = 0.592245042, z = -1.19089418E-06 } },
        { position = { x = -5.29180574, y = 0.592245042, z = 5.720136E-07 } },
        { position = { x = -3.52787042, y = 0.592245042, z = -1.90391438E-05 } },
        { position = { x = -1.76393521, y = 0.592245042, z = -5.90666048E-07 } },
        { position = { x = 1.25402921E-09, y = 0.592245042, z = -4.78217927E-08 } },
        { position = { x = 1.76393521, y = 0.592245042, z = 3.26311238E-07 } },
        { position = { x = 3.52787042, y = 0.592245042, z = 1.85104491E-05 } },
        { position = { x = 5.29180574, y = 0.592245042, z = -1.36505719E-06 } },
        { position = { x = 7.055741, y = 0.592245042, z = 1.33497565E-07 } },
        { position = { x = -6.657264, y = 0.592247, z = 5.64814663 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.656921, y = 0.5922419, z = -5.64823151 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 6.65733957, y = 0.5922419, z = -5.64823151 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.65677071, y = 0.592246056, z = 5.64806461 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Tager&Hazama"] = {
  		GUID = [[ce5be8]],
  		label = [[Tager &
Hazama]],
  		tooltip = 'Fan design by Chikage!',
  		variants = 4,
  		currentVariant = 1,
  		variantList = {
    			{ image = [[https://i.imgur.com/kBDijBw.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PDDcZpZ.jpg]] },
    			{ image = [[https://i.imgur.com/VFBN9Wc.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/e5ltDsj.jpg]] },
    			{ image = [[https://i.imgur.com/avIpkBl.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OTNfHXg.jpg]] },
    			{ image = [[https://i.imgur.com/32fQP6v.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rkHHX7a.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		--miniboardPosition = {-30.5, 1.37, -19},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
  		lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
  		matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.055741, y = 0.592245042, z = -1.19089418E-06 } },
        { position = { x = -5.29180574, y = 0.592245042, z = 5.720136E-07 } },
        { position = { x = -3.52787042, y = 0.592245042, z = -1.90391438E-05 } },
        { position = { x = -1.76393521, y = 0.592245042, z = -5.90666048E-07 } },
        { position = { x = 1.25402921E-09, y = 0.592245042, z = -4.78217927E-08 } },
        { position = { x = 1.76393521, y = 0.592245042, z = 3.26311238E-07 } },
        { position = { x = 3.52787042, y = 0.592245042, z = 1.85104491E-05 } },
        { position = { x = 5.29180574, y = 0.592245042, z = -1.36505719E-06 } },
        { position = { x = 7.055741, y = 0.592245042, z = 1.33497565E-07 } },
        { position = { x = -6.657264, y = 0.592247, z = 5.64814663 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.656921, y = 0.5922419, z = -5.64822674 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 6.65733957, y = 0.5922425, z = -5.64822674 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.65677071, y = 0.592244267, z = 5.64806461 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Ragna&Jin"] = {
  		GUID = [[bcac7c]],
  		label = [[Ragna
& Jin]],
  		tooltip = 'Fan design by Chikage!',
  		variants = 4,
  		currentVariant = 1,
  		variantList = {
    			{ image = [[https://i.imgur.com/3rYeaD0.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RuPTzT6.jpg]] },
    			{ image = [[https://i.imgur.com/YfpyVYr.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZnVSRkc.jpg]] },
    			{ image = [[https://i.imgur.com/HmNINvN.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gAOOIhh.jpg]] },
    			{ image = [[https://i.imgur.com/iyippED.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DkPfOpq.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		--miniboardPosition = {-30.5, 1.37, -19},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
  		lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
  		matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.055741, y = 0.592245042, z = -1.19089418E-06 } },
        { position = { x = -5.29180574, y = 0.592245042, z = 5.720136E-07 } },
        { position = { x = -3.52787042, y = 0.592245042, z = -1.90391438E-05 } },
        { position = { x = -1.76393521, y = 0.592245042, z = -5.90666048E-07 } },
        { position = { x = 1.25402921E-09, y = 0.592245042, z = -4.78217927E-08 } },
        { position = { x = 1.76393521, y = 0.592245042, z = 3.26311238E-07 } },
        { position = { x = 3.52787042, y = 0.592245042, z = 1.85104491E-05 } },
        { position = { x = 5.29180574, y = 0.592245042, z = -1.36505719E-06 } },
        { position = { x = 7.055741, y = 0.592245042, z = 1.33497565E-07 } },
        { position = { x = -6.657264, y = 0.592247, z = 5.64814663 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.656921, y = 0.5922419, z = -5.64822674 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 6.65733957, y = 0.5922425, z = -5.64822674 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.65677071, y = 0.5922437, z = 5.64806938 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Yu&Adachi"] = {
  		GUID = [[2dc320]],
  		label = [[Yu &
Adachi]],
  		tooltip = 'Fan design by Chikage!',
  		variants = 4,
  		currentVariant = 1,
  		variantList = {
    			{ image = [[https://i.imgur.com/ZzXM23J.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NmzSRHU.jpg]] },
    			{ image = [[https://i.imgur.com/ACsmmwi.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/opscCFL.jpg]] },
    			{ image = [[https://i.imgur.com/sVoYgnt.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZbiuhUK.jpg]] },
    			{ image = [[https://i.imgur.com/WfJMisF.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/U2cw88b.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		--miniboardPosition = {-30.5, 1.37, -19},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
  		lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
  		matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.055741, y = 0.592245042, z = -1.19089418E-06 } },
        { position = { x = -5.29180574, y = 0.592245042, z = 5.720136E-07 } },
        { position = { x = -3.52787042, y = 0.592245042, z = -1.90391438E-05 } },
        { position = { x = -1.76393521, y = 0.592245042, z = -5.90666048E-07 } },
        { position = { x = 1.25402921E-09, y = 0.592245042, z = -4.78217927E-08 } },
        { position = { x = 1.76393521, y = 0.592245042, z = 3.26311238E-07 } },
        { position = { x = 3.52787042, y = 0.592245042, z = 1.85104491E-05 } },
        { position = { x = 5.29180574, y = 0.592245042, z = -1.36505719E-06 } },
        { position = { x = 7.055741, y = 0.592245042, z = 1.33497565E-07 } },
        { position = { x = -6.657264, y = 0.592247, z = 5.64814663 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.656843, y = 0.5922407, z = -5.648203 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 6.65733957, y = 0.5922425, z = -5.64823151 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.656214, y = 0.5922419, z = 5.649166 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Taisei&Iaquis"] = {
  		GUID = [[00b147]],
  		label = [[Taisei &
Iaquis]],
  		tooltip = 'Fan design by Chikage, who has gone mad with playmat power!',
  		variants = 4,
  		currentVariant = 1,
  		variantList = {
    			{ image = [[https://i.imgur.com/UG3M7WA.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8N7LLaK.jpg]] },
    			{ image = [[https://i.imgur.com/foFizaS.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nWXBeYN.jpg]] },
    			{ image = [[https://i.imgur.com/uB0vXiP.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4j0yGxi.jpg]] },
    			{ image = [[https://i.imgur.com/TWC7f0l.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/D9lMBEi.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		--miniboardPosition = {-30.5, 1.37, -19},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
  		lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
  		matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.055741, y = 0.592245042, z = -1.19089418E-06 } },
        { position = { x = -5.29180574, y = 0.592245042, z = 5.720136E-07 } },
        { position = { x = -3.52787042, y = 0.592245042, z = -1.90391438E-05 } },
        { position = { x = -1.76393521, y = 0.592245042, z = -5.90666048E-07 } },
        { position = { x = 1.25402921E-09, y = 0.592245042, z = -4.78217927E-08 } },
        { position = { x = 1.76393521, y = 0.592245042, z = 3.26311238E-07 } },
        { position = { x = 3.52787042, y = 0.592245042, z = 1.85104491E-05 } },
        { position = { x = 5.29180574, y = 0.592245042, z = -1.36505719E-06 } },
        { position = { x = 7.055741, y = 0.592245042, z = 1.33497565E-07 } },
        { position = { x = -6.657264, y = 0.592247, z = 5.64814663 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.65677071, y = 0.592244267, z = 5.64806938 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.65692663, y = 0.5922425, z = -5.64822674 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 6.657328, y = 0.5922425, z = -5.64822674 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Kermit&Fozzie"] = {
      GUID = [[9bf096]],
      label = [[Kermit &
Fozzie]],
      tooltip = 'Fan design by Moriatti!',
      variants = 4,
      currentVariant = 1,
      variantList = {
          { image = [[https://steamusercontent-a.akamaihd.net/ugc/1695002478213082555/755F662FBA22395841A2D3B0215F859259299175/]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gv43sif.jpg]] },
          { image = [[https://steamusercontent-a.akamaihd.net/ugc/1695002478213083510/05CD639AF9D9901005468A9E2E040495909C9599/]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/U6bh2Bg.jpg]] },
          { image = [[https://steamusercontent-a.akamaihd.net/ugc/1695002478213074327/567AD418666DBEF38B601A35CFF3954D49F5B99A/]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/T5zOCPT.jpg]] },
          { image = [[https://steamusercontent-a.akamaihd.net/ugc/1695002478213081462/77755069E3F7B8C5C2E76D62D8448F8CD0D5EE14/]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9bsMv60.jpg]] },
      },
      altimage = [[https://steamusercontent-a.akamaihd.net/ugc/1695002478213084584/94D084D9072FD3977D29FBE3B867366038F69225/]],
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      miniboardScript = [===[function onObjectDrop(color, obj)
        local playmatStation = getObjectFromGUID("]===]..self.getGUID()..[===[")
        if obj.tag == 'Card' and nearMe(obj) then
          if obj.getName() == "Wrath of the Raging Demon (U)" then
            playmatStation.Call('playmatAddVariant', {
              matName = 'Kermit&Fozzie',
              image = [[https://steamusercontent-a.akamaihd.net/ugc/1695002478213084584/94D084D9072FD3977D29FBE3B867366038F69225/]],
              sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DJAPdkk.jpg]]
            })
          end
        end
      end

      function nearMe(obj)
          if obj.getGUID() != self.getGUID() then
            return withinArea(self, obj)
          end
          return
      end

      function withinArea(area, obj)
          local ap = area.getPosition()
          local as = area.getScale()
          local op = obj.getPosition()
          return op[1] > ap[1] - as[1]*8 and op[1] < ap[1] + as[1]*8 and op[3] > ap[3] - as[3]*8 and op[3] < ap[3] + as[3]*8
      end
]===],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["AkamegaKill"] = {
  		GUID = [[491740]],
  		label = [[Akame ga
Kill]],
  		tooltip = 'Fan design by zain!',
  		variants = 1,
  		currentVariant = 1,
  		variantList = {
  		    { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WfTZG2p.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hBx280K.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		--miniboardPosition = {-30.5, 1.37, -19},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
  		lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
  		matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.81144252E-08, y = 0.5922387, z = 1.530511E-07 } },
        { position = { x = -7.16702461, y = 0.592238665, z = -9.834694E-05 } },
        { position = { x = -5.3629303, y = 0.5922387, z = -8.177834E-06 } },
        { position = { x = -3.58077049, y = 0.592241168, z = -4.91331448E-05 } },
        { position = { x = -1.78215992, y = 0.5922441, z = -2.44528146E-05 } },
        { position = { x = 1.76382577, y = 0.5922392, z = 2.315015E-06 } },
        { position = { x = 3.558836, y = 0.5922429, z = 4.88490878E-05 } },
        { position = { x = 5.34648, y = 0.5922417, z = 7.337064E-05 } },
        { position = { x = 7.14693451, y = 0.592242539, z = 9.807879E-05 } },
        { position = { x = 4.798123, y = 0.592234552, z = -5.92592573 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 7.1286397, y = 0.592237353, z = -5.92592573 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.798123, y = 0.592242956, z = 5.92592573 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -7.1286397, y = 0.592242956, z = 5.92592573 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Nine&Noel"] = {
  		GUID = [[7301ba]],
  		label = [[Nine &
Noel]],
  		tooltip = 'Fan design by zain!',
  		variants = 1,
  		currentVariant = 1,
  		variantList = {
  		    { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/W3uVdig.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nhuXcJY.jpg]] },
  		},
  		fullboardSize = {1.08, 0.17, 1.08},
  		fullboardPosition = {0, 0.95, 0},
  		miniboardSize = {0.2, 0.1, 0.2},
  		--miniboardPosition = {-30.5, 1.37, -19},
  		miniboardRotation = {0, 0, 0},
  		lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
  		lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
  		matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -7.154086, y = 0.592245042, z = 0 } },
        { position = { x = -5.365565, y = 0.592245042, z = 0 } },
        { position = { x = -3.577043, y = 0.592245042, z = 0 } },
        { position = { x = -1.78852153, y = 0.592245042, z = 0 } },
        { position = { x = 0, y = 0.592245042, z = 0 } },
        { position = { x = 1.78852153, y = 0.592245042, z = 0 } },
        { position = { x = 3.577043, y = 0.592245042, z = 0 } },
        { position = { x = 5.365565, y = 0.592245042, z = 0 } },
        { position = { x = 7.154086, y = 0.592245042, z = 0 } },
        { position = { x = -7.236998, y = 0.592247, z = 6 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.962851, y = 0.592244267, z = 6 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.962851, y = 0.5922419, z = -6 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 7.236998, y = 0.592244267, z = -6 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Mettaton&Undyne"] = {
      GUID = [[091105]],
      label = [[Mettaton
& Undyne]],
      tooltip = 'Fan design by Moriatti!',
      variants = 4,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6FrdW3E.png]], sample = [[https://i.imgur.com/6FrdW3E.png]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/eCPOXMo.png]], sample = [[https://i.imgur.com/eCPOXMo.png]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kCy3jQT.png]], sample = [[https://i.imgur.com/kCy3jQT.png]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hs5b6if.png]], sample = [[https://i.imgur.com/hs5b6if.png]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["HighGround"] = {
      GUID = [[ff092f]],
      label = [[High
Ground]],
      tooltip = 'Fan design by Moriatti!',
      variants = 4,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1x4YGHi.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QNoXRIU.png]] },
        { image = [[https://i.imgur.com/QNoXRIU.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yAnZZmB.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SiIQMKI.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MbPNsZv.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/O6cE1up.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AKdaI2k.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["Zangief&Guile"] = {
      GUID = [[d50c7f]],
      label = [[Zangief
& Guile]],
      tooltip = 'Fan design by Moriatti!',
      variants = 5,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4T52VNC.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lUxh3hv.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EFmgVDZ.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/P46jJYU.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aF23yV0.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PXiD1Sg.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ge3GykD.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zy1Thbd.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IXq6wnw.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kjrF0yy.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["Ryu&Ken"] = {
      GUID = [[e7d837]],
      label = [[Ryu
& Ken]],
      tooltip = 'Fan design by Moriatti!',
      variants = 5,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wktBEjC.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xK5rlbX.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bBCtgUQ.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iuxcTZX.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VHXeRPy.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/u5mkvge.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/S6PAb99.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Eq5v62o.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/94kBr7O.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RSLFKPz.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["Chie&Kanji"] = {
      GUID = [[b6fd8a]],
      label = [[Chie &
Kanji]],
      tooltip = 'Fan design by Moriatti!',
      variants = 4,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ASqKJLG.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/81omMEe.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/B8rKA35.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/18h95dV.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CC112UA.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/C6ZC7V6.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hng6B4K.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8TRNonb.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["Bascule"] = {
      GUID = [[b6e2b1]],
      label = [[Bascule]],
      tooltip = 'Fan design by Moriatti!',
      variants = 4,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9jaMMJq.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DxNU5os.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nVIaYbC.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DFhDtnX.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pCsrJ03.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/whGfNiJ.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/T5f08j0.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PSRxRCG.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["JungysJapes"] = {
      GUID = [[05c52d]],
      label = [[Jungy's
Japes]],
      tooltip = [[Fan design by Moriatti, commemorating the Jungy's Japes event!]],
      variants = 4,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DuqQ1W5.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iXGV3t2.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DDckRfZ.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZHxZDT2.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xfgvS18.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IXsz7fp.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VU3bwdC.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/BIHv8wD.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["ShovelKnight"] = {
      GUID = [[082027]],
      label = [[Shovel
Knight]],
      tooltip = 'Official S4 playmat!',
      variants = 1,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fRY5PvD.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mHHHl7F.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = 7.130721, y = 0.592245042, z = 0 } },
        { position = { x = 5.34804058, y = 0.592245042, z = 0 } },
        { position = { x = 3.56536055, y = 0.592245042, z = 0 } },
        { position = { x = 1.78380251, y = 0.592245042, z = 0 } },
        { position = { x = 0, y = 0.592245042, z = 0 } },
        { position = { x = -1.78380251, y = 0.592245042, z = 0 } },
        { position = { x = -3.56536055, y = 0.592245042, z = 0 } },
        { position = { x = -5.34804058, y = 0.592245042, z = 0 } },
        { position = { x = -7.130721, y = 0.592245042, z = 0 } },
        { position = { x = -6.967852, y = 0.592247, z = 6.16299963 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 7.068872, y = 0.5922401, z = -6.08224726 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.93036938, y = 0.5922425, z = 6.16053534 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.936446, y = 0.592244267, z = -6.16210556 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["FireEmblemHeroes"] = {
      GUID = [[9f9818]],
      label = [[Fire Emblem
Heroes]],
      tooltip = 'Fan design by supersid!',
      variants = 4,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/b0V2jff.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ivtlvkl.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/11RTAOG.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/83z6CVQ.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xl7lY73.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wopoFQc.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bqpIRdx.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KyzbH4E.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["Cytus2"] = {
      GUID = [[4a1e4c]],
      label = [[Cytus 2]],
      tooltip = 'Fan design by IcePopAddict!',
      variants = 4,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bcSxc2J.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/g3Tmhzh.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8inwoaX.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/w8ixhJb.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Mj1UWPh.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NGEHdtl.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IO0fqvv.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TgqgzQ4.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["GenCon2018"] = {
      GUID = [[55c315]],
      label = [[Gen Con
2018]],
      tooltip = 'Promotional S2 playmat!',
      variants = 1,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/piutd9V.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0myT4u3.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = -13.65, y = 1.1, z = 5},
      lifePositionRight = { x = -13.65, y = 1.1, z = 5},
      matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = 6.992, y = 0.592245042, z = 0 } },
        { position = { x = 5.244, y = 0.592245042, z = 0 } },
        { position = { x = 3.496, y = 0.592245042, z = 0 } },
        { position = { x = 1.748, y = 0.592245042, z = 0 } },
        { position = { x = 0, y = 0.592245042, z = 0 } },
        { position = { x = -1.748, y = 0.592245042, z = 0 } },
        { position = { x = -3.496, y = 0.592245042, z = 0 } },
        { position = { x = -5.244, y = 0.592245042, z = 0 } },
        { position = { x = -6.992, y = 0.592245042, z = 0 } },
        { position = { x = -5.589569, y = 0.592247, z = 5.7407403 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 5.589569, y = 0.5922401, z = -5.7407403 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -3.73733974, y = 0.5922425, z = 5.7407403 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 3.73733974, y = 0.592244267, z = -5.7407403 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["UnderNight"] = {
      GUID = [[3e1fee]],
      label = [[Under
Night]],
      tooltip = 'Official S6 playmat!',
      variants = 1,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2UHR0iJ.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bOhs1Mc.jpg]] },
      },
      fullboardSize = {1.06, 0.17, 1.06},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 12.2, y = 1.15, z = 3.165},
      lifePositionRight = { x = 12.2, y = 1.15, z = 3.165},
      matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = 6.702536, y = 0.592245042, z = 0 } },
        { position = { x = 5.02831125, y = 0.592245042, z = 0 } },
        { position = { x = 3.35972357, y = 0.592245042, z = 0 } },
        { position = { x = 1.68549883, y = 0.592245042, z = 0 } },
        { position = { x = 0, y = 0.592245042, z = 0 } },
        { position = { x = -1.6629504, y = 0.592245042, z = 0 } },
        { position = { x = -3.33153772, y = 0.592245042, z = 0 } },
        { position = { x = -5.00012541, y = 0.592245042, z = 0 } },
        { position = { x = -6.67998743, y = 0.592245042, z = 0 } },
        { position = { x = -7.30007029, y = 0.5922419, z = 5.324074 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 7.30007029, y = 0.5922419, z = -5.324074 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -5.496192, y = 0.5922419, z = 5.324074 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 5.496192, y = 0.5922419, z = -5.324074 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["DreamMatch"] = {
      GUID = [[e83c80]],
      label = [[Dream
Match]],
      tooltip = [[Fan design by Moriatti, commemorating the Dream Match event!]],
      variants = 4,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pEyN9wT.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lah2kXI.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bWmYhwK.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RUKCqsX.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/k8jvzqO.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PnmtRwU.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gg7ELRn.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wGUfJy6.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["energytrixxx"] = {
      GUID = [[28ff75]],
      label = [[energy trixxx]],
      tooltip = 'Fan design by IcePopAddict!',
      variants = 1,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pMemVuz.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zYtyNTS.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["255"] = {
      GUID = [[0eeb27]],
      label = [[255]],
      tooltip = 'Fan design by Moriatti!',
      variants = 3,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kG7cNjp.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xAOsiiQ.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hR6FL1J.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9Hap2yy.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dk04VkC.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/V6whlZT.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["Credits"] = {
      GUID = [[6d6529]],
      label = [[Credits]],
      tooltip = [[Fan design by IcePopAddict!

Funding for this program was made possible by The Corporation for Public Broadcasting and by annual financial support from Viewers Like You!]],
      variants = 4,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RYzdN5X.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qYMEws5.jpg]] }, -- new (no life)
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gnUUyMV.jpg]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UifRQlA.jpg]] }, -- new (life)
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wInEhms.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7vntTWa.jpg]] }, -- old (no life)
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EyZ5foJ.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ShkdImf.jpg]] }, -- old (life)
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["MuseDash"] = {
      GUID = [[78aa6d]],
      label = [[Muse Dash]],
      tooltip = [[Fan design by IcePopAddict!]],
      variants = 1,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bfVMh79.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Svn7zAp.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["MatchupMadness"] = {
      GUID = [[140a1a]],
      label = [[Matchup
Madness]],
      tooltip = [[Fan design by Andarel edited by Moriatti, commemorating the Matchup Madness event!]],
      variants = 2,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vlN4Pg2.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DDOEQnF.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aWT6p0L.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/G235Qlk.jpg]] }
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["BloodGulch"] = {
      GUID = [[d83f18]],
      label = [[Blood
Gulch]],
      tooltip = [[Fan design by Moriatti!]],
      variants = 5,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cVjYOTk.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QdgH8qs.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9WvV8oM.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wmiWrFB.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PwsC3q0.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/j5c08NK.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QGNVYFN.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8jTzGKP.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Q6StlyT.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nBP61qP.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["MarcosBizarrePlaymat"] = {
      GUID = [[df254b]],
      label = [[Marco's Bizarre
Playmat]],
      tooltip = [[Fan design by TheMechanicritic!]],
      variants = 1,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9evuj2f.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OW9BFJ3.jpg]] },
      },
      fullboardSize = {1.05, 0.17, 1.05},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 3.90, y = 1.1, z = 7.07},
      lifePositionRight = { x = 3.90, y = 1.1, z = 7.07},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -3.01041675, y = 0.592245042, z = -3.26851845 },
          rotation = { 0, 150, 0 },
          rotation_snap = true },
        { position = { x = 3.08333325, y = 0.592245042, z = 3.34259248 },
          rotation = { x = 0.0, y = 330.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.6059494, y = 0.592245042, z = 4.992348 },
          rotation = { x = 0.0, y = 60.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 6.12555, y = 0.592245042, z = 6.644039 },
          rotation = { x = 0.0, y = 60.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.536458, y = 0.592245042, z = -4.918448 },
          rotation = { x = 0.0, y = 240.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -6.0668993, y = 0.592245042, z = -6.512086 },
          rotation = { x = 0.0, y = 240.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -1.486531, y = 0.592245042, z = -1.61655438 },
          rotation = { x = 0.0, y = 240.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 1.56187546, y = 0.592245042, z = 1.69035947 },
          rotation = { x = 0.0, y = 60.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 0.03585921, y = 0.592245042, z = 0.03817575 }, },
        { position = { x = -7.35416651, y = 0.5922419, z = 5.99999952 },
          rotation = { x = 0.0, y = 0.0, z = 0.0 },
          rotation_snap = true },
        { position = { x = -5.52604151, y = 0.5922419, z = 5.99999952 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 5.52604437, y = 0.5922419, z = -6.00148535 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 7.35416651, y = 0.5922419, z = -5.99999952 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true }
      } -- end snapPoints
    }

    playmatsTable["Zeromat"] = {
      GUID = [[7fc6bd]],
      label = [[Zeromat]],
      tooltip = [[Fan design by tirankin!]],
      variants = 2,
      currentVariant = 2,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/urBhe8a.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jkmKR4c.jpg]] },
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PVwOvu4.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/07PvdQs.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["7GrandDad"] = {
      GUID = [[9ffca6]],
      label = [[7 Grand
Dad]],
      tooltip = [[Fan design by Moriatti!]],
      variants = 1,
      currentVariant = 1,
      variantList = {
        { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/R3Eg5VP.png]], sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/e50HbBK.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      --miniboardPosition = {-30.5, 1.37, -19},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.0632, y = 1.25, z = 3},
      lifePositionRight = { x = 13.0632, y = 1.25, z = 3},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["EMOMOMO"] = {
      GUID = [[158699]],
      label = [[EMOMOMO]],
      tooltip = [[Fan design by IcePopAddict!

Powered by Twemoji]],
      variants = 6,
      currentVariant = 1,
      variantList = {
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Gtjy0AV.jpg]], -- Dark Mode
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/22qpemr.jpg]] },
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4BOxNqY.jpg]], -- Light Mode
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iA5IYTl.jpg]] },
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cPByDov.jpg]], -- Thinking
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GcePjtA.jpg]] },
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Sjkn32R.jpg]], -- Dark Mode Alt
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bAwlprW.jpg]] },
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9SMxdkb.jpg]], -- Light Mode Alt
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gXRO5UB.jpg]] },
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9aOo0c0.jpg]], -- Thinking Alt
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KYaI1Lm.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 15.23, y = 1.25, z = 3.1},
      lifePositionRight = { x = 15.23, y = 1.25, z = 3.1},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["Options"] = {
      GUID = [[2b25a3]],
      label = [[Options]],
      tooltip = [[Fan design by IcePopAddict!

Information alone is not enough. We also need the meaning of that information.]],
      variants = 4,
      currentVariant = 1,
      variantList = {
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7fGJW0P.jpg]],
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/R5ycBWU.jpg]] },
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/83vwlnj.jpg]],
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/L13oRC7.jpg]] },
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3E95VNs.jpg]],
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6ZCPCA9.jpg]] },
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vqyofdV.jpg]],
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Q1Nktk2.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 15.23, y = 1.25, z = 3.1},
      lifePositionRight = { x = 15.23, y = 1.25, z = 3.1},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = standardSnapPoints
    }

    playmatsTable["MortalKombat"] = {
      GUID = [[59ae01]],
      label = [[Mortal
Kombat]],
      tooltip = [[Fan design by haytada!]],
      variants = 2,
      currentVariant = 1,
      variantList = {
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ffasxWA.jpg]],
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7sBsXGG.jpg]] },
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DDD3Ulf.jpg]],
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dAjqGFm.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 15.23, y = 1.25, z = 3.1},
      lifePositionRight = { x = 15.23, y = 1.25, z = 3.1},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = 0, y = 0.5922387, z = 0 } },
        { position = { x = -4.654524, y = 0.592248, z = 5.643518 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -6.66235828, y = 0.5922479, z = 5.643518 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 6.66235828, y = 0.5922378, z = -5.643518 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.654524, y = 0.5922347, z = -5.643518 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -7.02604771, y = 0.592245042, z = 0 } },
        { position = { x = -5.26512432, y = 0.592237353, z = 0 } },
        { position = { x = -3.508709, y = 0.592245042, z = 0 } },
        { position = { x = -1.74395478, y = 0.592245042, z = 0 } },
        { position = { x = 1.74395478, y = 0.592245042, z = 0 } },
        { position = { x = 3.508709, y = 0.592245042, z = 0 } },
        { position = { x = 5.26512432, y = 0.592245042, z = 0 } },
        { position = { x = 7.02604771, y = 0.592245042, z = 0 } }
      } -- end snapPoints
    }

    playmatsTable["WindowsXP"] = {
      GUID = [[8afa64]],
      label = [[Windows XP]],
      tooltip = [[Fan design by Zenon Revolution!]],
      variants = 1,
      currentVariant = 1,
      variantList = {
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xB4vSZh.jpg]],
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XR62JYg.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 13.07, y = 1.55, z = 3.365},
      lifePositionRight = { x = 13.07, y = 1.55, z = 3.365},
      matStyle = [[half]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = -0.00999847148, y = 0.5922387, z = 0.0184 } },
        { position = { x = -6.646066, y = 0.592248, z = 5.66445351 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -4.661344, y = 0.5922479, z = 5.66445351 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.661344, y = 0.5922378, z = -5.66445351 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 6.646066, y = 0.5922347, z = -5.66445351 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -7.054401, y = 0.592245042, z = 0.0184 } },
        { position = { x = -5.304647, y = 0.592237353, z = 0.0184 } },
        { position = { x = -3.56489086, y = 0.592245042, z = 0.0184 } },
        { position = { x = -1.77963352, y = 0.592245042, z = 0.0184 } },
        { position = { x = 1.747648, y = 0.592245042, z = 0.0184 } },
        { position = { x = 3.56489086, y = 0.592245042, z = 0.0184 } },
        { position = { x = 5.304647, y = 0.592245042, z = 0.0184 } },
        { position = { x = 7.054401, y = 0.592245042, z = 0.0184 } }
      } -- end snapPoints
    }

    playmatsTable["TheMandalorian"] = {
      GUID = [[c5a69c]],
      label = [[The Mandalorian]],
      tooltip = [[Fan design by haytada!]],
      variants = 2,
      currentVariant = 1,
      variantList = {
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tTCVlEp.jpg]],
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/70XaxIY.jpg]] },
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/M4yfHZY.jpg]],
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LoHC0cu.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 15.23, y = 1.25, z = 3.1},
      lifePositionRight = { x = 15.23, y = 1.25, z = 3.1},
      matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = 0, y = 0.5922387, z = 0 } },
        { position = { x = -4.654524, y = 0.592248, z = 5.643518 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -6.66235828, y = 0.5922479, z = 5.643518 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 6.66235828, y = 0.5922378, z = -5.643518 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.654524, y = 0.5922347, z = -5.643518 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -7.02604771, y = 0.592245042, z = 0 } },
        { position = { x = -5.26512432, y = 0.592237353, z = 0 } },
        { position = { x = -3.508709, y = 0.592245042, z = 0 } },
        { position = { x = -1.74395478, y = 0.592245042, z = 0 } },
        { position = { x = 1.74395478, y = 0.592245042, z = 0 } },
        { position = { x = 3.508709, y = 0.592245042, z = 0 } },
        { position = { x = 5.26512432, y = 0.592245042, z = 0 } },
        { position = { x = 7.02604771, y = 0.592245042, z = 0 } }
      } -- end snapPoints
    }

    playmatsTable["GGST"] = {
      GUID = [[011774]],
      label = [[Guilty Gear -Strive-]],
      tooltip = [[Official S7 playmat!]],
      variants = 1,
      currentVariant = 1,
      variantList = {
           { image = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KpJOQ0w.jpg]],
             sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XzNttu4.jpg]] },
      },
      fullboardSize = {1.08, 0.17, 1.08},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.2, 0.1, 0.2},
      miniboardRotation = {0, 0, 0},
      lifePositionLeft = { x = 15.3, y = 1.15, z = 4.08},
      lifePositionRight = { x = 15.3, y = 1.15, z = 4.08},
      matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = 0, y = 0.592245042, z = 0 } },
        { position = { x = -4.858765, y = 0.592248, z = 6.5 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -7.31842041, y = 0.5922479, z = 6.5 },
          rotation = { x = 0.0, y = 0.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 4.858765, y = 0.5922378, z = -6.5 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = 7.31842041, y = 0.5922347, z = -6.5 },
          rotation = { x = 0.0, y = 180.0, z = 180.0 },
          rotation_snap = true },
        { position = { x = -7.28576231, y = 0.592245042, z = 0 } },
        { position = { x = -5.46527624, y = 0.592237353, z = 0 } },
        { position = { x = -3.64912724, y = 0.592245042, z = 0 } },
        { position = { x = -1.83217108, y = 0.592245042, z = 0 } },
        { position = { x = 1.83217108, y = 0.592245042, z = 0 } },
        { position = { x = 3.64912724, y = 0.592245042, z = 0 } },
        { position = { x = 5.46527624, y = 0.592245042, z = 0 } },
        { position = { x = 7.28576231, y = 0.592245042, z = 0 } }
      } -- end snapPoints
    }

    playmatsTable["Minimalist"] = {
      GUID = [[e38220]],
      label = 'Minimalist',
      tooltip = 'Fan design by attackofmilk!',
      variants = 1,
      currentVariant = 1,
      variantList = {
           { image = [[https://steamusercontent-a.akamaihd.net/ugc/792000083429133342/AC4E64058C1CF8E45A5A2DB05CF04EEAB7524B52/]],
              sample = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Jvop3Nv.jpg]] },
      },
      fullboardSize = {0.90, 0.17, 0.90},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.09, 0.1, 0.1},
      miniboardRotation = {0, 180, 0},
      lifePositionLeft = { x = 13.5, y = 1.25, z = 3},
      lifePositionRight = { x = 13.5, y = 1.25, z = 3},
      matStyle = [[full]],
      altMatScript = [[function onLoad()
          self.attachInvisibleHider(self.getGUID(), true, {
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
          Global.call("addHidden", { GUID = self.getGUID()})
        end]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {
        { position = { x = 6.416687, y = 0.592252731, z = 9.746602E-07 } },
        { position = { x = 4.81251526, y = 0.5922532, z = 5.70366751E-07 } },
        { position = { x = 3.20139933, y = 0.5922532, z = 5.00195E-07 } },
        { position = { x = 1.60069966, y = 0.5922532, z = 2.51950127E-07 } },
        { position = { x = -9.373258E-08, y = 0.592252731, z = 1.50346409E-07 } },
        { position = { x = -1.60417175, y = 0.5922532, z = -1.52037927E-07 } },
        { position = { x = -4.81251526, y = 0.5922532, z = -6.73108332E-07 } },
        { position = { x = -3.20834351, y = 0.5922532, z = -3.88499416E-07 } },
        { position = { x = -6.416687, y = 0.5922532, z = -1.06537982E-06 } }
      } -- end snapPoints
    }

    playmatsTable["shewholurks"] = {
      skip = true,
      --GUID = [[e38220]],
      label = 'She Who Lurks',
      --tooltip = 'Fan design by attackofmilk!',
      variants = 1,
      currentVariant = 1,
      variantList = {
           { image = [[https://i.imgur.com/1n2yI1l.png]], },
      },
      fullboardSize = {0.90, 0.17, 0.90},
      fullboardPosition = {0, 0.95, 0},
      miniboardSize = {0.09, 0.1, 0.1},
      miniboardRotation = {0, 180, 0},
      lifePositionLeft = { x = 13.5, y = 1.25, z = 3},
      lifePositionRight = { x = 13.5, y = 1.25, z = 3},
      matStyle = [[full]],
      halfButtonVisibility = {
        Black = [[Black]],
      },
      snapPoints = {} -- end snapPoints
    }

-- shewholurks
  -----------------------------------------------------

  currentPlaymats = {
    Center = { -- i.e., Red & Blue
      --fullMat = getObjectFromGUID([[e5b644]]),
      fullMatGUID = [[e5b644]],
      currentStyle = [[full]],
      currentMat = [[GGST]],
      currentVariant = 1,
      offsetX = 0,
      offsetZ = 0,
    },
    Starboard = { -- i.e., Yellow & Green
      --fullMat = getObjectFromGUID([[366bb5]]),
      fullMatGUID = [[366bb5]],
      currentStyle = [[half]],
      currentMat = [[UnderNight]],
      currentVariant = 1,
      offsetX = 70,
      offsetZ = 0,
    },
    Larboard = { -- i.e., Orange & Purple
      --fullMat = getObjectFromGUID([[14b85c]]),
      fullMatGUID = [[14b85c]],
      currentStyle = [[half]],
      currentMat = [[StreetFighter]],
      currentVariant = 1,
      offsetX = -70,
      offsetZ = 0,
    },
    Aft = { -- i.e., White & Teal
      --fullMat = getObjectFromGUID([[44efa8]]),
      fullMatGUID = [[44efa8]],
      currentStyle = [[half]],
      currentMat = [[SeventhCross]],
      currentVariant = 1,
      offsetX = 0,
      offsetZ = -70,
    },
    Fore = { -- i.e., Pink & Brown
      --fullMat = getObjectFromGUID([[51bc49]]),
      fullMatGUID = [[51bc49]],
      currentStyle = [[full]],
      currentMat = [[SkullGirls]],
      currentVariant = 1,
      offsetX = 0,
      offsetZ = 70,
    }
  }

  if saveState != nil then
    for mat,matInfo in pairs(saveState.currentPlaymats) do
      debugLog{"currentPlaymats check: "..mat, 4}
      currentPlaymats[mat].currentMat = matInfo.currentMat
      currentPlaymats[mat].currentStyle = matInfo.currentStyle
      currentPlaymats[mat].currentVariant = matInfo.currentVariant
    end
  end

  -- Make the playmat buttons.
  for playmatName,playmatTable in pairs(playmatsTable) do
    if playmatTable.skip != true then
      debugLog{" playmat loop: "..playmatName, 4}
      for playerName,playerTable in pairs(playerPairs) do
        -- By default, all of them are visible to Black, but not to other players.
        playmatTable.halfButtonVisibility[playerName] = [[Black]]
      end
      local thisMiniboard = getObjectFromGUID(playmatTable.GUID)
      local newName = string.gsub(playmatTable.label, [[

  ]], [[ ]])
      local newScript = playmatTable.miniboardScript or [[]]
      thisMiniboard.setName(newName)
      thisMiniboard.setDescription(playmatTable.tooltip)
      thisMiniboard.setLuaScript(newScript)

      createMiniboardButtons(playmatName)
    end
  end -- End of the loop that makes the playmat buttons.

  -- By default, full mats are in use across the board.
  -- Therefore, start with the half mats hidden and uninteractable.
  --local hiddenObjects = Global.getVar("hiddenObjects")
  --local uninteractableObjects = Global.getVar("uninteractableObjects")
  for playerName,playerTable in pairs(playerPairs) do
    local pairedPlayer = playerTable.opposingPlayer
    local playerPlaymat = getObjectFromGUID(playerTable.playmatGUID)
    if playerPlaymat != nil then

      local playmatTableEntry = playmatsTable[playerTable.currentMat]

      -- Update image if necessary.
      local selectedVariant = playmatTableEntry.variantList[playerTable.currentVariant]
      local image = selectedVariant.image
      local glitchMode = Global.getVar("glitchMode")
      if glitchMode == true then
        local matCount = 0
        for tempval in pairs(glitchMatList) do matCount = matCount + 1 end
        local randomMatIndex = math.random(1, matCount)
        image = glitchMatList[randomMatIndex]
        --debugLog{"mat glitch: "..newMatImage, 1, {0,1,0}}
      end
      if playerPlaymat.getCustomObject().image != image and glitchMode == false then
        playerPlaymat.setCustomObject({ image = image })
        playerPlaymat.reload()
      end

      -- Need to set uninteractable after reloading, not before.
      playerPlaymat.interactable = false
      Global.call("addUninteractable", { GUID = playerPlaymat.getGUID()})

      -- If the mat style is full, half mats are hidden and have no snap points.
      if currentPlaymats[playerTable.playmatPosition].currentStyle == [[full]] then
        playerPlaymat.setSnapPoints({})
        playerPlaymat.attachInvisibleHider(playerPlaymat.getGUID(), true, allPlayers)
        Global.call("addHidden", { GUID = playerPlaymat.getGUID()})
      else
        local snaps = playmatTableEntry.snapPoints
        playerPlaymat.setSnapPoints(snaps)
      end
    else
      playerStatusList[playerName] = false
      playerStatusCount = playerStatusCount-1
    end
  end

  -- Set playmats to uninteractable.
  for matPosition,matParams in pairs(currentPlaymats) do
    local thisPlaymat = getObjectFromGUID(matParams.fullMatGUID)
    if thisPlaymat != nil then

      local playmatTableEntry = playmatsTable[matParams.currentMat]

      -- Update image if necessary.
      local selectedVariant = playmatTableEntry.variantList[matParams.currentVariant]
      local image = selectedVariant.image
      if glitchMode == true then
        local matCount = 0
        for tempval in pairs(glitchMatList) do matCount = matCount + 1 end
        local randomMatIndex = math.random(1, matCount)
        image = glitchMatList[randomMatIndex]
        --debugLog{"mat glitch: "..newMatImage, 1, {0,1,0}}
      end
      if thisPlaymat.getCustomObject().image != image and glitchMode == false then
        thisPlaymat.setCustomObject({ image = image })
        thisPlaymat.reload()
      end

      -- If the mat style is half, full mats are hidden and have no snap points.
      if matParams.currentStyle == [[half]] then
        thisPlaymat.setSnapPoints({})
        thisPlaymat.attachInvisibleHider(thisPlaymat.getGUID(), true, allPlayers)
        Global.call("addHidden", { GUID = thisPlaymat.getGUID()})
      else
        local snaps = playmatTableEntry.snapPoints
        thisPlaymat.setSnapPoints(snaps)
      end

      thisPlaymat.interactable = false
      Global.call("addUninteractable", { GUID = matParams.fullMatGUID })
    end
  end
  self.setLock(true)
  self.interactable = false
  Global.call("addUninteractable", { GUID = self.getGUID() })
  --uninteractableObjects[self.getGUID()] = true

  if Global.getVar("debugFlag") == true then printToAll("Benchmarking, Playmat Station, reached the end of onLoad at: "..os.time()) end
end -- end onLoad



function onSave(script_state)
  local savedPlayerStatusList = {}

  for eachPlayer,status in pairs(playerStatusList) do
    savedPlayerStatusList[eachPlayer] = status
  end

  local savedPlayerPairs = {}

  for player,playerInfo in pairs(playerPairs) do
    --printToAll("saving playerInfo for "..player)
    --printToAll("*** currentMat: "..playerInfo.currentMat)
    --printToAll("*** currentVariant: "..playerInfo.currentVariant)
    savedPlayerPairs[player] = {}
    savedPlayerPairs[player].currentMat = playerInfo.currentMat
    savedPlayerPairs[player].currentVariant = playerInfo.currentVariant
  end

  local savedCurrentPlaymats = {}

  for mat,matInfo in pairs(currentPlaymats) do
    --printToAll("saving matInfo for "..mat)
    --printToAll("*** currentMat: "..matInfo.currentMat)
    --printToAll("*** currentStyle: "..matInfo.currentStyle)
    --printToAll("*** currentVariant: "..matInfo.currentVariant)
    savedCurrentPlaymats[mat] = {}
    savedCurrentPlaymats[mat].currentMat = matInfo.currentMat
    savedCurrentPlaymats[mat].currentStyle = matInfo.currentStyle
    savedCurrentPlaymats[mat].currentVariant = matInfo.currentVariant
  end

  local saveState = {
    playerStatusList = savedPlayerStatusList,
    playerPairs = savedPlayerPairs,
    currentPlaymats = savedCurrentPlaymats,
  }

  return JSON.encode(saveState)
end -- end onSave


--[===[
function checkMats(params)
  local location = params.location or [[Center]]
  local fullMat = currentPlaymats[location].fullMat
  local returnData = {
    fullMatGUID = fullMat.getGUID(),
    fullMatHidden = false,
    nearMatGUID = [[]],
    nearMatHidden = true,
    farMatGUID = [[]],
    farMatHidden = true
  }
  for playerName,playerTable in pairs(playerPairs) do
    if playerTable.playmatPosition ==
  end
  end
  if currentPlaymats[location].currentStyle == [[full]] then
    returnData.fullMatHidden = false
    returnData.nearMatHidden = true
    returnData.farMatHidden = true
  elseif currentPlaymats[location].currentStyle == [[half]] then
    returnData.fullMatHidden = true
    returnData.nearMatHidden = false
    returnData.farMatHidden = false
  end
  return returnData
end -- end checkMats
--]===]


function createMiniboardButtons(playmatName)
  local matParams = playmatsTable[playmatName]
  debugLog{" createMiniboardButtons, GUID: "..matParams.GUID, 4}
  local objMiniboard = getObjectFromGUID(matParams.GUID)

  -- Main playmat button.
  local myUIXMLTable = {}
  table.insert(myUIXMLTable, {-- Button element.
    tag = "Button",
    attributes = {
      id = playmatName,
      height = 325,
      width = 1665,
      position = [[-670 0 -60]],
      rotation = "0 0 90",
      color = "rgba(1,1,1,0.5)",
      raycastTarget = "true",
      onClick = self.getGUID().."/uiClick_Playmat",
      visibility = "Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Brown|Pink|Black",
    }, -- end attributes for Button
  })
  debugLog{ " main playmat button id: "..playmatName, 5}
  table.insert(myUIXMLTable, {-- Text element.
    tag = "Text",
    attributes = {
      id = playmatName.."ButtonLabel",
      text = matParams.label,
      fontSize = 72,
      resizeTextForBestFit = true,
      height = 1000,
      width = 1000,
      scale = [[5.25 3 3]],
      position = [[-670 0 -65]],
      rotation = "0 0 90",
      --color = "rgba(1,1,1,1)",
      visibility = "Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Brown|Pink|Black",
    }, -- end attributes for Text
  })

  -- Half mat button.
  if matParams.matStyle == [[half]] then

    local halfButtonHeight = 266
    local halfButtonWidth = 680
    local halfButtonHorizontalOffset = 490
    local halfButtonColor = [[rgba(1, 1, 1, 0.3)]]
    local halfTextColor = [[rgba(0, 0, 0, 1)]]

    local halfButtonLeftPosition = [[700 -]]..halfButtonHorizontalOffset..[[ -60]]
    local halfTextLeftPosition = [[690 -]]..halfButtonHorizontalOffset..[[ -65]]

    local halfButtonRightPosition = [[700 ]]..halfButtonHorizontalOffset..[[ -60]]
    local halfTextRightPosition = [[690 ]]..halfButtonHorizontalOffset..[[ -65]]

    -- Originally, I intended for each button to show up in the player's own color.
    -- I ended up deciding this wasn't of particular value.
    for colorIndex,playerTable in pairs(playerPairs)
    do

      debugLog{" adding miniboard buttons for "..colorIndex, 5, {0.9, 1, 0.9}}
      --debugLog{"   halfButtonVisibility: "..matParams.halfButtonVisibility[colorIndex]}

      if currentPlaymats[playerTable.playmatPosition].currentStyle == [[half]] then
        matParams.halfButtonVisibility[colorIndex] = colorIndex
      end

      table.insert(myUIXMLTable, { -- Button element.
        tag = "Button",
        attributes = {
          id = playmatName..[[LHalf]]..colorIndex,
          height = halfButtonHeight,
          width = halfButtonWidth,
          position = halfButtonLeftPosition,
          rotation = [[0 0 90]],
          color = halfButtonColor,
          raycastTarget = [[true]],
          onClick = self.getGUID()..[[/uiClick_Playmat]],
          visibility = matParams.halfButtonVisibility[colorIndex],
        },
      })
      debugLog{" button id: "..playmatName..[[LHalf]], 6}

      table.insert(myUIXMLTable, { -- Button element.
        tag = "Button",
        attributes = {
          id = playmatName..[[RHalf]]..colorIndex,
          height = halfButtonHeight,
          width = halfButtonWidth,
          position = halfButtonRightPosition,
          rotation = [[0 0 90]],
          color = halfButtonColor,
          raycastTarget = [[true]],
          onClick = self.getGUID()..[[/uiClick_Playmat]],
          visibility = matParams.halfButtonVisibility[colorIndex],
        },
      })
      --debugLog{" button id: "..playmatName..[[RHalf]]}

      table.insert(myUIXMLTable, { -- Text element.
        tag = "Text",
        attributes = {
          id = playmatName..[[LHalfLabel]]..colorIndex,
          text = playerTable.halfButtonText, -- [[←]], --←
          fontSize = 90,
          height = 100,
          width = 100,
          scale = [[5.25 3 3]],
          position = halfTextLeftPosition,
          rotation = [[0 0 90]],
          color = halfTextColor,
          visibility = matParams.halfButtonVisibility[colorIndex],
        },
      })
      --debugLog{" button id: "..playmatName..[[LHalfLabel]]}

      table.insert(myUIXMLTable, { -- Text element.
        tag = "Text",
        attributes = {
          id = playmatName..[[RHalfLabel]]..colorIndex,
          text = playerTable.halfButtonText, -- [[→]], --→
          fontSize = 90,
          height = 100,
          width = 100,
          scale = [[5.25 3 3]],
          position = halfTextRightPosition,
          rotation = [[0 0 90]],
          color = halfTextColor,
          visibility = matParams.halfButtonVisibility[colorIndex],
        },
      })
      --debugLog{" button id: "..playmatName..[[RHalfLabel]]}
    end
  end

  -- Variants button.
  if matParams.variants == nil then matParams.variants = 0 end
  if matParams.variants > 1 then
    table.insert(myUIXMLTable, {-- Button element.
      tag = "Button",
      attributes = {
        id = playmatName.."Variant",
        --text = matParams.label,
        --fontSize = 108,
        --resizeTextForBestFit = true,
        height = 200,
        width = 800,
        position = [[0 0 -60]],
        rotation = "0 0 90",
        color = "rgba(0,0,0,0.98)",
        raycastTarget = "true",
        onClick = self.getGUID().."/uiClick_PlaymatVariant",
        visibility = "Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown",
      }, -- end attributes for Button
    })
    table.insert(myUIXMLTable, {-- Text element.
      tag = "Text",
      attributes = {
        id = playmatName.."VariantLabel",
        text = matParams.currentVariant..' of '..matParams.variants,
        fontSize = 96,
        color = "rgba(1,1,1,1)",
        --resizeTextForBestFit = true,
        height = 500,
        width = 500,
        scale = [[1.75 1 1]],
        position = [[0 0 -65]],
        rotation = "0 0 90",
        visibility = "Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown",
      }, -- end attributes for Text
    })
  end

  debugLog{" attempting to set UI Xml at run-time", 4}
  objMiniboard.setLuaScript(matParams.miniboardScript)
  objMiniboard = objMiniboard.reload()
  objMiniboard.UI.setXmlTable(myUIXMLTable)
end -- end createMiniboardButtons



function onChat(message, player)
  -- debug
  if message == '!cursed' then
    printToAll("Yup, it's cursed all right.")
    for mat, v in pairs(playmatsTable) do
      playmatAddVariant({
        matName = mat,
        image = [[https://steamusercontent-a.akamaihd.net/ugc/1695002478213084584/94D084D9072FD3977D29FBE3B867366038F69225/]]
      })
    end
  end
end



--[=[
function printTable(thisTable, indentation)
  local indent = indentation or [[]]
  indent = indent.."   "
  local printString = [[]]

  if type(thisTable) == [[table]] then
    debugLog{" printTable: table check passed", 5, {1,1,1} }
    for key,val in pairs(thisTable) do
      printString = printString..indent..[[key: ]]..key..[[

]]
      debugLog{indent.."key: "..key, 2}
      printString = printString..printTable(val, indent)
    end
  elseif type(thisTable) == [[boolean]] then
    if thisTable then
      printString = printString..indent..[[value: true]]..[[

]]
      debugLog{indent.."value: true", 4, {0,1,0}}
    else
      printString = printString..indent..[[value: false]]..[[

]]
      debugLog{indent.."value: false", 4, {1,1,0}}
    end
  else
    --local value = thisTable or "nil"
    printString = printString..indent..[[value: ]]..thisTable..[[

]]
    debugLog{indent.."value: "..thisTable, 4, {0,1,1}}
  end
  return printString
end -- end printTable
--]=]



function getCatDecal()
  local decalScale = {
    x = 1.073,
    y = 1.53375,
    z = 0.5, }
  --local decalSize = 120
  --decalReferenceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sj2idgS.png]]
  local decalCatURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/svnQhnG.png]]
  local decalCatPosition = {
    x = math.random(-20, 20),
    y = 0.5,
    z = math.random(-20, 20),
  }

  local decalTable = {}
  decalTable.position = {
    x = decalCatPosition.x,
    y = decalCatPosition.y,
    z = decalCatPosition.z,
  }
  decalTable.rotation = {
    x = math.random(-180, 180),
    y = math.random(-180, 180),
    z = math.random(-180, 180),
  }
  decalTable.scale = {
    x = decalScale.x,
    y = decalScale.y,
    z = decalScale.z,
  }
  decalTable.name = [[CatDecal]]
  decalTable.url = decalCatURL

  return decalTable
end -- end getCatDecal



function uiClick_Playmat(player, clickValue, buttonID, selectedVariant)

  local playerColor = player.color
  --local hiddenObjects = Global.getVar("hiddenObjects")
  --local uninteractableObjects = Global.getVar("uninteractableObjects")

  debugLog{ "uiClick_Playmat clicked by "..playerColor, 3 }
  debugLog{ "   clickValue: "..clickValue, 3 }
-- [=[
  if playerStatusList[playerColor] == false then
    player.broadcast([[Please sit at one of the ]]..playerStatusCount..[[ player colors before choosing a playmat.]])
    return
  end
--]=]

  local opposingColor = playerPairs[playerColor].opposingPlayer

  debugLog{ "  opposing color: "..opposingColor, 3 }

  if _G["activeSearch"..playerColor] != nil then
    return
  end

  -- Initial values for these are the defaults. They only change if a half-mat button was clicked.
  local newMatSide = [[full]]
  local newMatName = buttonID

  -- The default playmat rotation is based on the player setting.
  local newMatRotation = {
    x = playerPairs[playerColor].playmatRotationX,
    y = playerPairs[playerColor].playmatRotationY,
    z = playerPairs[playerColor].playmatRotationZ,
  }
  local inverseMatRotation = {
    x = (-1*playerPairs[playerColor].playmatRotationX),
    y = playerPairs[playerColor].playmatRotationY,
    z = (-1*playerPairs[playerColor].playmatRotationZ),
  }
  local fullMatRotation = {
    x = 0,
    y = playerPairs[playerColor].playmatRotationY,
    z = 0,
  }

  -- Determine whether the button that was clicked was one of the half-mat buttons.
  local buttonIDSuffix = string.sub(buttonID, string.len(buttonID)-(4+string.len(playerColor)))
  local buttonIDPrefix = string.sub(buttonID, 1, string.len(buttonID)-(5+string.len(playerColor)))

  debugLog{" buttonIDSuffix: "..buttonIDSuffix, 4, {1,1,0}}
  debugLog{" buttonIDPrefix: "..buttonIDPrefix, 4, {1,1,0}}

  -- If it was, update the appropriate variables.
  if buttonIDSuffix == [[LHalf]]..playerColor then
    --printToAll("LEFT half button", {0.2,0.2,1})
    newMatSide = [[Left]]
    newMatName = buttonIDPrefix
    --printToAll("   newMatName: "..newMatName, {0,1,1})
  elseif buttonIDSuffix == [[RHalf]]..playerColor then
    --printToAll("RIGHT half button", {1,0.2,0.2})
    newMatSide = [[Right]]
    newMatName = buttonIDPrefix
    newMatRotation.x = (-1*newMatRotation.x)
    newMatRotation.y = 180+newMatRotation.y
    newMatRotation.z = (-1*newMatRotation.z)
    inverseMatRotation.x = (-1*inverseMatRotation.x)
    inverseMatRotation.y = 180+inverseMatRotation.y
    inverseMatRotation.z = (-1*inverseMatRotation.z)
    --printToAll("   newMatName: "..newMatName, {0,1,1})
  end

  local newMatParams = playmatsTable[newMatName]
  local newMatStyle = newMatParams.matStyle

  debugLog{ "      newMatName: "..newMatName }
  debugLog{ "     newMatStyle: "..newMatStyle, 4 }
  debugLog{ "      newMatSide: "..newMatSide, 4 }
  debugLog{ "  newMatRotation: "..newMatRotation.x..", "..newMatRotation.y..", "..newMatRotation.z, 5, {0,1,0}}
  debugLog{ " inverseRotation: "..inverseMatRotation.x..", "..inverseMatRotation.y..", "..newMatRotation.z, 5, {0,1,0}}

  -- Either "Center", "Starboard", "Larboard", "Aft", or "Fore", depending on the player.
  local matPosition = playerPairs[playerColor].playmatPosition

  -- These are the objects corresponding to the three playmats that may be affected.
  local nearMat = getObjectFromGUID(playerPairs[playerColor].playmatGUID)
  local farMat = getObjectFromGUID(playerPairs[opposingColor].playmatGUID)
  local fullMat = getObjectFromGUID(currentPlaymats[matPosition].fullMatGUID)
  local oldMatStyle = currentPlaymats[matPosition].currentStyle

  -- Set variables appropriate to which mat is being changed.
  --local lifeOffsetX = currentPlaymats[matPosition].offsetX -- Used to calculate life tracker positions.
  --local lifeOffsetZ = currentPlaymats[matPosition].offsetZ -- Used to calculate life tracker positions.

  local nearLife = getObjectFromGUID(playerPairs[playerColor].lifeTrackerGUID)
  local farLife = getObjectFromGUID(playerPairs[opposingColor].lifeTrackerGUID)

-- [=[
  local newLifePositionBaseLeft = {
    x = newMatParams.lifePositionLeft.x,
    y = newMatParams.lifePositionLeft.y,
    z = newMatParams.lifePositionLeft.z,
  }
  local newLifePositionBaseRight = {
    x = newMatParams.lifePositionRight.x,
    y = newMatParams.lifePositionRight.y,
    z = newMatParams.lifePositionRight.z,
  }

  if playerPairs[playerColor].lifePositionSwap == true then
    newLifePositionBaseLeft.x = newMatParams.lifePositionLeft.z
    newLifePositionBaseLeft.z = newMatParams.lifePositionLeft.x
  end
  if playerPairs[opposingColor].lifePositionSwap == true then
    newLifePositionBaseRight.x = newMatParams.lifePositionRight.z
    newLifePositionBaseRight.z = newMatParams.lifePositionRight.x
  end

  local lifePositionFar = {
    x = (playerPairs[playerColor].lifePositionModifier.x*newLifePositionBaseLeft.x)+playerPairs[playerColor].lifePositionOffsetX,
    y = (playerPairs[playerColor].lifePositionModifier.y*newLifePositionBaseLeft.y),
    z = (playerPairs[playerColor].lifePositionModifier.z*newLifePositionBaseLeft.z)+playerPairs[playerColor].lifePositionOffsetZ,
  }

  local lifePositionNear = {
    x = (playerPairs[opposingColor].lifePositionModifier.x*newLifePositionBaseRight.x)+playerPairs[opposingColor].lifePositionOffsetX,
    y = (playerPairs[opposingColor].lifePositionModifier.y*newLifePositionBaseRight.y),
    z = (playerPairs[opposingColor].lifePositionModifier.z*newLifePositionBaseRight.z)+playerPairs[opposingColor].lifePositionOffsetZ,
  }
--]=]

  local variantParams = newMatParams.variantList[newMatParams.currentVariant]

  -- If a variant was passed to this function, set it instead of using the current variant.
  if selectedVariant != nil then
    variantParams = newMatParams.variantList[selectedVariant]
  end

  local newMatImage = variantParams.image
  local newMatScript = [[]]

  -- Add the playmat name to the password sequence for the clicking player.
  characterStation.Call([[passwordUpdate]], {
    playerReference = player,
    appendix = newMatName,
  })

  -- Prioritize variant-specific scripts over mat-wide scripts.
  if variantParams.matScript != nil then
    newMatScript = variantParams.matScript
  elseif newMatParams.matScript != nil then
    newMatScript = newMatParams.matScript
  end

  -- Handle non-primary clicks.
  local altClick = false
  if clickValue != [[-1]] then
    altClick = true
    --printToAll(" altClick On", {0,1,1})
    if variantParams.altimage != nil then
      newMatImage = variantParams.altimage
    elseif newMatParams.altimage != nil then
      newMatImage = newMatParams.altimage
    end
    if variantParams.altMatScript != nil then
      newMatScript = variantParams.altMatScript
    elseif newMatParams.altMatScript != nil then
      newMatScript = newMatParams.altMatScript
    end
    nearMat = getObjectFromGUID(playerPairs[opposingColor].playmatGUID)
    farMat = getObjectFromGUID(playerPairs[playerColor].playmatGUID)
    newMatRotation.y = 180+newMatRotation.y
    inverseMatRotation.y = 180+inverseMatRotation.y
    fullMatRotation.y = 180+fullMatRotation.y
  end

  debugLog{" newMatScript: "..newMatScript, 4}

  local glitchMode = Global.getVar("glitchMode")
  if glitchMode == true then
    Global.call("givePrizeToPlayer", {
      playerReference = player,
      multiplier = 93,
    })
    if newMatStyle == [[half]] then
      local matCount = 0
      for tempval in pairs(glitchMatList) do matCount = matCount + 1 end
      local randomMatIndex = math.random(1, matCount)
      newMatImage = glitchMatList[randomMatIndex]
      debugLog{"mat glitch: "..newMatImage, 1, {0,1,0}}
    end
  end

  -- New mat is full.
  if newMatStyle == [[full]] then
    fullMat.setCustomObject({ image = newMatImage })
    fullMat.setSnapPoints({})
    fullMat.setLuaScript(newMatScript)
    fullMat = fullMat.reload()
    if Global.getVar("debugFlag") != true then
      fullMat.interactable = false
      Global.call("addUninteractable", { GUID = fullMat.getGUID()})
    end
    debugLog{" setting full mat snap points", 2, {1,0,0}}
    fullMat.setSnapPoints(newMatParams.snapPoints)
    fullMat.setRotation(fullMatRotation)
    fullMat.setScale(newMatParams.fullboardSize)

    -- Reset life tracker positions.
    nearLife.setPosition(lifePositionNear)
    farLife.setPosition(lifePositionFar)

    -- New mat is full, old mat is half/half.
    if oldMatStyle != [[full]] then
      -- Hide BOTH the old half mats. Show the new full mat.
      --printToAll(" Showing full mat, hiding half mats")
      fullMat.attachInvisibleHider(fullMat.getGUID(), false, allPlayers)
      Global.call("removeHidden", { GUID = fullMat.getGUID()})
      --hiddenObjects[fullMat.getGUID()] = nil
      debugLog{" unsetting half mat snap points", 2, {1,1,0}}
      nearMat.setSnapPoints({})
      nearMat.attachInvisibleHider(nearMat.getGUID(), true, allPlayers)
      Global.call("addHidden", { GUID = nearMat.getGUID()})
      --hiddenObjects[nearMat.getGUID()] = true
      farMat.setSnapPoints({})
      farMat.attachInvisibleHider(farMat.getGUID(), true, allPlayers)
      Global.call("addHidden", { GUID = farMat.getGUID()})
      --hiddenObjects[farMat.getGUID()] = true

      -- Conceal the half mat buttons from this player.
      for playmatName,playmatTable in pairs(playmatsTable) do
        if playmatTable.skip != true then
          --printToAll(" hiding half mat buttons for "..playmatName, {0, 1, 0})
          playmatTable.halfButtonVisibility[playerColor] = string.gsub(playmatTable.halfButtonVisibility[playerColor], [[|]]..playerColor, [[]])
          playmatTable.halfButtonVisibility[opposingColor] = string.gsub(playmatTable.halfButtonVisibility[opposingColor], [[|]]..opposingColor, [[]])
          local miniboard = getObjectFromGUID(playmatTable.GUID)
          for i,thisUIID in ipairs({
            playmatName..[[RHalf]],
            playmatName..[[LHalf]],
            playmatName..[[RHalfLabel]],
            playmatName..[[LHalfLabel]],
          }) do
            miniboard.UI.setAttribute(thisUIID..playerColor, "visibility", playmatTable.halfButtonVisibility[playerColor])
            miniboard.UI.setAttribute(thisUIID..opposingColor, "visibility", playmatTable.halfButtonVisibility[opposingColor])
          end
        end -- end 'if playmatTable.skip != true'
      end -- finished concealing half mat buttons
    end -- end 'if oldMatStyle != full'

  -- New mat is half/half.
  elseif newMatStyle != [[full]] then

    -- Reset the player's life tracker.
    nearLife.setPosition(lifePositionNear)

    -- Resetting both halves.
    if newMatSide == [[full]] then
      -- Replace both sides with half mats.
      --printToAll("newMatSide: full", {1,1,0})
      nearMat.setCustomObject({ image = newMatImage })
      nearMat.setSnapPoints({})
      nearMat.setLuaScript(newMatScript)
      nearMat = nearMat.reload()
      if Global.getVar("debugFlag") != true then
        nearMat.interactable = false
        Global.call("addUninteractable", { GUID = nearMat.getGUID()})
      end
      debugLog{" setting half mat snap points", 2, {0,1,1}}
      nearMat.setSnapPoints(newMatParams.snapPoints)
      nearMat.setRotation(newMatRotation)

      farMat.setCustomObject({ image = newMatImage })
      farMat.setSnapPoints({})
      farMat.setLuaScript(newMatScript)
      farMat = farMat.reload()
      if Global.getVar("debugFlag") != true then
        farMat.interactable = false
        Global.call("addUninteractable", { GUID = farMat.getGUID()})
      end
      farMat.setSnapPoints(newMatParams.snapPoints)
      farMat.setRotation(inverseMatRotation)

      -- Reset the opponent's life tracker.
      farLife.setPosition(lifePositionFar)
    -- Only one side is being replaced.
    else
      -- ...replace only the player's half of the mat.
      --printToAll("newMatSide: "..newMatSide, {0,1,1})
      nearMat.setCustomObject({ image = newMatImage })
      nearMat.setSnapPoints({})
      nearMat.setLuaScript(newMatScript)
      nearMat = nearMat.reload()
      if Global.getVar("debugFlag") != true then
        nearMat.interactable = false
        Global.call("addUninteractable", { GUID = nearMat.getGUID()})
      end
      debugLog{" setting near mat snap points", 2, {0.3,1,0.3}}
      nearMat.setSnapPoints(newMatParams.snapPoints)
      nearMat.setRotation(newMatRotation)
      --printToAll(" newMat GUID: "..nearMat.getGUID())
      nearLife.setPosition(lifePositionNear)
    end

    -- New mat is half/half, old mat is full.
    if oldMatStyle == [[full]] then
      -- Show BOTH the new half mats. Hide the old full mat.
      --printToAll(" Hiding full mat, showing half mats")
      debugLog{" unsetting full snap points", 2, {1,0,1}}
      fullMat.setSnapPoints({})
      fullMat.attachInvisibleHider(fullMat.getGUID(), true, allPlayers)
      Global.call("addHidden", { GUID = fullMat.getGUID()})
      --hiddenObjects[fullMat.getGUID()] = true
      nearMat.attachInvisibleHider(nearMat.getGUID(), false, allPlayers)
      Global.call("removeHidden", { GUID = nearMat.getGUID()})
      --hiddenObjects[nearMat.getGUID()] = nil
      farMat.attachInvisibleHider(farMat.getGUID(), false, allPlayers)
      Global.call("removeHidden", { GUID = farMat.getGUID()})
      --hiddenObjects[farMat.getGUID()] = nil

      -- Reveal the half mat buttons for this player.
      for playmatName,playmatTable in pairs(playmatsTable) do
        if playmatTable.skip != true then
          debugLog{" showing half mat buttons for "..playmatName, 2, {0, 1, 0}}
          playmatTable.halfButtonVisibility[playerColor] = playmatTable.halfButtonVisibility[playerColor]..[[|]]..playerColor
          playmatTable.halfButtonVisibility[opposingColor] = playmatTable.halfButtonVisibility[opposingColor]..[[|]]..opposingColor
          local miniboard = getObjectFromGUID(playmatTable.GUID)
          for i,thisUIID in ipairs({
            playmatName..[[RHalf]],
            playmatName..[[LHalf]],
            playmatName..[[RHalfLabel]],
            playmatName..[[LHalfLabel]],
          }) do
            --printToAll("     UUID: "..thisUIID, {0.3, 0.8, 0.3})
            --printToAll("     new visibility: "..playmatTable.halfButtonVisibility, {0.5, 0.5, 0.3})
            miniboard.UI.setAttribute(thisUIID..playerColor, "visibility", playmatTable.halfButtonVisibility[playerColor])
            miniboard.UI.setAttribute(thisUIID..opposingColor, "visibility", playmatTable.halfButtonVisibility[opposingColor])
          end
        end -- end 'if playmatTable.skip != true'
      end -- finished revealing half mat buttons
    end -- end 'if oldMatStyle == full'
  end

  -- Saving updated values.
  if selectedVariant == nil then
    selectedVariant = newMatParams.currentVariant
  end
  currentPlaymats[matPosition].fullMatGUID = fullMat.getGUID()
  currentPlaymats[matPosition].currentMat = newMatName
  currentPlaymats[matPosition].currentStyle = newMatStyle
  currentPlaymats[matPosition].currentVariant = selectedVariant

  playerPairs[playerColor].playmatGUID = nearMat.getGUID()
  playerPairs[playerColor].currentMat = newMatName
  playerPairs[playerColor].currentVariant = selectedVariant

  playerPairs[opposingColor].playmatGUID = farMat.getGUID()
  playerPairs[opposingColor].currentMat = newMatName
  playerPairs[opposingColor].currentVariant = selectedVariant

  if altClick == true then
    playerPairs[playerColor].playmatGUID = farMat.getGUID()
    playerPairs[opposingColor].playmatGUID = nearMat.getGUID()
  else
    playerPairs[playerColor].playmatGUID = nearMat.getGUID()
    playerPairs[opposingColor].playmatGUID = farMat.getGUID()
  end
end



function uiClick_PlaymatVariant(player, clickValue, buttonID)
  local playerColor = player.color
  local clickedMatName = string.sub(buttonID, 1, string.len(buttonID)-7)
  local altClick = false
  if clickValue != [[-1]] then
    altClick = true
  end

  local clickedMatParams = playmatsTable[clickedMatName]
  local clickedMat = getObjectFromGUID(clickedMatParams.GUID)
  --local currentVariant = clickedMatParams.currentVariant
  --local totalVariants = clickedMatParams.variants
  local variantList = clickedMatParams.variantList

  if altClick == true then
    clickedMatParams.currentVariant = clickedMatParams.currentVariant-1
    if clickedMatParams.currentVariant == 0 then
      clickedMatParams.currentVariant = clickedMatParams.variants
    end
  else
    clickedMatParams.currentVariant = clickedMatParams.currentVariant+1
    if clickedMatParams.currentVariant > clickedMatParams.variants then
      clickedMatParams.currentVariant = 1
    end
  end

  local newImage = variantList[clickedMatParams.currentVariant].image
  if variantList[clickedMatParams.currentVariant].sample != nil then
    newImage = variantList[clickedMatParams.currentVariant].sample
  end

  -- Normally we'd have to reload the object after using setCustomObject.
  -- However, we're going to call createMiniboardButtons momentarily, which will do that anyway.
  clickedMat.setCustomObject({
    image = newImage,
  })
  clickedMatParams.GUID = clickedMat.getGUID()

  createMiniboardButtons(clickedMatName)
end -- end uiClick_PlaymatVariant



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



function disablePlayer(params)
  local player = params.player
  playerStatusList[player] = false
  playerStatusCount = playerStatusCount-1
end

function enablePlayer(params)
  local player = params.player
  playerStatusList[player] = true
  playerStatusCount = playerStatusCount+1
end

function getPlayerStatus(params)
  local player = params.player
  if playerStatusList[player] == true then
    return true
  else
    return false
  end
end



function playmatAddVariant(params)
    debugLog{"playmatAddVariant triggered!", 3, {255/255,100/255,100/255}}
    local matName = params.matName
    local newImage = params.image
    local matParams = playmatsTable[matName]
    local objMat = getObjectFromGUID(matParams.GUID)
    local variants = matParams.variants+1
    local variantList = matParams.variantList
    local newSample = params.sample

    if newSample == nil then
      newSample = newImage
    end

    -- Update the global variables for this playmat.
    table.insert(variantList, variants, {
      image = newImage,
      sample = newSample,
    })
    matParams.variants = variants
    matParams.currentVariant = variants
    debugLog{ "new variant ID: "..variants, 4}
    debugLog{ "total variants: "..matParams.variants, 4}

    -- Set the playmat's current variant to the newly added one.
    --newImage = variantList[clickedMatParams.currentVariant]
    objMat.setCustomObject({
      image = newImage,
    })
    objMat = objMat.reload()
    matParams.GUID = objMat.getGUID()
    createMiniboardButtons(matName)

    debugLog{"   recreating buttons...", 1}
    debugLog{"   finished adding variant", 2}
    debugLog{"   updating object reference with GUID: "..objMat.getGUID(), 2}
--]=]
end -- end playmatAddVariant



--[=[
setMat(params = {
    clickPlayer, -- e.g., [[Black]]
    clickButtonID, -- e.g. [[HighGround]]
    clickVariant, -- e.g., 1
    clickValue, -- optional unless clickAlt == true; e.g., [[-2]]
  })
--]=]
function setMat(params)

  local clickPlayer = params.clickPlayer
  local clickButtonID = params.clickMatName
  local clickVariant = params.clickVariant or 1
  local clickValue = params.clickValue or [[-1]]

  --debugLog{"params.clickPlayer: "..params.clickPlayer, 2}
  debugLog{"params.clickMatName: "..params.clickMatName, 2}
  debugLog{"clickVariant: "..clickVariant, 2}
  debugLog{"clickValue: "..clickValue, 2}

  uiClick_Playmat(clickPlayer, clickValue, clickButtonID, clickVariant)
end -- end setMat