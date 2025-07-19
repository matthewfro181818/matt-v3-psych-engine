function onCreate()
	-- background shit
	makeLuaSprite('n2', 'miifunkin/bg', -1050, -450);
	setScrollFactor('n2', 1.0, 1.0);
	scaleObject('n2', 1.2, 1.2);
	addLuaSprite('n2', false);

	makeAnimatedLuaSprite('n1', 'miifunkin/BgFriiks_BLU', -700, -150);
	addAnimationByPrefix('n1', 'bgfriiks', 'bgfriiks', 24, false)
	setScrollFactor('n1', 1.0, 1.0);
	scaleObject('n1', 1.1, 1.1);
	addLuaSprite('n1', false);
	
	makeAnimatedLuaSprite('n3', 'miifunkin/ForegroundMiis_BLU', -1700, 500);
	addAnimationByPrefix('n3', 'FOREMIIS', 'FOREMIIS', 24, false)
	setScrollFactor('n3', 1.9, 1.9);
	scaleObject('n3', 2, 2);
	addLuaSprite('n3', true);

	--makeLuaSprite('n4', 'miifunkin/ui', -320, -190);
	--setScrollFactor('n4', 0.0, 0.0);
	--setGraphicSize('n4', 1400)
	--screenCenter('n4')
	--setObjectCamera('n4', 'hud')
	--addLuaSprite('n4', false);	
end

function onBeatHit()
	playAnim('n1', 'bgfriiks')
	playAnim('n3', 'FOREMIIS')
end