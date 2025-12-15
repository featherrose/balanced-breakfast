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
  normalsToggleName = "Seventh Cross"

  normalsSheets = {}
  normalsSheets["Seventh Cross"] = {
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
      Grasp = "00", Cross = "01", Slash = "02", Dive = "03", Dust = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Seventh Cross (Alternate)"] = {
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
      Grasp = "00", Cross = "01", Slash = "02", Dive = "03", Dust = "04", Sweep = "05", Focus = "06", Block = "07",
    }, --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Automata"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GXSpmlE.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["The Red Dragon Inn"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/i0oElan.jpg",
      Grasp = "00", Cross = "01", Assault = "02", Dive = "03", Spike = "04", Sweep = "05", Focus = "06", Block = "07",
    } --[[ end deck ]]
  } --[[ end normalsSheets entry ]]
  normalsSheets["Shovel Knight (Solo)"] = {
    Normals = { suffix = [[ (N)]],
      gridWidth = 4, gridHeight = 2, faceURL = "https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8I86Ikv.jpg",
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

  local row1Z = 56.05
  local row2Z = 44.53
  local row3Z = 31.65
  local row4Z = 20.13
  local row5Z = 7.25
  local row6Z = -4.3
  local row7Z = -17.15
  local row8Z = -48.36
  local row9Z = -55.9
  local column1X = -48.8
  local column2X = -36.83
  local column3X = -24.4
  local column4X = 0
  local column5X = 24.4
  local column6X = 35.8
  local column7X = 48.81
  local characterIconY = -100

  local iconSize = 23
  local btnScale = 115

  local togglePanelX = column4X
  local togglePanelZ = 68.5
  local togglePanelY = -100

  local togglePanelSize = 60

  local normalsToggleX = column4X
  local normalsToggleZ = -28.5
  local normalsToggleY = -80

  local normalsToggleSize = 50

  charTable = {}

  -- Season 2
  charTable["Carl (Automata)"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[CarlSwangee]], charCard = [[Carl (C)]], announcement = [[† BEEP BOOP †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Carl (Automata)",
      Description = [[S2, Difficulty 2 (Beginner-Friendly)
Carl Swangee is a tough, close-range brawler who relies on fundamentals and enhanced Normals to make steady, positive trades.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889687326/28BA1B49A9D0ADCA42E83EE39B236F10A9CBFE03/]],
        ImageSecondaryURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EqUoAFw.jpg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/uwXhbY2.jpg]],
      ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Improvised Weapon ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Disarming Strike ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Swangee Elbow ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Cease & Desist ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Power Short ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Authorized Force ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Autonomic Response ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tJtkxgk.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TLY6wUs.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VXJqO5t.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qXFG8LI.jpg]],
        altfaceURL = [[https://i.imgur.com/EcelfiY.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/3kvWHfy.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Carl (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Automata]], position = { z = row8Z, y = characterIconY, x = column6X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Cage",
        costumeDescription = [[Cage © Brian Cage.
Costume design by Moriatti!]],
        costumeNormals = [[Street Fighter]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/uwXhbY2.jpg]],
          ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Improvised Weapon ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Disarming Strike ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Swangee Elbow ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Cease & Desist ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Power Short ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Authorized Force ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Autonomic Response ;1 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lkXHvsk.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ztjM7wm.png]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Carl (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Carl (Costume: Cage)]]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Celinka"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Celinka]], charCard = [[Celinka (C)]], announcement = [[† In the name of the moon! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Celinka",
      Description = [[S2, Difficulty 3 (Intermediate)
Celinka is a mobile, mid-range brawler whose breakneck aggression is extremely card-hungry, but who grows stronger as she loses cards.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889663774/D459E129BF33522AB61435077E90009BAE6AADA9/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EVBINDt.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
        }, -- end cardList
      }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/F8XIAfT.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Swift Exorcism ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Dispelling Horn ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Moon Fall ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Moon Flare ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Wishing Ward ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Moon Ritual Dance ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Purifying Roar ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MO7ytVd.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xlJ0gNB.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ae7yFLM.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VujuYUu.jpg]],
        altfaceURL = [[https://i.imgur.com/GaaSg3u.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/UDld3vY.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Celinka (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row1Z, y = characterIconY, x = column1X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Delver MacVaughn",
        costumeDescription = [[Delver MacVaughn © Level 99 Games.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/EVBINDt.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/F8XIAfT.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Swift Exorcism ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Dispelling Horn ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Moon Fall ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Moon Flare ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Wishing Ward ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Moon Ritual Dance ;7 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Purifying Roar ;2 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QE7tkf2.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Jy5MMYd.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Celinka (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Celinka (Costume: Delver MacVaughn)]]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["D'Janette"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[DJanette]], charCard = [[D'Janette (C)]], announcement = [[† What a horrible night to have a curse... †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "D'Janette",
      Description = [[S2, Difficulty 4 (Advanced)
D'Janette is an immobile striker who manipulates opponent positioning to buy time for her long-term goals.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889665350/7745EA069B83B863F0A56EE94A959409F099BEB3/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UbewtYg.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8i1Tf8s.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Profane Sanctuary ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Affliction ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Blood Thorns ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Black Death ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Charnel Blast ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Carmine Offering ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Death Knell ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[5]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ANkj0Gu.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gk4GgA0.jpg]],
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Spell Circle / Diabolic Aura (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardSnap = false, cardScript = markerScript, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bJHNsmi.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fJ81u3s.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LPNNmWj.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/67GKRVX.jpg]],
        altfaceURL = [[https://i.imgur.com/DKTGuW4.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/cteegLZ.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[D'Janette (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row5Z, y = characterIconY, x = column3X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Sigizmund",
        costumeDescription = [[Sigizmund © Level 99 Games.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/UbewtYg.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/8i1Tf8s.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Profane Sanctuary ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Affliction ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Blood Thorns ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Black Death ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Charnel Blast ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Carmine Offering ;7 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Death Knell ;3 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[5]],
            faceURL = [[https://i.imgur.com/ANkj0Gu.jpg]],
            backURL = [[https://i.imgur.com/gk4GgA0.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Spell Circle / Diabolic Aura (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardSnap = false, cardScript = markerScript, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/iukAaMB.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OM78lXm.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[D'Janette (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[D'Janette (Costume: Sigizmund)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Emogine"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Emogine]], charCard = [[Emogine (C)]], announcement = [[† You're the best, hands down! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Emogine",
      Description = [[S2, Difficulty 3 (Intermediate)
Emogine is a brutal, mid-range counterattacker who spends and regains life while making massive trades.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889688101/52CDA1358F14D3B6127906C646C93EB94F064988/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DwF8GM2.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Csu4Avc.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Purifying Chime ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Holy Warding ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Guilty Paean ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Blood for Blood ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Martyr's Lash ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Hand of Judgment ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Touch of Divinity ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Kc5EAzW.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/xHa8l1y.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7xgPm2g.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pUhZJcQ.jpg]],
        altfaceURL = [[https://i.imgur.com/qKBAhfN.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/t8w8jkJ.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Emogine (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row2Z, y = characterIconY, x = column4X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Llwellwyn",
        costumeDescription = [[Llwellwyn © Level 99 Games.
Thanks to Moriatti for assisting with implementation!,
        costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/DwF8GM2.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/Csu4Avc.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Purifying Chime ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Holy Warding ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Guilty Paean ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Blood for Blood ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Martyr's Lash ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Hand of Judgment ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Touch of Divinity ;2 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LlnKvoP.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kCg12dg.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Emogine (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Emogine (Costume: Llwellwyn)]]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Eugenia"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Eugenia]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JPfdUBu.jpg]], charCard = [[Eugenia (C)]], announcement = [[† 'Twas brillig, and the slithy toves / Did gyre and gimble in the wabe:
All mimsy were the borogoves, / And the mome raths outgrabe. †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Eugenia",
      Description = [[S2, Difficulty 3 (Intermediate)
Eugenia is an opportunistic, mid-range brawler who bleeds the opponent of options while poking them with superior ranges and hand disruption.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889666580/5BDD47E16DD7906CD7E71A9A37898071E66006BA/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/oK8JmQ6.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9eqZmm9.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Shimmer of Madness ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Absinthin Arrow ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Plot Hook ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Werelight ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Color Spray ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Queen of Hearts ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Cat's Cradle ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[5]],
        faceURL = [[https://i.imgur.com/JPfdUBu.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/yu6ycF0.jpg]],
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Wonderland (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardSnap = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vz3LBax.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/DgLVaAm.jpg]],
        altfaceURL = [[https://i.imgur.com/gZGWnmY.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/fFJhi1d.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Eugenia (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row3Z, y = characterIconY, x = column7X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Hringwynn",
        costumeDescription = [[Hringwynn the Taken, Eugenia's half-sister.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
              { deckID = [[4]],
                faceURL = [[https://i.imgur.com/oK8JmQ6.jpg]],
                backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
                gridWidth = 1, gridHeight = 1,
                hiddenBack = false,
                cardList = { { cardID = [[00]],
                    cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                    copies = 0, reference = true, separate = false, },
                  }, -- end cardList
                }, -- end subdeck
              { deckID = [[2]], faceURL = [[https://i.imgur.com/9eqZmm9.jpg]],
                ----altfaceURL = [[REMASTERED]],
                gridWidth = 4, gridHeight = 2,
                hiddenBack = true,
                cardList = { { cardID = [[00]],
                    cardNickname = [[Shimmer of Madness ;6 (S)]], copies = 2, reference = true, },
                  { cardID = [[01]],
                    cardNickname = [[Absinthin Arrow ;5 (S)]], copies = 2, reference = true, },
                  { cardID = [[02]],
                    cardNickname = [[Plot Hook ;4 (S)]], copies = 2, reference = true, },
                  { cardID = [[03]],
                    cardNickname = [[Werelight ;3 (S)]], copies = 2, reference = true, },
                  { cardID = [[04]],
                    cardNickname = [[Color Spray ;2 (S)]], copies = 2, reference = true, },
                  { cardID = [[05]],
                    cardNickname = [[Queen of Hearts ;7 (U)]], copies = 2, reference = true, },
                  { cardID = [[06]],
                    cardNickname = [[Cat's Cradle ;1 (U)]], copies = 2, reference = true, },
                  }, -- end cardList
                }, -- end subdeck 2
              { deckID = [[5]],
                faceURL = [[https://i.imgur.com/JPfdUBu.jpg]],
                backURL = [[https://i.imgur.com/yu6ycF0.jpg]],
                ----altfaceURL = [[REMASTERED]],
                ----altbackURL = [[REMASTERED]],
                gridWidth = 1, gridHeight = 1,
                hiddenBack = false,
                cardList = { { cardID = [[00]],
                    cardNickname = [[Wonderland (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardSnap = false, },
                  }, -- end cardList
                }, -- end subdeck
              { deckID = [[3]],
                faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/EOeHRgr.jpg]],
                backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/qqIKFAE.jpg]],
                ----altfaceURL = [[REMASTERED]],
                ----altbackURL = [[REMASTERED]],
                gridWidth = 1, gridHeight = 1,
                hiddenBack = false,
                cardList = { { cardID = [[00]],
                    cardNickname = [[Eugenia (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Eugenia (Costume: Hringwynn)]]},
                  }, -- end cardList
                }, -- end subdeck
              }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Galdred"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Galdred]], charCard = [[Galdred (C)]], announcement = [[† WILL! IT! BLEND!? †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Galdred",
      Description = [[S2, Difficulty 3 (Intermediate)
Galdred is a brutal, close-range brawler who relies on an overwhelmingly threatening Exceed Mode to make up for a weak early game.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889667468/B644C7AD0E91EABEFFB333A2466148E7E814D54F/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7b9OxkS.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/djSzinK.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Blood Frenzy ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Violent Transgression ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Explosive Cocktail ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Withering Toxin ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Eviscerate ;0 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Hydra Helix ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Metamorphosis ;6 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/T3DPvQs.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/atNyZ4d.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/5NF4GDg.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ft58Zdk.jpg]],
        altfaceURL = [[https://i.imgur.com/NvcPAvv.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/r7bAgpP.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Galdred (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row5Z, y = characterIconY, x = column7X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Yugi Moto",
        costumeDescription = [[Yu-Gi-Oh! © Konami.
Costume design by Moriatti (and a long-running joke)!]],
        costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/7b9OxkS.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/djSzinK.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Blood Frenzy ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Violent Transgression ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Explosive Cocktail ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Withering Toxin ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Eviscerate ;0 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Hydra Helix ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Metamorphosis ;6 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/FBZbyRh.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/r4JxFNc.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Galdred (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Galdred (Costume: Yugi Moto)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Geoffrey"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Geoffrey]], charCard = [[Geoffrey (C)]], announcement = [[† Break your weapons against me! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Geoffrey",
      Description = [[S2, Difficulty 3 (Intermediate)
Geoffrey is a patient, defensive zoner who can outlast virtually any opponent as long as he's trading blows.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889668359/04E71B223E028A647C66D68CECB282B026357D22/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/n88QoQl.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/FgLSx1r.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Golden Arrow ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Inquisition ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Sacrament of Blades ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Solemn Exorcism ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Bastion Stance ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Crusader's Oath ;3 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Inviolable Judgment ;0 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fVeS1CV.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HWw5iby.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/inXtmWK.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HkkBf2X.jpg]],
        altfaceURL = [[https://i.imgur.com/P0taNaA.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/nOiG1i7.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Geoffrey (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row1Z, y = characterIconY, x = column3X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Bathilde",
        costumeDescription = [[Bathilde © Level 99 Games.
Thanks to Moriatti for assisting with implementation!,
        costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/n88QoQl.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/FgLSx1r.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Golden Arrow ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Inquisition ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Sacrament of Blades ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Solemn Exorcism ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Bastion Stance ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Crusader's Oath ;3 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Inviolable Judgment ;0 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WtmuXaS.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GSpNdS7.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Geoffrey (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Geoffrey (Costume: Bathilde)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Iaquis"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Iaquis]], charCard = [[Iaquis (C)]], announcement = [[† FIGHT ME! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Iaquis",
      Description = [[S2, Difficulty 3 (Intermediate)
Iaquis is a patient, powerful ranger who excels at relentless, overwhelming offense.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889673768/9DABC506DD349AA5DE2209AEE611CD15C3C1EA30/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/eJHu0Pb.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ryJHX1H.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Dragon's Tongue ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Dragon's Fire ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Dragon's Flight ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Dragon's Tail ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Dragon's Spine ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Dragon's Heart ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Dragon's Descent ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tXAF3ew.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HF16qxp.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZQ04Fq1.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wwBz2qY.jpg]],
        altfaceURL = [[https://i.imgur.com/fxobi4H.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/bOIOGnN.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Iaquis (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row3Z, y = characterIconY, x = column1X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Samaira",
        costumeDescription = [[Samaira © Level 99 Games.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/eJHu0Pb.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/ryJHX1H.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Dragon's Tongue ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Dragon's Fire ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Dragon's Flight ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Dragon's Tail ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Dragon's Spine ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Dragon's Heart ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Dragon's Descent ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/V0lIGZs.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/BHikO1X.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Iaquis (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Iaquis (Costume: Samaira)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Luciya"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Luciya]], charCard = [[Luciya (C)]], announcement = [[† You can't outrun the lightning! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Luciya",
      Description = [[S2, Difficulty 3 (Intermediate)
Luciya is a fast, mobile ranger who darts around the board to build up charge, then unleashes it in a series of shocking strikes.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889675017/B8A4C38FBFC9494F85D9570D4C69730910FD65F3/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/L0JJMaJ.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NBCBBtl.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Downburst ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Talon Sweep ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Mantis Strike ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Bug Zapper ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Firefly Gunner ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Ride the Lightning ;8 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Skies Aflame ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Xn8eL8k.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HCLNEBS.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/oZxg8jB.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Fl5BOU0.jpg]],
        altfaceURL = [[https://i.imgur.com/wQPpnw7.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/fT8FDGr.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Luciya (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row5Z, y = characterIconY, x = column1X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Sarin",
        costumeDescription = [[Art by wickedalucard.
Costume design by Moriatti!]],
        costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/L0JJMaJ.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/NBCBBtl.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Downburst ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Talon Sweep ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Mantis Strike ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Bug Zapper ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Firefly Gunner ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Ride the Lightning ;8 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Skies Aflame ;5 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Cb5LGVO.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/6ELTgs6.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Luciya (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Luciya (Costume: Sarin)]]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Minato"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Minato]], charCard = [[Minato (C)]], announcement = [[† HONK HONK! VROOOOM! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Minato",
      Description = [[S2, Difficulty 4 (Advanced)
Minato is a mobile, technical brawler hell-bent on mutual destruction. A single miscalculation can send him spiraling out of control.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889675955/9ABA1522797288B2158394293DFDADF1257BF1D8/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0DrYaEr.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HjyWn47.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Jump the Shark ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Barnstorming ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Cabstand ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Flight 13 ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Bus Stop ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[A Streetcar Named Disaster ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Hellward Bound ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fA2dQxh.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dXnSUuW.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/1aaPuUA.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ZkxbFko.jpg]],
        altfaceURL = [[https://i.imgur.com/KizX1kB.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/YFQVbdQ.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Minato (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row1Z, y = characterIconY, x = column5X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Zinnia & Rayquaza",
        costumeDescription = [[Pokémon © The Pokémon Company.
Costume design by Moriatti!]],
        --costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/0DrYaEr.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/HjyWn47.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Jump the Shark ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Barnstorming ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Cabstand ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Flight 13 ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Bus Stop ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[A Streetcar Named Disaster ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Hellward Bound ;3 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7M9PHrH.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tGQZjH6.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Minato (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Minato (Costume: Zinnia & Rayquaza)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Pooky (The Red Dragon Inn)"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Pooky]], charCard = [[Pooky (C)]], announcement = [[† Be vewy quiet, wabbit's hunting you! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Pooky (The Red Dragon Inn)",
      Description = [[S2, Difficulty 4 (Advanced)
Pooky is a mobile, technical, mid-range brawler whose breakneck aggression is tempo-driven and dangerously card-hungry.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889689175/02C685171B119059766AD4DC7277DCDA45432B8E/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/w74wsin.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WCBeoio.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Gambling? I'm In! ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Snack Attack ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Pooky Cheats! ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Long in the Tooth ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Pooky Drinks! ;0 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Drunken Rampage ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Hat Trick ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sRWvqpz.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9zLNJNe.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/k10oJQj.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lUJU2bE.jpg]],
        altfaceURL = [[https://i.imgur.com/JRWNh9z.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/JaoCPCr.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Pooky (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[The Red Dragon Inn]], position = { z = row8Z, y = characterIconY, x = column2X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Legrange",
        costumeDescription = [[Legrange © Level 99 Games.
Costume design by Moriatti!]],
        costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/w74wsin.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/WCBeoio.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Gambling? I'm In! ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Snack Attack ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Pooky Cheats! ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Long in the Tooth ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Pooky Drinks! ;0 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Drunken Rampage ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Hat Trick ;1 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/VZ3VjY5.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GgHjJSg.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Pooky (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Pooky (Costume: The Wendigo)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Remiliss"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Remiliss]], charCard = [[Remiliss (C)]], announcement = [[† What a bombshell! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Remiliss",
      Description = [[S2, Difficulty 4 (Advanced)
Remiliss is a flexible, all-range juggernaut who burns resources to ensure consistent trades.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889676956/DC002820174FD631034F80A03DB467124E594635/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LVlEvqT.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Ktzgp0F.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Caustic Vent ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Toxic Tendrils ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Irradiate ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Ground Zero ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Napalm Stream ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Consumption ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Nuclear Option ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mpAvy88.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Lz0gI6c.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OxYCC6b.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/KINCHUc.jpg]],
        altfaceURL = [[https://i.imgur.com/BcC6BrG.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/g6nlGmj.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Remiliss (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row7Z, y = characterIconY, x = column7X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Katie Kaboom",
        costumeDescription = [[Katie Kaboom © Warner Bros Animation (I think).
Costume design by D & Moriatti!]],
        --costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/LVlEvqT.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/Ktzgp0F.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Caustic Vent ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Toxic Tendrils ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Irradiate ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Ground Zero ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Napalm Stream ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Consumption ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Nuclear Option ;2 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QdqgXDM.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/jXdr1jG.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Remiliss (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Remiliss (Costume: Katie Kaboom)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Renea"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Renea]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/JJo4x0F.jpg]], charCard = [[Renea (C)]], announcement = [[† The truth is out there! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Renea",
      Description = [[S2, Difficulty 3* (Intermediate+)
Renea is a passive-aggressive, technical mid-ranger who manipulates information to pressure her opponents into poor decisions.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889680114/1C42C02E893914CE5CDEB06E5E958266CB9AED96/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Il80NAz.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fE0tYUI.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        -- Fix card names
        cardList = { { cardID = [[00]],
            cardNickname = [[Paranormal Investigation ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Strafe Fire ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Flare ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Lethal Force ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Called Shot ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Neutralizer ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Anticipation ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[5]],
        faceURL = [[https://i.imgur.com/JJo4x0F.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tXxcPcU.jpg]],
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Briefcase (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardSnap = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7E5dWWq.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/A3a1i5s.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MQEQXEo.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/XhyBxSn.jpg]],
        altfaceURL = [[https://i.imgur.com/8HwiwET.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/IAKPfIo.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Renea (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row1Z, y = characterIconY, x = column7X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Renee Montoya",
        costumeDescription = [[Renee Montoya © DC Entertainment.
Costume design by Moriatti!]],
        --costumeNormals = [[Seventh Cross]],
        costumeAttackBack = [[https://i.imgur.com/JJo4x0F.jpg]],
        costumeDeck = {
        { deckID = [[4]],
          faceURL = [[https://i.imgur.com/Il80NAz.jpg]],
          backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: Transformations (C)]],
              copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://i.imgur.com/fE0tYUI.jpg]],
          ----altfaceURL = [[REMASTERED]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          -- Fix card names
          cardList = { { cardID = [[00]],
              cardNickname = [[Paranormal Investigation ;7 (S)]], copies = 2, reference = true, },
            { cardID = [[01]],
              cardNickname = [[Strafe Fire ;6 (S)]], copies = 2, reference = true, },
            { cardID = [[02]],
              cardNickname = [[Flare ;5 (S)]], copies = 2, reference = true, },
            { cardID = [[03]],
              cardNickname = [[Lethal Force ;4 (S)]], copies = 2, reference = true, },
            { cardID = [[04]],
              cardNickname = [[Called Shot ;3 (S)]], copies = 2, reference = true, },
            { cardID = [[05]],
              cardNickname = [[Neutralizer ;6 (U)]], copies = 2, reference = true, },
            { cardID = [[06]],
              cardNickname = [[Anticipation ;3 (U)]], copies = 2, reference = true, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[5]],
          faceURL = [[https://i.imgur.com/JJo4x0F.jpg]],
          backURL = [[https://i.imgur.com/tXxcPcU.jpg]],
          ----altfaceURL = [[REMASTERED]],
          ----altbackURL = [[REMASTERED]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Briefcase (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardSnap = false, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/2p0leyY.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fBc6GhT.jpg]],
          ----altfaceURL = [[REMASTERED]],
          ----altbackURL = [[REMASTERED]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Renea (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Renea (Costume: Renee Montoya)]] },
            }, -- end cardList
          }, -- end subdeck
        }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Seijun"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Seijun]], charCard = [[Seijun (C)]], announcement = [[† By May? Nah, I'd say June. †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Seijun",
      Description = [[S2, Difficulty 3 (Intermediate)
Seijun is a patient, technical brawler who wields an enormous resource advantage over any opponent.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889681216/C4E605F1F2141FC861DC4434B3988D19B50A4E95/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/tWS9UBg.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bbkaKsO.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2, -- gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Ink Splash ;X (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Yokai Banishing ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Inari Guidance ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Ink Spike ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Fox Fire ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Tale of Nine Sorrows ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Tale of Seven Trials ;2 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/zoZQipn.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NtH1Zdl.jpg]],
        altfaceURL = [[https://i.imgur.com/9ZkXyED.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/UTnWCk6.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Seijun (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row7Z, y = characterIconY, x = column3X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Yuel",
        costumeDescription = [[Costume based on Yuel from Granblue Fantasy Versus.
Created by Jungy for April Fool's 2021.]],
        costumeNormals = [[Seventh Cross]],
        costumeOwner = { [[tirankin]], [[Jungy]], }, -- Only appears for players in this table.
        --costumeFavorite = { [[tirankin]], }, -- Prioritized for players in this table (but available regardless).
        --costumePassword = [[Seijun]], -- Locks access based on this password. Always needs to end with the character being clicked.
        --costumePasswordFavorite = [[Renea | Seijun]], -- Prioritized based on this password. ALways needs to end with the character being clicked.
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/tWS9UBg.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1716409000984816191/948D474DA9B78713863518D4130AAD049EA3E9EB/]],
            gridWidth = 3, gridHeight = 3,
            hiddenBack = true,
            cardList = { { cardID = [[03]], -- Replaced for April Fool's 2021.
                cardNickname = [[Ink Splash ;X (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Yokai Banishing ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Inari Guidance ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Ink Spike ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Fox Fire ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[00]],
                cardNickname = [[Tale of Nine Sorrows ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Tale of Seven Trials ;2 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://steamusercontent-a.akamaihd.net/ugc/1751309629108589434/C2977F5D8D85BB793438878D79865FAFEDF8C417/]],
            backURL = [[https://steamusercontent-a.akamaihd.net/ugc/1751309629108644179/C4B02909441704DAF5C39796E026B3D84159D747/]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Yuel (C)]], copies = 1, reference = false, cardDescription = [[Seijun (Costume: Yuel)]], cardMemo = "nonstackable", },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
        { -- costume begins
          costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
          costumeName = "Ulara",
          costumeDescription = [[Ulara © Level 99 Games.
Thanks to Moriatti for assisting with implementation!]],
          costumeNormals = [[Seventh Cross]],
          --costumeOwner = { [[tirankin]], [[Jungy]], }, -- Only appears for players in this table.
          --costumeFavorite = { [[tirankin]], }, -- Prioritized for players in this table (but available regardless).
          --costumePassword = [[Seijun]], -- Locks access based on this password. Always needs to end with the character being clicked.
          --costumePasswordFavorite = [[Renea | Seijun]], -- Prioritized based on this password. ALways needs to end with the character being clicked.
          costumeDeck = {
            { deckID = [[4]],
              faceURL = [[https://i.imgur.com/tWS9UBg.jpg]],
              backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
              gridWidth = 1, gridHeight = 1,
              hiddenBack = false,
              cardList = { { cardID = [[00]],
                  cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                  copies = 0, reference = true, separate = false, },
                }, -- end cardList
              }, -- end subdeck
            { deckID = [[2]],
              faceURL = [[https://i.imgur.com/bbkaKsO.jpg]],
              ----altfaceURL = [[REMASTERED]],
              gridWidth = 4, gridHeight = 2, -- gridWidth = 4, gridHeight = 2,
              hiddenBack = true,
              cardList = { { cardID = [[00]],
                  cardNickname = [[Ink Splash ;X (S)]], copies = 2, reference = true, },
                { cardID = [[01]],
                  cardNickname = [[Yokai Banishing ;6 (S)]], copies = 2, reference = true, },
                { cardID = [[02]],
                  cardNickname = [[Inari Guidance ;4 (S)]], copies = 2, reference = true, },
                { cardID = [[03]],
                  cardNickname = [[Ink Spike ;4 (S)]], copies = 2, reference = true, },
                { cardID = [[04]],
                  cardNickname = [[Fox Fire ;3 (S)]], copies = 2, reference = true, },
                { cardID = [[05]],
                  cardNickname = [[Tale of Nine Sorrows ;4 (U)]], copies = 2, reference = true, },
                { cardID = [[06]],
                  cardNickname = [[Tale of Seven Trials ;2 (U)]], copies = 2, reference = true, },
                }, -- end cardList
              }, -- end subdeck 2
            { deckID = [[3]],
              faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/aP4GZeY.jpg]],
              backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/wtox7mJ.jpg]],
              ----altfaceURL = [[REMASTERED]],
              ----altbackURL = [[REMASTERED]],
              gridWidth = 1, gridHeight = 1,
              hiddenBack = false,
              cardList = { { cardID = [[00]],
                  cardNickname = [[Seijun (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Seijun (Costume: Ulara)]] },
                }, -- end cardList
              }, -- end subdeck
            }, -- end deck
          }, -- costume ends
      }, -- end costume list
    }
  charTable["Shovel Knight (Shovel Knight)"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[PromoKnight]], charCard = [[Shovel Knight (C)]], announcement = [[† I'll pay you back in spades! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Shovel Knight (Shovel Knight)",
      Description = [[S2, Difficulty 2 (Beginner-Friendly)
Shovel Knight is a flexible, all-range brawler who has tools for any situation and dangerously powerful Boosts.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889690113/5BED9AB9D632F40C7B0B81770538A8EEE2E0045B/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/m5QCext.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Flare Wand ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Mobile Gear ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[War Horn ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Chaos Sphere ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Alchemy Coin ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Propeller Dagger ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Troupple Chalice ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/4IWZAOl.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Jww39ZF.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/fqqQFcP.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ryuA0FR.jpg]],
        altfaceURL = [[https://i.imgur.com/UNl7cfh.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/ntYc3a3.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Shovel Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Shovel Knight (Solo)]], position = { z = row9Z, y = characterIconY, x = column4X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Scrooge McDuck",
        costumeDescription = [[Scrooge McDuck © Disney.
Costume design by Moriatti!]],
        --costumeNormals = [[Shovel Knight (Solo)]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[2]], faceURL = [[https://i.imgur.com/m5QCext.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Flare Wand ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Mobile Gear ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[War Horn ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Chaos Sphere ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Alchemy Coin ;1 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Propeller Dagger ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Troupple Chalice ;1 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3QYSYOq.png]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cfsV8wF.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Shovel Knight (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Shovel Knight (Costume: Scrooge McDuck)]]},
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Sydney & Serena"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[SydneyandSerena]], assetTooltip = [[
.............................
.            ...            .
.            ...            .
.............................]], charCard = [[Sydney (C)]], announcement = [[† It's suppertime! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Sydney & Serena",
      Description = [[S2, Difficulty 4 (Advanced)
Sydney is a weak, tactical brawler who uses Serena to threaten the center. Serena consumes Sydney to become a technical, all-range powerhouse.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889691200/B678E03FD21A1380331551D62E6E2C4F785990DB/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dmyloCW.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/o6dmp2Y.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Pea Shooter ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Blossom Haze ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Venom Lash ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Spore Burst ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Choking Thorns ;0 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Aluraune's Kiss ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Verdant Slaughter ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[5]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dcwqKGR.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dmTsHNh.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/9owz7Sk.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hi9RUq0.jpg]],
        altfaceURL = [[https://i.imgur.com/819Fb3s.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/FQLqGpx.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Serena (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Rnspf9p.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CRhSSVT.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8G8bmN2.jpg]],
        altfaceURL = [[https://i.imgur.com/5ts1vjQ.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/CNjf1hI.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Sydney (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row6Z, y = characterIconY, x = column4X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Bohdan & Soultron",
        costumeDescription = [[Bohdan © Seventh Cross.
Costume design by Moriatti!]],
        costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
              { deckID = [[4]],
                faceURL = [[https://i.imgur.com/dmyloCW.jpg]],
                backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
                gridWidth = 1, gridHeight = 1,
                hiddenBack = false,
                cardList = { { cardID = [[00]],
                    cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                    copies = 0, reference = true, separate = false, },
                  }, -- end cardList
                }, -- end subdeck
              { deckID = [[2]], faceURL = [[https://i.imgur.com/o6dmp2Y.jpg]],
                ----altfaceURL = [[REMASTERED]],
                gridWidth = 4, gridHeight = 2,
                hiddenBack = true,
                cardList = { { cardID = [[00]],
                    cardNickname = [[Pea Shooter ;6 (S)]], copies = 2, reference = true, },
                  { cardID = [[01]],
                    cardNickname = [[Blossom Haze ;5 (S)]], copies = 2, reference = true, },
                  { cardID = [[02]],
                    cardNickname = [[Venom Lash ;4 (S)]], copies = 2, reference = true, },
                  { cardID = [[03]],
                    cardNickname = [[Spore Burst ;2 (S)]], copies = 2, reference = true, },
                  { cardID = [[04]],
                    cardNickname = [[Choking Thorns ;0 (S)]], copies = 2, reference = true, },
                  { cardID = [[05]],
                    cardNickname = [[Aluraune's Kiss ;7 (U)]], copies = 2, reference = true, },
                  { cardID = [[06]],
                    cardNickname = [[Verdant Slaughter ;1 (U)]], copies = 2, reference = true, },
                  }, -- end cardList
                }, -- end subdeck 2
              { deckID = [[5]],
                faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/kryc6UZ.jpg]],
                backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ae0D7Sc.jpg]],
                ----altfaceURL = [[REMASTERED]],
                ----altbackURL = [[REMASTERED]],
                gridWidth = 1, gridHeight = 1,
                hiddenBack = false,
                cardList = { { cardID = [[00]],
                    cardNickname = [[Serena (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardDescription = [[Serena (Costume: Bohdan & Soultron)]] },
                  }, -- end cardList
                }, -- end subdeck
              { deckID = [[3]],
                faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/IaNpq3A.jpg]],
                backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/hGlQjIP.jpg]],
                ----altfaceURL = [[REMASTERED]],
                ----altbackURL = [[REMASTERED]],
                gridWidth = 1, gridHeight = 1,
                hiddenBack = false,
                cardList = { { cardID = [[00]],
                    cardNickname = [[Sydney (C)]], copies = 1, reference = false, bannedInLag = true, cardMemo = "nonstackable", cardDescription = [[Sydney (Costume: Bohdan & Soultron)]] },
                  }, -- end cardList
                }, -- end subdeck
              }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Syrus"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Syrus]], charCard = [[Syrus (C)]], announcement = [[† You are curiously attractive for a fish-man! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Syrus",
      Description = [[S2, Difficulty 3 (Intermediate)
Syrus is a mobile, technical ranger who uses Boosts to build up a tremendous resource advantage.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889682416/D95DA7089FE55D5B29EA8C800364422CD8BA9933/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LnlbgSz.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/WOFFNc9.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Tidal Whirl ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Aria of the Winds ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Siren Call ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Treasure Hunter ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Albatross Talon ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Symphony of the Deep ;7 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Dredge Fury ;4 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HmMa8ba.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/E7SLHzm.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/dBlUanM.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/v9ktYxx.jpg]],
        altfaceURL = [[https://i.imgur.com/W8Sbhj4.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/IoxYOrJ.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Syrus (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row7Z, y = characterIconY, x = column1X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Nessa & Dreadmaw",
        costumeDescription = [[Pokémon © The Pokémon Company.
Costume design by Moriatti!]],
        --costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/LnlbgSz.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/WOFFNc9.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Tidal Whirl ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Aria of the Winds ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Siren Call ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Treasure Hunter ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Albatross Talon ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Symphony of the Deep ;7 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Dredge Fury ;4 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/vz4AhOn.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/bCbZcFF.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Syrus (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Syrus (Costume: Nessa & Dreadmaw)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Taisei"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Taisei]], charCard = [[Taisei (C)]], announcement = [[† Quit while you're ahead! ���]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Taisei",
      Description = [[S2, Difficulty 3 (Intermediate)
Taisei is an aggressive, vampiric mid-ranger who spends life to empower himself and outdamage his foes.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889683297/1AB7D95E76361A0DD5901469FC832D4058DB2FCF/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/3cwMz64.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/nzhlxRs.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Dust to Dust ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Anathema Surge ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Bloodthirst ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Ashen Claws ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Blackvolt ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Chaos Scissors ;5 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Nightmare Tares ;1 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
      -- April Fool's Exceed 2022   faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/lc791eP.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/TELJm3v.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/OnAQb7s.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/37F1Gxo.jpg]],
        altfaceURL = [[https://i.imgur.com/HWt6w9T.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/KBAb02S.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Taisei (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row3Z, y = characterIconY, x = column3X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Marlowe",
        costumeDescription = [[Marlowe © Level 99 Games.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/3cwMz64.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/nzhlxRs.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Dust to Dust ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Anathema Surge ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Bloodthirst ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Ashen Claws ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Blackvolt ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Chaos Scissors ;5 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Nightmare Tares ;1 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/0YwRNOA.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/PdkNgym.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Taisei (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Taisei (Costume: Marlowe)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Tournelouse"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Tournelouse]], charCard = [[Tournelouse (C)]], announcement = [[† so aggression. much fragile. wow †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Tournelouse",
      Description = [[S2, Difficulty 3 (Intermediate)
Tournelouse is a fast, mid-range striker who ramps up from a weakened state to an overwhelmingly powerful monstrosity.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889684191/61E31F2F77F4E7515686F21B25D3694FB4C8C8AC/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/J2lFCXF.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/x88VcfA.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Evil Eye ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Southpaw ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Death Omen ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Grim Thundercalling ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Lightning Spike ;3 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Bargeist Fang ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Netherstorm ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/CsbFgCO.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/88x357L.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/cqBoFa6.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/pX2fSSA.jpg]],
        altfaceURL = [[https://i.imgur.com/SWyfKI7.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/i5bzPQ1.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Tournelouse (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row5Z, y = characterIconY, x = column5X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Dampierre",
        costumeDescription = [[Dampierre © Level 99 Games.
Thanks to Moriatti for assisting with implementation!]],
        costumeNormals = [[Seventh Cross]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/J2lFCXF.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/x88VcfA.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Evil Eye ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Southpaw ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Death Omen ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Grim Thundercalling ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Lightning Spike ;3 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Bargeist Fang ;6 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Netherstorm ;5 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Rmivrsc.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/8q93dYT.jpg]],
            ----altfaceURL = [[REMASTERED]],
            ----altbackURL = [[REMASTERED]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Tournelouse (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Tournelouse (Costume: Dampierre)]] },
              }, -- end cardList
            }, -- end subdeck
          }, -- end deck
        }, -- costume ends
      }, -- end costume list --]=]
    }
  charTable["Umina"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = false, assetName = [[Umina]],
    attackBack = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/oouli0L.jpg]], charCard = [[Umina (C)]], announcement = [[† Opening minds with minimal spatter! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Umina",
      Description = [[S2, Difficulty 4 (Advanced)
Umina is a patient, technical manipulator who excels at controlling or shutting down her opponent's options.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889685422/906E30116F38E2819CE098677FB24AD2EC8DEAB6/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MbEU6fp.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ORCMPBO.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Terror Whispers ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Out of Mind ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Hollow Space ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Dark Thoughts ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Shadow Chorus ;1 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Unknown Khadath ;6 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Call of the Dreamlands ;5 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[5]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/QuWqooi.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/an7eDIa.jpg]],
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Dreamlands (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardSnap = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/7NhES4J.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/UONYwXV.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/d9OB4J2.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/mLakrZ0.jpg]],
        altfaceURL = [[https://i.imgur.com/9QfqfvA.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/J7kc20S.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        ----altbackURL = [[REMASTERED]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Umina (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row7Z, y = characterIconY, x = column5X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Marx, a Friend?",
        costumeDescription = [[Marx © Nintendo.
Costume design by Moriatti!]],
        --costumeNormals = [[COSTUMENORMALS]],
        costumeAttackBack = [[https://i.imgur.com/oouli0L.jpg]],
        costumeDeck = {
        { deckID = [[4]],
          faceURL = [[https://i.imgur.com/MbEU6fp.jpg]],
          backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Season Mechanics Reference: Transformations (C)]],
              copies = 0, reference = true, separate = false, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[2]], faceURL = [[https://i.imgur.com/ORCMPBO.jpg]],
          ----altfaceURL = [[REMASTERED]],
          gridWidth = 4, gridHeight = 2,
          hiddenBack = true,
          cardList = { { cardID = [[00]],
              cardNickname = [[Terror Whispers ;7 (S)]], copies = 2, reference = true, },
            { cardID = [[01]],
              cardNickname = [[Out of Mind ;5 (S)]], copies = 2, reference = true, },
            { cardID = [[02]],
              cardNickname = [[Hollow Space ;4 (S)]], copies = 2, reference = true, },
            { cardID = [[03]],
              cardNickname = [[Dark Thoughts ;2 (S)]], copies = 2, reference = true, },
            { cardID = [[04]],
              cardNickname = [[Shadow Chorus ;1 (S)]], copies = 2, reference = true, },
            { cardID = [[05]],
              cardNickname = [[Unknown Khadath ;6 (U)]], copies = 2, reference = true, },
            { cardID = [[06]],
              cardNickname = [[Call of the Dreamlands ;5 (U)]], copies = 2, reference = true, },
            }, -- end cardList
          }, -- end subdeck 2
        { deckID = [[5]],
          faceURL = [[https://i.imgur.com/QuWqooi.jpg]],
          backURL = [[https://i.imgur.com/an7eDIa.jpg]],
          ----altfaceURL = [[REMASTERED]],
          ----altbackURL = [[REMASTERED]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Dreamlands (C)]], copies = 1, reference = false, separate = true, cardMemo = "nonstackable", cardSnap = false, },
            }, -- end cardList
          }, -- end subdeck
        { deckID = [[3]],
          faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/k2935Su.jpg]],
          backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/LLkktSj.jpg]],
          ----altfaceURL = [[REMASTERED]],
          ----altbackURL = [[REMASTERED]],
          gridWidth = 1, gridHeight = 1,
          hiddenBack = false,
          cardList = { { cardID = [[00]],
              cardNickname = [[Umina (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Umina (Costume: Marx, a Friend?)]] },
            }, -- end cardList
          }, -- end subdeck
        }, -- end deck
      }, -- costume ends
    }, -- end costume list --]=]
  }
  charTable["Zsolt"] = { panelGUID = [[0e101c]], season = [[2]], borderColor = { 149/255, 0, 179/255, 1}, legal = seasonLegal, assetName = [[Zsolt]], charCard = [[Zsolt (C)]], announcement = [[† Now with 200% more turn per turn! †]],
    referenceChip = { Name = "Custom_Tile",
      Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
      Nickname = "Zsolt",
      Description = [[S2, Difficulty 3* (Intermediate+)
Zsolt is a fast, mobile ranger who presses the advantage while dancing around opponent counterattacks.]],
      CustomImage = {
        ImageURL = [[https://steamusercontent-a.akamaihd.net/ugc/923680057889686634/01A4295CB5E34859A4BFF8EF88854FAACED4923F/]],
        ImageSecondaryURL = [[https://i.imgur.com/EqUoAFw.jpeg]],
        CustomTile = { Thickness = 0.1, Stretch = true, }
      }
    },
    deck = {
      { deckID = [[4]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/NDV3Uew.jpg]],
        backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Season Mechanics Reference: Transformations (C)]],
            copies = 0, reference = true, separate = false, },
          }, -- end cardList
        }, -- end subdeck
      { deckID = [[2]], faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/GP8goQi.jpg]],
        ----altfaceURL = [[REMASTERED]],
        gridWidth = 4, gridHeight = 2,
        hiddenBack = true,
        cardList = { { cardID = [[00]],
            cardNickname = [[Fatal Eye ;7 (S)]], copies = 2, reference = true, },
          { cardID = [[01]],
            cardNickname = [[Cross Up ;6 (S)]], copies = 2, reference = true, },
          { cardID = [[02]],
            cardNickname = [[Blaze of Fervor ;5 (S)]], copies = 2, reference = true, },
          { cardID = [[03]],
            cardNickname = [[Whip Crack ;4 (S)]], copies = 2, reference = true, },
          { cardID = [[04]],
            cardNickname = [[Gunblaze ;2 (S)]], copies = 2, reference = true, },
          { cardID = [[05]],
            cardNickname = [[Fanatical Purification ;4 (U)]], copies = 2, reference = true, },
          { cardID = [[06]],
            cardNickname = [[Wild Hunt ;3 (U)]], copies = 2, reference = true, },
          }, -- end cardList
        }, -- end subdeck 2
      { deckID = [[3]],
        -- April Fool's Exceed 2022 faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/gKWJV2v.jpg]],
        -- April Fool's Exceed 2022 backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/loU8RFc.jpg]],
        faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/ME5uNhV.jpg]],
        backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/onUs573.jpg]],
        altfaceURL = [[https://i.imgur.com/U2MDzQJ.png]], -- April Fool's Exceed 2023
        altbackURL = [[https://i.imgur.com/mRgJD0E.png]], -- April Fool's Exceed 2023
        ----altfaceURL = [[REMASTERED]],
        --altbackURL = [[https://cdn.discordapp.com/attachments/687778679614734364/770562433215234108/unknown.png]],
        gridWidth = 1, gridHeight = 1,
        hiddenBack = false,
        cardList = { { cardID = [[00]],
            cardNickname = [[Zsolt (C)]], copies = 1, reference = false, cardMemo = "nonstackable", },
          }, -- end cardList
        }, -- end subdeck
    }, normals = [[Seventh Cross]], position = { z = row3Z, y = characterIconY, x = column5X }, costumes = {
      { -- costume begins
        costumePriority = 0, -- The default costume has a priority of 1, so a higher value means it overrides the default.
        costumeName = "Buffy Summers",
        costumeDescription = [[Buffy Summers © Joss Whedon.
Costume design by Moriatti!]],
        --costumeNormals = [[COSTUMENORMALS]],
        --costumeAttackBack = [[COSTUMEATTACKBACK]],
        costumeDeck = {
          { deckID = [[4]],
            faceURL = [[https://i.imgur.com/NDV3Uew.jpg]],
            backURL = [[https://i.imgur.com/Qp8PExW.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Season Mechanics Reference: Transformations (C)]],
                copies = 0, reference = true, separate = false, },
              }, -- end cardList
            }, -- end subdeck
          { deckID = [[2]], faceURL = [[https://i.imgur.com/GP8goQi.jpg]],
            ----altfaceURL = [[REMASTERED]],
            gridWidth = 4, gridHeight = 2,
            hiddenBack = true,
            cardList = { { cardID = [[00]],
                cardNickname = [[Fatal Eye ;7 (S)]], copies = 2, reference = true, },
              { cardID = [[01]],
                cardNickname = [[Cross Up ;6 (S)]], copies = 2, reference = true, },
              { cardID = [[02]],
                cardNickname = [[Blaze of Fervor ;5 (S)]], copies = 2, reference = true, },
              { cardID = [[03]],
                cardNickname = [[Whip Crack ;4 (S)]], copies = 2, reference = true, },
              { cardID = [[04]],
                cardNickname = [[Gunblaze ;2 (S)]], copies = 2, reference = true, },
              { cardID = [[05]],
                cardNickname = [[Fanatical Purification ;4 (U)]], copies = 2, reference = true, },
              { cardID = [[06]],
                cardNickname = [[Wild Hunt ;3 (U)]], copies = 2, reference = true, },
              }, -- end cardList
            }, -- end subdeck 2
          { deckID = [[3]],
            faceURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/HXZeGZr.jpg]],
            backURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/MHZdnTz.jpg]],
            ----altfaceURL = [[https://i.imgur.com/HXZeGZr.jpg]],
            --altbackURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/Soibqxb.jpg]],
            gridWidth = 1, gridHeight = 1,
            hiddenBack = false,
            cardList = { { cardID = [[00]],
                cardNickname = [[Zsolt (C)]], copies = 1, reference = false, cardMemo = "nonstackable", cardDescription = [[Zsolt (Costume: Buffy Summers)]] },
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
      id = "Season 2 Base",
      image = "RosterS2",
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
      id = "Random2",
      tooltip = [[Random
Season 2]],
      active = true,
      height = iconSize,
      width = iconSize,
      position = { x = column4X, z = row4Z, y = characterIconY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 0, g = 1, b = 0, a = transparencyValue },
      clickable = "true",
      onClick = self.getGUID().."/uiClick_Random",
      --[[ 2023-08-19: Disabling hover images to attempt to improve load times.
      hoverTooltip = blankTooltip,
      hoverImage = "RandomS2",
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
    debugLog{ "Roster S2, per-char loop: "..charName, 2, {1,1,1} }

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
        colors = [[rgba(0,0,0,0.1)|rgba(]]..(149/255)..[[,0.75,]]..(179/255)..[[,1)|rgba(0.7,0.7,0.7,0.9)]], -- Applied on top of the background color, for some reason.
        color = [[rgba(]]..(149/255)..[[,0,]]..(179/255)..[[,1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS2Icon",
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
        colors = [[rgba(0,0,0,0.1)|rgba(1,0.5,1,1)|rgba(]]..(149/255)..[[,0,]]..(179/255)..[[,1)]], -- Applied on top of the background color, for some reason.
        color = [[rgba(1,1,1,0.1)]], -- Background color of the ToggleButton.
        onClick = self.getGUID()..'/uiClick_TogglePanel',
        isOn = false,
        position = togglePanelX.." "..togglePanelZ.." "..togglePanelY,
        rotation = "0 0 0",
        height = iconSize,
        width = iconSize,
        scale = 0.5,
        icon = "RosterS2Icon",
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