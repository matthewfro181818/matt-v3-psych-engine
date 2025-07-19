local fov = 90 * (math.pi/180) --90 deg
--https://github.com/openfl/openfl/blob/develop/src/openfl/geom/PerspectiveProjection.hx
local focalLength = 250.0 * (1.0 / math.tan(fov * 0.5));

local perspectiveMatrix = 
{
	focalLength, 0, 0, 0,
	0, focalLength, 0, 0,
	0, 0, 1.0, 1.0,
	0, 0, 0, 0
}
local eye = {0, 0, -150, 0};
local lookAt = {0, 0, 1, 0};
local up = {0, 1, 0, 0}
local viewMatrix = {}

local right = {1, 0, 0, 0}
local upv = {0, 1, 0, 0}
local forward = {0, 0, 1, 0}

function updateViewMatrix()

    forward = {(lookAt[1] - eye[1]), (-lookAt[2] - -eye[2]), (lookAt[3] - eye[3]), 0};
    forward = normalize(forward);

    right = cross(up, forward);
	right = normalize(right);
    upv = cross(forward, right);
    local negEye = {-eye[1], eye[2], -eye[3], -eye[4]};
    viewMatrix = 
	{
		right[1], upv[1], forward[1], 0,
		right[2], upv[2], forward[2], 0,
		right[3], upv[3], forward[3], 0,
		dot(right, negEye), dot(upv, negEye), dot(forward, negEye), 1
	};
end
function normalize(vec)
	local mag = math.sqrt((vec[1] * vec[1]) + (vec[2] * vec[2]) + (vec[3] * vec[3]) + (vec[4] * vec[4]) );
	vec[1] = vec[1] / mag;
	vec[2] = vec[2] / mag;
	vec[3] = vec[3] / mag;
	vec[4] = vec[4] / mag;
    return vec;
end
function cross(vec1, vec2)
	local vec = {0, 0, 0, 1}
	vec[1] = vec1[2] * vec2[3] - vec1[3] * vec2[2];
	vec[2] = vec1[3] * vec2[1] - vec1[1] * vec2[3];
	vec[3] = vec1[1] * vec2[2] - vec1[2] * vec2[1];
	return vec;
end
function dot(vec1, vec2)
    return vec1[1] * vec2[1] + vec1[2] * vec2[2] + vec1[3] * vec2[3];
end
function setupPerspectiveSprite(spr, shader)
	if not shadersEnabled then 
		return
	end
	setSpriteShader(spr, shader)
	setShaderFloatArray(spr, 'viewMatrix', viewMatrix)
	setShaderFloatArray(spr, 'perspectiveMatrix', perspectiveMatrix)
	setShaderFloat(spr, 'zOffset', 1)
	setShaderFloatArray(spr, 'vertexXOffset', {0.0, 0.0, 0.0, 0.0})
	setShaderFloatArray(spr, 'vertexYOffset', {0.0, 0.0, 0.0, 0.0})
	setShaderFloatArray(spr, 'vertexZOffset', {0.0, 0.0, 0.0, 0.0})
end

local flying = true
local finalPhase = false

