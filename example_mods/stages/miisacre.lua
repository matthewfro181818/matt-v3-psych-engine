function onCreate()
	-- background shit
	makeLuaSprite('n2', 'miisacre/Stage', -450, -180);
	setScrollFactor('n2', 1.0, 1.0);
	scaleObject('n2', 1.1, 1.1);

	makeAnimatedLuaSprite('Bro', 'miisacre/TheBroInFront', 440, 300)
	addAnimationByPrefix('Bro', 'Idle', 'Idle', 24, true)
	addAnimationByPrefix('Bro', 'Shoot', 'Shoot', 24, false)
	objectPlayAnimation('Bro', 'Idle', false);
	setLuaSpriteScrollFactor('Bro', 1.0, 1.0)
	scaleObject('Bro', 0.8, 0.8);

	addLuaSprite('Bro', true);
	addLuaSprite('n2', false);

	

	makeLuaSprite('m1', 'miisacre/MiisacreRoom', -50, 50);
	setScrollFactor('m1', 1.0, 1.0);
	scaleObject('m1', 0.6, 0.6);
	addLuaSprite('m1', false);

	makeLuaSprite('m2', 'miisacre/MiisacreTV', -50, 50);
	setScrollFactor('m2', 1.0, 1.0);
	scaleObject('m2', 0.6, 0.6);
	addLuaSprite('m2', true);

	makeLuaSprite('m3', 'miisacre/shadows', -50, 50);
	setScrollFactor('m3', 1.0, 1.0);
	scaleObject('m3', 0.6, 0.6);
	addLuaSprite('m3', true);
end

function onStepHit()

	if curStep == 1934 then 
		objectPlayAnimation('Bro', 'Shoot', true)
		setProperty('Bro.x', getProperty('Bro.x') - 100)
		setProperty('Bro.y', getProperty('Bro.y') - 100)
	end
	--objectPlayAnimation('Bro', 'Idle', true)
end

function onUpdatePost(elapsed)
	local playerAlpha = 0.001
	local oppAlpha = 1
	if mustHitSection then 
		oppAlpha = 0.001
		playerAlpha = 1
	end

	setProperty('dad.alpha', oppAlpha)
	setProperty('Bro.alpha', oppAlpha)
	setProperty('n2.alpha', oppAlpha)

	setProperty('boyfriend.alpha', playerAlpha)
	setProperty('m1.alpha', playerAlpha)
	setProperty('m2.alpha', playerAlpha)
	setProperty('m3.alpha', playerAlpha)
end