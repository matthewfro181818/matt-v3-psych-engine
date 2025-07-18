local displayText = ''
local separatedText = {}
local CharperSec = 10
local interval = 0.025
local timeWaited = 0

function onCreate()
	makeLuaWiiText('subtitle', '', screenWidth, 0, 500)
	setProperty('subtitle.size', 27/24)
	setProperty('subtitle.spaceGap', 12)
	addInstance('subtitle')
end

function onEvent(name, value1, value2)
	if name == 'subtitle'then
	
		splitval1 = {}
		
        for value in string.gmatch(value1, '([^,]+)')do
                table.insert(splitval1, value)
        end

		splitval1[1] = (splitval1[1] == nil and 0 or splitval1[1])
		splitval1[2] = (splitval1[2] == nil and 'replace' or splitval1[2])
			
		CharperSec = tonumber(splitval1[1])
		
		if splitval1[2] == 'remove' or splitval1[2] == 'replace' then
			displayText = ''
			separatedText = {}
		end
		
		if splitval1[2] ~= 'remove' then
		
			interval = 1/CharperSec
			
			if splitval1[2] == 'addNext' then
				table.insert(separatedText, '\n')
			end
			
			
			if tonumber(splitval1[1]) <= 0 then
				if #separatedText ~= 0 then
					for i, letter in pairs(separatedText) do 
						displayText = displayText..letter
					end
				end
				separatedText = {}
				displayText = displayText..value2
			else
				for char in (value2):gmatch"." do
					table.insert(separatedText, char)
				end
			end
			
		
		end
	end
end

function onUpdate(elapsed)

	timeWaited = timeWaited + elapsed
	
	while (timeWaited > interval and separatedText[1] ~= nil) do
		displayText = displayText..separatedText[1]
		table.remove(separatedText, 1)
		timeWaited = timeWaited - interval
	end
	
	if #separatedText == 0 then timeWaited = 0 end
	
	if displayText ~= "" and getProperty('vocals.volume') ~= 1 then 
		setProperty('vocals.volume', 1)
	end

	setProperty('subtitle.text', displayText)
end