function onCreatePost()

	if shadersEnabled then 
		updateViewMatrix()
	end
	

	makeAnimatedLuaSprite('mattSplash', 'eclipsewg_/impact', getProperty('dad.x')-800, getProperty('dad.y')-800)
	scaleObject('mattSplash', 2.5, 2.5)
	addAnimationByPrefix('mattSplash', 'Matt', 'Matt', 12, false)
	playAnim('mattSplash', 'Matt')
	

	makeAnimatedLuaSprite('bfSplash', 'eclipsewg_/impact', getProperty('mattSplash.x') + 800, getProperty('mattSplash.y'))
	scaleObject('bfSplash', 2.5, 2.5)
	addAnimationByPrefix('bfSplash', 'BF', 'BF', 12, false)
	playAnim('bfSplash', 'BF')


	makeLuaSprite('space', 'eclipsewg_/spaceCombined', -1900, -1350);
	setScrollFactor('space', 0.1, 0.1);
	scaleObject('space', 3, 3);

	makeLuaSprite('spaceE', 'eclipsewg_/spaceCombinedEmpty', -1300, -750);
	setScrollFactor('spaceE', 0.03, 0.03);
	scaleObject('spaceE', 2, 2);

	setProperty('dad.x', getProperty('dad.x') + 750)
	setProperty('boyfriend.x', getProperty('boyfriend.x') - 750)



	setupPerspectiveSprite('dad', 'perspective')
	setupPerspectiveSprite('boyfriend', 'perspective')
	

	--initLuaShader('eclipsebg')
    --setSpriteShader('space', 'eclipsebg')
	--setShaderSampler2D('space', 'sun1', 'eclipsewg_/sun1')
	--setShaderSampler2D('space', 'sun2', 'eclipsewg_/sun2')

	makeLuaSprite('wiikz', 'eclipsewg_/wiikz', -1050 + 28, -100 + 1123);
	setScrollFactor('wiikz', 0.6, 1);
	scaleObject('wiikz', 2, 2);

	makeLuaSprite('bluematt', 'eclipsewg_/bluematt', -1050 + 4429, -100 + 1174);
	setScrollFactor('bluematt', 0.6, 1);
	scaleObject('bluematt', 2, 2);

	makeLuaSprite('moon', 'eclipsewg_/moon', -450 + 894, -100 + 1926);
	setScrollFactor('moon', 1.0, 1.0);
	scaleObject('moon', 2, 2);

	addLuaSprite('spaceE', false);

	makeLuaSprite('trailMatt', 'eclipsewg_/beamred', getProperty('dad.x')+150, getProperty('dad.y')+270)
	setupPerspectiveSprite('trailMatt', 'perspectiveBeam')
	if shadersEnabled then 
		setShaderFloatArray('trailMatt', 'vertexYOffset', {450.0, 450.0, 0.0, 0.0})
		setShaderFloatArray('trailMatt', 'vertexZOffset', {0.0, 50000.0*150, 0.0, 50000.0*150})
		addLuaSprite('trailMatt', false)
	end

	makeLuaSprite('trailBF', 'eclipsewg_/beamblue', getProperty('boyfriend.x')+70, getProperty('boyfriend.y')-20)
	setupPerspectiveSprite('trailBF', 'perspectiveBeam')
	if shadersEnabled then 
		setShaderFloatArray('trailBF', 'vertexYOffset', {450.0, 450.0, 0.0, 0.0})
		setShaderFloatArray('trailBF', 'vertexZOffset', {0.0, 50000.0*150, 0.0, 50000.0*150})
		addLuaSprite('trailBF', false)
	end
	


	setProperty('space.alpha', 0.001)
	setProperty('wiikz.alpha', 0.001)
	setProperty('bluematt.alpha', 0.001)
	setProperty('moon.alpha', 0.001)
	addLuaSprite('space', false);
	addLuaSprite('wiikz', false);
	addLuaSprite('bluematt', false);
	addLuaSprite('moon', false);
	
	setupFinalPhase()


	addCharacterToList('wgmatt2', 'dad')
	addCharacterToList('wgbf', 'bf')
	addCharacterToList('wgmatt-final', 'dad')
	addCharacterToList('wgbf-final', 'bf')

	addLuaSprite('mattSplash', true)
	addLuaSprite('bfSplash', true)

	setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/bmwg1');
	setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'wgbf-fly-dead');

	--endFly()
	--beginFinalPhase()
end

local iTime = 0
local sinVal = 0
function onUpdate(elapsed)
	if curStep == 2816 then
		--setProperty('defaultCamZoom', 0.3)
	end
	
	iTime = iTime + elapsed
    sinVal = sinVal + elapsed * 1.5

	local bgstuff1 = {'wiikz'}
	local bgstuff2 = {'bluematt'}

	for i = 1, #bgstuff1 do
        local sprite = bgstuff1[i]
        setProperty(sprite .. '.x', getProperty(sprite .. '.x') + math.sin(sinVal) * 0)
        setProperty(sprite .. '.y', getProperty(sprite .. '.y') + math.cos(sinVal) * -0.3)
    end

	for i = 1, #bgstuff2 do
        local sprite = bgstuff2[i]
        setProperty(sprite .. '.x', getProperty(sprite .. '.x') + math.sin(sinVal) * 0.1)
        setProperty(sprite .. '.y', getProperty(sprite .. '.y') + math.cos(sinVal) * 0.5)
    end

	if flying then 
		setShaderFloat('trailMatt', 'iTime', -iTime*2.5)
	end


	if finalPhase then 
		updateFinalPhase(elapsed)
	end
end

function endFly()
	flying = false
	setProperty('spaceE.alpha', 0.001)
	removeLuaSprite('trailMatt')
	removeLuaSprite('trailBF')
	removeSpriteShader('dad')
	removeSpriteShader('boyfriend')
	setProperty('dad.x', getProperty('dad.x') - 750)
	setProperty('boyfriend.x', getProperty('boyfriend.x') + 750)

	setProperty('space.alpha', 1)
	setProperty('wiikz.alpha', 1)
	setProperty('bluematt.alpha', 1)
	setProperty('moon.alpha', 1)

	triggerEvent('Change Character', 'dad', 'wgmatt2')
	triggerEvent('Change Character', 'bf', 'wgbf')

	--setProperty('dad.visible', false)
	--setProperty('boyfriend.visible', false)

	setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'wgbf-dead');
	setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/wgbf');
end

