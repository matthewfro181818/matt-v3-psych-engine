function onCreate()
	-- background shit
	makeLuaSprite('Sky', 'been-patient/Sky', -500, -250);
	setScrollFactor('Sky', 0.05, 0.5);
	scaleObject('Sky', 1.0, 1.0);

	makeLuaSprite('Clouds', 'been-patient/Clouds', -700, -270);
	setScrollFactor('Clouds', 0.1, 0.1);
	scaleObject('Clouds', 1.0, 1.0);

	makeLuaSprite('Sun2', 'been-patient/Sun2', -400, -270);
	setScrollFactor('Sun2', 0.07, 0.07);
	scaleObject('Sun2', 1.0, 1.0);

	makeLuaSprite('Sun1', 'been-patient/Sun1', 255, 150);
	setScrollFactor('Sun1', 0.07, 0.07);
	scaleObject('Sun1', 1.0, 1.0);

	for i = 1, 24 do 
		local n = 'bar'..i
		makeLuaSprite(n, 'been-patient/VisualizerBar', -190 + (i * 80), 450);
		setScrollFactor(n, 0.35, 0.35);
		scaleObject(n, 1.0, 1.0);
	end

	makeLuaSprite('Ground', 'been-patient/Ground', -600, 350);
	setScrollFactor('Ground', 0.4, 0.4);
	scaleObject('Ground', 1.0, 1.0);

	makeLuaSprite('EmptyBar', 'been-patient/EmptyBar', 1370, 440);
	setScrollFactor('EmptyBar', 0.47, 0.47);
	scaleObject('EmptyBar', 1.0, 1.0);

	makeLuaSprite('FullBar', 'been-patient/FullBar', 1370, 440);
	setScrollFactor('FullBar', 0.47, 0.47);
	scaleObject('FullBar', 1.0, 1.0);

	makeLuaSprite('Timer', 'been-patient/Timer', 1300, 250);
	setScrollFactor('Timer', 0.47, 0.47);
	scaleObject('Timer', 1.0, 1.0);

	makeLuaSprite('Platform', 'been-patient/Platform', -200, 740);
	setScrollFactor('Platform', 1.0, 1.0);
	scaleObject('Platform', 1.0, 1.0);

	addLuaSprite('Sky', false);
	addLuaSprite('Clouds', false);
	addLuaSprite('Sun2', false);
	addLuaSprite('Sun1', false);
	if not lowQuality then
		for i = 1, 24 do
			addLuaSprite('bar'..i);
		end
	end
	addLuaSprite('Ground', false);
	addLuaSprite('EmptyBar', false);
	addLuaSprite('FullBar', false);
	addLuaSprite('Timer', false);
	addLuaSprite('Platform', false);

	initLuaShader('uvMask')
	setSpriteShader('FullBar', 'uvMask')
	setShaderFloat('FullBar', 'xPercent', 0.0)
	setShaderFloat('FullBar', 'yPercent', 1.0)
	setShaderSampler2D('FullBar', 'mask', 'been-patient/BarMask')
end

function onCreatePost()
	setupLighting()
end

function setupLighting()
	initLuaShader('lightingEffects')
	refreshLighting()
end

function refreshLighting() 
    setSpriteShader('boyfriend', 'lightingEffects')
    setSpriteShader('dad', 'lightingEffects')

	setShaderFloatArray('boyfriend', 'multiplyColor', {0.0, 0.0, 0.0, 0.0})
	setShaderFloatArray('dad', 'multiplyColor', {0.0, 0.0, 0.0, 0.0})
    
    setShaderFloatArray('boyfriend', 'addColor', {0.29, 0.02, 0.23, 0.4})
    setShaderFloatArray('dad', 'addColor', {0.29, 0.02, 0.23, 0.4})
end

local vizStart = false
function onSongStart()

	if not lowQuality then
		--hardcoded func (for anyone looking where the fuck this is from) 
		initAnalyzer(24, 0.025, 50)
		vizStart = true
	end

end


function onUpdatePost(elapsed)
	setShaderFloat('FullBar', 'xPercent', getSongPosition() / getProperty('songLength'))

	if vizStart then 
		local levels = getAudioLevels()

		for i = 1, #levels do 
			local n = 'bar'..i
			scaleObject(n, 1.0, levels[i]*1.5);
			setProperty(n..'.y', 725 - getProperty(n..'.height'))
		end
	end

end