local noteColors = {}

function onCreate()
    -- background setup
    makeLuaSprite('sky', 'nightmare/nightmare_matt_bg_sky', -750, -700);
    setScrollFactor('sky', 0.1, 0.1);
    scaleObject('sky', 2.0, 2.0);
    
    makeLuaSprite('rocks', 'nightmare/nightmare_matt_bg_volcano_rocks', -950, -700 + 1155);
    setScrollFactor('rocks', 1.5, 1.5);
    scaleObject('rocks', 1.25*2, 1.25*2);

    makeLuaSprite('rocks2', 'nightmare/nightmare_matt_bg_volcano_rocks', -950 + (2584*1.25), -700 + 1155);
    setScrollFactor('rocks2', 1.5, 1.5);
    scaleObject('rocks2', 1.25*2, 1.25*2);
    setProperty('rocks2.flipX', true)
    

    makeLuaSprite('volcano', 'nightmare/nightmare_matt_bg_volcano', -750, -800 + 834);
    setScrollFactor('volcano', 0.55, 0.55);
    scaleObject('volcano', 2.0, 2.0);
    
    makeLuaSprite('platform', 'nightmare/nightmare_matt_bg_platform', -750 + 170, -500 + 1187);
    setScrollFactor('platform', 1.0, 1.0);
    scaleObject('platform', 2.0, 2.0);

    -- sprites that only load if Low Quality is turned off
    if not lowQuality then
        -- Add any additional sprites for high quality mode
    end

    addLuaSprite('sky', false);
    addLuaSprite('volcano', false);
    addLuaSprite('platform', false);
    addLuaSprite('rocks', true);
    addLuaSprite('rocks2', true);

    setProperty('skipArrowStartTween', true) --alpha messes with the color transform stuff
end

function getColorStringFromInt(col)
    --lua sucks ass
    local r = bit.band(math.floor(col / 2 ^ 16), 0xff);
    local rStr = callMethodFromClass('StringTools', "hex", {r, 2})
    local g = bit.band(math.floor(col / 2 ^ 8), 0xff);
    local gStr = callMethodFromClass('StringTools', "hex", {g, 2})
    local b = bit.band(col, 0xff);
    local bStr = callMethodFromClass('StringTools', "hex", {b, 2})

    --debugPrint(('0x'..rStr..gStr..bStr))

    return ('0x'..rStr..gStr..bStr)
end

local startBFY = 0;

local colors = {}
local lastAnims = {}

function onCreatePost()
    --initLuaShader('invert')
    initLuaShader('nightmare')
    setSpriteShader('boyfriend', 'nightmare')
    startBFY = getProperty('boyfriend.y');


    --[[for i = 0, getProperty('strumLineNotes.members.length')-1 do 
        table.insert(colors, getPropertyFromGroup('strumLineNotes.members', i, 'rgbShader.r'))
        table.insert(lastAnims, 'static')

        local col = callMethod('strumLineNotes.members['..i..'].getBrightenedPrimaryNoteColor', {0})
            
        makeLuaSprite('noteColorR'..i, ""); 
        setProperty('noteColorR'..i..'.color', getColorFromHex('000000'))
        makeLuaSprite('noteColorG'..i, ""); 
        setProperty('noteColorG'..i..'.color', getColorFromHex(col))
        makeLuaSprite('noteColorB'..i, ""); 
        setProperty('noteColorB'..i..'.color', getColorFromHex(col))
    end

    for i = 0, getProperty('strumLineNotes.members.length')-1 do
        setPropertyFromGroup('strumLineNotes.members', i, 'useColorTransform', true)
        setPropertyFromGroup('strumLineNotes.members', i, 'rgbShader.parent.r', getProperty('noteColorR'..i..'.color'))
        setPropertyFromGroup('strumLineNotes.members', i, 'rgbShader.parent.g', getProperty('noteColorG'..i..'.color'))
        setPropertyFromGroup('strumLineNotes.members', i, 'rgbShader.parent.b', getProperty('noteColorB'..i..'.color'))
    end]]--

    callMethod('setupfoulplayshit', {0})

    setProperty('healthBar.bg.color', getColorFromHex('000000'))
    setTextColor('scoreTxt', '000000')
    setProperty('scoreTxt.borderColor', getColorFromHex('FFFFFF'))

    luaDebugMode = true
end

local forceUpdateShit = 5

