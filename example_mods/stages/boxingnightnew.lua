function onCreate()
	-- background shit
	makeLuaSprite('bg', 'boxingnight_/bg', -500, -125);
	setScrollFactor('bg', 0.7, 0.7);
	scaleObject('bg', 0.9*2, 0.9*2);

	makeLuaSprite('crowd1', 'boxingnight_/crowd1', -500, -325 + 400*0.9);
	setScrollFactor('crowd1', 0.3, 0.3);
	scaleObject('crowd1', 0.9*2, 0.9*2);

	makeLuaSprite('crowd2', 'boxingnight_/crowd2', -500, -325 + 641*0.9);
	setScrollFactor('crowd2', 0.5, 0.5);
	scaleObject('crowd2', 0.9*2, 0.9*2);

	makeLuaSprite('crowd3', 'boxingnight_/crowd3', -500, -325 + 768*0.9);
	setScrollFactor('crowd3', 0.7, 0.7);
	scaleObject('crowd3', 0.9*2, 0.9*2);

	makeLuaSprite('ring', 'boxingnight_/ring', -600, -300 + 484*0.9);
	setScrollFactor('ring', 1.0, 1.0);
	scaleObject('ring', 0.9, 0.9);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		
	end

	addLuaSprite('bg', false);
	addLuaSprite('crowd1', false);
	addLuaSprite('crowd2', false);
	addLuaSprite('crowd3', false);
	addLuaSprite('ring', false);
	
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end