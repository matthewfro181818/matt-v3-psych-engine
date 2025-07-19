local phase = 1
function onCreatePost()
    -- background stuff
    makeLuaSprite('bg', 'wii-fit/wii_trainer_bg_sky_merged', -400, -250);
    setScrollFactor('bg', 0.25, 0.25);
    scaleObject('bg', 1.0, 1.0);
    addLuaSprite('bg', false);

    makeLuaSprite('fore', 'wii-fit/wii_trainer_bg_foreground', -400, -250);
    setScrollFactor('fore', 1, 1);
    scaleObject('fore', 1.0, 1.0);
    addLuaSprite('fore', false);

    makeLuaSprite('board', 'wii-fit/wii_trainer_bg_balance_board', -400 + 955, -250 + 991);
    setScrollFactor('board', 1, 1);
    scaleObject('board', 1.0, 1.0);
    addLuaSprite('board', false);

    makeLuaSprite('screen', 'wii-fit/wii_trainer_bg_screen_light', -400, -250);
    setScrollFactor('screen', 1, 1);
    scaleObject('screen', 1.0, 1.0);
    addLuaSprite('screen', false);    

    setProperty('camGame.zoom', 1)
    makeLuaSprite('intro', 'wii-fit/intro', 0, 0);
	setGraphicSize('intro', 1280)
	screenCenter('intro')
	setObjectCamera('intro', 'camGame')
	addLuaSprite('intro', true);
    setScrollFactor('intro', 0, 0)

    doTweenZoom('camGame', 'camGame', 1.1, crochet*0.001*16, 'cubeInOut')
end

function onSongStart()
	setProperty('camZooming', false)
	--doTweenZoom('camGame', 'camGame', 1.1, crochet*0.001*12, 'cubeOut')
end

function onStepHit()
	if curStep == 64 then 
		setProperty('intro.alpha', 0.001)
        setProperty('camGame.zoom', getProperty('defaultCamZoom'))
	elseif curStep == 48 then
		doTweenZoom('camGame', 'camGame', 5.2, crochet*0.001*3.5, 'cubeIn')
        doTweenY('intro', 'intro', 155, crochet*0.001*3.5, 'cubeIn')
        --cameraFade('game', 'FFFFFF', crochet*0.001*3.5)f
	end
end

function onUpdatePost(elapsed)
    if phase == 1 then 
        setProperty('boyfriend.visible', false)
        cameraSetTarget('dad')
    end
end