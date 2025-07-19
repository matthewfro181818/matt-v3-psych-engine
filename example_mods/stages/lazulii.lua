function onCreatePost()
	setScrollFactor('gfGroup', 0.8, 0.8) 

	setObjectOrder('gfplat', 2);
	setObjectOrder('gfGroup', 3);
	setObjectOrder('ties1', 4);
	setupLighting()
end

function onCreate()
	-- background shit

	makeLuaSprite('space', 'lazulii/vsmattbrokenbackgroundspace', -550, -250);
	setScrollFactor('space', 0.05, 0.05);
	scaleObject('space', 0.8*2, 0.8*2);

	makeLuaSprite('plat1', 'lazulii/vsmattbrokenbackground platform 1', -1295 + 794, -760 + 1088);
	setScrollFactor('plat1', 0.9, 0.9);
	scaleObject('plat1', 2.0, 2.0);

	makeLuaSprite('ties1', 'lazulii/vsmattbrokenbackground ties1', -1295 + 1140, -760 + 1159);
	setScrollFactor('ties1', 0.9, 0.9);
	scaleObject('ties1', 2.0, 2.0);

	makeLuaSprite('mattplat', 'lazulii/vsmattbrokenbackground platform matt', -1295 + 1077, -760 + 1480);
	setScrollFactor('mattplat', 1.0, 1.0);
	scaleObject('mattplat', 1.0, 1.0);

	makeLuaSprite('bfplat', 'lazulii/vsmattbrokenbackground platform bf', -1230 + 1981, -760 + 1127);
	setScrollFactor('bfplat', 1.0, 1.0);
	scaleObject('bfplat', 1.0, 1.0);
	
	makeLuaSprite('gfplat', 'lazulii/vsmattbrokenbackground platform gf', -1230 + 1512, -760 + 1294);
	setScrollFactor('gfplat', 0.8, 0.8);
	scaleObject('gfplat', 2.0, 2.0);

	makeLuaSprite('plat5', 'lazulii/vsmattbrokenbackground platform 5', -1230, -760 + 1759);
	setScrollFactor('plat5', 1.2, 1.2);
	scaleObject('plat5', 2.0, 2.0);

	makeLuaSprite('plat4', 'lazulii/vsmattbrokenbackground platform 4', -1230 + 1482, -800 + 1972);
	setScrollFactor('plat4', 1.2, 1.2);
	scaleObject('plat4', 2.0, 2.0);

	makeLuaSprite('plat3', 'lazulii/vsmattbrokenbackground platform 3', -1230 + 2504, -800 + 1795);
	setScrollFactor('plat3', 1.2, 1.2);
	scaleObject('plat3', 2.0, 2.0);

	makeLuaSprite('plat2', 'lazulii/vsmattbrokenbackground platform 2', -1230 + 283, -800 + 1316);
	setScrollFactor('plat2', 1.0, 1.0);
	scaleObject('plat2', 2.0, 2.0);

	makeLuaSprite('ties3', 'lazulii/vsmattbrokenbackground ties3', -1450, -800 + 1139);
	setScrollFactor('ties3', 1.0, 1.0);
	scaleObject('ties3', 2.0, 2.0);

	makeLuaSprite('ties2', 'lazulii/vsmattbrokenbackground ties2', -1000 + 2704, -800 + 1245);
	setScrollFactor('ties2', 1.2, 1.2);
	scaleObject('ties2', 2.0, 2.0);

	makeLuaSprite('ties4', 'lazulii/vsmattbrokenbackground ties4', -1000 + 2469, -800 + 1444);
	setScrollFactor('ties4', 1.2, 1.2);
	scaleObject('ties4', 2.0, 2.0);

	makeLuaSprite('stars', 'lazulii/vsmattbrokenbackground stars', -1400, -800 + 948);
	setScrollFactor('stars', 1.5, 1.5);
	scaleObject('stars', 2.0, 2.0);

	makeLuaSprite('light', 'lazulii/vsmattbrokenbackground light', -1400, -800);
	setScrollFactor('light', 1.5, 1.5);
	scaleObject('light', 3600.0, 2.0);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		
	end

	addLuaSprite('space', false);
	addLuaSprite('gfplat', false);
	addLuaSprite('plat1', false);
	addLuaSprite('ties1', false);
	addLuaSprite('mattplat', false);
	addLuaSprite('bfplat', false);
	addLuaSprite('plat2', false);
	addLuaSprite('plat5', false);
	addLuaSprite('plat4', false);
	addLuaSprite('plat3', false);
	addLuaSprite('ties3', false);
	addLuaSprite('ties2', false);
	addLuaSprite('ties4', false);
	addLuaSprite('stars', true);
	addLuaSprite('light', true);
