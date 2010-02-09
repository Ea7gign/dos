local Gate = {
	[1] = createObject(985, 2874.6430664063, -1976.3186035156, 11.822189331055, 0, 0, 90.016479492188, 0, 0),
	[2] = createObject(986, 2874.64453125, -1984.279296875, 11.822639465332, 0, 0, 90.016479492188, 0, 0),
}

local GateName = "Towing lot gates"
exports.pool:allocateElement(Gate[1])
exports.pool:allocateElement(Gate[2])
local open = false


local function ResetOpenState()
	open = false
end

local function closeDoor(thePlayer)
	moveObject(Gate[1], 2000, 2874.6430664063, -1976.3186035156, 11.822189331055)
	moveObject(Gate[2], 2000, 2874.64453125, -1984.279296875, 11.822639465332)
	setTimer(ResetOpenState, 2000, 1)
end


-- Gate code / Using local functions to avoid 
local function useDoor(thePlayer, commandName)
	if exports.global:hasItem(thePlayer, 82) then
		local x, y, z = getElementPosition(thePlayer)
		local distance = getDistanceBetweenPoints3D(2874.6430664063, -1976.3186035156, 11.822189331055, x, y, z)

		if (distance<=15) and (open==false) then
			moveObject(Gate[1], 2000, 2874.6501367188, -1969.318359375, 11.822189331055)
			moveObject(Gate[2], 2000, 2874.6462402344, -1992.3139648438, 11.822189331055)
			setTimer(closeDoor, 6000, 1, thePlayer)
			open = true
		end
	end
end
addCommandHandler("gate", useDoor)