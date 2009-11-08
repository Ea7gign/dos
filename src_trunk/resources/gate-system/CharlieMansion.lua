local Gate = {
	[1] = createObject(2131, 137.7, 1382, 1082.9, 0, 0, -90)
}

setElementDimension( Gate[1], 9730 )
setElementInterior( Gate[1], 5 )

local GatePass = "ivanskunkyjet"
local open = false

local function ResetOpenState()
	open = false
end

local function closeDoor()
	moveObject(Gate[1], 2000, 137.7, 1382, 1082.9)
	setTimer(ResetOpenState, 2000, 1)
end

local function openDoor()
	moveObject(Gate[1], 2000, 137.7, 1384, 1082.9)
	setTimer(closeDoor, 6000, 1)
	open = true
end

local function useDoor(thePlayer, commandName, ...)
	local password = table.concat({...})
	local x, y, z = getElementPosition(thePlayer)
	local distance = getDistanceBetweenPoints3D(137.7, 1381.4, 1082.9, x, y, z)

	if (distance<=5) and (open==false) then
		if (password == GatePass) then
			openDoor()
		end
	end
end
addCommandHandler("gate", useDoor)