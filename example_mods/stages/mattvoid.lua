function onCreate()
	-- background shit
	makeLuaSprite('whitepeoplebelike', 'whitepeoplebelike', -350, -125);
	setScrollFactor('whitepeoplebelike', 0.2, 0.2);
	scaleObject('whitepeoplebelike', 1.9, 1.9);

	makeLuaSprite('water', 'water', -375, 680);
	setScrollFactor('water', 0.8, 0.8);
	scaleObject('water', 0.9, 0.9);

	makeLuaSprite('platform', 'platform', -375, 680);
	setScrollFactor('platform', 1.0, 1.0);
	scaleObject('platform', 0.9, 0.9);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		
	end

	addLuaSprite('whitepeoplebelike', false);
	addLuaSprite('water', false);
	addLuaSprite('platform', false);
	
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end