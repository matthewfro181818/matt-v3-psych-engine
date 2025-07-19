function onCreate()
	-- background shit
	makeLuaSprite('3hot1', '3hot1', -450, -200);
	setScrollFactor('3hot1', 1.0, 1.0);
	scaleObject('3hot1', 0.9, 0.9);
	
	makeLuaSprite('3hot2', '3hot2', -450, -200);
	setScrollFactor('3hot2', 0.96, 0.96);
	scaleObject('3hot2', 0.9, 0.9);

	makeLuaSprite('3hot3', '3hot3', -450, -200);
	setScrollFactor('3hot3', 0.98, 0.98);
	scaleObject('3hot3', 0.9, 0.9);
	
	makeLuaSprite('3hot4', '3hot4', -450, -200);
	setScrollFactor('3hot4', 0.98, 0.98);
	scaleObject('3hot4', 0.9, 0.9);
	
	makeLuaSprite('3hot5', '3hot5', -450, -200);
	setScrollFactor('3hot5', 1.0, 1.0);
	scaleObject('3hot5', 0.9, 0.9);

	makeLuaSprite('3hot6', '3hot6', -450, -200);
	setScrollFactor('3hot6', 1.03, 1.03);
	scaleObject('3hot6', 0.9, 0.9);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		
	end

	addLuaSprite('3hot1', false);
	addLuaSprite('3hot2', false);
	addLuaSprite('3hot3', false);
	addLuaSprite('3hot4', false);
	addLuaSprite('3hot5', false);
	addLuaSprite('3hot6', false);

	end

function onBeatHit()
	objectPlayAnimation('bgCharacters', 'bop', true)
	
	
end