local characterList = {}

local charToNoteTypeMap = {
    {'pony_biddle', 'opponent2'},
    {'pony_rareblin', 'player2'},
}

local cameos = {
    "Aleonepic",
    "MAJAVI",
    "Shaggy",
    "Shygee",
    "SiccusOn",
    "Sodalite"
}
local targetExclusions = ''
local targetsLeft = #cameos
local curTarget = 0

local static_bg_assets = {
    -- {filename, x, y, scrollfactor}
    {'sky', 0, 0, 0},
    {'grass', 0, -10, 1},
    {'trees_back', 50, 15, 0.85},
    {'bench', 0, 0, 0.9},
    {'trees_mid', 0, 0, 0.95, true},
    {'trees_front', 0, 50, 1, true}
}

function onCreate()
    --luaDebugMode = true
    setProperty('skipCountdown', true)
    setupWalkers()
	setupStage()
end

function setupWalkers()
    for i, walker in ipairs(cameos) do
        makeAnimatedLuaSprite(walker,'ponytown/cameos/walkers/'..walker, -1000, 10000)
		addAnimationByPrefix(walker,'idle','Walkies',12)
		setProperty( walker..'.antialiasing', false )
		playAnim(walker,"idle")
        setProperty(walker..'.alpha', 0.1)

        addLuaSprite(walker,false)	
    end

    runTimer('walker', getRandomFloat(5, 10))
end

function generateWalker(selected, id)
	local fromLeft = getRandomBool(50)
    local x = 100
    local y = 220 + getRandomInt(0, 65)
    local speed = getRandomInt(20, 40)
    if fromLeft then
        speed = -speed
        x = 600
    end
    
	setProperty(selected..'.alpha', 1)
	setProperty(selected..'.x', x)
	setProperty(selected..'.y', y)
	
	setProperty(selected..'.velocity.x', speed)
	setProperty(selected..'.animation.curAnim.frameRate', 12 * (math.abs(speed)/50))
	setProperty(selected..'.flipX', not fromLeft)

    resortObjects()
end

