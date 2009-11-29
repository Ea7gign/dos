local Gate = {
	[1] = createObject(988, 1154.0626220703, -626.15966796875, 104.99081420898, 0, 0, 6.49)
}
exports.pool:allocateElement(Gate[1])
local GatePass = "scotlandalba"
local open = false

local function ResetOpenState()
	open = false
end

local function closeDoor()
	moveObject(Gate[1], 2000, 1154.0626220703, -626.15966796875, 104.99081420898, 0, 0, 100)
	setTimer(ResetOpenState, 2000, 1)
end

local function openDoor()
	moveObject(Gate[1], 2000, 1157.0626220703, -623.15966796875, 104.99081420898, 0, 0, -100)
	setTimer(closeDoor, 6000, 1)
	open = true
end

local function useDoor(thePlayer, commandName, ...)
	local password = table.concat({...})
	local x, y, z = getElementPosition(thePlayer)
	local distance = getDistanceBetweenPoints3D(1154.0626220703, -626.15966796875, 104.99081420898, x, y, z)

	if (distance<=25) and (open==false) then
		if (password == GatePass) then
			openDoor()
		else
			outputChatBox("Invalid Password", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("gate", useDoor)

createObject(3279, 1145.1748046875, -608.6337890625, 103.9140625)
local ped1 = createPed(280, 1157.533203125, -628.3515625, 104.00807189941)
setTimer(giveWeapon, 100, 1, ped1, 31, 15000, true)
setPedRotation(ped1, 181.274)

local ped2 = createPed(280, 1149.9052734375, -629.08984375, 103.81439208984)
setTimer(giveWeapon, 100, 1, ped2, 31, 15000, true)
setPedRotation(ped2, 158.40057373047)

local ped3 = createPed(285, 1150.03125, -625.1044921875, 104.25662231445)
setTimer(giveWeapon, 100, 1, ped3, 31, 15000, true)
setPedRotation(ped3, 358.93704223633)

local ped4 = createPed(285, 1157.111328125, -624.3662109375, 104.07080841064)
setTimer(giveWeapon, 100, 1, ped4, 31, 15000, true)
setPedRotation(ped4, 0.82125854492188)

-- snipers
local ped4 = createPed(285, 1146.28125, -610.3056640625, 120.9921875)
setTimer(giveWeapon, 100, 1, ped4, 34, 15000, true)
setPedRotation(ped4, 188.00915527344)

local ped5 = createPed(285, 1144.8779296875, -610.421875, 120.9921875)
setTimer(giveWeapon, 100, 1, ped5, 34, 15000, true)
setPedRotation(ped5, 184.20233154297)

-- door guards
local ped6 = createPed(282, 1141.2021484375, -585.6953125, 105.6206741333)
setTimer(giveWeapon, 100, 1, ped6, 29, 15000, true)
setPedRotation(ped6, 180.58778381348)

local ped7 = createPed(282,1136.109375, -585.146484375, 105.6206741333)
setTimer(giveWeapon, 100, 1, ped7, 29, 15000, true)
setPedRotation(ped7, 176.20416259766)