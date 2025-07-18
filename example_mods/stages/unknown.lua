function onCreate()
	-- magic time--
	makeLuaSprite('unknownBG', 'unknownBG', -450, -100)
	makeLuaSprite('4', '4', -250, -100)
	makeLuaSprite('5', '5', -600, -200)
	makeLuaSprite('7', '7', 0, -150)
	makeLuaSprite('8', '8', -550, -550)
	
	setScrollFactor('unknownBG', 0, 0.3)
	setScrollFactor('4', 0.4, 0.4)
	setScrollFactor('5', 0.6, 0.6)
	setScrollFactor('8', 1.3, 1.3)
	
	scaleObject('4', 1.0, 1.0)
	scaleObject('5', 1.2, 1.2)
	scaleObject('8', 1.5, 1.5)

	addLuaSprite('unknownBG', false)
	for i = 0 , 50 do
		makeLuaSprite(i..'far', 'far', -3000, -3000)
		setScrollFactor(i..'far', 0.2, 0.2)
		addLuaSprite(i..'far', false)
	end
	addLuaSprite('4', false)
	addLuaSprite('5', false)
	for i = 0 , 15 do
		makeLuaSprite(i..'mid', 'mid', -3000, -3000)
		setScrollFactor(i..'mid', 0.6, 0.6)
		scaleObject(i..'mid', 1.2, 1.2)
		addLuaSprite(i..'mid', false)
	end
	addLuaSprite('7', false)
	addLuaSprite('8', false)
	for i = 0 , 10 do
		makeLuaSprite(i..'near', 'near', -3000, -3000)
		setScrollFactor(i..'near', 1.4, 1.4)
		scaleObject(i..'near', 2, 2)
		addLuaSprite(i..'near', true)
	end
	runTimer('particlefar', 25/50, 0)
	runTimer('particlemid', 1, 0)
	runTimer('particlenear', 0.9, 0)
end
constantvalue = 0
pfar = 50
pmid = 15
pnear = 10
cfar = 0
cmid = 0
cnear = 0
rscale = 0

function particleCounter(ptype)
		_G['c'..ptype] = _G['c'..ptype] + 1;
	if _G['c'..ptype] == _G['p'..ptype] then
		_G['c'..ptype] = 0
	end
		setProperty(_G['c'..ptype]..''..ptype..'.x', math.random(-200, 2000))
end

function onUpdate(R)

	constantvalue = constantvalue + R
	
	setProperty('4.y', -100 + 10 * math.sin(constantvalue/1.5))
	setProperty('5.y', -200 + 10 * math.sin(constantvalue/1.3))
	setProperty('8.y', -550 + 30 * math.sin(constantvalue/1.7))
end

rscale = 0
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'particlefar' then
		setProperty(cfar..'far.y', 1000)
		setProperty(cfar..'far.velocity.y' , -50)
		setProperty(cfar..'far.velocity.x' , -0)
		setProperty(cfar..'far.acceleration.x' , math.random(-5, 5))
		particleCounter('far')
	end
	if tag == 'particlemid' then
		setProperty(cmid..'mid.y', 1000)
		setProperty(cmid..'mid.velocity.y' , -100)
		setProperty(cmid..'mid.velocity.x' , -0)
		setProperty(cmid..'mid.acceleration.x' , math.random(-10, 10))
		particleCounter('mid')
	end
	if tag == 'particlenear' then
		setProperty(cnear..'near.y', 1300)
		setProperty(cnear..'near.velocity.y' , -200)
		setProperty(cnear..'near.velocity.x' , -0)
		setProperty(cnear..'near.acceleration.x' , math.random(-20, 20))
		particleCounter('near')
	end
end

