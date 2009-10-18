local objGatea = createObject(4100, 1291.6, -966.384, 35.36, 0 , 0 , 140)
exports.pool:allocateElement(objGatea)

local open = false

-- Gate code
function useSangate2(thePlayer)
	local team = getPlayerTeam(thePlayer)
	
	if (team==getTeamFromName("San Andreas Network News")) then
		local x, y, z = getElementPosition(thePlayer)
		local distance = getDistanceBetweenPoints3D(1291.6, -966.384, 35.36, x, y, z)

		if (distance<=8) and (open==false) then
			open = true
			outputChatBox("Garage is now Open!", thePlayer, 0, 255, 0)
			moveObject(objGatea, 1500, 1296.9, -966.384, 35.36,0,0,0)
			setTimer(closeSangate2, 5500, 1, thePlayer)
		end
	end
end
addCommandHandler("gate", useSangate2)

function closeSangate2(thePlayer)
	moveObject(objGatea, 1500, 1291.6, -966.384, 35.36,0,0 ,0)
	setTimer(resetState2, 1500, 1)
end


function resetState2()
	open = false
end