end

local sinVal = 0
function onUpdate(elapsed)
    sinVal = sinVal + elapsed * 1.5

    local spritesdad = {'dad', 'mattplat'}
    local spritesbf = {'boyfriend', 'bfplat'}
	local spritesgf = {'gfGroup', 'gfplat'}
	local bgstuff1 = {'plat1'}
	local bgstuff2 = {'plat2'}
	local bgstuff3 = {'plat5', 'plat4', 'plat3'}
	local bgstuff4 = {'ties3', 'ties2', 'ties4', 'ties1'}
	local bgstuff5 = {'stars'}

	for i = 1, #bgstuff1 do
        local sprite = bgstuff1[i]
        setProperty(sprite .. '.x', getProperty(sprite .. '.x') + math.sin(sinVal) * 0)
        setProperty(sprite .. '.y', getProperty(sprite .. '.y') + math.cos(sinVal) * -0.3)
    end

	for i = 1, #bgstuff2 do
        local sprite = bgstuff2[i]
        setProperty(sprite .. '.x', getProperty(sprite .. '.x') + math.sin(sinVal) * 0.1)
        setProperty(sprite .. '.y', getProperty(sprite .. '.y') + math.cos(sinVal) * 0.5)
    end

	for i = 1, #bgstuff3 do
        local sprite = bgstuff3[i]
        setProperty(sprite .. '.x', getProperty(sprite .. '.x') + math.sin(sinVal) * -0.2)
        setProperty(sprite .. '.y', getProperty(sprite .. '.y') + math.cos(sinVal) * -0.1)
    end

	for i = 1, #bgstuff4 do
        local sprite = bgstuff4[i]
        setProperty(sprite .. '.x', getProperty(sprite .. '.x') + math.sin(sinVal) * 0)
        setProperty(sprite .. '.y', getProperty(sprite .. '.y') + math.cos(sinVal) * -0.15)
    end

	for i = 1, #bgstuff5 do
        local sprite = bgstuff5[i]
        setProperty(sprite .. '.x', getProperty(sprite .. '.x') + math.sin(sinVal) * -0.25)
        setProperty(sprite .. '.y', getProperty(sprite .. '.y') + math.cos(sinVal) * -0.25)
    end

	for i = 1, #spritesgf do
        local sprite = spritesgf[i]
        setProperty(sprite .. '.x', getProperty(sprite .. '.x') + math.sin(sinVal) * 1)
        setProperty(sprite .. '.y', getProperty(sprite .. '.y') + math.cos(sinVal) * 0.5)
    end

    for i = 1, #spritesdad do
        local sprite = spritesdad[i]
        setProperty(sprite .. '.x', getProperty(sprite .. '.x') + math.sin(sinVal) * 0.1)
        setProperty(sprite .. '.y', getProperty(sprite .. '.y') + math.cos(sinVal) * 0.1)
    end

    for i = 1, #spritesbf do
        local sprite2 = spritesbf[i]
        setProperty(sprite2 .. '.x', getProperty(sprite2 .. '.x') + math.sin(sinVal) * -0.4)
        setProperty(sprite2 .. '.y', getProperty(sprite2 .. '.y') + math.cos(sinVal) * -0.4)
    end

	if mustHitSection then 
		cameraSetTarget("bf")
	else
		cameraSetTarget("dad")
	end
end


function setupLighting()
	initLuaShader('lightingEffects')
	refreshLighting()
end

function refreshLighting() 
    setSpriteShader('boyfriend', 'lightingEffects')
    setSpriteShader('dad', 'lightingEffects')
    setSpriteShader('gf', 'lightingEffects')

	setShaderFloatArray('boyfriend', 'multiplyColor', {0.0, 0.0, 0.0, 0.0})
	setShaderFloatArray('dad', 'multiplyColor', {0.0, 0.0, 0.0, 0.0})
	setShaderFloatArray('gf', 'multiplyColor', {0.0, 0.0, 0.0, 0.0})
    
    setShaderFloatArray('boyfriend', 'addColor', {0.0, 0.024, 0.26, 0.6})
    setShaderFloatArray('dad', 'addColor', {0.0, 0.024, 0.26, 0.6})
    setShaderFloatArray('gf', 'addColor', {0.0, 0.024, 0.26, 0.7})
end

function onEvent(name, val1, val2) 
	if name == "Change Character" then 
		refreshLighting()
	end
end