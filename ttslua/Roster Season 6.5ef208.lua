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
  normalsToggleName = "Under Night (Diverse)"

  normalsSheets = {}
  normalsSheets["Under Night (Diverse)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Byakuya"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TeKA9b1.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Carmine"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JgxAZ44.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Chaos"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sHisRSq.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Enkidu"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CN2Ueqn.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Gordeau"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ATF1pkD.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Hilda"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YY6AXM9.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Hyde"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/o3x2gNh.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Linne"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XghvueQ.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Londrekia"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/f47RNi4.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Merkava"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GUU6Uo1.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Mika"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fqFOvhE.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Nanase"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Zs2cqmO.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Orie"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GcwlsFA.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Phonon"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nbN8sAO.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Seth"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wEc2Ai6.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Vatista"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iJ2OqiY.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Wagner"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IuJADfQ.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Definitely Wagner"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CavMKWA.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Waldstein"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/woderwW.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Yuzuriha"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4MA79SP.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Three Precept Enkidu"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/VnB5fWe.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]

  -- Instead of individualized alternate sets, they use the diverse set.
  normalsSheets["Byakuya (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Carmine (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Chaos (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Enkidu (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Gordeau (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Hilda (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Hyde (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Linne (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Londrekia (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Merkava (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Mika (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Nanase (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Orie (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Phonon (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Seth (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Vatista (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Wagner (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Waldstein (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Yuzuriha (Alternate)"] = { UNNormals = { suffix = [[ (UN)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/tEH1XTf.jpg",
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

  local row1Z = 10
  local row2Z = -14
  local column1X = -120.5
  local column2X = -96.4
  local column3X = -72.3
  local column4X = -48.2
  local column5X = -24.1
  local column6X = 0
  local column7X = 24.1
  local column8X = 48.2
  local column9X = 72.3
  local column10X = 96.4
  local column11X = 120.5
  local characterIconY = -100

  local iconSize = 23
  local btnScale = 115

  local togglePanelX = 0
  local togglePanelZ = 33
  local togglePanelY = -100

  local togglePanelSize = 60

  local normalsToggleX = 0
  local normalsToggleZ = -33
  local normalsToggleY = -80

  local normalsToggleSize = 50

  charTable = {}
  -- Season 6: Under Night
  -- Hilda:   { z = -6.165, y = 0.6, x = 19.94 }
  -- Phonon:  { z = -6.165, y = 0.6, x = 21.78 }
  -- Nanase:  { z = -6.165, y = 0.6, x = 23.62 }
  -- Merkava: { z = -4.335, y = 0.6, x = 19.94 }
  -- Orie:    { z = -4.335, y = 0.6, x = 21.78 }
  -- Seth:    { z = -4.335, y = 0.6, x = 23.62 }
  -- Wagner:  { z = -2.505, y = 0.6, x = 19.94 }
  -- Hyde:    { z = -2.505, y = 0.6, x = 21.78 }
  -- Waldo:   { z = -2.505, y = 0.6, x = 23.62 }
  -- Lonny:   { z = -0.675, y = 0.6, x = 20.86 }
  -- Random:  { z = -0.675, y = 0.6, x = 22.70 }
  -- Enkidu:  { z = 1.155, y = 0.6, x = 19.94 }
  -- Linne:   { z = 1.155, y = 0.6, x = 21.78 }
  -- Carmine: { z = 1.155, y = 0.6, x = 23.62 }
  -- Vatista: { z = 2.985, y = 0.6, x = 19.94 }
  -- Gordeau: { z = 2.985, y = 0.6, x = 21.78 }
  -- Yuzu:    { z = 2.985, y = 0.6, x = 23.62 }
  -- Chaos:   { z = 4.815, y = 0.6, x = 19.94 }
  -- Mika:    { z = 4.815, y = 0.6, x = 21.78 }
  -- Byakuya: { z = 4.815, y = 0.6, x = 23.62 }
  -- moving right: x + 1.84
  -- moving left: x - 1.84
  -- moving up: z - 1.83
  -- moving down: z + 1.83

  charTable["Byakuya"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Byakuya]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rOrjCG8.jpg]], charCard = [[Byakuya (C)]], announcementList = {
      [[† They nest. The web will lure and consume any prey that goes near. They fight - he, for her,
and her for herself. Her feelings point in one direction, to a friend defeated. She sips on
blood and mud alike, chasing a shadow. His eight legs will crawl through the night once
more, carrying with him her feelings. †]],
      [[† He does whatever a spider can! †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Byakuya",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2BFOAYT.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0O1W85b.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hvags5p.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Iy7LFaM.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Caught You! ;8 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Minced? ;7 (S)]], copies = 4, reference = true, },
          { cardID = [[02]],
            cardNickname = [[How Shall I Cook You? ;5 (S)]], copies = 4, reference = true, },
          { cardID = [[03]],
            cardNickname = [[I'll Plant It Somewhere Over Here ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Or... Shredded? ;3 (S)]], copies = 4, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Become a Part of Me ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Endless Nightmtare ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ixoYKjN.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/FaOpnrM.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IiEDUD8.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XC42jZM.jpg]],
        altfaceURL = [[https://i.imgur.com/WapZiwg.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/3C3V4D5.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Byakuya (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Byakuya]], position = { z = row1Z, y = characterIconY, x = column10X, }, }
-- Byakuya: { z = 4.815, y = 0.6, x = 23.62 }

  charTable["Carmine"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = false, assetName = [[Carmine]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KHXP54G.jpg]], charCard = [[Carmine (C)]], announcementList = {
      [[† He hungers. His body drenched in blood thirsts for more, but nothing can satiate his desire
for violence. He must show that none are more powerful than he. His fangs and claws
pierce his enemies in their entirety. Still, he cannot let his blood go
dry and he hunts for more prey to satisfy his lust. †]],
      [[† Like if you went to hell, and it was full of blood, and that blood was on fire, and
it was raining blood, then maybe that would be enough blood! Eh... but probably not. †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Carmine",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bABsozh.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ad3Fdw4.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cI7ZbqC.jpg]], -- Replaced for April Fool's Exceed 2023.
        --faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mIRPccs.jpg]],
        --altfaceURL = [[https://i.imgur.com/cI7ZbqC.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Thrust! ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Spin! ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Pulverize! ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Give Me That! ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Twist! ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Hahahaha! Be Devoured! ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[You ****! This is the END! ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/5Koj3Wj.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OtDacWM.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yXiZkz4.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2wrKYg6.jpg]],
        altfaceURL = [[https://i.imgur.com/rIXUPS8.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/Gxirmry.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Carmine (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Carmine]], position = { z = row1Z, y = characterIconY, x = column8X, }, }

  charTable["Chaos"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Chaos]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/l6VQp5s.jpg]], charCard = [[Chaos (C)]], announcementList = {
      [[† He schemes. Staring down his opponents from behind his glasses. He keeps a beast within
and a book filled with nothing but chaos. He awaits the chance to unleash his power. The
desire to find his beloved friend and a comrade who tries to stop him. But which he was
going to pick was obvious... The beast shows its fangs, crushing anything it finds in its path. †]],
      [[† Why do all the Final Fantasy fans want him dead? †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Chaos",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/o3tnyGz.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YMeTIou.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Dwm7BOa.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Cold Reflection ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Spew Out ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Repel ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Conceal ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[That's Your Prey ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Dissect Barrage ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Deep Revenance ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZUP64sa.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tb6U6CG.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/93WAKzd.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/l3CD5kX.jpg]],
        altfaceURL = [[https://i.imgur.com/8D6tXNb.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/A6Y8Kwp.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Chaos (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Chaos]], position = { z = row1Z, y = characterIconY, x = column2X, }, }
-- Chaos: { z = 4.815, y = 0.6, x = 19.94 }

  charTable["Enkidu"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Enkidu]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/t1HaZBs.jpg]], charCard = [[Enkidu (C)]], announcementList = {
      [[† He suffers. Both what he seeks and the path he takes are born of desperation. His body
shows no change as he searches for worthy adversaries, treading the path to creatures
of far greater power. His well-trained fists smite darkness and in his name resounds
calamity. All for the sake of fulfilling his promise to a long-lost friend. †]],
      [[† Do you even lift, bro? †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Enkidu",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XU9MLKv.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WeGYkh4.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LrRGN4O.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Tidal Spin ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Three Precept Strike ;5 (S)]], copies = 6, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Chained Kick ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Gale Edge ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Thunder Stomp ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Spiral Dual Palm Strike ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Demon Seal: Abyssal Force ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4XalT8B.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/X96Gty6.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/BYIV07o.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/r9gIBYt.jpg]],
        altfaceURL = [[https://i.imgur.com/ojNCpnJ.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/IGUbTjd.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Enkidu (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Enkidu]], position = { z = row2Z, y = characterIconY, x = column7X, }, }

  charTable["Gordeau"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Gordeau]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qlN4UaJ.jpg]], charCard = [[Gordeau (C)]], announcementList = {
      [[† He reaps. He slashes his enemies to satisfy, but it is not enough - he wishes to reunite
with an old friend and offer a souvenir. The land is vast, expanding
as far as the eye can see. The sky, without boundaries, no ceiling. He raises his sickle
and prepares for the Night. †]],
      [[† Vladimir and Estragon can stop waiting! †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Gordeau",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/j5lli2p.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uNpvir1.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gnlJbET.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Mortal Glide ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Precise Aim ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Mortal Slide ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Grim Reaper ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Rusty Nail ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Soul Exodus ;5 (U)]], copies = 1, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Turbulence ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ljCiN54.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GJmkTfH.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/v0xz0uH.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yBcoxYs.jpg]],
        altfaceURL = [[https://i.imgur.com/0G0i43L.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/nOlr6P8.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Gordeau (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Gordeau]], position = { z = row1Z, y = characterIconY, x = column3X, }, }

  charTable["Hilda"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Hilda]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8rpXRgc.jpg]], charCard = [[Hilda (C)]], announcementList = {
      [[† She savors. She wields her power for a single purpose. Light and Dark, the contradiction
that exists inside of her. A helix of contradiction and chaos with no order. Darkness
that covers the eyes. A voice that comes from deep within the earth. The false eyes chase
after eternity and she wishes for Re-birth. †]],
      [[† If she doesn't scare you / No evil thing will
To see her is to / Take a sudden chill †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Hilda",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Mvj6t9u.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YvKRmv8.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ayTPW2v.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Skewer ;6 (S)]], copies = 4, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Tri-Furket ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Revenant Pillar ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Interference ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Condensity Gloom ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[In The Darkness ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Impalement ;6 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tSUqPdV.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ytneArp.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jy7YiIL.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bjIGZNF.jpg]],
        altfaceURL = [[https://i.imgur.com/5qefNNM.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/9AeTi2c.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Hilda (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Hilda]], position = { z = row2Z, y = characterIconY, x = column2X, }, }

    charTable["Hyde"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Hyde]],
      attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/k7KiFGI.jpg]], charCard = [[Hyde (C)]], announcementList = {
        [[† He awakens. In order to free the girl from the chains of eternity that seal her fate. The
power burning within him is the "Void". The blade he carries, the Insulator. Each day became
lost in a sea of banality, living under the threat of the Night. The Hollow Night approaches
and where reality and fantasy meet, this young boy takes a stand... to reclaim everything
and return it to nothingness. †]],
        [[† you can't run but you can Hyde †]]},
      referenceChip = { Name = "Custom_Tile",
        Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
        Nickname = "Hyde",
        Description = "S6",
        CustomImage = {
          ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/d12OqO4.jpg]],
          ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XBleVPY.jpg]],
          CustomTile = { Thickness = 0.1, Stretch = true, }
        }
      },
      deck = {
        { deckID = [[4]],
          faceURL = [[https://i.imgur.com/hvags5p.jpg]],
          backURL = [[https://i.imgur.com/222sGfm.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
              copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[2]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/f3ihDIl.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Vacant Shift ;6 (S)]], copies = 2, reference = true, },
            { cardID = [[01]],
              cardNickname = [[Red-Clad Craver ;5 (S)]], copies = 3, reference = true, },
            { cardID = [[02]],
              cardNickname = [[Black Orbiter ;4 (S)]], copies = 2, reference = true, },
            { cardID = [[03]],
              cardNickname = [[Pale Bringer ;4 (S)]], copies = 3, reference = true, },
            { cardID = [[04]],
              cardNickname = [[Shadow Scare ;3 (S)]], copies = 2, reference = true, },
            { cardID = [[05]],
              cardNickname = [[Gyro Vortex ;5 (U)]], copies = 2, reference = true, },
            { cardID = [[06]],
              cardNickname = [[Dead Set Daze ;2 (U)]], copies = 2, reference = true, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bjopf7W.jpg]], -- April Fool's Exceed 2022
          --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xoZvSFD.jpg]], -- April Fool's Exceed 2022
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/POyXL4D.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fjMYSwU.jpg]],
          altfaceURL = [[https://i.imgur.com/gS1Fkwv.png]], -- April Fool's Exceed 2023
          altbackURL = [[https://i.imgur.com/7Kr659a.png]], -- April Fool's Exceed 2023
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Hyde (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
            }, -- end cardList
          }, -- end subdeck
      }, normalsSet = [[UNNormals]], normals = [[Hyde]], position = { z = row1Z, y = characterIconY, x = column5X, }, }

  charTable["Linne"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Linne]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ep7tPr7.jpg]], charCard = [[Linne (C)]], announcementList = {
      [[† She repeats. To unearth the truth behind her eternity and settle a score with her brother.
The sword she sought and the encounter with its wielder... Therein lies the path that will
change her fate. The rusty cogs begin to turn once more, their ripples
beckoning her to the end of her tale. †]],
      [[† this is where I draw the Linne †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Linne",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/D0O8g3C.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/eqUDgzU.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
    { deckID = [[4]],
      faceURL = [[https://i.imgur.com/hvags5p.jpg]],
      backURL = [[https://i.imgur.com/222sGfm.jpg]],
      gridWidth = 1, gridHeight = 1,
      hiddenBack = false,
      cardList = { { cardID = [[00]],
          cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
          copies = 0, reference = true, separate = false, },
        }, -- end cardList
      }, -- end subdeck
    { deckID = [[2]],
      faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TLK2O6L.jpg]],
      gridWidth = 4, gridHeight = 2,
      hiddenBack = true,
      cardList = { { cardID = [[00]],
          cardNickname = [[Moon Gyre ;5 (S)]], copies = 2, reference = true, },
        { cardID = [[01]],
          cardNickname = [[Tenacious Mist ;5 (S)]], copies = 2, reference = true, },
        { cardID = [[02]],
          cardNickname = [[Sky Fangs ;4 (S)]], copies = 2, reference = true, },
        { cardID = [[03]],
          cardNickname = [[Flying Swallow ;4 (S)]], copies = 2, reference = true, },
        { cardID = [[04]],
          cardNickname = [[Divine Blaze ;6 (U)]], copies = 2, reference = true, },
        { cardID = [[05]],
          cardNickname = [[Elusive Flash ;4 (U)]], copies = 2, reference = true, },
        { cardID = [[06]],
          cardNickname = [[The Diviner ;3 (U)]], copies = 2, reference = true, },
        }, -- end cardList
      }, -- end subdeck 2
    { deckID = [[3]],
      --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ucAwkTg.jpg]], -- April Fool's Exceed 2022
      --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qjHj5M4.jpg]], -- April Fool's Exceed 2022
      faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KhQReVX.jpg]],
      backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aJRPgjl.jpg]],
      altfaceURL = [[https://i.imgur.com/6mWYAb4.png]], -- April Fool's Exceed 2023
      altbackURL = [[https://i.imgur.com/pDFBi2X.png]], -- April Fool's Exceed 2023
      gridWidth = 1, gridHeight = 1,
      hiddenBack = false,
      cardList = { { cardID = [[00]],
          cardNickname = [[Linne (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
        }, -- end cardList
      }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Linne]], position = { z = row1Z, y = characterIconY, x = column7X, }, }
    --PositionCheck { z = -0.675, y = 0.6, x = 22.70}

  charTable["Londrekia"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Londrekia]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QhDrTCd.jpg]], charCard = [[Londrekia (C)]], announcementList = {
      [[† He seeks. A beautiful equation that corrects the past and leads to the future.
Wishing for happiness and for putting an end to the tragedies.
He loves. The dawn of glittering diamond dust and the plains of silvery white.
The wizard who freezes all things hopes for a warm spring. †]],
      [[† Laundry car! †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Londrekia",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CcH1FMx.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/l1tD3GJ.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Grzh6Rm.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Circular Step ;6 (S)]], copies = 4, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Snow Blossom ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Frozen Vine ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Frozen Spire ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Hail Storm ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Frozen Cleave ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Cocytus Ice Prison ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mptD2K2.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hzIUqhG.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vkRi0CP.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ECuhCJO.jpg]],
        altfaceURL = [[https://i.imgur.com/5g1TdFr.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/AvHagTx.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Londrekia (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Londrekia]], position = { z = row2Z, y = characterIconY, x = column6X, }, }

  charTable["Merkava"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Merkava]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IZpJ6SH.jpg]], charCard = [[Merkava (C)]], announcementList = {
      [[† He fears. Every day the curse that permeates through his body grows stronger.
The memory lost, the flesh that is no longer, the hunger that cannot be fulfilled. He dashes
across the earth drenched in red, trailing behind him his crimson arms. A beast of the
Void. Neither peace nor hope has resided in this body for a long, long time. †]],
      [[† ~∽~∽~∽~ ●Δ● ∽~∽~∽~∽ †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Merkava",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AcNA9LO.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kk4GaIP.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tCKYZV6.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[I, Capture and Devour ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[I, Breathe Out ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[I, Drill Through ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[I, Rampage ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[I, Agitate ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[I, Persistently Cling ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[I, Defile ;8 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[I, Resentfully Rage ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IiLGZPP.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qVZo5c6.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OTO0YX6.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HiNpv7N.jpg]],
        altfaceURL = [[https://i.imgur.com/ocsPJXe.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/mi9dwMG.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Merkava (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Merkava]], position = { z = row2Z, y = characterIconY, x = column3X, }, }

  charTable["Mika"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Mika]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pu5OUjT.jpg]], charCard = [[Mika (C)]], announcementList = {
      [[† She arrives. She escapes, unfettered, from her tedious routine. She flies
through the sky, swims across the ocean, and climbs over mountains. Her travels
are undertaken in earnest, so as to never lose her beloved friend again. Her desires
are expressed in fists, which she swings with all of her might as far as she can reach. †]],
      [[† \  >◡<  / †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Mika",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/54vskq5.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GVVww3F.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JYu9cMV.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Mika's Crash ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Mika's Missile ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Mika's Tornado ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Mika's Hip Attack ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Mika's Cannon ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Mika's Revolution ;2 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Mika's Galaxy ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WuUyYqK.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/oNdYHGc.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SBBMMPe.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TYpEv9p.jpg]],
        altfaceURL = [[https://i.imgur.com/SO3qHhS.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/UGnAGcY.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Mika (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Mika]], position = { z = row1Z, y = characterIconY, x = column11X, }, }

  charTable["Nanase"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Nanase]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EKYM3f1.jpg]], charCard = [[Nanase (C)]], announcementList = {
      [[† She dances. Taking on the pure air from the night sky, she seeks the one who turned her into
an In-birth: the young boy with a long red blade. Her pure and silky white skin that is
contrasted with her body that has been consumed by the night. The traces of her innocence
are clouded. Is what she's feeling truly the desire for vengeance?
Perhaps the answers will present itself in the story... †]],
      [[† "If you're a man, take responsibility!" †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Nanase",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vafFUSZ.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QtelBlZ.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/W4NJsoR.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Chasing le Rêvé Chasing le Reve ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Plumage Dancing in the Wind ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Conveying My Vrai Couer ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Let the Fleur Carry Your Feelings ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Ange's Invitation ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Atmosphére of the Aether Atmosphere of the Aether ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Lumiére of the Dawn Lumiere of the Dawn ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ot00K3i.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aPb2VZy.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1wtgJvE.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wULYmHt.jpg]],
        altfaceURL = [[https://i.imgur.com/XZKF0sb.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/GzcX8jh.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Nanase (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Nanase]], position = { z = row2Z, y = characterIconY, x = column10X, }, }
-- Nanase:  { z = -6.165, y = 0.6, x = 23.62 }

  charTable["Orie"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Orie]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hF2y7MA.jpg]], charCard = [[Orie (C)]], announcementList = {
      [[† She judges. And hopes that the heavy weight placed on her frail shoulders may one day be
lifted. Delicate physique and delicate sword - its point aimed at the monster responsible
for her parents' death. Light fills her body, and the melody she sings resonates throughout
the city. The girl, a beacon of justice... no doubt her shadow will burn in the eyelids of her
enemies. †]],
      [[† Y, IOU or EA †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Orie",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qV1ByLN.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KNvCH8t.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GgPWRVQ.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Divine Thrust ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[To me! (Command Order) ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Sealing Hoplon ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Succession ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Sacred Arrow ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Luminous Embrace ;2 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Rest In Peace ;0 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yeIkhxv.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/G2qqYO2.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/l6QWRno.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fMkEDyx.jpg]],
        altfaceURL = [[https://i.imgur.com/9o8pOe7.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/7w7GxNp.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Orie (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Orie]], position = { z = row2Z, y = characterIconY, x = column4X, }, }

  charTable["Phonon"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Phonon]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZaPibbC.jpg]], charCard = [[Phonon (C)]], announcementList = {
      [[† She wishes. She yearns for powers beyond the ordinary. Trailing along beside her
is a white follower. She waits for the time to awaken from her false self,
and awaken she does. The sword speaks to her on a path leading to a bright future,
but she turns in another direction, only to find the sword blocking her way.
A way that trails from a murky past over which she has trampled. †]],
      [[† Whip it good! †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Phonon",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fI73Dzx.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/I19OSqK.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/njgpHE5.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Guidance Ascension ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Tuning Satisfaction ;5 (S)]], copies = 4, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Impulsive Frustration ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Sliding Affliction ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Suppressive Restriction ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Complete Servitude ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Binding Beatitude ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iwaR20j.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lVc9ytG.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NgRRnvu.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vMwxvei.jpg]],
        altfaceURL = [[https://i.imgur.com/H1bSTBQ.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/AF04nQw.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Phonon (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Phonon]], position = { z = row1Z, y = characterIconY, x = column1X, }, }
-- Phonon:  { z = -6.165, y = 0.6, x = 21.78 }

  charTable["Seth"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Seth]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/h88E7Rs.jpg]], charCard = [[Seth (C)]], announcementList = {
      [[† He wanders. Bound by the will and governing of an ancient family, but his emotions tremor.
The promise he made with a young girl shackles him in rusty chains he strives to sever. The
Night becomes a labyrinth, impeding his progress. Will he ever find the beacon he seeks? †]],
      [[† Make sure to follow up your Wyrd Dodges with truly Compelling Strikes! †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Seth",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hkZOzTD.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OT4sEue.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zDY0VL4.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Captive Segment ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Dead Space of Intrusion ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Vanishing Confusion ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Transgressing Convict ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Piercing Penetration ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Abyssal Geometry ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Distant Frontier ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aJ7XbsC.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/c7EvHWC.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Bh439p4.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pvS3FQK.jpg]],
        altfaceURL = [[https://i.imgur.com/QCHmSps.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/g66mWSA.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Seth (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Seth]], position = { z = row2Z, y = characterIconY, x = column8X, }, }
-- Seth:  { z = -4.335, y = 0.6, x = 23.62 }

  charTable["Vatista"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Vatista]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6h2qOT7.jpg]], charCard = [[Vatista (C)]], announcementList = {
      [[† She serves. A pawn that sleeps eternally. A puppet with no will to call her own. Her master,
nowhere to be seen. There is but one directive that resonates within her to this day - the end of
peace is the beginning of war. To destroy the Voids once and for all. †]],
      [[† Kurukuru~ †]],
      [[† Yaaaawn~ †]],
      [[† You spin me right round baby †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Vatista",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VxTcuWO.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nLtkFPF.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rpnPPGf.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Mikoruseo ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Lumen Stella ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Zahhishio ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Transvoranse ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Lateus Orbis ;3 (U)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Armabellum ;2 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Ruber Angelus ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YmSC6r7.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UcJruLs.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yeI3PT7.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JctuOOq.jpg]],
        altfaceURL = [[https://i.imgur.com/Ip3Bqaq.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/KVnVkwY.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Vatista (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Vatista]], position = { z = row2Z, y = characterIconY, x = column9X, }, }
-- Vatista: { z = 2.985, y = 0.6, x = 19.94 }

-- [=[
  charTable["Wagner"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Wagner]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nlgObO3.jpg]], charCard = [[Wagner (C)]], announcementList = {
      [[† She annihilates. She is exalted and engulfed in the scorching flames
of her family name, taking an oath of eternal loyality to Adelheid.
She shows neither forgiveness nor love, but the reflection of her sword.
No divine grace can save her soul from the battlefield.
She treads on the ashes of the dead as she awaits her judgment. †]],
      [[† She's kreisy! †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Wagner",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/m4g8N7N.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XzOJjnM.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JURFReI.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Schild Zack ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Filthy Dog! ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Kugel Blitz ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Wackenroder ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Sturm Brecher ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Megiddo L'or Celeste Grace ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Hitze Falke ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/eYA4th7.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Z90F6Zh.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pRTPRhW.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/f2vYfm3.jpg]],
        altfaceURL = [[https://i.imgur.com/OWneGe6.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/6OOjJZl.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Wagner (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Wagner]], position = { z = row2Z, y = characterIconY, x = column5X, }, }
-- Wagner: { z = -2.505, y = 0.6, x = 19.94 }

  charTable["Waldstein"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Waldstein]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qXC5vE0.jpg]], charCard = [[Waldstein (C)]], announcementList = {
      [[† He rages. In order to protect his master, the beast will raze buildings and crush trees with
his own two hands. To stand by his master's side, he takes on the curse of eternity,
transcending the power of mankind. On this quiet night he thinks about his master,
and how he may die on the battlefield one day... †]],
      [[† Maximize Power! †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Waldstein",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hz5lgWn.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CnS2ZYS.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TUcfJEm.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Wirbelwind ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Eisen Nagel ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Sturmangriff ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Ferzen Volf ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Katastrophe ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Werfen Erschlagen ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Verderben ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MWLf7Lg.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TxEqRkw.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uBbkLaD.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/w03tgvm.jpg]],
        altfaceURL = [[https://i.imgur.com/j8ByCzY.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/GewJFnm.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Waldstein (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Waldstein]], position = { z = row1Z, y = characterIconY, x = column4X, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Definitely Wagner",
        costumeDescription = [[Yup, that's Wagner all right.]],
        costumeNormals = [[Definitely Wagner]],
        costumeAttackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rLJopE4.jpg]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/hvags5p.jpg]],
            backURL = [[https://i.imgur.com/222sGfm.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VH8InG4.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Schild Zack ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Filthy Dog! ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Kugel Blitz ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Wackenroder ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Sturm Brecher ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Megiddo L'or Celeste Grace ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Hitze Falke ;1 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8TTLmjF.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sKPzSGQ.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Waldstein (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
              }, -- end cardList
            }, -- end subdeck
        }, -- end deck
      }, -- costume ends
    }, -- end costume list
  }
-- Waldstein: { z = -2.505, y = 0.6, x = 23.62 }

  charTable["Yuzuriha"] = { panelGUID = [[0e101c]], season = [[6]], borderColor = { 255/255, 50/255, 200/255, 1}, legal = seasonLegal, assetName = [[Yuzuriha]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8eJRAA7.jpg]], charCard = [[Yuzuriha (C)]], announcementList = {
      [[† She reacts. She runs away from her laws and chooses to be alone, living life as she
pleases, bound to no one. Tonight, too, is nothing more for her than a whimsical stroll.
The naked sword is seldom drawn, but when it is, the blade never lies. Everything is
reflected in its clear glimmer... And her true self lies beyond the freedom she attained.
The self she has lost.  †]],
      [[† Featuring Yuzuriha from SkullGirls! †]]},
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Yuzuriha",
      Description = "S6",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ycn1Dpm.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/K10yvNT.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/hvags5p.jpg]],
        backURL = [[https://i.imgur.com/222sGfm.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: UN Normals & Revert Charge (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/431gwo8.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Sougetsu Ittou-ryu et cetera! Yae Ichirin ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Over Here! ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Battoujutsu San no Kata: Tachi ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Battoujutsu Ni no Kata: Saki ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Battoujutsu Ichi no Kata: Kiri ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Sogetsu Ittou-Ryuu Ougi: Kashou ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Zero no Kata Hi-ougi: Inochi Kurenai ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Dvx3qsX.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6sXWzEQ.jpg]], -- April Fool's Exceed 2022
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0kh8bK8.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Jc4RKTg.jpg]],
        altfaceURL = [[https://i.imgur.com/PuZyZ3d.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/mNIoexq.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Yuzuriha (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[UNNormals]], normals = [[Yuzuriha]], position = { z = row1Z, y = characterIconY, x = column9X, }, }
-- Yuzuriha: { z = 2.985, y = 0.6, x = 23.62 }
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
  systemElements = {}
  table.insert(systemElements, {
      id = "Season 6 Base",
      image = "RosterS6",
      active = true,
      height = 300,
      width = 300,
      position = { x = 0, z = 0, y = 10, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 1, g = 1, b = 1, a = 1 },
      clickable = "false",
      --onClick = self.getGUID().."/uiClick_SelectNormals",
      --hoverImage = "",
      hoverColor = { r = 1, g = 1, b = 1, a = 0, },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    })
    table.insert(systemElements, {
      id = "Random6",
      tooltip = [[Random
Season 6]],
      active = true,
      height = iconSize,
      width = iconSize,
      position = { x = column6X, z = row1Z, y = characterIconY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 0, g = 1, b = 0, a = transparencyValue },
      clickable = "true",
      onClick = self.getGUID().."/uiClick_Random",
      --[[ 2023-08-19: Disabling hover images to attempt to improve load times.
      hoverTooltip = blankTooltip,
      hoverImage = "RandomS6",
      hoverColor = { r = 1, g = 1, b = 1, a = 1, },
      --]]
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    })

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
  end -- Finish registering Normals

  -- Register all the charTable entries in Character Station.
  for charName,thisChar in pairs(charTable) do
    debugLog{ "Roster S6, per-char loop: "..charName, 2, {1,1,1} }

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
        colors = [[rgba(0,0,0,0.1)|rgba(1,]]..(114/255)..[[,0.9,1)|rgba(0.7,0.7,0.7,0.9)]], -- Applied on top of the background color, for some reason.
        color = [[rgba(1,]]..(50/255)..[[,]]..(200/255)..[[,1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS6Icon",
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
        colors = [[rgba(0,0,0,0.1)|rgba(0.5,0.1,0.4,1)|rgba(1,]]..(50/255)..[[,]]..(200/255)..[[,1)]], -- Applied on top of the background color, for some reason.
        color = [[rgba(1,1,1,0.1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS6Icon",
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