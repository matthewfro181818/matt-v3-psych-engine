local lockZoom = false

function onEvent(name, value1, value2)
	if name == 'Better Zoom' then
		splitv1 = split(value1, ',')
		splitv2 = split(value2, ',')

		zoom = getProperty('defaultCamZoom', zoom) + tonumber(splitv2[1])
		
		doTweenZoom('zoooooooooooooom', splitv1[1], zoom, tonumber(splitv2[2]), splitv1[2]);
        setProperty('defaultCamZoom', zoom)
	
	end
end
	
function split (stringtosplit, cut)
   if stringtosplit == nil then
      stringtosplit = "%s"
   end
   local t={}
   for str in string.gmatch(stringtosplit, "([^"..cut.."]+)") do
      table.insert(t, str)
   end
   return t
end
function onUpdate()
	setProperty('camZooming', not lockOn)
end