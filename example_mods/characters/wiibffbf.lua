function onCreate()
	if boyfriendName == "wiibffbf" then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'wiibffbf-dead');
		setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/revolution');
	end
end
function onGameOverStart()
	
	setProperty('camFollow.x', getProperty('camFollow.x') - 350)
	setProperty('camFollow.y', getProperty('camFollow.y') - 500)
end