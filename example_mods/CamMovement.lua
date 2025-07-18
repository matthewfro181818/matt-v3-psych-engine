--change this ones--
local camMovement = 9
local velocity = 2

--leave this ones alone, no touchy--
local campointx = 0
local campointy = 0
local camlockx = 0
local camlocky = 0
local camlock = false
local bfturn = false
-- dont touchy, srs dont--
	
function onMoveCamera(focus)
	if focus == 'boyfriend' then
	campointx = getProperty('camFollow.x')
	campointy = getProperty('camFollow.y')
	bfturn = true
	camlock = false
	setProperty('cameraSpeed', 1)
	
	elseif focus == 'dad' then
	campointx = getProperty('camFollow.x')
	campointy = getProperty('camFollow.y')
	bfturn = false
	camlock = false
	setProperty('cameraSpeed', 1)
	
	end
end

-- camlock prevents from on beat reseting to the og pos on beat, really annoying tbh--
function goodNoteHit(id, direction)
	if bfturn then
		if direction == 0 then
			camlockx = campointx - camMovement
			camlocky = campointy
		elseif direction == 1 then
			camlocky = campointy + camMovement
			camlockx = campointx
		elseif direction == 2 then
			camlocky = campointy - camMovement
			camlockx = campointx
		elseif direction == 3 then
			camlockx = campointx + camMovement
			camlocky = campointy
		end
	runTimer('camreset', 1)
	setProperty('cameraSpeed', velocity)
	camlock = true
	end	
end
--teninete mantequilla was here--
		-- delete this if you dont want the oponent to move the camera
		--from here--
function opponentNoteHit(id, direction)
	if not bfturn then
		if direction == 0 then
			camlockx = campointx - camMovement
			camlocky = campointy
		elseif direction == 1 then
			camlocky = campointy + camMovement
			camlockx = campointx
		elseif direction == 2 then
			camlocky = campointy - camMovement
			camlockx = campointx
		elseif direction == 3 then
			camlockx = campointx + camMovement
--nice--
			camlocky = campointy
		end
	runTimer('camreset', 1)
	setProperty('cameraSpeed', velocity)
	camlock = true
	end	
end
		-- till here -- 
		
-- this was unnecesary at the beggining but then i remembered, there are songs with a loong pause--
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'camreset' then
	camlock = false
	setProperty('cameraSpeed', 1)
	setProperty('camFollow.x', campointx)
	setProperty('camFollow.y', campointy)
	end
end
-- funny rukus --
function onCreatePost()
	campointx = getProperty('camFollow.x')
	campointy = getProperty('camFollow.y')
end

function onUpdate()
	if camlock then
	setProperty('camFollow.x', camlockx)
	setProperty('camFollow.y', camlocky)
	end
end
	-- cringe camera EWW: Teniente Mantequilla Was Here--