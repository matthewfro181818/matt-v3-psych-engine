--change this ones--
camMovement = 9
velocity = 2

--leave these ones alone, nothings gonna happen anyways--
cXoffset = 0
cYoffset = 0
checkdadidle = false

function onMoveCamera(focus)
	checkdadidle = focus == 'dad'
	setProperty('cameraSpeed', 1)
end

function setCamDisplacement(direction)
	setProperty('cameraSpeed', velocity)
	local toAdd = (direction%2 == 1 and camMovement or -camMovement)
	cYoffset = ((direction == 1 or direction == 2) and toAdd or 0)
	cXoffset = ((direction == 0 or direction == 3) and toAdd or 0)
end

function opponentNoteHit(id, direction, nType)
	if checkdadidle and nType ~= 'No Animation' then setCamDisplacement(getMultikeyNoteIndex(direction)) end
end

function goodNoteHit(id, direction, nType)
	if not checkdadidle and nType ~= 'No Animation' then setCamDisplacement(getMultikeyNoteIndex(direction)) end
end
--teninete mantequilla was here, HOLY SHIT i cant belive a shit ton of people keep using the old fuckass script i made in early psych times PLEASE FOR THE LOVE OF GOD STOP IT--
function onUpdate()
	setProperty('camGame.targetOffset.y', cYoffset)
	setProperty('camGame.targetOffset.x', cXoffset)
end