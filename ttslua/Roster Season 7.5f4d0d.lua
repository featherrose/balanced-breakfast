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
  normalsToggleName = "GGST (Diverse)"

  normalsSheets = {}
  normalsSheets["GGST (Diverse)"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Vufsz3x.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]

  normalsSheets["Anji Mito"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PoF9klC.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Axl Low"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/j57Axxl.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Baiken"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OBZvavZ.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Chipp Zanuff"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/K5vdRY9.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Faust"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jM2Qwzx.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Giovanna"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qaMnJ7V.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Goldlewis Dickinson"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UA0weKo.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Happy Chaos"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/czwBxJn.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["I-No"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6a271hg.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Jack-O'"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WgFWf8v.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Ky Kiske"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/w37266m.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Leo Whitefang"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3Mn6BIa.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["May"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/x5F6Yv0.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Millia Rage"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ylad5LZ.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Nagoriyuki"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HB7XeKU.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Potemkin"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ASqx62k.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Ramlethal Valentine"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    -- faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/POHW2Eq.jpg", -- Original
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/shKYdPO.jpg", -- Fixed
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Sol Badguy"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LCaCpyQ.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Testament"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xOETDn9.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Zato-1"] = { GGSTNormals = { suffix = [[ (GGST)(N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/akBEcjP.jpg",
    Grasp = "00", Cross = "01", Slash = "02", Assault = "02", Dive = "03", Dust = "04", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]

  --[=[---------------------------------------------------------------------------
  charTable entry template:
  charTable["CHARACTERNAME"] = {
  season = "7", -- string, expects one of: "1", "2", "3", "4", "5", "6".
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

  local row1Z = 65
  local row2Z = 39
  local row3Z = 13
  local row4Z = -13
  local row5Z = -39
  local row6Z = -65
  local row7Z = -91
  local column1X = -39
  local column2X = -26
  local column3X = -13
  local column4X = 0
  local column5X = 13
  local column6X = 26
  local column7X = 39
  local characterIconY = -100

  local iconSize = 22
  local btnScale = 115

  local togglePanelX = 0
  local togglePanelZ = 71
  local togglePanelY = -100

  local togglePanelSize = 60

  local normalsToggleX = 0
  local normalsToggleZ = 60
  local normalsToggleY = -80

  local normalsToggleSize = 50

  charTable = {}
  -- Season 7: Guilty Gear -Strive-
  charTable["Anji Mito"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[AnjiMito]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vSx1PVf.jpg]], charCard = [[Anji Mito (C)]], announcement = [[† His graceful steps evade all attacks as he strikes! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Anji Mito",
      Description = [[S7, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/frcblyB.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/eyYH5wv.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/66eYAdP.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Fuujin ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Nagiha ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Kou ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Rin ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Shitsu ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Issei Ougi: Sai ;3 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Kachoufuugetsu Kai ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vcHPpPo.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ufUZrK4.jpg]],
        altfaceURL = [[https://i.imgur.com/p8kXM05.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/bFHNm6T.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Anji Mito (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Anji Mito]], position = { z = row6Z, y = characterIconY, x = column1X, },
  } -- end charTable entry

  charTable["Axl Low"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[AxlLow]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SnBx5MU.jpg]], charCard = [[Axl Low (C)]], announcement = [[† Striking from afar, you can't touch him! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Axl Low",
      Description = [[S7, Difficulty 2 (Beginner-friendly)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/f40kEQj.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hv1c66y.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/J0c0shA.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Snail ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Sickle Flash ;5 (S)]], copies = 4, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Rainwater ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Axl Bomber ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Winter Mantis ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[One Vision ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Sickle Storm ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/A7v3ns6.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/FAzzKJy.jpg]],
        altfaceURL = [[https://i.imgur.com/PZeS0x7.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/nTdCdyP.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Axl Low (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Axl Low]], position = { z = row4Z, y = characterIconY, x = column3X, },
  } -- end charTable entry

  charTable["Baiken"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[Baiken]], altattackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Bz6ISMZ.jpg]], -- WHAT THE HECK IS THIS HIIRAGI
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/F1AdTtW.jpg]], charCard = [[Baiken (C)]], announcement = [[† Wielding her opponent's strength as her own! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Baiken",
      Description = [[S7, Difficulty 2 (Beginner-friendly)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/caxwVSX.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/c8x5qLu.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jKxrSWD.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Kabari ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Youzansen ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Karatakewari ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Tatami Gaeshi ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Hiiragi ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Kenjyu ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Tsurane Sanzu-watashi ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lffuhca.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ud5rYyr.jpg]],
        altfaceURL = [[https://i.imgur.com/i4ZfqCr.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/3FfwQ18.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Baiken (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Baiken]], position = { z = row6Z, y = characterIconY, x = column3X, },
  } -- end charTable entry

  charTable["Chipp Zanuff"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[ChippZanuff]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wVe2FRl.jpg]], charCard = [[Chipp Zanuff (C)]], announcement = [[† Overwhelming supersonic assault! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Chipp Zanuff",
      Description = [[S7, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iylTWQm.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/D1tLBQK.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jGcFFQQ.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Beta Blade ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Alpha Blade ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Resshou ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Gamma Blade ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Genrouzan ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Zansei Rouga ;9 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Banki Messai ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kGWq8zo.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wGQ5no4.jpg]],
        altfaceURL = [[https://i.imgur.com/IZUDxFW.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/oh5uXtw.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Chipp Zanuff (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Chipp Zanuff]], position = { z = row4Z, y = characterIconY, x = column1X, },
  } -- end charTable entry

  charTable["Faust"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[Faust]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lxKFBBy.jpg]], charCard = [[Faust (C)]], announcement = [[† Deceptive! Enigmatic! Incomprehensible! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Faust",
      Description = [[S7, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9joO2wh.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZgjPTMt.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KdzkOcI.jpg]],
        gridWidth = 4, gridHeight = 3,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Snip Snip Snip ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Scarecrow ;4 (S)]], copies = 1, reference = false, },
          { cardID = [[02]],
            cardNickname = [[Scarecrow ;4 (S)]], copies = 1, reference = false, },
          { cardID = [[01]],
            cardNickname = [[Scarecrow ;4 (S)]], copies = 0, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Love ;4 (S)]], copies = 1, reference = false, },
          { cardID = [[04]],
            cardNickname = [[Love ;4 (S)]], copies = 1, reference = false, },
          { cardID = [[03]],
            cardNickname = [[Love ;4 (S)]], copies = 0, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Thrust ;3 (S)]], copies = 1, reference = false, },
          { cardID = [[06]],
            cardNickname = [[Thrust ;3 (S)]], copies = 1, reference = false, },
          { cardID = [[05]],
            cardNickname = [[Thrust ;3 (S)]], copies = 0, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Mix Mix Mix ;2 (S)]], copies = 1, reference = false, },
          { cardID = [[08]],
            cardNickname = [[Mix Mix Mix ;2 (S)]], copies = 1, reference = false, },
          { cardID = [[07]],
            cardNickname = [[Mix Mix Mix ;2 (S)]], copies = 0, reference = true, },
          { cardID = [[09]],
            cardNickname = [[W-W-What Could This Be? ;6 (U)]], copies = 1, reference = false, },
          { cardID = [[10]],
            cardNickname = [[W-W-What Could This Be? ;6 (U)]], copies = 1, reference = false, },
          { cardID = [[09]],
            cardNickname = [[W-W-What Could This Be? ;6 (U)]], copies = 0, reference = true, },
          { cardID = [[11]],
            cardNickname = [[Bone-crushing Excitement ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gw01KBP.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uEzodx5.jpg]],
        altfaceURL = [[https://i.imgur.com/NHZEF9n.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/pIDf4Ml.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Faust (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Faust]], position = { z = row5Z, y = characterIconY, x = column3X, },
  } -- end charTable entry

  charTable["Giovanna"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[Giovanna]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VSWTnXm.jpg]], charCard = [[Giovanna (C)]], announcement = [[† Max out on offensive rushdown! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Giovanna",
      Description = [[S7, Difficulty 2 (Beginner-friendly)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AMcWEN1.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UEujYUO.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hX5qDny.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Sol Nascente ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Triple Kick ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Sepultura ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Sol Poente ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Trovão Trovao ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Ventania ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Tempestade ;6 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JGR4Ys9.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QXHVXst.jpg]],
        altfaceURL = [[https://i.imgur.com/BkaeYui.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/yvMUfVZ.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Giovanna (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Giovanna]], position = { z = row6Z, y = characterIconY, x = column5X, },
  } -- end charTable entry

  charTable["Goldlewis Dickinson"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[GoldlewisDickinson]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JiS3Djo.jpg]], charCard = [[Goldlewis Dickinson (C)]], announcement = [[† Unparalleled brute strength! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Goldlewis Dickinson",
      Description = [[S7, Difficulty 2 (Beginner-friendly)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GgFYInW.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZdDfX5g.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cJRG0q9.jpg]],
        gridWidth = 5, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[BT Rise Behemoth Typhoon Rise ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[BT Hurl Behemoth Typhoon Hurl ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[BT Slam Behemoth Typhoon Slam ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[BT Swing Behemoth Typhoon Swing ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[BT Drop Behemoth Typhoon Drop ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[BT Smash Behemoth Typhoon Smash ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[BT Spin Behemoth Typhoon Spin ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[BT Crush Behemoth Typhoon Crush ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[08]],
            cardNickname = [[Down With The System ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[09]],
            cardNickname = [[Burn It Down ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/O4eZUhC.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VnJ72L5.jpg]],
        altfaceURL = [[https://i.imgur.com/tUBXqmE.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/kzwZQEQ.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Goldlewis Dickinson (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Goldlewis Dickinson]], position = { z = row6Z, y = characterIconY, x = column7X, },
  } -- end charTable entry

  charTable["Happy Chaos"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[HappyChaos]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/j1HTOa7.jpg]], charCard = [[Happy Chaos (C)]], announcement = [[† Restorer of humanity! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Happy Chaos",
      Description = [[S7, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4R9XvAa.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/W4WiJ9i.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tisUne9.jpg]],
        gridWidth = 3, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[At the Ready ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Fire ;4 (S)]], copies = 3, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Cheap Shot ;6 (U)]], copies = 3, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Gun Down ;5 (U)]], copies = 3, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Steady Aim ;2 (U)]], copies = 3, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/86yaswj.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/5EvZY6W.jpg]],
        altfaceURL = [[https://i.imgur.com/vxCkPAa.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/3cIl1UD.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Happy Chaos / Deus Ex Machina (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Happy Chaos]], position = { z = row1Z, y = characterIconY, x = column6X, },
  } -- end charTable entry

  charTable["I-No"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[INo]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cIW5lUc.jpg]], charCard = [[I-No (C)]], announcement = [[† Her offense with her hover dash is overbearing! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "I-No",
      Description = [[S7, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HumiaLv.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bvUI6Jh.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CmHARAy.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Chemical Love ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Antidepressant Scale ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Stroke the Big Tree ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Sultry Performance ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Guitar Stamping ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Megalomania ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Ultimate Fortissimo ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KU8oyeN.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/L0vyRWI.jpg]],
        altfaceURL = [[https://i.imgur.com/PAuqIni.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/OINMp1B.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[I-No (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[I-No]], position = { z = row2Z, y = characterIconY, x = column5X, },
  } -- end charTable entry

  charTable["Jack-O'"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[Jack-O]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YL1bV4g.jpg]], charCard = [[Jack-O' (C)]], announcement = [[† Dominates the battle with an ensemble of servants! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Jack-O'",
      Description = [[S7, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0wY6M0p.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bJORhf0.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3tFLmJn.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Iron Pumpkin ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Chain of Chiron ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Servant Shoot ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Throw Servant ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Countdown ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Cheer Servant On ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Forever Elysion Driver ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RWRBSLp.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zg0ZdXe.jpg]],
        altfaceURL = [[https://i.imgur.com/Co6af9V.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/7ruTgyT.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Jack-O' (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Jack-O']], position = { z = row5Z, y = characterIconY, x = column7X, },
  } -- end charTable entry

  charTable["Ky Kiske"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[KyKiske]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/efknW6Q.jpg]], charCard = [[Ky Kiske (C)]], announcement = [[† Master of a multitude of techniques! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Ky Kiske",
      Description = [[S7, Difficulty 1 (Novice)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/W3BSwnJ.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2Uw5F9U.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/V8rWGVD.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Stun Dipper ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Vapor Thrust ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Foudre Arc ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Dire Eclat ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Stun Edge ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Sacred Edge ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Ride The Lightning ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RBCSXwP.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Jcc8RYc.jpg]],
        altfaceURL = [[https://i.imgur.com/i9KKpMH.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/ibKepXT.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Ky Kiske (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Ky Kiske]], position = { z = row3Z, y = characterIconY, x = column6X, },
  } -- end charTable entry

  charTable["Leo Whitefang"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[LeoWhitefang]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0ObTbvQ.jpg]], charCard = [[Leo Whitefang (C)]], announcement = [[† A crushing pressure from his back-facing stance! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Leo Whitefang",
      Description = [[S7, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9Skevra.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9jWikxm.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DJkbF0F.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Zweites Kaltes Gestöber Zweites Kaltes Gestober ;SPEED (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Blitzschlag ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Eisensturm ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Gravierte Würde Gravierte Wurde ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Kahn Schild ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Stahlwirbel ;0 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Leidenschaft des Dirigenten ;0 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9r5nKru.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1bdLfdb.jpg]],
        altfaceURL = [[https://i.imgur.com/hUo2ySQ.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/s4VtGk4.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Leo Whitefang (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Leo Whitefang]], position = { z = row5Z, y = characterIconY, x = column1X, },
  } -- end charTable entry

  charTable["May"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[May]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/etEnGRu.jpg]], charCard = [[May (C)]], announcement = [[† Charges forward with vibrant energy! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "May",
      Description = [[S7, Difficulty 1 (Novice)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SVNViio.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vIYABXz.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tjFCTtO.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Totsugeki! ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Arisugawa Sparkle ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Mr. Dolphin ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Overhead Kiss ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Anchor Swing ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[The Wonderful And Dynamic Goshogawara ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Great Yamada Attack ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jIETs6s.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6HZPfjA.jpg]],
        altfaceURL = [[https://i.imgur.com/bOmS5eG.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/DBLyFBp.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[May (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[May]], position = { z = row4Z, y = characterIconY, x = column7X, },
  } -- end charTable entry

  charTable["Millia Rage"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[Millia Rage]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8G228CY.jpg]], charCard = [[Millia Rage (C)]], announcement = [[† Blink once and it's over! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Millia Rage",
      Description = [[S7, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PuSUZQT.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mzz8GGI.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XUnesfH.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Low Kick ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Bad Moon ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Swing Braid ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Tandem Top ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Iron Savior ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Septem Voices ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Winger ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QmwtiTN.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wncqAkM.jpg]],
        altfaceURL = [[https://i.imgur.com/dkFmf6O.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/5zLwew1.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Millia Rage (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Millia Rage]], position = { z = row2Z, y = characterIconY, x = column1X, },
  } -- end charTable entry

  charTable["Nagoriyuki"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[Nagoriyuki]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vhgpNSN.jpg]], charCard = [[Nagoriyuki (C)]], announcement = [[† His blood-sucking blade delivers a devastating blow! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Nagoriyuki",
      Description = [[S7, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/l8FLFZv.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pI1vB6c.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sEtM4PI.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Kamuriyuki ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Kirioroshi ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Bloodsucking Universe ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Shizuriyuki ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Zarameyuki ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Wasureyuki ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Zansetsu ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/j2npVOS.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jgf2t2c.jpg]],
        altfaceURL = [[https://i.imgur.com/E9BD8pQ.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/lhYyHsP.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Nagoriyuki (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Nagoriyuki]], position = { z = row2Z, y = characterIconY, x = column3X, },
  } -- end charTable entry

  charTable["Potemkin"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[Potemkin]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/f04crN6.jpg]], charCard = [[Potemkin (C)]], announcement = [[† It's game over once you are in his grasp! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Potemkin",
      Description = [[S7, Difficulty 2 (Beginner-friendly)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kvkN1Nw.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/J7xWA48.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/K0CgB4Q.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Mega Fist ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Garuda Impact ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Potemkin Buster ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Hammer Fall ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Slide Head ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Heat Knuckle ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Giganter Kai ;1 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Heavenly Potemkin Buster ;0 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/22mQc6y.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/r3ralQs.jpg]],
        altfaceURL = [[https://i.imgur.com/4lBKkPm.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/aagvAt1.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Potemkin (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Potemkin]], position = { z = row4Z, y = characterIconY, x = column5X, },
  } -- end charTable entry

  charTable["Ramlethal Valentine"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[Ramlethal Valentine]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qOFJBXb.jpg]], charCard = [[Ramlethal Valentine (C)]], announcement = [[† Wielder of two giant swords! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Ramlethal Valentine",
      Description = [[S7, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UryOaaJ.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ivlNqnW.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DEl3xd1.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Dauro ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Bajoneto ;5 (S)]], copies = 1, reference = false, },
          { cardID = [[02]],
            cardNickname = [[Bajoneto ;5 (S)]], copies = 1, reference = false, },
          { cardID = [[01]],
            cardNickname = [[Bajoneto ;5 (S)]], copies = 0, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Erarlumo ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Agresa Ordono ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Sabrobato ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Mortobato ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Calvados ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wnYKjDf.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wpEnHkE.jpg]],
        altfaceURL = [[https://i.imgur.com/XPvdgsY.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/TEhYtxr.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Ramlethal Valentine (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Ramlethal Valentine]], position = { z = row5Z, y = characterIconY, x = column5X, },
  } -- end charTable entry

  charTable["Sol Badguy"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[Sol Badguy]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XkijP6t.jpg]], charCard = [[Sol Badguy (C)]], announcement = [[† Overpowering all foes with savage force! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Sol Badguy",
      Description = [[S7, Difficulty 1 (Novice)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kkFtK5a.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cs8BwuJ.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QdBFWxG.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Gun Flame ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Volcanic Viper ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Fafnir ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Bandit Bringer ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Wild Throw ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Night Raid Vortex ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Tyrant Rave ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Heavy Mob Cemetery ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SMbtQ4g.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Z71s4RA.jpg]],
        altfaceURL = [[https://i.imgur.com/ccZ94ly.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/yn8s56C.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Sol Badguy (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Sol Badguy]], position = { z = row3Z, y = characterIconY, x = column2X, },
  } -- end charTable entry

  charTable["Testament"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[Testament]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NvJC7hf.jpg]], charCard = [[Testament (C)]], announcement = [[† Crimson scythe swaying in an enchanting dance! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Testament",
      Description = [[S7, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kwLGp00.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4tPfsA2.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JB0s9kC.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Unholy Diver ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Arbiter Sign - Rising ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Grave Reaper ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Arbiter Sign - Falling ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Scythe Swing ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Nostrovia ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Calamity One ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1yEX8Gf.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CoVHdEd.jpg]],
        altfaceURL = [[https://i.imgur.com/j9uAUqJ.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/u9xf9Ea.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Testament (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Testament]], position = { z = row1Z, y = characterIconY, x = column2X, },
  } -- end charTable entry

  charTable["Zato-1"] = { panelGUID = [[5f4d0d]], season = [[7]], borderColor = { 151/255, 0, 0, 1}, legal = seasonLegal,
    assetName = [[Zato-1]],
    normalsList = { [[Grasp]], [[Grasp]], [[Cross]], [[Cross]], [[Slash]], [[Slash]], [[Dive]], [[Dive]], [[Dust]], [[Dust]], [[Sweep]], [[Sweep]], [[Focus]], [[Focus]], [[Block]], [[Block]], },
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OjHK2l6.jpg]], charCard = [[Zato-1 (C)]], announcement = [[† Suffocating offense paired with his shadow! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Zato-1",
      Description = [[S7, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DeuqPvL.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dFjienE.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        backURL = [[https://i.imgur.com/PelkdRZ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Cancel & GG Normals (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/i2gkjcp.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [["Pierce" ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [["Leap" ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Invite Hell ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [["That's a lot!" ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Damned Fang ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [["Oppose" ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Sun Void ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[07]],
            cardNickname = [[Amorphous ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[5]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UCKf7iu.jpg]],
        backURL = [[https://i.imgur.com/UCKf7iu.jpg]],
        altfaceURL = [[https://i.imgur.com/BpcKKqa.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/BpcKKqa.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Eddie (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/X1HSW4h.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/K6vcO8T.jpg]],
        altfaceURL = [[https://i.imgur.com/lDcU4bN.png]], -- April Fool's Exceed 2024
        altbackURL = [[https://i.imgur.com/zCTLyh6.png]], -- April Fool's Exceed 2024
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Zato-1 (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normalsSet = [[GGSTNormals]], normals = [[Zato-1]], position = { z = row2Z, y = characterIconY, x = column7X, },
  } -- end charTable entry


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
      id = "Season 7 Base",
      image = "RosterS7",
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
      id = "Random7",
      tooltip = [[Random
Season 7]],
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
      hoverImage = "RandomS7",
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
    debugLog{ "Roster S7, per-char loop: "..charName, 2, {1,1,1} }

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
        color = [[rgba(0.592156863,0,0,1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS7Icon",
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
        icon = "RosterS7Icon",
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