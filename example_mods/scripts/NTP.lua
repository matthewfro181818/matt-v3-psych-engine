local counter = 0 

function onCreate()
	makeLuaWiiText('nps', '0', screenWidth, -18, 10)
	setProperty('nps.alignment', 'right')
	addInstance('nps')
end

function onUpdate()
	setProperty('nps.text', 'NPS: '..counter)
end
	
function goodNoteHit(id, direction, noteType, isSustainNote)
	if not isSustainNote then
		counter = counter + 1
		runTimer(getRandomInt(0, 300)..getSongPosition()..id..direction..id..direction..'nps',1)
		if counter > 15 then
			updateGData('boyfriend')	
			createGhost('boyfriend', id, direction + 1, (counter-15)/15)
		end
	end
end

function onTimerCompleted(tag) --oh wow mantequilla re-using code bits?!?!?!? unnaceptable 
	if (tag:sub(#tag-2, #tag)) == 'nps' then
		counter = counter - 1
	end
end

function onTweenCompleted(tag)
-- i like number 45 :thumbs_up:
	if (tag:sub(#tag- 5, #tag)) == 'delete' then
		removeLuaSprite(tag:sub(1, #tag - 6), true)
	end
end

function updateGData(char)
	_G[char..'GhostData.frameName'] = getProperty(char..'.animation.frameName')
	_G[char..'GhostData.offsetX'] = getProperty(char..'.offset.x')
	_G[char..'GhostData.offsetY'] = getProperty(char..'.offset.y')
end

function createGhost(char, id, direction,alpha) --yet again re using shit
	songPos = getSongPosition() --in case game stutters
	tag = char..'Ghost'..songPos..id
    makeAnimatedLuaSprite(tag, getProperty(char..'.imageFile'),getProperty(char..'.x'),getProperty(char..'.y'))
    addLuaSprite(tag, false)
    setProperty(tag..'.scale.x',getProperty(char..'.scale.x'))
	setProperty(tag..'.scale.y',getProperty(char..'.scale.y'))
	setProperty(tag..'.flipX', getProperty(char..'.flipX'))
	setProperty(tag..'.alpha', alpha)
	doTweenAlpha(tag..'delete', tag, 0, 0.5*alpha)
	setProperty(tag..'.velocity.x', 500)
	setBlendMode(tag, 'screen')
	setProperty(tag..'.animation.frameName', _G[char..'GhostData.frameName'])
	setProperty(tag..'.offset.x', _G[char..'GhostData.offsetX'])
	setProperty(tag..'.offset.y', _G[char..'GhostData.offsetY'])
	setObjectOrder(tag, getObjectOrder(char..'Group')-1)
end
