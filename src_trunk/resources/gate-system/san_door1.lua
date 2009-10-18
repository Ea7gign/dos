local objDoor1 = createObject(3089, 372.7575,166.7212,1008.582,0,0,180)
exports.pool:allocateElement(objDoor1)
setElementInterior(objDoor1, 3)
setElementDimension(objDoor1, 9902)

local open = false

function useSANDoor(thePlayer)
	local team = getPlayerTeam(thePlayer)
	
	if (team==getTeamFromName("San Andreas Network News")) then
		local x, y, z = getElementPosition(thePlayer)
		local distance = getDistanceBetweenPoints3D(372.7575,166.7212,1008.582, x, y, z)

		if (distance<=5) and (open==false) then
			open = true
			outputChatBox("Door is now Open!", thePlayer, 0, 255, 0)
			moveObject(objDoor1, 1000, 372.7575,166.7212,1008.582,0,0,90)
			setTimer(closeSANDoor, 5000, 1, thePlayer)
		end
	end
end
addCommandHandler("gate", useSANDoor)

function closeSANDoor(thePlayer)
	moveObject(objDoor1, 1000, 372.7575,166.7212,1008.582, 0, 0, -90)
	setTimer(resetState1, 1000, 1)
end


function resetState1()
	open = false
end