local finalPhaseObjects = {
	{0, 'objects/Bat', 695, 133},
	{0, 'objects/Beach Ball', 218, 607},
	{0, 'objects/glove1', 2203, 646},
	{0, 'objects/MetalFrame', 1667, 383},
	{0, 'objects/Paddle', 1557, 164},
	{0, 'objects/Racket', 2147, 436},
	{0, 'objects/WiiStage1', 1862, 91},
	{0, 'objects/WiiStage2', 1210, 573},
	{0, 'objects/WiiStage3', 913, 221},
	{0, 'objects/WiiStage4', 153, 139},
	{0, 'objects/WiiStage5', 429, 735},
	{0, 'objects/WiiStage6', 960, 567},


	{1, 'objects/spotlight2', 286, 116},
	{1, 'objects/spotlight1', 2062, 684},
	{1, 'objects/rope5', 626, 364},
	{1, 'objects/rope3', 622, 125},
	{1, 'objects/rope2', 1362, 805},
	{1, 'objects/rope1', 1730, 677},
	{1, 'objects/MetalFrame2', 148, 444},
	{1, 'objects/glove3', 2280, 169},
	{1, 'objects/glove2', 1139, 107},
	{1, 'objects/cornerpost2', 1454, 143},
	{1, 'objects/cornerpost1', 441, 398},

	{2, 'objects/tworocks2', 160, 724},
	{2, 'objects/tworocks1', 1976, 364},
	{2, 'objects/sword2', 1025, 581},
	{2, 'objects/sword1', 1755, 130},
	{2, 'objects/rock8', 2128, 164},
	{2, 'objects/rock7', 935, 888},
	{2, 'objects/rock6', 734, 750},
	{2, 'objects/rock5', 135, 339},
	{2, 'objects/rock4', 172, 116},
	{2, 'objects/rock3', 1059, 361},
	{2, 'objects/rock2', 1322, 155},
	{2, 'objects/rock1', 2176, 816},
	{2, 'objects/platform2', 1328, 495},
	{2, 'objects/platform1', 331, 205},

	{3, 'objects/Wiimote', 1439, 378},
	{3, 'objects/Wii', 1576, 470},
	{3, 'objects/trophy3', 433, 758},
	{3, 'objects/trophy2', 220, 539},
	{3, 'objects/trophy1', 486, 440},
	{3, 'objects/Shelf', 711, 538},
	{3, 'objects/poster1', 1450, 744},
	{3, 'objects/pencils', 1095, 230},
	{3, 'objects/palmtree', 1662, 87},
	{3, 'objects/nikkuhat', 726, 127},
	{3, 'objects/MattPlush', 876, 321},
	{3, 'objects/knife', 1374, 107},
	{3, 'objects/Hoop', 181, 76},
	{3, 'objects/Basketball', 1195, 407},

	{4, 'objects/YourOpinion', 1078, 132},
	{4, 'objects/WiiZapper', 927, 705},
	{4, 'objects/WiiU', 1504, 299},
	{4, 'objects/WiiKnife', 717, 249},
	{4, 'objects/VirtualBoy', 1000, 537},
	{4, 'objects/TV', 1375, 680},
	{4, 'objects/Streetlamp', 1779, 91},
	{4, 'objects/PunchingBag', 250, 150},
	{4, 'objects/Nunchuck', 1893, 421},
	{4, 'objects/NoSmoking', 1252, 454},
	{4, 'objects/Fluffing', 645, 456},
	{4, 'objects/ExitSign', 431, 766},
	{4, 'objects/Box', 1771, 602},

	{5, 'objects/WiiPost', 1143, 230},
	{5, 'objects/WiimoteIcon', 1624, 773},
	{5, 'objects/WhistleIcon', 1925, 469},
	{5, 'objects/Swapnote2', 513, 273},
	{5, 'objects/Swapnote1', 212, 538},
	{5, 'objects/Pen', 678, 745},
	{5, 'objects/MiisacreGun', 2070, 334},
	{5, 'objects/MiiFloor2', 1581, 255},
	{5, 'objects/MiiFloor1', 1679, 573},
	{5, 'objects/Internet', 1464, 651},
	{5, 'objects/Hededlol', 2128, 570},
	{5, 'objects/FriendList', 1349, 513},
	{5, 'objects/FNFIcon', 1033, 592},
	{5, 'objects/Eraser', 304, 313},
	{5, 'objects/Color', 601, 538},

	{6, 'objects/smashsword', 913, 477},
	{6, 'objects/smashrock', 1505, 620},
	{6, 'objects/smashgun', 1164, 649},
	{6, 'objects/smashbrawl', 817, 739},
	{6, 'objects/smashbanner', 964, 159},
	{6, 'objects/pebble', 1502, 838},
	{6, 'objects/glass3', 550, 263},
	{6, 'objects/glass2', 390, 162},
	{6, 'objects/glass1', 134, 433},
	{6, 'objects/eteledcorner', 1927, 510},
	{6, 'objects/cube3', 1645, 224},
	{6, 'objects/cube2', 1931, 604},
	{6, 'objects/cube1', 1773, 783},
	{6, 'objects/balanceboard', 261, 722},
	{6, 'objects/axe', 1841, 173},

	{7, 'objects/rope4', 1603, 883},
	{7, 'objects/foulrock', 2201, 464},
	{7, 'objects/foulground2', 1894, 123},
	{7, 'objects/foulground1', 1701, 478},
	{7, 'objects/destinyground', 311, 111},
	{7, 'objects/destinycorner', 766, 97},
	{7, 'objects/cornerpost3', 131, 374},
	{7, 'objects/bluerock3', 962, 320},
	{7, 'objects/bluerock2', 1053, 764},
	{7, 'objects/bluerock1', 356, 836},
}
local objectGroups = 8

