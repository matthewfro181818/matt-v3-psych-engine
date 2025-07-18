function onCreate()
	makeLuaSprite('bg', 'fisticuffs_/BG', -450, -100);
	setScrollFactor('bg', 1.0, 1.0);

	addLuaSprite('bg', false);

	if isStoryMode then 
		setProperty('skipTransitionOnStoryModeSongEnd', false)
	end
end
