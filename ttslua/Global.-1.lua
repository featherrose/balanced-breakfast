--[[ Lua code. See documentation: http://berserk-games.com/knowledgebase/scripting/ --]]

--[[ The OnLoad function. This is called after everything in the game save finishes loading.
Most of your script code goes here. --]]
function onload()

--[===[
-- this shouldn't be here at all
local count = 0
local outputString = [[]]

for i,v in ipairs({ [[CROSS]], [[BLAZ]], [[BLUE]] }) do
  count = count+1
  if math.fmod(count, 3) == 0 then
    outputString = outputString..[[, BATTLE ]]
  else
    outputString = outputString..[[ ]]
  end
  outputString = outputString..[[TAG ]]..v
end

printToAll(outputString)
-- you might be wondering why any of this was here
-- good
--]===]

    versionNumber = 14.0 -- Doesn't actually do anything except show up in an announcement.
    versionLabel = [[The 14.0 Update]] -- Same as above.
    -- DONE: Rename the variable "godforsaken" to the slightly clearer "excludeFromRandomAny".
    -- TODO: Continue continuing to add content for April Fool's 2025.
    -- -- TODO: Iota.
    -- -- TODO: Restore the Bag of Lag.
    -- DONE: Continue adding content for April Fool's 2025.
    -- -- DONE: Julius Belmont's card backs.
    -- -- DONE: Soma Cruz's card backs.
    -- -- DONE: The Reaper's reference cards.
    -- -- DONE: Fix Ogre Magi's Basic Mode.
    -- -- DONE: A costume change for Lilith.
    -- -- DONE: Points do something.
    -- DONE: Add content for April Fool's Exceed 2025.
    -- -- DONE: Julius Belmont.
    -- -- DONE: Soma Cruz.
    -- -- DONE: Melf.
    -- -- DONE: Carry Potter.
    -- -- DONE: Dudes of Hazmat.
    -- -- DONE: Storm.
    -- -- DONE: Luavirus.
    -- -- DONE: A Gorilla.
    -- -- DONE: The Reaper.
    -- -- DONE: Cui.
    -- -- DONE: Some random customs.
    -- TODO: Table color options?
    -- TODO: Add missing Flailing characters.
    -- TODO: Add more Mega Men.
    -- TODO: Rewinding breaks the world.
    -- -- FIXED: Rewinding breaks playmats.
    -- -- FIXED: Rewinding breaks reference areas.
    -- TODO: Implement full-scale Info Mode.
    -- TODO: [Disable Character] functionality.
    -- TODO: Develop stat tracking for custom character analysis. Review tournament results.
    -- TODO: Overhaul refcards for all of S1 through S6.
    -- TODO: Overhaul timer system.
    -- TODO: Implement match recorder.
    -- TODO: Season mechanic reference for Overloads.
    -- TODO: Enable spawning of headless reference sets.

    -- Legal Gear Update
      -- Corrected character legality for Random Legal.
    -- Unfool's 2024 Update
      -- Calmed things down after the holiday.
      -- Disabled Bugs.
    -- St. Patrick's Day Update, Patch 1
      -- Added Bad Company, Shin Beheaded, and She Who Lurks.
    -- Valentine's Day Update
      -- Spruced things up for the holiday.
      -- Enabled Bugs.
      -- Added Season 7 of Exceed: The TV Series.
      -- Added Mega Man... and Mega Man.
      -- New bugs introduced into the half-mat system.
      -- Your Opponent now has a wider selection of Normals.
    -- Update That Has Nothing To Do With Strive
      -- Back replacers now replace with the default Exceed card back URL, rather than Van Diesel.
      -- FIXED: Broken link for Normals reference.
      -- FIXED: Broken links for 7 Grand Dad, Garou Mark of the Train, Legal Wuhu, Ostrheinsburg Chapel, and Pokefloats.
      -- FIXED: Broken links for Ballot, Dante, and Tony Hawk.
      -- FIXED: Broken links for Akame ga Kill and Nine & Noel.
      -- FIXED: Seventh Cross playmat no longer registered as halfmat-compatible.
      -- DONE: Passwords are more useful. (Custom character access system still has not been overhauled.)
      -- DONE: Enabling/disabling Bugs should be much more explicit as to what it actually does.
      -- DONE: Enabling/disabling Flailing should be much more explicit as to what it actually does.
      -- DONE: Deleting Bugs should disable Bugs.
      -- DONE: Deleting Flailing should disable Flailing.
      -- DONE: Behemoth Typhoon's name should be optimized for viewing in search boxes.
      -- DONE: Updated Skull Kid.
    -- Strive Update, Patch 2
      -- Added memes.
      -- FIXED: Fixed H|H coin.
      -- FIXED: Search improvements for Dust/Spike and Slash/Assault.
      -- FIXED: Snap points are broken on "Options" and "EMOMOMO".
      -- FIXED: s7 characters now support the "Choose your active Normals" button.
      -- FIXED: Invisible object which manages the table toggles should be uninteractable.
      -- FIXED: Rewinding breaks playmats.
      -- FIXED: Rewinding breaks reference areas.
      -- FIXED: Snap points are terrible on GGST mat.
      -- FIXED: Default lift height is now too high for the Reference Areas to work.
    -- Strive Update, Patch 1
      -- Added S7 Normals in the Seventh Cross style.
    -- Strive Update
      -- Added the cast of Guilty Gear -Strive-: The Board Game.
    -- Still My Heart Is Update
      -- Disabled hover images to attempt to improve load times.
      -- Finally changed the default playmat in the center table.
      -- Removed some hidden content as an action of desperation to reduce load times.
      -- Added (scuffed) public preview versions of Guilty Gear characters.
    -- April 2nd Update
      -- DONE: Fix Devris, Hakumen, Hazama, M. Bison.
    -- April 1st Update
      -- DONE: Reverted coins.
      -- DONE: Reverted flailing.
      -- DONE: Bugs disabled by default.
    -- St Patrick's Day Update (Fool's Exceed 2023)
      -- DONE: Added searchable Speed values.
      -- DONE: Fixed the name of Desperate Gambit.
      -- DONE: Arena selector.
      -- DONE: Added cpat's Normals.
      -- DONE: Update S6 with new canon.
      -- TODO: Added a bunch of playmats.
      -- TODO: Add a bag of things.
      -- DONE: Fixed Normals reconfiguring themselves in strange ways. Maybe.
      -- DONE: Shovel Knight, BlazBlue, and Under Night characters now use the Diverse sets as their alternate Normals.
      -- DONE: BlazBlue characters now use their enhanced Normals as their default Normals. (Their as-printed Normals are no longer available.)
      -- DONE: Waldo has been made easier to find, but only if you know how to find him.
      -- DONE: In an effort to increase randomness, coin flips will now always result in Tails.
      -- DONE: Exceed has been replaced by a more perfect game.
      -- DONE: Due to data corruption, old card previews have crept into the current image files.
      -- DONE: Gordeau's Normals have not been changed.
      -- DONE: Cardback memes intensified.
      -- DONE: Bugs have not been fixed, but they can now be toggled.
    -- Note: If I need to roll back after this overhaul, the previous stable version was [13.86: The Byakuya Update]
    -- DONE: Overhaul reference generators.
    -- DONE: Overhaul select screen.

    debugFlag = false -- Look at this optimism!
    debugLevel = 2
    -- There's no special meaning associated with the debug levels.
    -- Generally '0' is the sort of thing that should come up if any debugging is on,
    -- '1' is stuff that's useful if I'm trying to figure out at what stage something is breaking,
    -- '2' is for whatever I'm working on right now,
    -- '3' is for stuff I thought worked but might be breaking now,
    -- '5' is for really obnoxious debug output that tends to cause massive lag.
    if debugFlag == true then
      print("debugging")
      print("debugLevel "..debugLevel)
    end

    math.randomseed(os.time())
    if debugFlag == true then printToAll("Benchmarking, started loading at: "..os.time()) end

    playmatStationGUID = [[b70028]]
    characterStationGUID = [[1b4685]]
    arenaStationGUID = [[ca8347]]

    flailingMode = false
    glitchMode = false -- true for April Fool's, otherwise false
    validationMode = false

    -- Whenever we hide an object, we set hiddenObjects[that object's GUID] to true.
    hiddenObjects = {}

    -- Ditto uninteractables.
    uninteractableObjects = {}

    --[==[
    local state = JSON.decode(script_state)
    if state != nil then
      debugLog{printTable(state), 2}

      if state.hiddenObjects != nil then
        hiddenObjects = state.hiddenObjects
      end
      if state.uninteractableObjects != nil then
        uninteractableObjects = state.uninteractableObjects
      end
    end
    --]==]

    -- Ensures each player is shown the disclaimer concerning cards not representing their printed counterparts.
    disclaimedPlayers = {}
    local playerList = Player.getPlayers()
    for i,thisPlayer in ipairs(playerList) do
      if thisPlayer.host == true then
        disclaimToColor(thisPlayer)
      end
    end

    -- All times in seconds.
    maxTurnTime = 120 -- The maximum amount of time for a given turn.
    firstWarning = (20 * 60) -- Remaining time at which first warning is given.
    secondWarning = (10 * 60) -- Remaining time at which second warning is given.
    thirdWarning = (2 * 60) -- You get the idea.

    -- activeStrike indicates whether we're in "borrowed" time due to a Strike.
    activeStrike = false

    -- isPaused indicates whether the clocks were manually paused.
    -- (This only notices the Pause button's activity, not clicking the clocks.)
    isPaused = false

    -- Temporarily becomes set to true when color Black pauses an unpausable game.
    pauseOverride = false

    -- This mapping table is used by getPlayerNumber(playerColor), which
    --  returns values used to create dynamic references.
    actualPlayer = {
        Red = "Plr2",
        Blue = "Plr1",
        Green = "Plr3",
        Yellow = "Plr4",
        Purple = "Plr5",
        Orange = "Plr6",
    }

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
      "Grey"
    }

    -- The actual player names output when text refers to Plr1 or Plr2,
    --  in case we want to use different actual colors (see above).
    -- This also lets us substitute strPlr1 when a player name is required.
    strPlr1 = "Blue"
    strPlr2 = "Red"
    strPlr3 = "Green"
    strPlr4 = "Yellow"
    strPlr5 = "Purple"
    strPlr6 = "Orange"

    -- Various color values for when we recolor things.
    textColorPlr1 = {0.118, 0.53, 1}
    textColorPlr2 = {0.856, 0.1, 0.094}
    clockColorPlr1 = {50/255, 100/255, 255/255}
    clockColorPlr2 = {255/255, 50/255, 50/255}
    colorDefaultText = {1,1,1}
    colorDefaultBG = {0,0,0}
    colorAnnouncer = {0,0,0} -- Announcervoice text color.
    colorNotifications = {155/255,155/255,155/255} -- Boring event notifications.

    -- This is functionally a flag to indicate the game hasn't started yet.
    --  setCurrent(newPlayer) should be used to ensure these remain in sync.
    currentPlayer = "Nobody"
    opponent = "Nobody"

    -- If the round ends due to timeout, who loses?
    timeoutLoser = "Nobody"

    -- When we "hide" or "show" buttons, we're actually just moving them.
    -- The offset is the distance we move them.
    hideOffset = 150
--    if debugFlag == true then
--        hideOffset = 5
--    end

    -- Creates a table containing each of the timer modes.
    timerModes = {
        {
            modeName = "Chess Clocks",
            modeLabel = "Chess\nClocks",
            modeTooltip = "Click to change timer mode",
            modeDesc = [[---- Chess Clocks ----
- Gain set amount of time per player.
- If gap between player times exceeds 120s
when slower player runs out of time, slower
player loses if game clock runs out.
]],
            modeActiveDesc = [[ NumPad Hotkeys:

0 - End Turn  ]]..[[

1 - Start Turn]]..[[


4 - Pause       ]]..[[

5 - Resume    ]]..[[


End Turn after initiating a Strike.
Pause after revealing attacks.
Resume when the Strike ends.
]],
            hideHiddenAreas = true,
            showBtnStrike = true,
            showBtnTurn = true,
            useBanks = false,
            useRound = true,
            useTurns = true,
            playerTurnTime = (15 * 60),
            maxRoundTime = (30 * 60),
            mercyTime = 120,
            timeTiebreaks = true,
            pauseRoundTimer = false,
            pauseTurnTimer = true,
            fnCleanup = 'noCleanup',
            fnPause = 'pauseTimers',
            fnStart = 'modeChessStart',
            fnStrike = 'pauseTimers',
            fnTimeout = 'modeChessTimeout',
            fnTurn = 'modeChessSwap',
            fnUnpause = 'modeChessUnpause',
            implemented = true,
        },
        {
            modeName = "Final Destination",
            modeLabel = "Final\nDestination",
            modeTooltip = "Click to change timer mode",
            modeDesc = [[---- Final Destination ----
- Gain set amount of time per round.
- If time runs out, game ends immediately.
Do not finish the turn. Do not collect $200.
]],
            modeActiveDesc = [[]],
            hideHiddenAreas = false,
            showBtnStrike = false,
            showBtnTurn = false,
            useBanks = false,
            useRound = true,
            useTurns = false,
            maxRoundTime = (60 * 60), -- Formerly (10 * 60)
            timeTiebreaks = false,
            pauseRoundTimer = false, -- Formerly true
            pauseTurnTimer = false,
            fnCleanup = 'noCleanup',
            fnPause = 'pauseTimers',
            fnStart = 'modeBoringStart',
            fnTurn = 'announceGame',
            fnUnpause = 'modeBoringUnpause',
            implemented = true,
        },
        {
            modeName = "No Items",
            modeLabel = "No\nItems",
            modeTooltip = "Click to change timer mode",
            modeDesc = [[---- No Items ----
- Disable all timers.
]],
            modeActiveDesc = [[Handy-Dandy Keyboard Shortcuts:

R -- Randomize (shuffles decks, flips coins)

F -- Flip Card

Alt -- View Card

Shift + Alt -- View Face-Down Card

#key over deck -- Draw # Cards
(e.g. 3 to draw 3 cards)

Q/E -- Rotate Card
(set to 90° at the top of your screen!)


Right Click -- Brings up an Interaction Menu

Tab (quick press) -- Ping Location

Tab (hold) -- Draw a Line

Enter -- Open/Close Text Chat]],
            hideHiddenAreas = true,
            showBtnStrike = false,
            showBtnTurn = false,
            useBanks = false,
            useRound = false,
            useTurns = false,
            pauseRoundTimer = false,
            pauseTurnTimer = false,
            fnCleanup = 'modeNoneCleanup',
            fnPause = 'announceGame',
            fnStart = 'modeNoneStart',
            fnTurn = 'announceGame',
            fnUnpause = 'announceGame',
            implemented = true,
        },
    }

    -- Default timer mode.
    activeModeIndex = 3
    activeTimerMode = timerModes[activeModeIndex]

    -- This information will appear in the note at the side of the screen.
    initialNotesValue = [[
---- INFO (cleared at game start) ----
If time runs out, finish turn & 2 more.
Draw if neither player can win.
]]

    local count = 0
    for i, v in ipairs(timerModes) do
        count = count+1
        if v.implemented == true then
            initialNotesValue = initialNotesValue..'\n'..v.modeDesc
        end
    end
    timerModeCount = count -- The number of entries above.

    -- This is the list of random announcements which might play on game start.
    announcementList = {
        [[Version ]]..versionNumber..[[: ]]..versionLabel..[[!]],
        [[Fight!]],
        [[It's showtime!]],
        [[Let's party!]],
        [[Nobody blink!]],
        [[It's the battle of the century!]],
        [[New horizons await!]],
        [[Who will reach the tabletop alive?]],
        [[The stage of battle is set!]],
        [[And the battle begins!]],
        [[Let's get started!]],
        [[Pull out all the stops!]],
        [[Let the madness begin!]],
        [[Let's ride!]],
        [[Everybody mind your marks!]],
        [[This is tuna with bacon!]],
        [[This is an in-joke even I don't understand!]],
        [[It's the greatest showtime!]],
        [[Believe in the announcer that believes in you!]],
        [[Fights, camera, action!]],
        [[Everybody warmed up?]],
        [[banana bread]],
        [[Time to put on a show!]],
        [[Be strong, like ox!]],
        [[Prepare for glorious battle!]],
        [[Play fast, make mistakes, lose spectacularly!]],
        [[Ready for punching?!]],
        [[Hey, let's have fun here!]],
        [[Time to wrestle like bear!]],
        [[Shall we play again on... Easy Mode?]],
        [[Toast to your health!]],
        [[Punch? Nah, I'll stick with water!]],
        [[You've got the music in you!]],
        [[Big adventures, tons of fun!]],
        [[A beautiful heart, faithful and strong!]],
        [[Sharing kindness is an easy feat!]],
        [[Magic makes it all complete!]],
        [[Attack the darkness!]],
        [[The wheel of fate is turning!]],
        [[The gorilla fate is yearning!]],
        [[Let it ride!]],
        [[You're not using enough Wild Swings!]],
        [[Believe in the heart of the cards!]],
        [[Believe in the art of the cards!]],
        [[Hone your skills!]],
        [[It's t-t-time to d-d-d-DUEL!]],
        [[It's time to duel! (Hey, my stutter's gone!)]],
        [[If it's not in your hand, it's in your deck!]],
        [[What you need is to Wild Swing more often!]],
        [[Top deck lethal!]],
        [[Truly a fight to behold!]],
        [[What a matchup!]],
        [[Let's make it spectacular!]],
        [[Time to let it all hang out!]],
        [[A new and incredible challenge begins!]],
        [[Let the battle begin!]],
        [[Get started!]],
        [[Ready! Set! Go!]],
        [[This is true love we're makin'!]],
        [[You're too slow!]],
        [[Well, exCUSE me, princess!]],
        [[There's a little bit of Sasuke in all of us!]],
        [[Too late! It's canon!]],
        [[Don't forget your special action!]],
        [=[[4444FF]@everyone @here[-]]=],
        [[The sharpest duel! Ready your fisticufflinks!]],
        [[Hi!]],
        [[Let's settle this peacefully, with violence!]],
        [[meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow]],
        [[If you want to be weaksauce, just get a name like "Welsie"]],
        [[You can do this! Be strong!]],
        [[No fear, no regrets!]],
        [[EXCEED expectations!]],
        [[Part of this balanced breakfast!]],
        [[If you like Eggseed, try BaCON!]],
        [[†††††††
---------^]],
        [[Time for a good old-fashioned brawl!]],
        [[Everyone's a brawler!]],
        [[You'll comment this one out before it goes live, right?]],
        [[Code untested can't be bested!]],
        [[You've fought the rest, now face the best!]],
        [[Reticulating splines...]],
        [[It's on!]],
        [[You must construct additional pylons!]],
        [[Let's get ready to rumble!]],
        [[Don't talk about fight club!]],
        [[Fight night!]],
        [[Make your time!]],
        [[Ready? WALLOP!]],
        [[Welcome to the jungle!]],
        [[KILL EACH OTHER, BUT IT'S GOOD]],
        [[Try to kill each other like civilized people!]],
        [[You're literally anime!]],
        [[I Have No Deck, and I Must Swing]],
        [[I Know Why the Caged Bird Wild Swings!]],
        [[Do not use while operating a car, plane, ostrich, or motorcycle!]],
        [[Trained professionals on a closed course. Do not attempt.]],
        [[Be the combo you wish to see in the world!]],
        [[Is this a brawler?]],
        [[It's a fight to the finish!]],
        [[Life is nice, but you only need one to win!]],
        [[My grandfather's deck has no pathetic cards!]],
        [[Rebel one, ACTION!]],
        [[Just gauging your interest!]],
        [[Gauge your options! Force their hand!]],
        [[Reshuffle early, before your hand is determinable!]],
        [[Did you find the secret?]],
        [[If at first you don't succeed, Wild Swing!]],
        [[Reading is for winners!]],
        [[Ditch Normals with Change Cards if your opponent sees your hand!]],
        [[Never give up! Never surrender!]],
        [[When all hope is lost, remember: your opponent might screw up!]],
        [[By Grabthar's hammer, what a savings!]],
        [[In Turbo Mode, all non-Range stats are doubled!]],
        [[In the metameta, our meta is top tier!]],
        [["Poor man's tech" (noun)
See: !tech]],
        [["Parry Exodia" (verb; also "parry Black Lotus", "parry Matsu the Butcher", etc.)
See: !parry]],
        [["Cross out" (verb)
See: !cross]],
        [[EX Dive is the surprise jazz hands of openers!]],
        [[Gen Con 2016 frankly just showed us that Alice was overpowered!]],
        [[Gen Con 2017 elevated Eva from bottom tier to "What just hit me?"]],
        [[Gen Con 2018 taught us to fear lightning in all its forms!]],
        [[PAX Unplugged 2018 left one man standing while the world burned!]],
        [[Fanime 2019 had 18 new players face off - Cammy toppled Bison for the win!]],
        [[Gen Con 2019 unleashed a bombshell!]],
        [[Matchup Madness 2020 culminated in a shocking finale!]],
        [[Jungy's Japes brought Seventh Cross and BlazBlue head-to-head!]],
        [[Only you can rescue trash tier from itself!]],
        [[Street Fighter: It's here!]],
        [[Dan is a real character!]],
        [[Dan is a joke character!]],
        [[Many character guides are available on BoardGameGeek!]],
        [["Guard crush" (noun)
An attack that deals damage in excess of an opponent's Guard, stunning them.]],
        [[EX Transform (verb; also "EX TF")
As an action, play one copy of a Transformation by discarding the other copy from hand.]],
        [["50/50" (noun)
A Strike in which the defender has no perfectly safe play.]],
        [["Mixup" (noun)
Simultaneous threat of a strong, unsafe attack and a weak, safe attack.]],
        [["Reading, Hail Mary" (noun)
A Boost with Reading that must succeed for the attacker to win the exchange.]],
        [["Reading, safe" (noun)
A Boost with Reading that names an attack that cannot hit.]],
        [["Reading, guaranteed" (noun)
A Boost with Reading that names an attack the opponent is known to have.]],
        [["Dan Swing" (noun or verb)
Critical Wild Swing (i.e., spend 1 Gauge to make your attack Critical, then set a Wild Swing).]],
        [["Checkmate" (noun or verb; also "mate")
Guaranteed victory, or (as a verb) to guarantee victory.]],
        [[Who's your main?]],
        [[Put on your sunglasses!]],
        [[Now with 500% more fireball spam!]],
        [[Try right-clicking when choosing a playmat!]],
        [[FDR OP, pls nerf]],
        [[Formerly with Tag support!]],
        [[Now without Tag support!]],
        [[Everything's balanced in Tag!]],
        [[Now supports up to 6 players! But only two timers still!]],
        [[Tag is officially dead!]],
        [[D cheats!]],
        [[Watch for flying crabs!]],
        [[Search YouTube for "Guile Versus The World"!]],
        [[I put on the shades.]],
        [[Join us on the Level 99 Online Play Discord server!]],
        [[POTUS content has been restored!]],
        [[March 2020's Matchup Madness is the largest Exceed event to date!]],
        [[Interested in custom characters? Ask around the L99 community!]],
        [[The Back Replacers let you change your card backs!]],
        [[Heaven or Hell? Let's rock!]],
        [[Season 5 is Exceed: BlazBlue!]],
        [[Guess we have to buff Hakumen!]],
        [[Guess we have to nerf Noel!]],
        [[Interested in custom characters? Some are accessible via four-character passwords!]],
        [[Many fan-made playmats have variants that add a life tracker!]],
        [[Many fan-made playmats have variants that remove the characters!]],
        [[Many fan-made playmats can be mixed and matched, so pick your favorite half!]],
        [[Playable in lag!]],
        [[No frame delay!]],
        [[To activate rollback netcode, click "Rewind Time"!]],
        [[Clippy isn't real! He can't hurt you!]],
        [[You ain't from Michigan if you've never done this!]],
        [[Season 6 is Exceed: Under Night!]],
        [[Be wary of Secret Skull Man!]],
        [[The time for despair begins.
To survive. Neck or nothing
No other choice but to defeat others.]],
        [[Recurring VOID Effect...]],
        [[Your desire. Your dignity. Stake your life on the battle.
Cross the sea of blood. Take advantage on others to get what you want.
There is no justice. Only the blood contract exists in the domain of chaos and endless darkness. The winner takes it all.
The only rule of "7days Immortalize".]],
        [[DIVIDE!]],
        [[INFERNO DIVIDER!]],
        [[kill each other, but it's good "INVERSES"]],
        [[What is a combo?]],
        [[Enable Validation Mode to have suspected duplicates alert all players!]],
        [[Season 7 is Guilty Gear -Strive-: The Board Game!]],
        [[GUN FLAME!]],
        [[RIDE THE LIGHTNING!]],
        [[GUILTY GEAR IS VERY LOUD!]],
        [[Let's Rock!]],
        [[The character you've chosen is
brimming with countless possibility.]],
        [[Your inputs breathe life into the character.]],
        [[Put on your best performance
and they will respond with victory.]],
        [[Heads always shreds!]],
        [[Tails never fails!]],
        [[Heavenmeta wins the coin toss!]],
        [[Hellmeta wins the coin toss!]],
        [[Headsven or Taihells?]],
        [[Unity format has been deprecated!]],
        -- Secret boss hints below.
        [[Some of these announcements are [b]cryptic hints[/b]!]],
        [[To enter a [00BB00]password for a secret character[-][000000], use the Any Key!]],
        [[To enter a [BB0000]password for a secret boss[-][000000], use the Boss Key]],
        [[[4470FF]Certain rare passwords[-] are entered with a unique key!]],
        [[Almost all [00BB00]pas[-][BB0000]swo[-][4470FF]rds[-] are four characters long!]],
        [["Four characters long" is a double entendre!]],
        [[Passwords never contain random characters, but always end with them!]],
        [["Vox Virium" displays a random announcement!]],
        [=[[4470FF][b]Red Horizon[/b]'s jank is also its savng grace![-]
[FFFFFF33]Satoshi, Alice, Vincent, Nehtali, Gabrek, RH]=], -- Hint: Ballot
        [=[[BB0000]Gotta rev up those [b]RPMs[/b]!
[FFFFFF33]Reese, Pooky, Minato, Sagat, BOSS[-]]=], -- Hint: Burnout Car
        [=[[00BB00]How much [b]salt[/b] could one character induce?[-]
[FFFFFF33]Satoshi, Arakune, Luciya, Taokaka, ANY[-]]=], -- Hint: Clippy
        [=[[BB0000]Vanda's herald leads [b]knights[/b] of [b]fire, water, earth,[/b] and [b]wind[/b]![-]
[FFFFFF33]Mole, Polar, Specter, Propeller, [Zeromat,] BOSS[-]]=], -- Hint: Culex
        [=[[BB0000]The [b]Boss Tier Trinity[/b] got [b]a new ride[/b]![-]
[FFFFFF33]Alice, Juno, Jemina, Minato, BOSS[-]]=], -- Hint: Danica Patrick
        [=[[BB0000]That [b]Seventh Cross antihero[/b] sure looks familiar![-]
[FFFFFF33]Zsolt, Zsolt, Zsolt, Zsolt, BOSS[-]]=], -- Hint: Dante
        [=[[00BB00]Who counts as undead? It's a [b]grey[/b] área![-]
[FFFFFF33]Gabrek, Rachel, Iaquis, Specter, ANY]]=], -- Hint: Dark Souls
        [=[[00BB00]Let's practice [b]gun[/b] safety![-]
[FFFFFF33]Galdred, Renea, Fight, Noel, ANY[-]]=], -- Hint: Doom Speedrunner
        [=[[00BB00][b]Dogs playing poker[/b] sure rings a [b]bell[/b]!
[FFFFFF33]Miska, Tournelouse, Pooky, Platinum, ANY[-]]=], -- Hint: Fortuna
        [=[[BB0000][b]Infamous low tiers[/b] team up to compound their weaknesses!
[FFFFFF33]Nehtali, Vincent, Pooky, Treasure, BOSS[-]]=], -- Hint: Giant Spearman
        [=[[00BB00]Fakey and the Taximeta really [b]nail[/b]ed it with this custom character![-]
[FFFFFF33]Nine, Arakune, Iaquis, Litchi, ANY[-]]=], -- Hint: The Knight
        [=[[00BB00]He's no [b]bad guy[/b], but he is his [b]counterpart[/b]![-]
[FFFFFF33]Heidi, Ryu, Sagat, Jin, ANY[-]]=], -- Hint: Ky Kiske
        [=[[00BB00]My [b]Windows typewriter[/b] is on its last legs![-]
[FFFFFF33]Carl Swangee, Remiliss, Lily, Fight, ANY[-]]=], -- Hint: Last Legs
        [=[[00BB00]DAWN OF THE FIRST DAY: [b]13[/b] HOURS REMAIN[-]
[FFFFFF33]Devris, Alice, Wagner, Nu-13, ANY[-]]=], -- Hint: Majora
        [=[[00BB00]There's a Number of characters in the module, but [b]one is Missing from print[/b]![-]
[FFFFFF33]Jemina, Jemina, Jemina, Jemina, BOSS[-]]=], -- Hint: MissingNo.
        [=[[BB0000]Facing overpowered Boost characters may lead to [b]Post-Testing Stress Disorder[/b]![-]
[FFFFFF33]Shovel Knight, Tinker, Seijun, Devris, BOSS[-]]=], -- Hint: Noir
        [=[[BB0000]It's ruph fighting [b]characters who can Retreat 1 and Strike[/b]![-]
[FFFFFF33]Rachel, Ulrik, Propeller, Hyde, BOSS[-]]=], -- Hint: Norin the Wary
        [=[[00BB00]These [b]huge dudes[/b] are [b]reaching out[/b] to you![-]
[FFFFFF33]Morathi, Zangief, Tager, Waldstein, ANY[-]]=], -- Hint: Potemkin
        [=[[BB0000]You must defeat [b]Shin[/b] Long to stand a chance against the mightiest and most evil boss character ever![-]
[FFFFFF11]Scharlachrot, Heihachi, Igniz, Nu-13, BOSS[-]]=], -- Hint: Rugal
        [=[[00BB00][b]the eye of time[/b] beholds [b]her reflection[/b]
[FF44FF][b]erutuf sih[/b] segduj [b]drows tneicna eht[/b][-]
[FFFFFF33]Noel, Nu-13, Jin, Hakumen, ANY[-]]=], -- Hint: Sagas
        [=[[BB0000][b]🎵The 🎵first 🎵four 🎵notes[/b] of MEGALOVANIA are really catchy![-]
[FFFFFF33]Dan, Dan, D'Janette, Arakune, BOSS[-]]=], -- Hint: Sans
        [=[[00BB00]Don't feel guilty about maining [b]red shotos[/b]![-]
[FFFFFF33]Reese, Zsolt, Ken, Ragna, ANY[-]]=], -- Hint: Sol Badguy
        [=[[4470FF]Precepts all the way down![-]
[FFFFFF33]Enkidu, Enkidu, Enkidu, Enkidu, Enkidu, Enkidu, UN[-]]=], -- Hint: Three Precept Enkidu
        [=[[BB0000][b]GRAB[/b] some air with high-damage shotos![-]
[FFFFFF33]Guile, Reese, Akuma, Beheaded, BOSS[-]]=], -- Hint: Tony Hawk
        [=[[BB0000]Trillion's a [b]Seventh Cross[/b] styled Boss Tier fighter, and her game is about [b]time marching on[/b]![-]
[FFFFFF33]Taisei, Tournelouse, Zsolt, Geoffrey[-]]=], -- Hint: Trillion
        [=[[BB0000]The S1 version of Ultimate Zangetsu is borrowing [b]Zorro's signature move[/b]![-]
[FFFFFF33]Baelkhor, Mei Lien, Zoey, Gabrek, BOSS[-]]=], -- Hint: Ultimate Zangetsu
        [=[[00BB00]Ever Feel Like Your Opponent Is Playing [b]4D[/b] Chess?[-]
[FFFFFF33]Dan, Dan, Dan, Dan, ANY[-]]=], -- Hint: Your Opponent
    }
    count = 0
    for tempval in pairs(announcementList) do count = count + 1 end
    announcementMax = count -- The number of entries above.

    -- Added for April Fool's Exceed 2025. Used for givePrizeToPlayer.
    playerPrizes = {}

    if debugFlag == true then printToAll("Benchmarking, setting button characteristics at: "..os.time()) end

    -- Setting the basic characteristics of all the buttons, which will then
    --  be adjusted on an individual basis.
    btnParams = {
        label          = 'Button Label',
        position       = {0, 0.6, 0},
        rotation       = {0, 90, 0},
        -- scale          = -- Vector,
        width          = 400,
        height         = 400,
        font_size      = 100,
        color          = {1, 1, 1},
        -- font_color     = -- Color,
    }

    -- Create Timer Mode button.
    btnTimerMode = getObjectFromGUID('787434')
    btnParams.label = activeTimerMode.modeLabel
    btnParams.tooltip = activeTimerMode.modeTooltip
    btnParams.click_function = 'click_TimerMode'
    btnParams.font_size = 75
    btnTimerMode.createButton(btnParams)
    btnTimerLabel = getObjectFromGUID('e875ed')

    -- Create Pause button.
    btnPauseTimers = getObjectFromGUID('c166f8')
    btnParams.label = 'Pause'
    btnParams.tooltip = 'Pause current timer'
    btnParams.click_function = 'click_Pause'
    btnParams.font_size = 130
    btnPauseTimers.createButton(btnParams)

    -- Create "Announcer Voice" button.
    btnAnnounce = getObjectFromGUID('cf9b5a')
    btnParams.label = 'Vox\nVirium'
    btnParams.tooltip = 'Get ready!'
    btnParams.click_function = 'click_Announce'
    btnParams.font_size = 90
    btnParams.color = {0,0,0}
    btnParams.font_color = {0.6,0.6,0.6}
    --btnAnnounce.createButton(btnParams)
    btnAnnounce.UI.setXmlTable({
      {-- Image element.
        tag = "Image",
        attributes = {
          id = btnAnnounce.getGUID(),
          height = 120,
          width = 240,
          position = "0 0 -120",
          rotation = "0 0 0",
          color = "rgba(0,0,0,1)", -- Fully transparent by default. Change this to debug element positions.
          raycastTarget = "true",
          onClick = "Global/click_Announce",
          --tooltip = [=[]=],
          --tooltipTextColor = "rgba(1,1,1,0)",
          --tooltipBorderColor = "rgba(0,0,0,1)",
          --tooltipBackgroundColor = "rgba(1,1,1,1)",
          --tooltipBackgroundImage = thisChar.assetName,
          --tooltipPosition = "Above",
          --tooltipOffset = "-45",
          --visibility = "Red|Blue|Yellow|Green|Orange|Purple",
        }, -- end attributes for Image
      }, -- end Image element.
      {-- Text element.
        tag = "Text",
        attributes = {
          text = [[Vox
Virium]],
          position = "0 0 -120",
          offsetXY = "0 0 0",
          rotation = "0 0 0",
          fontSize = "40",
          color = "White",
        }, -- end attributes for Text
      },
      {--Toggle element.
        tag = "Toggle",
        attributes = {
          id = [[SetValidationMode]],
          colors = [[rgba(1,1,1,1)|rgba(0.5,0.5,0.5,1)|rgba(1,1,1,0.6)|rgba(0.75,0.75,0.75,0.1)]],
          onValueChanged = 'Global/uiClick_SetValidationMode',
          position = "0 -4730 -180",
          offsetXY = "0 0 0",
          rotation = "0 0 180",
          scale = "3 3 3",
          visibility = [[Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black]],
          --isOn = false,
        }, -- end attributes for Toggle
      } -- end Toggle element
    })

    -- Create Reset button.
    btnResetTimers = getObjectFromGUID('8914ff')
    btnParams.label = 'Setup'
    btnParams.tooltip = [[Configure or reset timers
and create hidden areas]]
    btnParams.click_function = 'click_Reset'
    btnParams.color = {0.8, 0.8, 0.8}
    btnParams.font_color = {0,0,0}
    btnResetTimers.createButton(btnParams)

    -- Create "Start Turn" buttons.
    btnParams.tooltip = 'Start your turn manually'
    btnParams.click_function = 'click_Start'
    btnParams.font_color = colorDefaultText

    btnTurnPlr1 = getObjectFromGUID('a20d5a')
    btnParams.label = 'Start\nTurn'
    btnParams.color = textColorPlr1
    btnTurnPlr1.createButton(btnParams)

    btnTurnPlr2 = getObjectFromGUID('cb38d6')
    btnParams.label = 'Start\nTurn'
    btnParams.color = textColorPlr2
    btnTurnPlr2.createButton(btnParams)

    -- Create "Strike!" buttons.
    btnParams.tooltip = [[Pauses player timers for Strike resolution]]
    btnParams.label = [[Reveal!]]
    btnParams.click_function = 'click_Strike'
    btnParams.scale = {1,1,1}
    btnParams.width = 400
    btnParams.height = 400
    btnParams.rotation = {0, 90, 0}
    btnParams.font_size = 80
    btnParams.color = colorDefaultBG

    btnStrikePlr1 = getObjectFromGUID('0fb3b7') -- formerly 'b76a63'
    btnStrikePlr1.createButton(btnParams)

    btnStrikePlr2 = getObjectFromGUID('e967a0') -- formerly '820905'
    btnStrikePlr2.createButton(btnParams)

    -- Identify clocks.
    clkTurnTimerPlr1 = getObjectFromGUID('8cfd19')
    clkTurnTimerPlr2 = getObjectFromGUID('172892')
    clkRoundTimer = getObjectFromGUID('cc7c66')

    -- Identify life trackers.
    lifeCounters = {
      [[c1df1c]],
      [[41ab1d]],
      [[388734]],
      [[85bf68]],
      [[63cd60]],
      [[221281]],
      [[f65e3d]],
      [[2f6462]],
      [[dfb25f]],
      [[6f9030]],
    }
    lifePlr1 = getObjectFromGUID('c1df1c')
    lifePlr2 = getObjectFromGUID('41ab1d')
    lifePlr3 = getObjectFromGUID('388734')
    lifePlr4 = getObjectFromGUID('85bf68')
    lifePlr5 = getObjectFromGUID('63cd60')
    lifePlr6 = getObjectFromGUID('221281')
    lifePlr7 = getObjectFromGUID('f65e3d')
    lifePlr8 = getObjectFromGUID('2f6462')
    lifePlr9 = getObjectFromGUID('dfb25f')
    lifePlr10 = getObjectFromGUID('6f9030')

    -- Identify the "billboard" so we can remove it later.
    billboardPlr1 = getObjectFromGUID('7e0cb0')
    billboardPlr2 = getObjectFromGUID('64a1c9')

    hiddenBorders = {
      [[c9d327]], -- Text label (Plr1)
      [[12cc75]], -- Text label (Plr2)
      [[0e3474]], -- Text label (Plr3)
      [[fe234e]], -- Text label (Plr4)
      [[82ee99]], -- Text label (Plr5)
      [[1a9d2d]], -- Text label (Plr6)
      [[4d5ada]], -- Text label (Plr7 Teal)
      [[58fbf4]], -- Text label (Plr8 White)
      [[815d79]], -- Text label (Plr9 Brown)
      [[4d00c9]], -- Text label (Plr10 Pink)
    }
    hiddenAreas = {
      [[197a05]], -- Hidden area GUID (Plr1)
      [[bd8e32]], -- Hidden area GUID (PLr2)
      [[31b075]], -- Hidden area GUID (Plr3 Green)
      [[82a957]], -- Hidden area GUID (Plr4 Yellow)
      [[b4ef4d]], -- Hidden area GUID (Plr5 Purple)
      [[f55535]], -- Hidden area GUID (Plr6 Orange)
      [[f525b9]], -- Hidden area GUID (Plr7 Teal)
      [[be7761]], -- Hidden area GUID (Plr8 White)
      [[746d5c]], -- Hidden area GUID (Plr9 Brown)
      [[420aea]], -- Hidden area GUID (Plr10 Pink)
      -- [=[
      [[6c3c09]], -- Blue selection desk
      [[5e9f6e]], -- Red selection desk
      [[90de45]], -- Green selection desk
      [[8c1616]], -- Yellow selection desk
      [[7e0a75]], -- Purple selection desk
      [[628627]], -- Orange selection desk
      [[544ba5]], -- Brown selection desk
      [[ac2440]], -- Pink selection desk
      [[fef26b]], -- Teal selection desk
      [[a93880]], -- White selection desk
      --]=]
    }

    -- If we're reloading a saved game, don't reset everything.
    -- (Unless all players were still at 30 life. If this hits you, sorry!)
    local resumeFromSave = false

    for i,thisCounterGUID in ipairs(lifeCounters) do
      local thisCounter = getObjectFromGUID(thisCounterGUID)
      if thisCounter != nil then
        if thisCounter.Counter.getValue() != 30 then
          resumeFromSave = true
        end
      end
    end -- finish looking through lifeCounters

    if resumeFromSave == false then
        initializeTimers()
    elseif resumeFromSave == true then
        broadcastToAll("Warning! Resuming from save is not yet supported!",{1,1,0})
    end

    if debugFlag == true then
        btnPauseTimers.setName("btnPauseTimers")
        btnStrikePlr1.setName("btnStrikePlr1")
        btnStrikePlr2.setName("btnStrikePlr2")
        btnResetTimers.setName("btnResetTimers")
        btnTurnPlr1.setName("btnTurnPlr1")
        btnTurnPlr2.setName("btnTurnPlr2")
        --        btnEndPlr1.setName("btnEndPlr1")
        --        btnEndPlr2.setName("btnEndPlr2")
    elseif debugFlag == false then
        btnPauseTimers.setName("")
        btnStrikePlr1.setName("")
        btnStrikePlr2.setName("")
        btnResetTimers.setName("")
        btnTurnPlr1.setName("")
        btnTurnPlr2.setName("")
    end

    -- Workaround for the weird bug that keeps changing player hand zones.
    for i, playerString in pairs(actualPlayer) do
        local playerColor = _G["str"..playerString]
        local handData = Player[playerColor].getHandTransform()
        Player[playerColor].setHandTransform({
            position = {
                x = handData.position[1],
                y = 1,
                z = handData.position[3],
            },
            rotation = {
              x=0,
              y = handData.rotation[2],
              z=0
            },
            scale = {x=14, y=10, z=5},
        }, 1)
    end

    if debugFlag == true then printToAll("Benchmarking, reaching end of Global onLoad at: "..os.time()) end

    -- Let's start with timers disabled.
     click_Start(btnTurnPlr1, "Red", false)
end -- end onLoad



function initializeTimers()
    debugLog = debugLog
    -- This resets everything for first use.
    -- It's called once during onLoad, then whenever somebody hits Reset.

    debugLog{"initializeTimers", 2}
    if debugFlag == true then printToAll("Benchmarking, initializeTimers loading at: "..os.time()) end

    -- Sets players' life to starting values.
    --lifePlr1.Counter.setValue(30)
    --lifePlr2.Counter.setValue(30)

    -- Mark the hidden areas.
    for i, v in ipairs (hiddenBorders) do
        showHideBtn(getObjectFromGUID(v), "show")
    end

    -- Mark the hidden areas.
    for i, v in ipairs (hiddenAreas) do
      if getObjectFromGUID(v) != nil then
        showHideBtn(getObjectFromGUID(v), "show")
      end
    end

    -- This block runs if there's an active turn.
    -- It's skipped the first time this function is called, during onLoad.
    if currentPlayer != "Nobody" then

        debugLog{"currentPlayer != Nobody; cleaning up", 4}

        -- Resets timeoutLoser.
        timeoutLoser = "Nobody"

        -- Sets the Pause button back to normal, and sets 'isPaused' to false.
        if isPaused == true then
            if debugFlag == true then print("isPaused == true; unpausing") end
            _G[activeTimerMode.fnUnpause]()
        end

        if debugFlag == true then print("running cleanup function: "..activeTimerMode.fnCleanup) end
        _G[activeTimerMode.fnCleanup]()

        -- Identify and destroy the current turn countdown timer.
        local clock = getTurnTimer(currentPlayer)
        Timer.destroy(clock.getGUID())

        -- Destroy the round timer(s).
        Timer.destroy(clkRoundTimer.getGUID())
        Timer.destroy(clkRoundTimer.getGUID().."1")
        Timer.destroy(clkRoundTimer.getGUID().."2")
        Timer.destroy(clkRoundTimer.getGUID().."3")

        debugLog{"resetting buttons", 5}

        -- Resets the Start Turn and Strike buttons to their initial states.
        btnTurnPlr1.editButton({
            index = 0,
            click_function = 'click_Start',
            label = 'Start\nTurn',
            tooltip = 'Start your turn manually',
            color = textColorPlr1,
        })
        btnTurnPlr2.editButton({
            index = 0,
            click_function = 'click_Start',
            label = 'Start\nTurn',
            tooltip = 'Start your turn manually',
            color = textColorPlr2,
        })
        btnStrikePlr1.editButton({
            index = 0,
            label = 'Reveal!',
            tooltip = [[Pauses player timers for Strike resolution]],
        })
        btnStrikePlr1.editButton({
            index = 0,
            label = 'Reveal!',
            tooltip = [[Pauses player timers for Strike resolution]],
        })

        if debugFlag == true then
            print("revealing hidden buttons")
            print("currentPlayer: "..currentPlayer)
            print("opponent: "..opponent)
        end

        -- Show buttons that are hidden.
        --        showHideBtn(_G["btnTurn"..currentPlayer], "show")
        showHideBtn(_G["btnStrike"..opponent], "show")
        showHideBtn(btnTimerMode, "show")
        showHideBtn(btnTimerLabel, "show")
        showHideBtn(billboardPlr1, "show")
        showHideBtn(billboardPlr2, "show")

        --        showHideBtn(_G["btnEnd"..opponent], "show")

        currentPlayer = "Nobody"
        opponent = "Nobody"
    end

    if debugFlag == true then print("hiding irrelevant buttons") end

    -- Hide irrelevant buttons.
    showHideBtn(btnStrikePlr1, "hide")
    showHideBtn(btnStrikePlr2, "hide")
    --    showHideBtn(btnEndPlr1, "hide")
    --    showHideBtn(btnEndPlr2, "hide")

    -- Show Start buttons.
    showHideBtn(btnTurnPlr1, "show")
    showHideBtn(btnTurnPlr2, "show")

    -- Position Start buttons.
    btnTurnPlr1.setPosition({x = -12.6, y = -0.2, z = 10.5})
    btnTurnPlr2.setPosition({x = 12.6, y = -0.2, z = -10.5})

    -- Colorize clocks. This is because running negative turns them black.
    clkTurnTimerPlr1.setColorTint(clockColorPlr1)
    clkTurnTimerPlr2.setColorTint(clockColorPlr2)

    if debugFlag == true then print("revealing hidden clocks") end

    -- Show (and reset) or hide round timer, as appropriate.
    if activeTimerMode.useRound == true then
        showHideBtn(clkRoundTimer, "show")
        clkRoundTimer.Clock.setValue(activeTimerMode.maxRoundTime)
    elseif activeTimerMode.useRound == false then
        showHideBtn(clkRoundTimer, "hide")
    end

    -- If the round timer is supposed to be visible, make it visible.
    if activeTimerMode.useRound == true then
      clkRoundTimer.setPositionSmooth({24,1.25,0},false,true)
      clkRoundTimer.setScale({0.8,0.8,0.3})
      clkRoundTimer.setRotationSmooth({15,90,0}, false, true)
      clkRoundTimer.attachInvisibleHider(clkRoundTimer.getGUID(), false, allPlayers)
    end

    -- Show (and reset) or hide turn clocks, as appropriate.
    if activeTimerMode.useTurns == true then
        showHideBtn(clkTurnTimerPlr1, "show")
        showHideBtn(clkTurnTimerPlr2, "show")
        clkTurnTimerPlr1.Clock.setValue(activeTimerMode.playerTurnTime)
        clkTurnTimerPlr2.Clock.setValue(activeTimerMode.playerTurnTime)
    elseif activeTimerMode.useTurns == false then
        showHideBtn(clkTurnTimerPlr1, "hide")
        showHideBtn(clkTurnTimerPlr2, "hide")
    end

    -- Set the sideNote to the initial info message.
    setNotes(initialNotesValue)

    if debugFlag == true then printToAll("Benchmarking, initializeTimers concluding at: "..os.time()) end
end -- end initializeTimers



function addAnnouncement(params)
  local announcement = params.announcement
  if announcement != nil then
    -- Add a new announcement to the list.
    --debugLog{" adding announcement: "..announcement, 2}
    local newIndex = announcementMax+1
    announcementList[newIndex] = announcement
    announcementMax = announcementMax+1
  end
end



function addHidden(params)
  local addGUID = params.GUID
  hiddenObjects[addGUID] = true
end



function addUninteractable(params)
  local addGUID = params.GUID
  uninteractableObjects[addGUID] = true
end



function announceGame()
    local announcementID = math.random(1,announcementMax)
    local announcement = announcementList[announcementID]
    broadcastToAll("", colorAnnouncer)
    broadcastToAll(announcement, colorAnnouncer)
end



function click_Announce(obj, player_clicker_color, alt_click)
    announceGame()
end



function click_Pause(obj, player_clicker_color, alt_click)
    -- Pauses the current timer. 'click_Resume' resumes.
    -- Does not pause the round timer. This is intentional.
    if currentPlayer == "Nobody" then
        return
    end
    isPaused = true

    if player_clicker_color == [[Black]] then
        pauseOverride = true
    end

    local pauseFunction = _G[activeTimerMode.fnPause]
    pauseFunction()
end -- end click_Pause



function click_Reset(obj, player_clicker_color, alt_click)
    -- Resets all timers.
    -- Doesn't need to do anything if the game hasn't started.
    if currentPlayer == "Nobody" then
        return
    end
    initializeTimers()
    broadcastToAll("Timers Reset", colorNotifications)
end -- end click_Reset



function click_Resume(obj, player_clicker_color, alt_click)

    -- If there's no current game, don't do anything.
    -- Come to think of it, how did this get called?
    if currentPlayer == "Nobody" then
        return
    end

    if player_clicker_color == [[Black]] then
        pauseOverride = true
    end

    local unpauseFunction = _G[activeTimerMode.fnUnpause]
    unpauseFunction()
end -- end click_Resume



function click_Start(obj, player_clicker_color, alt_click)
    local startFunction = _G[activeTimerMode.fnStart]
    local hideHidden = activeTimerMode.hideHiddenAreas
    showHideBtn(btnTimerMode, "hide")
    showHideBtn(btnTimerLabel, "hide")
    showHideBtn(billboardPlr1, "hide")
    showHideBtn(billboardPlr2, "hide")

    -- Remove the hidden area markers.
    for i, v in ipairs (hiddenBorders) do
        showHideBtn(getObjectFromGUID(v), "hide")
    end
    if hideHidden == true then
      debugLog{"Hiding hidden areas...", 0}
      -- Hide the hidden areas.
      for i, v in ipairs (hiddenAreas) do
        if getObjectFromGUID(v) != nil then
          showHideBtn(getObjectFromGUID(v), "hide")
        end
      end
    end

    startFunction(obj)
end -- end click_Start



function click_Strike(obj, player_clicker_color, alt_click)
    -- Handles both players' Strike buttons.
    local strikeFunction = _G[activeTimerMode.fnStrike]
    strikeFunction()
end -- end click_Strike



function click_Swap(obj, player_clicker_color, alt_click)
    -- Called by the Start and End Turn buttons after the game has started.
    local turnFunction = _G[activeTimerMode.fnTurn]
    turnFunction()
end -- end click_Swap



function click_TimerMode(obj, player_clicker_color, alt_click)
    -- Rotates through the available timer modes.
    debugLog{"click_TimerMode", 5}
    debugLog{"activeModeIndex: "..activeModeIndex, 3}
    setTimerMode(activeModeIndex + 1)
end -- end click_TimerMode



function debugLog(params)
  local debugText = params[1] or "<empty debug call>"
  local debugImportance = params[2] or 0
  local debugColor = params[3] or {0,1,0}
  if debugFlag == true and debugLevel >= debugImportance then
    printToAll(debugText, debugColor)
  end
end -- end debugLog



function disclaimToColor(playerReference)
  local steamID = playerReference.steam_id

  -- Let's not repeat ourselves.
  if disclaimedPlayers[steamID] == true then return end
  disclaimedPlayers[steamID] = true

  Wait.frames(function ()
    playerReference.broadcast([[Content may not necessarily reflect the printed product.
Cards have been edited for an optimal TTS play experience.]], {1, 0.9, 0})
  end, 30)
  Wait.frames(function ()
    playerReference.broadcast([[
Reskinned character-specific Normals are the current default. Left-
or right-click on different Normal toggles to change your Normals.]], {0.4, 0.9, 0})
end, 360)
end -- end disclaimToColor



function getFlailingMode()
  return flailingMode
end -- getFlailingMode



function getGlitchMode()
  return glitchMode
end -- getGlitchMode



function getOpponent(playerNumber)
    if playerNumber == "Plr1" then
        return "Plr2"
    elseif playerNumber == "Plr2" then
        return "Plr1"
    elseif playerNumber == "Nobody" then
        return "Nobody"
    end
end -- end getOpponent



function getPlayerNumber(actualColor)
    -- Checks a color against the table that maps colors to player numbers.
    --  The script uses "Plr1" and such to generate dynamic references,
    --  so referring to players directly by color doesn't seem wise.
    return actualPlayer[actualColor]
end -- end getPlayerNumber



function getPlayerPrizes(params)
  local playerReference = params.playerReference
  local playerSteamID = params.playerSteamID

  if playerSteamID == nil then
    playerSteamID = playerReference.steam_id
  end

  if playerSteamID != nil then
    if playerPrizes[playerSteamID] == nil then
      playerPrizes[playerSteamID] = 0
    end
    return playerPrizes[playerSteamID]
  end
end -- end getPlayerPrizes



function getTurnSign()
    -- Returns +1 or -1, depending on the value currently held in turnTimerSign.
    return turnTimerSign
end -- end getTurnSign



function getTurnTimer(playerNumber)
    -- Returns an object reference to a player's turn clock.
    -- playerNumber is passed in as 'Plr1' or 'Plr2'.
    if playerNumber == "Nobody" then
        return 0
    end
    return _G["clkTurnTimer"..playerNumber]
end -- end getTurnTimer



-- Added for April Fool's Exceed 2025.
function givePrizeToPlayer(params)
  local playerReference = params.playerReference
  local multiplier = params.multiplier
  local points = params.points
  local secret = params.secret

  if multiplier == nil then multiplier = 1 end
  if points == nil then
    points = math.random(1, 3)
  end

  if playerReference != nil then

    local playerSteamID = playerReference.steam_id
    if playerPrizes[playerSteamID] == nil then
      playerPrizes[playerSteamID] = 0
    end

    if playerPrizes[playerSteamID] > 4294967294 then
      -- This is an in-joke for anyone who checks the code.
      -- If you're reading this, you'll probably get it.
      playerPrizes[playerSteamID] = -4294967294
    end

    local pointsToAdd = points * multiplier
    local oldPoints = playerPrizes[playerSteamID]
    local newPoints = oldPoints + pointsToAdd

    debugLog{"Adding "..points.." points."}

    if secret != true then
      playerReference.print("You earned some points! Current total: "..newPoints)
    end
    playerPrizes[playerSteamID] = newPoints
  end
end -- end givePrizeToPlayer



function modeBoringStart(obj)
    -- Called by the Start Turn buttons before the game has started.
    currentPlayer = "Nobody"

    -- If somehow NOT called by clicking a Start Turn button, do nothing.
    if obj.getGUID() == btnTurnPlr1.getGUID() then
        currentPlayer = "Plr1"
        opponent = "Plr2"
    elseif obj.getGUID() == btnTurnPlr2.getGUID() then
        currentPlayer = "Plr2"
        opponent = "Plr1"
    end
    if currentPlayer == "Nobody" then
        broadcastToAll("ERROR!", {1,0,0})
        printToAll("Something went wrong trying to start the game.",{1,1,1})
        return
    end

    -- Clears the info message at the side of the screen.
    setNotes(activeTimerMode.modeActiveDesc)

    -- Set the round time and start the clock.
    setRoundTime(activeTimerMode.maxRoundTime)
    clkRoundTimer.Clock.pauseStart()

    -- Hide turn buttons.
    showHideBtn(btnTurnPlr1, "hide")
    showHideBtn(btnTurnPlr2, "hide")

    -- Hide turn timers.
    showHideBtn(clkTurnTimerPlr1, "hide")
    showHideBtn(clkTurnTimerPlr2, "hide")

    -- Hide round timer.
    clkRoundTimer.setPositionSmooth({0,70,200}, false, true)
    clkRoundTimer.setScale({20,18,1})
    clkRoundTimer.setRotationSmooth({330,0,0}, false, true)
    clkRoundTimer.attachInvisibleHider(clkRoundTimer.getGUID(), true, allPlayers)

    -- Announce the beginning of the game!
    announceGame()
end -- end modeBoringStart



function modeBoringUnpause()
    -- Resumes a clock paused with click_Pause. Also recreates the timer.

    debugLog{"modeBoringUnpause", 5}

    if activeTimerMode.pauseRoundTimer == true or pauseOverride == true then
        -- Unset the isPaused flag.
        isPaused = false

        -- Recreate round timers.
        setRoundTime(clkRoundTimer.Clock.getValue())

        if clkRoundTimer.Clock.getValue() > 0 then -- If time's already up, don't resume.
            clkRoundTimer.Clock.pauseStart()
        end

        broadcastToAll("Timer Resumed",{0,1,0})

        btnPauseTimers.editButton({
            index = 0,
            label = 'Pause',
            tooltip = 'Pause current timer',
            click_function = 'click_Pause',
            font_size = 130,
        })
    end
    pauseOverride = false
end -- end modeBoringUnpause



function modeChessStart(obj)
    -- Called by the Start Turn buttons before the game has started.
    local startPlayer = "Nobody"
    local startTime = activeTimerMode.playerTurnTime

    -- If somehow NOT called by clicking a Start Turn button, do nothing.
    if obj.getGUID() == btnTurnPlr1.getGUID() then
        startPlayer = "Plr1"
    elseif obj.getGUID() == btnTurnPlr2.getGUID() then
        startPlayer = "Plr2"
    end
    if startPlayer == "Nobody" then
        broadcastToAll("ERROR!", {1,0,0})
        printToAll("Something went wrong trying to start the game.",{1,1,1})
        return
    end

    -- Clears the info message at the side of the screen.
    setNotes(activeTimerMode.modeActiveDesc)

    -- Edits the Start buttons to pass turn instead of starting the game.
    btnTurnPlr1.editButton({index = 0, click_function = 'click_Swap'})
    btnTurnPlr2.editButton({index = 0, click_function = 'click_Swap'})

    -- Moves the Start and End Turn buttons closer to the center of the board.
    btnTurnPlr1.setPosition({x = -5.5, y = -0.2, z = 4})
    btnTurnPlr2.setPosition({x = 5.5, y = -0.2, z = -4})

    -- Set the round time and start the clock.
    setRoundTime(activeTimerMode.maxRoundTime)
    clkRoundTimer.Clock.pauseStart()

    -- Set both player clocks to their total time.
    clkTurnTimerPlr1.Clock.setValue(startTime)
    clkTurnTimerPlr2.Clock.setValue(startTime)

    -- Announce the beginning of the game!
    announceGame()
    modeChessTurnStart(startPlayer)
end -- end modeChessStart



function modeChessSwap()
    -- Called by the Start and End Turn buttons after the game has started.
    if currentPlayer != "Nobody" then
        modeChessTurnEnd(currentPlayer)
        modeChessTurnStart(opponent)
    end
end -- end modeChessSwap



function modeChessTimeout()
    -- Announces when a player clock runs out.
    -- Sets the timeoutLoser if mercyTime is exceeded.
    -- (timeoutLoser is the player who wins by default if round time expires.)
    -- Immediately ends the round if a timeoutLoser is declared.
    local oppClock = getTurnTimer(opponent)
    local maxGap = activeTimerMode.mercyTime

    if oppClock.Clock.getValue() <= maxGap then
        broadcastToAll(_G["str"..currentPlayer].." Time Expired!",_G["textColor"..currentPlayer])
        broadcastToAll("No timeout penalty incurred! Finish the game before the round ends!",{1,1,1})
    elseif oppClock.Clock.getValue() > maxGap then
        broadcastToAll(_G["str"..currentPlayer].." Time Expired!",{0,1,1})
        broadcastToAll("Timeout penalty incurred!\n".._G["str"..currentPlayer].." must win before the game ends, or suffer a loss by timeout!",{1,1,0})
        timeoutLoser = currentPlayer
    end
end -- end modeChessTimeout



function modeChessTimeoutAbrupt()
  -- Announces when a player clock runs out.
  -- Sets the timeoutLoser if mercyTime is exceeded.
  -- Immediately ends the round if a timeoutLoser is declared.
  local oppClock = getTurnTimer(opponent)
  local maxGap = activeTimerMode.mercyTime
  local lifeWinner = [[Nobody]]
  local winnerColor = {1,1,1}

  if oppClock.Clock.getValue() <= maxGap then
      broadcastToAll(_G["str"..currentPlayer].." Time Expired!",_G["textColor"..currentPlayer])
      if _G["life"..currentPlayer].getValue() > _G["life"..opponent].getValue() then
          lifeWinner = _G["str"..currentPlayer]
          winnerColor = _G["textColor"..currentPlayer]
      elseif _G["life"..currentPlayer].getValue() < _G["life"..opponent].getValue() then
          lifeWinner = _G["str"..opponent]
          winnerColor = _G["textColor"..opponent]
      end
      if lifeWinner == [[Nobody]] then
          broadcastToAll("The game is a draw! Both players may change characters or not as they see fit!",{1,1,1})
      else
          broadcastToAll(lifeWinner.." wins by life and may not change characters!",winnerColor)
      end
  elseif oppClock.Clock.getValue() > maxGap then
      broadcastToAll(_G["str"..currentPlayer].." Time Expired!",_G["textColor"..currentPlayer])
      timeoutLoser = currentPlayer

      local roundClockValue = clkRoundTimer.Clock.getValue()
      clkRoundTimer.Clock.setValue(roundClockValue) -- Pauses even if already paused.

      -- Destroy the round timer(s).
      Timer.destroy(clkRoundTimer.getGUID())
      Timer.destroy(clkRoundTimer.getGUID().."1")
      Timer.destroy(clkRoundTimer.getGUID().."2")
      Timer.destroy(clkRoundTimer.getGUID().."3")
      roundTimeout()
  end
end -- end modeChessTimeoutAbrupt



function modeChessTurnEnd(oldPlayer)
    -- Does all the things necessary to handle the end of a player's turn.
    -- Does not do the things necessary to handle the start of the next turn.
    local clock = getTurnTimer(oldPlayer)
    local clockValue = clock.Clock.getValue()
    local startButton = _G["btnTurn"..oldPlayer]

    if isPaused == true then
        modeChessUnpause()
    end

    -- Move the Start button closer to the middle of the mat.
    local oldX = startButton.getPosition()[1]
    local oldY = startButton.getPosition()[2]
    local oldZ = startButton.getPosition()[3]
    local newZ = (oldZ / 1.8)
    startButton.setPosition({x = oldX, y = oldY, z = newZ})

    -- There's no turn countdown timer if they're already out of time.
    if clockValue > 0 then
        -- Destroy the turn end countdown timer.
        Timer.destroy(clock.getGUID())
    end

    debugLog{"modeChessTurnEnd", 5}
    debugLog{"clock value: "..clockValue, 3}
    debugLog{"oldPlayer: "..oldPlayer, 4}
    clock.Clock.setValue(clockValue) -- Pauses it regardless of its prior state.
end -- end modeChessTurnEnd



function modeChessTurnStart(newPlayer)
    -- Does all the things necessary to handle the start of a player's turn.
    -- Does not do the things necessary to handle the end of the previous turn.
    local clock = getTurnTimer(newPlayer)
    local clockValue = clock.Clock.getValue()
    local endButton = _G["btnTurn"..newPlayer]

    -- Move the End button farther from the middle of the mat.
    local oldX = endButton.getPosition()[1]
    local oldY = endButton.getPosition()[2]
    local oldZ = endButton.getPosition()[3]
    local newZ = (oldZ * 1.8)
    endButton.setPosition({x = oldX, y = oldY, z = newZ})

    debugLog{"clock: "..clockValue, 5}

    -- If the clock is 0, they're already out of time, so we don't resume.
    if clockValue > 0 then
        clock.Clock.setValue(clockValue) -- Set it to itself, which pauses it.
        clock.Clock.pauseStart() -- Start the turn timer.
        Timer.create({
            identifier = clock.getGUID(),
            delay = clockValue,
            repetitions = 1,
            function_name = activeTimerMode.fnTimeout,
        })
    end

    debugLog{"modeChessTurnStart: setting Current Player", 0}

    setCurrent(newPlayer) -- Set 'currentPlayer' and 'opponent'.
    broadcastToAll(_G["str"..currentPlayer].."'s Turn Begins!",_G["textColor"..currentPlayer])
end -- end modeChessTurnStart



function modeChessUnpause()
    -- Resumes a clock paused with click_Pause. Also recreates the timer.
    local clock = getTurnTimer(currentPlayer)
    local clockValue = clock.Clock.getValue()
    clock.Clock.setValue(clockValue) -- This ensures the clock is paused.
    isPaused = false

    broadcastToAll("Timer Resumed",{0,1,0})

    -- If they're already out of time, don't create a timer.
    if clock.Clock.getValue() > 0 then
        Timer.create({
            identifier = clock.getGUID(),
            delay = clock.Clock.getValue(),
            repetitions = 1,
            function_name = activeTimerMode.fnTimeout,
        })
        clock.Clock.pauseStart()
    end
    btnPauseTimers.editButton({
        index = 0,
        label = 'Pause',
        tooltip = 'Pause current timer',
        click_function = 'click_Pause',
        font_size = 130,
    })
end -- end modeChessUnpause



function modeNoneStart(obj)
    -- Called by the Start Turn buttons before the game has started.
    currentPlayer = "Nobody"

    -- If somehow NOT called by clicking a Start Turn button, do nothing.
    if obj.getGUID() == btnTurnPlr1.getGUID() then
        currentPlayer = "Plr1"
        opponent = "Plr2"
    elseif obj.getGUID() == btnTurnPlr2.getGUID() then
        currentPlayer = "Plr2"
        opponent = "Plr1"
    end
    if currentPlayer == "Nobody" then
        broadcastToAll("ERROR!", {1,0,0})
        printToAll("Something went wrong trying to start the timers.",{1,1,1})
        return
    end

    -- Clears the info message at the side of the screen.
    setNotes(activeTimerMode.modeActiveDesc)

    -- Hide round timer and pause button.
    showHideBtn(clkRoundTimer, "hide")
    showHideBtn(btnPauseTimers, "hide")

    -- Hide turn buttons.
    showHideBtn(btnTurnPlr1, "hide")
    showHideBtn(btnTurnPlr2, "hide")

    -- Hide turn timers.
    showHideBtn(clkTurnTimerPlr1, "hide")
    showHideBtn(clkTurnTimerPlr2, "hide")

    -- Announce the beginning of the game!
    announceGame()
end -- end modeNoneStart



function modeNoneCleanup()
    -- Cleans up the No Timers ("No Items") mode.

    -- Show round timer and pause button.
    showHideBtn(clkRoundTimer, "show")
    showHideBtn(btnPauseTimers, "show")
end -- end modeNoneCleanup



function noCleanup()
    -- Performs the bare minimum of cleanup steps.
    -- Used for the "Final Destination" mode.

    -- Destroy timer on current clock.
    Timer.destroy(getTurnTimer(currentPlayer).getGUID())

    -- Reset clocks. This automatically pauses any running clocks.
    clkTurnTimerPlr1.Clock.setValue(activeTimerMode.playerTurnTime)
    clkTurnTimerPlr2.Clock.setValue(activeTimerMode.playerTurnTime)

    -- Set the round time, which also pauses the round clock.
    setRoundTime(activeTimerMode.maxRoundTime)

    -- If the round timer is supposed to be visible, make it visible.
    if activeTimerMode.useRound == true then
      clkRoundTimer.setPositionSmooth({24,1.25,0},false,true)
      clkRoundTimer.setScale({0.8,0.8,0.3})
      clkRoundTimer.setRotationSmooth({15,90,0}, false, true)
      clkRoundTimer.attachInvisibleHider(clkRoundTimer.getGUID(), false, allPlayers)
    end
end -- end noCleanup



function onChat(message, player)
  message = string.lower(message)
  if message == "!disclaim" then
    if disclaimedPlayers[player.steam_ID] != nil then
      disclaimedPlayers[player.steam_ID] = nil
    end
    disclaimToColor(player)
  elseif message == "Vox Virium" then
    announceGame()
  elseif message == "!glitch" or message == "!glitches" or message == "!bugs" or message == "!glitchMode" then
    if glitchMode == true then player.broadcast("glitchMode: enabled")
    else player.broadcast("glitchMode: disabled")
    end
  elseif string.match(message, '^!') then
    local memeList = {}
    memeList["!alice"] = [[† Die, you monster! †]]
    memeList["!baelkhor"] = [[† Baelkhor is a sealing fan! †]]
    memeList["!eva"] = [[† Normals are the key to victory! †]]
    memeList["!gabrek"] = [[† Put on your dancing shoes! †]]
    memeList["!heidi"] = [[† Boost your resolve with boundless vigor! †]]
    memeList["!kaden"] = [[† Ring any bells? †]]
    memeList["!lily"] = [[† It's the Magic Bullet! †]]
    memeList["!meilien"] = [[† Quit dragon your feet! †]]
    memeList["!mei-lien"] = [[D: Mei Lien was rumored to be the best legal fighter after Alice and Juno were banned, before RH left tournament play.]]
    memeList["!mei lien"] = [[D: Mei Lien is my 3rd favorite RH character, but my friend mained her, so I didn't spend much time learning her.]]
    memeList["!miska"] = [[† Optimal Range is several towns away! †]]
    memeList["!morathi"] = [[† GROUND NOT WORK NO MORE! WRATHY HIT YOU WITH SKY! †]]
    memeList["!morewrathy"] = [[D: I made a Wild Swinger for BattleCON called "More Wrathy" as an homage to RH's Morathi.]]
    memeList["!more wrathy"] = [[D: "More Wrathy" attacked randomly, but he managed his randomness, which made him very difficult. Thus, a design failure.]]
    memeList["!autorathi"] = [[D: It wasn't always easy to find opponents. I made an automated Morathi so I could play Exceed by myself.]]
    memeList["!autowrathy"] = [[D: You can find Autowrathy by searching "Autowrathy" on BoardGameGeek. He's based on a Skype-era meme!]]
    memeList["!nehtali"] = [[† Exceeding is not for everyone. Consult your doctor before use. †]]
    memeList["!reese"] = [[† Press the Advantage! †]]
    memeList["!satoshi"] = [[† Did you hear about the ninja comedian? No? It must've slipped past you. †]]
    memeList["!ulrik"] = [[† Bring the thunder! †]]
    memeList["!vincent"] = [[† Blatant cheating may be your only hope! †]]
    memeList["!ballotfixing"] = [[D: Vincent's art features Ulrik's brother; Ballot Fixing spawned a running gag that the brother's name must be "Ballot".]]
    memeList["!zoey"] = [[† It's all coming back to you now! †]]
    -- Promo fighters starting here.
    memeList["!carl"] = [[† BEEP BOOP †]]
    memeList["!carlswangee"] = [[D: I'm terrified of this robot! Want to know why? Play my main, Emogine, against him...]]
    memeList["!devris"] = [[† Watch the world burn! †]]
    memeList["!emogine"] = [[† You're the best, hands down! †]]
    memeList["!hecatoncheir"] = [[D: In the Discord, we sometimes contrast players by referring to them as "Emogines" or "Hecatoncheirs".]]
    memeList["!jemina"] = [[† Jem[ina] is truly outrageous! †]]
    memeList["!faultlessfocus"] = [[D: Perfect Read is probably the best Boost ever made. At least it has a cost, unlike Alice's Boosts.]]
    memeList["!highdive"] = [[D: High Dive might be the strongest Ultra ever made. Remember her Exceed Mode.]]
    memeList["!interceptspike"] = [[D: Jemina's entire kit was leaked publicly on the official Discord in May 2017.]]
    memeList["!jiujitsugrasp"] = [[D: Jiujitsu Grasp might be the strongest Special ever made. Remember her Exceed Mode.]]
    memeList["!reversedoublecross"] = [[D: What if we made a strictly better version of Cross, one of the safest cards around?]]
    memeList["!sweepthecompetition"] = [[D: Behold the third member of the Boss Tier trinity: Alice, Juno, and Jemina! She was never officially released.]]
    memeList["!tackleassault"] = [[D: According to Brad, Tackle Assault's Hit effect was supposed to be an After effect, for some reason.]]
    memeList["!juno"] = [[† Never miss a beat! †]]
    memeList["!junolive"] = [[D: This is my least favorite card in all of Exceed. I can't stand truly random effects like this.]]
    memeList["!pooky"] = [[† Be vewy quiet, wabbit's hunting you! †]]
    memeList["!shovelknight"] = [[† I'll pay you back in spades! †]]
    memeList["!skullman"] = [[† Who's your friend who likes to play? †]]
    memeList["!superskullman33"] = [[D: SSM33 is one of my two mains from RH. Burning Justice might be the strongest Boost in the game!]]
    memeList["!sydneyandserena"] = [[D: In early testing, Sydney & Serena were MONSTROUSLY strong. They ate heavy nerfs; some say they never recovered.]]
    memeList["!sydney"] = [[† So hard to find good help these days... †]]
    memeList["!serena"] = [[† It's suppertime! †]]
    memeList["!s&s"] = [[D: As of SK, we have two fighters named "S&S", which has caused some confusion...]]
    -- Season 2 fighters starting here.
    memeList["!celinka"] = [[† In the name of the moon! †]]
    memeList["!gaki"] = [[D: Celinka got some precision nerfs when J-2S0 and I theorycrafted some crazy openers. She's still super strong!]]
    memeList["!djanette"] = [[† What a horrible night to have a curse... †]]
    memeList["!d'janette"] = [[D: Early versions of D'Janette inscribed ritual circles on the board which gave her massive late-game stats.]]
    memeList["!devilsown"] = [[D: I latched onto D'Janette and Galdred in playtesting, but D'janette got reworked later.]]
    memeList["!devil'sown"] = [[D: D'Janette has consistent draw and the best recursion in the game, but she lacks damage until late-game.]]
    memeList["!eugenia"] = [[† 'Twas brillig, and the slithy toves / Did gyre and gimble in the wabe:
All mimsy were the borogoves, / And the mome raths outgrabe. †]]
    memeList["!cheshirecat"] = [[D: In playtesting, the "Eugenia problem" is when a character goes untested because nobody wants to fight them.]]
    memeList["!galdred"] = [[† WILL! IT! BLEND!? †]]
    memeList["!beastwithin"] = [[D: Galdred is a contentious figure. He's very strong, but inconsistent. So is he weak, or is he strong...?]]
    memeList["!exodia"] = [[D: Galdred, Minato, and Tinker are "exodia" characters: by meeting difficult conditions, they unlock an unbeatable endgame.]]
    memeList["!geoffrey"] = [[† Break your weapons against me! †]]
    memeList["!facelessjudge"] = [[D: Geoff and Seijun can upset the normal flow of Exceed by making a decision during the opponent's turn.]]
    memeList["!iaquis"] = [[† FIGHT ME! †]]
    memeList["!dragonslayer"] = [[D: Iaquis + Zsolt was an infamously broken Tag Team. Use Dragon-Slayer's ability to discard Wild Hunt...]]
    memeList["!dragon-slayer"] = [[D: The Dragon-Slayer has an incredibly ability! But Iaquis does so much damage, I seldom get to use it...]]
    memeList["!luciya"] = [[† You can't outrun the lightning! †]]
    memeList["!thunderbird"] = [[D: Luciya's playstyle is remarkably flexible. "Answer Luciya" uses Thunderbird for the reload, not the payout!]]
    memeList["!minato"] = [[† HONK HONK! VROOOOM! †]]
    memeList["!oboroguruma"] = [[D: Oboroguruma probably looks like "big damage", but it can accelerate Minato's recursion engine by a full turn!]]
    memeList["!remiliss"] = [[† What a bombshell! †]]
    memeList["!yellowdeath"] = [[D: Remi's Exceed Mode is flashy, but inefficient. You need to set it up to make it worthwhile.]]
    memeList["!renea"] = [[† The truth is out there! †]]
    memeList["!spook"] = [[D: Cammy, Luciya, and Renea are what we call "ninjas": they have subpar damage, but potent defensive or evasive abilities.]]
    memeList["!seijun"] = [[† By May? Nah, I'd say June. †]]
    memeList["!kyubinokitsune"] = [[D: Enchantress, Bison, and Seijun are "boss" characters: limitless resources, but action- or damage-inefficient.]]
    memeList["!syrus"] = [[† You are curiously attractive for a fish-man! †]]
    memeList["!lordofthedeep"] = [[D: Syrus' TFs and Exceed Mode provide excellent "action economy", meaning he can do many things with few actions.]]
    memeList["!taisei"] = [[† Quit while you're ahead! †]]
    memeList["!dullahan"] = [[D: Taisei is deceptively resilient. It's tempting to play cautiously, but he performs best when he's going all-out!]]
    memeList["!tournelouse"] = [[† so aggression. much fragile. wow †]]
    memeList["!bargeist"] = [[D: Tournelouse isn't an exodia character. His wincon isn't difficult; it just takes a while.]]
    memeList["!umina"] = [[† Opening minds with minimal spatter! †]]
    memeList["!dreamerawakened"] = [[D: Umina is probably the most difficult, technical character in the game.]]
    memeList["!dreamer"] = [[D: Umina is notorious for having antisynergistic TFs: "The Sleeper Awakes" effectively disables "Spiraling Descent".]]
    memeList["!zsolt"] = [[† Now with 200% more turn per turn! †]]
    memeList["!hunterofmen"] = [[D: We could've templated Zsolt's Exceed Mode better. We just didn't have enough fresh eyes at the time to realize it.]]
    -- Season 3 fighters starting here.
    memeList["!akuma"] = [[† DIE THREE OR FOUR DEATHS, AT MINIMUM! †]]
    memeList["!viper"] = [[† The best-known and most-loved Street Fighter character since Rolento! †]]
    memeList["!cviper"] = [[D: I regularly argue with my friend about whether C. Viper is bad. He says she is, but he plays her really well!]]
    memeList["!c.viper"] = [[D: Viper is straightforward, but fascinatingly difficult. Breakneck aggression is optimal, but hard to manage!]]
    memeList["!cammy"] = [[† What a doll! †]]
    memeList["!chun-li"] = [[† You killed my father. Prepare to die. †]]
    memeList["!chunli"] = [[D: Chun-Li's Exceed Mode is among the strongest in the game. Running away from her is usually a mistake.]]
    memeList["!dan"] = [[† He packs a meme punch! †]]
    memeList["!guile"] = [[† Goes with everything! †]]
    memeList["!bighandguile"] = [[D: Soon after release, an unintended line of play was discovered. Hand size isn't checked after Strikes, so...]]
    memeList["!ken"] = [[† Show Ryu, Ken! †]]
    memeList["!bison"] = [[† For you, the day Bison graced your village was the most important day of your life. But for me, it was Tuesday. †]]
    memeList["!mbison"] = [[D: I can't shake the feeling that Bison's weak, but maybe it's just that he subtly encourages suboptimal play?]]
    memeList["!m.bison"] = [[D: When I play Bison, I usually play "Gin Rummy Bison". The goal: End the game with 15 different cards in your Gauge!]]
    memeList["!dictator"] = [[D: Be careful not to leave many high-value cards in your Gauge when you reshuffle.]]
    memeList["!ryu"] = [[† Sure, Ryu can! †]]
    memeList["!sagat"] = [[† America's Funniest Home Fighting Games! †]]
    memeList["!tiger"] = [[D: Rumor has it that available art dictated Sagat's playstyle even more than his original design goals.]]
    memeList["!tigershot"] = [[D: Sagat is said to "play less Exceed" than most of SF because he plays Exceed more like a card game than a fighting game.]]
    memeList["!lowtigershot"] = [[D: Playing Cross against Sagat is probably a mistake. He's the only fighter who favors Range 8!]]
    memeList["!vega"] = [[† Also known as Dictator! †]]
    memeList["!claw"] = [[D: Vega's attacks aren't very reliable, but he has excellent mobility and a LOT of damage.]]
    memeList["!zangief"] = [[† Zangief? He'zangrief! †]]
    -- Season 4 fighters starting here.
    memeList["!enchantress"] = [[† ...and she does evil dances! †]]
    memeList["!kingknight"] = [[† He's the ace of "paid"s! †]]
    memeList["!king"] = [[D: Man, I'm comically terrible at playing King Knight. I have trouble investing resources if I'm not guaranteed a payout.]]
    memeList["!moleknight"] = [[† digdigdigdigdigdigdig burrowburrowburrowburrowburrowburrowburrow †]]
    memeList["!mole"] = [[D: Mole Knight breaks one of Exceed's "fundamental promises": when he Strikes, he's "lying" about his current Range!]]
    memeList["!burrow"] = [[D: Mole Knight took a lot of work to develop, but it paid off!]]
    memeList["!plagueknight"] = [[† Can you explode and then explode again? †]]
    memeList["!plague"] = [[D: Plague Knight is explosively fast, mobile, OR powerful, but he struggles to be any two at once.]]
    memeList["!polarknight"] = [[† Ice to meet you! †]]
    memeList["!polar"] = [[D: You should place Ice Spikes beneath the opponent, two spaces behind them, or at Range 1 from yourself, in that order.]]
    memeList["!propellerknight"] = [[† I'm a huge fan! †]]
    memeList["!propeller"] = [[D: Propeller Knight's "Fly Up" Boost was an instant meme. SK's mobility is the highest of any season thus far.]]
    memeList["!shovelknightandshieldknight"] = [[† Hey, I thought Tag was deprecated! †]]
    memeList["!shovelandshield"] = [[D: Bluellama1 and myself, among other testers, had a pretty significant influence on SK2's final kit shape.]]
    memeList["!exsk"] = [[D: The variations on this one are "shovelandshield", "shieldknight", "exsk", "sk2", and "shovelknightandshieldknight".]]
    memeList["!sk2"] = [[D: Did you notice that SK2 is a shoto? They have a tatsu, a fireball, and a DP!]]
    memeList["!shieldknight"] = [[D: Shield Knight exemplifies a concern the testers had right up until release: does the set have too much text?]]
    memeList["!specterknight"] = [[† You don't stand a ghost of a chance! †]]
    memeList["!spectreknight"] = [[D: No, no, the other spelling.]]
    memeList["!spectrenight"] = [[D: Now you're just trolling.]]
    memeList["!specter"] = [[D: Hidden sealed cards necessitated a revision to the original rule that sealed cards were always publicly known.]]
    memeList["!spectre"] = [[D: Dread Talon, Dread Reaper, and Barrier Lantern were all insanely overpowered in early testing. RIP.]]
    memeList["!tinkerknight"] = [[† Exceeding is overrated! †]]
    memeList["!tinker"] = [[D: I delight in ignoring conventional lines of play. Nobody exemplifies that better than No Exceed Tinker!]]
    memeList["!treasureknight"] = [[† Greed is good. †]]
    memeList["!treasure"] = [[D: I was concerned Treasure Knight ended up underpowered, but now I just think he's kinda hard to play.]]
    memeList["!beheaded"] = [[† Nothing personnel, kid †]]
    memeList["!fight"] = [[† I got that, but what's the name of the game he's from? †]]
    memeList["!arnf"] = [[† SHOOT AT BLOCKS TO UNCOVER SECRETS †]]
    memeList["!SHOOT AT BLOCKS"] = [[† You got up dog. Up dog. What is it? †]]
    memeList["!SHOOTATBLOCKS"] = [[��� A blessing of violence upon you, Fight †]]
    memeList["!arobotnamedfight"] = [[D: Some wanted Fight Smith to be called "A Robot Named Fight", so he'd be a robot named "A Robot Named Fight".]]
    -- Season 5 fighters starting here.
    memeList["!arakune"] = [[† Something bugs me about this one... †]]
    memeList["!lottecarmine"] = [[D: I considered printing a comma-separated range, like "Range 3,5,7". It ended up working better without.]]
    memeList["!bang"] = [[† Quicker than the wind and as still as the forest! Hotter than flames and MORE MAGNIFICENT THAN A MOUNTAIN! †]]
    memeList["!bangshishigami"] = [[D: Bang's kit changed from game to game, so I based his Exceed design mostly on his personality.]]
    memeList["!carlclover"] = [[† Help me, sis! †]]
    memeList["!nirvana"] = [[D: An early version of Carl Clover gave Nirvana her own health bar. Man, was THAT a bad idea...]]
    memeList["!ada"] = [[D: Most "puppet characters" are based on a ranged/melee dichotomy, but Carl and Nirvana are based on the rushdown/grappler split.]]
    memeList["!hakumen"] = [[† I am the white void. I am the cold steel. I am the just sword.
With blade in hand shall I reap the sins of this world and cleanse it in the fires of destruction.
I am Hakumen. The end has come. †]]
    memeList["!whitevoid"] = [[D: Hakumen's Specials are pretty weird. He has a slow mid-speed, a fast slow, a slow fast, and a card that's both fast AND slow.]]
    memeList["!coldsteel"] = [[D: In Centralfiction, Akumetsu is arguably the worst Astral in the game. In Exceed, on the other hand...]]
    memeList["!justsword"] = [[D: In playtesting, "so we buffed Hakumen" became a running joke, e.g.: "Noel was testing a little weak, so we buffed Hakumen."]]
    memeList["!akumetsu"] = [[D: Akumetsu is probably the strongest Ultra in Exceed. The very first version we ever tested had 20 Power.]]
    memeList["!hazama"] = [[† Having fun yet? †]]
    memeList["!ouroboros"] = [[D: Having Fun Yet? went through numerous versions. The final version is probably the strongest, but also the fairest.]]
    memeList["!jin"] = [[† Chill, dude. †]]
    memeList["!jinkisaragi"] = [[D: Jin was originally supposed to favor Range 1, but I accidentally made him favor Range 2. Everything else worked, so we kept it.]]
    memeList["!kokonoe"] = [[† She's a big fan of the Boost on Dive! †]]
    memeList["!kokonoemercury"] = [[D: The first version of Kokonoe was so insane we nicknamed her "Brokonoe". Apparently, the same thing happened in Centralfiction!]]
    memeList["!litchi"] = [[† Stick around! †]]
    memeList["!litchifayeling"] = [[D: For lore reasons, Lao Jiu's in-game effect references one of Arakune's mechanics...]]
    memeList["!nine"] = [[† Complexity rating: Hold on to your hat. †]]
    memeList["!ninethephantom"] = [[D: I checked, and yes, we are allowed to make a character with this many cards. (But only just barely.)]]
    memeList["!noel"] = [[† et the batte begin! †]]
    memeList["!noelvermillion"] = [[D: Hailed by testers as a "new Zsolt", I always thought of her as more of a "new Morathi".]]
    memeList["!nu"] = [[† Here comes a ν challenger! †]]
    memeList["!nu-13"] = [[D: Nu's design was always pretty stable. She got a wave of huge buffs, then a wave of moderate nerfs, then she was basically done.]]
    memeList["!platinum"] = [[† Never Sena Luna tick like this before! †]]
    memeList["!platinumthetrinity"] = [[D: In every season, there's at least one character I just can't seem to play. In S5, that's Platinum.]]
    memeList["!luna"] = [[D: Dramatic Sammy is one of the least safe and most punishing "command grab" Specials in Exceed.]]
    memeList["!sena"] = [[D: Platinum's ability required a lot of text, but it's actually pretty simple.]]
    memeList["!rachel"] = [[† She'll blow you away! †]]
    memeList["!rachelalucard"] = [[D: Rachel probably has the highest "skill ceiling" in S5, meaning she'll be the hardest (but most rewarding) to master.]]
    memeList["!nago"] = [[D: Cat chair!]]
    memeList["!gii"] = [[D: Rachel underwent a late-stage redesign that made her significantly more complex. The jury's out on how it affected her power level.]]
    memeList["!ragna"] = [[† 623C †]]
    memeList["!ragnathebloodedge"] = [[D: Inferno Divider pushes the limits of how good we can ever make a Special, even a Force Special.]]
    memeList["!tager"] = [[† He's very attractive! †]]
    memeList["!irontager"] = [[D: Tager and Kokonoe are my two favorite BlazBlue characters!]]
    memeList["!taokaka"] = [[† Squigly justice tackle! †]]
    memeList["!tao"] = [[D: Earlier versions of Tao were accidentally strong, defensive control characters. Whoops! That took some fixing.]]
    -- Season 6 fighters starting here.
    memeList["!byakuya"] = [[† He does whatever a spider can! †]]
    memeList["!carmine"] = [[��� Like if you went to hell, and it was full of blood, and that blood was on fire, and
it was raining blood, then maybe that would be enough blood! Eh... but probably not. †]]
    memeList["!chaos"] = [[† Why do all the Final Fantasy fans want him dead? †]]
    memeList["!enkidu"] = [[† Do you even lift, bro? †]]
    memeList["!gordeau"] = [[† Vladimir and Estragon can stop waiting! †]]
    memeList["!hilda"] = [[† If she doesn't scare you / No evil thing will
To see her is to / Take a sudden chill †]]
    memeList["!hyde"] = [[† you can run but you can't Hyde †]]
    memeList["!linne"] = [[† this is where I draw the Linne †]]
    memeList["!londrekia"] = [[† Laundry car! †]]
    memeList["!merkava"] = [[† ~∽~∽~∽~ ●Δ● ∽~∽~∽~∽ †]]
    memeList["!mika"] = [[† \  >◡<  / †]]
    memeList["!nanase"] = [[† "If you're a man, take responsibility!" †]]
    memeList["!orie"] = [[† Y, IOU or EA †]]
    memeList["!phonon"] = [[† Whip it good! †]]
    memeList["!seth"] = [[† Make sure to follow up your Wyrd Dodges with truly Compelling Strikes! †]]
    memeList["!vatista"] = [[† Kurukuru~ †]]
    memeList["!wagner"] = [[† She's kreisy! †]]
    memeList["!waldstein"] = [[† Maximize Power! †]]
    memeList["!yuzuriha"] = [[† Featuring Yuzuriha from SkullGirls! †]]
    -- Season 7 fighters starting here.
    memeList["!anji"] = [[† His graceful steps evade all attacks as he strikes! †]]
    memeList["!anjimito"] = [[† Spin to win! †]]
    memeList["!axl"] = [[† Striking from afar, you can't touch him! †]]
    memeList["!axel"] = [[† YES!! But no. †]]
    memeList["!axle"] = [[† No "e". †]]
    memeList["!axllow"] = [[† ZA WARUDO! †]]
    memeList["!baiken"] = [[† Wielding her opponent's strength as her own! †]]
    memeList["!bkn"] = [[† WHAT THE HECK IS THIS HIIRAGI †]]
    memeList["!chipp"] = [[† Overwhelming supersonic assault! †]]
    memeList["!chippzanuff"] = [[† SHAMPOO! †]]
    memeList["!chp"] = [[† DAIJOUBU! †]]
    memeList["!faust"] = [[† Deceptive! Enigmatic! Incomprehensible! †]]
    memeList["!fau"] = [[† One thousand years of death! †]]
    memeList["!giovanna"] = [[† Max out on offensive rushdown! †]]
    memeList["!gio"] = [[† much rushdown. so adore. wow †]]
    memeList["!goldlewis"] = [[† Unparalleled brute strength! †]]
    memeList["!gld"] = [[† In this Behemoth Typhoon... †]]
    memeList["!goldlewisdickinson"] = [[† This is a tasty burger! †]]
    memeList["!golddicklewisson"] = [[†  †]]
    memeList["!happychaos"] = [[† Restorer of humanity! †]]
    memeList["!happy"] = [[† :gun: †]]
    memeList["!cos"] = [[†  †]]
    memeList["!ino"] = [[† Her offense with her hover dash is overbearing! †]]
    memeList["!i-no"] = [[† She's got a real dirty drive! †]]
    memeList["!jacko"] = [[† Dominates the battle with an ensemble of servants! †]]
    memeList["!jack-o"] = [[† Juno not to scale! †]]
    memeList["!jack-o'"] = [[† holds 2 †]]
    memeList["!jackovalentine"] = [[† Will you be mine? †]]
    memeList["!ky"] = [[† Master of a multitude of techniques! †]]
    memeList["!kykiske"] = [[† Stale bread enjoyer, drinker of water without ice! †]]
    --memeList["!kyk"] = --[[†  †]]
    --memeList["!kylekiske"] = --[[†  †]]
    memeList["!kylekiosk"] = [[† Don't be fooled! †]]
    memeList["!leo"] = [[† A crushing pressure from his back-facing stance! †]]
    memeList["!leowhitefang"] = [[† Maybe I'm a lion! †]]
    memeList["!may"] = [[† Charges forward with vibrant energy! †]]
    memeList["!millia"] = [[† Blink once and it's over! †]]
    memeList["!milliarage"] = [[† Featuring Fukua from SkullGirls! †]]
    memeList["!mll"] = [[† Time for a bad hair day! †]]
    memeList["!nag"] = [[† It's morbing time! †]]
    memeList["!nago"] = [[† His blood-sucking blade delivers a devastating blow! †]]
    memeList["!nagoriyuki"] = [[† He's Dandy! †]]
    memeList["!potemkin"] = [[† It's game over once you are in his grasp! †]]
    memeList["!pot"] = [[† Groove to the rhythm of your own theme song! †]]
    memeList["!ram"] = [[† :burger †]]
    memeList["!ramlethal"] = [[† Wielder of two giant swords! †]]
    memeList["!ramlethalvalentine"] = [[† Stretching the definition of "melee" to the breaking point! †]]
    memeList["!sol"] = [[† Overpowering all foes with savage force! †]]
    memeList["!solbadguy"] = [[† Strategy? Spacing? I just keep punching until I hit something. †]]
    memeList["!badguy"] = [[† That recovery is not a typo. †]]
    memeList["!testament"] = [[† Crimson scythe swaying in an enchanting dance! †]]
    memeList["!tst"] = [[† Gear up! †]]
    memeList["!zato"] = [[† Suffocating offense paired with his shadow! †]]
    memeList["!zato-1"] = [[† Adjectives on the typewriter
He moves his words like a prize fighter
The frenzied pace of the mind inside the cell †]]
    memeList["!zat"] = [[† "What has happened to that elegance of yours?" †]]
    memeList["!eddie"] = [[† Hey, isn't that Dead Man's Hand? †]]
    -- Miscellaneous memes starting here.
    memeList["!version"] = [[Version ]]..versionNumber..[[: ]]..versionLabel..[[!]]
    memeList["!5050"] = [["50/50" (noun)
A Strike in which the defender has no perfectly safe play.
They can win by correctly predicting the attack; otherwise, they lose.]]
    memeList["!axekick"] = [["It's not overpowered, it loses to Axe Kick"]]
    memeList["!bhg"] = [["As a defensive fighter, Guile [...] doesn't get much benefit from initiating strikes."]]
    memeList["!cc0"] = [["CC0" (verb, more or less)
Change Cards 0: spend 0 Force to Change Cards, drawing 0 cards.
Move 0 also works (as of S4). Remember to draw at end of turn!]]
    memeList["!cross"] = [["Cross out" (verb)
Respond to a Strike with Cross in order to retreat out of range. Usually performed at Range 2 or greater.]]
    memeList["!discordmeta"] = [[D: The L99 Discord tends to play much more aggressively than the Taximeta.]]
    memeList["!exblock"] = [[Just don't.]]
    memeList["!mixup"] = [["Mixup" (noun)
The simultaneous threat of a strong, unsafe attack and a weak, safe attack.
The safe attack can defeat an attempt to punish the unsafe attack.]]
    memeList["!parry"] = [["Parry Exodia" (verb; also "parry Black Lotus", "parry Matsu the Butcher", etc.)
Using the Parry Boost, name a card your opponent could not possibly have in order to look at their hand. Although it's
arguably illegal to name a non-EXCEED card, it's quite legal to name an EXCEED card belonging to an absent character.
Variant forms of this technique should be considered creative shorthand for a legal version of the effect.]]
    memeList["!promoknight"] = [[Affectionate nickname for the Shovel Knight solo fighter.]]
    memeList["!r8"] = [[Taximeta intensifies]]
    memeList["!range8"] = [[Taximeta intensifies]]
    memeList["!streetcar"] = [[What could possibly go wrong?]]
    memeList["!taximeta"] = [[D: The "Taximeta" is the largest known IRL scene, named for their TO, TaxiCAB.]]
    memeList["!tech"] = [["Poor man's tech" (noun)
A Strike initiated to waste opponent Boosts. Usually a Block, Cross, or similar "safe" attack.]]
    memeList["!wildswing"] = [[MOON PUNCH]]

    if string.sub(message, 1, 6) == "!debug" then
      local newDebugLevel = tonumber(string.sub(message, 7)) or nil
      -- If a debug level was provided, enable debugging and set the current level.
      if newDebugLevel != nil then
        debugFlag = true
        debugLevel = newDebugLevel
        printToAll("level "..debugLevel.." debugging enabled")
      -- If a debug level was not provided and debugging is enabled, disable it.
      elseif debugFlag == true and newDebugLevel == nil then
        debugFlag = false
        player.print("debugging disabled")
      -- If a debug level was not provided and debugging is disabled, enable it.
      elseif debugFlag == false and newDebugLevel == nil then
        debugFlag = true
        printToAll("level "..debugLevel.." debugging enabled")
      end
      return false
    end

    if message == "!oxenfree" then
      print(printTable(hiddenObjects))
      return false
    end

    if string.sub(message, 1, 9) == "!findGUID" then
      local findingGUID = string.sub(message, 10, -1) or nil
      local foundObject = getObjectFromGUID(findingGUID)
      if foundObject == nil then
        debugLog{"object not found", 0, {1, 0, 0}}
        return false
      else
        debugLog{"found at: "..foundObject.getPosition().x..", "..foundObject.getPosition().y..", "..foundObject.getPosition().z, 0}
        return false
      end
    end

    local meme = memeList[message] or ''
    if meme != '' then
      player.print("Command acknowledged: "..message)
      broadcastToAll(memeList[message], colorNotifications)
      return false
    end
  end
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
  elseif type(thisTable) == [[nil]] then
    printString = printString..[=[[FF0000]is nil[-]]=]
  else
    --local value = thisTable or "nil"
    printString = printString..[=[[00FFFF]value: ]=]..thisTable..[=[[-]]=]
    --printToAll(indent.."value: "..thisTable, {0,1,1})
  end
  return printString
end -- end printTable



function onObjectDrop(player_color, dropped_object)
  if glitchMode == true then
    local playerReference = Player[player_color]
    local dropPoints = math.random(0, 10)
    if dropPoints > 0 and dropPoints < 3 then
      givePrizeToPlayer{
        playerReference = playerReference,
        multiplier = 2,
        points = dropPoints
      }
    end
  end
  return true
end



function onObjectLeaveContainer(container, obj)
  --[=[
    -- When a character leaves a Selection bag, add a fighter-specific announcement.
    debugLog{"object left container", 3}
    --debugLog{" container: "..container.getGUID(), 2}
    debugLog{" removed object, memo: "..obj.memo, 4, {0,1,1}}

    local playersTable = Player.getPlayers()

    --debugLog{"printTable: "..printTable(playersTable), 3}

    local pingPlayer = playersTable[math.random(1, #playersTable)]

    --debugLog{"pingPlayer: "..printTable(pingPlayer), 3}

    -- If the object has a memo, check to make sure it does not have the exact same memo as any item still inside the container.
    -- This is intended to catch duplicates.
    local duplicateCheck = false
    if obj.memo != [[]] then
      for index,subtable in ipairs(container.getObjects()) do
        --debugLog{"   sub-item memo: "..subtable.memo, 2, {1,1,0}}
        if subtable.memo == obj.memo and string.sub(obj.getGMNotes(), -10) != ".reference" then
          --debugLog{" memo match", 2}
          --debugLog{" string sub: "..string.sub(obj.getGMNotes(), -10), 3}
          duplicateCheck = true
        end
      end -- end for loop that counts objects in container
      for index,item in ipairs(Global.getObjects()) do
        --debugLog{"   global item memo: "..item.memo, 2, {1,1,0}}
        if item.guid != obj.guid and item.memo == obj.memo and string.sub(obj.getGMNotes(), -10) != ".reference" then
          --debugLog{" memo match", 2}
          --debugLog{" string sub: "..string.sub(obj.getGMNotes(), -10), 3}
          duplicateCheck = true
        end
      end
    end -- end 'if obj.memo != [[]]'

    if duplicateCheck == true then
      broadcastToAll("[FF0000]WARNING:[-] [FFFF00]CARD DUPLICATION ERROR![-]")

      -- If the card is face-up, report its name.
      if obj.getRotation().z < 90 or obj.getRotation().z > 270 then
        printToAll("Card with error: "..obj.getName())
      end

      --debugLog{" pingColor: "..pingPlayer.color}
      local pingPosition = obj.getPosition()
      pingPlayer.pingTable(pingPosition)
    end
  --]=]

    --[[ Easter egg: custom fighters.
    if container.getGUID() == '761d38' then
        broadcastToAll("Nothing to see here.", {26/255,26/255,26/255})
    end --]]

    -- Resize decks for the 12.0 revamp.
    if obj.tag == 'Deck' then
      if debugFlag == true then printToAll("object is a deck")
        obj.setScale({
          x = 1.25,
          y = 1.00,
          z = 1.25
        })
      end
    end

    --[=[
    -- Only do something if the container is one of the Selection bags.
    if container.getName() == "Selection" then
        if debugFlag == true then
            print("container name confirmed")
            print("obj name: "..obj.getName())
        end
        local name = obj.getName()

        -- If it has no name, we'll use the default announcement.
        if name == nil or name == '' then
            name = "default"
        end

        -- Grab the character's unique announcement from the list.
        local ann = characterAnnouncementList[name]

        -- If there's a shared character, use a special announcement instead.
        -- Known bug/issue: currently produces a false positive if the same player
        -- pulls the same character twice in a row.
        if announcementList[announcementMax] == ann then
            ann = [[* Great minds think alike! *]]
        end

        if debugFlag == true and ann != nil then
            print("adding announcement: "..ann)
        end

        if name != "default" and ann != [[* Great minds think alike! *]] and ann != nil then
            -- Add the new announcement to the list.
            local testvar = announcementMax+1
            announcementList[testvar] = ann
            announcementMax = announcementMax+1
        end
    end
    --]=]
end -- end onObjectLeaveContainer


-- [=[
function onObjectNumberTyped(object, player_color, number)
  --debugLog{"picking up a signal", 1}
  --debugLog{"   number: "..number, 1}
  -- Added for April Fool's Exceed 2025.
  if glitchMode == true then
    local playerReference = Player[player_color]
    local numberPoints = math.random(0, number)
    if numberPoints > 0 and numberPoints < 8 then
      givePrizeToPlayer{
        playerReference = playerReference,
        multiplier = 1,
        points = numberPoints
      }
    end
  end
  return false
end -- end onObjectNumberTyped
--]=]



function onObjectPickUp(player_color, obj)
  if obj.tag == 'Card' and validationMode == true and obj.memo != [[]] and obj.memo != nil then
    -- [=[
      -- When a character leaves a Selection bag, add a fighter-specific announcement.
      debugLog{"object spawned", 4}
      --debugLog{" container: "..container.getGUID(), 2}
      debugLog{" picked up object, memo: "..obj.memo, 4, {0,1,1}}

      local playersTable = Player.getPlayers()

      --debugLog{"printTable: "..printTable(playersTable), 3}

      local pingPlayer = playersTable[math.random(1, #playersTable)]

      --debugLog{"pingPlayer: "..printTable(pingPlayer), 3}

      -- If the object has a memo, check to make sure it does not have the exact same memo as any item still inside the container.
      -- This is intended to catch duplicates.
      local duplicateCheck = false

      -- Set nil string to empty to prevent string.sub errors.
      local objectGMNotes = obj.getGMNotes()
      if objectGMNotes == nil then
        objectGMNotes = [[]]
      end

      for index,item in ipairs(Global.getObjects()) do
        --debugLog{"   global item memo: "..item.memo, 2, {1,1,0}}
        if item.tag == 'Deck' then
          for index,subtable in ipairs(item.getObjects()) do
            --debugLog{"   sub-item memo: "..subtable.memo, 2, {1,1,0}}
            if subtable.memo == obj.memo and string.sub(objectGMNotes, -10) != ".reference" then
              --debugLog{" memo match", 2}
              --debugLog{" string sub: "..string.sub(obj.getGMNotes(), -10), 3}
              duplicateCheck = true
            end
          end -- end for loop that counts objects in container
        end
        if item.guid != obj.guid and item.memo == obj.memo and string.sub(objectGMNotes, -10) != ".reference" then
          --debugLog{" memo match", 2}
          --debugLog{" string sub: "..string.sub(obj.getGMNotes(), -10), 3}
          duplicateCheck = true
        end
      end

      if duplicateCheck == true then
        broadcastToAll("[FF0000]WARNING:[-] [33FFFF]Duplicate card detected on pickup![-]")

        -- If the card is face-up, report its name.
        --[[
        if obj.getRotation().z < 90 or obj.getRotation().z > 270 then
          printToAll("Card with error: "..obj.getName())
        end
        --]]

        --debugLog{" pingColor: "..pingPlayer.color}
        local pingPosition = obj.getPosition()
        pingPlayer.pingTable(pingPosition)
      end
    --]=]
  end
end -- end onObjectPickUp



function onObjectRotate(object, spin, flip, player_color, old_spin, old_flip)
  --debugLog{"picking up a signal", 1}
  --debugLog{"   number: "..number, 1}
  -- Added for April Fool's Exceed 2025.
  if glitchMode == true then
    local playerReference = Player[player_color]
    local rotatePoints = math.random(0, 12)
    if rotatePoints > 0 and rotatePoints < 4 then
      givePrizeToPlayer{
        playerReference = playerReference,
        multiplier = 1,
        points = rotatePoints
      }
    end
  end
  return true
end -- end onObjectRotate



function onObjectSearchEnd(obj, player_color)

  local playersTable = Player.getPlayers()
  local pingPlayer = playersTable[math.random(1, #playersTable)]
  local duplicateCheck = false
  local duplicateName = [[]]

  if obj.tag == 'Deck' and validationMode == true then

    for index,subitem in ipairs(obj.getObjects()) do
      -- Skip the check if we've already identified a duplicate.
      if duplicateCheck == false then

        -- If any item within the container has a memo, check to make sure it does not have the exact same memo as any item in the world.
        -- This is intended to catch duplicates.

        -- Set nil string to empty to prevent string.sub errors.
        local subitemMemo = subitem.memo
        if subitemMemo == nil then
          subitemMemo = [[]]
        end
        --debugLog{"   sub-item memo: "..subitemMemo, 2, {1,1,0}}

        -- Set nil string to empty to prevent string.sub errors.
        local subitemGMNotes = subitem.GMNotes
        if subitemGMNotes == nil then
          subitemGMNotes = [[]]
        end
        --debugLog{"   sub-item GMNotes: "..subitemGMNotes, 2, {1,1,0}}

        -- Only perform a check if the subitem has a memo value and is not a reference copy.
        if subitemMemo != [[]] and string.sub(subitemGMNotes, -10) != ".reference" then

          -- Check every object in the world.
          for index,worldObj in ipairs(Global.getObjects()) do
            -- Skip check if duplicate has already been identified.
            if duplicateCheck == false then
              --if worldObj.memo != nil then debugLog{"   worldObj memo: "..worldObj.memo, 2, {1,1,0}} end
              if worldObj.tag == 'Card' and worldObj.getMemo() == subitemMemo then
                --debugLog{" memo match", 2}
                duplicateName = subitem.name
                duplicateCheck = true
              elseif worldObj.tag == 'Deck' and obj != worldObj then
                for worldIndex,subtable in ipairs(worldObj.getObjects()) do
                  -- Skip check if duplicate has already been identified.
                  if duplicateCheck == false then
                    --if subtable.memo != nil then debugLog{"   subtable memo: "..subtable.memo, 2, {1,1,0}} end

                    local subtableGMNotes = subtable.GMNotes
                    if subtableGMNotes == nil then
                      subtableGMNotes = [[]]
                    end

                    if subtable.memo == subitemMemo and string.sub(subtableGMNotes, -10) != ".reference" then
                      --debugLog{" worldObj Deck search memo match", 2}
                      --debugLog{" string sub: "..string.sub(subtableGMNotes, -10), 3}
                      duplicateName = subtable.name
                      duplicateCheck = true
                    end
                  end -- end 'if duplicateCheck == false'
                end -- end for loop that counts objects in container
              end -- finish check to confirm that the world object is a card or deck and has a memo that matches
            end -- end 'if duplicateCheck == false'
          end -- finish looping through all objects in the world

        end -- finish check to confirm that the subitem has a memo and is not a reference copy

      end -- end 'if duplicateCheck == false'

    end -- end for loop that counts objects in container
  end -- finish check to confirm that object is a deck and validationMode is true

  if duplicateCheck == true then
    debugLog{" duplicate check: true!", 3}
    broadcastToAll("[FF0000]WARNING:[-] [FF44FF]Duplicate card detected in container![-]")

    -- If the deck is face-up, report its name.
    -- [[
    if obj.getRotation().z < 90 or obj.getRotation().z > 270 then
      printToAll("Card with error: "..duplicateName)
    end
    --]]

    --debugLog{" pingColor: "..pingPlayer.color}
    local pingPosition = obj.getPosition()
    pingPlayer.pingTable(pingPosition)
  end
end -- end onObjectSearchEnd



-- When a deck is spawned, resize it.
function onObjectSpawn(obj)
  if obj.tag == 'Deck' then
    obj.setScale({
      x = 1.25,
      y = 1.00,
      z = 1.25
    })
  elseif obj.tag == 'Card' and validationMode == true and obj.memo != [[]] and obj.memo != nil then
    -- [=[
      -- When a character leaves a Selection bag, add a fighter-specific announcement.
      debugLog{"object spawned", 4}
      --debugLog{" container: "..container.getGUID(), 2}
      debugLog{" picked up object, memo: "..obj.memo, 4, {0,1,1}}

      local playersTable = Player.getPlayers()

      --debugLog{"printTable: "..printTable(playersTable), 3}

      local pingPlayer = playersTable[math.random(1, #playersTable)]

      --debugLog{"pingPlayer: "..printTable(pingPlayer), 3}

      -- If the object has a memo, check to make sure it does not have the exact same memo as any item still inside the container.
      -- This is intended to catch duplicates.
      local duplicateCheck = false

      -- Set nil string to empty to prevent string.sub errors.
      local objectGMNotes = obj.getGMNotes()
      if objectGMNotes == nil then
        objectGMNotes = [[]]
      end

      for index,item in ipairs(Global.getObjects()) do
        --debugLog{"   global item memo: "..item.memo, 2, {1,1,0}}
        if item.tag == 'Deck' then
          for index,subtable in ipairs(item.getObjects()) do
            --debugLog{"   sub-item memo: "..subtable.memo, 2, {1,1,0}}
            if subtable.memo == obj.memo and string.sub(objectGMNotes, -10) != ".reference" then
              --debugLog{" memo match", 2}
              --debugLog{" string sub: "..string.sub(obj.getGMNotes(), -10), 3}
              duplicateCheck = true
            end
          end -- end for loop that counts objects in container
        end
        if item.guid != obj.guid and item.memo == obj.memo and string.sub(objectGMNotes, -10) != ".reference" then
          --debugLog{" memo match", 2}
          --debugLog{" string sub: "..string.sub(obj.getGMNotes(), -10), 3}
          duplicateCheck = true
        end
      end

      if duplicateCheck == true then
        broadcastToAll("[FF0000]WARNING:[-] [FFFF00]Duplicate card spawn detected![-]")
        -- If the card is face-up, report its name.
        --if obj.getRotation().z < 90 or obj.getRotation().z > 270 then
          --printToAll("Card with error: "..obj.getName())
        --end
        --debugLog{" pingColor: "..pingPlayer.color}
        local pingPosition = obj.getPosition()
        pingPlayer.pingTable(pingPosition)
      end
    --]=]
  end
end



--[[
function onPlayerConnect(newcomer)
    -- Welcome message for newcomers.
    broadcastToColor("Hold Shift and press a number to jump to that camera.", newcomer.color, {1,1,0,})
    disclaimToColor(newcomer.color)
end -- end onPlayerConnect
--]]
function onPlayerConnect(newcomer)
    -- Make sure everybody gets the disclaimer.
    disclaimToColor(newcomer)
end -- end onPlayerConnect



-- It seems like this function can only be declared in the Global script.
-- If an object with "nonstackable" in its note tries to combine with another card, prevent it from doing so.
function tryObjectEnterContainer(container, object)
  --debugLog{ "object trying to enter container", 4}

  local objectNote = object.getMemo() or [[]]
  local containerNote = container.getMemo() or [[]]
  --debugLog{ "object note: "..objectNote, 4}

  local nonstackable = string.find(objectNote, "nonstackable")
  if nonstackable == nil then
    nonstackable = string.find(containerNote, "nonstackable")
  end
  if nonstackable != nil then
    --debugLog{ " nonstackable object found", 3, {0.8,0.8,0}}

    -- If the container has the 'Card' tag, it means the object is trying to combine with an individual card to form a deck.
    if container.tag == 'Card' then
      --debugLog{ "  container is a card", 3, {1,0,1}}
      return false
    elseif container.tag == 'Deck' then
      --debugLog{ "  container is a deck", 3, {1,0,1}}
      return false
    else
      --debugLog{ "  container is not a card or deck", 3, {1,0,1}}
      return true
    end
  else
    --debugLog{ " stackable object found", 3, {1,1,0.2}}
    return true
  end
end -- end tryObjectEnterContainer



function pauseTimers()
      -- Pauses the current timer. 'click_Resume' resumes.
      -- Does not pause the round timer unless pauseRoundTimer or pauseOverride is active. This is intentional.

      if activeTimerMode.pauseTurnTimer == true then
          local turnClock = getTurnTimer(currentPlayer)
          local turnClockValue = turnClock.Clock.getValue()
          turnClock.Clock.setValue(turnClockValue) -- Pauses even if already paused.

          Timer.destroy(turnClock.getGUID())
      end

      if activeTimerMode.pauseRoundTimer == true or pauseOverride == true then
          local roundClockValue = clkRoundTimer.Clock.getValue()

          clkRoundTimer.Clock.setValue(roundClockValue) -- Pauses even if already paused.
          -- Destroy the round timer(s).
          Timer.destroy(clkRoundTimer.getGUID())
          Timer.destroy(clkRoundTimer.getGUID().."1")
          Timer.destroy(clkRoundTimer.getGUID().."2")
          Timer.destroy(clkRoundTimer.getGUID().."3")
      end

      if activeTimerMode.pauseTurnTimer == true or activeTimerMode.pauseRoundTimer == true or pauseOverride == true then
          isPaused = true
          broadcastToAll("Timer Paused",{1,1,0})
          btnPauseTimers.editButton({
              index = 0,
              label = 'Resume',
              tooltip = 'Resume current timer',
              click_function = 'click_Resume',
              font_size = 100,
          })
      end

      pauseOverride = false
  end -- end pauseTimers



function roundTimeout()
    -- Stuff that happens when the game ends due to time running out.
    local timeWinner = "Nobody"
    local clock = getTurnTimer(currentPlayer)
    local oppClock = getTurnTimer(opponent)

    if debugFlag == true then
        print("roundTimeout")
        print("timeoutLoser: "..timeoutLoser)
    end

    -- If time is a victory condition, figure out who won.
    if activeTimerMode.timeTiebreaks == true then

        -- If a timeout loser hasn't been set, figure out who it is.
        if timeoutLoser == "Nobody" then

            local timeDiff = clock.Clock.getValue() - oppClock.Clock.getValue()

            if debugFlag == true then
                print("timeDiff: "..timeDiff)
            end

            -- Do not set a timeout loser if the gap did not exceed mercyTime.
            if timeDiff > activeTimerMode.mercyTime then
                if timeDiff < 0 then -- currentPlayer was slower.
                    timeoutLoser = currentPlayer
                elseif timeDiff > 0 then -- opponent was slower.
                    timeoutLoser = opponent
                end
            end
        end -- timeoutLoser should now be set.
        timeWinner = getOpponent(timeoutLoser)
    end

    if debugFlag == true then
        print("logic completed")
        print("timeWinner: "..timeWinner)
    end

    if timeWinner != "Nobody" then
        -- If either player was awarded a timeout victory, the game ends now.
        broadcastToAll("Game ends NOW!",{1,1,0})
        broadcastToAll(_G["str"..timeWinner].." is victorious by timeout!",_G["textColor"..timeWinner])
    elseif timeWinner == "Nobody" then
        -- If neither player timed out (or time was not a victory condition), play 2 more turns after this one.
        broadcastToAll("Time's up! Finish this turn and 2 more!\nThen, the fighter with higher life claims victory!",{0,1,1})
    end
end -- end roundTimeout



function roundWarning(params)
    -- Warn folks time's about to run out.
    broadcastToAll(params.bcText,params.bcColor)
end -- end roundWarning



function setCurrent(newPlayer)
    -- Sets 'currentPlayer' and 'opponent' to "Plr1" or "Plr2", as relevant.
    -- Also hides/shows the relevant buttons (by calling showHideBtn).
    if newPlayer == "Plr1" then
        currentPlayer = "Plr1"
        opponent = "Plr2"
    elseif newPlayer == "Plr2" then
        currentPlayer = "Plr2"
        opponent = "Plr1"
    end

    local buttonStrike = _G["btnStrike"..currentPlayer]
    local buttonTurn = _G["btnTurn"..currentPlayer]
    local oppButtonTurn = _G["btnTurn"..opponent]
    local oppButtonStrike = _G["btnStrike"..opponent]

    if activeStrike == true then
        -- rename the currentPlayer Strike button to "Respond!"
        buttonStrike.editButton({
            index = 0,
            label = 'Respond!',
            tooltip = 'Respond with your own attack!',
        })
        oppButtonTurn.editButton({
            index = 0,
            label = 'Resume\nTurn',
            tooltip = 'Finish your turn',
            color = _G["textColor"..opponent],
        })
        buttonTurn.editButton({
            index = 0,
            label = 'Respond!',
            tooltip = 'Respond with your own attack!',
            color = colorDefaultBG,
        })
        showHideBtn(_G["btnTurn"..currentPlayer], "hide")
    elseif activeStrike == false then
        -- rename the currentPlayer Strike button to "Strike!"
        oppButtonStrike.editButton({
            index = 0,
            label = 'Reveal!',
            tooltip = [[Pauses player timers for Strike resolution]],
        })
        buttonStrike.editButton({
            index = 0,
            label = 'Reveal!',
            tooltip = [[Pauses player timers for Strike resolution]],
        })
        oppButtonTurn.editButton({
            index = 0,
            label = 'Start\nTurn',
            tooltip = 'Start your turn manually',
            color = _G["textColor"..opponent],
        })
        buttonTurn.editButton({
            index = 0,
            label = 'End\nTurn',
            tooltip = 'Pass the turn to your opponent',
            color = colorDefaultBG,
        })
        showHideBtn(_G["btnTurn"..opponent], "show")
    end

    -- Show and hide Strike buttons if they're used by the current timer mode.
    if activeTimerMode.showBtnStrike == true then
    --    showHideBtn(_G["btnTurn"..currentPlayer], "show")
        showHideBtn(_G["btnStrike"..currentPlayer], "show")
    --    showHideBtn(_G["btnEnd"..currentPlayer], "show")
    --    showHideBtn(_G["btnTurn"..opponent], "show")
        showHideBtn(_G["btnStrike"..opponent], "hide")
    --    showHideBtn(_G["btnEnd"..opponent], "hide")
    end
end --end setCurrent



function setFlailingMode(params)
  local newMode = params.newMode
  local playerColor = params.playerColor or "Grey"
  local toggle = params.toggle
  local oldMode = flailingMode

  if toggle == true then
    flailingMode = not flailingMode
  elseif newMode == true or newMode == false then
    flailingMode = newMode
  else
    flailingMode = true
  end
  debugLog{"flailingMode: "..tostring(flailingMode), 1 , Color.fromString(playerColor) }
  -- If the mode changed, notify folks.
  if oldMode != flailingMode then
    if flailingMode == true then
      broadcastToAll("(This is a leftover April Fool's joke. Expect the unexpected.)", {0.7,0.7,0.7})
      broadcastToAll("Flailing enabled!", {1,1,0})
    else
      broadcastToAll("Flailing disabled!", {0,1,0})
    end -- end if glitchMode == true
  end -- end if oldMode != glitchMode
end -- end setFlailingMode



function setGlitchMode(params)
  local newMode = params.newMode
  local playerColor = params.playerColor or "Grey"
  local toggle = params.toggle
  local oldMode = glitchMode

  if toggle == true then
    glitchMode = not glitchMode
  elseif newMode == true or newMode == false then
    glitchMode = newMode
  else
    glitchMode = true
    debugLog{"warning: should not have taken that left turn at Albuquerque", 0, {1,1,0}}
  end
  debugLog{"glitchMode: "..tostring(glitchMode), 1 , Color.fromString(playerColor) }
  -- If the mode changed, notify folks.
  if oldMode != glitchMode then
    if glitchMode == true then
      --broadcastToAll("(This is a leftover April Fool's joke. Expect the unexpected.)", {0.7,0.7,0.7})
      broadcastToAll("Bugs (AKA April Fool's Mode) enabled!", {1,1,0})
      local glitchModeAudioCueList = {
        -- TODO: Reupload all these as WAV or OGG or something.
        [[https://steamusercontent-a.akamaihd.net/ugc/2039608339947636641/B7AA68A89B134CBABE719DE1C365E4BD8BEA6B1A/]],
        [[https://steamusercontent-a.akamaihd.net/ugc/2039608339947637418/4CEF4DD86ED8C62BFB314000F69A5E151D20EB39/]],
        [[https://steamusercontent-a.akamaihd.net/ugc/2039608339947643649/223A8EBC1D7378AB32685B8EE9FCE5F3707262BD/]],
        [[https://steamusercontent-a.akamaihd.net/ugc/2039608339947644914/369BDC8856549E1A383FE0E10FEA01AC0D179F7F/]],
        [[https://steamusercontent-a.akamaihd.net/ugc/2039608339947645453/B661ED22672F8E37353AC76DB5C3A72F09988CEA/]],
        [[https://steamusercontent-a.akamaihd.net/ugc/2039608339947645948/C0945524044F5786471174A37F22BBFA633186EA/]],
        [[https://steamusercontent-a.akamaihd.net/ugc/2039608339947646433/EB102AD3B41A475B4AE01B688201FAD8500B2DCE/]],
        [[https://steamusercontent-a.akamaihd.net/ugc/2039608339947646892/D759076BFE36477D6394A9DA833D8BB4830F3B41/]],
        [[https://steamusercontent-a.akamaihd.net/ugc/2039608339947647936/5AA8D3827C7D922B62FE4C689B9D20503606498F/]],
        [[https://steamusercontent-a.akamaihd.net/ugc/2039608339947648478/B3AE9A44FB382FECAE02222B57A3C397259FA5FA/]],
      }
      local glitchModeAudioCueRoll = math.random(1, #glitchModeAudioCueList)
      MusicPlayer.repeat_track = false
      MusicPlayer.setCurrentAudioclip({url=glitchModeAudioCueList[glitchModeAudioCueRoll],title=[[flibbertigibbet No. ]]..glitchModeAudioCueRoll})
    else
      broadcastToAll("Bugs disabled! (Hopefully.)", {0,1,0})
      for _,thisPlayer in ipairs(Player.getPlayers()) do
        local playerSteamID = thisPlayer.steam_id
        if playerPrizes[playerSteamID] != nil then
          printToAll(thisPlayer.steam_name.."'s final score this round: "..playerPrizes[playerSteamID])
          playerPrizes[playerSteamID] = nil
        end
      end
      local stickyCoin = getObjectFromGUID([[c33d52]])
      if stickyCoin.getLock() == true then
        stickyCoin.setLock(false)
      end
    end -- end if glitchMode == true
  end -- end if oldMode != glitchMode
end -- end setGlitchMode



function setRoundTime(newTime)
    -- Resumes a clock paused with click_Pause. Also recreates the timer.
    local clock = clkRoundTimer
    local clockValue = newTime
    clock.Clock.setValue(newTime) -- This also ensures the clock is paused.

    if clockValue > 0 then -- If no time remains, don't create timers.
        Timer.destroy(clock.getGUID())
        Timer.create({
            identifier = clock.getGUID(),
            delay = clockValue,
            repetitions = 1,
            function_name = 'roundTimeout',
        })
        if clockValue >= thirdWarning then
            Timer.destroy(clock.getGUID().."3")
            Timer.create({
                identifier = clock.getGUID().."3",
                delay = (clockValue - thirdWarning),
                repetitions = 1,
                function_name = 'roundWarning',
                parameters = {
                    bcText = (thirdWarning/60)..' minutes remain!',
                    bcColor = {1,0,0},
                },
            })
            if clockValue >= secondWarning then
                Timer.destroy(clock.getGUID().."2")
                Timer.create({
                    identifier = clock.getGUID().."2",
                    delay = (clockValue - secondWarning),
                    repetitions = 1,
                    function_name = 'roundWarning',
                    parameters = {
                        bcText = (secondWarning/60)..' minutes remain!',
                        bcColor = {1,1,0},
                    },
                })
                if clockValue >= firstWarning then
                    Timer.destroy(clock.getGUID().."1")
                    Timer.create({
                        identifier = clock.getGUID().."1",
                        delay = (clockValue - firstWarning),
                        repetitions = 1,
                        function_name = 'roundWarning',
                        parameters = {
                            bcText = (firstWarning/60)..' minutes remain!',
                            bcColor = {1,1,1},
                        },
                    })
                end
            end
        end
    end
end -- end setRoundTime



function setTimerMode(newMode)
    -- Rotates through the available timer modes.
    local maxModeIndex = timerModeCount

    if newMode > maxModeIndex then
        newMode = 1
    end

    if debugFlag == true then
        print("setTimerMode")
        print("newMode: "..newMode)
        print("maxModeIndex: "..maxModeIndex)
    end

    -- Relabels the Timer Mode button.
    btnTimerMode.editButton({
        label = timerModes[newMode].modeLabel,
        tooltip = timerModes[newMode].modeTooltip
    })

    -- Changes the active timer mode, if it's implemented.
    if timerModes[newMode].implemented == true then
        if debugFlag == true then print("New mode is implemented") end
        btnTimerMode.editButton({color = {1,1,1},})
        activeTimerMode = timerModes[newMode]
        broadcastToAll("Timer Mode: "..activeTimerMode.modeName, colorNotifications)
    elseif timerModes[newMode].implemented == false then
        printToAll("(Sorry, that mode isn't implemented yet. Previous mode still active.)", colorNotifications)
        btnTimerMode.editButton({color = {0.4,0.4,0.4},})
    end
    activeModeIndex = newMode

    if debugFlag == true then
        print("resetting clocks")
    end

    -- Show (and reset) or hide round timer, as appropriate.
    if activeTimerMode.useRound == true then
        showHideBtn(clkRoundTimer, "show")
        clkRoundTimer.Clock.setValue(activeTimerMode.maxRoundTime)
    elseif activeTimerMode.useRound == false then
        showHideBtn(clkRoundTimer, "hide")
    end

    -- Show (and reset) or hide turn clocks, as appropriate.
    if activeTimerMode.useTurns == true then
        showHideBtn(clkTurnTimerPlr1, "show")
        showHideBtn(clkTurnTimerPlr2, "show")
        clkTurnTimerPlr1.Clock.setValue(activeTimerMode.playerTurnTime)
        clkTurnTimerPlr2.Clock.setValue(activeTimerMode.playerTurnTime)
    elseif activeTimerMode.useTurns == false then
        showHideBtn(clkTurnTimerPlr1, "hide")
        showHideBtn(clkTurnTimerPlr2, "hide")
    end

end -- end setTimerMode



function setTurnSign(newSign)
    -- Sets the sign for the current turn clock.
    -- This is used to determine whether a player's current time is negative.
    -- Since clocks don't actually run negative, we need to track that somehow.
    local clock = getTurnTimer(currentPlayer)
    if debugFlag == true then
        print("setTurnSign")
        print("currentPlayer: "..currentPlayer)
    end
    if newSign < 0 then
        -- Blackens the turn clock if in debt.
        clock.setColorTint({0,0,0})
    elseif newSign >= 0 then
        -- Colorizes the turn clock in case it was previously blackened.
        clock.setColorTint(_G["clockColor"..currentPlayer])
    end
    turnTimerSign = newSign
end -- end setTurnSign



function showHideBtn(btnBox, op)
    -- Toggles the visibility of a button.
    -- The 'op' parameter is a string which should hold either "show" or "hide".
    -- Right now it's just a parlour trick; it moves the button out of sight.
    --  Should probably actually destroy/create them.
    -- Will have to modify onLoad so it creates global variables to hold the
    --  parameters used to create them, of course. (This way was faster.)
    debugLog{"-- showHideBtn: function running --", 4, {1,1,1}}
    debugLog{"   hiding item: "..btnBox.getGUID(), 5, {1,1,1}}

    local currentX = btnBox.getPosition()[1]
    local currentY = btnBox.getPosition()[2]
    local currentZ = btnBox.getPosition()[3]
    local newX = currentX
    local newY = currentY
    local newZ = currentZ
    local needToHide = true

    if debugFlag == true and debugLevel >= 2 then
      debugLog{"   currentX: "..currentX, 7, {1,1,1}}
      debugLog{"   currentY: "..currentY, 7, {1,1,1}}
      debugLog{"   currentZ: "..currentZ, 7, {1,1,1}}
    end

    -- If their position values are > 90, they've already been hidden.
    -- If they're < 90, then they've already been shown.
    if op == "show" then
      needToHide = false
      if currentY > 90 then
        newX = currentX
        newY = currentY-hideOffset
        newZ = currentZ
      end
      hiddenObjects[btnBox.getGUID()] = nil
    elseif op == "hide" then
      needToHide = true
      if currentY < 90 then
        newX = currentX
        newY = currentY+hideOffset
        newZ = currentZ
      end
      hiddenObjects[btnBox.getGUID()] = true
    end

    if debugFlag == true and debugLevel >= 2 then
      debugLog{"newX: "..newX, 7, {1,1,1}}
      debugLog{"newY: "..newY, 7, {1,1,1}}
      debugLog{"newZ: "..newZ, 7, {1,1,1}}
      debugLog{"-- showHideBtn: function ending --", 4, {1,1,1}}
    end

    btnBox.setPosition({x = newX, y = newY, z = newZ,})

    -- Trying to use this fancy "Hider" functionality.
    btnBox.attachInvisibleHider(btnBox.getGUID(), needToHide, allPlayers)
end -- end showHideBtn



function onPlayerChangeColor(player_color)
    local offsetX = 0
    local offsetZ = 0
    local newRotation = 0
    local newColor = player_color
    debugLog = debugLog

    debugLog{"player change detected: " .. player_color, 2}
    debugLog{"new color: " .. newColor, 2}

    if newColor == "Blue" or newColor == "Purple" or newColor == "Green" then
        newRotation = 180
    end

    if newColor == "Blue" then
        offsetX = 0
        offsetZ = 0.65
    elseif newColor == "Red" then
        offsetX = 0
        offsetZ = -0.65
    elseif newColor == "Green" then
        offsetX = 70
        offsetZ = 0.65
    elseif newColor == "Yellow" then
        offsetX = 70
        offzetZ = -0.65
    elseif newColor == "Purple" then
        offsetX = -70
        offsetZ = 0.65
    elseif newColor == "Orange" then
        offsetX = -70
        offsetZ = -0.65
    end

    if debugFlag == true then
        print("centering camera for " .. newColor)
        print("offsetX: " .. offsetX)
        print("offsetZ: " .. offsetZ)
    end

    if newColor != "Grey" and newColor != "Black" then
      Player[newColor].broadcast("Tournament players, check your chat!", {255/255,255/255,0})
      Player[newColor].print("Click the Setup button to use hidden areas for character selection. (They appear behind you - hold S to move your camera.)", {1,1,1})
        Player[newColor].lookAt({
            position = {
              x = 0 + offsetX,
              y = -1,
              z = 0 + offsetZ,
            },
            pitch = 65,
            yaw = newRotation,
            distance = 27.5,
            --distance = 38.9,
        })

        local handData = Player[newColor].getHandTransform()

        if handData.position[2] != 1 then
          if debugFlag == true then
            print("Hand position does not match; resetting")
          end
          Player[newColor].setHandTransform({
              position = {
                  x = handData.position[1],
                  y = 1,
                  z = handData.position[3],
              },
              rotation = {
                x=0,
                y = handData.rotation[2],
                z=0
              },
              scale = {x=14, y=10, z=5},
          }, 1)
        end -- end "if handData.position[2] != 1"
    end -- end "if newColor != Grey and newColor != Black"
end -- end onPlayerChangeColor



function onObjectEnterContainer(container, obj)
  -- When an object gets dropped into a Trash Bag, eliminate it.
  debugLog{"object entered container", 5}

  local name = container.getName()

  -- If the container is named 'Trash Bag', clear its contents.
  if name == 'Trash Bag' then
      container.reset()
  end
end -- end onObjectEnterContainer


--[[
function onSave()
  local state = {
    hiddenObjects,
    uninteractableObjects,
  }
  --debugLog{printTable(state), 3}
  return JSON.encode(state)
end
--]]


function onScriptingButtonDown(index, color)
    if debugFlag == true then
        printToAll("Button index: " .. index, {1,1,0.5})
        printToAll("Player color: " .. color, {1,1,1})
        printToAll("Current Player:" .. currentPlayer, {0.5,1,1})
    end

    -- If there is no active player, do nothing.
    if currentPlayer != "Nobody" then

      local playerNumber = getPlayerNumber(color)

        -- If the player isn't seated in a place, do nothing.
        if playerNumber != nil then
            --Identify the "Start Turn" or "End Turn" button belonging to the player.
            local turnButton = _G["btnTurn"..playerNumber]
            local strikeButton = _G["btnStrike"..playerNumber]

            -- 0: End Turn. Only use turns if turns are enabled!
            if index == 10 and activeTimerMode.useTurns == true then
                -- Only end turn if it's your turn!
                if playerNumber == currentPlayer then
                    click_Swap(turnButton, color, false)
                end
            -- 1: Start Turn. Only use turns if they are enabled!
            elseif index == 1 and activeTimerMode.useTurns == true then
                -- Only start turn if it's not your turn!
                if playerNumber == opponent then
                    click_Swap(turnButton, color, false)
                end
            -- 2: Strike! Only use if strikes are enabled!
            elseif index == 2 and activeTimerMode.showBtnStrike == true then
                -- Only strike if it's your turn!
                if playerNumber == currentPlayer then
                    -- If a Strike is already active, this is exactly like Respond!
                    click_Strike(strikeButton, color, false)
                end
            -- 3: Respond! Only use if strikes are enabled!
            elseif index == 3 and activeTimerMode.showBtnStrike == true then
                -- Only respond if it's the opponent's turn and a Strike is active!
                if playerNumber == currentPlayer and activeStrike == true then
                    click_Strike(strikeButton, color, false)
                end
            -- 4: Pause Timers. Only pause if not already paused and if the timer is in use!
            elseif index == 4 and isPaused == false and activeTimerMode.useRound == true then
                -- Only the active combatants should be allowed to pause!
                if playerNumber == currentPlayer or playerNumber == opponent then
                    click_Pause(btnPauseTimers, color, false)
                end
            -- 5: Resume Timers. Only resume if paused!
            elseif index == 5 and isPaused == true and activeTimerMode.useRound == true then
                -- Only the active combatants should be allowed to pause!
                if playerNumber == currentPlayer or playerNumber == opponent then
                    click_Resume(btnPauseTimers, color, false)
                end
            elseif index == 6 then
            elseif index == 7 then
            elseif index == 8 then
            elseif index == 9 then
            end
        end
    end
end -- end onScriptingButtonDown



function removeHidden(params)
  local removeGUID = params.GUID
  hiddenObjects[removeGUID] = nil
end



function removeUninteractable(params)
  local remove = params.GUID
  uninteractableObjects[removeGUID] = nil
end



function uiClick_SetValidationMode(player, value, id)
  if _G["activeSearch"..player.color] != nil then
    return
  end
  if value == [[True]] then
    broadcastToAll("Validation Mode: Enabled", {1,1,1})
    validationMode = true
  elseif value == [[False]] then
    broadcastToAll("Validation Mode: Disabled", {0.3, 0.3, 0.3})
    validationMode = false
  end
end



--[[ The Update function. This is called once per frame. --]]
-- Never use this for anything if you can help it. Lag is the enemy. >_>
function update ()
    --[[ print('Update loop!') --]]
end



function withinArea(area, obj)
    local ap = area.getPosition()
    local as = area.getScale()
    local op = obj.getPosition()
    return op[1] > ap[1] - as[1]/2 and op[1] < ap[1] + as[1]/2 and op[3] > ap[3] - as[3]/2 and op[3] < ap[3] + as[3]/2
end