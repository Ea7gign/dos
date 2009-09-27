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
	for key, value in pairs(data) do
		outputChatBox(tostring(key) .. ": ".. value)
	end
end
addCommandHandler("showdata", showdata)