function onCreate()
	-- background shit
	makeLuaSprite('Floor', '3hot/Floor', -420, -250);
	setScrollFactor('Floor', 1.0, 1.0);
	scaleObject('Floor', 1.2*1.5, 1.2*1.5);
	
	makeLuaSprite('Wall', '3hot/Wall', -400, -250);
	setScrollFactor('Wall', 0.94, 0.94);
	scaleObject('Wall', 1.2*1.5, 1.2*1.5);

	makeLuaSprite('Trash', '3hot/Trash', -400 + (929*1.2), -250 + (369*1.2));
	setScrollFactor('Trash', 0.94, 0.94);
	scaleObject('Trash', 1.2*1.5, 1.2*1.5);

	makeLuaSprite('Punching_Bag', '3hot/Punching_Bag', -400 + (231*1.2), -250 + (246*1.2));
	setScrollFactor('Punching_Bag', 0.92, 0.92);
	scaleObject('Punching_Bag', 1.2*1.5, 1.2*1.5);

	makeLuaSprite('Boxes', '3hot/Boxes', -420, -250 + (604*1.2));
	setScrollFactor('Boxes', 0.96, 0.96);
	scaleObject('Boxes', 1.2*1.5, 1.2*1.5);

	makeLuaSprite('Boxes2', '3hot/Boxes2', -400 + (1675*1.2), -250 + (604*1.2));
	setScrollFactor('Boxes2', 0.96, 0.96);
	scaleObject('Boxes2', 1.2*1.5, 1.2*1.5);

	makeLuaSprite('Spotlight-Ground', '3hot/Spotlight-Ground', -400 + (220*1.2), -250 + (838*1.2));
	setScrollFactor('Spotlight-Ground', 0.96, 0.96);
	scaleObject('Spotlight-Ground', 1.2*1.5, 1.2*1.5);

	makeLuaSprite('Lightposts', '3hot/Lightposts', -400, -250);
	setScrollFactor('Lightposts', 1.0, 1.0);
	scaleObject('Lightposts', 1.2*1.5, 1.2*1.5);

	makeLuaSprite('Lightposts2', '3hot/Lightposts', -400 + (1290*1.2), -250);
	setProperty('Lightposts2.flipX', true)
	setScrollFactor('Lightposts2', 1.0, 1.0);
	scaleObject('Lightposts2', 1.2*1.5, 1.2*1.5);

	makeLuaSprite('Spotlights', '3hot/Spotlights', -400 + (80*1.2), -248);
	setScrollFactor('Spotlights', 0.94, 0.94);
	scaleObject('Spotlights', 1.2*1.5, 1.2*1.5);

	makeLuaSprite('Foreground', '3hot/Foreground', -450, -250 + (794*1.25));
	setScrollFactor('Foreground', 1.1, 1.1);
	scaleObject('Foreground', 1.25*1.5, 1.25*1.5);

	makeLuaSprite('Ambience', '3hot/Ambience', -420, -250);
	setScrollFactor('Ambience', 1.0, 1.0);
	scaleObject('Ambience', 1.2*1.5, 1.2*1.5);

	addLuaSprite('Floor', false);
	addLuaSprite('Wall', false);
	addLuaSprite('Trash', false);
	addLuaSprite('Punching_Bag', false);
	addLuaSprite('Boxes', false);
	addLuaSprite('Boxes2', false);
	addLuaSprite('Spotlight-Ground', false);
	addLuaSprite('Lightposts', false);
	addLuaSprite('Lightposts2', false);
	addLuaSprite('Spotlights', true);
	addLuaSprite('Foreground', true);
	addLuaSprite('Ambience', true);
end