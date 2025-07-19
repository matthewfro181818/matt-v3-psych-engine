function onCreate()
	-- background shit
	makeLuaSprite('arenaBG', 'arena-bg', -450, -100);
	setScrollFactor('arenaBG', 0.9, 0.9);
	scaleObject('arenaBG', 0.9, 0.9);
		
	makeLuaSprite('railing', 'railing', -700, 375);
	setScrollFactor('railing', 0.9, 0.9);
	scaleObject('railing', 1.1, 1.1);

	makeAnimatedLuaSprite('bgCharacters','arena-characters',-400,250)
		addAnimationByPrefix('bgCharacters','bop','bg-characters',24,false)
		setLuaSpriteScrollFactor('bgCharacters', 0.9, 0.9)
		scaleObject('bgCharacters', 0.8, 0.8);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		
	end

	addLuaSprite('arenaBG', false);
	addLuaSprite('bgCharacters', false);
	addLuaSprite('railing', false);

	end

function onBeatHit()
	objectPlayAnimation('bgCharacters', 'bop', true)
	
	
end