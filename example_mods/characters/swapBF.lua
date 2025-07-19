function onCreate()
	if boyfriendName == "swapBF" then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'swapBF-dead');
		setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/swapbf');
	end
end
function onGameOverStart()
	
	setProperty('camFollow.x', getProperty('camFollow.x') - 250)
	setProperty('camFollow.y', getProperty('camFollow.y') - 100)
end