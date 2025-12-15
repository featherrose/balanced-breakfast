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
  normalsToggleName = "Shovel Knight (Diverse)"

  normalsSheets = {}
  normalsSheets["Shovel Knight (Diverse)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QUPRdRj.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["The Enchantress"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/74gES24.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["King Knight"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AGmmf1d.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Mole Knight"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bqXMzQr.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Plague Knight"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9wutpZY.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Polar Knight"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fdHFJ1K.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Propeller Knight"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1MaStFi.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Shovel Knight & Shield Knight"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TuFOJVQ.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Specter Knight"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/opQdscv.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Tinker Knight"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wWIbK3W.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Treasure Knight"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9zRrqIa.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Dead Cells"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/a0cqvcG.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["A Robot Named Fight"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VZubP6z.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]

  -- Instead of individualized alternate sets, they use the diverse set.
  normalsSheets["The Enchantress (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/QUPRdRj.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["King Knight (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/QUPRdRj.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Mole Knight (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/QUPRdRj.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Plague Knight (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/QUPRdRj.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Polar Knight (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/QUPRdRj.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Propeller Knight (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/QUPRdRj.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Shovel Knight & Shield Knight (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/QUPRdRj.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Specter Knight (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/QUPRdRj.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Tinker Knight (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/QUPRdRj.jpg",
    Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
  } --[[ end deck ]] } --[[ end normalsSheets entry ]]
  normalsSheets["Treasure Knight (Alternate)"] = { Normals = { suffix = [[ (N)]], gridWidth = 4, gridHeight = 2,
    faceURL = "https://i.imgur.com/QUPRdRj.jpg",
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
  local row2Z = 24
  local row3Z = 12
  local row4Z = 0
  local row5Z = -12
  local row6Z = -24
  local row7Z = -36
  local column1X = -50
  local column2X = -24
  local column3X = 0
  local column4X = 24
  local column5X = 50
  local characterIconY = -100

  local iconSize = 23
  local btnScale = 115

  local togglePanelX = 0
  local togglePanelZ = 48
  local togglePanelY = -100

  local togglePanelSize = 60

  local normalsToggleX = 0
  local normalsToggleZ = -48
  local normalsToggleY = -80

  local normalsToggleSize = 50

  charTable = {}
  -- Season 4
  charTable["The Beheaded (Dead Cells)"] = { panelGUID = [[0e101c]], season = [[4]], borderColor = { 113/255, 59/255, 23/255, 1}, legal = seasonLegal, assetName = [[Beheaded]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MfMlgg9.jpg]], charCard = [[The Beheaded (C)]], announcement = [[† Nothing personnel, kid †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "The Beheaded (Dead Cells)",
      Description = [[S4, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VKILwSF.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0xNsbc6.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jLbyVUW.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Twin Daggers ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Dive Attack ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Wrenching Whip ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Infantry Bow ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Assault Shield ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Wave of Denial ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Phaser ;4 (U)]], copies = 2, reference = true, },
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
        ---- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7F52DDn.jpg]],
        ---- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/V0jrUKf.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aGBsbck.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QRSPlfK.jpg]],
        altfaceURL = [[https://i.imgur.com/tqyDSrQ.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/zdlAQuo.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[The Beheaded (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Dead Cells]], position = { z = row4Z, y = characterIconY, x = column5X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Link",
        costumeDescription = [[Costume based on Link from Nintendo's Legend of Zelda series.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Dead Cells]],
        costumeAttackBack = [[https://i.imgur.com/MfMlgg9.jpg]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/jLbyVUW.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Twin Daggers ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Dive Attack ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Wrenching Whip ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Infantry Bow ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Assault Shield ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Wave of Denial ;7 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Phaser ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[6]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/BrfBqIb.png]],
            backURL = [[https://i.imgur.com/cI6TGjC.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Tactics (C)]], copies = 1, reference = false, separate = true, cardSnap = false, cardDescription = [[The Beheaded (Costume: Link)]]},
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[5]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/FQWOnmE.png]],
            backURL = [[https://i.imgur.com/cI6TGjC.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Survival (C)]], copies = 1, reference = false, separate = true, cardSnap = false, cardDescription = [[The Beheaded (Costume: Link)]]},
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[4]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pdaqVoI.png]],
            backURL = [[https://i.imgur.com/cI6TGjC.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Brutality (C)]], copies = 1, reference = false, separate = true, cardSnap = false, cardDescription = [[The Beheaded (Costume: Link)]] },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dzGJd2g.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ypk3oYJ.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[The Beheaded (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[The Beheaded (Costume: Link)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["The Enchantress"] = { panelGUID = [[0e101c]], season = [[4]], borderColor = { 113/255, 59/255, 23/255, 1}, legal = seasonLegal, assetName = [[Enchantress]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jANKwbe.jpg]], charCard = [[The Enchantress (C)]], announcement = [[† ...and she does evil dances! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "The Enchantress",
      Description = [[S4, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JB4XqKc.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/f8rxXSG.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hltEPTp.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Homing Orb ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Magic Shot ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Fire Wave ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Flying Charge ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Spiral Orb ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Rapid Beam ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Shattering Scream ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        ---- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LRa8G0n.jpg]],
        ---- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8vN09WX.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OhxNWjk.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9RIXdLo.jpg]],
        altfaceURL = [[https://i.imgur.com/PEAnwLS.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/gytENeO.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[The Enchantress (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[The Enchantress]], position = { z = row2Z, y = characterIconY, x = column3X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Garland",
        costumeDescription = [[Costume based on Garland and Chaos from Square Enix's Final Fantasy.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Mage Wars]],
        costumeAttackBack = [[https://i.imgur.com/jANKwbe.jpg]],
        --costumeOwner = { [[tirankin]], [[Jungy]], }, -- Only appears for players in this table.
        --costumeFavorite = { [[Piraticus]], }, -- Prioritized for players in this table (but available regardless).
        --costumePassword = [[Seijun]], -- Locks access based on this password. Always needs to end with the character being clicked.
        --costumePasswordFavorite = [[Renea | Seijun]], -- Prioritized based on this password. ALways needs to end with the character being clicked.
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/hltEPTp.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Homing Orb ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Magic Shot ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Fire Wave ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Flying Charge ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Spiral Orb ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Rapid Beam ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Shattering Scream ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WHsRIpz.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wrK7hDW.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[The Enchantress (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[The Enchantress (Costume: Garland)]], },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Fight (A Robot Named Fight)"] = { panelGUID = [[0e101c]], season = [[4]], borderColor = { 113/255, 59/255, 23/255, 1}, legal = seasonLegal, assetName = [[Fight]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ep5ma7U.jpg]], charCard = [[Fight (C)]], announcement = [[† I got that, but what's the name of the game he's from? †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Fight (A Robot Named Fight)",
      Description = [[S4, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/FRQIh6l.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/88FhUbc.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/l4P9sfU.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Explosive Shot ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Retreating Bolts ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Power Jump ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Electro Charge ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Lightning Gun ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Rail Gun ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Flamethrower ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        ---- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XR92wdB.jpg]],
        ---- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yNGEP1J.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XsuCKKZ.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/a8IG6c6.jpg]],
        altfaceURL = [[https://i.imgur.com/TMI0iQn.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/ROfGFcI.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Fight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[A Robot Named Fight]], position = { z = row4Z, y = characterIconY, x = column1X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Samus",
        costumeDescription = [[Costume based on Nintendo's Samus.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[A Robot Named Fight]],
        costumeAttackBack = [[https://i.imgur.com/Ep5ma7U.jpg]],
        --costumeOwner = { [[tirankin]], [[Jungy]], }, -- Only appears for players in this table.
        --costumeFavorite = { [[Piraticus]], }, -- Prioritized for players in this table (but available regardless).
        --costumePassword = [[Seijun]], -- Locks access based on this password. Always needs to end with the character being clicked.
        --costumePasswordFavorite = [[Renea | Seijun]], -- Prioritized based on this password. ALways needs to end with the character being clicked.
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/l4P9sfU.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Explosive Shot ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Retreating Bolts ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Power Jump ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Electro Charge ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Lightning Gun ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Rail Gun ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Flamethrower ;5 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yxWvGNF.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zmidvT4.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Fight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Fight (Costume: Samus)]], },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["King Knight"] = { panelGUID = [[0e101c]], season = [[4]], borderColor = { 113/255, 59/255, 23/255, 1}, legal = seasonLegal, assetName = [[KingKnight]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PC0OqwD.jpg]], charCard = [[King Knight (C)]], announcement = [[† He's the ace of "paid"s! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "King Knight",
      Description = [[S4, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/k3l3gI7.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Yy52G0c.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DvOMYog.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Healing Hammer ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Scepter Slam ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Spin Jump ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Scepter Smite ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Shoulder Bash ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[King of Cards ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Victory Trumpets ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[7]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/10BnuLp.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aQGNkD5.png]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Pay to Win (C)]], copies = 1, reference = false, separate = true, cardSnap = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[6]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/F9xfsu0.jpg]],
        backURL = [[https://i.imgur.com/aQGNkD5.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Magnificent Cape (C)]], copies = 1, reference = false, separate = true, cardSnap = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[5]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HBcPJQd.jpg]],
        backURL = [[https://i.imgur.com/aQGNkD5.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Lordly Might (C)]], copies = 1, reference = false, separate = true, cardSnap = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/c1WKSti.jpg]],
        backURL = [[https://i.imgur.com/aQGNkD5.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Kingly Strut (C)]], copies = 1, reference = false, separate = true, cardSnap = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]], -- April Fool's Exceed
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hVSCHM7.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OCGUOqE.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Bgs1eSj.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3aqiRvT.jpg]],
        altfaceURL = [[https://i.imgur.com/A7D9UTB.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/pvIUfdt.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[King Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[King Knight]], position = { z = row3Z, y = characterIconY, x = column4X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Wario",
        costumeDescription = [[Costume based on Nintendo's Wario.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[King Knight]],
        costumeAttackBack = [[https://i.imgur.com/PC0OqwD.jpg]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/DvOMYog.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Healing Hammer ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Scepter Slam ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Spin Jump ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Scepter Smite ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Shoulder Bash ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[King of Cards ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Victory Trumpets ;3 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[7]],
            faceURL = [[https://i.imgur.com/10BnuLp.jpg]],
            backURL = [[https://i.imgur.com/aQGNkD5.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Pay to Win (C)]], copies = 1, reference = false, separate = true, cardSnap = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[6]],
            faceURL = [[https://i.imgur.com/F9xfsu0.jpg]],
            backURL = [[https://i.imgur.com/aQGNkD5.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Magnificent Cape (C)]], copies = 1, reference = false, separate = true, cardSnap = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[5]],
            faceURL = [[https://i.imgur.com/HBcPJQd.jpg]],
            backURL = [[https://i.imgur.com/aQGNkD5.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Lordly Might (C)]], copies = 1, reference = false, separate = true, cardSnap = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/c1WKSti.jpg]],
            backURL = [[https://i.imgur.com/aQGNkD5.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Kingly Strut (C)]], copies = 1, reference = false, separate = true, cardSnap = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6Y1tffO.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Whj6huw.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[King Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[King Knight (Costume: Wario)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Mole Knight"] = { panelGUID = [[0e101c]], season = [[4]], borderColor = { 113/255, 59/255, 23/255, 1}, legal = seasonLegal, assetName = [[MoleKnight]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/djfLNqb.jpg]], charCard = [[Mole Knight (C)]], announcement = [[† digdigdigdigdigdigdig burrowburrowburrowburrowburrowburrowburrow †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Mole Knight",
      Description = [[S4, Difficulty 2* (Beginner-Friendly+)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/f2IYGbO.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JKkbrbm.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7YiXZD1.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Burrow Dig ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Headbutt ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Diving Dig ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Block Push ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Belly Slide ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Erupt ;1 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Cave In ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ttr2T9I.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZNNT5EY.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Burrow (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]], -- April Fool's Exceed
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wVx5US3.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iYsX7ao.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/FjUlTmd.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AcvNFft.jpg]],
        altfaceURL = [[https://i.imgur.com/XeMAFOx.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/lssScdQ.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Mole Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Mole Knight]], position = { z = row5Z, y = characterIconY, x = column2X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Taizo Hori",
        costumeDescription = [[Costume based on Taizo Hori from Atari's Dig Dug.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Mole Knight]],
        costumeAttackBack = [[https://i.imgur.com/djfLNqb.jpg]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/7YiXZD1.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Burrow Dig ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Headbutt ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Diving Dig ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Block Push ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Belly Slide ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Erupt ;1 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Cave In ;1 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/ttr2T9I.jpg]],
            backURL = [[https://i.imgur.com/ZNNT5EY.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Burrow (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QE1LsgA.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PzAXGZM.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Mole Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Mole Knight (Costume: Taizo Hori)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Plague Knight"] = { panelGUID = [[0e101c]], season = [[4]], borderColor = { 113/255, 59/255, 23/255, 1}, legal = seasonLegal, assetName = [[PlagueKnight]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fncv8EO.jpg]], charCard = [[Plague Knight (C)]], announcement = [[† Can you explode and then explode again? †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Plague Knight",
      Description = [[S4, Difficulty 3* (Intermediate+)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LFO5AIH.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vdCW0hq.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nW70UrN.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Perfect Pitch ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Staff of Surging ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Long Pitch ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Chain Reaction ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Giant Bomb ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Castle Crasher ;3 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Triple Dose ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]], -- April Fool's Exceed
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/x9bmgmn.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Vt5EVU9.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/q4kA8Ef.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bCXBHNl.jpg]],
        altfaceURL = [[https://i.imgur.com/0id2pxL.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/tFMSf4C.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Plague Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Plague Knight]], position = { z = row5Z, y = characterIconY, x = column4X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Bomberman",
        costumeDescription = [[Costume based on Bomberman from Hudson Soft's Bomberman.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[A Robot Named Fight]],
        costumeAttackBack = [[https://i.imgur.com/fncv8EO.jpg]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/nW70UrN.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Perfect Pitch ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Staff of Surging ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Long Pitch ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Chain Reaction ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Giant Bomb ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Castle Crasher ;3 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Triple Dose ;1 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SeYR6GI.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4GyjZ7z.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Plague Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Plague Knight (Costume: Bomberman)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Polar Knight"] = { panelGUID = [[0e101c]], season = [[4]], borderColor = { 113/255, 59/255, 23/255, 1}, legal = seasonLegal, assetName = [[PolarKnight]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RrodOn3.jpg]], charCard = [[Polar Knight (C)]], announcement = [[† Ice to meet you! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Polar Knight",
      Description = [[S4, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/p5hV3cN.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jjRjc5I.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0d2KK6g.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Stomp ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Shovel Charge ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Shovel Slam ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Polar Plow ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Shovel Drop ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Icicle Drop ;2 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Snow Slash ;0 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nYf8GqL.jpg]],
        backURL = [[https://i.imgur.com/nYf8GqL.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Ice Spike (C)]],
            copies = 5, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]], -- April Fool's Exceed
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vInTTAc.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tBnEUdM.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RMYPlnv.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/shgweee.jpg]],
        altfaceURL = [[https://i.imgur.com/25uN4r0.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/PmPlnpz.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Polar Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Polar Knight]], position = { z = row7Z, y = characterIconY, x = column4X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Guts Man",
        costumeDescription = [[Costume based on Guts Man from Capcom's Mega Man.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Polar Knight]],
        costumeAttackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zFWi5Vd.jpg]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/0d2KK6g.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Stomp ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Shovel Charge ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Shovel Slam ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Polar Plow ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Shovel Drop ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Icicle Drop ;2 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Snow Slash ;0 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[4]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1XM1AVI.png]],
            backURL = [[https://i.imgur.com/1XM1AVI.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Ice Spike (C)]],
                copies = 5, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, cardDescription = [[Polar Knight (Costume: Guts Man)]]},
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/v0P6QFA.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1LQzi0J.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Polar Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Polar Knight (Costume: Guts Man)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Propeller Knight"] = { panelGUID = [[0e101c]], season = [[4]], borderColor = { 113/255, 59/255, 23/255, 1}, legal = seasonLegal, assetName = [[PropellerKnight]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WerX1bQ.jpg]], charCard = [[Propeller Knight (C)]], announcement = [[† I'm a huge fan! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Propeller Knight",
      Description = [[S4, Difficulty 1 (Novice)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rqQtWNB.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/5ZBoRln.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cpPy0ax.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Swoop ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Saber Lunge ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Headwind ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Cannonball ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Propeller Pull ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Launcher ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Full Broadside ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]], -- April Fool's Exceed
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kMx7MAX.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xl7WaDe.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Fw9YHpy.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4j7IwDR.jpg]],
        altfaceURL = [[https://i.imgur.com/3tUgehK.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/Nv4981e.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Propeller Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Propeller Knight]], position = { z = row7Z, y = characterIconY, x = column2X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Ryu Hyabusa",
        costumeDescription = [[Costume based on Ryu Hyabusa from Koei Tecmo's Ninja Gaiden.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Hakumen (Alternate)]],
        costumeAttackBack = [[https://i.imgur.com/MfMlgg9.jpg]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/cpPy0ax.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Swoop ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Saber Lunge ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Headwind ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Cannonball ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Propeller Pull ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Launcher ;7 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Full Broadside ;2 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Xkas1tg.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mhWCpXm.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Propeller Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Propeller Knight (Costume: Ryu Hyabusa)]]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Shovel Knight & Shield Knight"] = { panelGUID = [[0e101c]], season = [[4]], borderColor = { 113/255, 59/255, 23/255, 1}, legal = seasonLegal, assetName = [[ShovelandShield]], assetTooltip = [[
.............................
.            ...            .
.            ...            .
.............................]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Y2m5n5K.jpg]], charCard = [[Shovel Knight (C)]], announcement = [[† Hey, I thought Tag was deprecated! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Shovel Knight & Shield Knight",
      Description = [[S4, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/abYMRkf.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ep8HRuA.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pHmyjXD.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Buckler Blow ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Discovery! ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Shovel Drop ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Shield Gong ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Charge Slash ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Tandem Attack ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Shield Boomerang ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[4]], -- April Fool's Exceed
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VZksNT0.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/oXnuRCB.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8VTxxbZ.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aMGfRhv.jpg]],
        altfaceURL = [[https://i.imgur.com/MNjkITU.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/Uz8f8jq.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Shield Knight (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]], -- April Fool's Exceed
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DN8i7Kx.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8C4sXko.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zvQSKLv.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/oIOeUy0.jpg]],
        altfaceURL = [[https://i.imgur.com/3KAeatp.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/VwgX1Mx.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Shovel Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Shovel Knight & Shield Knight]], position = { z = row3Z, y = characterIconY, x = column2X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Mario & Luigi",
        costumeDescription = [[Costume based on Mario and Luigi from Nintendo's Super Mario Bros.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Shovel Knight & Shield Knight]],
        costumeAttackBack = [[https://i.imgur.com/Y2m5n5K.jpg]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/pHmyjXD.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Buckler Blow ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Discovery! ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Shovel Drop ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Shield Gong ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Charge Slash ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Tandem Attack ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Shield Boomerang ;3 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[4]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XEqrNsN.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AUEjVlw.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Shield Knight (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, cardDescription = [[Shovel Knight & Shield Knight (Costume: Mario & Luigi)]] },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nSkWof1.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TW9dI07.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Shovel Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Shovel Knight & Shield Knight (Costume: Mario & Luigi)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Specter Knight"] = { panelGUID = [[0e101c]], season = [[4]], borderColor = { 113/255, 59/255, 23/255, 1}, legal = seasonLegal, assetName = [[SpecterKnight]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aGCo16y.jpg]], charCard = [[Specter Knight (C)]], announcement = [[† You don't stand a ghost of a chance! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Specter Knight",
      Description = [[S4, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ib3DxFg.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/McwnGAx.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PDUmgKR.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Spider Scythe ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Throwing Sickle ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Bounding Soul ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Spin Scythe ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Dread Talon ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Barrier Lantern ;3 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Dread Reaper ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]], -- April Fool's Exceed
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lS56fES.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8UJSS4B.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JLKu8gl.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/T5IzNfh.jpg]],
        altfaceURL = [[https://i.imgur.com/ZmIVlu4.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/qkqdzbK.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Specter Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Specter Knight]], position = { z = row6Z, y = characterIconY, x = column3X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Grim Reaper",
        costumeDescription = [[Costume based on the Grim Reaper, a folkloric psychopomp, but especially Konami's version.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Specter Knight]],
        costumeAttackBack = [[https://i.imgur.com/aGCo16y.jpg]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/PDUmgKR.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Spider Scythe ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Throwing Sickle ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Bounding Soul ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Spin Scythe ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Dread Talon ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Barrier Lantern ;3 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Dread Reaper ;3 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DMHQnf4.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jiXcUiU.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Specter Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Specter Knight (Costume: Grim Reaper)]]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Tinker Knight"] = { panelGUID = [[0e101c]], season = [[4]], borderColor = { 113/255, 59/255, 23/255, 1}, legal = seasonLegal, assetName = [[TinkerKnight]],
    attackBack = [[https://i.imgur.com/zFWi5Vd.jpg]], charCard = [[Tinker Knight (C)]], announcement = [[† Exceeding is overrated! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Tinker Knight",
      Description = [[S4, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/38Fq7fn.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ROiaXxj.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/14yY86X.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Flail ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Mobile Gear ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Wrench Toss ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Drill Arm ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Missiles ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Mech Charge ;3 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Bomb Bounce ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[4]], -- April Fool's Exceed
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gRXMG3T.jpg]],
        --altbackURL = [[https://i.imgur.com/gRXMG3T.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mugGdqS.jpg]],
        backURL = [[https://i.imgur.com/mugGdqS.jpg]],
        altfaceURL = [[https://i.imgur.com/Cuh6nWH.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/Cuh6nWH.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Tinker Knight (Exceed) (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]], -- April Fool's Exceed
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OGdwLa9.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fyfS5AW.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qJXsBRv.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Km0NYV3.jpg]],
        altfaceURL = [[https://i.imgur.com/PtIvhoO.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/b9soujT.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Tinker Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Tinker Knight]], position = { z = row1Z, y = characterIconY, x = column2X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Doctor Wily",
        costumeDescription = [[Costume based on Doctor Wiley from Capcom's Mega Man series.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Tinker Knight]],
        costumeAttackBack = [[https://i.imgur.com/zFWi5Vd.jpg]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/14yY86X.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Flail ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Mobile Gear ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Wrench Toss ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Drill Arm ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Missiles ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Mech Charge ;3 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Bomb Bounce ;2 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[4]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cpt5PMC.jpg]],
            backURL = [[https://i.imgur.com/cpt5PMC.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Tinker Knight (Exceed) (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardDescription = [[Tinker Knight (Costume: Doctor Wily)]] },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0OB7m75.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/5dox3z7.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Tinker Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Tinker Knight (Costume: Doctor Wily)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Treasure Knight"] = { panelGUID = [[0e101c]], season = [[4]], borderColor = { 113/255, 59/255, 23/255, 1}, legal = seasonLegal, assetName = [[TreasureKnight]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lER7O5b.jpg]], charCard = [[Treasure Knight (C)]], announcement = [[† Greed is good. †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Treasure Knight",
      Description = [[S4, Difficulty 2 (Beginner-Friendly)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/z9xSqgl.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PImqHGu.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xNXEhEF.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Scuttle Slam ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Dive Charge ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Treasure Coin ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Anchor Launch ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Aqua Mine ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Maelstrom Chest ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Angler Call ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]], -- April Fool's Exceed
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/adIICn8.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2YFb251.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3dcm4I1.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VT2RIBH.jpg]],
        altfaceURL = [[https://i.imgur.com/P3kkr1h.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/DpMF8nI.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Treasure Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Treasure Knight]], position = { z = row1Z, y = characterIconY, x = column4X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Rad Spencer",
        costumeDescription = [[Costume based on Rad Specter from Capcom's Bionic Commando series.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[A Robot Named Fight]],
        costumeAttackBack = [[https://i.imgur.com/Ep5ma7U.jpg]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/xNXEhEF.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Scuttle Slam ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Dive Charge ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Treasure Coin ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Anchor Launch ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Aqua Mine ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Maelstrom Chest ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Angler Call ;1 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6CICcHq.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1EfOSr2.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Treasure Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Treasure Knight (Costume: Rad Spencer)]]},
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
      id = "Season 4 Base",
      image = "RosterS4",
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
      id = "Random4",
      tooltip = [[Random
Season 4]],
      active = true,
      height = iconSize,
      width = iconSize,
      position = { x = column3X, z = row4Z, y = characterIconY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 0, g = 1, b = 0, a = transparencyValue },
      clickable = "true",
      onClick = self.getGUID().."/uiClick_Random",
      --[[ 2023-08-19: Disabling hover images to attempt to improve load times.
      hoverTooltip = blankTooltip,
      hoverImage = "RandomS4",
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
    debugLog{ "Roster S4, per-char loop: "..charName, 2, {1,1,1} }

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
        colors = [[rgba(0,0,0,0.1)|rgba(]]..(177/255)..[[,]]..(123/255)..[[,]]..(87/255)..[[,1)|rgba(0.7,0.7,0.7,0.9)]], -- Applied on top of the background color, for some reason.
        color = [[rgba(]]..(113/255)..[[,]]..(59/255)..[[,]]..(23/255)..[[,1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS4Icon",
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
        colors = [[rgba(0,0,0,0.1)|rgba(0.5,0.3,0.2,1)|rgba(]]..(113/255)..[[,]]..(59/255)..[[,]]..(23/255)..[[,1)]], -- Applied on top of the background color, for some reason.
        color = [[rgba(1,1,1,0.1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS4Icon",
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