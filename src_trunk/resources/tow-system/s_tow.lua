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

-- towing impound lot
local towSphere = createColPolygon(2789.131835, -1468.5177, 2789.131835, -1468.5177, 2789.133544, -1425.358398, 2820.9104, -1425.353027, 2820.912597, -1467.778808)
-- pd impound lot
local towSphere2 = createColPolygon(1540.209594, -1602.937377, 1540.209594, -1602.937377, 1590.368408, -1602.958251, 1583.952514, -1617.322265625, 1540.34082, -1617.087524)

function cannotVehpos(thePlayer)
	return isElementWithinColShape(thePlayer, towSphere) and getTeamName(getPlayerTeam(thePlayer)) ~= "Best's Towing and Recovery"
end

-- generic function to check if a guy is in the col polygon and the right team
function CanTowTruckDriverVehPos(thePlayer, commandName)
	local ret = 0
	if (isElementWithinColShape(thePlayer, towSphere) or isElementWithinColShape(thePlayer,towSphere2)) then
		if (getTeamName(getPlayerTeam(thePlayer)) == "Best's Towing and Recovery") then
			ret = 2
		else
			ret = 1
		end
	end
	return ret
end
--Auto Pay for PD
function CanTowTruckDriverGetPaid(thePlayer, commandName)
	if (isElementWithinColShape(thePlayer,towSphere2)) then
		if (getTeamName(getPlayerTeam(thePlayer)) == "Best's Towing and Recovery") then
			return true
		end
	end
	return false
end
function UnlockVehicle(element, matchingdimension)
	if (getElementType(element) == "vehicle" and getVehicleOccupant(element) and getTeamName(getPlayerTeam(getVehicleOccupant(element))) == "Best's Towing and Recovery" and getElementModel(element) == 525 and getVehicleTowedByVehicle(element)) then
		local temp = element
		while (getVehicleTowedByVehicle(temp)) do
			temp = getVehicleTowedByVehicle(temp)
			local owner = getElementData(temp, "owner")
			local faction = getElementData(temp, "faction")
			local dbid = getElementData(temp, "dbid")
			if (owner > 0) then
				if (faction > 3 or faction < 0) then
					if (source == towSphere2) then
						--PD make sure its not marked as impounded so it cannot be recovered and unlock/undp it
						setVehicleLocked(temp, false)
						setElementData(temp, "Impounded", 0)
						setElementData(temp, "enginebroke", 0, false)
						setVehicleDamageProof(temp, false)
						setVehicleEngineState(temp, false)
						outputChatBox("((Please remember to /park your vehicle in our car park.))", getVehicleOccupant(element), 255, 194, 14)
					else
						if (getElementData(temp, "faction") ~= 30) then
							--unlock it and impound it
							setVehicleLocked(temp, false)
							setElementData(temp, "Impounded", getRealTime().yearday)
							setElementData(temp, "enginebroke", 1, false)
							setVehicleEngineState(temp, false)
							outputChatBox("((Please remember to /park your vehicle in our car park.))", getVehicleOccupant(element), 255, 194, 14)
						end
					end
				else
					outputChatBox("This Faction's vehicle cannot be impounded.", getVehicleOccupant(element), 255, 194, 14)
				end
			end
		end
	end
end

addEventHandler("onColShapeHit", towSphere, UnlockVehicle)
addEventHandler("onColShapeHit", towSphere2, UnlockVehicle)

function payRelease(vehID)
	if exports.global:takeMoney(source, 75) then
		exports.global:giveMoney(getTeamFromName("Best's Towing and Recovery"), 75)
		setElementData(vehID, "Impounded", 0)
		setElementPosition(vehID, 2743.0905761719, -1462.744750, 33.453125)
		setVehicleLocked(vehID, true)
		setElementData(vehID, "enginebroke", 0, false)
		setVehicleDamageProof(vehID, false)
		setVehicleEngineState(vehID, false)
		updateVehPos(vehID)
		outputChatBox("Your vehicle has been released. (( Please remember to /park your vehicle so it does not respawn in our carpark. ))", source, 255, 194, 14)
	else
		outputChatBox("Insufficient Funds.", source, 255, 0, 0)
	end
end
addEvent("releaseCar", true)
addEventHandler("releaseCar", getRootElement(), payRelease)


