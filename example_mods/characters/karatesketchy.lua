function onCreate()
	if boyfriendName == "karatesketchy" then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'karatesketchy');
		setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/sketchy');
	end
end
function onGameOverStart()
	
	setProperty('camFollow.x', getProperty('camFollow.x') + 150)
	setProperty('camFollow.y', getProperty('camFollow.y') - 0)
end