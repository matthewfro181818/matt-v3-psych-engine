local IntroTime = 0
local IntroY = 200
local composer = ''

function onCreatePost()

	for i = 0, getProperty('eventNotes.length')-1 do
		if getPropertyFromGroup('eventNotes', i, 'event') == 'IntroTime' and IntroTime == 0 then
			IntroTime = getPropertyFromGroup('eventNotes', i, 'strumTime')
		end
	end
	
	makeLuaWiiText('title', '', 0, 0, IntroY + 14)
	setProperty('title.alignment', 'left')
	setProperty('title.size', 30/24)
	setProperty('title.spaceGap', 10)
	setProperty('title.newlineGap', 32)
	setProperty('title.text', songName..'\nComposer: '..(checkFileExists('data/'..songPath..'/composer.txt') and getTextFromFile('data/'..songPath..'/composer.txt') or 'no composer set')..'\nCharter: '..(checkFileExists('data/'..songPath..'/charter.txt') and getTextFromFile('data/'..songPath..'/charter.txt') or 'no charter set'))
	for i = 0, 10 do
		makeLuaSprite('introBar'..i , '', 0, IntroY + (12 * i+1))
		makeGraphic('introBar'..i, getProperty('title.width') + 250, 12, '000000')
		setProperty('introBar'..i..'.x', 0 - getProperty('introBar'..i..'.width'))
		setObjectCamera('introBar'..i, 'hud')
		setProperty('introBar'..i..'.alpha', 0.7)
		addLuaSprite('introBar'..i)
	end
	
	setProperty('title.x', -30 - getProperty('introBar1.width'))
	addInstance('title', false)
	setObjectOrder('title', getObjectOrder('introBar10')+1)
end

function onUpdate()
	if getSongPosition() > IntroTime and IntroTime ~= -1 then
		for i = 0, 10 do
			doTweenX('IntroInbar'..i, 'introBar'..i, -50 - (5 * i+1) - (i%2 == 0 and 0 or 70), (i%2 == 0 and 1 or 1.3), 'backOut')
		end
		doTweenX('IntroIn', 'title', 30, 0.7, 'sineOut')
		runTimer('introOut', 6);
		IntroTime = -1
	end
end



function onTimerCompleted(tag)
	if tag == 'introOut' then
		for i = 0, 10 do
			doTweenX('IntroOutbar'..i, 'introBar'..i, -200 - getProperty('introBar1.width'), (i%2 == 0 and 1.3 or 1), 'smootherStepInOut')
		end
		doTweenX('IntroOut', 'title', -170 - getProperty('introBar1.width'), 1, 'smootherStepInOut')
	end
end