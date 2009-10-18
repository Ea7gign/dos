local objGatea = createObject(4100, 1291.6, -1006.13, 31.57, 0 , 0 , 140)
exports.pool:allocateElement(objGatea)

local open = false

-- Gate code
function useSangate1(thePlayer)
	local team = getPlayerTeam(thePlayer)
	
	if (team==getTeamFromName("San Andreas Network News")) then
		local x, y, z = getElementPosition(thePlayer)
		local distance = getDistanceBetweenPoints3D(1291.6, -1006.13, 31.57, x, y, z)

		if (distance<=8) and (open==false) then
			open = true
			outputChatBox("Garage is now Open!", thePlayer, 0, 255, 0)
			moveObject(objGatea, 1500, 1296.805, -1006.13, 31.57,0,0,0)
			setTimer(closeSangate1, 5500, 1, thePlayer)
		end
	end
end
addCommandHandler("gate", useSangate1)

function closeSangate1(thePlayer)
	moveObject(objGatea ,1500, 1291.6, -1006.13, 31.57,0,0 ,0)
	setTimer(resetState1, 1500, 1)
end


function resetState1()
	open = false
end