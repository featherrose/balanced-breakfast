function setup()

  isHidden = false

  local playmatStationGUID = Global.getVar("playmatStationGUID")
  local characterStationGUID = Global.getVar("characterStationGUID")
  seasonLegal = false

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
  normalsToggleName = "Street Fighter"

  normalsSheets = {}
  normalsSheets["Street Fighter"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tXuqP40.jpg",
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

  local row1Z = 24
  local row2Z = 0
  local row3Z = -24
  local column1X = -48
  local column2X = -24
  local column3X = 0
  local column4X = 24
  local column5X = 48
  local characterIconY = -100

  local iconSize = 23
  local btnScale = 115

  local togglePanelX = 0
  local togglePanelZ = 48
  local togglePanelY = -100

  local togglePanelSize = 60

  local normalsToggleX = 0
  local normalsToggleZ = -42
  local normalsToggleY = -80

  local normalsToggleSize = 50

  charTable = {}
  -- Season 3
  charTable["Akuma"] = { panelGUID = [[0e101c]], season = [[3]], borderColor = { 31/255, 136/255, 255/255, 1}, legal = seasonLegal, assetName = [[Akuma]], charCard = [[Akuma (C)]], announcement = [[† DIE THREE OR FOUR DEATHS, AT MINIMUM! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Akuma",
      Description = "S3, Difficulty 3 (Intermediate)",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/oFzGMAz.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PVcgBaW.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/07FzZml.png]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TTbuUIL.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MR4hcwc.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Goshoryuken ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Zugaihasatsu ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Gohadoken ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Tatsumaki Zankukyaku ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Hyakkishu ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Demon Armageddon ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Wrath of the Raging Demon ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/b78Cnsh.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hgcj4TG.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/crrqVvH.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rfrBEIx.jpg]],
        altfaceURL = [[https://i.imgur.com/8CnIGNm.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/TnuownP.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[https://i.imgur.com/crrqVvH.jpg]],
        ----altbackURL = [[https://i.imgur.com/rfrBEIx.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Akuma (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], position = { z = row2Z, y = characterIconY, x = column2X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Pichu",
        costumeDescription = [[Costume based on Pichu from Nintendo's Pokémon.
Costume design by Moriatti!]],
        costumeNormals = [[The Red Dragon Inn]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/07FzZml.png]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Critical (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/TTbuUIL.jpg]],
            altfaceURL = [[https://i.imgur.com/MR4hcwc.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Goshoryuken ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Zugaihasatsu ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Gohadoken ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Tatsumaki Zankukyaku ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Hyakkishu ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Demon Armageddon ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Wrath of the Raging Demon ;3 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fcUXOhp.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/B4vlqtM.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Akuma (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Akuma (Costume: Pichu)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["C. Viper"] = { panelGUID = [[0e101c]], season = [[3]], borderColor = { 31/255, 136/255, 255/255, 1}, legal = seasonLegal, assetName = [[CViper]], charCard = [[C. Viper (C)]], announcement = [[† The best-known and most-loved Street Fighter character since Rolento! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "C. Viper",
      Description = [[S3, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wVIbwr9.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/E9D4mxW.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/5LPkkN4.png]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/L7bHwNe.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zaKoRGg.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Emergency Combination ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Burning Kick ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Thunder Knuckle ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Temple Massage ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Seismic Hammer ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Burning Dance ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Burst Time ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Fc72tkj.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Q6eGnel.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9pcVdvS.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/d6gdFhu.jpg]],
        altfaceURL = [[https://i.imgur.com/PGAz16m.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/Ta6yvvZ.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/suHXpJZ.jpg]],
        ----altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/32cPMo1.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[C. Viper (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], position = { z = row3Z, y = characterIconY, x = column3X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Verdant Viper",
        costumeDescription = [[I'm not actually sure where this particular Crimson Viper art came from.
Costume design by Moriatti!]],
        costumeNormals = [[Street Fighter]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/5LPkkN4.png]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Critical (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/L7bHwNe.jpg]],
            altfaceURL = [[https://i.imgur.com/zaKoRGg.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Emergency Combination ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Burning Kick ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Thunder Knuckle ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Temple Massage ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Seismic Hammer ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Burning Dance ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Burst Time ;2 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/V7RDchi.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uMe7Sur.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[C. Viper (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[C. Viper (Costume: Verdant Viper)]]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Cammy"] = { panelGUID = [[0e101c]], season = [[3]], borderColor = { 31/255, 136/255, 255/255, 1}, legal = seasonLegal, assetName = [[Cammy]], charCard = [[Cammy (C)]], announcement = [[† What a doll! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Cammy",
      Description = [[S3, Difficulty 1 (Novice)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Bve7j68.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UTt3ZzW.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YpbNiiD.png]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HTiaOfp.jpg]],
        --altfaceURL = [[https://i.imgur.com/HTiaOfp.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Cannon Spike ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Dive Kick ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Spiral Arrow ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Cannonball ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Razor's Edge Slicer ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Gyro Drive Smasher ;2 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[CQC ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/58PcTBv.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ovs3lyo.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GtFasOz.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4IAQ3kI.jpg]],
        altfaceURL = [[https://i.imgur.com/LCOdi5N.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/0dknTuV.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[https://i.imgur.com/GtFasOz.jpg]],
        ----altbackURL = [[https://i.imgur.com/4IAQ3kI.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Cammy (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], position = { z = row2Z, y = characterIconY, x = column5X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Duel Cammy",
        costumeDescription = [[Art from Capcom's mobile game, Street Fighter: Duel.
Costume design by Moriatti!]],
        costumeNormals = [[Street Fighter]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/YpbNiiD.png]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Critical (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/HTiaOfp.jpg]],
            --altfaceURL = [[https://i.imgur.com/HTiaOfp.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Cannon Spike ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Dive Kick ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Spiral Arrow ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Cannonball ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Razor's Edge Slicer ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Gyro Drive Smasher ;2 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[CQC ;2 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Rhegrgb.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9S5RbRY.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Cammy (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Cammy (Costume: Duel Cammy)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Chun-Li"] = { panelGUID = [[0e101c]], season = [[3]], borderColor = { 31/255, 136/255, 255/255, 1}, legal = seasonLegal, assetName = [[ChunLi]], charCard = [[Chun-Li (C)]], announcement = [[† You killed my father. Prepare to die. †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Chun-Li",
      Description = [[S3, Difficulty 3 (Intermediate)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KVLdOAH.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/D3EdvkO.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/d9Gc3UY.png]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gGLXf48.jpg]],
        --altfaceURL = [[https://i.imgur.com/gGLXf48.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Lightning Legs ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Flipping Ax Kick ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Head Stomp ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Spinning Bird Kick ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Kikoken ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Hosenka ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Kikousho ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UKwOgCO.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QkYfx2y.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8PlvX7B.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DlVnWrv.jpg]],
        altfaceURL = [[https://i.imgur.com/Fpt2PXi.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/apvBRnZ.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/oG2i5wf.jpg]],
        ----altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AJOEpQd.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Chun-Li (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], position = { z = row2Z, y = characterIconY, x = column3X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Classic Chun-Li",
        costumeDescription = [[I'm not actually sure where exactly this art is from.
Costume design by Moriatti!]],
        costumeNormals = [[Street Fighter]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/d9Gc3UY.png]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Critical (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/gGLXf48.jpg]],
            --altfaceURL = [[https://i.imgur.com/gGLXf48.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Lightning Legs ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Flipping Ax Kick ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Head Stomp ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Spinning Bird Kick ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Kikoken ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Hosenka ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Kikousho ;2 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tfTUTSE.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/s9SlLOm.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Chun-Li (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Chun-Li (Costume: Casual Chun-Li)]]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Dan"] = { panelGUID = [[0e101c]], season = [[3]], borderColor = { 31/255, 136/255, 255/255, 1}, legal = seasonLegal, assetName = [[Dan]], charCard = [[Dan (C)]], announcement = [[† He packs a meme punch! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Dan",
      Description = [[S3, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WzgGNQx.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XKqUl4s.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cR87JEh.png]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7F7oHlM.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/af7Uc88.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Saikyo Haraigoshi ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Dankukyaku ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Koryuken ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Gadouken ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Shisso Buraiken ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Legendary Taunt ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Haoh Gadouken ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fL7Z2Dz.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ahIORvH.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XlGRdjA.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ATndgNk.jpg]],
        altfaceURL = [[https://i.imgur.com/cZLE94S.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/rJQrYlF.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sh7ESVP.jpg]],
        ----altbackURL = [[https://i.imgur.com/ATndgNk.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Dan (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], position = { z = row3Z, y = characterIconY, x = column2X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Dan's the Man!",
        costumeDescription = [[Costume design by Moriatti!]],
        costumeNormals = [[Street Fighter]],
        costumeAttackBack = [[https://i.imgur.com/wTx8sqt.png]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/cR87JEh.png]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Critical (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/7F7oHlM.jpg]],
            altfaceURL = [[https://i.imgur.com/af7Uc88.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Saikyo Haraigoshi ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Dankukyaku ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Koryuken ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Gadouken ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Shisso Buraiken ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Legendary Taunt ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Haoh Gadouken ;1 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0sUQHWZ.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YDdAFzG.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Dan (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Dan (Costume: Dan's the Man!)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Guile"] = { panelGUID = [[0e101c]], season = [[3]], borderColor = { 31/255, 136/255, 255/255, 1}, legal = seasonLegal, assetName = [[Guile]], charCard = [[Guile (C)]], announcement = [[† Goes with everything! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Guile",
      Description = [[S3, Difficulty 2* (Beginner-Friendly+)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dLkWyK1.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TGhEBaD.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zVX32o8.png]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7H6UJmc.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tICGNEH.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Double Sweep Kick ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Spinning Back Knuckle ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Sonic Boom ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Reverse Spin Kick ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Flash Kick ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Sonic Hurricane ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Flash Explosion ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Y4ujh2C.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/oej2Kgy.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/E379lZa.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/5V1hb9r.jpg]],
        altfaceURL = [[https://i.imgur.com/sT6CeGZ.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/cMK2EJm.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[https://i.imgur.com/E379lZa.jpg]],
        ----altbackURL = [[https://i.imgur.com/5V1hb9r.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Guile (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], position = { z = row2Z, y = characterIconY, x = column4X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Glorious Guile",
        costumeDescription = [[Exceed Mode art from Capcom's Street Fighter: Duel.
Costume design by Moriatti!]],
        costumeNormals = [[Street Fighter]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/zVX32o8.png]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Critical (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/7H6UJmc.jpg]],
            altfaceURL = [[https://i.imgur.com/tICGNEH.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Double Sweep Kick ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Spinning Back Knuckle ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Sonic Boom ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Reverse Spin Kick ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Flash Kick ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Sonic Hurricane ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Flash Explosion ;3 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EGIeIPJ.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qOD4eq4.png]],
            altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/5JmAGwz.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Guile (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Guile (Costume: Glorious Guile)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Ken"] = { panelGUID = [[0e101c]], season = [[3]], borderColor = { 31/255, 136/255, 255/255, 1}, legal = seasonLegal, assetName = [[Ken]], charCard = [[Ken (C)]], announcement = [[† Show Ryu, Ken! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Ken",
      Description = [[S3, Difficulty 1 (Novice)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AvTxlgD.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WGcTwpz.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YR4StDQ.png]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ln74Y6r.jpg]],
        --altfaceURL = [[https://i.imgur.com/ln74Y6r.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Shoryuken ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Hadoken ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Axe Kick ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Tatsumaki Senpukyaku ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Knee Bash ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Shinryuken ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Guren Senpukyaku ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2nRSNFb.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qyrDI0Z.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ycx96uz.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AkD5ozJ.jpg]],
        altfaceURL = [[https://i.imgur.com/YHqNi8H.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/3GX5RAs.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[https://i.imgur.com/Ycx96uz.jpg]],
        ----altbackURL = [[https://i.imgur.com/AkD5ozJ.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Ken (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], position = { z = row1Z, y = characterIconY, x = column4X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Duel Ken",
        costumeDescription = [[Art from Capcom's Street Fighter: Duel.
Costume design by Moriatti!]],
        costumeNormals = [[Street Fighter]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/YR4StDQ.png]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Critical (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]],
            faceURL = [[https://i.imgur.com/ln74Y6r.jpg]],
            --altfaceURL = [[https://i.imgur.com/ln74Y6r.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Shoryuken ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Hadoken ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Axe Kick ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Tatsumaki Senpukyaku ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Knee Bash ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Shinryuken ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Guren Senpukyaku ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/BvNfdYf.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/h5fVccv.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Ken (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Ken (Costume: Duel Ken)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["M. Bison"] = { panelGUID = [[0e101c]], season = [[3]], borderColor = { 31/255, 136/255, 255/255, 1}, legal = seasonLegal, assetName = [[MBison]], charCard = [[M. Bison (C)]], announcement = [[† For you, the day Bison graced your village was the most important day of your life. But for me, it was Tuesday. †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "M. Bison",
      Description = [[S3, Difficulty 2 (Beginner-Friendly)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YKacvnz.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/44b2MBL.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pgq4EDh.png]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/30gSWlD.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TGCMaog.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Head Stomp ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Devil Reverse ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Sliding Kick ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Psycho Crusher ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Somersault Skull Diver ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Nightmare Booster ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Psycho Punisher ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GlTmwva.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7jxn8Wz.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/s1GOT0M.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4xdQdxl.jpg]],
        altfaceURL = [[https://i.imgur.com/UV0NGzb.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/ZQVHvXu.png]], -- April Fool's Exceed 2023
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[M. Bison (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], position = { z = row1Z, y = characterIconY, x = column5X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Duel Dictator",
        costumeDescription = [[Art from Capcom's Street Fighter: Duel.
Costume design by Moriatti!]],
        costumeNormals = [[Street Fighter]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/pgq4EDh.png]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Critical (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/30gSWlD.jpg]],
            altfaceURL = [[https://i.imgur.com/TGCMaog.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Head Stomp ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Devil Reverse ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Sliding Kick ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Psycho Crusher ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Somersault Skull Diver ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Nightmare Booster ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Psycho Punisher ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bb0F9pK.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/r6RlKtO.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[M. Bison (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[M. Bison (Costume: Duel Dictator)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Ryu"] = { panelGUID = [[0e101c]], season = [[3]], borderColor = { 31/255, 136/255, 255/255, 1}, legal = seasonLegal, assetName = [[Ryu]], charCard = [[Ryu (C)]], announcement = [[† Sure, Ryu can! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Ryu",
      Description = [[S3, Difficulty 1 (Novice)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uNQzTbf.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WXxlH4l.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Q7VGBCu.png]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wCqSDQh.jpg]],
        --altfaceURL = [[https://i.imgur.com/wCqSDQh.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Shoryuken ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Hadoken ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Donkey Kick ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Tatsumaki Senpukyaku ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[One Inch Punch ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Metsu Hadoken ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Metsu Shoryuken ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uevz1gl.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jwmKX5t.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dQLfmLi.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rD09jP6.jpg]],
        altfaceURL = [[https://i.imgur.com/g56gqZL.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/Iit24b6.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[https://i.imgur.com/dQLfmLi.jpg]],
        ----altbackURL = [[https://i.imgur.com/rD09jP6.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Ryu (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], position = { z = row1Z, y = characterIconY, x = column2X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Duel Ryu",
        costumeDescription = [[Art from Capcom's Street Fighter: Duel.
Costume design by Moriatti!]],
        costumeNormals = [[Street Fighter]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/Q7VGBCu.png]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Critical (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/wCqSDQh.jpg]],
            --altfaceURL = [[https://i.imgur.com/wCqSDQh.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Shoryuken ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Hadoken ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Donkey Kick ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Tatsumaki Senpukyaku ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[One Inch Punch ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Metsu Hadoken ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Metsu Shoryuken ;5 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7apVFvz.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cohtOsH.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Ryu (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Ryu (Costume: Duel Ryu)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Sagat"] = { panelGUID = [[0e101c]], season = [[3]], borderColor = { 31/255, 136/255, 255/255, 1}, legal = seasonLegal, assetName = [[Sagat]], charCard = [[Sagat (C)]], announcement = [[† America's Funniest Home Fighting Games! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Sagat",
      Description = [[S3, Difficulty 2 (Beginner-Friendly)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NyNTMyv.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lRJVlXc.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SdIXCN7.png]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aQsEq7F.jpg]],
        --altfaceURL = [[https://i.imgur.com/aQsEq7F.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Low Step Kick ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Tiger Shot ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Tiger Uppercut ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Tiger Knee ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Low Tiger Shot ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Tiger Cannon ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Tiger Destruction ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/n2lzIPy.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/x06LgcS.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/H3qjEPI.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fjAeC1W.jpg]],
        altfaceURL = [[https://i.imgur.com/Wvmof5p.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/mQ4PZEU.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[https://i.imgur.com/H3qjEPI.jpg]],
        ----altbackURL = [[https://i.imgur.com/fjAeC1W.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Sagat (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], position = { z = row1Z, y = characterIconY, x = column1X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Papelne",
        costumeDescription = [[Costume based on Papelne from The Legend of Dark Witch.
Created by D as a high-effort meme.]],
        costumeNormals = [[Seventh Cross (Alternate)]],
        --costumeOwner = { [[tirankin]], }, -- Only appears for players in this table.
        costumeFavorite = { [[tirankin]], [[HeliosAFlame]], }, -- Prioritized for players in this table (but available regardless).
        --costumePassword = [[Seijun | Sagat]], -- Locks access based on this password. Always needs to end with the character being clicked.
        --costumePasswordFavorite = [[Seijun | Sagat]], -- Prioritized based on this password. ALways needs to end with the character being clicked.
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/SdIXCN7.png]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Critical (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EPY26Pf.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Low Step Kick ;5 (S)]], copies = 2, reference = true, cardDescription = [[Sagat (Costume: Papelne)]], },
              { cardID = [[01]],
                cardNickname = [[Tiger Shot ;4 (S)]], copies = 2, reference = true, cardDescription = [[Sagat (Costume: Papelne)]], },
              { cardID = [[02]],
                cardNickname = [[Tiger Uppercut ;4 (S)]], copies = 2, reference = true, cardDescription = [[Sagat (Costume: Papelne)]], },
              { cardID = [[03]],
                cardNickname = [[Tiger Knee ;3 (S)]], copies = 2, reference = true, cardDescription = [[Sagat (Costume: Papelne)]], },
              { cardID = [[04]],
                cardNickname = [[Low Tiger Shot ;2 (S)]], copies = 2, reference = true, cardDescription = [[Sagat (Costume: Papelne)]], },
              { cardID = [[05]],
                cardNickname = [[Tiger Cannon ;6 (U)]], copies = 2, reference = true, cardDescription = [[Sagat (Costume: Papelne)]], },
              { cardID = [[06]],
                cardNickname = [[Tiger Destruction ;5 (U)]], copies = 2, reference = true, cardDescription = [[Sagat (Costume: Papelne)]], },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/80Pi8Jb.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/84eSam4.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Papelne (C)]], copies = 1, reference = false, cardDescription = [[Sagat (Costume: Papelne)]], cardMemo = "nonstackable", },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
        { -- costume begins
          costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
          costumeName = "Bob Sagat",
          costumeDescription = [[Costume based on Bob Saget (of America's Funniest Home Videos fame).
Costume design by Moriatti!]],
          costumeNormals = [[Street Fighter]],
          costumeDeck = {
            { deckID = [[4]],
              faceURL = [[https://i.imgur.com/SdIXCN7.png]],
              backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
              gridWidth = 1, gridHeight = 1,
              hiddenBack = false,
              cardList = { { cardID = [[00]],
                  cardNickname = [[Season Mechanics Reference: Critical (C)]],
                  copies = 0, reference = true, separate = false, },
                }, -- end cardList
              }, -- end subdeck
            { deckID = [[2]], faceURL = [[https://i.imgur.com/aQsEq7F.jpg]],
              --altfaceURL = [[https://i.imgur.com/aQsEq7F.jpg]],
              gridWidth = 4, gridHeight = 2,
              hiddenBack = true,
              cardList = { { cardID = [[00]],
                  cardNickname = [[Low Step Kick ;5 (S)]], copies = 2, reference = true, },
                { cardID = [[01]],
                  cardNickname = [[Tiger Shot ;4 (S)]], copies = 2, reference = true, },
                { cardID = [[02]],
                  cardNickname = [[Tiger Uppercut ;4 (S)]], copies = 2, reference = true, },
                { cardID = [[03]],
                  cardNickname = [[Tiger Knee ;3 (S)]], copies = 2, reference = true, },
                { cardID = [[04]],
                  cardNickname = [[Low Tiger Shot ;2 (S)]], copies = 2, reference = true, },
                { cardID = [[05]],
                  cardNickname = [[Tiger Cannon ;6 (U)]], copies = 2, reference = true, },
                { cardID = [[06]],
                  cardNickname = [[Tiger Destruction ;5 (U)]], copies = 2, reference = true, },
                }, -- end cardList
              }, -- end subdeck 2
            { deckID = [[3]],
              faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/eedqDWk.png]],
              backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zjyhzPW.png]],
              gridWidth = 1, gridHeight = 1,
              hiddenBack = false,
              cardList = { { cardID = [[00]],
                  cardNickname = [[Sagat (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Sagat (Costume: Bob Sagat)]] },
                }, -- end cardList
              }, -- end subdeck
            }, -- end deck
          }, -- costume ends
      }, -- end costumes table
    } -- end charTable entry
  charTable["Vega"] = { panelGUID = [[0e101c]], season = [[3]], borderColor = { 31/255, 136/255, 255/255, 1}, legal = seasonLegal, assetName = [[Vega]], charCard = [[Vega (C)]], announcement = [[† Also known as Dictator! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Vega",
      Description = [[S3, Difficulty 4 (Advanced)]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kyBIisT.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wwW2A7j.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tk50Are.png]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QVSOm50.jpg]],
        --altfaceURL = [[https://i.imgur.com/QVSOm50.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Scarlet Terror ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Flying Barcelona Attack ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Sky High Claw ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Pounce ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Rolling Crystal Flash ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Bloody High Claw ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Splendid Claw ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/00zHfMJ.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TzFk9Oc.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ef9BJn7.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RiBeRZz.jpg]],
        altfaceURL = [[https://i.imgur.com/YFoE6R8.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/dyLMULh.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[https://i.imgur.com/ef9BJn7.jpg]],
        ----altbackURL = [[https://i.imgur.com/RiBeRZz.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Vega (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], position = { z = row3Z, y = characterIconY, x = column4X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Duel Vega",
        costumeDescription = [[Vega has to put up with a lot of Dirty Bull. Art from Capcom's Street Fighter: Duel.
Costume design by Moriatti!]],
        costumeNormals = [[Street Fighter]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/tk50Are.png]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Critical (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/QVSOm50.jpg]],
            --altfaceURL = [[https://i.imgur.com/QVSOm50.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Scarlet Terror ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Flying Barcelona Attack ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Sky High Claw ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Pounce ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Rolling Crystal Flash ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Bloody High Claw ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Splendid Claw ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lnD1T9l.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kzprs1q.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Vega (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Vega (Costume: Duel Vega)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Zangief"] = { panelGUID = [[0e101c]], season = [[3]], borderColor = { 31/255, 136/255, 255/255, 1}, legal = seasonLegal, assetName = [[Zangief]], charCard = [[Zangief (C)]], announcement = [[† Zangief? He'zangrief! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Zangief",
      Description = "S3, Difficulty 1 (Novice)",
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bkFAXF5.jpg]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YWs5ckE.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lCdjuSy.png]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Critical (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7V6ulyz.jpg]],
        --altfaceURL = [[https://i.imgur.com/7V6ulyz.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Atomic Suplex ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Banishing Flat ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Spinning Piledriver ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Double Lariat ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Flying Power Bomb ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Ultimate Atomic Buster ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Siberian Blizzard ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VXFx0i2.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/761fUee.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cTRX9mh.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kloV3TF.jpg]],
        altfaceURL = [[https://i.imgur.com/aPqKzkg.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/7jiTDVo.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[https://i.imgur.com/cTRX9mh.jpg]],
        ----altbackURL = [[https://i.imgur.com/kloV3TF.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Zangief (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Street Fighter]], position = { z = row2Z, y = characterIconY, x = column1X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Mecha Zangief",
        costumeDescription = [[Okay, technically Mecha Zangief is a different character.
Costume design by Moriatti!]],
        costumeNormals = [[Street Fighter]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/lCdjuSy.png]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Critical (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/7V6ulyz.jpg]],
            --altfaceURL = [[https://i.imgur.com/7V6ulyz.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Atomic Suplex ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Banishing Flat ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Spinning Piledriver ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Double Lariat ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Flying Power Bomb ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Ultimate Atomic Buster ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Siberian Blizzard ;2 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PlMVP26.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TV1XX1y.png]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Zangief (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Zangief (Costume: Mecha Zangief)]] },
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
      id = "Season 3 Base",
      image = "RosterS3",
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
      id = "Random3",
      tooltip = [[Random
Season 3]],
      active = true,
      height = iconSize,
      width = iconSize,
      position = { x = column3X, z = row1Z, y = characterIconY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 0, g = 1, b = 0, a = transparencyValue },
      clickable = "true",
      onClick = self.getGUID().."/uiClick_Random",
      --[[ 2023-08-19: Disabling hover images to attempt to improve load times.
      hoverTooltip = blankTooltip,
      hoverImage = "RandomS3",
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
    debugLog{ "Roster S3, per-char loop: "..charName, 2, {1,1,1} }

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
        colors = [[rgba(0,0,0,0.1)|rgba(]]..(136/255)..[[,]]..(204/255)..[[,1,1)|rgba(0.7,0.7,0.7,0.9)]], -- Applied on top of the background color, for some reason.
        color = [[rgba(]]..(31/255)..[[,]]..(136/255)..[[,1,1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS3Icon",
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
        colors = [[rgba(0,0,0,0.1)|rgba(0.6,0.8,1,1)|rgba(]]..(31/255)..[[,]]..(136/255)..[[,1,1)]], -- Applied on top of the background color, for some reason.
        color = [[rgba(1,1,1,0.1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS3Icon",
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