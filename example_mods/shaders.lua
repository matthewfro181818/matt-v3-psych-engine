--script to easily stack camera shaders and have them be tweenable
--by TheZoroForce240

--stores shader data (name, valueNames, values)
local storedShaders = {}

--stores shader names for each cam
local camGameShaders = {}
local camHUDShaders = {}
local camOtherShaders = {}

function initShader(shaderName, shaderPath, values, defaultValues)
    initLuaShader(shaderPath)

    makeLuaSprite(shaderName, '', 0, 0) --empty sprite to use as a ref
    setSpriteShader(shaderName, shaderPath)  

    for i = 1, #values do --init each value
        makeLuaSprite(shaderName..values[i], '', 0, 0) --empty sprite used for each value 
        setSpriteShader(shaderName..values[i], shaderPath)
        setShaderProperty(shaderName, values[i], defaultValues[i])
        setShaderFloat(shaderName, values[i], defaultValues[i])
    end

    table.insert(storedShaders, {shaderName, values, defaultValues}) --store for later
end 

function setCameraShader(cam, shaderName)
    if string.lower(cam) == 'hud' or string.lower(cam) == 'camhud' then --set for hud shaders
        table.insert(camHUDShaders, shaderName)
        applyCameraFilters(camHUDShaders, 'camHUD')
    elseif string.lower(cam) == 'other' or string.lower(cam) == 'camother' then --set for hud shaders
        table.insert(camOtherShaders, shaderName)
        applyCameraFilters(camOtherShaders, 'camOther')
    else --regular camera
        table.insert(camGameShaders, shaderName)
        applyCameraFilters(camGameShaders, 'camGame')
    end
end

function applyCameraFilters(shaderList, camName)
    if not shadersEnabled then 
        return
    end
    setCameraShaders(camName, shaderList)
end

function setShaderProperty(shaderName, variable, value)
    setProperty(shaderName..variable..'.x', value)
end

function tweenShaderProperty(shaderName, variable, value, time, ease)
    doTweenX(shaderName..variable, shaderName..variable, value, time, ease)
end

function onCreate()
    --[[
    initShader('mirror', 'mirrorRepeat', {'x', 'y', 'zoom', 'angle'}, {0, 0, 1, 0})
    setCameraShader('game', 'mirror')


    initShader('mirror2', 'mirrorRepeat', {'x', 'y', 'zoom', 'angle'}, {0, 0, 1.5, 0})
    setCameraShader('hud', 'mirror2')

    initShader('grey', 'greyscale', {'strength'}, {1.0})
    setCameraShader('game', 'grey')
    setCameraShader('hud', 'grey')

    initShader('ca', 'ca', {'strength'}, {0.005})
    setCameraShader('game', 'ca')
    

    initShader('mosaic', 'mosaic', {'strength'}, {5})
    setCameraShader('game', 'mosaic')
    --setCameraShader('other', 'mosaic')

    setShaderProperty('mirror', 'zoom', 2)
    tweenShaderProperty('mirror', 'zoom', 1, 5, 'cubeOut')
    ]]--
    --if version >= '0.7.0' then 
        --setOnScripts('initShader', initShaderCall, true)
        --setOnScripts('setCameraShader', setCameraShaderCall, true)
        --setOnScripts('setShaderProperty', setShaderProperty, true)
        --setOnScripts('tweenShaderProperty', tweenShaderProperty, true)
    --end
    --debugPrint(scriptName)
end

function updateShaders()
    for i = 1, #storedShaders do 
        local shaderData = storedShaders[i]

        for v = 1, #shaderData[2] do --update values
            local value = getProperty(shaderData[1]..shaderData[2][v]..'.x')
            if value ~= shaderData[3][v] then --only update if needed
                setShaderFloat(shaderData[1], shaderData[2][v], value)
                shaderData[3][v] = value
            end
        end
    end
end
function onUpdatePost(elapsed)
    if not inGameOver then
        updateShaders()
    end
end

--helper funcs-----------

--lua to haxe array
function arrToString(arr)
    local str = '['

    for i = 1, #arr do 
        str = str..'"'..arr[i]..'"'
        if i < #arr then 
            str = str..','
        end
    end

    str = str..']'
    return str
end

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
----------------------