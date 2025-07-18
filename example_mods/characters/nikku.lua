local baseY = 0
function onCreatePost()
    baseY = getProperty('boyfriend.y')
end
function onUpdate(elapsed)
    setProperty('boyfriend.y', baseY + math.sin(getSongPosition()*0.001)*15)
end

function onCreate()
	if boyfriendName == "nikku" then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'nikku-dead');
		setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/nikku');
	end
end
function onGameOverStart()
	
	setProperty('camFollow.x', getProperty('camFollow.x') + -700)
	setProperty('camFollow.y', getProperty('camFollow.y') + 100)
end