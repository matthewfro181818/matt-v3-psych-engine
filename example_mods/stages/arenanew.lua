function onCreate()
	-- background shit
	makeLuaSprite('skyBG', 'arena_/skyBG', -450, -175);
	setScrollFactor('skyBG', 0.3, 0.3);
	scaleObject('skyBG', 0.9, 0.9);
	
	makeLuaSprite('standsBG', 'arena_/standsBG', -450, -225);
	setScrollFactor('standsBG', 0.47, 0.47);
	scaleObject('standsBG', 0.9, 0.9);
	--[[
	makeLuaSprite('backgroundCharacters3Left', 'arena_/backgroundCharacters3Left', -400, 130);
	setScrollFactor('backgroundCharacters3Left', 0.47, 0.47);
	scaleObject('backgroundCharacters3Left', 0.9, 0.9);

	makeLuaSprite('backgroundCharacters3Right', 'arena_/backgroundCharacters3Right', 900, 120);
	setScrollFactor('backgroundCharacters3Right', 0.47, 0.47);
	scaleObject('backgroundCharacters3Right', 0.9, 0.9);
	
	makeLuaSprite('backgroundCharacters2Left', 'arena_/backgroundCharacters2Left', -357, 230);
	setScrollFactor('backgroundCharacters2Left', 0.47, 0.47);
	scaleObject('backgroundCharacters2Left', 0.9, 0.9);

	makeLuaSprite('backgroundCharacters2Right', 'arena_/backgroundCharacters2Right', 875, 220);
	setScrollFactor('backgroundCharacters2Right', 0.47, 0.47);
	scaleObject('backgroundCharacters2Right', 0.9, 0.9);

	makeLuaSprite('backgroundCharactersLeft', 'arena_/backgroundCharactersLeft', -350, 290);
	setScrollFactor('backgroundCharactersLeft', 0.47, 0.47);
	scaleObject('backgroundCharactersLeft', 0.9, 0.9);

	makeLuaSprite('backgroundCharactersRight', 'arena_/backgroundCharactersRight', 850, 280);
	setScrollFactor('backgroundCharactersRight', 0.47, 0.47);
	scaleObject('backgroundCharactersRight', 0.9, 0.9);
	]]--
	setupCrowd(6, 900, 120)
	setupCrowd(5, -400, 130)
	setupCrowd(4, -357, 230)
	setupCrowd(3, 875, 220)
	setupCrowd(1, -350, 290+10)
	setupCrowd(2, 850, 250+60)

	--makeAnimatedLuaSprite('bgCharacters','BG1_chs',-430,80)
	--addAnimationByPrefix('bgCharacters','bgCharacters','BG1_chs bopping',24,true)
	--objectPlayAnimation('bgCharacters','BG1_chs bopping',false);
	--setLuaSpriteScrollFactor('bgCharacters', 0.5, 0.5)
	--scaleObject('bgCharacters', 0.8, 0.8);

	makeLuaSprite('railingnew', 'arena_/railingBG', -450, -200);
	setScrollFactor('railingnew', 0.52, 0.52);
	scaleObject('railingnew', 0.9, 0.9);
	
	
	makeLuaSprite('groundBG', 'arena_/groundBG', -450, -100);
	setScrollFactor('groundBG', 1.0, 1.0);
	scaleObject('groundBG', 0.9, 0.9);

	addLuaSprite('skyBG', false);
	addLuaSprite('standsBG', false);

	addLuaSprite('crowd6', false);
	addLuaSprite('crowd5', false);
	addLuaSprite('crowd4', false);
	addLuaSprite('crowd3', false);
	addLuaSprite('crowd2', false);
	addLuaSprite('crowd1', false);

	addLuaSprite('bgCharacters', false);
	addLuaSprite('railingnew', false);
	addLuaSprite('groundBG', false);

end

function setupCrowd(num, x, y)

	makeAnimatedLuaSprite('crowd'..num, 'arena_/crowd', x, y)
	addAnimationByPrefix('crowd'..num, 'crowd '..num, 'crowd '..num, 24, false)
	setScrollFactor('crowd'..num, 0.47, 0.47);
	scaleObject('crowd'..num, 0.9, 0.9);
end
local bop = 0
function onBeatHit()
	if curBeat % 2 == 0 then 
		for i = 1, 6 do
			objectPlayAnimation('crowd'..i, 'crowd '..i, true)
		end
	end
	--objectPlayAnimation('bgCharacters', 'BG1_chs bopping', true)
end

function onCountdownTick(swagCounter)
	if swagCounter < 2 then 
		for i = 1, 6 do
			objectPlayAnimation('crowd'..i, 'crowd '..i, true)
		end
	end

end