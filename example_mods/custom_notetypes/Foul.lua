function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Foul' then
			if not getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then 
				if noteSkin == "Default" then 
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'nightmare/foulplayNotesWii'); --Change texture
				else 
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'nightmare/foulplayNotes'); --Change texture
				end
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
				setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.disabled', true);
				
                setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false);

				setPropertyFromGroup('unspawnNotes', i, 'scale.x', getPropertyFromGroup('unspawnNotes', i, 'scale.x')*0.8);
				setPropertyFromGroup('unspawnNotes', i, 'scale.y', getPropertyFromGroup('unspawnNotes', i, 'scale.y')*0.8);
				updateHitboxFromGroup('unspawnNotes', i)

				if downscroll then 
					setPropertyFromGroup('unspawnNotes', i, 'flipY', true);
					setPropertyFromGroup('unspawnNotes', i, 'offsetY', -25);
				else 
					setPropertyFromGroup('unspawnNotes', i, 'offsetY', -5);
				end

				setPropertyFromGroup('unspawnNotes', i, 'offsetX', 5);
			end
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Foul' then
		addHealth(-0.7)
	end
end