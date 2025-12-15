function setup()

  isHidden = false

  local playmatStationGUID = Global.getVar("playmatStationGUID")
  local characterStationGUID = Global.getVar("characterStationGUID")
  seasonLegal = true

  playmatStation = getObjectFromGUID(playmatStationGUID)
  characterStation = getObjectFromGUID(characterStationGUID)

  -- Apparently, using a local variable to store a common function call improves performance.
  -- This is because global variables require a table lookup.
  local debugLog = debugLog

  -- This is just a list of all the player colors.
  allPlayers = { "Red", "Blue", "Yellow", "Green", "Orange", "Purple", "White", "Pink", "Brown", "Teal"}

  -- There's a certain script used for all markers to cause them to rotate slightly when they're placed on the board.
  -- This makes it harder to lose track of them when there are multiple cards in the same space.
  markerScript = characterStation.getVar("markerScript")


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

  -- This identifies which of these items gets its own toggle.
  -- There's no reason I can only have one per panel, but I don't want things getting too busy.
  normalsToggleName = "BlazBlue (Diverse)"

  normalsSheets = {}
  normalsSheets["BlazBlue (Diverse)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VPjK3En.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]

  --[=[ "As printed" Normals preserved for posterity.
  normalsSheets["Arakune"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LRkqJCf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Bang Shishigami"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PHUbNCi.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Carl Clover"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3FPvyWK.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Hakumen"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UGdBZa0.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Hazama"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mt5gQ5p.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Jin Kisaragi"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TcGJuIN.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Kokonoe"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yJcgtiK.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Litchi Faye Ling"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Sxroglz.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Nine the Phantom"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MFSsIJ9.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Noel Vermillion"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LlBnvrh.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Nu-13"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tY1QSFD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Platinum the Trinity"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RvWU0JP.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Rachel Alucard"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Q0O01Mo.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Ragna the Bloodedge"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XxhLhEr.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Iron Tager"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/potdLIC.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Taokaka"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aytQYfM.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  --]=]

  normalsSheets["Arakune"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Y4YT0Ac.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Bang Shishigami"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3u51rI3.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Carl Clover"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uM8z42h.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Hakumen"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8eRSKQj.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Hazama"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pUD3hgw.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Jin Kisaragi"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/X9wCvLN.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Kokonoe"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NCQEwcO.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Litchi Faye Ling"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iRJcciC.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Nine the Phantom"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Wj6izpx.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Noel Vermillion"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MNulPgy.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Nu-13"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/il5eKSN.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Platinum the Trinity"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/eLQAyCh.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Rachel Alucard"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2HMhROh.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Ragna the Bloodedge"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/smQsPkF.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Iron Tager"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/oHnBzF8.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Taokaka"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IdQWUeN.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]

  normalsSheets["BlazBlue (Diverse) (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]

  -- Instead of individualized alternate sets, they now all use the diverse set.
  normalsSheets["Arakune (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Bang Shishigami (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Carl Clover (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Hakumen (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Hazama (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Jin Kisaragi (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Kokonoe (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Litchi Faye Ling (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Nine the Phantom (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Noel Vermillion (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Nu-13 (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Platinum the Trinity (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Rachel Alucard (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Ragna the Bloodedge (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Iron Tager (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Taokaka (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/rYK7cBD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]

  --[=[---------------------------------------------------------------------------
  charTable entry template:
  charTable["CHARACTERNAME"] = {
  season = "5", -- string, expects one of: "1", "2", "3", "4", "5", "6".
  legal = false, -- optional
  secret = false, -- optional
  assetName = "NinethePhantom",
  excludeFromRandomAny = true,
  attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Yr2fNEk.jpg]],
  charCard = "Nine the Phantom (C)",
  deck = {
    { deckID = "2", faceURL = "https://i.imgur.com/Yr2fNEk.jpg",
      backURL = "https://i.imgur.com/Yr2fNEk.jpg",
      gridWidth = 5, gridHeight = 2,
      hiddenBack = true,
      cardList = { { cardID = "00",
          cardNickname = "Lapis Lazuli of Lamentation (S)", copies = 1, reference = true, },
        { cardID = "01",
          cardNickname = "Emerald of Enmity (S)", copies = 1, reference = true, },
        { cardID = "02",
          cardNickname = "Morganite of Malice (S)", copies = 1, reference = true, },
        { cardID = "03",
          cardNickname = "Coral of Catastrophe (S)", copies = 1, reference = true, },
        { cardID = "04",
          cardNickname = "Kunzite of Keep Breaker (S)", copies = 1, reference = false, separate = true, },
        { cardID = "05",
          cardNickname = "Amethyst of Annihilation (S)", copies = 1, reference = false, separate = true, },
        { cardID = "06",
          cardNickname = "Navy Pressure (S)", copies = 1, reference = false, separate = true, },
        { cardID = "07",
          cardNickname = "Azurite Inferno (U)", copies = 1, reference = false, separate = true, },
        { cardID = "08",
          cardNickname = "Flame Punisher (U)", copies = 1, reference = false, separate = true, },
        { cardID = "09",
          cardNickname = "Colorless Void (U)",
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
          cardNickname = [[Grasp (N)]], copies = 1, reference = true, },
        { cardID = [[00]],
            cardNickname = [[Grasp (N)]], copies = 1, reference = false, },
        { cardID = [[01]],
          cardNickname = [[Cross (N)]], copies = 2, reference = true, },
        { cardID = [[02]],
          cardNickname = [[Assault (N)]], copies = 2, reference = true, },
        { cardID = [[03]],
          cardNickname = [[Spike (N)]], copies = 2, reference = true, },
        { cardID = [[04]],
          cardNickname = [[Focus (N)]], copies = 2, reference = true, },
        { cardID = [[05]],
          cardNickname = [[Dive (N)]], copies = 2, reference = true, },
        { cardID = [[06]],
          cardNickname = [[Sweep (N)]], copies = 2, reference = true, },
        }, -- end cardList
      }
  Normals do not currently support the "separate" member item ("separate = true" or "separate = false").
  --]=]


  --[==[ Format for costumes:
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
      costumeDeck = { --[=[This table should be a copy of the base character's entire deck, with changes made as desired.]=] }, -- end deck
      }, -- costume ends
    }, -- end costume list
  --]==]

  local row1Z = 36
  local row2Z = 12
  local row3Z = 0
  local row4Z = -12
  local row5Z = -36
  local column1X = -60
  local column2X = -36
  local column3X = -12
  local column4X = 0
  local column5X = 12
  local column6X = 36
  local column7X = 60
  local characterIconY = -100

  local iconSize = 23
  local btnScale = 115

  local togglePanelX = 0
  local togglePanelZ = 60
  local togglePanelY = -100

  local togglePanelSize = 60

  local normalsToggleX = 0
  local normalsToggleZ = -18
  local normalsToggleY = -80

  local normalsToggleSize = 50

  charTable = {}
  -- Season 5: BlazBlue
  charTable["Arakune"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[Arakune]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aVLBCb1.jpg]], charCard = [[Arakune (C)]], announcement = [[† Something bugs me about this one... †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Arakune",
      Description = [[S5, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jvuuZuU.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sxhFzMB.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ImgQFjP.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VSfTjJ7.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vSYaRxk.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Disjoint union ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[If p, then q ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[y, two-dash ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Permutation n, r ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[f piecewise ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[f inverse ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[f of g ;3 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[n to infinity ;4 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ETF4tXo.jpg]], -- April Fool's Exceed 2022
        altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hIgfoZy.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ngs8UZD.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NBusCZC.jpg]],
        altfaceURL = [[https://i.imgur.com/AnMvDrj.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/i9wKzKr.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Arakune (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Arakune]], position = { z = row4Z, y = characterIconY, x = column7X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "A Raccoon, Eh?",
        costumeDescription = [[Original design by voice-to-text software.
Created by Petersonian.]],
        costumeNormals = [[Arakune]],
        costumeAttackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3Qf4eFn.jpg]],
        --costumeOwner = { [[tirankin]], [[Jungy]], }, -- Only appears for players in this table.
        costumeFavorite = { [[Piraticus]], }, -- Prioritized for players in this table (but available regardless).
        --costumePassword = [[Seijun]], -- Locks access based on this password. Always needs to end with the character being clicked.
        --costumePasswordFavorite = [[Renea | Seijun]], -- Prioritized based on this password. ALways needs to end with the character being clicked.
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/ImgQFjP.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aqUCOfp.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                cardDescription = [[A Raccoon, Eh?]], copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/vSYaRxk.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Disjoint union ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[If p, then q ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[y, two-dash ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Permutation n, r ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[f piecewise ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[f inverse ;7 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[f of g ;3 (U)]], copies = 2, reference = true, },
              { cardID = [[07]],
                cardNickname = [[n to infinity ;4 (U)]], copies = 1, reference = true, separate = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/p5pUdXs.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/o5RjNQ7.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Arakune (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
        { -- costume begins
          costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
          costumeName = "Promo Arakune",
          costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
          costumeNormals = [[Arakune (Alternate)]],
          costumeDeck = {
            { deckID = [[4]],
              faceURL = [[https://i.imgur.com/ImgQFjP.jpg]],
              backURL = [[https://i.imgur.com/VSfTjJ7.jpg]],
              gridWidth = 1, gridHeight = 1,
              hiddenBack = false,
              cardList = { { cardID = [[00]],
                  cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                  copies = 0, reference = true, separate = false, },
                }, -- end cardList
              }, -- end subdeck
            { deckID = [[2]], faceURL = [[https://i.imgur.com/vSYaRxk.jpg]],
              gridWidth = 4, gridHeight = 2,
              hiddenBack = true,
              cardList = { { cardID = [[00]],
                  cardNickname = [[Disjoint union ;5 (S)]], copies = 2, reference = true, },
                { cardID = [[01]],
                  cardNickname = [[If p, then q ;5 (S)]], copies = 2, reference = true, },
                { cardID = [[02]],
                  cardNickname = [[y, two-dash ;4 (S)]], copies = 2, reference = true, },
                { cardID = [[03]],
                  cardNickname = [[Permutation n, r ;3 (S)]], copies = 2, reference = true, },
                { cardID = [[04]],
                  cardNickname = [[f piecewise ;2 (S)]], copies = 2, reference = true, },
                { cardID = [[05]],
                  cardNickname = [[f inverse ;7 (U)]], copies = 2, reference = true, },
                { cardID = [[06]],
                  cardNickname = [[f of g ;3 (U)]], copies = 2, reference = true, },
                { cardID = [[07]],
                  cardNickname = [[n to infinity ;4 (U)]], copies = 1, reference = true, separate = true, },
                }, -- end cardList
              }, -- end subdeck 2
            { deckID = [[3]],
              faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0IV5Z94.png]],
              backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JPUJ8wC.png]],
              gridWidth = 1, gridHeight = 1,
              hiddenBack = false,
              cardList = { { cardID = [[00]],
                  cardNickname = [[Arakune (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Arakune (Costume: Promo Arakune)]] },
                }, -- end cardList
              }, -- end subdeck
            }, -- end deck
          }, -- costume ends
      }, -- end costume list
    }
  charTable["Bang Shishigami"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[BangShishigami]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uLj1uVy.jpg]], charCard = [[Bang Shishigami (C)]], announcement = [[† Quicker than the wind and as still as the forest! Hotter than flames and MORE MAGNIFICENT THAN A MOUNTAIN! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Bang Shishigami",
      Description = [[S5, Difficulty 1 (Novice)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/95QoHzy.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YrDxjbW.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/I59oKe2.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bt6rduh.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/BEYa6cu.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Bang-Style Shuriken ;6 (S)]], copies = 2, reference = true,
            tooltip = true, cardDescription = [["Shuriken special!"]], },
          { cardID = [[01]],
            cardNickname = [[Unstoppable Palm Thrust ;5 (S)]], copies = 2, reference = true,
            tooltip = true, cardDescription = [["Heavenly phoenix!"]], },
          { cardID = [[02]],
            cardNickname = [[Void Tempest Kick ;4 (S)]], copies = 2, reference = true,
            tooltip = true, cardDescription = [["Void Tempest! Bang Drop!"]], },
          { cardID = [[03]],
            cardNickname = [[Pulverizing Blast Jutsu ;2 (S)]], copies = 2, reference = true,
            tooltip = true, cardDescription = [["Defender of justice! Burning Bang!"]], },
          { cardID = [[04]],
            cardNickname = [[Infinite Chaos-Fist of the Void ;9 (U)]], copies = 2, reference = true,
            tooltip = true, cardDescription = [["Shishigami ninpo! I am! No, WE ARE! BANG!"]], },
          { cardID = [[05]],
            cardNickname = [[Hyper Shadowstep Strike ;7 (U)]], copies = 2, reference = true,
            tooltip = true, cardDescription = [["Shishigami-ninpo Forbidden Art: Fū-Rin-Ka-Zan!"]], },
          { cardID = [[06]],
            cardNickname = [[Fatal Eruption ;5 (U)]], copies = 2, reference = true,
            tooltip = true, cardDescription = [["To rid this world of evil, I will become.. THE HAMMER... OF JUSTICE!"]], },
          { cardID = [[07]],
            cardNickname = [[The Ultimate Bang ;1 (U)]], copies = 1, reference = true, separate = true,
            tooltip = true, cardDescription = [["The time! Has! Come! SUUUPEEER! BAAAAANG!"]], },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wJuEZwW.jpg]], -- April Fool's Exceed 2022
        altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qOuU748.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TcepW5u.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gtc0M3r.jpg]],
        altfaceURL = [[https://i.imgur.com/I1S8uKl.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/GMtWn0s.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Bang Shishigami (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardScript = [===[function onLoad()
            themeURL = [[https://steamusercontent-a.akamaihd.net/ugc/1774948906013495769/E7CE3809A8AAB6EC4B3E97F749460C7D0A3A7379/]]
            quoteList = {
              [[I see right through you!]],
              [[The tables have turned!]],
              [[Nani!?]],
              [[Ninja taijutsu!]],
              [[Hailed by the heavens, the earth, and the people! The one and only Bang Shishigami is now here!]],
              [[By the sweat of my brow, I will punish you!]],
              [[You won't escape, evildoer! The defender of justice, Bang Shishigami, will be your opponent!]],
              [[Your exploits can no longer go unchallenged!]],
              [[I will exact justice here and now!]],
              [[Defender of justice! Burning Bang!]],
              [[Shishigami-ninpo Forbidden Art!]],
              [[I cannot lose until I have fulfilled my duties!]],
              [[Here comes... THE HERO OF JUSTICE!]],
              [[There are two things in this world I cannot stand! Lies, and evil, and lies, and BELL PEPPERS!]],
              [[I am Bang Shishigami! The man respected and adored by ALL THOSE WHO FOLLOW HIM!]],
              [[Hero of love and justice, Bang Shishigami!]],
              [[Where evil and darkness lurks, so shall I; Bang Shishigami, at your service!]],
              [[You there, halt! The hero of love and justice shall be your opponent!]],
              [[Stand fast, evildoer! Let us fight fair and square!]],
              [[By the sweat of my brow, I... uh... ahh, no matter. The ninja who fights for love and justice is here!]],
              [[Witness the power of a ninja!]],
              [[Feel the wrath of a ninja!]],
              [[Justice will prevail!]],
              [[Tune in next week for The Fellowship of Bang!]],
              [[Never underestimate a ninja!]],
              [[Need a hero? Look no further!]],
              [[It is a well-known fact that I am the strongest ninja!]],
              [[I am none other than Bang Shishigami, a kind man who helps those in need!]],
            }
            quoteCount = 0
            for i in pairs(quoteList) do
             quoteCount = quoteCount+1
            end
            local quoteID = math.random(1, quoteCount)
            local quote = quoteList[quoteID]

            btnParams = {
            click_function = [[beatANail]],
            function_owner = self,
            label          = [[火風
山林]],
            position       = {0.75, -0.5, 0.685},
            rotation       = {0,0,180},
            scale          = {0.57,0.57,0.57},
            width          = 300,
            height         = 300,
            --font_size      = -- int,
            color          = {0.9, 0.9, 0.1},
            --font_color     = -- Color,
            tooltip        = quote..[[


Shishigami-ninpo Forbidden Art: Fū-Rin-Ka-Zan!]],
            }
              self.createButton(btnParams)
          end

          function beatANail()
            broadcastToAll([[Quicker than the wind and as still as the forest! Hotter than flames and MORE MAGNIFICENT THAN A MOUNTAIN!]], {0.9,0.9,0.1})
            MusicPlayer.repeat_track = false
            MusicPlayer.setCurrentAudioclip({url=themeURL,title=[[FURINKAZAN!]]})
            btnParams.tooltip = [[(Kind of noisy for a ninja, isn't he?)]]
            btnParams.click_function = [[toggleMusic]]
            self.removeButton(0)

            queueMusic()
--[=[
            local runFunction = function ()
                -- Wait 220 frames, then broadcast the quote...
                Wait.frames(function ()
                  broadcastToAll(quote, {0.9,0.9,0.1})
                  -- ...then wait 500 additional frames, then create the button to toggle the music.
                  Wait.frames(function ()
                    self.createButton(btnParams)
                  end, 500)
                end, 220)
            end

            local loaded = false

            while loaded == false do
              Wait.frames(function ()
                loaded = MusicPlayer.loaded
              end, 30)
              if loaded == true then
                runFunction()
              end
            end

            local checkFunction = function () return MusicPlayer.loaded end

            -- Wait until the clip has loaded for everyone (it begins playing automatically) before triggering the function defined above.
            Wait.condition(runFunction, checkFunction)
--]=]
          end

          function queueMusic()
            if MusicPlayer.loaded != true then
              -- If the clip hasn't loaded for everybody, delay a number of frames, then check again.
              Wait.frames(function ()
                queueMusic()
              end, 60)
            else
              -- Wait 220 frames, then broadcast the quote...
              Wait.frames(function ()
                local quoteID = math.random(1, quoteCount)
                local quote = quoteList[quoteID]
                broadcastToAll(quote, {0.9,0.9,0.1})
                -- ...then wait 500 additional frames, then create the button to toggle the music.
                Wait.frames(function ()
                  self.createButton(btnParams)
                end, 500)
              end, 220)
            end
          end

          function toggleMusic(obj, playercolor)
            local playerReference = Player[playercolor]
            local quoteID = math.random(1, quoteCount)
            local quote = quoteList[quoteID]
            if MusicPlayer.player_status == [[Play]] and MusicPlayer.getCurrentAudioclip().url == themeURL then
              -- If Bang's theme song is already playing, pause it.
              playerReference.broadcast([[Very well, I shall hold my peace.]], {0.6,0.6,0.6})
              self.removeButton(0)
              btnParams.tooltip = quote
              MusicPlayer.pause()
              Wait.frames(function ()
                 self.createButton(btnParams)
               end, 12)
            else
              -- If Bang's theme song isn't currently playing, either resume or restart it.
              broadcastToAll(quote, {0.9,0.9,0.1})
              self.removeButton(0)
              btnParams.tooltip = [[(Kind of noisy for a ninja, isn't he?)]]
              if MusicPlayer.getCurrentAudioclip().url == themeURL then
                -- If the current clip is his theme song, resume it.
                MusicPlayer.play()
              else
                -- If the current clip isn't his theme song, restart it.
                MusicPlayer.setCurrentAudioclip({url=themeURL,title=[[FURINKAZAN!]]})
              end
              Wait.frames(function ()
                 self.createButton(btnParams)
               end, 12)
            end
          end]===]},
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Bang Shishigami]], position = { z = row2Z, y = characterIconY, x = column7X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Bang",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Bang Shishigami (Alternate)]],
        costumeDeck = {
        { deckID = [[4]],
          faceURL = [[https://i.imgur.com/I59oKe2.jpg]],
          backURL = [[https://i.imgur.com/bt6rduh.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
              copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://i.imgur.com/BEYa6cu.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Bang-Style Shuriken ;6 (S)]], copies = 2, reference = true,
              tooltip = true, cardDescription = [["Shuriken special!"]], },
            { cardID = [[01]],
              cardNickname = [[Unstoppable Palm Thrust ;5 (S)]], copies = 2, reference = true,
              tooltip = true, cardDescription = [["Heavenly phoenix!"]], },
            { cardID = [[02]],
              cardNickname = [[Void Tempest Kick ;4 (S)]], copies = 2, reference = true,
              tooltip = true, cardDescription = [["Void Tempest! Bang Drop!"]], },
            { cardID = [[03]],
              cardNickname = [[Pulverizing Blast Jutsu ;2 (S)]], copies = 2, reference = true,
              tooltip = true, cardDescription = [["Defender of justice! Burning Bang!"]], },
            { cardID = [[04]],
              cardNickname = [[Infinite Chaos-Fist of the Void ;9 (U)]], copies = 2, reference = true,
              tooltip = true, cardDescription = [["Shishigami ninpo! I am! No, WE ARE! BANG!"]], },
            { cardID = [[05]],
              cardNickname = [[Hyper Shadowstep Strike ;7 (U)]], copies = 2, reference = true,
              tooltip = true, cardDescription = [["Shishigami-ninpo Forbidden Art: Fū-Rin-Ka-Zan!"]], },
            { cardID = [[06]],
              cardNickname = [[Fatal Eruption ;5 (U)]], copies = 2, reference = true,
              tooltip = true, cardDescription = [["To rid this world of evil, I will become.. THE HAMMER... OF JUSTICE!"]], },
            { cardID = [[07]],
              cardNickname = [[The Ultimate Bang ;1 (U)]], copies = 1, reference = true, separate = true,
              tooltip = true, cardDescription = [["The time! Has! Come! SUUUPEEER! BAAAAANG!"]], },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VGdFtz3.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Fv8tfTg.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Bang Shishigami (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Bang Shishigami (Costume: Promo Bang)]],
              cardScript = [===[function onLoad()
                themeURL = [[https://steamusercontent-a.akamaihd.net/ugc/1774948906013495769/E7CE3809A8AAB6EC4B3E97F749460C7D0A3A7379/]]
                quoteList = {
                  [[I see right through you!]],
                  [[The tables have turned!]],
                  [[Nani!?]],
                  [[Ninja taijutsu!]],
                  [[Hailed by the heavens, the earth, and the people! The one and only Bang Shishigami is now here!]],
                  [[By the sweat of my brow, I will punish you!]],
                  [[You won't escape, evildoer! The defender of justice, Bang Shishigami, will be your opponent!]],
                  [[Your exploits can no longer go unchallenged!]],
                  [[I will exact justice here and now!]],
                  [[Defender of justice! Burning Bang!]],
                  [[Shishigami-ninpo Forbidden Art!]],
                  [[I cannot lose until I have fulfilled my duties!]],
                  [[Here comes... THE HERO OF JUSTICE!]],
                  [[There are two things in this world I cannot stand! Lies, and evil, and lies, and BELL PEPPERS!]],
                  [[I am Bang Shishigami! The man respected and adored by ALL THOSE WHO FOLLOW HIM!]],
                  [[Hero of love and justice, Bang Shishigami!]],
                  [[Where evil and darkness lurks, so shall I; Bang Shishigami, at your service!]],
                  [[You there, halt! The hero of love and justice shall be your opponent!]],
                  [[Stand fast, evildoer! Let us fight fair and square!]],
                  [[By the sweat of my brow, I... uh... ahh, no matter. The ninja who fights for love and justice is here!]],
                  [[Witness the power of a ninja!]],
                  [[Feel the wrath of a ninja!]],
                  [[Justice will prevail!]],
                  [[Tune in next week for The Fellowship of Bang!]],
                  [[Never underestimate a ninja!]],
                  [[Need a hero? Look no further!]],
                  [[It is a well-known fact that I am the strongest ninja!]],
                  [[I am none other than Bang Shishigami, a kind man who helps those in need!]],
                }
                quoteCount = 0
                for i in pairs(quoteList) do
                 quoteCount = quoteCount+1
                end
                local quoteID = math.random(1, quoteCount)
                local quote = quoteList[quoteID]

                btnParams = {
                click_function = [[beatANail]],
                function_owner = self,
                label          = [[火風
  山林]],
                position       = {0.75, -0.5, 0.685},
                rotation       = {0,0,180},
                scale          = {0.57,0.57,0.57},
                width          = 300,
                height         = 300,
                --font_size      = -- int,
                color          = {0.9, 0.9, 0.1},
                --font_color     = -- Color,
                tooltip        = quote..[[


  Shishigami-ninpo Forbidden Art: Fū-Rin-Ka-Zan!]],
                }
                  self.createButton(btnParams)
              end

              function beatANail()
                broadcastToAll([[Quicker than the wind and as still as the forest! Hotter than flames and MORE MAGNIFICENT THAN A MOUNTAIN!]], {0.9,0.9,0.1})
                MusicPlayer.repeat_track = false
                MusicPlayer.setCurrentAudioclip({url=themeURL,title=[[FURINKAZAN!]]})
                btnParams.tooltip = [[(Kind of noisy for a ninja, isn't he?)]]
                btnParams.click_function = [[toggleMusic]]
                self.removeButton(0)

                queueMusic()
  --[=[
                local runFunction = function ()
                    -- Wait 220 frames, then broadcast the quote...
                    Wait.frames(function ()
                      broadcastToAll(quote, {0.9,0.9,0.1})
                      -- ...then wait 500 additional frames, then create the button to toggle the music.
                      Wait.frames(function ()
                        self.createButton(btnParams)
                      end, 500)
                    end, 220)
                end

                local loaded = false

                while loaded == false do
                  Wait.frames(function ()
                    loaded = MusicPlayer.loaded
                  end, 30)
                  if loaded == true then
                    runFunction()
                  end
                end

                local checkFunction = function () return MusicPlayer.loaded end

                -- Wait until the clip has loaded for everyone (it begins playing automatically) before triggering the function defined above.
                Wait.condition(runFunction, checkFunction)
  --]=]
              end

              function queueMusic()
                if MusicPlayer.loaded != true then
                  -- If the clip hasn't loaded for everybody, delay a number of frames, then check again.
                  Wait.frames(function ()
                    queueMusic()
                  end, 60)
                else
                  -- Wait 220 frames, then broadcast the quote...
                  Wait.frames(function ()
                    local quoteID = math.random(1, quoteCount)
                    local quote = quoteList[quoteID]
                    broadcastToAll(quote, {0.9,0.9,0.1})
                    -- ...then wait 500 additional frames, then create the button to toggle the music.
                    Wait.frames(function ()
                      self.createButton(btnParams)
                    end, 500)
                  end, 220)
                end
              end

              function toggleMusic(obj, playercolor)
                local playerReference = Player[playercolor]
                local quoteID = math.random(1, quoteCount)
                local quote = quoteList[quoteID]
                if MusicPlayer.player_status == [[Play]] and MusicPlayer.getCurrentAudioclip().url == themeURL then
                  -- If Bang's theme song is already playing, pause it.
                  playerReference.broadcast([[Very well, I shall hold my peace.]], {0.6,0.6,0.6})
                  self.removeButton(0)
                  btnParams.tooltip = quote
                  MusicPlayer.pause()
                  Wait.frames(function ()
                     self.createButton(btnParams)
                   end, 12)
                else
                  -- If Bang's theme song isn't currently playing, either resume or restart it.
                  broadcastToAll(quote, {0.9,0.9,0.1})
                  self.removeButton(0)
                  btnParams.tooltip = [[(Kind of noisy for a ninja, isn't he?)]]
                  if MusicPlayer.getCurrentAudioclip().url == themeURL then
                    -- If the current clip is his theme song, resume it.
                    MusicPlayer.play()
                  else
                    -- If the current clip isn't his theme song, restart it.
                    MusicPlayer.setCurrentAudioclip({url=themeURL,title=[[FURINKAZAN!]]})
                  end
                  Wait.frames(function ()
                     self.createButton(btnParams)
                   end, 12)
                end
              end]===]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Carl Clover"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[CarlClover]], assetTooltip = [[
.............................
.            ...            .
.            ...            .
.............................]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ePmFdNt.jpg]], charCard = [[Carl Clover (C)]], announcement = [[† Help me, sis! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Carl Clover",
      Description = [[S5, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/N3GHPSH.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/K9BBE2O.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Dqi4gN1.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DDoJ9pM.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YrTDqYN.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Con Brio ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Cantabile ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Con Fuoco ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Con Anima ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Volante ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Rhapsody of Memories ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Laetabilis Cantata ;2 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Deus Ex Machina ;0 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[5]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/R1tjQW3.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2ylT2x2.jpg]],
        altfaceURL = [[https://i.imgur.com/rL0GfON.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/eN57bf0.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Nirvana (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/17R4U7x.jpg]], -- April Fool's Exceed 2022
        altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ezYH6Qg.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/B3XpB0n.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ls0RIiE.jpg]],
        altfaceURL = [[https://i.imgur.com/9GLJzjK.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/xLqlhdX.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Carl Clover (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Carl Clover]], position = { z = row1Z, y = characterIconY, x = column6X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Carl",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Carl Clover (Alternate)]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/Dqi4gN1.jpg]],
            backURL = [[https://i.imgur.com/DDoJ9pM.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/YrTDqYN.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Con Brio ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Cantabile ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Con Fuoco ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Con Anima ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Volante ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Rhapsody of Memories ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Laetabilis Cantata ;2 (U)]], copies = 2, reference = true, },
              { cardID = [[07]],
                cardNickname = [[Deus Ex Machina ;0 (U)]], copies = 1, reference = true, separate = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[5]],
            faceURL = [[https://i.imgur.com/R1tjQW3.jpg]],
            backURL = [[https://i.imgur.com/2ylT2x2.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Nirvana (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lGNSsq4.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/B4pqYrT.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Carl Clover (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Carl Clover (Costume: Promo Carl)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Hakumen"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[Hakumen]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/c3Po5cI.jpg]], charCard = [[Hakumen (C)]], announcement = [[† I am the white void. I am the cold steel. I am the just sword.
With blade in hand shall I reap the sins of this world and cleanse it in the fires of destruction.
I am Hakumen. The end has come. †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Hakumen",
      Description = [[S5, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iPLaBFA.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PJfKKmU.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LDO51bv.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8wanyvL.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RFvHyXo.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Enma ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Guren ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Renka ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Yanagi ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Zantetsu ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Kokuujin: Yukikaze ;2 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Kokuujin: Shippu ;1 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Akumetsu ;0 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6Wq97Fq.jpg]], -- April Fool's Exceed 2022
        altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/K8UMlCn.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rLT5Ta6.jpg]],
        --backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ReTSTqv.jpg]], -- Original back image.
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/k0tcoVf.jpg]], -- Modified back image.
        altfaceURL = [[https://i.imgur.com/dvG4lxA.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/3nblwsn.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Hakumen (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Hakumen]], position = { z = row1Z, y = characterIconY, x = column5X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Hakumen",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Hakumen (Alternate)]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/LDO51bv.jpg]],
            backURL = [[https://i.imgur.com/8wanyvL.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/RFvHyXo.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Enma ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Guren ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Renka ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Yanagi ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Zantetsu ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Kokuujin: Yukikaze ;2 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Kokuujin: Shippu ;1 (U)]], copies = 2, reference = true, },
              { cardID = [[07]],
                cardNickname = [[Akumetsu ;0 (U)]], copies = 1, reference = true, separate = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yoxcMHl.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bA7TY0y.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Hakumen (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Hakumen (Costume: Promo Hakumen)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Hazama"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[Hazama]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6M2Bfod.jpg]], charCard = [[Hazama (C)]], announcement = [[† Having fun yet? †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Hazama",
      Description = [[S5, Difficulty 3* (Intermediate+)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AUuwgPy.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/atv9UlY.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VOUhRdI.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/J0cuGvK.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/5mAcmUK.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Falling Fang ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Hungry Coils ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Venom Sword ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Devouring Fang ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Rising Fang ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Serpent's Infernal Rapture ;8 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Eternal Coils of the Dragon Serpent ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Hungry Darkness of 1000 Souls ;4 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[6]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WVPPHlK.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uSn7RAw.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Ouroboros (C)]], copies = 1, reference = false, separate = true, cardScript = markerScript, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[5]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AW6vmPK.jpg]],
        backURL = [[https://i.imgur.com/uSn7RAw.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Ouroboros (C)]], copies = 1, reference = false, separate = true, cardScript = markerScript, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iFsLDk0.jpg]], -- April Fool's Exceed 2022
        altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jrmvhdk.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/5Dcpn07.jpg]],
        --backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/D7YAkPi.jpg]],-- Original art for Hazama's Exceed Mode.
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/u7srx73.jpg]], -- Modified art for Hazama's Exceed Mode.
        altfaceURL = [[https://i.imgur.com/73Kkw8M.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/EmrDzbe.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Hazama (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Hazama]], position = { z = row4Z, y = characterIconY, x = column2X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Hazama",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Hazama (Alternate)]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/VOUhRdI.jpg]],
            backURL = [[https://i.imgur.com/J0cuGvK.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/5mAcmUK.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Falling Fang ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Hungry Coils ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Venom Sword ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Devouring Fang ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Rising Fang ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Serpent's Infernal Rapture ;8 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Eternal Coils of the Dragon Serpent ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[07]],
                cardNickname = [[Hungry Darkness of 1000 Souls ;4 (U)]], copies = 1, reference = true, separate = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[6]],
            faceURL = [[https://i.imgur.com/WVPPHlK.jpg]],
            backURL = [[https://i.imgur.com/uSn7RAw.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Ouroboros (C)]], copies = 1, reference = false, separate = true, cardScript = markerScript, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[5]],
            faceURL = [[https://i.imgur.com/AW6vmPK.jpg]],
            backURL = [[https://i.imgur.com/uSn7RAw.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Ouroboros (C)]], copies = 1, reference = false, separate = true, cardScript = markerScript, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lhRETU4.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Onl8bRu.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Hazama (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Hazama (Costume: Promo Hazama)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Jin Kisaragi"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[JinKisaragi]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mujeqZx.jpg]], charCard = [[Jin Kisaragi (C)]], announcement = [[† Chill, dude. †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Jin Kisaragi",
      Description = [[S5, Difficulty 1 (Novice)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/z4eTw1Y.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nQ8kfOi.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ohfDe5v.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ITn2tgM.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        --faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cjgjzK6.jpg]], -- Original card images.
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/G2aunbM.jpg]], -- Modified card images.
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Violent Ice ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Crystal Strike ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Permafrost ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Ice Blade ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Dual Ice Strike ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Moonsong ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Ice Fang ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Arctic Dungeon ;0 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/45geFzq.jpg]], -- April Fool's Exceed 2022
        altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/B9zj5zR.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/A45XyrN.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bnOeUdC.jpg]],
        altfaceURL = [[https://i.imgur.com/n5l9K2A.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/xVh00pW.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Jin Kisaragi (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Jin Kisaragi]], position = { z = row2Z, y = characterIconY, x = column6X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Jin",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Jin Kisaragi (Alternate)]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/ohfDe5v.jpg]],
            backURL = [[https://i.imgur.com/ITn2tgM.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]],
            --faceURL = [[https://i.imgur.com/cjgjzK6.jpg]], -- Original card images.
            faceURL = [[https://i.imgur.com/G2aunbM.jpg]], -- Modified card images.
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Violent Ice ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Crystal Strike ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Permafrost ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Ice Blade ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Dual Ice Strike ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Moonsong ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Ice Fang ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[07]],
                cardNickname = [[Arctic Dungeon ;0 (U)]], copies = 1, reference = true, separate = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9uA3rhv.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/M6rqljm.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Jin Kisaragi (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Jin Kisaragi (Costume: Promo Jin)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Kokonoe"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[Kokonoe]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ylDqXky.jpg]], charCard = [[Kokonoe (C)]], announcement = [[† She's a big fan of the Boost on Dive! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Kokonoe",
      Description = [[S5, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gDNXSNU.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wNNgJwY.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NsscEBO.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pFkmirz.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ASKoXk8.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Absolute Zero v4.32 ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Broken Bunker Assault v2.21 ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Banishing Rays v3.10 ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Solid Wheel v3.37 ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Flame Cage v1.43 ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Dreadnought Exterminator ;3 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Flaming Belobog v2.73 ;2 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Ultimate Impact ;4 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[5]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LCApYi6.jpg]],
        backURL = [[https://i.imgur.com/LCApYi6.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Graviton (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1ow5g4X.jpg]], -- April Fool's Exceed 2022
        altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pUgYlqw.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CzUrtZW.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vuuDyGJ.jpg]],
        altfaceURL = [[https://i.imgur.com/ObskQcZ.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/SclPd5M.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Kokonoe (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Kokonoe]], position = { z = row4Z, y = characterIconY, x = column1X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Kokonoe",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Kokonoe (Alternate)]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/NsscEBO.jpg]],
            backURL = [[https://i.imgur.com/pFkmirz.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/ASKoXk8.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Absolute Zero v4.32 ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Broken Bunker Assault v2.21 ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Banishing Rays v3.10 ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Solid Wheel v3.37 ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Flame Cage v1.43 ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Dreadnought Exterminator ;3 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Flaming Belobog v2.73 ;2 (U)]], copies = 2, reference = true, },
              { cardID = [[07]],
                cardNickname = [[Ultimate Impact ;4 (U)]], copies = 1, reference = true, separate = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[5]],
            faceURL = [[https://i.imgur.com/LCApYi6.jpg]],
            backURL = [[https://i.imgur.com/LCApYi6.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Graviton (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fwoYQd8.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ib8XT80.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Kokonoe (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Kokonoe (Costume: Promo Kokonoe)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Litchi Faye Ling"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[LitchiFayeLing]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mt9uLDV.jpg]], charCard = [[Litchi Faye Ling (C)]], announcement = [[† Stick around! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Litchi Faye Ling",
      Description = [[S5, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RgE7dyO.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pGlaEIc.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RfXDWHY.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wHP38Tv.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/94QdEQs.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Tsubame Gaeshi ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Reach: Robbing the Kong ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Renchan ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Four Winds ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Unarmed Lunge ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[All Green ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Thirteen Orphans ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Nine Gates of Heaven ;7 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[5]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GWHtkaY.jpg]],
        backURL = [[https://i.imgur.com/GWHtkaY.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Mantenbo (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CCS98Pw.jpg]], -- April Fool's Exceed 2022
        altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zncy8kQ.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XiyOFwg.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/akpX1ss.jpg]],
        altfaceURL = [[https://i.imgur.com/8a3FPH9.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/Jaujxl3.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Litchi Faye Ling (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Litchi Faye Ling]], position = { z = row5Z, y = characterIconY, x = column6X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Litchi",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Litchi Faye Ling (Alternate)]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/RfXDWHY.jpg]],
            backURL = [[https://i.imgur.com/wHP38Tv.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/94QdEQs.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Tsubame Gaeshi ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Reach: Robbing the Kong ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Renchan ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Four Winds ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Unarmed Lunge ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[All Green ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Thirteen Orphans ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[07]],
                cardNickname = [[Nine Gates of Heaven ;7 (U)]], copies = 1, reference = true, separate = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[5]],
            faceURL = [[https://i.imgur.com/GWHtkaY.jpg]],
            backURL = [[https://i.imgur.com/GWHtkaY.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Mantenbo (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/twCI9qN.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xiEO8gR.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Litchi Faye Ling (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Litchi Faye Ling (Costume: Promo Litchi)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Nine the Phantom"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[NinethePhantom]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/U0sSwJa.jpg]], charCard = [[Nine the Phantom (C)]], announcement = [[† Complexity rating: Hold on to your hat. †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Nine the Phantom",
      Description = [[S5, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WKgAyh9.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1i6jg1I.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UUwHaZK.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jMkIGtf.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RhpF7Zi.jpg]],
        gridWidth = 5, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Lapis Lazuli of Lamentation ;7 (S)]], copies = 1, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Emerald of Enmity ;6 (S)]], copies = 1, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Morganite of Malice ;5 (S)]], copies = 1, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Coral of Catastrophe ;4 (S)]], copies = 1, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Kunzite of Keep Breaker ;3 (S)]], copies = 1, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Amethyst of Annihilation ;2 (S)]], copies = 1, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Navy Pressure ;1 (S)]], copies = 1, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Azurite Inferno ;8 (U)]], copies = 1, reference = true, },
          { cardID = [[08]],
            cardNickname = [[Flame Punisher ;0 (U)]], copies = 1, reference = true, },
          { cardID = [[00]],
            cardNickname = [[Lapis Lazuli of Lamentation ;7 (S)]], copies = 1, reference = false, separate = true, },
          { cardID = [[01]],
            cardNickname = [[Emerald of Enmity ;6 (S)]], copies = 1, reference = false, separate = true, },
          { cardID = [[02]],
            cardNickname = [[Morganite of Malice ;5 (S)]], copies = 1, reference = false, separate = true, },
          { cardID = [[03]],
            cardNickname = [[Coral of Catastrophe ;4 (S)]], copies = 1, reference = false, separate = true, },
          { cardID = [[04]],
            cardNickname = [[Kunzite of Keep Breaker ;3 (S)]], copies = 1, reference = false, separate = true, },
          { cardID = [[05]],
            cardNickname = [[Amethyst of Annihilation ;2 (S)]], copies = 1, reference = false, separate = true, },
          { cardID = [[06]],
            cardNickname = [[Navy Pressure ;1 (S)]], copies = 1, reference = false, separate = true, },
          { cardID = [[07]],
            cardNickname = [[Azurite Inferno ;8 (U)]], copies = 1, reference = false, separate = true, },
          { cardID = [[08]],
            cardNickname = [[Flame Punisher ;0 (U)]], copies = 1, reference = false, separate = true, },
          { cardID = [[09]],
            cardNickname = [[Colorless Void ;9 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aS4g6ob.jpg]], -- April Fool's Exceed 2022
        altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/j7FDkek.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/R1EzqZU.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ul2AnMP.jpg]],
        altfaceURL = [[https://i.imgur.com/h1dYEIS.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/zLBqZt6.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Nine the Phantom (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Nine the Phantom]], position = { z = row5Z, y = characterIconY, x = column3X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Nine",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Nine the Phantom (Alternate)]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/UUwHaZK.jpg]],
            backURL = [[https://i.imgur.com/jMkIGtf.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/RhpF7Zi.jpg]],
            gridWidth = 5, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Lapis Lazuli of Lamentation ;7 (S)]], copies = 1, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Emerald of Enmity ;6 (S)]], copies = 1, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Morganite of Malice ;5 (S)]], copies = 1, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Coral of Catastrophe ;4 (S)]], copies = 1, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Kunzite of Keep Breaker ;3 (S)]], copies = 1, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Amethyst of Annihilation ;2 (S)]], copies = 1, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Navy Pressure ;1 (S)]], copies = 1, reference = true, },
              { cardID = [[07]],
                cardNickname = [[Azurite Inferno ;8 (U)]], copies = 1, reference = true, },
              { cardID = [[08]],
                cardNickname = [[Flame Punisher ;0 (U)]], copies = 1, reference = true, },
              { cardID = [[00]],
                cardNickname = [[Lapis Lazuli of Lamentation ;7 (S)]], copies = 1, reference = false, separate = true, },
              { cardID = [[01]],
                cardNickname = [[Emerald of Enmity ;6 (S)]], copies = 1, reference = false, separate = true, },
              { cardID = [[02]],
                cardNickname = [[Morganite of Malice ;5 (S)]], copies = 1, reference = false, separate = true, },
              { cardID = [[03]],
                cardNickname = [[Coral of Catastrophe ;4 (S)]], copies = 1, reference = false, separate = true, },
              { cardID = [[04]],
                cardNickname = [[Kunzite of Keep Breaker ;3 (S)]], copies = 1, reference = false, separate = true, },
              { cardID = [[05]],
                cardNickname = [[Amethyst of Annihilation ;2 (S)]], copies = 1, reference = false, separate = true, },
              { cardID = [[06]],
                cardNickname = [[Navy Pressure ;1 (S)]], copies = 1, reference = false, separate = true, },
              { cardID = [[07]],
                cardNickname = [[Azurite Inferno ;8 (U)]], copies = 1, reference = false, separate = true, },
              { cardID = [[08]],
                cardNickname = [[Flame Punisher ;0 (U)]], copies = 1, reference = false, separate = true, },
              { cardID = [[09]],
                cardNickname = [[Colorless Void ;9 (U)]], copies = 1, reference = true, separate = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sZjPXJK.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/BNGF6PS.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Nine the Phantom (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", cardDescription = [[Nine the Phantom (Costume: Promo Nine)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Noel Vermillion"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[NoelVermillion]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vg5c0Zr.jpg]], charCard = [[Noel Vermillion (C)]], announcement = [[† et the batte begin! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Noel Vermillion",
      Description = [[S5, Difficulty 1 (Novice)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2twnwSj.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GcXmHE7.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kPvNFZy.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TUUIySZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nfYESGn.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Spring Raid ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Type One ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Muzzle Flitter ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Assault Through ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Optic Barrel ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Zero Gun: Fenrir ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Bullet Storm ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Valkyrie Veil ;2 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xaX2NHe.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YwdPXbg.jpg]],
        altfaceURL = [[https://i.imgur.com/WO0OpUo.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/UIthatH.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Noel Vermillion (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Noel Vermillion]], position = { z = row4Z, y = characterIconY, x = column6X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Noel",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Noel Vermillion (Alternate)]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/kPvNFZy.jpg]],
            backURL = [[https://i.imgur.com/TUUIySZ.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/nfYESGn.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Spring Raid ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Type One ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Muzzle Flitter ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Assault Through ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Optic Barrel ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Zero Gun: Fenrir ;7 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Bullet Storm ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[07]],
                cardNickname = [[Valkyrie Veil ;2 (U)]], copies = 1, reference = true, separate = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rVUDvMW.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9u7r0Xr.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Noel Vermillion (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Noel Vermillion (Costume: Promo Noel)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Nu-13"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[Nu13]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bZ74m3y.jpg]], charCard = [[Nu-13 (C)]], announcement = [[† Here comes a ν challenger! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Nu-13",
      Description = [[S5, Difficulty 2* (Beginner-Friendly+)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Rs8SyvS.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tRMqjNt.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/65hJHh6.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Eex3hsR.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
      --faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/beu36BL.jpg]], -- Original card images.
      faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KxSn2uh.jpg]], -- Modified card images.
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Sword Summoner ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Supra Rage ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Sickle Storm ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Sword Dance ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Spike Chaser ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Calamity Sword ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Legacy Edge ;3 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Sword of Destruction ;5 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LUYbiX2.jpg]], -- April Fool's Exceed 2022
        altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SAGRKPf.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/R0zIrAW.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dlv9Btt.jpg]],
        altfaceURL = [[https://i.imgur.com/dk0zLEQ.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/1ZR2sr1.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Nu-13 (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Nu-13]], position = { z = row5Z, y = characterIconY, x = column5X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Nu-13",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Nu-13 (Alternate)]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/65hJHh6.jpg]],
            backURL = [[https://i.imgur.com/Eex3hsR.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]],
          --faceURL = [[https://i.imgur.com/beu36BL.jpg]], -- Original card images.
          faceURL = [[https://i.imgur.com/KxSn2uh.jpg]], -- Modified card images.
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Sword Summoner ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Supra Rage ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Sickle Storm ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Sword Dance ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Spike Chaser ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Calamity Sword ;7 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Legacy Edge ;3 (U)]], copies = 2, reference = true, },
              { cardID = [[07]],
                cardNickname = [[Sword of Destruction ;5 (U)]], copies = 1, reference = true, separate = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lRAQKgc.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/j3BWrvF.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Nu-13 (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Nu-13 (Costume: Promo Nu-13)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Platinum the Trinity"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[PlatinumtheTrinity]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PzA1Qc5.jpg]], charCard = [[Platinum the Trinity (C)]], announcement = [[† Never Sena Luna tick like this before! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Platinum the Trinity",
      Description = [[S5, Difficulty 2 (Beginner-Friendly)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ry5eOdy.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DOs35B7.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/u2BxAMk.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6VNn4SV.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/p47ivWp.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Mystique Momo ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Mami Circular ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Dramatic Sammy ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Happy Magicka ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Dream Sally ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Cure Dot Typhoon ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Miracle Jeanne ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Shining Layered Force ;5 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/C4kFSYq.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4o57Diu.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gUz4yEB.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EhEKnk3.jpg]],
        altfaceURL = [[https://i.imgur.com/KTDwMiK.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/UhaBlnt.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Platinum the Trinity (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Platinum the Trinity]], position = { z = row5Z, y = characterIconY, x = column2X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Platinum",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Platinum the Trinity (Alternate)]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/u2BxAMk.jpg]],
            backURL = [[https://i.imgur.com/6VNn4SV.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/p47ivWp.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Mystique Momo ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Mami Circular ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Dramatic Sammy ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Happy Magicka ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Dream Sally ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Cure Dot Typhoon ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Miracle Jeanne ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[07]],
                cardNickname = [[Shining Layered Force ;5 (U)]], copies = 1, reference = true, separate = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xRCE3RG.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gdL4R09.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Platinum the Trinity (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Platinum the Trinity (Costume: Promo Platinum)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Rachel Alucard"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[RachelAlucard]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AQiQAec.jpg]], charCard = [[Rachel Alucard (C)]], announcement = [[† She'll blow you away! †]], normalsScript = markerScript,
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Rachel Alucard",
      Description = [[S5, Difficulty 3* (Intermediate+)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Er7cPXF.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yp4IKcX.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nVQ7XbZ.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/25QCBuO.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ELQbQco.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Whirlwind ;6 (S)]], copies = 2, reference = true, cardScript = markerScript, },
          { cardID = [[01]],
            cardNickname = [[Flying Lobelia ;5 (S)]], copies = 2, reference = true, cardScript = markerScript, },
          { cardID = [[02]],
            cardNickname = [[Spike Drop ;5 (S)]], copies = 2, reference = true, cardScript = markerScript, },
          { cardID = [[03]],
            cardNickname = [[Tiny Lobelia ;4 (S)]], copies = 2, reference = true, cardScript = markerScript, },
          { cardID = [[04]],
            cardNickname = [[Electric Chair ;1 (S)]], copies = 2, reference = true, cardScript = markerScript, },
          { cardID = [[05]],
            cardNickname = [[Tempest Dahlia ;6 (U)]], copies = 2, reference = true, cardScript = markerScript, },
          { cardID = [[06]],
            cardNickname = [[Baden Baden Lily ;6 (U)]], copies = 2, reference = true, cardScript = markerScript, },
          { cardID = [[07]],
            cardNickname = [[Clownish Calendula ;3 (U)]], copies = 1, reference = true, separate = true, cardScript = markerScript, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3U218Px.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zxSohXx.jpg]],
        altfaceURL = [[https://i.imgur.com/E1S1iiF.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/1aQrBpj.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Rachel Alucard (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Rachel Alucard]], position = { z = row1Z, y = characterIconY, x = column3X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Rachel",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Rachel Alucard (Alternate)]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/nVQ7XbZ.jpg]],
            backURL = [[https://i.imgur.com/25QCBuO.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/ELQbQco.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Whirlwind ;6 (S)]], copies = 2, reference = true, cardScript = markerScript, },
              { cardID = [[01]],
                cardNickname = [[Flying Lobelia ;5 (S)]], copies = 2, reference = true, cardScript = markerScript, },
              { cardID = [[02]],
                cardNickname = [[Spike Drop ;5 (S)]], copies = 2, reference = true, cardScript = markerScript, },
              { cardID = [[03]],
                cardNickname = [[Tiny Lobelia ;4 (S)]], copies = 2, reference = true, cardScript = markerScript, },
              { cardID = [[04]],
                cardNickname = [[Electric Chair ;1 (S)]], copies = 2, reference = true, cardScript = markerScript, },
              { cardID = [[05]],
                cardNickname = [[Tempest Dahlia ;6 (U)]], copies = 2, reference = true, cardScript = markerScript, },
              { cardID = [[06]],
                cardNickname = [[Baden Baden Lily ;6 (U)]], copies = 2, reference = true, cardScript = markerScript, },
              { cardID = [[07]],
                cardNickname = [[Clownish Calendula ;3 (U)]], copies = 1, reference = true, separate = true, cardScript = markerScript, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qiE4eQ2.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3oTbZxw.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Rachel Alucard (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Rachel Alucard (Costume: Promo Rachel)]]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Ragna the Bloodedge"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[RagnatheBloodedge]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6aQ2YGa.jpg]], charCard = [[Ragna the Bloodedge (C)]], announcement = [[† 623C †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Ragna the Bloodedge",
      Description = [[S5, Difficulty 1 (Novice)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vEhskIU.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RIhfiyq.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/g1x76jT.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2udPstj.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HkNWjKo.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Inferno Divider ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Hell's Fang ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Dead Spike ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Gauntlet Hades ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Blood Scythe ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Devoured by Darkness ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Carnage Scissors ;3 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Black Onslaught ;6 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/trVb9Td.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/v151seD.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Wm7HWRL.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/a5Dr86J.jpg]],
        altfaceURL = [[https://i.imgur.com/VLPiMzR.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/Vqaa8kc.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Ragna the Bloodedge (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Ragna the Bloodedge]], position = { z = row2Z, y = characterIconY, x = column2X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Ragna",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Ragna the Bloodedge (Alternate)]],
        costumeDeck = {
        { deckID = [[4]],
          faceURL = [[https://i.imgur.com/g1x76jT.jpg]],
          backURL = [[https://i.imgur.com/2udPstj.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
              copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://i.imgur.com/HkNWjKo.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Inferno Divider ;7 (S)]], copies = 2, reference = true, },
            { cardID = [[01]],
              cardNickname = [[Hell's Fang ;4 (S)]], copies = 2, reference = true, },
            { cardID = [[02]],
              cardNickname = [[Dead Spike ;3 (S)]], copies = 2, reference = true, },
            { cardID = [[03]],
              cardNickname = [[Gauntlet Hades ;3 (S)]], copies = 2, reference = true, },
            { cardID = [[04]],
              cardNickname = [[Blood Scythe ;1 (S)]], copies = 2, reference = true, },
            { cardID = [[05]],
              cardNickname = [[Devoured by Darkness ;5 (U)]], copies = 2, reference = true, },
            { cardID = [[06]],
              cardNickname = [[Carnage Scissors ;3 (U)]], copies = 2, reference = true, },
            { cardID = [[07]],
              cardNickname = [[Black Onslaught ;6 (U)]], copies = 1, reference = true, separate = true, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GSwGFXj.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/efPeeqQ.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Ragna the Bloodedge (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Ragna the Bloodedge (Costume: Promo Ragna)]] },
            }, -- end cardList
          }, -- end subdeck
        }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Iron Tager"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[IronTager]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/btnZ4Ve.jpg]], charCard = [[Iron Tager (C)]], announcement = [[† He's very attractive! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Iron Tager",
      Description = [[S5, Difficulty 2 (Beginner-Friendly)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fsVLnsn.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ysnVLPr.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MpFSKSF.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cBh4Ev2.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/16EbqgS.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Gigantic Tager Driver ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Sledgehammer ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Atomic Collider ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Spark Bolt ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Crimson Punisher ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Genesic Emerald Tager Buster ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Magna Tech Wheel ;1 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[King of Tager ;0 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RiaHzTX.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3TLUXdM.jpg]], -- April Fool's Exceed 2022
        --faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xZRT5Yb.jpg]], -- Original card image for Tager's Normal Mode.
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PBwxSLn.jpg]], -- Modified card image for Tager's Normal Mode.
        --backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/C4fpeG6.jpg]], -- Original card image for Tager's Exceed Mode.
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dRjM0tN.jpg]], -- Modified card image for Tager's Exceed Mode.
        altfaceURL = [[https://i.imgur.com/teZXI2k.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/kBv8ipC.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Iron Tager (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Iron Tager]], position = { z = row2Z, y = characterIconY, x = column1X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Tager",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Iron Tager (Alternate)]],
        costumeDeck = {
        { deckID = [[4]],
          faceURL = [[https://i.imgur.com/MpFSKSF.jpg]],
          backURL = [[https://i.imgur.com/cBh4Ev2.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
              copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://i.imgur.com/16EbqgS.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Gigantic Tager Driver ;5 (S)]], copies = 2, reference = true, },
            { cardID = [[01]],
              cardNickname = [[Sledgehammer ;4 (S)]], copies = 2, reference = true, },
            { cardID = [[02]],
              cardNickname = [[Atomic Collider ;3 (S)]], copies = 2, reference = true, },
            { cardID = [[03]],
              cardNickname = [[Spark Bolt ;1 (S)]], copies = 2, reference = true, },
            { cardID = [[04]],
              cardNickname = [[Crimson Punisher ;1 (S)]], copies = 2, reference = true, },
            { cardID = [[05]],
              cardNickname = [[Genesic Emerald Tager Buster ;6 (U)]], copies = 2, reference = true, },
            { cardID = [[06]],
              cardNickname = [[Magna Tech Wheel ;1 (U)]], copies = 2, reference = true, },
            { cardID = [[07]],
              cardNickname = [[King of Tager ;0 (U)]], copies = 1, reference = true, separate = true, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pricTwf.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OLPom1L.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Iron Tager (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Iron Tager (Costume: Promo Tager))]] },
            }, -- end cardList
          }, -- end subdeck
        }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Taokaka"] = { panelGUID = [[0e101c]], season = [[5]], borderColor = { 0, 0, 255/255, 1}, legal = seasonLegal, assetName = [[Taokaka]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CDi8p96.jpg]], charCard = [[Taokaka (C)]], announcement = [[† Squigly justice tackle! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Taokaka",
      Description = [[S5, Difficulty 2 (Beginner-Friendly)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xNNXSb6.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VE5N2hx.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8wsBsNX.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Zfe0erU.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KT0MIo1.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Cat Spirit One! ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Kitty Litter Special! ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Double Paw Strike! ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Slashy Slashy! ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Trick Edge! ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Hexa Edge! ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Imma Beat the Crap Outta You! ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Attack Meow Pow! ;5 (U)]], copies = 1, reference = true, separate = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cWqtQW7.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OVFM7Nv.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ipSpJeW.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JjSuY2N.jpg]],
        altfaceURL = [[https://i.imgur.com/6BMkhlO.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/H1oSEKe.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Taokaka (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Taokaka]], position = { z = row1Z, y = characterIconY, x = column2X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Promo Taokaka",
        costumeDescription = [[Thanks to Moriatti and Petersonian for ideas, frames, and assets!]],
        costumeNormals = [[Taokaka (Alternate)]],
        costumeDeck = {
        { deckID = [[4]],
          faceURL = [[https://i.imgur.com/8wsBsNX.jpg]],
          backURL = [[https://i.imgur.com/Zfe0erU.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: Astral Heat & Overdrive (C)]],
              copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://i.imgur.com/KT0MIo1.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Cat Spirit One! ;6 (S)]], copies = 2, reference = true, },
            { cardID = [[01]],
              cardNickname = [[Kitty Litter Special! ;5 (S)]], copies = 2, reference = true, },
            { cardID = [[02]],
              cardNickname = [[Double Paw Strike! ;5 (S)]], copies = 2, reference = true, },
            { cardID = [[03]],
              cardNickname = [[Slashy Slashy! ;3 (S)]], copies = 2, reference = true, },
            { cardID = [[04]],
              cardNickname = [[Trick Edge! ;3 (S)]], copies = 2, reference = true, },
            { cardID = [[05]],
              cardNickname = [[Hexa Edge! ;7 (U)]], copies = 2, reference = true, },
            { cardID = [[06]],
              cardNickname = [[Imma Beat the Crap Outta You! ;4 (U)]], copies = 2, reference = true, },
            { cardID = [[07]],
              cardNickname = [[Attack Meow Pow! ;5 (U)]], copies = 1, reference = true, separate = true, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tdy7Wuz.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qKltbj1.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Taokaka (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Taokaka (Costume: Promo Taokaka)]]},
            }, -- end cardList
          }, -- end subdeck
        }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  -- end charTable entries



  local blankTooltip = [[
.............
.           .
.           .
.............]]
  imageFactor1 = 1 -- multiplied by position.x to generate first value in the UI element position string
  imageFactor2 = 1 -- multiplied by position.z to generate second value in the UI element position string
  imageFactor3 = 1 -- multiplied by position.y to generate third value in the UI element position string
  btnFactor1 = characterStation.getVar("btnFactor1") -- multiplied by position.x to set X value for decorative buttons
  btnFactor2 = characterStation.getVar("btnFactor2")   -- multiplied by position.y to set Y value for decorative buttons
  btnFactor3 = characterStation.getVar("btnFactor3") -- multiplied by position.z to set Z value for decorative buttons

  --debugLog{"imageFactor1: "..imageFactor1, 3}
  --debugLog{"imageFactor2: "..imageFactor2, 3}
  --debugLog{"imageFactor3: "..imageFactor3, 3}

  -- UI elements are fully transparent by default. The "hover image" is actually a tooltip.
  local transparencyValue = 0
  if Global.getVar("debugFlag") == true and Global.getVar("debugLevel") >= 2 then
    transparencyValue = 0.5
  end

  myXmlTable = {}

  -- This table is traversed in order to determine element draw order (i.e., images with greater indices are drawn on top of those with lesser indices).
  systemElements = {
    {
      id = "Season 5 Base",
      image = "RosterS5",
      active = true,
      height = 200,
      width = 200,
      position = { x = 0, z = 0, y = 10, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 1, g = 1, b = 1, a = 1 },
      clickable = "false",
      --onClick = self.getGUID().."/uiClick_SelectNormals",
      --hoverImage = "",
      hoverColor = { r = 1, g = 1, b = 1, a = 0, },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
    {
      id = "Random5",
      tooltip = [[Random
Season 5]],
      active = true,
      height = iconSize,
      width = iconSize,
      position = { x = column4X, z = row3Z, y = characterIconY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 0, g = 1, b = 0, a = transparencyValue },
      clickable = "true",
      onClick = self.getGUID().."/uiClick_Random",
      --[[ 2023-08-19: Disabling hover images to attempt to improve load times.
      hoverTooltip = blankTooltip,
      hoverImage = "RandomS5",
      hoverColor = { r = 1, g = 1, b = 1, a = 1, },
      --]]
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
  }

  playerToggleStartIndex = (#systemElements + 1) -- This only works on integer keys

  -- [=[

  -- Register all the Normals in Character Station.
  for normalsName,normalsTable in pairs(normalsSheets) do
    debugLog{"normalsName (registration call, Character Station): "..normalsName, 1}
    local supportedNormals = {}
    for thisSet,setTable in pairs(normalsTable) do
      supportedNormals[thisSet] = true
    end
    local toggleID = nil
    if normalsName == normalsToggleName then
      toggleID = [[Normals Toggle: ]]..normalsName
    end
    -- [=[ Uncomment for remote execution.
    characterStation.call("registerNormals", {
      normalsName = normalsName,
      ownerGUID = self.getGUID(),
      sets = supportedNormals,
      toggleID = toggleID,
    }) --]=]
    --[=[ Uncomment for local execution.
    registerNormals({
      normalsName = normalsName,
      ownerGUID = myGUID,
      sets = supportedNormals
    }) --]=]
  end -- Finish registering Normals.

  -- Register all the charTable entries in Character Station.
  for charName,thisChar in pairs(charTable) do
    debugLog{ "Roster S5, per-char loop: "..charName, 2, {1,1,1} }

    local seasons = { thisChar.season, }
    if not thisChar.excludeFromRandomAny == true then table.insert(seasons, "Any") end
    if thisChar.legal == true then table.insert(seasons, "Legal") end

    debugLog{"about to register character: "..charName, 0}
    debugLog{" season: "..thisChar.season, 1}
    characterStation.call("registerCharacter", {
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
    debugLog{ "borderColorString: "..borderColorString, 3}

    -- If there's a position for the UI element, actually set up and insert the UI element.
    if thisChar.position != nil then
      debugLog{"inserting systemElement entry for character "..charName, 3}
      -- Insert an entry for this character into the table of buttons to be created later.
      --[=[
      table.insert(systemElements, {
        position = {
          x = thisChar.position.x,
          y = thisChar.position.y,
          z = thisChar.position.z,
        },
        tooltip = charName,
      })
      --]=]

      -- Determine this UI element's position string.
      local positionTable = {
        x = imageFactor1*thisChar.position.x,
        z = imageFactor2*thisChar.position.z,
        y = imageFactor3*thisChar.position.y,
      }

      -- If this character's tooltip backdrop should be different from usual, use it instead of the blank backdrop.
      local thisTooltip = thisChar.assetTooltip or blankTooltip

      if Global.getVar("debugFlag") == true and Global.getVar("debugLevel") >= 3 then
        transparencyValue = 0.5
      end

      -- Insert the element into the table.
      --debugLog{ "inserting XML for: "..thisChar.assetName, 1, {0,1,1} }
      table.insert(systemElements, {-- Image element.
        id = charName,
        active = true,
        height = iconSize,
        width = iconSize,
        position = positionTable,
        rotation = { x = 0, y = 0, z = 0, },
        color = { r = 0.9, g = 0.9, b = 1, a = transparencyValue, }, -- Fully transparent by default. Change this to debug element positions.
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
    end
  end -- Finish looping through charTable.
  debugLog{"finished looping through charTable", 3, {1,1,1}}

  debugLog{"beginning loop through systemElements", 3, {1,1,1}}
  for drawOrder,thisElement in ipairs(systemElements) do
    debugLog{"thisElement.id: "..thisElement.id, 5}
    --debugLog{"  thisElement.position: "..thisElement.position.x.." "..thisElement.position.z.." "..thisElement.position.y, 2}
    --if thisElement.image != nil then debugLog{"  thisElement.image: "..thisElement.image, 2} end
    --debugLog{"  thisElement.height: "..thisElement.height, 2}
    --debugLog{"  thisElement.width: "..thisElement.width, 2}
    --if thisElement.color != nil then debugLog{"  image color: ".."rgba("..thisElement.color.r..","..thisElement.color.g..","..thisElement.color.b..","..thisElement.color.a..")", 2} end
    --if thisElement.hoverImage != nil then debugLog{"  thisElement.hoverImage: "..thisElement.hoverImage, 2} end
    --if thisElement.hoverColor != nil then debugLog{"  thisElement.hoverColor: ".."rgba("..thisElement.hoverColor.r..","..thisElement.hoverColor.g..","..thisElement.hoverColor.b..","..thisElement.hoverColor.a..")", 2} end
    --if thisElement.onClick != nil then debugLog{"  thisElement.onClick: "..thisElement.onClick, 2} end
    table.insert(myXmlTable, {-- Image element.
      tag = "Image",
      attributes = {
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
        --[[ 2023-08-19: Disabling hover images to attempt to improve load times.
        tooltip = thisElement.hoverTooltip,
        tooltipTextColor = "rgba(1,1,1,0)",
        tooltipBorderColor = "rgba(0,0,0,0)",
        tooltipBackgroundColor = "rgba("..thisElement.hoverColor.r..","..thisElement.hoverColor.g..","..thisElement.hoverColor.b..","..thisElement.hoverColor.a..")",
        tooltipBackgroundImage = thisElement.hoverImage,
        tooltipPosition = "Above",
        tooltipOffset = "-45",
        --]]
        visibility = thisElement.visibilityString,
      }, -- end attributes for Image
    })

    if thisElement.tooltip != nil then debugLog{"  thisElement.tooltip: "..thisElement.tooltip, 5} end

    if Global.getVar("debugFlag") == true and Global.getVar("debugLevel") >= 5 then
      transparencyValue = 0.4
    else
      transparencyValue = 0
    end

    -- If applicable, create a decorative button to make the text tooltip show up properly.
    debugLog{"  attempting to create decorative button", 5}
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

  panelToggleOffXml = {--Toggle element.
    tag = "ToggleButton",
      attributes = {
        id = [[TogglePanelOff]]..self.getGUID(),
        --colors = [[doesn't do anything | mouseover color | clicking color | ???]],
        colors = [[rgba(0,0,0,0.1)|rgba(0.5,0.5,1,1)|rgba(0.7,0.7,0.7,0.9)]], -- Applied on top of the background color, for some reason.
        color = [[rgba(0,0,1,1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS5Icon",
        selectedIconColor = [[rgba(1,1,1,1)]], -- Discovered by implication of the attribute below.
        deselectedIconColor = [[rgba(1,1,1,1)]], -- This is an undocumented attribute discovered by user Mervil#2137 on 2021-08-18.
        visibility = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black]],
      }, -- end attributes for Toggle
    } -- end Toggle
  panelToggleOnXml = {--Toggle element.
    tag = "ToggleButton",
      attributes = {
        id = [[TogglePanelOn]]..self.getGUID(),
        --colors = [[doesn't do anything | mouseover color | clicking color | ???]],
        colors = [[rgba(0,0,0,0.1)|rgba(0,0,0.5,1)|rgba(0,0,1,1)]], -- Applied on top of the background color, for some reason.
        color = [[rgba(1,1,1,0.1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS5Icon",
        selectedIconColor = [[rgba(1,1,1,1)]], -- Discovered by implication of the attribute below.
        deselectedIconColor = [[rgba(1,1,1,1)]], -- This is an undocumented attribute discovered by user Mervil#2137 on 2021-08-18.
        visibility = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black]],
      }, -- end attributes for Toggle
    } -- end Toggle
  table.insert(myXmlTable, panelToggleOffXml)
  self.createButton({
      click_function = 'click_Button',
      function_owner = self,
      width          = togglePanelSize,
      height         = togglePanelSize,
      color          = {0.2, 1, 1, 0},
      position       = {
        x = tonumber(togglePanelX)*btnFactor1,
        y = tonumber(togglePanelY)*btnFactor2,
        z = tonumber(togglePanelZ)*btnFactor3,
      },
      tooltip        = [[Disable Season]],
  })
  --]=]

  -- Loop through players to set up Normals toggle(s).
  playerToggleStartIndex = (#myXmlTable + 1) -- This only works on integer keys
  for i,thisPlayer in ipairs(allPlayers) do

    local colorString = [[#FFFFFF|]]..thisPlayer..[[|#C8C8C8]]

    table.insert(myXmlTable, {
      tag = "Toggle",
      attributes = {
        id = thisPlayer..[[ Normals Toggle: ]]..normalsToggleName,
        colors = colorString,
        isOn = false,
        onClick = self.getGUID().."/uiClick_NormalsToggle",
        position = normalsToggleX.." "..normalsToggleZ.." "..normalsToggleY,
        scale = 0.5,
        visibility = thisPlayer,
      }, -- end attributes for Toggle
    }) -- end Toggle

    self.createButton({
        click_function = 'click_Button',
        function_owner = self,
        width          = normalsToggleSize,
        height         = normalsToggleSize,
        color          = {0.2, 1, 1, 0},
        position       = {
          x = tonumber(normalsToggleX)*btnFactor1,
          y = tonumber(normalsToggleY)*btnFactor2,
          z = tonumber(normalsToggleZ)*btnFactor3,
        },
        tooltip        = normalsToggleName..[[

Normals]],
    })
  end -- finish looping through players

  self.UI.setXmlTable(myXmlTable)

  -- This prevents the panel from being unlocked or alt-zoomed.
  if Global.getVar("debugFlag") != true then
    self.interactable = false
  end

end -- end setup



-- This is a dead function. It exists to catch clicks we don't want to do anything.
function click_Button(player, value, id)
end



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



function getDeck(charName)
  --local charName = params[1]
  --debugLog{ " getDeck run for "..charName, 2, {1, 1, 0} }
  return charTable[charName].deck
end



--[=[ Sometimes, when players connect, the UI doesn't load properly.
This may be more of an issue with Classic UI than XML UI - it's been hard to confirm consistently.
Any issues with XML UI can be fixed by forcibly reloading the UI.
The performance hit from doing this is surprisingly low.
Attempting to do this in onPlayerConnect didn't consistently fix the issue
  (probably because the UI hadn't actually loaded yet for them).
Putting the logic in onPlayerChangeColor does seem to fix the issue.
--]=]
function onPlayerChangeColor(player_color)
  local finishedSetup = characterStation.getVar("finishedSetup")
  if player_color != "Grey" and player_color != "Black" and finishedSetup == true then
    local reloadXml = self.UI.getXmlTable()
    self.UI.setXmlTable(reloadXml)
  end
end -- end onPlayerChangeColor
--]=]



function togglePanel(newMode)
  if newMode == nil then
    newMode = isHidden
  end

  if newMode == true then debugLog{"togglePanel, setting to true", 2}
  else debugLog{"togglePanel, setting to false", 2} end

  if newMode == false and isHidden == false then

    -- Hide UI.
    debugLog{"   hiding UI", 3, {0.7,0.7,0.7}}

    -- Disable and recolor player toggles on this object's UI.
    myXmlTable = self.UI.getXmlTable()
    local currentToggleIndex = playerToggleStartIndex
    for i,thisPlayer in ipairs(allPlayers) do
      local colorString = [[#FFFFFF|]]..thisPlayer..[[|#C8C8C8]]
      myXmlTable[currentToggleIndex].attributes.isOn = false
      myXmlTable[currentToggleIndex].attributes.colors = colorString
      currentToggleIndex = currentToggleIndex+1
    end

    self.UI.setXmlTable({ panelToggleOnXml })
    isHidden = true
    self.attachInvisibleHider(self.getGUID(), true, allPlayers)

    -- Deactivate panel.
    characterStation.call("setPanelState", { ownerGUID = self.getGUID(), state = false, })

  elseif newMode == true and isHidden == true then

    -- Show UI.
    debugLog{"   showing UI", 3, {1,1,1}}

    local currentToggleIndex = playerToggleStartIndex
    for i,thisPlayer in ipairs(allPlayers) do

      local invertColor = Color[thisPlayer]
      invertColor = {
        r = 1-invertColor[1],
        g = 1-invertColor[2],
        b = 1-invertColor[3],
        a = 1,}
      local invertColorString = "rgba("..invertColor.r..","..invertColor.g..","..invertColor.b..","..invertColor.a..")"
      --debugLog{ "invertColor: "..invertColorString, 5}

      local unselectedColorString = [[#FFFFFF|]]..thisPlayer..[[|#C8C8C8]]
      local selectedColorString = thisPlayer..[[|]]..thisPlayer..[[|#C8C8C8]]

      local playerCurrentNormals = characterStation.call("getCurrentNormals", { playerColor = thisPlayer, })
      local playerCurrentNormalsBase = playerCurrentNormals

      -- If the specified Normals already have the alternate suffix, determine the base.
      if string.sub(playerCurrentNormals, -12) == [[ (Alternate)]] then
        selectedColorString = invertColorString..[[|]]..invertColorString..[[|]]..[[|#C8C8C8]]
        playerCurrentNormalsBase = string.sub(playerCurrentNormals, 1, (string.len(playerCurrentNormals)-12))
      end

      if myXmlTable[currentToggleIndex].attributes.id == thisPlayer..[[ Normals Toggle: ]]..playerCurrentNormalsBase then
        debugLog{"player "..thisPlayer.." found to be using <"..playerCurrentNormals..">, matching toggleID at index "..currentToggleIndex, 3, {0.3,1,0.7}}
        myXmlTable[currentToggleIndex].attributes.isOn = true
        myXmlTable[currentToggleIndex].attributes.colors = selectedColorString
      else
        myXmlTable[currentToggleIndex].attributes.isOn = false
        myXmlTable[currentToggleIndex].attributes.colors = unselectedColorString
      end
      currentToggleIndex = currentToggleIndex+1
    end -- finish looping through players

    self.UI.setXmlTable(myXmlTable)
    isHidden = false
    self.attachInvisibleHider(self.getGUID(), false, allPlayers)

    -- Reactivate panel.
    characterStation.call("setPanelState", { ownerGUID = self.getGUID(), state = true, })
  end
end -- end togglePanel



function uiClick_Character(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end
  if player.color == [[Grey]] then
    player.broadcast([[Spectators cannot spawn characters.]])
    return
  end

  --debugLog{ "uiClick_Character clicked by "..player.color, 0 }
  --debugLog{ "   value: "..value, 3 }
  --debugLog{ "      id: "..id, 3 }
  --local clickedObject = getObjectFromGUID(id)
  local deckList = getDeck(id)

  -- If NOT clicked with the left mouse button, alternate mode is on.
  local alternate = false
  if value != "-1" then
    --debugLog{ "   alternate mode is on", 1, {0, 1, 1} }
    alternate = true
  end

  characterStation.call("spawnDeck", {
    characterName = id,
    ownerGUID = self.getGUID(),
    deckList = deckList,
    playerColor = player.color,
    alternate = alternate })
end -- end uiClick_Character



function uiClick_NormalsToggle(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end

  local alternate = false
  if value != [[-1]] then alternate = true end

  debugLog{self.getGUID()..[[ ran uiClick_NormalsToggle]], 2}
  debugLog{"   player: "..player.color, 5}
  debugLog{"   value: "..value, 5}
  debugLog{"   id: "..id, 5}

  --[=[ Uncomment for local execution.
  normalsToggleClick({
    playerColor = player.color,
    alternate = alternate,
    toggleID = id,
  })
  --]=]
  -- [=[ Uncomment for remote execution.
  characterStation.call("normalsToggleClick", {
    alternate = alternate,
    ownerGUID = self.getGUID(),
    playerColor = player.color,
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

  local season = id

  -- If NOT clicked with the left mouse button, alternate mode is on.
  local alternate = false
  if value != "-1" then
    --debugLog{ "   alternate mode is on", 1, {0, 1, 1} }
    alternate = true
  end

  characterStation.call("spawnRandomCharacter", {
    season = season,
    playerColor = player.color,
    alternate = alternate,
  })
  --debugLog{ "uiClick_Random clicked by "..player.color, 0 }
  --debugLog{ "   value: "..value, 3 }
  --debugLog{ "      id: "..id, 3 }
  --local clickedObject = getObjectFromGUID('4c8428')
  --local deckList, deckNickname = getRandomDeck(id, player)
  --debugLog{ "   deckNickname: "..deckNickname, 1, { 1, 1, 0 } }

  --spawnDeck({ deckName = deckNickname, deckList = deckList, player = player, alternate = alternate })
end -- end uiClick_Random



function uiClick_TogglePanel(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end
  if player.color == [[Grey]] then
    player.broadcast([[Spectators cannot toggle roster panels.]])
    return
  end
  togglePanel()
end -- end uiClick_TogglePanel