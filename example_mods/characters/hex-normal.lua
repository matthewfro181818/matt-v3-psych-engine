function onCreate()
	if boyfriendName == "hex-normal" then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'hex-dead');
		setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/hex');
	end
end
function onGameOverStart()
	
	setProperty('camFollow.x', getProperty('camFollow.x') - 100)
	setProperty('camFollow.y', getProperty('camFollow.y') - 0)
end