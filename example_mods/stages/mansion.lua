function initShader(shaderName, shaderPath, values, defaultValues)
    callScript("shaders", "initShader", {shaderName, shaderPath, values, defaultValues})
end
function setCameraShader(cam, shaderName)
    callScript("shaders", "setCameraShader", {cam, shaderName})
end
function setShaderProperty(shaderName, variable, value)
    setProperty(shaderName..variable..'.x', value)
end

function onCreatePost()

	luaDebugMode = true

	if shadersEnabled then 
		addLuaScript('shaders')
		initShader('bloomX', 'LightningBloom', {'strength', 'dirX', 'dirY'}, {0, 1, 0})
		setCameraShader('game', 'bloomX')
		initShader('bloomY', 'LightningBloom', {'strength', 'dirX', 'dirY'}, {0, 0, 1})
		setCameraShader('game', 'bloomY')
		initLuaShader('RainShader')
	end


	
	
	setupSprite('sky', 'gbg/Sky', -500, -1860, 0.1, 1.5)
	addLuaSprite('sky')
	setupSprite('moon', 'gbg/Moon', -200, -250, 0.01, 0.9 * 1.5)
	addLuaSprite('moon')
	setupSprite('trees', 'gbg/Trees', -200, 0, 0.45, 1.5)
	addLuaSprite('trees')

	if not lowQuality and shadersEnabled then 
		makeRainShit(2560, 2500, 0.6, 0.8, 17, 0.4, 0, 0)
		addLuaSprite('rain')
	end


	makeLuaSprite('flash', '', 0, 0)
	makeGraphic('flash', 1, 1)
	setGraphicSize('flash', 2560, 2560)
	updateHitbox('flash')
	screenCenter('flash')
	addLuaSprite('flash')
	setBlendMode('flash', 'add')
	setProperty('flash.alpha', 0)

	setupSprite('bg', 'gbg/Background', -520, -300, 1, 1.5)
	addLuaSprite('bg')
	if not lowQuality and shadersEnabled then 
		setSpriteShader('bg', 'SpriteBlend')
		setShaderFloat('bg', 'blendStrength', 0);
		setShaderSampler2D('bg', 'blendBitmap', 'gbg/Background_lightning')
	end


	setupSprite('eyes', 'gbg/Eyes', -520 + 1563, -300 + 442, 1, 1)
	addLuaSprite('eyes')

	setupSprite('stairs', 'gbg/Stairs', 1600, -200, 1.3, 1.5)
	addLuaSprite('stairs', true)
	if not lowQuality and shadersEnabled then 
		setSpriteShader('stairs', 'SpriteBlend')
		setShaderFloat('stairs', 'blendStrength', 0);
		setShaderSampler2D('stairs', 'blendBitmap', 'gbg/Stairs_lightning')
	end

	setupSprite('shadow', 'gbg/Shadow', -500, -300, 1, 1.5)
	addLuaSprite('shadow', true)
	setBlendMode('shadow', 'multiply')


	makeLuaSprite('darken', '', 0, 0)
	makeGraphic('darken', 1, 1)
	setGraphicSize('darken', 5000, 5000)
	updateHitbox('darken')
	screenCenter('darken')
	addLuaSprite('darken', true)
	setBlendMode('darken', 'subtract')
	setProperty('darken.alpha', 0)
end
function setupSprite(name, path, x, y, scroll, scale)
	makeLuaSprite(name, path, x, y);
	setScrollFactor(name, scroll, scroll);
	scaleObject(name, scale, scale);
end

function makeRainShit(w, h, scroll, scale, speed, alpha, offsetX, offsetY)
	makeLuaSprite('rain', '', 0, 0)
	makeGraphic('rain', 1, 1)
	setGraphicSize('rain', w, h)
	updateHitbox('rain')
	screenCenter('rain')
	setScrollFactor('rain', scroll, scroll);
	if not lowQuality and shadersEnabled then
		setSpriteShader('rain', 'RainShader')
		setShaderFloat('rain', 'width', w);
		setShaderFloat('rain', 'height', h);
		setShaderFloat('rain', 'iTime', 0);
		setShaderFloat('rain', 'offsetX', offsetX);
		setShaderFloat('rain', 'offsetY', offsetY);
		setShaderFloat('rain', 'rainSpeed', speed);
		setShaderFloat('rain', 'rainAlpha', alpha);
		setShaderFloat('rain', 'rainScale', 1/scale);
		--rain.shader = shader;
		setProperty('rain.angle', -5)
		--rain.angle = -5;
		--//rain.alpha = 0.3;
		--rainShaders.push(shader);
	else 
		--rain.alpha = 0;
		setProperty('rain.alpha', 0)
	end
end

local flashActive = false
local iTime = 0
function onUpdate(elapsed)
	iTime = iTime + elapsed
	if not lowQuality and shadersEnabled then 
		setShaderFloat('rain', 'iTime', iTime);
	end

	if flashActive then 
		updateFlashShaders()
	end
end



local lightningStrikeTime = 0;
local lightningTimeOffset = 8000;
local lastMustHitSection = false
function onBeatHit()
	if (flashingLights and getRandomBool(10) and getSongPosition() > lightningStrikeTime + lightningTimeOffset) then
		lightningStrikeMansion();
	end

	if lastMustHitSection ~= mustHitSection then 
		lastMustHitSection = mustHitSection
		local x = 1571
		local y = 447
		if not lastMustHitSection then 
			x = 1563
			y = 442
		end
		doTweenX('eyesX', 'eyes', -520 + x, crochet*0.001*4, 'cubeInOut')
		doTweenY('eyesY', 'eyes', -300 + y, crochet*0.001*4, 'cubeInOut')
	end
end

function lightningStrikeMansion()
	lightningStrikeTime = getSongPosition()
	lightningTimeOffset = getRandomFloat(5000, 10000);
	flashActive = true
	playSound('thunderclap'..getRandomInt(0, 1), 0.4)
	doTweenAlpha('flashStart', 'flash', 1.0, 0.2, 'expoIn')
end
function onTweenCompleted(tag, idk)
	if tag == 'flashStart' then
		doTweenAlpha('flashEnd', 'flash', 0.0, 2, 'linear')
	elseif tag == 'flashEnd' then 
		flashActive = false
		updateFlashShaders()
	end
end

function updateFlashShaders()
	local alpha = getProperty('flash.alpha')
	if not lowQuality and shadersEnabled then
		setShaderProperty('bloomX', 'strength', alpha * 2)
		setShaderProperty('bloomY', 'strength', alpha * 2)
	end

	setProperty('darken.alpha', alpha*0.15)
	
	if not lowQuality and shadersEnabled then
		setShaderFloat('bg', 'blendStrength', alpha);
		setShaderFloat('stairs', 'blendStrength', alpha);
	end
end