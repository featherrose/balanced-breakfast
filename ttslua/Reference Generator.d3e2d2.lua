-- This is set up like this so reference decal variables can be changed in one central location, rather than throughout the script.
function getReferenceDecal()
  return {
    Transform = {
      posX = 0,
      posY = 0.363,
      posZ = 0,
      rotX = 90,
      rotY = 180,
      rotZ = 0,
      scaleX = 2.146,
      scaleY = 3.0675,
      scaleZ = 1,
    },
    CustomDecal = {
      Name = [[Decal]],
      ImageURL = [[https://raw.github.com/featherrose/balanced-breakfast/refs/heads/main/images/sP61UtR.png]],
      Size = 120
    }
  }
end



function onObjectDrop(color, obj)
    --print("Obj" .. obj.getName()) --debug
    local objectName = obj.getName()
    local objectNick = obj.name
    --print(objectName)
    --print(objectNick)
    --printToAll("getName, 1 = "..string.sub(obj.getName(), 1, 13))
    if obj.tag != 'Card' then
        if nearMe(obj) then
          local opponentNameString = string.gsub(obj.getName(), [==[%[.-%]]==], [[]])
          --printToAll(opponentNameString, {1,0.7,0.3})
            if string.sub(opponentNameString, 1, 13) == [[Your Opponent]] then
                MusicPlayer.repeat_track = false
                MusicPlayer.setCurrentAudioclip({url=[[https://cdn.discordapp.com/attachments/487059391116476419/831671156402028605/Wilhelm_Scream.ogg]],title=[[Wilhelm Scream]]})
                panic()
                return
            end
            --printToAll("nearMe: TRUE",{1,1,1})
            --deckTitle = "Decklist"
            --deckContents = ""
            if obj.tag == 'Deck'
            and (
              (obj.getRotation()[3] > 160 and obj.getRotation()[3] < 200)
              or
              (obj.getRotation()[3] > 340 or obj.getRotation()[3] < 20)
            ) then
              decalSetting = true
              if obj.getRotation()[3] > 160 and obj.getRotation()[3] < 200 then
                decalSetting = false
              end
                --print("Deck found in deck drop zone.")
                --printToAll("obj.getObjects length: " .. #obj.getObjects(),{r=1,g=1,b=1})

                  local normalList = {}
                  local specialList = {}
                  local ultraList = {}
                  local unknownList = {}
                  if objectName == [[]] then objectName = [[a character]] end

                  -- Read each card.
                    -- If the card's DeckID does not already appear in deckInfoTable, add it.
                    -- Identify the card's type and, thus, the appropriate list: normalList, specialList, ultraList, or unknownList
                      -- Check for a card of the exact same name in that card list.
                        -- If there is one, increment the quantity for that card by 1.
                        -- Otherwise, insert the card's name into that card list.
                  -- For each card in ultraList, then specialList, then unknownList...
                    -- add the card's deckID to the CustomDeckIDList for the reference set JSON.
                    -- add the card's JSON contents to the ContainedObjects table for the reference set JSON.
                  -- Spawn two reference sets.

                  --printToAll("reading data: "..os.time(), {0.3,1,0.3})

                  local objTable = obj.getData()
                  local refTable = {}

                  local deckInfoTable = {}

                  --printToAll(os.time().." - parsing deckIDs", {0.3,1,0.3})

                  local cardCount = 0

                  for i,deckID in ipairs(objTable["DeckIDs"]) do
                    deckID = tonumber(string.sub(deckID, 1, string.len(deckID)-2))
                    --printToAll("deckID: "..deckID)
                    --printToAll("deckIDtype: "..type(deckID))
                    if deckInfoTable[deckID] == nil then
                      --printToAll("unique deckID: "..deckID)
                      --printToAll("   typing: "..type(deckID))
                      deckInfoTable[deckID] = {}
                      local objCustomDeck = objTable["CustomDeck"]

                      deckInfoTable[deckID]["FaceURL"] = objCustomDeck[deckID]["FaceURL"]
                      deckInfoTable[deckID]["BackURL"] = objCustomDeck[deckID]["BackURL"]
                      deckInfoTable[deckID]["NumWidth"] = objCustomDeck[deckID]["NumWidth"]
                      deckInfoTable[deckID]["NumHeight"] = objCustomDeck[deckID]["NumHeight"]
                      deckInfoTable[deckID]["BackIsHidden"] = objCustomDeck[deckID]["BackIsHidden"]
                      deckInfoTable[deckID]["UniqueBack"] = objCustomDeck[deckID]["UniqueBack"]
                      deckInfoTable[deckID]["Type"] = objCustomDeck[deckID]["Type"]

                      --[=[
                      printToAll("   FaceURL: "..deckInfoTable[deckID]["FaceURL"])
                      printToAll("   BackURL: "..deckInfoTable[deckID]["BackURL"])
                      printToAll("   NumWidth: "..deckInfoTable[deckID]["NumWidth"])
                      printToAll("   NumHeight: "..deckInfoTable[deckID]["NumHeight"])
                      printToAll("   BackIsHidden: "..deckInfoTable[deckID]["BackIsHidden"])
                      printToAll("   UniqueBack: "..deckInfoTable[deckID]["UniqueBack"])
                      printToAll("   Type: "..deckInfoTable[deckID]["Type"])
                      --]=]
                    end
                  end

                  --printToAll(os.time().." - parsing Contained Objects",{0.3,1,0.3})

                  for cardNumber,thisCard in pairs(objTable["ContainedObjects"]) do
                    -- If the GMNotes for this card end in '.reference', it's a reference card.
                    if not string.match(thisCard["GMNotes"], '.*%.reference$') then
                      local thisCardName = thisCard["Nickname"] or [[]]
                      local thisCardDescription = thisCard["Description"] or [[]]
                      local thisCardGMNotes = thisCard["GMNotes"]
                      --printToAll("thisCardName: "..thisCardName)
                      local thisCardIndex = string.sub(thisCard["CardID"], -2)
                      local thisCardDeckNumber = tonumber(string.sub(thisCard["CardID"], 1, string.len(thisCard["CardID"])-2))
                      --printToAll("thisCardIndex: "..thisCardIndex)
                      --printToAll("thisCardDeckNumber: "..thisCardDeckNumber)

                      --printToAll("   typing: "..type(thisCardDeckNumber))

                      --[=[
                      for key,val in pairs(deckInfoTable[thisCardDeckNumber]) do
                        printToAll("deckInfoTable entry for thisCardDeckNumber: "..key)
                        printToAll("value: "..val)
                      end
                      --]=]

                      local thisCardFace = deckInfoTable[thisCardDeckNumber]["FaceURL"]
                      local thisCardBack = deckInfoTable[thisCardDeckNumber]["BackURL"]
                      local thisCardWidth = deckInfoTable[thisCardDeckNumber]["NumWidth"]
                      local thisCardHeight = deckInfoTable[thisCardDeckNumber]["NumHeight"]
                      local thisCardHiddenBack = deckInfoTable[thisCardDeckNumber]["BackIsHidden"]
                      local thisCardUniqueBack = deckInfoTable[thisCardDeckNumber]["UniqueBack"]
                      local thisCardShape = deckInfoTable[thisCardDeckNumber]["Type"]

                      --printToAll("thisCardWidth: "..thisCardWidth)
                      --printToAll("thisCardHeight: "..thisCardHeight)
                      --printToAll("thisCardFace: "..thisCardFace)
                      --printToAll("thisCardBack: "..thisCardBack)

                      local thisCardType = string.sub(thisCard["Nickname"], -3)
                      local thisCardIdentifier = thisCardName..[[.]]..thisCardDeckNumber..[[.]]..thisCardIndex..[[.]]..thisCardWidth..[[.]]..thisCardHeight..[[.]]..thisCardFace..[[.]]..thisCardBack
                      --printToAll("thisCardIdentifier: "..thisCardIdentifier)

                      local thisCardList = unknownList

                      if thisCardType == [[(U)]] then
                        thisCardType = [[Ultra]]
                        thisCardList = ultraList
                      elseif thisCardType == [[(S)]] then
                        thisCardType = [[Special]]
                        thisCardList = specialList
                      elseif thisCardType == [[(N)]] then
                        thisCardType = [[Normal]]
                        thisCardList = normalList
                      elseif thisCardType == [[(C)]] then
                        thisCardType = [[Character]]
                      else
                        thisCardType = [[none]]
                        thisCardList = unknownList
                      end
                      --printToAll("thisCardType: "..thisCardType)

                      if thisCardType != [[Character]] then
                        if thisCardList[thisCardIdentifier] != nil then
                          thisCardList[thisCardIdentifier]["copies"] = thisCardList[thisCardIdentifier]["copies"]+1
                          --printToAll("incremented", {0.7, 0, 1})
                        else
                          thisCardList[thisCardIdentifier] = {
                            cardNickname = thisCardName,
                            cardDescription = thisCardDescription,
                            cardGMNotes = thisCardGMNotes,
                            deckID = thisCardDeckNumber,
                            cardID = thisCardIndex,
                            gridWidth = thisCardWidth,
                            gridHeight = thisCardHeight,
                            cardFace = thisCardFace,
                            cardBack = thisCardBack,
                            hiddenBack = thisCardHiddenBack,
                            uniqueBack = thisCardUniqueBack,
                            type = thisCardShape,
                            exceedType = thisCardType,
                            copies = 1,
                          }
                          --printToAll("added", {0, 1, 0.3})
                        end
                      end -- end 'if cardType is not Character'
                    end -- end 'if not reference'
                  end -- end pairs(objTable["ContainedObjects"])

                  --printToAll(os.time().." - assembling reference set", {0.3,1,0.3})

                  referenceDecal = getReferenceDecal()
                  local referenceTransformTable = {
                    posX = self.getPosition().x,
                    posY = self.getPosition().y+4,
                    posZ = self.getPosition().z,
                    scaleX = 1.25,
                    scaleY = 1.0,
                    scaleZ = 1.25,
                    rotX = 0,
                    rotY = self.getRotation().y,
                    rotZ = 0,
                  }
                  local referenceTransformTableLeft = {
                    posX = self.getPosition().x - 4,
                    posY = self.getPosition().y + 3,
                    posZ = self.getPosition().z,
                    scaleX = 1.25,
                    scaleY = 1.0,
                    scaleZ = 1.25,
                    rotX = 0,
                    rotY = self.getRotation().y,
                    rotZ = 315,
                  }
                  local referenceTransformTableRight = {
                    posX = self.getPosition().x + 4,
                    posY = self.getPosition().y + 3,
                    posZ = self.getPosition().z,
                    scaleX = 1.25,
                    scaleY = 1.0,
                    scaleZ = 1.25,
                    rotX = 0,
                    rotY = self.getRotation().y,
                    rotZ = 315,
                  }
                  local cardTransformTable = {
                    posX = 0,
                    posY = 0,
                    posZ = 0,
                    rotX = 0,
                    rotY = 0,
                    rotZ = 0,
                    scaleX = 1.25,
                    scaleY = 1.0,
                    scaleZ = 1.25,
                  }
                  local cardColorTable = {
                    r = 0.713235259,
                    g = 0.713235259,
                    b = 0.713235259,
                    a = 1,
                  }

                  -- Everything now uses tables and natural data structures instead of JSON traversal.
                  local cardList = {}
                  local referenceDeckData = {
                    GUID = [[112358]],
                    Name = [[Deck]],
                    Transform = referenceTransformTable,
                    Nickname = objectName,
                    Description = [[Reference set for ]]..objectName,
                    GMNotes = objectName..[[.reference]],
Memo = [[nonstackable]],
                    ColorDiffuse = cardColorTable,
                    LayoutGroupSortIndex = 0,
                    Value = 0,
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
                    Hands = false,
                    SidewaysCard = false,
                    DeckIDs = {},
                    CustomDeck = {},
                    LuaScript = [[]],
                    LuaScriptState = [[]],
                    XmlUI = [[]],
                    ContainedObjects = {},
                    --AttachedDecals = {},
                  }

                  -- Add all the Ultras to the card list.
                  for identifier,cardEntry in pairsByKeys(ultraList) do
                    table.insert(cardList, cardEntry)
                    cardCount = cardCount+1
                  end
                  -- Add all the Specials to the card list.
                  for identifier,cardEntry in pairsByKeys(specialList) do
                    table.insert(cardList, cardEntry)
                    cardCount = cardCount+1
                  end
                  -- Add all the unknown cards to the card list.
                  for identifier,cardEntry in pairsByKeys(unknownList) do
                    table.insert(cardList, cardEntry)
                    cardCount = cardCount+1
                  end

                  if cardCount == 1 then
                    cardEntry = cardList[1]
                    --printToAll("card count is 1")

                    -- If the card doesn't have exactly two copies, enable tooltip and change its name to the number of copies.
                    if cardEntry["copies"] != 2 then
                      cardEntry["cardNickname"] = "x"..cardEntry["copies"]
                      cardEntry["tooltip"] = true
                    else
                      cardEntry["tooltip"] = false
                    end

                    -- cardCustomDeckTable would normally be a subtable for referenceDeckData["CustomDeck"], but this is only a single card.
                    local cardCustomDeckTable = {
                      FaceURL = cardEntry["cardFace"],
                      BackURL = cardEntry["cardBack"],
                      NumWidth = cardEntry["gridWidth"],
                      NumHeight = cardEntry["gridHeight"],
                      BackIsHidden = cardEntry["hiddenBack"],
                      UniqueBack = cardEntry["uniqueBack"],
                      Type = cardEntry["type"],
                    }

                    referenceDeckData = {
                      GUID = [[112358]],
                      Name = [[Card]],
                      Transform = cardTransformTable,
                      Nickname = cardEntry["cardNickname"],
                      Description = [[]],
                      GMNotes = cardEntry["cardGMNotes"]..[[.reference]],
                      Memo = [[]],
                      ColorDiffuse = cardColorTable,
                      LayoutGroupSortIndex = 0,
                      Value = 0,
                      Locked = false,
                      Grid = true,
                      Snap = true,
                      IgnoreFoW = false,
                      MeasureMovement = false,
                      DragSelectable = true,
                      Autoraise = true,
                      Sticky = true,
                      Tooltip = cardEntry["tooltip"],
                      GridProjection = false,
                      HideWhenFaceDown = true,
                      Hands = true,
                      CardID = tonumber(cardEntry["deckID"]..cardEntry["cardID"]),
                      SidewaysCard = false,
                      CustomDeck = {},
                      LuaScript = [[]],
                      LuaScriptState = [[]],
                      XmlUI = [[]],
                      AttachedDecals = {},
                    }
                    referenceDeckData["CustomDeck"][cardEntry["deckID"]] = cardCustomDeckTable[cardEntry["deckID"]]
                    if decalSetting then
                      table.insert(referenceDeckData["AttachedDecals"], referenceDecal)
                    end

                  elseif cardCount > 1 then
                    --printToAll("card count exceeds 1")

                    -- Iterate through the card list. Each entry is a distinct card.
                    for index,cardEntry in ipairs(cardList) do
                      --printToAll(os.time().." - loop: "..cardEntry["cardNickname"])

                      -- If the card doesn't have exactly two copies, enable tooltip and change its name to the number of copies.
                      if cardEntry["copies"] != 2 then
                        cardEntry["cardNickname"] = "x"..cardEntry["copies"]
                        cardEntry["tooltip"] = true
                      else
                        cardEntry["tooltip"] = false
                      end

                      -- cardCustomDeckTable is a subtable for referenceDeckData["CustomDeck"].
                      local cardCustomDeckTable = {
                        FaceURL = cardEntry["cardFace"],
                        BackURL = cardEntry["cardBack"],
                        NumWidth = cardEntry["gridWidth"],
                        NumHeight = cardEntry["gridHeight"],
                        BackIsHidden = cardEntry["hiddenBack"],
                        UniqueBack = cardEntry["uniqueBack"],
                        Type = cardEntry["type"],
                      }

                      -- insert DeckID into referenceDeckData["DeckIDs"]
                      table.insert(referenceDeckData["DeckIDs"], tonumber(cardEntry["deckID"]..cardEntry["cardID"]))

                      -- insert CustomDeck table into referenceDeckData["CustomDeck"]
                      referenceDeckData["CustomDeck"][cardEntry["deckID"]] = cardCustomDeckTable

                      local cardData = {
                        GUID = [[112358]],
                        Name = [[Card]],
                        Transform = cardTransformTable,
                        Nickname = cardEntry["cardNickname"],
                        Description = [[]],
                        GMNotes = cardEntry["cardGMNotes"]..[[.reference]],
                        Memo = [[]],
                        ColorDiffuse = cardColorTable,
                        LayoutGroupSortIndex = 0,
                        Value = 0,
                        Locked = false,
                        Grid = true,
                        Snap = true,
                        IgnoreFoW = false,
                        MeasureMovement = false,
                        DragSelectable = true,
                        Autoraise = true,
                        Sticky = true,
                        Tooltip = cardEntry["tooltip"],
                        GridProjection = false,
                        HideWhenFaceDown = true,
                        Hands = true,
                        CardID = tonumber(cardEntry["deckID"]..cardEntry["cardID"]),
                        SidewaysCard = false,
                        CustomDeck = {},
                        LuaScript = [[]],
                        LuaScriptState = [[]],
                        XmlUI = [[]],
                        AttachedDecals = {},
                      }
                      cardData["CustomDeck"][cardEntry["deckID"]] = cardCustomDeckTable[cardEntry["deckID"]]
                      if decalSetting then
                        table.insert(cardData["AttachedDecals"], referenceDecal)
                      end

                      -- insert card table into referenceDeckData["ContainedObjects"]
                      table.insert(referenceDeckData["ContainedObjects"], cardData)

                      --printToAll(printTable(cardData))
                    end -- end 'for index,cardEntry in ipairs(cardList)'

                    --printToAll("================================", {1,0,0})
                    --printToAll(printTable(obj.getData()))
                    --printToAll("================================", {1,0.6,0.2})
                    --printToAll(printTable(referenceDeckData))

                  end -- end 'if cardCount > 1'

                  if cardCount != 0 then

                    spawnObjectData({
                      data = referenceDeckData,
                      position = {
                        x = self.getPosition().x-4,
                        y = self.getPosition().y+4,
                        z = self.getPosition().z,
                      },
                      scale = { x = 1.25, y = 1.0, z = 1.25 },
                      rotation = {
                        x = 0,
                        y = self.getRotation().y,
                        z = 315,
                      },
                    })

                    spawnObjectData({
                      data = referenceDeckData,
                      position = {
                        x = self.getPosition().x+4,
                        y = self.getPosition().y+4,
                        z = self.getPosition().z,
                      },
                      scale = { x = 1.25, y = 1.0, z = 1.25 },
                      rotation = {
                        x = 0,
                        y = self.getRotation().y,
                        z = 45,
                      },
                    })
                  end -- end 'if cardCount != 0'
            end -- end 'if Deck'
        end -- end 'if nearMe'
    end -- end 'if not Card'
end

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
end

function nearMe(obj)
    if obj.getGUID() != self.getGUID() then
      --printToAll("obj: " .. obj.getGUID())
      --printToAll("selfPos: " .. self.getPosition().x)
      return withinArea(self, obj)
    end
    return
end

function panic()
  local myScale = self.getScale()
  myScale.x = myScale.x*0.99
  myScale.y = myScale.y*0.99
  myScale.z = myScale.z*0.99
  if myScale.x < 0.001 or myScale.y < 0.001 or myScale.z < 0.001 then
    self.destruct()
    return
  end
  Wait.frames(function ()
    self.setScale(myScale)
    panic()
  end, 1)
end


function printTable(thisTable, indentation)
  local indent = indentation or [[]]
  indent = indent.." "
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
  else
    --local value = thisTable or "nil"
    printString = printString..[=[[00FFFF]value: ]=]..thisTable..[=[[-]]=]
    --printToAll(indent.."value: "..thisTable, {0,1,1})
  end
  return printString
end -- end printTable

function withinArea(area, obj)
    local ap = area.getPosition()
    local as = area.getScale()
    local op = obj.getPosition()
    return op[1] > ap[1] - as[1]*16 and op[1] < ap[1] + as[1]*16 and op[3] > ap[3] - as[3]*20 and op[3] < ap[3] + as[3]*20
end