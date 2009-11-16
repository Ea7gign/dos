local angGate = createObject(3089, 372.7575,166.7212,1008.582,0,0,180)
exports.pool:allocateElement(angGate)
setElementInterior(angGate, 3)
setElementDimension(angGate, 63)
local open = false
-- 
-- Gate code

local angGuard = createPed( 287, 370.7433166, 167.1261444, 1008.3828125 )
setElementDimension( angGuard, 63 )
setElementInterior( angGuard , 3 )
setElementData( angGuard, "talk", 1 )
setElementData( angGuard, "name", "Airman Connor" )

function useAngGate(thePlayer)
	if getElementDimension( thePlayer ) ~= getElementDimension( angGate ) then return end
	
	local gender = getElementData(thePlayer, "gender")
	local genderm = "Sir"
	if (gender == 1) then
		genderm = "Ma'am"
	end

	local team = getPlayerTeam(thePlayer)
	if (team==getTeamFromName("Air National Guard")) then
		local x, y, z = getElementPosition(thePlayer)
		local distance = getDistanceBetweenPoints3D(372.7575,166.7212,1008.582, x, y, z)

		if (distance<=3) and (open==false) then
			exports.global:sendLocalText(thePlayer, " *Airman Connor opens the door.", 255, 51, 102)
			exports.global:sendLocalText(thePlayer, "Airman Connor says: " .. genderm .. ", You can walk inside/outside.", nil, nil, nil, 10)
			open = true
			moveObject(angGate, 1000, 372.7575,166.7212,1008.582,0,0,90)
			setTimer(closeAngGate, 5000, 1, thePlayer)
		end
	else
		exports.global:sendLocalText(thePlayer, "Airman Connor says: " .. genderm .. ", only authorized personnel is allowed in here.", nil, nil, nil, 10)
	end
end
addCommandHandler("gate", useAngGate)
addEvent( "gateAngBase", true )
addEventHandler( "gateAngBase", getRootElement( ),
	function( )
		useAngGate( source )
	end
)

function closeAngGate(thePlayer)
	exports.global:sendLocalText(thePlayer, " *Airman Connor closes the door.", 255, 51, 102)
	moveObject(angGate, 1000, 372.7575,166.7212,1008.582,0,0,-90)
	setTimer(resetObjectState, 1000, 1)
end


function resetObjectState()
	open = false
end
