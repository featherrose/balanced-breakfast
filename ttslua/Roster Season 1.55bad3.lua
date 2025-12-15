function setup()

  isHidden = false

  local playmatStationGUID = Global.getVar("playmatStationGUID")
  local characterStationGUID = Global.getVar("characterStationGUID")
  local seasonLegal = false

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
  normalsToggleName = "Red Horizon"

  normalsSheets = {}
  normalsSheets["Red Horizon"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3wJKVis.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    }, --[[ end deck ]]
    UNNormals = { suffix = [[ (UN)(N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HO2yMYE.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Red Horizon (Alternate)"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PFHTq9B.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    }, --[[ end deck ]]
    UNNormals = { suffix = [[ (UN)(N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://i.imgur.com/HO2yMYE.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Esper X"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ezQKkAf.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Mage Wars"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iSoICQ1.jpg",
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

  local row1Z = 73.25
  local row2Z = 49
  local row3Z = 24.5
  local row4Z = 0
  local row5Z = -24.25
  local row6Z = -48.75
  local row7Z = -77
  local row8Z = -107.5
  local column1X = -24.25
  local column2X = -12.125
  local column3X = 0
  local column4X = 12.125
  local column5X = 24.5
  local characterIconY = -100

  local iconSize = 23
  local btnScale = 115

  local togglePanelX = -40
  local togglePanelZ = 74.5
  local togglePanelY = -100

  local togglePanelSize = 60

  local normalsToggleX = 40
  local normalsToggleZ = 74.5
  local normalsToggleY = -80

  local normalsToggleSize = 50

  charTable = {}
  -- Season 0
  charTable["Jemina (Esper X)"] = { panelGUID = [[0e101c]], season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true, assetName = [[Jemina]],
    charCard = [[Jemina (C)]],
    deckDescription = [[Posted online by L99, but never printed!]],
    --[=[
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "CHARACTERNAME",
      Description = [[DESCRIPTIONPASSAGEHERE]],
      CustomImage = {
        ImageURL = [[FACEURLHERE]],
        ImageSecondaryURL = [[BACKURLHERE]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    --]=]
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/m65eyyw.jpg]],
        --altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Jiujitsu Grasp ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Reverse Double Cross ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Tackle Assault ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Intercept Spike ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Faultless Focus ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[High Dive ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Sweep the Competition ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8UMzeFb.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gf2E5f6.jpg]],
        altfaceURL = [[https://i.imgur.com/v9VyjQQ.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/ngBQ1R4.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3T9hQuA.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NwyuLS2.jpg]], -- April Fool's Exceed 2022
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Jemina (C)]],
            copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Esper X]], position = { x = column5X, z = row8Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Daisy",
        costumeDescription = [[Daisy © Nintendo.
Costume design by Moriatti!]],
        costumeNormals = [[Esper X]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/m65eyyw.jpg]],
            --altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Jiujitsu Grasp ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Reverse Double Cross ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Tackle Assault ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Intercept Spike ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Faultless Focus ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[High Dive ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Sweep the Competition ;2 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KvUsMpO.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/t9DKIuA.jpg]],
            --altfaceURL = [[REMASTERED]],
            --altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Jemina (C)]],
                copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", cardDescription = [[Jemina (Costume: Daisy)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Juno (Esper X)"] = { panelGUID = [[0e101c]], season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true, assetName = [[Juno]], charCard = [[Juno (C)]], announcement = [[† Never miss a beat! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Juno (Esper X)",
      Description = [[S1, Difficulty 2* (Beginner-Friendly+)
Juno is a fast, technical, all-range striker who can reuse Boosts for extremely consistent stats and mobility. At most ranges, she has no equal.]],
      CustomImage = {
        ImageURL = [[https://cdn.discordapp.com/attachments/541759161457836062/691829817481363516/refcard.juno.png]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EqUoAFw.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/drpuVvM.jpg]],
        --altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Sonic Comet ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Comet Tail ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Technic Beat ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Rhythm Beat ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Star Struck ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Juno ~ Live ;9 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Meteor Jam ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Qdh8FiQ.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fY0zZ8C.jpg]],
        altfaceURL = [[https://i.imgur.com/NweHz4Q.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/tsAzmDL.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/eHGfMcR.jpg]], -- April Fool's Exceed 2022
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pbERyRN.jpg]], -- April Fool's Exceed 2022
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Juno (C)]],
            copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Esper X]], position = { x = column1X, z = row8Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Ariana",
        costumeDescription = [[Ariana Grande © herself, Sephiroth © Square Enix.
This one is Moriatti's fault.]],
        --costumeNormals = [[COSTUMENORMALS]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/drpuVvM.jpg]],
            --altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Sonic Comet ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Comet Tail ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Technic Beat ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Rhythm Beat ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Star Struck ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Juno ~ Live ;9 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Meteor Jam ;5 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DlEMtWX.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EozJ8uH.jpg]],
            --altfaceURL = [[REMASTERED]],
            --altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Juno (C)]],
                copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", cardDescription = [[Juno (Costume: Ariana)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Alice"] = { panelGUID = [[0e101c]], season = [[0]], borderColor = { 0, 0, 0, 1}, legal = false, excludeFromRandomAny = true, assetName = [[Alice]], charCard = [[Alice (C)]], announcement = [[† Die, you monster! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Alice",
      Description = [[S1, Difficulty 3* (Intermediate+)
Alice is a swift, opportunistic ranger with matchless speed, power, and control effects at specific ranges. She has no equal.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843861663/6E59CAA594F423E88293F472C1986609E4181667/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/afdN980.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SDrVEDD.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Soul Gazer ;8 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Guardian Slasher ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Sword & Cross ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Dark Corruption ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Bloody Baptism ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Surprise Punishment ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Cross Blades ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Tnmxvd7.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UlpBAxj.jpg]],
        altfaceURL = [[https://i.imgur.com/dJGshaz.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/PppoCPG.png]], -- April Fool's Exceed 2023
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rIfNDmr.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bCIzoxw.jpg]],
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Z88rBFS.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/G5ju9pM.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Alice (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column3X, z = row8Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Guidance Alice",
        costumeDescription = [[Guidance Alice from Organized Play!]],
        --costumeNormals = [[COSTUMENORMALS]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/afdN980.jpg]],
            altfaceURL = [[https://i.imgur.com/SDrVEDD.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Soul Gazer ;8 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Guardian Slasher ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Sword & Cross ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Dark Corruption ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Bloody Baptism ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Surprise Punishment ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Cross Blades ;1 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/y5xx2F7.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CcBxhNA.jpg]],
            --altfaceURL = [[https://i.imgur.com/Z88rBFS.jpg]],
            --altbackURL = [[https://i.imgur.com/G5ju9pM.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Alice (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", cardDescription = [[Alice (Costume: Guidance Alice)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }

  -- Season 1
  charTable["Baelkhor"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Baelkhor]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/C1XNRx5.jpg]], charCard = [[Baelkhor (C)]], announcement = [[† Baelkhor is a sealing fan! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Baelkhor",
      Description = [[S1, Difficulty 4 (Advanced)
Baelkhor is a risky, mid-range juggernaut who is willing to make poor early trades in return for huge late-game stats.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843861775/FFCF0606564BD6E294C188C99086E2D002F781EE/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/afvse8o.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7l61zav.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Soul Ripper ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Accursed Gaze ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Storm of Souls ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Blade of Souls ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Desperate Might ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[From Hell ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Desperate Gambit ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HXQ3GkP.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Hc1fzhO.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DB4I2lL.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9WudLDU.jpg]],
        altfaceURL = [[https://i.imgur.com/RUhjLvq.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/NIoIHfw.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/doZ2RUQ.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jgtlrTt.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Baelkhor (C)]],
            copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column1X, z = row2Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "College Baelkhor",
        costumeDescription = [[Costume design by Moriatti!]],
        costumeAttackBack = [[https://i.imgur.com/C1XNRx5.jpg]],
        costumeNormals = [[BlazBlue (Diverse)]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/afvse8o.jpg]],
            altfaceURL = [[https://i.imgur.com/7l61zav.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Soul Ripper ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Accursed Gaze ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Storm of Souls ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Blade of Souls ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Desperate Might ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[From Hell ;7 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Desperate Gambit ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/T7rdoRs.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LMsFwbH.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Baelkhor (C)]],
                copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Baelkhor (Costume: College Baelkhor)]]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list
    }
  charTable["Devris (Mage Wars)"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Devris]], charCard = [[Devris (C)]], announcement = [[† Watch the world burn! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Devris (Mage Wars)",
      Description = [[S1, Difficulty 3 (Intermediate)
Devris is a patient, technical brawler who stores up power to unleash overwhelming payouts at any range.]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/BPDzH2U.png]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WHvmgsV.jpg]],
        --altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Phantasmal Might ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Summoned Assailants ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Drain Life ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Marked For Death ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Combustion ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Firestream ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Demonbond ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yBNsQjR.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UYvQkKX.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sOrPJTO.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KOgVUbS.jpg]],
        altfaceURL = [[https://i.imgur.com/qh51mlU.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/9EM9P34.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[REMASTERED]],
        --altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Devris (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Mage Wars]], position = { x = column3X, z = row7Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Lute",
        costumeDescription = [[Fire Emblem © Nintendo.
Costume design by Moriatti!!]],
        costumeNormals = [[Mage Wars]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/WHvmgsV.jpg]],
            --altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Phantasmal Might ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Summoned Assailants ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Drain Life ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Marked For Death ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Combustion ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Firestream ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Demonbond ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wDPkyXc.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QJEa0hP.png]],
            --altfaceURL = [[REMASTERED]],
            --altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Devris (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Devris (Costume: Lute)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Eva"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal,  assetName = [[Eva]], charCard = [[Eva (C)]], announcement = [[† Normals are the key to victory! ��]],
  referenceChip = { Name = "Custom_Tile",
    Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
    Nickname = "Eva",
    Description = [[S1, Difficulty 4 (Advanced)
Eva is a slow fighter with deceptively low stats who powers up with reusable Boosts to unleash unstoppable payout attacks.]],
    CustomImage = {
      ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843861890/63B8027C2CDD57B8E9C3A49FB26CA875CA0148C7/]],
      ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
      CustomTile = { Thickness = 0.1, Stretch = true, }
    }
  },
  deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ocjo1Ag.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/utaOTig.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Cyber Destroyer ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Upgrade ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Riot Machine ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Plasma Barrage ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Enki Thresher ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Harnessing Chaos ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Shifting Technology ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tMnkO6O.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iWNWMZa.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IXcsiqh.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GTKOmhz.jpg]],
        altfaceURL = [[https://i.imgur.com/NPPlauI.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/fY9z9w3.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/g2ybFE8.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6n1HNyu.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Eva (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column1X, z = row5Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 2, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Ordinary Girl Eva",
        costumeDescription = [[Ordinary Girl Eva from Organized Play, and an altered Exceed Mode by totalhavok!]],
        --costumeNormals = [[COSTUMENORMALS]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/ocjo1Ag.jpg]],
            altfaceURL = [[https://i.imgur.com/utaOTig.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Cyber Destroyer ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Upgrade ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Riot Machine ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Plasma Barrage ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Enki Thresher ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Harnessing Chaos ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Shifting Technology ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/myVaLp4.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZbH9D4X.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Eva (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Eva (Costume: Ordinary Girl Eva)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Gabrek"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Gabrek]], charCard = [[Gabrek (C)]], announcement = [[† Put on your dancing shoes! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Gabrek",
      Description = [[S1, Difficulty 2 (Beginner-Friendly)
Gabrek is slow, patient grappler who wants to take the fight to melee range and keep it there.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843862035/934536FB1F4B65B80CF984A91954AE0E40A1CE53/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bOb3rzt.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HasRrcc.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Lunar Launcher ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Perilous Descent ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Choke Hold ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Shrug Off ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Rolling Ankle Grab ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[13th Story Oblivion ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Death Valley Face Plant ;0 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fGN0x5G.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HKfLKue.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xhHZ4jB.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/76x8k2d.jpg]],
        altfaceURL = [[https://i.imgur.com/XmluiPY.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/IYzI9Tk.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TMD8KfL.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bK88zsS.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Gabrek (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column5X, z = row6Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Lord Gabrek",
        costumeDescription = [[Lord Gabrek from Organized Play, "goth guy 2" art by brolo!]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/bOb3rzt.jpg]],
            altfaceURL = [[https://i.imgur.com/HasRrcc.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Lunar Launcher ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Perilous Descent ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Choke Hold ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Shrug Off ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Rolling Ankle Grab ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[13th Story Oblivion ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Death Valley Face Plant ;0 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Nie5st8.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/b8zMO39.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Gabrek (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Gabrek (Costume: Lord Gabrek)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Heidi"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Heidi]], charCard = [[Heidi (C)]], announcement = [[† Boost your resolve with boundless vigor! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Heidi",
      Description = [[S1, Difficulty 1 (Novice)
Heidi is a patient fighter who builds up her strength by "cheating" powerful Boosts into play without paying their costs.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843862150/178AF959B4E5A7D1C5E0866F37FC62ABBB746CBA/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aAD5QlY.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xV4X6XZ.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Dagger Strike - Install ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Iron Knuckle ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Mech Cannon ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Steel Driver ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Artillery Cannon ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Dagger Storm - Drei Install ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Rail Driver ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GFdMxZK.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/83WKLiJ.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CofAnhd.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pJ0IQIe.jpg]],
        altfaceURL = [[https://i.imgur.com/4wCoblT.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/kWAuTFr.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aJJRUZ9.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rXp9Jia.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Heidi (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column5X, z = row3Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Boundless Heidi",
        costumeDescription = [[Boundless Heidi from Organized Play!]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/aAD5QlY.jpg]],
            altfaceURL = [[https://i.imgur.com/xV4X6XZ.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Dagger Strike - Install ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Iron Knuckle ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Mech Cannon ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Steel Driver ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Artillery Cannon ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Dagger Storm - Drei Install ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Rail Driver ;2 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vEB7zLF.jpg]],
            backURL = [[https://i.imgur.com/zZ4SY4N.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Heidi (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Heidi (Costume: Boundless Heidi)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Kaden"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Kaden]], charCard = [[Kaden (C)]], announcement = [[† Ring any bells? †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Kaden",
      Description = [[S1, Difficulty 2 (Beginner-Friendly)
Kaden is a slow, short-range counterattacker with unimpressive stats, but strong recursion and search effects.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843862244/2E0242CB6C00354493345581B26665691222D15F/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KYoqC5G.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GBux8z5.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Chain Strike ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Havoc Call ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Calamity Bell ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Fusion Bane ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Double Charge Executioner ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Dark Tide Summon ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Rising Host ;6 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Z0RtHht.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nXUb8ZB.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4InSEpY.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aFAhtgX.jpg]],
        altfaceURL = [[https://i.imgur.com/61CzLHw.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/HjosdwJ.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0PRzYUG.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/beNGsoy.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Kaden (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column1X, z = row4Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Human Kaden",
        costumeDescription = [[Human Kaden from Organized Play!]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/KYoqC5G.jpg]],
            altfaceURL = [[https://i.imgur.com/GBux8z5.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Chain Strike ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Havoc Call ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Calamity Bell ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Fusion Bane ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Double Charge Executioner ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Dark Tide Summon ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Rising Host ;6 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Aet08Mx.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hj7rD8q.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Kaden (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Kaden (Costume: Human Kaden)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Lily"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Lily]], charCard = [[Lily (C)]], announcement = [[��� It's the Magic Bullet! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Lily",
      Description = [[S1, Difficulty 1** (Novice++)
Lily is a quick, nimble ranger who needs to keep her distance; she can hit with practically anything given some space.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843862336/12EDF7CAB2976A29E6BE34E62749707452C90005/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/S4yZWRd.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RyVEcZj.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Excessive Force ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Hair Trigger ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Double Tap ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Mug Shot ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Bullet Barrage ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[The Magic Bullet ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[The Wild Bunch ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Tgxy6QA.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vxenXNQ.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bJH0VfG.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SOBQMFy.jpg]],
        altfaceURL = [[https://i.imgur.com/Ea13sxv.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/BWBdaGR.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/67VrKbg.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SxiEH1k.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Lily (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column1X, z = row3Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Easter Lily",
        costumeDescription = [[Not Alone and Easter Lily by Genzoman (the latter was a rejected Organized Play costume)!]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/S4yZWRd.jpg]],
            altfaceURL = [[https://i.imgur.com/RyVEcZj.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Excessive Force ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Hair Trigger ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Double Tap ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Mug Shot ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Bullet Barrage ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[The Magic Bullet ;7 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[The Wild Bunch ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PCHPhNj.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GUFP5pq.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Lily (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Lily (Costume: Easter Lily)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Mei Lien"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[MeiLien]], charCard = [[Mei Lien (C)]], announcement = [[† Quit dragon your feet! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Mei Lien",
      Description = [[S1, Difficulty 3* (Intermediate+)
Mei Lien is a swift, agile ranger whose ability can grant her unexpected Range or extraordinary Power. At long ranges, she has no equal.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843862426/818AA86E207FD552F3D92096006918B2FD38AE79/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WXccKrw.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ij6Tz5n.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Raijin Knife ;8 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Cloud Rider ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Fujin Drum ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Halberdier ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Dragon Thrash ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Dragon Tempest ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Raijin Oath ;6 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8NxTrd8.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lH4cQYe.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/E0tid05.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/A9iRrAL.jpg]],
        altfaceURL = [[https://i.imgur.com/264bk9T.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/C52cWtc.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/k10cQcW.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Vdg324i.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Mei Lien (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column5X, z = row2Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Guardian Mei Lien",
        costumeDescription = [[Guardian Mei Lien from Organized Play!]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/WXccKrw.jpg]],
            altfaceURL = [[https://i.imgur.com/ij6Tz5n.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Raijin Knife ;8 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Cloud Rider ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Fujin Drum ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Halberdier ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Dragon Thrash ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Dragon Tempest ;7 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Raijin Oath ;6 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6WYywBc.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ELYA3EH.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Mei Lien (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Mei Lien (Costume: Guardian Mei Lien)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Miska"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Miska]], assetTooltip = [[
.............................
.            ...            .
.            ...            .
.............................]], charCard = [[Miska (C)]], announcement = [[† Optimal Range is several towns away! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Miska (& Bear)",
      Description = [[S1, Difficulty 3 (Intermediate)
Miska is a slow ranged striker who prefers to use her own attacks at extreme range or her companion's attacks to maintain distance.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843862523/E35C6A4FBB1F4CB49D536D34BDC61322F3CE9812/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jTE5kSD.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9rW8gL9.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Silver Fang ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Bear Rush ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Knee Capper ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Canine Strike ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Fire in the Hole! ;0 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Savage Wildsider ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Scorched Earth ;0 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      {
        deckID = [[4]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1frCAWW.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Y9Gr5qa.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NLLg0O4.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/oxHJT2S.jpg]],
        altfaceURL = [[https://i.imgur.com/ZGEmj2r.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/9KHwcX1.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mIsNbAA.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HtXkzLE.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Bear (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dJjfbRx.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/oAZMXz0.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/FI1vB51.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pKL4W2c.jpg]],
        altfaceURL = [[https://i.imgur.com/8Qj0o2A.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/KjQfAWp.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/myen2gH.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jZtQwnv.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Miska (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column3X, z = row3Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Strength in Numbers Miska",
        costumeDescription = [[Strength in Numbers art from Jasco's UFS!]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/jTE5kSD.jpg]],
            altfaceURL = [[https://i.imgur.com/9rW8gL9.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Silver Fang ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Bear Rush ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Knee Capper ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Canine Strike ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Fire in the Hole! ;0 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Savage Wildsider ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Scorched Earth ;0 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          {
            deckID = [[4]],
            faceURL = [[https://i.imgur.com/NLLg0O4.jpg]],
            backURL = [[https://i.imgur.com/oxHJT2S.jpg]],
            altfaceURL = [[https://i.imgur.com/mIsNbAA.jpg]],
            altbackURL = [[https://i.imgur.com/HtXkzLE.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Bear (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardScript = markerScript, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dCwQkRL.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/k9hRTdI.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Miska (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Miska (Costume: Strength in Numbers Miska)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Morathi"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Morathi]], charCard = [[Morathi (C)]], announcement = [[† GROUND NOT WORK NO MORE! WRATHY HIT YOU WITH SKY! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Morathi",
      Description = [[S1, Difficulty 3 (Intermediate)
Morathi is a brutal, close-range fighter who prefers to Wild Swing as often as possible, using his hand as resources to chase down fleeing opponents.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843862612/5CB4AD5D1DF9D041CFCAD6871508018E35DBF5BE/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nRM3cyc.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pOSETzG.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Neck Snapper ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Ivory Ghost Charge ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Gyro Chain Gash ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Ivory Ghost Impalement ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Revenger ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Shadow of Death ;8 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[God of War ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QvHyuoD.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ai5xsSa.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zigrNhy.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CAW4jXT.jpg]],
        altfaceURL = [[https://i.imgur.com/6NAicRN.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/EB1Xp8K.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1ujQSuL.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vcNTmIU.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Morathi (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column3X, z = row2Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Deadly Morathi",
        costumeDescription = [[Deadly Morathi from Organized Play!]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/nRM3cyc.jpg]],
            altfaceURL = [[https://i.imgur.com/pOSETzG.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Neck Snapper ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Ivory Ghost Charge ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Gyro Chain Gash ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Ivory Ghost Impalement ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Revenger ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Shadow of Death ;8 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[God of War ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6UZQ4Ht.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/psNEXN5.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Morathi (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Morathi (Costume: Deadly Morathi)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Nehtali"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Nehtali]], charCard = [[Nehtali (C)]], announcement = [[† Exceeding is not for everyone. Consult your doctor before use. †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Nehtali",
      Description = [[S1, Difficulty 2 (Beginner-Friendly)
Nehtali is a weak, technical ranger who rapidly gathers power, then manipulates opponent positioning to guarantee devastating payouts.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843862710/B4A28760ECB5ABA80029E61BD171C22F2C928AEA/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8A2nb84.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qkiVEvB.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Soul Thresher ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Azazel's Torment ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Hellfire ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Darkness Barrier ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Volt Damnation ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Hell's Salvation ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Heaven's Punishment ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jvpLyCl.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hjHMqJM.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/I34GUf9.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VJ5ub8G.jpg]],
        altfaceURL = [[https://i.imgur.com/HHVmrG9.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/W8O6IFW.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NgiSPct.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kxmRNbS.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Nehtali (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column5X, z = row5Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 2, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Executive Nehtali",
        costumeDescription = [[Executive Nehtali from Organized Play!]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/8A2nb84.jpg]],
            altfaceURL = [[https://i.imgur.com/qkiVEvB.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Soul Thresher ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Azazel's Torment ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Hellfire ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Darkness Barrier ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Volt Damnation ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Hell's Salvation ;7 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Heaven's Punishment ;5 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vnvssDC.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rQ8gFO5.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Nehtali (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Nehtali (Costume: Executive Nehtali)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Reese"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Reese]], charCard = [[Reese (C)]], announcement = [[† Press the Advantage! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Reese",
      Description = [[S1, Difficulty 2* (Beginner-Friendly+)
Reese is an aggressive, rushdown fighter who forces his opponent to keep up with his reckless pace.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843862806/854EEE2255D354E47CC67A3CE3470E52B649DF1E/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rZtewsp.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KJtUZtT.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Gauntlet Flurry ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Knight Wave ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Ballista ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Chivalry ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Gallant Defender ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Sovereign Glory ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Checkmate ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Et2EprG.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/topZAiE.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cyLWZKE.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SLgOyRh.jpg]],
        altfaceURL = [[https://i.imgur.com/bCJa6VG.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/wFGffzf.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/eUl8t6c.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3Ff4v7c.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Reese (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column5X, z = row4Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Racer Reese",
        costumeDescription = [[Racer Reese from Organized Play!]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/rZtewsp.jpg]],
            altfaceURL = [[https://i.imgur.com/KJtUZtT.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Gauntlet Flurry ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Knight Wave ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Ballista ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Chivalry ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Gallant Defender ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Sovereign Glory ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Checkmate ;1 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zNxA1Q0.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2yFwdG6.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Reese (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Reese (Costume: Racer Reese)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Satoshi"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Satoshi]], charCard = [[Satoshi (C)]], announcement = [[† Did you hear about the ninja comedian? No? It must've slipped past you. †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Satoshi",
      Description = [[S1, Difficulty 4 (Advanced)
Satoshi is a deadly, opportunistic ninja who waits for a moment of weakness, then presses the advantage as long as possible.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843862900/F7E790737BCFCB4AA00B54345A52F8C1F6D3A93D/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/olIZ6aO.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/btQi8Op.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Shuriken Illusion ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Sealing Strike ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Yokai Fury ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Paralyzing Dart ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Demon Slayer Slash ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Paralyzing Dust ;9 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Jigoku Banishment ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/phikQpW.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/efvHZ0P.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/YTfg08Z.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ArcVk5C.jpg]],
        altfaceURL = [[https://i.imgur.com/oTGSmOf.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/HG8jqVk.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/COooU4H.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KIUKPWx.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Satoshi (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column4X, z = row1Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Striker Satoshi",
        costumeDescription = [[Striker Satoshi from Organized Play!]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/olIZ6aO.jpg]],
            altfaceURL = [[https://i.imgur.com/btQi8Op.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Shuriken Illusion ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Sealing Strike ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Yokai Fury ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Paralyzing Dart ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Demon Slayer Slash ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Paralyzing Dust ;9 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Jigoku Banishment ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/avJpqQ9.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OKeHKlE.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Satoshi (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Satoshi (Costume: Striker Satoshi)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Super Skull Man 33"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1},
    legal = seasonLegal, assetName = [[SuperSkullMan33]], charCard = [[Super Skull Man 33 (C)]], announcement = [[† Who's your friend who likes to play? †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Super Skull Man 33",
      Description = [[S1, Difficulty 3 (Intermediate)
Super Skull Man 33 is an aggressive, close-range brawler with an unpredictable, high-risk playstyle.]],
      CustomImage = {
        ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/BC8EZEb.png]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XcAhEeU.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Qg5G45T.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Zaaaap!!! ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Bang! Bang! Bang! ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Bing Bong! ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Slam Evil ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Splam! ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Kaplow!!!! ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Zing! Zing! Zing! ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8Gp4hQn.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mAGNGi5.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kRMPLr3.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/AOCjwcl.jpg]],
        altfaceURL = [[https://i.imgur.com/JJMIc0L.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/IlbgWrW.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HmNBAkh.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OTLBcfE.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Super Skull Man 33 (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column2X, z = row1Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Smashing Skull Man",
        costumeDescription = [[UFS promo card art by brolo!]],
        costumeDeck = {
        { deckID = [[2]], faceURL = [[https://i.imgur.com/XcAhEeU.jpg]],
          altfaceURL = [[https://i.imgur.com/Qg5G45T.jpg]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Zaaaap!!! ;6 (S)]], copies = 2, reference = true, },
            { cardID = [[01]],
              cardNickname = [[Bang! Bang! Bang! ;6 (S)]], copies = 2, reference = true, },
            { cardID = [[02]],
              cardNickname = [[Bing Bong! ;5 (S)]], copies = 2, reference = true, },
            { cardID = [[03]],
              cardNickname = [[Slam Evil ;4 (S)]], copies = 2, reference = true, },
            { cardID = [[04]],
              cardNickname = [[Splam! ;4 (S)]], copies = 2, reference = true, },
            { cardID = [[05]],
              cardNickname = [[Kaplow!!!! ;6 (U)]], copies = 2, reference = true, },
            { cardID = [[06]],
              cardNickname = [[Zing! Zing! Zing! ;5 (U)]], copies = 2, reference = true, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UAKanG4.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wijDhmG.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Super Skull Man 33 (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Super Skull Man 33 (Costume: Smashing Skull Man)]] },
            }, -- end cardList
          }, -- end subdeck
        }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Ulrik"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Ulrik]], charCard = [[Ulrik (C)]], announcement = [[† Bring the thunder! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Ulrik",
      Description = [[S1, Difficulty 1 (Novice)
Ulrik is an extremely mobile fighter with strong options at all ranges, and who can virtually guarantee astonishing payouts.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843862981/F3E1223CAB3752765D31A1B238AE123235D3B1B9/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GZfHxkg.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2IDXwgA.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Lightning Javelin ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[100 Million Volts ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Blitz Hammer ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Ionization ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Inevitability ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Second Strike ;8 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Atomic Bolt ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zIa1tJm.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/17qb9os.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6Gt0NKN.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IUxB8yz.jpg]],
        altfaceURL = [[https://i.imgur.com/h55P8hn.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/StrkJ3l.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/SHxCBg5.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Cw8fInX.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Ulrik (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column3X, z = row6Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Prepared Ulrik",
        costumeDescription = [[Prepared Ulrik from Organized Play!
(And Hot Ulrik from the Organized Play materials!)]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/GZfHxkg.jpg]],
            altfaceURL = [[https://i.imgur.com/2IDXwgA.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Lightning Javelin ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[100 Million Volts ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Blitz Hammer ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Ionization ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Inevitability ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Second Strike ;8 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Atomic Bolt ;5 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mxNFwjd.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jrICaAo.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Ulrik (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Ulrik (Costume: Prepared Ulrik)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Vincent"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = seasonLegal, assetName = [[Vincent]], charCard = [[Vincent (C)]], announcement = [[�� Blatant cheating may be your only hope! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Vincent",
      Description = [[S1, Difficulty 2 (Beginner-Friendly)
Vincent is a patient melee fighter who excels at breaking the guard of slower opponents, but struggles under pressure.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843863065/8355B3A093B2832DA08705AE73332C65FEF2CDFA/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JBwtH4U.jpg]],
        altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/rfKHeXL.jpg]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Phoenix Ascent ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Gatling Punch ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Majority Whip ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[National Guard ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Crimson Barrage ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Ballot Fixing ;8 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Phoenix Revival ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fIbfaoh.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vZTdYBT.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/g6utXZh.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/okaQrxZ.jpg]],
        altfaceURL = [[https://i.imgur.com/wZdNxDB.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/UH8zYdY.png]], -- April Fool's Exceed 2023
        --altfaceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lBhpIdN.jpg]],
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/I62m84v.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Vincent (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column3X, z = row5Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "President Vincent Grey",
        costumeDescription = [[President Vincent Grey from Organized Play!]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/JBwtH4U.jpg]],
            altfaceURL = [[https://i.imgur.com/rfKHeXL.jpg]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Phoenix Ascent ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Gatling Punch ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Majority Whip ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[National Guard ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Crimson Barrage ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Ballot Fixing ;8 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Phoenix Revival ;1 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ee64sxr.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IfPKx7j.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Vincent (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Vincent (Costume: President Vincent Grey)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Zoey"] = { panelGUID = [[0e101c]], season = [[1]], borderColor = { 179/255, 0, 0, 1}, legal = false, assetName = [[Zoey]], charCard = [[Zoey (C)]], announcement = [[† It's all coming back to you now! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Zoey",
      Description = [[S1, Difficulty 3 (Intermediate)
Zoey is a nimble, flexible ranger mobile enough to get where she needs to be in order to recur her best attacks over and over.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/773984798843863163/8A3C7CCB095A45337431FAD14B48DD499DB59292/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
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
        --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ogFjDsB.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Zoey (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
          }, -- end cardList
      }, -- end subdeck
    }, normals = [[Red Horizon]], position = { x = column1X, z = row6Z, y = characterIconY, }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Zoey At Home",
        costumeDescription = [[Zoey At Home from Organized Play!]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/GozQIFa.jpg]],
            altfaceURL = [[https://i.imgur.com/si2vJLo.jpg]],
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
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7yy40LS.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/RfpmEx2.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Zoey (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", cardDescription = [[Zoey (Costume: Zoey At Home)]]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
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
      id = "Season 1 Base",
      image = "RosterS1",
      active = true,
      height = 275,
      width = 275,
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
      id = "Random1",
      tooltip = [[Random
Season 1]],
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
      hoverImage = "RandomS1",
      --]]
      hoverColor = { r = 1, g = 1, b = 1, a = 1, },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
  }

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
    debugLog{ "Roster S1, per-char loop: "..charName, 2, {1,1,1} }

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
        colors = [[rgba(0,0,0,0.1)|rgba(]]..(217/255)..[[,0.75,0.75,1)|rgba(0.7,0.7,0.7,0.9)]], -- Applied on top of the background color, for some reason.
        color = [[rgba(]]..(179/255)..[[,0,0,1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS1Icon",
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
        colors = [[rgba(0,0,0,0.1)|rgba(1,0.5,0.5,1)|rgba(]]..(179/255)..[[,0,0,1)]], -- Applied on top of the background color, for some reason.
        color = [[rgba(1,1,1,0.1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS1Icon",
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