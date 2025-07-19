function onCreate()
	makeLuaSprite('battlefield1', 'battlefield/Sky', -450, -250);
	setScrollFactor('battlefield1', 0.05, 0.05);
	scaleObject('battlefield1', 1.25*1.5, 1.25*1.5);

	makeLuaSprite('battlefield2', 'battlefield/Moon', -450 + (528*1.25), -200);
	setScrollFactor('battlefield2', 0.05, 0.05);
	scaleObject('battlefield2', 1.25, 1.25);

	makeLuaSprite('battlefield3', 'battlefield/Bg_colliseum', -450 + (1256*1.25), -250);
	setScrollFactor('battlefield3', 0.4, 0.4);
	scaleObject('battlefield3', 1.25*1.5, 1.25*1.5);

	makeLuaSprite('battlefield4', 'battlefield/Ruins', -450 + (972*1.25), -200 + (296*1.25));
	setScrollFactor('battlefield4', 0.7, 0.7);
	scaleObject('battlefield4', 1.25*1.5, 1.25*1.5);

	makeLuaSprite('battlefield5', 'battlefield/mini_islands', -450 + (54*1.25), -250 + (49*1.25));
	setScrollFactor('battlefield5', 0.2, 0.2);
	scaleObject('battlefield5', 1.25*1.5, 1.25*1.5);

	makeLuaSprite('battlefield6', 'battlefield/flag_2', -440 + (1198*1.25), -200 + (391*1.25));
	setScrollFactor('battlefield6', 0.7, 0.7);
	scaleObject('battlefield6', 1.25*1.5, 1.25*1.5);

	makeLuaSprite('battlefield7', 'battlefield/flag_1', -450 + (1455*1.25), -200 + (393*1.25));
	setScrollFactor('battlefield7', 0.7, 0.7);
	scaleObject('battlefield7', 1.25*1.5, 1.25*1.5);

	makeLuaSprite('battlefield8', 'battlefield/bg_island', -450, -250 + (351 * 1.25));
	setScrollFactor('battlefield8', 0.4, 0.4);
	scaleObject('battlefield8', 1.25*1.5, 1.25*1.5);

	makeLuaSprite('battlefield9', 'battlefield/fod_foreground', -450, -400 + (574*1.4));
	setScrollFactor('battlefield9', 1.0, 1.0);
	scaleObject('battlefield9', 1.4*1.5, 1.4*1.5);
	setProperty('battlefield9.alpha', 0.5)

	makeLuaSprite('battlefield10', 'battlefield/Battledield', -450, -200 + (531*1.25));
	setScrollFactor('battlefield10', 1.0, 1.0);
	scaleObject('battlefield10', 1.25, 1.25);

	makeLuaSprite('battlefield11', 'battlefield/fog_bg', 0, -200 + (797*1.4));
	setScrollFactor('battlefield11', 1.0, 1.0);
	scaleObject('battlefield11', 1.4*1.5, 1.4*1.5);
	setProperty('battlefield9.alpha', 0.5)

	addLuaSprite('battlefield1', false);
	addLuaSprite('battlefield2', false);
	addLuaSprite('battlefield3', false);
	addLuaSprite('battlefield4', false);
	addLuaSprite('battlefield5', false);
	addLuaSprite('battlefield6', false);
	addLuaSprite('battlefield7', false);
	addLuaSprite('battlefield8', false);
	addLuaSprite('battlefield11', false);
	addLuaSprite('battlefield10', false);
	addLuaSprite('battlefield9', true);
end