local baseY = 0
function onCreatePost()
    baseY = getProperty('dad.y')
end
function onUpdate(elapsed)
    setProperty('dad.y', baseY + math.sin(getSongPosition()*0.001)*15)
end