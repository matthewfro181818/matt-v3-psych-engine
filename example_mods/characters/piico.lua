function onCreate()
	if boyfriendName == "piico" then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'piico-dead');
		setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'death/pico');
	end
end