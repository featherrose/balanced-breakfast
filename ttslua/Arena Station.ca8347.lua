function onLoad()

  -- I have no idea how I'm implementing these, but I know how I need to start.
  arenas = {
    { -- Begin arena.
      name = [[1987 Cyberspace]],
      class = 3,
      announcement = [[Brace your  self for in
put de               lay]],
      faceURL = [[https://i.imgur.com/mb6jQFu.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
      enclosed = {
        Name = "Deck",
        Transform = {
          posX = 0, posY = 0, posZ = 0,
          rotX = 0, rotY = 180, rotZ = 0,
          scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
        },
        --Nickname = deckName..[[ Side Cards]],
        --Description = [[Cards that begin outside of ]]..deckName..[['s deck]],
        GMNotes = "", Memo = "", ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
        Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
        Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
        DeckIDs = { 200, 200, 100 },
        CustomDeck = {
          {
            FaceURL = [[https://i.imgur.com/QCukJ8A.png]],
            BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
            NumWidth = 1,
            NumHeight = 1,
            BackIsHidden = true,
            UniqueBack = false,
            Type = 0,
          },
          {
            FaceURL = [[https://i.imgur.com/R9cVfdF.png]],
            BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
            NumWidth = 1,
            NumHeight = 1,
            BackIsHidden = true,
            UniqueBack = false,
            Type = 0,
          },
        },
        ContainedObjects = {
          { Name = "Card",
            Transform = {
              posX = 0, posY = 0, posZ = 0,
              rotX = 0, rotY = 0, rotZ = 0,
              scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
            },
            Nickname = [[Modified Actions Reference Card]],
            ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
            CardID = 200, -- CustomDeck entry ID concatenated with the index on the sheet
            SidewaysCard = false,
            CustomDeck = {
              {
                FaceURL = [[https://i.imgur.com/R9cVfdF.png]],
                BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
                NumWidth = 1,
                NumHeight = 1,
              }, -- end CustomDeck entry 1
            }, -- end CustomDeck within card
          }, -- end card
          { Name = "Card",
            Transform = {
              posX = 0, posY = 0, posZ = 0,
              rotX = 0, rotY = 0, rotZ = 0,
              scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
            },
            Nickname = [[Mismatched Actions Reference Card]],
            ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
            CardID = 200, -- CustomDeck entry ID concatenated with the index on the sheet
            SidewaysCard = false,
            CustomDeck = {
              {
                FaceURL = [[https://i.imgur.com/R9cVfdF.png]],
                BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
                NumWidth = 1,
                NumHeight = 1,
              }, -- end CustomDeck entry 1
            }, -- end CustomDeck within card
          }, -- end card
          { Name = "Card",
            Transform = {
              posX = 0, posY = 0, posZ = 0,
              rotX = 0, rotY = 0, rotZ = 0,
              scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
            },
            Nickname = [[Host]],
            ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
            CardID = 100, -- CustomDeck entry ID concatenated with the index on the sheet
            SidewaysCard = false,
            CustomDeck = {
              {
                FaceURL = [[https://i.imgur.com/QCukJ8A.png]],
                BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
                NumWidth = 1,
                NumHeight = 1,
              }, -- end CustomDeck entry 1
            }, -- end CustomDeck within card
          }, -- end card
        }, -- end ContainedObjects within deck
      }, -- end 'enclosed' within subtable
    },
    { -- Begin arena.
      name = [[Bountiful Bazaar]],
      class = 3,
      announcement = [[Introducing card rotation!]],
      faceURL = [[https://i.imgur.com/mgjhrX4.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Downtown Back Alley]],
      class = 3,
      announcement = [[Rival gangs battle for the crown!]],
      faceURL = [[https://i.imgur.com/RHsQyie.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Floating Platform]],
      class = 3,
      announcement = [[Stay on guard near the edge, it's a fatal drop!]],
      faceURL = [[https://i.imgur.com/EY1TSzU.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Storefront Complex]],
      class = 3,
      announcement = [[Time for some window shopping~]],
      faceURL = [[https://i.imgur.com/Ae3GzfU.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Uptown Laundromat]],
      class = 3,
      announcement = [[Oops! Looks like you've got some Unmatched clothing!]],
      faceURL = [[https://i.imgur.com/ceK7Gxf.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
      enclosed = {
        Name = "Deck",
        Transform = {
          posX = 0, posY = 0, posZ = 0,
          rotX = 0, rotY = 180, rotZ = 0,
          scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
        },
        --Nickname = deckName..[[ Side Cards]],
        --Description = [[Cards that begin outside of ]]..deckName..[['s deck]],
        GMNotes = "", Memo = "", ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
        Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
        Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = true,
        DeckIDs = { 100, 100 },
        CustomDeck = {
          {
            FaceURL = [[https://i.imgur.com/OeTbEYG.png?1]],
            BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
            NumWidth = 1,
            NumHeight = 1,
            BackIsHidden = true,
            UniqueBack = false,
            Type = 0,
          },
        },
        ContainedObjects = {
          { Name = "Card",
            Transform = {
              posX = 0, posY = 0, posZ = 0,
              rotX = 0, rotY = 0, rotZ = 0,
              scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
            },
            Nickname = [[Mismatched Actions Reference Card]],
            ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
            CardID = 100, -- CustomDeck entry ID concatenated with the index on the sheet
            SidewaysCard = true,
            CustomDeck = {
              {
                FaceURL = [[https://i.imgur.com/OeTbEYG.png?1]],
                BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
                NumWidth = 1,
                NumHeight = 1,
              }, -- end CustomDeck entry 1
            }, -- end CustomDeck within card
          }, -- end card within deck's ContainedObjects
          { Name = "Card",
            Transform = {
              posX = 0, posY = 0, posZ = 0,
              rotX = 0, rotY = 0, rotZ = 0,
              scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
            },
            Nickname = [[Mismatched Actions Reference Card]],
            ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
            CardID = 100, -- CustomDeck entry ID concatenated with the index on the sheet
            SidewaysCard = true,
            CustomDeck = {
              {
                FaceURL = [[https://i.imgur.com/OeTbEYG.png?1]],
                BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
                NumWidth = 1,
                NumHeight = 1,
              }, -- end CustomDeck entry 1
            }, -- end CustomDeck within card
          }, -- end card within deck's ContainedObjects
        }, -- end ContainedObjects within deck
      }, -- end 'enclosed' within subtable
    },
    { -- Begin arena.
      name = [[Ancient Bridge]],
      class = 2,
      announcement = [[Things fall apart; the centre cannot hold;]],
      faceURL = [[https://i.imgur.com/Ovsxg7Y.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Edge of the Universe]],
      class = 2,
      announcement = [[Sudden Death!]],
      faceURL = [[https://i.imgur.com/ICRoZih.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Factory's Heart]],
      class = 2,
      announcement = [[You look like you're under a lot of pressure!]],
      faceURL = [[https://i.imgur.com/zSwWsVc.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
      enclosed = {
        Name = "Deck",
        Transform = {
          posX = 0, posY = 0, posZ = 0,
          rotX = 0, rotY = 180, rotZ = 0,
          scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
        },
        --Nickname = deckName..[[ Side Cards]],
        --Description = [[Cards that begin outside of ]]..deckName..[['s deck]],
        GMNotes = "", Memo = "", ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
        Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
        Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
        DeckIDs = { 100, 200 },
        CustomDeck = {
          {
            FaceURL = [[https://i.imgur.com/uQq78g9.png]],
            BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
            NumWidth = 1,
            NumHeight = 1,
            BackIsHidden = true,
            UniqueBack = false,
            Type = 0,
          },
          {
            FaceURL = [[https://i.imgur.com/gEbgOXt.png]],
            BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
            NumWidth = 1,
            NumHeight = 1,
            BackIsHidden = true,
            UniqueBack = false,
            Type = 0,
          },
        },
        ContainedObjects = {
          { Name = "Card",
            Transform = {
              posX = 0, posY = 0, posZ = 0,
              rotX = 0, rotY = 0, rotZ = 0,
              scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
            },
            Nickname = [[Steam Plumes]],
            ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
            CardID = 100, -- CustomDeck entry ID concatenated with the index on the sheet
            SidewaysCard = false,
            CustomDeck = {
              {
                FaceURL = [[https://i.imgur.com/uQq78g9.png]],
                BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
                NumWidth = 1,
                NumHeight = 1,
              }, -- end CustomDeck entry 1
            }, -- end CustomDeck within card
            LuaScript = markerScript,
          }, -- end card within deck's ContainedObjects
          { Name = "Card",
            Transform = {
              posX = 0, posY = 0, posZ = 0,
              rotX = 0, rotY = 0, rotZ = 0,
              scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
            },
            Nickname = [[Crushing Piston]],
            ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
            CardID = 200, -- CustomDeck entry ID concatenated with the index on the sheet
            SidewaysCard = false,
            CustomDeck = {
              {
                FaceURL = [[https://i.imgur.com/gEbgOXt.png]],
                BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
                NumWidth = 1,
                NumHeight = 1,
              }, -- end CustomDeck entry 1
            }, -- end CustomDeck within card
            LuaScript = markerScript,
          }, -- end card within deck's ContainedObjects
        }, -- end ContainedObjects within deck
      }, -- end 'enclosed' within subtable
    },
    { -- Begin arena.
      name = [[Outlook Tower]],
      class = 2,
      announcement = [[Round and round we go]],
      faceURL = [[https://i.imgur.com/GuMcNh6.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Seafoam Beach]],
      class = 2,
      announcement = [[~ Ebb and flow ~]],
      faceURL = [[https://i.imgur.com/FSoL6hZ.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
      enclosed = { Name = "Card",
        Transform = {
          posX = 0, posY = 0, posZ = 0,
          rotX = 0, rotY = 0, rotZ = 0,
          scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
        },
        Nickname = [[Tide]],
        ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
        CardID = 100, -- CustomDeck entry ID concatenated with the index on the sheet
        SidewaysCard = false,
        CustomDeck = {
          {
            FaceURL = [[https://i.imgur.com/g3YJev3.png]],
            BackURL = [[https://i.imgur.com/Xdgml9z.png]],
            NumWidth = 1,
            NumHeight = 1,
          }, -- end CustomDeck entry 1
        }, -- end CustomDeck within card
        LuaScript = markerScript,
      }, -- end enclosed card
    },
    { -- Begin arena.
      name = [[Shadowed Halls]],
      class = 2,
      announcement = [[Secret passageways abound!]],
      faceURL = [[https://i.imgur.com/EoUGGLz.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Solar Eclipse]],
      class = 2,
      announcement = [[Move under the cover of night!]],
      faceURL = [[https://i.imgur.com/GlazbWN.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Studio Apartment]],
      class = 2,
      announcement = [[Thersntmchspcnhere]],
      faceURL = [[https://i.imgur.com/j64gy9w.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Vast Cavern]],
      class = 2,
      announcement = [[Danger: Sharp rocks, above and below!]],
      faceURL = [[https://i.imgur.com/KBW7Md5.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
      enclosed = {
        Name = "Deck",
        Transform = {
          posX = 0, posY = 0, posZ = 0,
          rotX = 0, rotY = 180, rotZ = 0,
          scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
        },
        --Nickname = deckName..[[ Side Cards]],
        --Description = [[Cards that begin outside of ]]..deckName..[['s deck]],
        GMNotes = "", Memo = "", ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
        Locked = false, Grid = true, Snap = true, IgnoreFoW = false, MeasureMovement = false, DragSelectable = true, Autoraise = true,
        Sticky = true, Tooltip = true, GridProjection = false, HideWhenFaceDown = false, Hands = false, SidewaysCard = false,
        DeckIDs = { 100, 100 },
        CustomDeck = {
          {
            FaceURL = [[https://i.imgur.com/v4nzJC7.png]],
            BackURL = [[https://i.imgur.com/MD5lf8W.png]],
            NumWidth = 1,
            NumHeight = 1,
            BackIsHidden = false,
            UniqueBack = false,
            Type = 0,
          },
        },
        ContainedObjects = {
          { Name = "Card",
            Transform = {
              posX = 0, posY = 0, posZ = 0,
              rotX = 0, rotY = 0, rotZ = 0,
              scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
            },
            Nickname = [[Stalagmite]],
            ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
            CardID = 100, -- CustomDeck entry ID concatenated with the index on the sheet
            SidewaysCard = false,
            CustomDeck = {
              {
                FaceURL = [[https://i.imgur.com/v4nzJC7.png]],
                BackURL = [[https://i.imgur.com/MD5lf8W.png]],
                NumWidth = 1,
                NumHeight = 1,
              }, -- end CustomDeck entry 1
            }, -- end CustomDeck within card
            LuaScript = markerScript,
          }, -- end card within deck's ContainedObjects
          { Name = "Card",
            Transform = {
              posX = 0, posY = 0, posZ = 0,
              rotX = 0, rotY = 0, rotZ = 0,
              scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
            },
            Nickname = [[Stalagmite]],
            ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
            CardID = 100, -- CustomDeck entry ID concatenated with the index on the sheet
            SidewaysCard = false,
            CustomDeck = {
              {
                FaceURL = [[https://i.imgur.com/v4nzJC7.png]],
                BackURL = [[https://i.imgur.com/MD5lf8W.png]],
                NumWidth = 1,
                NumHeight = 1,
              }, -- end CustomDeck entry 1
            }, -- end CustomDeck within card
            LuaScript = markerScript,
          }, -- end card within deck's ContainedObjects
        }, -- end ContainedObjects within deck
      }, -- end 'enclosed' within subtable
    },
    { -- Begin arena.
      name = [[Windswept Valley]],
      class = 2,
      announcement = [[Gale force winds!]],
      faceURL = [[https://i.imgur.com/PoomvIN.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
      enclosed = { Name = "Card",
        Transform = {
          posX = 0, posY = 0, posZ = 0,
          rotX = 0, rotY = 0, rotZ = 0,
          scaleX = 1.25, scaleY = 1, scaleZ = 1.25,
        },
        Nickname = [[Gale]],
        ColorDiffuse = { r = 0.713235259, g = 0.713235259, b = 0.713235259 },
        CardID = 100, -- CustomDeck entry ID concatenated with the index on the sheet
        SidewaysCard = false,
        CustomDeck = {
          {
            FaceURL = [[https://i.imgur.com/Ys6w5DG.png]],
            BackURL = [[https://i.imgur.com/ZtcAjXb.png]],
            NumWidth = 1,
            NumHeight = 1,
          }, -- end CustomDeck entry 1
        }, -- end CustomDeck within card
      }, -- end 'enclosed' within subtable
    },
    { -- Begin arena.
      name = [[Castle Courtyard]],
      class = 1,
      announcement = [[A fair fight on even footing.]],
      faceURL = [[https://i.imgur.com/en1yA3I.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Caustic Wasteland]],
      class = 1,
      announcement = [[Acid reigns]],
      faceURL = [[https://i.imgur.com/5Ji4SNW.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Hyperspace Jump]],
      class = 1,
      announcement = [[Long live Turbo Mode!]],
      faceURL = [[https://i.imgur.com/iNOy4Q9.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Divine Pulse]],
      class = 1,
      announcement = [[Supercharged conflict!]],
      faceURL = [[https://i.imgur.com/15BzJSS.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Magma Flood]],
      class = 1,
      announcement = [[The floor is lava!]],
      faceURL = [[https://i.imgur.com/OKrEIxH.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Shopping Mall]],
      class = 1,
      announcement = [[Scouting for bargains!]],
      faceURL = [[https://i.imgur.com/73FsW1v.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Sky Deck]],
      class = 1,
      announcement = [[Free, free falling ~]],
      faceURL = [[https://i.imgur.com/MBBZjh8.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Tree of Life]],
      class = 1,
      announcement = [[You feel full of energy, vitality, and courage!]],
      faceURL = [[https://i.imgur.com/q19gcPR.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Underground Arena]],
      class = 1,
      announcement = [[Step into the ring for a cage match!]],
      faceURL = [[https://i.imgur.com/u4u5Dvo.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[Unknown Kadath]],
      class = 1,
      announcement = [[Dream of tomorrow under an endless, alien sky]],
      faceURL = [[https://i.imgur.com/8QngHYm.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
    { -- Begin arena.
      name = [[White Field]],
      class = 1,
      announcement = [[Everyone loves ice physics!]],
      faceURL = [[https://i.imgur.com/LxiuOwH.png]],
      backURL = [[https://i.imgur.com/feji1Ze.png]],
    },
  } -- end arenas

  arenasNamesTable = {}
  for i,arenaEntry in ipairs(arenas) do
    table.insert(arenasNamesTable, arenaEntry.name)
  end

  arenaStationXmlTable = {}
  arenaStationXmlY = -100

  transparencyValue = 0
  if Global.getVar("debugFlag") == true then
    transparencyValue = 1
  end

  -- This table is traversed in order to determine element draw order (i.e., images with greater indices are drawn on top of those with lesser indices).
  systemElements = {
    {
      id = "Arena Station Base",
      image = "ArenaStation",
      active = true,
      height = 50,
      width = 73.3524355,
      position = { x = 0, z = 0, y = (arenaStationXmlY*1.2), }, -- x z -y
      rotation = { x = 0, y = 270, z = 0, },
      color = { r = 1, g = 1, b = 1, a = 1 }, -- TODO: Get an image for the Arena Station.
      clickable = "false",
      --onClick = self.getGUID().."/uiClick_SelectNormals",
      --hoverImage = "",
      hoverColor = { r = 1, g = 1, b = 1, a = 0, },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
    {
      id = "SpawnArena",
      tooltip = [[Spawn an Arena
No warranty, express or implied!]],
      active = true,
      height = 72,
      width = 50,
      position = { x = 0, z = 0, y = arenaStationXmlY, }, -- x z -y
      rotation = { x = 0, y = 0, z = 0, },
      color = { r = 0, g = 1, b = 1, a = transparencyValue },
      clickable = "true",
      onClick = self.getGUID().."/uiClick_SpawnArena",
      --hoverImage = "",
      hoverColor = { r = 1, g = 1, b = 1, a = 0, },
      visibilityString = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey]],
    },
  }

  local blankTooltip = [[
............
.          .
.          .
............]]

  imageFactor1 = 31.15  -- multiplied by position.x to generate first value in the UI element position string
  imageFactor2 = -31.45 -- multiplied by position.z to generate second value in the UI element position string
  imageFactor3 = 1      -- multiplied by position.y to generate third value in the UI element position string
  btnFactor1 = -0.01 -- multiplied by position.x to set X value for decorative buttons
  btnFactor2 =  0.01   -- multiplied by position.y to set Y value for decorative buttons
  btnFactor3 =  0.01 -- multiplied by position.z to set Z value for decorative buttons
  btnScaleWidth = 240 -- used for scale of decorative buttons
  btnScaleHeight = 345 -- used for scale of decorative buttons

  for drawOrder,thisElement in ipairs(systemElements) do
    debugLog{"thisElement.id: "..thisElement.id, 5}
    table.insert(arenaStationXmlTable, {-- Image element.
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
        tooltip = thisElement.hoverTooltip,
        tooltipTextColor = "rgba(1,1,1,0)",
        tooltipBorderColor = "rgba(0,0,0,0)",
        tooltipBackgroundColor = "rgba("..thisElement.hoverColor.r..","..thisElement.hoverColor.g..","..thisElement.hoverColor.b..","..thisElement.hoverColor.a..")",
        tooltipBackgroundImage = thisElement.hoverImage,
        tooltipPosition = "Above",
        tooltipOffset = "-45",
        visibility = thisElement.visibilityString,
      }, -- end attributes for Image
    })

    -- If applicable, create a decorative button to make the text tooltip show up properly.
    debugLog{" attempting to create decorative button", 5}
    if thisElement.tooltip != nil then
      self.createButton({
          click_function = 'click_Button',
          function_owner = self,
          width          = btnScaleWidth,
          height         = btnScaleHeight,
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

  self.UI.setXmlTable(arenaStationXmlTable)

  if Global.getVar("debugFlag") == true then
    self.interactable = false
  end
end -- end onLoad



function spawnArena(params)
  local chosenArenaIndex = params.chosenArenaIndex
  local class            = params.class
  local playerColor      = params.playerColor

  if type(playerColor) != [[string]] then
    debugLog{"error: Arena Station: playerColor is not a string!"}
    return
  end

  -- If not predetermined, class is weighted toward simpler arenas.
  if class == nil then
    class = math.random(1, 6)
    if class <= 3 then class = 1
    elseif class <= 5 then class = 2
    elseif class == 6 then class = 3
    end
  end

  local playerReference = Player[playerColor]
  local playerHandTransform = playerReference.getHandTransform()
  local bagTransform = {
    posX = playerHandTransform.position.x,
    posY = playerHandTransform.position.y,
    posZ = playerHandTransform.position.z,
    scaleX = 1.8,
    scaleY = 1.2,
    scaleZ = 1.8,
  }

  local validArena = false
  local spawnData = {
    Name = "Bag",
    Transform = bagTransform,
    Nickname = [[The Stage of Battle is Set!]],
    Description = [[Contains an arena!]],
    GMNotes = "",
    Memo = "selfdestruct",
    ColorDiffuse = { r = 0, g = 0, b = 0, a = 0.5, },
    Locked = true,
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

  local chosenArena = {}
  local chosenArenaData = {}

  -- If an arena was explicitly specified, use that instead of a random arena.
  if chosenArenaIndex != nil then
    if arenas[chosenArenaIndex] != nil then
      chosenArena = arenas[chosenArenaIndex]
      validArena = true
    end
  end

  while validArena == false do
    chosenArena = arenas[math.random(1, #arenas)]
    --printToAll("arena: "..chosenArena.name)
    if chosenArena.class == class then
      validArena = true
    end -- end class check
  end -- end validArena check

  chosenArenaData = {
    Name = "Custom_Tile",
    Transform = { scaleX = 2.5, scaleY = 1.0, scaleZ = 2.5 },
    Nickname = chosenArena.name,
    Description = chosenArena.announcement,
    Tags = {
      "Arenas"
    },
    Tooltip = true,
    HideWhenFaceDown = false,
    Hands = true,
    CustomImage = {
      ImageURL = chosenArena.faceURL,
      ImageSecondaryURL = chosenArena.backURL,
      ImageScalar = 1.0,
      WidthScale = 0.0,
      CustomTile = { Thickness = 0.1, Stretch = true }
    },
  }

  if chosenArena.enclosed != nil then
    table.insert(spawnData.ContainedObjects, chosenArena.enclosed)
  end

  table.insert(spawnData.ContainedObjects, chosenArenaData)

  spawnData.Nickname = [[Arena: ]]..chosenArena.name

  spawnObjectData({
    data = spawnData,
    position = playerHandTransform.position,
    callback_function = function(obj) deckToHand(obj, futureName, playerColor) end,
  })

  if chosenArena.announcement != nil then
    playerReference.broadcast(chosenArena.announcement)
  end

  local glitchMode = Global.getVar("glitchMode")
  if glitchMode == true then
    Global.call("givePrizeToPlayer", {
      playerReference = playerReference,
      multiplier = 100,
    })
  end
end -- end spawnArena



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
end -- end debugLog



function deckToHand(obj, name, color)
  obj.setLock(false)
end -- end deckToHand



function uiClick_SpawnArena(player, value, id)
  local optionsDialogArenasList = {
    "<Random>", -- index 1
    "<Random Class 1>", -- index 2
    "<Random Class 2>", -- index 3
    "<Random Class 3>", -- index 4
  }
  for i,arenaName in ipairs(arenasNamesTable) do
    table.insert(optionsDialogArenasList, arenaName)
  end

  player.showOptionsDialog("Set the stage!", optionsDialogArenasList, 1,
    function (selectedArenaName, selectedArenaIndex, playerColor)
      local arenaParams = {
        playerColor = playerColor,
        class = nil,
        chosenArenaIndex = nil,
      }
      -- We initialized this list with the four Random options, so we need to adjust the passed parameters accordingly.
      if selectedArenaIndex == 2 then
        arenaParams.class = 1
      elseif selectedArenaIndex == 3 then
        arenaParams.class = 2
      elseif selectedArenaIndex == 4 then
        arenaParams.class = 3
      elseif selectedArenaIndex > 4 then
        arenaParams.chosenArenaIndex = selectedArenaIndex-4
      end -- end index check

      spawnArena(arenaParams)
    end -- end anonymous function
  ) -- end showOptionsDialog
end -- end uiClick_SpawnArena