bindKey("u", "down", "chatbox", "GlobalOOC")
bindKey("b", "down", "chatbox", "LocalOOC")

data = { }
function datachange(value)
	if (data[value] == nil) then
		data[value] = 1
	else
		data[value] = data[value] + 1
	end
end
addEventHandler("onClientElementDataChange", getRootElement(), datachange)

local tick = getTickCount()
function showdata()
	local tick2 = getTickCount()
	local time = (tick2 - tick) / 1000
	outputChatBox("Sync for " .. time .. " seconds.")
	
	local largest = 0
	local largestname = "none"
	for key, value in pairs(data) do
		if (value>largest) and (value~="scoreboard:reload") then
			largest = value
			largestname = key
		end
		outputChatBox(tostring(key) .. ": ".. value)
	end
	
	outputChatBox("Largest was: ".. largestname .. ": " .. largest)
end
addCommandHandler("showdata", showdata)