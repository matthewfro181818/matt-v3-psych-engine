local swapNoteCount = 33
local noteGap = 750
local exclusions = ''
function onCreate()
    -- background stuff
    makeLuaSprite('bg', 'swapnote/Background', -400, -250);
    setScrollFactor('bg', 0.25, 0.25);
    scaleObject('bg', 1.333, 1.333);
    addLuaSprite('bg');

    for i = 0, swapNoteCount do 

        local randomIndex = getRandomInt(0, swapNoteCount, exclusions)
        if exclusions == '' then --prevent the same index from being used twice
            exclusions = ''..randomIndex
        else 
            exclusions = exclusions..','..randomIndex
        end

        makeLuaSprite('swapNoteTop'..i, 'swapnote/notes/'..randomIndex, noteGap * i, 0)
        setScrollFactor('swapNoteTop'..i, 0.6, 0.6);
        setGraphicSize('swapNoteTop'..i, 500)
        addLuaSprite('swapNoteTop'..i);

        makeLuaSprite('swapNoteBot'..i, 'swapnote/notes/'..randomIndex, noteGap * (-i + swapNoteCount), 350)
        setScrollFactor('swapNoteBot'..i, 0.6, 0.6);
        setGraphicSize('swapNoteBot'..i, 500)
        addLuaSprite('swapNoteBot'..i)
    end

    makeLuaSprite('stage', 'swapnote/Stage', -550, -150);
    setScrollFactor('stage', 1, 1);
    scaleObject('stage', 1.333, 1.333);
    addLuaSprite('stage');

    makeLuaSprite('doodles', 'swapnote/Doodles', -200, -50);
    setScrollFactor('doodles', 1, 1);
    scaleObject('doodles', 1.333, 1.333);
    addLuaSprite('doodles');

    makeLuaSprite('ui', 'swapnote/UI', 0, 0);
    setGraphicSize('ui', 1280)
    setObjectCamera('ui', 'hud')
    addLuaSprite('ui');
end

local time = 0

function onUpdate(elapsed)
    time = time + elapsed * 50
    if time > noteGap * (swapNoteCount+1) then
        time = time - noteGap * (swapNoteCount+1)
    end

    for i = 0, swapNoteCount do 
        local xPos = (noteGap * i) + time
        if xPos > noteGap * (swapNoteCount+1) then 
            xPos = xPos - (noteGap * (swapNoteCount+1))
        end
        setProperty('swapNoteBot'..i..'.x', xPos - 1000)

        local shit = -xPos + (noteGap * (swapNoteCount+1))

        --[[local xPosTop = (noteGap * (-i + swapNoteCount+1)) - time
        if xPosTop < -noteGap * (swapNoteCount-1) then 
            xPosTop = xPosTop + (noteGap * (swapNoteCount))
        end]]--

        setProperty('swapNoteTop'..i..'.x', shit - 1000)
    end
end