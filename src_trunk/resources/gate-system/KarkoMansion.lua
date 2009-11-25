local Gate = {
	[1] = createObject(988, -50.936084747314, -807.28820800781, 11.592994689941, 0, 0, 68.210021972656)
}
exports.pool:allocateElement(Gate[1])
local GatePass = "megamilk"
local open = false

local function ResetOpenState()
	open = false
end

local function closeDoor()
	moveObject(Gate[1], 1000, -50.936084747314, -807.28820800781, 11.592994689941, 0, 0, 0)
	setTimer(ResetOpenState, 1000, 1)
end

local function openDoor()
	moveObject(Gate[1], 1000, -48.921611785889, -802.21807861328, 11.592994689941, 0, 0, 0)
	setTimer(closeDoor, 5000, 1)
	open = true
end

local function useDoor(thePlayer, commandName, ...)
	local password = table.concat({...})
	local x, y, z = getElementPosition(thePlayer)
	local distance = getDistanceBetweenPoints3D(-50.936084747314, -807.28820800781, 11.592994689941, x, y, z)

	if (distance<=10) and (open==false) then
		if (password == GatePass) then
			openDoor()
		else
			outputChatBox("Invalid Password", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("gate", useDoor)