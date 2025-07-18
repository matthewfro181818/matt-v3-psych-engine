function onCreate()
	if boyfriendName == "darnellmii_player" then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'darnellmii-dead');
		setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/darnell');
	end
end
function onGameOverStart()
	
	setProperty('camFollow.x', getProperty('camFollow.x') - 600)
	setProperty('camFollow.y', getProperty('camFollow.y') - 500)
end