function onUpdatePost(elapsed)
    if shadersEnabled and not getPropertyFromClass('states.PlayState', 'instance.isDead') then 
        --shader.frameBounds.value = [parentSprite.frame.uv.x,parentSprite.frame.uv.y,parentSprite.frame.uv.width,parentSprite.frame.uv.height];
        setShaderFloatArray('boyfriend', 'frameBounds', {getProperty('boyfriend.frame.uv.x'), getProperty('boyfriend.frame.uv.y'), getProperty('boyfriend.frame.uv.width'), getProperty('boyfriend.frame.uv.height')})
        setShaderFloatArray('boyfriend', 'frameOffset', {getProperty('boyfriend.frame.offset.x'), getProperty('boyfriend.frame.offset.y')})

        setShaderFloat('boyfriend', 'volcano', (getProperty('boyfriend.y') - startBFY) / 3500)
    end


    if not mustHitSection then 
        cameraSetTarget('dad')
    else 
        cameraSetTarget('bf')
    end

  

    if shadersEnabled and not getPropertyFromClass('states.PlayState', 'instance.isDead') then 
        callMethod('updatefoulplaynotescuzitstooslowinluaandluasucksass', {0})
        --[[
        for i = 0, getProperty('strumLineNotes.members.length')-1 do
            --setPropertyFromGroup('strumLineNotes.members', i, 'rgbShader.enabled', true)
            local anim = getPropertyFromGroup('strumLineNotes.members', i, 'animation.curAnim.name')
            if lastAnims[i+1] ~= anim or forceUpdateShit > 0 then 
                lastAnims[i+1] = anim
                if anim == 'static' then 
                    --setPropertyFromGroup('strumLineNotes.members', i, 'color', getColorFromHex('555555'))
        
                    setSpriteShader('strumLineNotes.members['..i..']', 'invert')
                    setPropertyFromGroup('strumLineNotes.members', i, 'colorTransform.redOffset', -100)
                    setPropertyFromGroup('strumLineNotes.members', i, 'colorTransform.greenOffset', -100)
                    setPropertyFromGroup('strumLineNotes.members', i, 'colorTransform.blueOffset', -100)
                    setPropertyFromGroup('strumLineNotes.members', i, 'colorTransform.redMultiplier', 3)
                    setPropertyFromGroup('strumLineNotes.members', i, 'colorTransform.greenMultiplier', 3)
                    setPropertyFromGroup('strumLineNotes.members', i, 'colorTransform.blueMultiplier', 3)
                else
                    callMethod('strumLineNotes.members['..i..'].setRGBShaderToStrum', {0})
                    setPropertyFromGroup('strumLineNotes.members', i, 'colorTransform.redOffset', 0)
                    setPropertyFromGroup('strumLineNotes.members', i, 'colorTransform.greenOffset', 0)
                    setPropertyFromGroup('strumLineNotes.members', i, 'colorTransform.blueOffset', 0)
                    setPropertyFromGroup('strumLineNotes.members', i, 'colorTransform.redMultiplier', 1)
                    setPropertyFromGroup('strumLineNotes.members', i, 'colorTransform.greenMultiplier', 1)
                    setPropertyFromGroup('strumLineNotes.members', i, 'colorTransform.blueMultiplier', 1)
                end
            end

        end
        ]]--
    end

    --idk it fucking works who cares
    if forceUpdateShit > 5 then 
        forceUpdateShit = forceUpdateShit - 1
    end

    --for i = 0, getProperty('comboGroup.members.length')-1 do
    --    setSpriteShader('comboGroup.members['..i..']', 'invert')
    --end
end

function onBeatHit()
    -- Check if the current beat is the desired beat (e.g., beat 8)
    if curBeat == 368 then
        startVolcanoTween();
    end
end

function tweenShaderProperty(shaderName, variable, value, time, ease)
    doTweenX(shaderName..variable, shaderName..variable, value, time, ease)
end

function startVolcanoTween()
    doTweenY('volcanoTween', 'platform', getProperty('platform.y') + 3500, 8, 'quartOut');
    doTweenY('boyfriendGroup', 'boyfriend', getProperty('boyfriend.y') + 3500, 8, 'quartOut');
    doTweenY('dadGroup', 'dad', getProperty('dad.y') + 3500, 8, 'quartOut');
    tweenShaderProperty('heat', 'strength', 1.2, 8, 'quartOut')
end
function opponentNoteHit(id, d, t, sus)
    cameraShake('game', 0.008, 0.02)
    cameraShake('hud', 0.008, 0.02)
end