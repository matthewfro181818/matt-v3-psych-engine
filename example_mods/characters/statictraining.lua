function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'statictraining')
end

function onUpdate()
	if inGameOver then
		setProperty('camFollow.y', 450)
	end
end