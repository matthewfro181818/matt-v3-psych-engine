function onCreate()
	-- background shit
	makeLuaSprite('boxingnight2', 'boxingnight2', -450, -125);
	setScrollFactor('boxingnight2', 0.9, 0.9);
	scaleObject('boxingnight2', 0.9, 0.9);

	makeLuaSprite('boxingnight3', 'boxingnight3', -600, -300);
	setScrollFactor('boxingnight3', 0.9, 0.9);
	scaleObject('boxingnight3', 0.9, 0.9);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		
	end

	addLuaSprite('boxingnight2', false);
	addLuaSprite('boxingnight3', false);
	
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end