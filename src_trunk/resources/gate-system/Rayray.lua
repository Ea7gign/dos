local Gate = {
	[1] = createObject(969, 2777.0668945313, 923.25128173828, 9.8875827789307, 0, 0, 270.34521484375),
	[2] = createObject(969, 2777.130859375, 914.486328125, 9.8875827789307, 0, 0, 270.34057617188),
	[3] = createObject(969, 2777.1047363281, 911.95733642578, 9.8875827789307, 0, 0, 270.34057617188),
}
local GateName = "Gate"
local GatePass = "13371249"
local open = false


local function ResetOpenState()
	open = false
end

local function closeDoor(thePlayer)
	if (getElementType(thePlayer)) then
		outputChatBox("The " .. GateName .. " is now closed!", thePlayer, 255, 0, 0)
	end
	moveObject(Gate[1], 1000, 2777.0668945313, 923.25128173828, 9.8875827789307, 0, 0, 0)
	moveObject(Gate[2], 1000, 2777.130859375, 914.486328125, 9.8875827789307, 0, 0, 0)
	moveObject(Gate[3], 1000, 2777.1047363281, 911.95733642578, 9.8875827789307, 0, 0, 0)
	setTimer(ResetOpenState, 1000, 1)
end


local function useDoor(thePlayer, commandName, ...)
	local password = table.concat({...})
	local x, y, z = getElementPosition(thePlayer)
	local distance = getDistanceBetweenPoints3D(2777.130859375, 914.486328125, 9.8875827789307, x, y, z)
	
	if (distance<10) and (open==false) then
		if (password == GatePass) then
			outputChatBox("The " .. GateName .. " is now open!", thePlayer, 0, 255, 0)
			moveObject(Gate[1], 1000, 2777.0668945313, 923.25128173828, 6.5626058578491, 0, 0, 0)
			moveObject(Gate[2], 1000, 2777.130859375, 914.486328125, 6.4876055717468, 0, 0, 0)
			moveObject(Gate[3], 1000, 2777.1047363281, 911.95733642578, 6.5126056671143, 0, 0, 0)
			setTimer(closeDoor, 5000, 1, thePlayer)
			open = true
		else
			outputChatBox("Invalid Password!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("gate", useDoor)