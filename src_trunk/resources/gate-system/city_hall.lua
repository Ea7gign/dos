-- ////////////////////////////////////
-- //			MYSQL				 //
-- ////////////////////////////////////		
sqlUsername = exports.mysql:getMySQLUsername()
sqlPassword = exports.mysql:getMySQLPassword()
sqlDB = exports.mysql:getMySQLDBName()
sqlHost = exports.mysql:getMySQLHost()
sqlPort = exports.mysql:getMySQLPort()

handler = mysql_connect(sqlHost, sqlUsername, sqlPassword, sqlDB, sqlPort)

function checkMySQL()
	if not (mysql_ping(handler)) then
		handler = mysql_connect(sqlHost, sqlUsername, sqlPassword, sqlDB, sqlPort)
	end
end
setTimer(checkMySQL, 300000, 0)

function closeMySQL()
	if (handler) then
		mysql_close(handler)
	end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), closeMySQL)
-- ////////////////////////////////////
-- //			MYSQL END			 //
-- ////////////////////////////////////

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
setElementData( guard, "name", "Guard Jenkins" )

function useImpoundDoorb(thePlayer)
	if getElementDimension( thePlayer ) ~= getElementDimension( objGateb ) then return end
	
	local gender = getElementData(thePlayer, "gender")
	local genderm = "Sir"
	if (gender == 1) then
		genderm = "Ma'am"
	end
	
	local factionrank = getElementData(thePlayer,"factionrank")	
	local factionID = getElementData(thePlayer,"faction")
	local titleresult = mysql_query(handler, "SELECT rank_" .. factionrank .. " FROM factions WHERE id='" .. factionID .. "' LIMIT 1")
	if mysql_num_rows(titleresult) ~= 0 then
		genderm = tostring(mysql_result(titleresult, 1, 1))
	end
	mysql_free_result(titleresult)

	local team = getPlayerTeam(thePlayer)
	if (team==getTeamFromName("Government of Los Santos")) then
		local x, y, z = getElementPosition(thePlayer)
		local distance = getDistanceBetweenPoints3D(372.7575,166.7212,1008.582, x, y, z)

		if (distance<=3) and (open==false) then
			
			if (y <= 167) then
				exports.global:sendLocalText(thePlayer, "Guard Jenkins says: Hello " .. genderm .. "" .. string.match(getPlayerName(thePlayer):gsub("_", " "), " %a+") .. ". Have a good day.", nil, nil, nil, 10)
			else
				exports.global:sendLocalText(thePlayer, "Guard Jenkins says: Hello " .. genderm .. "" .. string.match(getPlayerName(thePlayer):gsub("_", " "), " %a+") .. ". Go on through.", nil, nil, nil, 10)
			end
			exports.global:sendLocalText(thePlayer, " *Guard Jenkins opens the door.", 255, 51, 102)
			open = true
			moveObject(objGateb, 1000, 372.7575,166.7212,1008.582,0,0,90)
			setTimer(closeImpoundDoorba, 5000, 1, thePlayer)
		end
	else
		exports.global:sendLocalText(thePlayer, "Guard Jenkins says: Sorry " .. genderm .. ", This is a restricted area, you cannot enter.", nil, nil, nil, 10)
	end
end
addCommandHandler("gate", useImpoundDoorb)
addEvent( "gateCityHall", true )
addEventHandler( "gateCityHall", getRootElement( ),
	function( )
		useImpoundDoorb( source )
	end
)

function closeImpoundDoorba(thePlayer)
	exports.global:sendLocalText(thePlayer, " *Guard Jenkins closes the door.", 255, 51, 102)
	moveObject(objGateb, 1000, 372.7575,166.7212,1008.582,0,0,-90)
	setTimer(resetState1ba, 1000, 1)
end


function resetState1ba()
	open = false
end
