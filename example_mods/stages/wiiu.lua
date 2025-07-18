local miiverseSprites = {}
local initialYPositions = {}
local miiverseListLength = 47
local exclusions = ''
local postRefreshTime = 0

function onCreate()
    -- background stuff
    makeLuaSprite('wii_u_bg', 'wiiu/wii_u_bg', -400, -250);
    setScrollFactor('wii_u_bg', 0.25, 0.25);
    scaleObject('wii_u_bg', 1.1, 1.1);

    makeLuaSprite('icons', 'wiiu/icons', -380, -150);
    setScrollFactor('icons', 0.3, 0.3);
    scaleObject('icons', 2.09, 2.09);
    
    makeLuaSprite('wii_u_platform', 'wiiu/wii_u_platform', -450, -200);
    setScrollFactor('wii_u_platform', 1.0, 1.0);
    scaleObject('wii_u_platform', 1.2, 1.2);

    makeLuaSprite('Wii_u_icon', 'wiiu/Wii_u_icon', 20, 0);
    setScrollFactor('Wii_u_icon', 0, 0);
    setObjectCamera('Wii_u_icon', 'hud')
    setGraphicSize('Wii_u_icon', 1280, 0)

    makeLuaSprite('bottom_right_button', 'wiiu/bottom_right_button', 0, 0);
    setScrollFactor('bottom_right_button', 0, 0);
    setObjectCamera('bottom_right_button', 'hud')
    setGraphicSize('bottom_right_button', 1280, 0)

    setProperty('Wii_u_icon.alpha', 0)
    setProperty('bottom_right_button.alpha', 0)

    -- Randomly select three miiverse sprites
    math.randomseed(os.time())

    

    -- Add background sprites
    addLuaSprite('wii_u_bg', false);
    addLuaSprite('icons', false);
    addLuaSprite('wii_u_platform', false);
    addLuaSprite('Wii_u_icon', false);
    addLuaSprite('bottom_right_button', false);

    --removeLuaSprite("gfGroup")

    makePosts()
end

function makePosts()

    miiverseSprites = {}
    initialYPositions = {}

    for _, sprite in ipairs(miiverseSprites) do
        removeLuaSprite(sprite)
    end

    local curY = -100
    for i = 1, 3 do
        local randomIndex = getRandomInt(1, miiverseListLength, exclusions)
        if exclusions == '' then --prevent the same index from being used twice
            exclusions = ''..randomIndex
        else 
            exclusions = exclusions..','..randomIndex
        end

        local spriteName = 'miiverse/'..randomIndex

        local x = -200 + (i - 1) * math.random(450, 550)  -- spread them out horizontally
        curY = curY + math.random(250, 500)
        if curY > 500 then
            curY = curY - 600
        end
        local y = curY
        makeLuaSprite('miiverseSprite' .. i, spriteName, x, y)
        setScrollFactor('miiverseSprite' .. i, 0.35, 0.35)
        scaleObject('miiverseSprite' .. i, 1.0, 1.0)
        setProperty('miiverseSprite'..i..'.alpha', 0)
        doTweenAlpha('miiverseSprite'..i, 'miiverseSprite'..i, 1, 1, 'cubeOut')
        table.insert(miiverseSprites, 'miiverseSprite' .. i)
        table.insert(initialYPositions, y)
    end

    -- Add the randomly selected miiverse sprites
    for _, sprite in ipairs(miiverseSprites) do
        addLuaSprite(sprite, false)
        setObjectOrder(sprite, getObjectOrder('wii_u_platform'))
    end

    postRefreshTime = getRandomFloat(10, 15)
end



function onUpdate(elapsed)
    if postRefreshTime > 0 then 
        postRefreshTime = postRefreshTime - elapsed
        if postRefreshTime <= 0 then 
            makePosts()
        end
    end

    for i, sprite in ipairs(miiverseSprites) do
        local floatOffset = math.sin((getSongPosition() + (i * 500)) / 1000) * 5  -- Slightly offset the phase for each sprite
        setProperty(sprite .. '.y', initialYPositions[i] + floatOffset)
    end
end
