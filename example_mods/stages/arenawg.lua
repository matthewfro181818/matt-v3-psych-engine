
local lifetime = 3
local counter = 300
local updateTime = lifetime/counter

function onCreatePost()
	makeLuaSprite('sky', 'arenawg_/sky', -450, -500);
	setScrollFactor('sky', 0.1, 0.1);
	scaleObject('sky', 2, 2);
	addLuaSprite('sky', false);

	if songName == "Target Practice WG" then 
		makeLuaSprite('moon', 'arenawg_/moon', -450 + 1574, -300 + 343);
		setScrollFactor('moon', 0.02, 0.02);
		scaleObject('moon', 0.8, 0.8);
		screenCenter('moon', 'x')
		addLuaSprite('moon', false);
	else
		makeLuaSprite('sun', 'arenawg_/sun', -450 + 795 + 200, -300 + 340);
		setScrollFactor('sun', 0.02, 0.02);
		scaleObject('sun', 0.8, 0.8);
		screenCenter('sun', 'x')
		addLuaSprite('sun', false);
	end
	

	for i = 0 , 3 do
		makeLuaSprite('blackBG'..i, 'blackBG', -450, 100 + (i*10));
		setScrollFactor('blackBG'..i, 0.75 - (i*0.1), 0.75 - (i*0.1));
		scaleObject('blackBG'..i, 2560, 2);
		addLuaSprite('blackBG'..i, false);
	end
		
	if not lowQuality then
		for i = 0 , counter do
			makeLuaSprite(i..'mid', 'near', -3000, -3000)
			setProperty(i..'mid.color', 0xFF000000)
			addLuaSprite(i..'mid', false)
		end
	end
			


	makeLuaSprite('ground', 'arenawg_/ground', -450, -100 + 909);
	setScrollFactor('ground', 1.0, 1.0);
	scaleObject('ground', 1, 1);
	addLuaSprite('ground', false);

	--runTimer('particleloop', lifetime/counter, 0)
end

local currentparticle = 0
randoscale = 0

local time = 0
function onUpdate(elapsed)
	if lowQuality then
		return
	end

	time = time + elapsed
	if time > updateTime then 
		time = time - updateTime

		currentparticle = currentparticle + 1;
		if currentparticle == counter then
			currentparticle = 0
		end
		randoscale =  math.random(100, 1000)
		scaleObject(currentparticle..'mid', randoscale/100, randoscale/100);
		setProperty(currentparticle..'mid.y', math.random(600, 1000))
		setProperty(currentparticle..'mid.x', math.random(-700, 1600))
		doTweenX(currentparticle..'midx', currentparticle..'mid.scale', 0, lifetime, 'bounceOut')
		doTweenY(currentparticle..'midy', currentparticle..'mid.scale', 0, lifetime, 'bounceOut')
		setProperty(currentparticle..'mid.velocity.y' , -300 - (randoscale / 4))
		setProperty(currentparticle..'mid.acceleration.y' , 120)
		setScrollFactor(currentparticle..'mid', 0.3 + (randoscale / 1500), 1);
	end
end