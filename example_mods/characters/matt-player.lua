function onCreate()
	if boyfriendName == "matt-player" then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'matt-player');
		setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/matt');
	end
end
function onGameOverStart()
	
	setProperty('camFollow.x', getProperty('camFollow.x') + -550)
	setProperty('camFollow.y', getProperty('camFollow.y') + 350)
end