function disableEntryToTowedVehicles(thePlayer, seat, jacked, door) 
	if (getVehicleTowingVehicle(source)) then
		outputChatBox("You cannot enter a vehicle being towed!", thePlayer, 255, 0, 0)
		cancelEvent()
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), disableEntryToTowedVehicles)

local releaseColShape = createColSphere(223.42578125, 114.265625, 1010.21875, 1)
function triggerShowImpound(element)
	local vehElements = {}
	local count = 1
	for key, value in ipairs(getElementsByType("vehicle")) do
		local dbid = getElementData(value, "dbid")
		if (getElementData(value, "Impounded") and getElementData(value, "Impounded") > 0 and ((dbid > 0 and exports.global:hasItem(element, 3, dbid) or (getElementData(value, "faction") == getElementData(element, "faction") and getElementData(value, "owner") == getElementData(element, "dbid"))))) then
			vehElements[count] = value
			count = count + 1
		end
	end

	triggerClientEvent( element, "ShowImpound", element, vehElements)
end
addEventHandler("onColShapeHit", releaseColShape, triggerShowImpound)

function updateVehPos(veh)
	local x, y, z = getElementPosition(veh)
	local rx, ry, rz = getVehicleRotation(veh)
		
	local interior = getElementInterior(veh)
	local dimension = getElementDimension(veh)
	local dbid = getElementData(veh, "dbid")	
	local query = mysql_query(handler, "UPDATE vehicles SET x='" .. x .. "', y='" .. y .."', z='" .. z .. "', rotx='" .. rx .. "', roty='" .. ry .. "', rotz='" .. rz .. "', currx='" .. x .. "', curry='" .. y .. "', currz='" .. z .. "', currrx='" .. rx .. "', currry='" .. ry .. "', currrz='" .. rz .. "', interior='" .. interior .. "', currinterior='" .. interior .. "', dimension='" .. dimension .. "', currdimension='" .. dimension .. "' WHERE id='" .. dbid .. "'")
	mysql_free_result(query)	
	setVehicleRespawnPosition(veh, x, y, z, rx, ry, rz)
	setElementData(veh, "respawnposition", {x, y, z, rx, ry, rz}, false)
end

function updateTowingVehicle(theTruck)
	local thePlayer = getVehicleOccupant(theTruck)
	if (getTeamName(getPlayerTeam(thePlayer)) == "Best's Towing and Recovery") then
		local owner = getElementData(source, "owner")
		local faction = getElementData(source, "faction")
		local carName = getVehicleName(source)
		
		if (owner<0) then
			outputChatBox("(( This " .. carName .. " is a civilian vehicle. ))", thePlayer, 255, 195, 14)
		elseif (faction==-1) and (owner>0) then
			local query = mysql_query(handler, "SELECT charactername FROM characters WHERE id='" .. owner .. "' LIMIT 1")
		
			if (mysql_num_rows(query)>0) then
				local ownerName = mysql_result(query, 1, 1)
				outputChatBox("(( This " .. carName .. " belongs to " .. ownerName .. ". ))", thePlayer, 255, 195, 14)
			end
			mysql_free_result(query)
		else
			local query = mysql_query(handler, "SELECT name FROM factions WHERE id='" .. faction .. "' LIMIT 1")
		
			if (mysql_num_rows(query)>0) then
				local ownerName = mysql_result(query, 1, 1)
				outputChatBox("(( This " .. carName .. " belongs to the " .. ownerName .. " faction. ))", thePlayer, 255, 195, 14)
			end
			mysql_free_result(query)
		end
	end
end

addEventHandler("onTrailerAttach", getRootElement(), updateTowingVehicle)

function updateCivilianVehicles(theTruck)
	if (isElementWithinColShape(theTruck, towSphere)) then
		local owner = getElementData(source, "owner")
		local faction = getElementData(source, "faction")
		local dbid = getElementData(source, "dbid")

		if (dbid >= 0 and faction == -1 and owner < 0) then
			exports.global:giveMoney(getTeamFromName("Best's Towing and Recovery"), 75)
			outputChatBox("The state has un-impounded the vehicle you where towing.", getVehicleOccupant(theTruck), 255, 194, 14)
			respawnVehicle(source)
		end
	end
end

addEventHandler("onTrailerDetach", getRootElement(), updateCivilianVehicles)