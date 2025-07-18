function onCreate()
	if boyfriendName == "bf-battlefield" then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf-battlefield-dead');
		setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/bfBattlefield');
	end
end
function onGameOverStart()
	
	setProperty('camFollow.x', getProperty('camFollow.x') - 100)
	setProperty('camFollow.y', getProperty('camFollow.y') - 200)
end