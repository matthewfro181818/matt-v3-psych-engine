function onCreate()
	if boyfriendName == "wgbf" then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'wgbf-dead');
		setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/wgbf');
	end
end
function onGameOverStart()
	
	setProperty('camFollow.x', getProperty('camFollow.x') - 450)
	setProperty('camFollow.y', getProperty('camFollow.y') - 0)
end