function setupFinalPhase()

	makeLuaSprite('sunF', 'eclipsewg_/final/Sun', 100, -250);
	setScrollFactor('sunF', 0.02, 0.02);
	scaleObject('sunF', 1, 1);
	addLuaSprite('sunF', false)
	setProperty('sunF.alpha', 0.001)

	makeLuaSprite('earthF', 'eclipsewg_/final/Earth', -500, 400);
	setScrollFactor('earthF', 0.02, 0.02);
	scaleObject('earthF', 1, 1);
	addLuaSprite('earthF', false)
	setProperty('earthF.alpha', 0.001)

	makeLuaSprite('astF', 'eclipsewg_/final/Asteroids', -500, 500);
	setScrollFactor('astF', 0.05, 0.05);
	scaleObject('astF', 1, 1);
	addLuaSprite('astF', false)
	setProperty('astF.alpha', 0.001)


	for i = 1, #finalPhaseObjects do 
		local obj = finalPhaseObjects[i]

		local offset = 2560 * (obj[1]-1)

		makeLuaSprite(obj[2], 'eclipsewg_/final/'..obj[2], obj[3] + -100 + offset, obj[4] + -100);
		setScrollFactor(obj[2], 0.2, 0.2);
		addLuaSprite(obj[2], false)

		setProperty(obj[2]..'.alpha', 0.001)
	end

	--makeLuaSprite('moon', 'eclipsewg_/moon', -450 + 894, -100 + 1926);
	--setScrollFactor('moon', 1.0, 1.0);
	--scaleObject('moon', 2, 2);


end

function beginFinalPhase()

	finalPhase = true

	--setProperty('defaultCamZoom', 0.6)
	--setProperty('camGame.zoom', 0.6)

	setProperty('spaceE.alpha', 1)
	setProperty('space.alpha', 0.001)
	setProperty('wiikz.alpha', 0.001)
	setProperty('bluematt.alpha', 0.001)
	setProperty('moon.alpha', 0.001)

	setProperty('sunF.alpha', 1)
	setProperty('earthF.alpha', 1)
	setProperty('astF.alpha', 1)

	--setProperty('duetCamera', true)

	--setProperty('dad.x', getProperty('dad.x') + 1000)
	--setProperty('boyfriend.x', getProperty('boyfriend.x') - 400)

	--setProperty('dad.y', getProperty('dad.y') - 200)
	--setProperty('boyfriend.y', getProperty('boyfriend.y') + 200)

	for i = 1, #finalPhaseObjects do 
		local obj = finalPhaseObjects[i]
		setProperty(obj[2]..'.alpha', 1)
	end

	triggerEvent('Change Character', 'dad', 'wgmatt-final')
	triggerEvent('Change Character', 'bf', 'wgbf-final')

	setScrollFactor('dad', 0, 0.5)
	screenCenter('dad')
	
	setScrollFactor('boyfriend', 0, 0.3)
	screenCenter('boyfriend')

	setProperty('dad.x', getProperty('dad.x') - 370)
	setProperty('dad.y', getProperty('dad.y') - 100)
	setProperty('boyfriend.y', getProperty('boyfriend.y') + 350)

	setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'wgbf-final-dead');
	setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/bmwg2');
end
local time = 0
function updateFinalPhase(elapsed)
	time = time + (elapsed * 1800)
	if time > 2560*objectGroups then 
		time = time - 2560*objectGroups
	end

	local songPos = getSongPosition()*0.001

	for i = 1, #finalPhaseObjects do
		local obj = finalPhaseObjects[i]

		local pos = obj[3] + -100 + (2560 * obj[1]) - time
		if pos < -2560 * (objectGroups-1) then 
			pos = pos + (2560*objectGroups)
		end
		

		setProperty(obj[2]..'.x', pos)
		setProperty(obj[2]..'.y', obj[4] + -100 + (math.sin(songPos + i) * 20))
	end
end