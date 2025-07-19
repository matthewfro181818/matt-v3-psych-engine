
local pfar = 50
local pmid = 15
local pnear = 10
local pmax = {pfar, pmid, pnear}
local pcounts = {0, 0, 0}

function onCreate()
	-- magic time--
	makeLuaSprite('unknownBG', 'wiikz/unknownBG', -450, -100)
	makeLuaSprite('4', 'wiikz/4', -250 + 273, -100 + 250)
	makeLuaSprite('5', 'wiikz/5', -600 + 118*1.2, -200 + 378*1.2)
	makeLuaSprite('7left', 'wiikz/platform', 207, -150 + 1074)
	makeLuaSprite('7right', 'wiikz/platform', 1471, -150 + 1074)
	setProperty('7right.flipX', true)

	makeLuaSprite('8l', 'wiikz/8split', 0, -500)
	makeLuaSprite('8r', 'wiikz/8split', 1844*1.2, -500)
	setProperty('8r.flipX', true)
	
	setScrollFactor('unknownBG', 0, 0.3)
	setScrollFactor('4', 0.4, 0.4)
	setScrollFactor('5', 0.6, 0.6)
	setScrollFactor('8l', 1.3, 1.3)
	setScrollFactor('8r', 1.3, 1.3)
	
	scaleObject('unknownBG', 2.0, 2.0)
	scaleObject('4', 2.0, 2.0)
	scaleObject('5', 1.2*2, 1.2*2)
	scaleObject('8l', 1.2*2, 1.2*2)
	scaleObject('8r', 1.2*2, 1.2*2)

	addLuaSprite('unknownBG', false)

	
	if not lowQuality then
		for i = 0 , pfar do
			makeLuaSprite(i..'far', 'wiikz/far', -3000, -3000)
			setScrollFactor(i..'far', 0.2, 0.2)
			addLuaSprite(i..'far', false)
		end
	end

	addLuaSprite('4', false)
	addLuaSprite('5', false)

	if not lowQuality then
		for i = 0 , pmid do
			makeLuaSprite(i..'mid', 'wiikz/mid', -3000, -3000)
			setScrollFactor(i..'mid', 0.6, 0.6)
			scaleObject(i..'mid', 1.2, 1.2)
			addLuaSprite(i..'mid', false)
		end
	end

	addLuaSprite('7left', false)
	addLuaSprite('7right', false)
	addLuaSprite('8l', false)
	addLuaSprite('8r', false)

	if not lowQuality then
		for i = 0 , pnear do
			makeLuaSprite(i..'near', 'wiikz/near', -3000, -3000)
			setScrollFactor(i..'near', 1.4, 1.4)
			scaleObject(i..'near', 2, 2)
			addLuaSprite(i..'near', true)
		end

		runTimer('particlefar', 25/50, 0)
		runTimer('particlemid', 1, 0)
		runTimer('particlenear', 0.9, 0)
	end
end


function onCreatePost()
	setupLighting()
end

function particleCounter(ptype, index)
	pcounts[index] = pcounts[index] + 1
	if pcounts[index] == pmax[index] then
		pcounts[index] = 0
	end

	setProperty(pcounts[index]..''..ptype..'.x', math.random(-200, 2000))
end

local sinVal = 0
local dadSpinX = 0
local dadSpinY = 0
local bfSpinX = 0
local bfSpinY = 0
function onUpdate(elapsed)
    sinVal = sinVal + elapsed * 1.5

    local spritesdad = {'7left'}
    local spritesbf = {'7right'}

    for i = 1, #spritesdad do
        local sprite = spritesdad[i]
        setProperty(sprite .. '.x', getProperty(sprite .. '.x') + math.sin(sinVal) * 0.5)
        setProperty(sprite .. '.y', getProperty(sprite .. '.y') + math.cos(sinVal) * 0.5)
		dadSpinX = dadSpinX + math.sin(sinVal) * 0.5
		dadSpinY = dadSpinY + math.cos(sinVal) * 0.5

		local off = getProperty('dad.positionArray') --should work with character changes???
		setProperty('dad.x', dadSpinX + defaultOpponentX + off[1])
		setProperty('dad.y', dadSpinY + defaultOpponentY + off[2])
    end

    for i = 1, #spritesbf do
        local sprite2 = spritesbf[i]
        setProperty(sprite2 .. '.x', getProperty(sprite2 .. '.x') + math.sin(sinVal) * 0.3)
        setProperty(sprite2 .. '.y', getProperty(sprite2 .. '.y') + math.cos(sinVal) * 0.3)
		bfSpinX = bfSpinX + math.sin(sinVal) * 0.3
		bfSpinY = bfSpinY + math.cos(sinVal) * 0.3

		local off = getProperty('boyfriend.positionArray')
		setProperty('boyfriend.x', bfSpinX + defaultBoyfriendX + off[1])
		setProperty('boyfriend.y', bfSpinY + defaultBoyfriendY + off[2])
    end

	if mustHitSection then 
		cameraSetTarget("bf")
	else
		cameraSetTarget("dad")
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'particlefar' then
		local num = pcounts[1]
		setProperty(num..'far.y', 1000)
		setProperty(num..'far.velocity.y' , -50)
		setProperty(num..'far.velocity.x' , -0)
		setProperty(num..'far.acceleration.x' , math.random(-5, 5))
		particleCounter('far', 1)
	end
	if tag == 'particlemid' then
		local num = pcounts[2]
		setProperty(num..'mid.y', 1000)
		setProperty(num..'mid.velocity.y' , -100)
		setProperty(num..'mid.velocity.x' , -0)
		setProperty(num..'mid.acceleration.x' , math.random(-10, 10))
		particleCounter('mid', 2)
	end
	if tag == 'particlenear' then
		local num = pcounts[3]
		setProperty(num..'near.y', 1300)
		setProperty(num..'near.velocity.y' , -200)
		setProperty(num..'near.velocity.x' , -0)
		setProperty(num..'near.acceleration.x' , math.random(-20, 20))
		particleCounter('near', 3)
	end
end


function setupLighting()
	initLuaShader('lightingEffects')
	refreshLighting()
end

function refreshLighting() 
    setSpriteShader('boyfriend', 'lightingEffects')
    setSpriteShader('dad', 'lightingEffects')

	setShaderFloatArray('boyfriend', 'multiplyColor', {0.0, 0.0, 0.0, 0.0})
	setShaderFloatArray('dad', 'multiplyColor', {0.0, 0.0, 0.0, 0.0})
    
    setShaderFloatArray('boyfriend', 'addColor', {0.06, 0.00, 0.16, 0.5})
    setShaderFloatArray('dad', 'addColor', {0.06, 0.00, 0.16, 0.5})
end

function onEvent(name, val1, val2) 
	if name == "Change Character" then 
		refreshLighting()
	end
end