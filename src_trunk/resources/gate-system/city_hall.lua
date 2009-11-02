local objGateb = createObject(3089, 372.7575,166.7212,1008.582,0,0,180)
exports.pool:allocateElement(objGateb)
setElementInterior(objGateb, 3)
setElementDimension(objGateb, 125)
local open = false
-- 
-- Gate code

local guard = createPed( 163, 370.7433166, 167.1261444, 1008.3828125 )
setElementDimension( guard, 125 )
setElementInterior( guard , 3 )
setElementData( guard, "talk", 1 )
setElementData( guard, "name", "Guard Clark" )

local function useImpoundDoorb(thePlayer)
	local team = getPlayerTeam(thePlayer)
	if (team==getTeamFromName("Government of Los Santos")) then
		local x, y, z = getElementPosition(thePlayer)
		local distance = getDistanceBetweenPoints3D(372.7575,166.7212,1008.582, x, y, z)

		if (distance<=3) and (open==false) then
			local gender = getElementData(thePlayer, "gender")
			local genderm = "Mr."
			if (gender == 1) then
				genderm = "Miss."
			end
			exports.global:sendLocalText(thePlayer, " *Guard Clark opens the door.", 255, 51, 102)
			exports.global:sendLocalText(thePlayer, "Guard Clark says: Hello " .. genderm .. " " .. getPlayerName(thePlayer):gsub("_", " ") .. ". You can walk inside.", nil, nil, nil, 10)
			open = true
			moveObject(objGateb, 1000, 372.7575,166.7212,1008.582,0,0,90)
			setTimer(closeImpoundDoorba, 5000, 1, thePlayer)
		end
	end
end
addCommandHandler("gate", useImpoundDoorb)

function closeImpoundDoorba(thePlayer)
	exports.global:sendLocalText(thePlayer, " *Guard Clark closes the door.", 255, 51, 102)
	moveObject(objGateb, 1000, 372.7575,166.7212,1008.582,0,0,-90)
	setTimer(resetState1ba, 1000, 1)
end


function resetState1ba()
	open = false
end
