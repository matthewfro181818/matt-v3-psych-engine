function onCreatePost()
	-- background shit
	makeLuaSprite('n2', 'motioncontrol/Corrupted_Mii', -550, -315);
	setScrollFactor('n2', 0.5, 0.5);
	scaleObject('n2', 0.95, 0.95);
	
	makeLuaSprite('n3', 'motioncontrol/Dark Static', -500, -150);
	setScrollFactor('n3', 0.65, 0.65);
	scaleObject('n3', 0.95, 0.95);

	makeLuaSprite('n1', 'motioncontrol/Glitched Ring', -760, 15);
	setScrollFactor('n1', 1.0, 1.0);
	scaleObject('n1', 1.1, 1.1);

	makeLuaSprite('n7', 'motioncontrol/Screen Light', -300, -170);
	setScrollFactor('n7', 0, 0);
	scaleObject('n7', 0.73, 0.73);

	makeLuaSprite('n6', 'motioncontrol/Scrren Shadow', 0, 0);
	setGraphicSize('n6', 1280/0.92)
	screenCenter('n6')
	setObjectCamera('n6', 'camHUD')

	makeLuaSprite('n5', 'motioncontrol/TV Scanlines', 0, 0);
	setGraphicSize('n5', 1280/0.92)
	screenCenter('n5')
	setObjectCamera('n5', 'camHUD')
	
	makeLuaSprite('n4', 'motioncontrol/TV Overlay', 0, 0);
	setGraphicSize('n4', 1280/0.92)
	screenCenter('n4')
	setObjectCamera('n4', 'camHUD')

	addLuaSprite('n2', false);
	addLuaSprite('n3', false);
	addLuaSprite('n1', false);
	addLuaSprite('n7', true);
	addLuaSprite('n6', true);
	addLuaSprite('n5', true);
	addLuaSprite('n4', true);
	
	setProperty('defaultHUDZoom', 0.92)


	makeLuaSprite('introTV', 'motioncontrol/tvIntro', 0, 0);
	setGraphicSize('introTV', 1280/0.92)
	screenCenter('introTV')
	setObjectCamera('introTV', 'camHUD')
	addLuaSprite('introTV', true);
	setObjectCamera('title', 'other')
    for i = 0, 10 do
        setObjectCamera('introBar'..i, 'other')
    end
end

function onSongStart()
	setProperty('camZooming', false)
	doTweenZoom('camHUD', 'camHUD', 1.25, crochet*0.001*12, 'cubeIn')
end

function onStepHit()
	if curStep == 64 then 
		setProperty('introTV.alpha', 0.001)
	elseif curStep == 48 then 
		doTweenZoom('camHUD', 'camHUD', 4, crochet*0.001*4, 'cubeInOut')
	end
end