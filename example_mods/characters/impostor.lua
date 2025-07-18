function onCreate()
	if boyfriendName == "impostor" then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'impostor');
		setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/red');
	end
end
function onGameOverStart()
	
	setProperty('camFollow.x', getProperty('camFollow.x') + 50)
	setProperty('camFollow.y', getProperty('camFollow.y') - 100)
end