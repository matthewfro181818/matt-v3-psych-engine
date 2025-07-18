local stageData = {
	--name, x, y, scale, scroll factor
	{'bg', -800, -800, 1 * 1.5, 0.05},

	{'cloud1', -750 + 201, -750 + 147, 1.5, 0.03},
	{'cloud2', 350 + 265, -700 + 171, 1.5, 0.05},
	{'cloud3', -350 + 143, -600 + 339, 1.5, 0.1},

	{'mattpillar', -550 + (207), -250 + (249), 1 * 1.5, 0.4},
	{'bfpillar', -80 + (288), 420 + (347), 1 * 1.5, 1.0},

	{'roof', -480, -250, 0.7 * 1.5, 0.5},
	{'crowd', -480 + (404 * 0.7), -50 + (705 * 0.7), 0.7 * 1.5, 0.65},
	{'back', -480 + (734 * 0.7), -50 + (754 * 0.7), 0.7 * 1.5, 0.8},
	{'light', -480, -250, 0.7 * 1.5, 0.5},
	{'pillars', -480, -50, 0.7 * 1.5, 1.0},
	{'side', -480 + (138 * 0.7), -50 + (885 * 0.7), 0.7 * 1.5, 1.0},
	{'ring', -480, -50 + (325 * 0.7), 0.7 * 1.5, 1.0},
}

local bgFolder = 'destiny/'

function onCreate() --simple stage template

	for i = 0, #stageData-1 do 
		local name = stageData[i+1][1]
		makeLuaSprite(name, bgFolder..name, stageData[i+1][2], stageData[i+1][3]);
		setScrollFactor(name, stageData[i+1][5], stageData[i+1][5])
		scaleObject(name, stageData[i+1][4], stageData[i+1][4])
		updateHitbox(name)
		addLuaSprite(name, stageData[i+1][6] ~= nil);
	end
end

function onCreatePost()
	setProperty('boyfriend.alpha', 0.001)
	setProperty('gf.visible', false)

	setBlendMode('light', 'add')

	--switchShit()
end

function onEvent(tag, val1, val2)
	if tag == "Change Character" and val2 == "corrMat_P2" then 
		switchShit()
	end
	if tag == "Change Character" and val1 == "bf" then 
		setProperty('boyfriend.visible', true) --make visible after switching to matt
		setProperty('boyfriend.x', getProperty('boyfriend.x')+100)
		setProperty('boyfriend.y', getProperty('boyfriend.y')-50)
		--cameraFlash('game', '#FFFFFF', 1)

		setProperty('matt-destiny-anims.visible', false)

		--debugPrint(getProperty('boyfriend.x'))
		--debugPrint(getProperty('boyfriend.y'))
	end

	if tag == "Play Animation" then 
		if val1 == "dies" then 
			if val2 == "bf" then 
				runTimer('hideBF', (1/24)*25) --hide after fall anim
			elseif val2 == "dad" then 
				runTimer('hideDad', (1/24)*28)
			end
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "hideBF" then 
		setProperty('boyfriend.visible', false)
	elseif tag == "hideDad" then 
		setProperty('dad.visible', false)
	end
end


function switchShit()
	setProperty('roof.visible', false)
	setProperty('crowd.visible', false)
	setProperty('back.visible', false)
	setProperty('light.visible', false)
	setProperty('pillars.visible', false)
	setProperty('side.visible', false)
	setProperty('ring.visible', false)

	setProperty('boyfriend.alpha', 1)
	setProperty('gf.visible', true)
	setProperty('defaultCamZoom', 0.5)
	setScrollFactor('dad', 0.4, 0.4)
	setProperty('dad.x', getProperty('dad.x')-475)
	setProperty('dad.y', getProperty('dad.y')-610)

	setProperty('boyfriendCameraOffset', {100, 200})

	--setProperty('dad.x', getProperty('dad.x')-250)
	--setProperty('dad.y', getProperty('dad.y')-300)
end