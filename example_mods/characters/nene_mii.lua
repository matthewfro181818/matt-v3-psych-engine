local visX = {0, 59, 56, 66, 54, 52, 51}
local visY = {0, -8, -3.5, -0.4, 0.5, 4.7, 7}
function onCreatePost()
    --makeAnimatedLuaSprite('abot', 'characters/abot', getProperty('gf.x'), getProperty('gf.y'))

    setScrollFactor('gf', 1, 1)

    createInstance('abot', "objects.Character", {getProperty('gfGroup.x')-450, getProperty('gfGroup.y')-80, 'abot'})
    addInstance('abot', true)
    setObjectOrder('abot', getObjectOrder('gfGroup'))

    makeLuaSprite('stereoBG', 'characters/abot/stereoBG', getProperty('abot.x')+260, getProperty('abot.y')+375)
    addLuaSprite('stereoBG', true)
    setObjectOrder('stereoBG', getObjectOrder('abot'))

    local totalX = 0
    local totalY = 0
    for i = 1, 7 do 
        totalX = totalX + visX[i]
        totalY = totalY + visY[i]
        local x = getProperty('abot.x') + 295 + totalX
        local y = getProperty('abot.y') + 430 + totalY

        makeAnimatedLuaSprite('vis'..i, 'characters/abot/aBotViz', x, y)
        addAnimationByPrefix('vis'..i, 'vis', 'viz'..i, 24, false)
        playAnim('vis'..i, 'vis', false, false, 6)

        addLuaSprite('vis'..i, true)
        setObjectOrder('vis'..i, getObjectOrder('abot'))
    end

end

local vizStart = false
function onSongStart()

	if not lowQuality then
		--hardcoded func (for anyone looking where the fuck this is from) 
		initAnalyzer(7, 0.1, 40)
		vizStart = true
	end
end

function onUpdatePost(elapsed)

	if vizStart then 
		local levels = getAudioLevels()

		for i = 1, math.min(#levels, 7) do
			local n = 'vis'..i
            local frame = math.min(5, math.max(0, math.floor((levels[i] * 5) + 0.5)) );

            setProperty(n..'.animation.curAnim.curFrame', -frame + 5)
		end
	end

end