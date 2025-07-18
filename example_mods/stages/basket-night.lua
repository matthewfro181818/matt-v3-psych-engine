function onCreate()
    -- background stuff
    makeLuaSprite('bg', 'basket/sky_Night', -1200, -550);
    setScrollFactor('bg', 0.05, 0.05);
    scaleObject('bg', 2.0, 2.0);
    addLuaSprite('bg', false);

    makeLuaSprite('fore', 'basket/grounds_Night', -1200, -700);
    setScrollFactor('fore', 1, 1);
    scaleObject('fore', 2.0, 2.0);
    addLuaSprite('fore', false); 

    makeLuaSprite('overlay', 'basket/overlay_Night', -1200, -700);
    setScrollFactor('overlay', 1, 1);
    scaleObject('overlay', 2.0, 2.0);
    addLuaSprite('overlay', true); 
    setBlendMode('overlay', 'add')

    if isStoryMode then 
		setProperty('skipTransitionOnStoryModeSongEnd', false)
	end
end