function tryStartWalker()
  --  debugPrint(targetExclusions)
    curTarget = getRandomInt(1, #cameos, targetExclusions)
    if targetExclusions == '' then
        targetExclusions = ''..curTarget
    else 
        targetExclusions = targetExclusions..','..curTarget
    end
    targetsLeft = targetsLeft - 1
    if targetsLeft <= 0 then 
        targetExclusions = ''..curTarget --reset
        targetsLeft = #cameos-1
    end
    
    local curTargetX = getProperty(cameos[curTarget]..'.x')
    if curTargetX > 100 and curTargetX < 600 then
        --target is already in bounds so dont bother lol
    else
        generateWalker(cameos[curTarget], curTarget)
    end
end

function onTimerCompleted(tag)
	if tag == 'walker' then
		tryStartWalker()
        runTimer('walker', getRandomFloat(5, 10))
	end
end

local objectList = {
    {'dad', 0},
    {'boyfriend', 0},
    {"pony_biddle", 0},
    {"pony_rareblin", 0},
    {"Aleonepic", 0},
    {"MAJAVI", 0},
    {"Shaggy", 0},
    {"Shygee", 0},
    {"SiccusOn", 0},
    {"Sodalite", 0},
}
function sortShit()

   -- debugPrint('about to sort')

    --recalculate object floor pos
    for i = 1, #objectList do
        objectList[i][2] = getProperty(objectList[i][1]..'.y') + getProperty(objectList[i][1]..'.height')
    end

    table.sort(objectList, function(a, b)
        return a[2] < b[2]
    end)
end

function resortObjects()
    
    sortShit()

    for i = 1, #objectList do
        local n = objectList[i][1]
        if n == 'dad' then n = 'dadGroup' end
        if n == 'boyfriend' then n = 'boyfriendGroup' end
        setObjectOrder(n, getObjectOrder('gfGroup') + i)
    end
end

function setupStage()
    -- don't you dare criticize my lua formatting. //i will criticize it
    -- ignore the boilerplate im not doing an intricate for a single background........... maybe

    -- reviewing this a couple days later i kinda regret the fancy formatting im too lazy to fix it LOL
    local scale = 1
    local asset = ""

	for i, asset_data in ipairs(static_bg_assets) do
        makeLuaSprite(asset_data[1], 'ponytown/'..asset_data[1], asset_data[2], asset_data[3])
        scaleObject(asset_data[1], scale, scale)
        setProperty(asset_data[1]..'.antialiasing', false)
        setScrollFactor(asset_data[1], asset_data[4], asset_data[4])
        addLuaSprite(asset_data[1], asset_data[5] ~= nil)
    end
	
	setObjectOrder('trees_front', getObjectOrder('boyfriendGroup') + 100)

    screenCenter('sky')
    
    asset = "bonette"
    makeAnimatedLuaSprite(asset, 'ponytown/cameos/Bonette',245,190)
    addAnimationByPrefix(asset,'idle','IDLE',12)
    setProperty(asset..'.antialiasing', false)
    scaleObject(asset,-.9,.9)
    setScrollFactor ( asset, .9, .9)
    addLuaSprite(asset)
    playAnim(asset,"IDLE")

    asset = "cesar"
    makeAnimatedLuaSprite(asset, 'ponytown/cameos/Cesar',320,180)
    addAnimationByPrefix(asset,'idle','IDLE',3)
    setProperty(asset..'.antialiasing', false)
    scaleObject(asset,-.9,.9)
    setScrollFactor ( asset, .9, .9)
    addLuaSprite(asset)
    playAnim(asset,"IDLE")

    asset = "sam"
    makeAnimatedLuaSprite(asset, 'ponytown/cameos/Samthesly',360,175)
    addAnimationByPrefix(asset,'idle','IDLE',5)
    setProperty(asset..'.antialiasing', false)
    scaleObject(asset,.9,.9)
    setScrollFactor ( asset, .9, .9)
    addLuaSprite(asset)
    playAnim(asset,"IDLE")


    asset = "Valerie"
    makeAnimatedLuaSprite(asset, 'ponytown/cameos/Valerie',430,180)
    addAnimationByPrefix(asset,'idle','IDLE',5)
    setProperty(asset..'.antialiasing', false)
    scaleObject(asset,.9,.9)
    setScrollFactor ( asset, .9, .9)
    addLuaSprite(asset)
    playAnim(asset,"IDLE")
end

function onCreatePost()
    setProperty     ( 'boyfriend.antialiasing', false )
    setProperty     ( 'dad.antialiasing', false )
    setProperty     ( 'girlfriend.antialiasing', false )
	setProperty		('darnell.antialising',false )

    triggerEvent('createCharacter', 'pony_biddle', '')
    triggerEvent('createCharacter', 'pony_rareblin', 'true')

    setProperty('pony_biddle.x', getProperty('dad.x')+20)
    setProperty('pony_biddle.y', getProperty('dad.y')-20)

    setProperty('pony_rareblin.x', getProperty('boyfriend.x')-20)
    setProperty('pony_rareblin.y', getProperty('boyfriend.y')-20)

    setObjectOrder('pony_biddle', getObjectOrder('dadGroup'))
    setObjectOrder('pony_rareblin', getObjectOrder('boyfriendGroup'))

    setProperty('pony_rareblin.isPlayer', false) --fix for idle anim

    for i = 0, getProperty('unspawnNotes.length')-1 do
        for j = 0, #characterList-1 do
            if string.find(getPropertyFromGroup('unspawnNotes', i, 'noteType'), getCharNoteType(characterList[j+1])) 
                and not string.find(getPropertyFromGroup('unspawnNotes', i, 'noteType'), "-duet") then 
                setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
            end
        end
    end
end

function onUpdatePost(elapsed)
    setProperty('camGame.targetOffset.x', 0)
    setProperty('camGame.targetOffset.y', 0)
end


function getCharNoteType(char)
    for i = 1, #charToNoteTypeMap do 
        if charToNoteTypeMap[i][1] == char then 
            return charToNoteTypeMap[i][2]
        end
    end
    return ''
end

function onEvent(tag, val1, val2)
    if tag == 'createCharacter' then
        local character = val1
        createInstance(character, "objects.Character", {0, 0, character, val2 == 'true'})
        addInstance(character, true)
        table.insert(characterList, character)
    end
end

function danceCharacters()
	--play idle
    for i = 0, #characterList-1 do 
        if curBeat % getProperty(characterList[i+1]..'.danceEveryNumBeats') == 0 and not getProperty(characterList[i+1]..'.stunned') and getProperty(characterList[i+1]..'.animation.curAnim') then 
            if getProperty(characterList[i+1]..'.animation.curAnim.name') == 'idle' then 
                callMethod(characterList[i+1]..'.dance', {0})
            end
        end
    end
end

function onBeatHit()
    danceCharacters()
end

function onCountdownTick()
    danceCharacters()
end

local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}

local lastHitCharacter = 'hex'
local lastOpponentHitCharacter = 'hex'

function opponentNoteHit(id, noteData, ntype, sus)
    for i = 0, #characterList-1 do 
        if string.find(ntype, getCharNoteType(characterList[i+1])) then 
            --runHaxeCode('game.variables["'..characterList[i+1]..'"].playAnim("'..singAnims[getSingAnim(noteData)]..'", true);')
		    --runHaxeCode('game.variables["'..characterList[i+1]..'"].holdTimer = 0;')
            playAnim(characterList[i+1], singAnims[getMultikeyNoteIndex(noteData)+1], true)
            setProperty(characterList[i+1]..'.holdTimer', 0)
            lastOpponentHitCharacter = characterList[i+1]
        end
    end
end
function goodNoteHit(id, noteData, ntype, su)
    for i = 0, #characterList-1 do 
        if string.find(ntype, getCharNoteType(characterList[i+1])) then 
            playAnim(characterList[i+1], singAnims[getMultikeyNoteIndex(noteData)+1], true)
            setProperty(characterList[i+1]..'.holdTimer', 0)
            lastHitCharacter = characterList[i+1]
        end
    end
end