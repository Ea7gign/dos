local Gate = {
	[1] = createObject(988, 1154.0626220703, -626.15966796875, 104.99081420898, 0, 0, 6.49)
}
local GateName = "Hans's Residence"
exports.pool:allocateElement(Gate[1])
exports.pool:allocateElement(Gate[2])
local GatePass = "private!hah"
local open = false


local function ResetOpenState()
	open = false
end

local function closeDoor(thePlayer)
	moveObject(Gate[1], 2000, 1154.0626220703, -626.15966796875, 104.99081420898, 0, 0, 100)
	setTimer(ResetOpenState, 2000, 1)
end


-- Gate code / Using local functions to avoid 
local function useDoor(thePlayer, commandName, ...)
	local password = table.concat({...})
	local x, y, z = getElementPosition(thePlayer)
	local distance = getDistanceBetweenPoints3D(1154.0626220703, -626.15966796875, 104.99081420898, x, y, z)

	if (distance<=10) and (open==false) then
		if (password == GatePass) then
			moveObject(Gate[1], 2000, 1157.0626220703, -623.15966796875, 104.99081420898, 0, 0, -100)
			setTimer(closeDoor, 6000, 1, thePlayer)
			open = true
		else
			outputChatBox("Invalid Password", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("gate", useDoor)