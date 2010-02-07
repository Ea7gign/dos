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
	for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
		triggerEvent("savePlayer", value, "Save All")
	end
	if (handler) then
		mysql_close(handler)
	end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), closeMySQL)
-- ////////////////////////////////////
-- //			MYSQL END			 //
-- ////////////////////////////////////

tweapons = { }

function initWeapons()
	tweapons[source] = { }
	tweapons[source][1] = ""
	tweapons[source][2] = ""
end
addEventHandler("onPlayerJoin", getRootElement(), initWeapons)

function cleanWeapons(thePlayer)
	tweapons[thePlayer] = nil
end

function saveWeapons(thePlayer)
	if tweapons[thePlayer] then
		local weapons = tweapons[thePlayer][1]
		local ammo = tweapons[thePlayer][2]

		cleanWeapons(thePlayer)
		
		if (weapons~=false) and (ammo~=false) then
			local query = mysql_query(handler, "UPDATE characters SET weapons='" .. weapons .. "', ammo='" .. ammo .. "' WHERE id='" .. getElementData(source, "dbid") .. "'")
			mysql_free_result(query)
		end
	end
end

local count = 1
function syncWeapons(weapons, ammo)
	--outputDebugString("Got weapon sync packet #" .. count .. " FROM: " .. getPlayerName(source))
	count = count + 1
	tweapons[source] = { weapons, ammo }
end
addEvent("syncWeapons", true)
addEventHandler("syncWeapons", getRootElement(), syncWeapons)


function getWeapons(player)
	return tweapons[player] or { "", "" }
end

function saveAllPlayers()
	outputDebugString("WORLDSAVE INCOMING")
	for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
		triggerEvent("savePlayer", value, "Save All")
	end
end

function syncTIS()
	for key, value in ipairs(getElementsByType("player")) do
		local tis = getElementData(value, "timeinserver")
		if (tis) then
			setElementData(value, "timeinserver", tonumber(tis)+1, false)
		end
	end
end
setTimer(syncTIS, 60000, 0)

function savePlayer(reason, player)
	local logged = getElementData(source, "loggedin")

	if (logged==1 or reason=="Change Character") then
		saveWeapons(source)
		
		local vehicle = getPedOccupiedVehicle(source)
		
		if (vehicle) then
			local seat = getPedOccupiedVehicleSeat(source)
			triggerEvent("onVehicleExit", vehicle, source, seat)
		end
		
		local x, y, z, rot, health, armour, interior, dimension, cuffed, skin, duty, timeinserver, businessprofit
		
		local x, y, z = getElementPosition(source)
		local rot = getPedRotation(source)
		local health = getElementHealth(source)
		local armor = getPedArmor(source)
		local interior = getElementInterior(source)
		local dimension = getElementDimension(source)
		money = getElementData(source, "stevie.money")
		if money and money > 0 then
			money = 'money = money + ' .. money .. ', '
		else
			money = ''
		end
		skin = getElementModel(source)
		
		if getElementData(source, "help") then
			dimension, interior, x, y, z = unpack( getElementData(source, "help") )
		end
		
		-- Fix for #0000984
		if getElementData(source, "businessprofit") and ( reason == "Quit" or reason == "Timed Out" or reason == "Unknown" or reason == "Bad Connection" or reason == "Kicked" or reason == "Banned" ) then
			businessprofit = 'bankmoney = bankmoney + ' .. getElementData(source, "businessprofit") .. ', '
		else
			businessprofit = ''
		end
		
		-- Fix for freecam-tv
		if exports['freecam-tv']:isPlayerFreecamEnabled(source) then 
			x = getElementData(source, "tv:x")
			y = getElementData(source, "tv:y")
			z =  getElementData(source, "tv:z")
			interior = getElementData(source, "tv:int")
			dimension = getElementData(source, "tv:dim") 
		end
		
		local  timeinserver = getElementData(source, "timeinserver")
		-- LAST AREA
		local zone = exports.global:getElementZoneName(source)
		if not zone or #zone == 0 then
			zone = "Unknown"
		end
		
		local update = mysql_query(handler, "UPDATE characters SET x='" .. x .. "', y='" .. y .. "', z='" .. z .. "', rotation='" .. rot .. "', health='" .. health .. "', armor='" .. armor .. "', dimension_id='" .. dimension .. "', interior_id='" .. interior .. "', " .. money .. businessprofit .. "lastlogin=NOW(), lastarea='" .. mysql_escape_string(handler, zone) .. "', timeinserver='" .. timeinserver .. "' WHERE id=" .. getElementData(source, "dbid"))
		if (update) then
			mysql_free_result(update)
		else
			outputDebugString( "Saveplayer Update: " .. mysql_error( handler ) )
		end
		
		local update2 = mysql_query(handler, "UPDATE accounts SET lastlogin=NOW() WHERE id = " .. getElementData(source,"gameaccountid"))
		if (update2) then
			mysql_free_result(update2)
		else
			outputDebugString( "Saveplayer Update2: " .. mysql_error( handler2 ) )
		end
		
		--outputDebugString("Saved player '" .. getPlayerName(source) .. "' [" .. reason .. "].")
	end
end
addEventHandler("onPlayerQuit", getRootElement(), savePlayer)
addEvent("savePlayer", false)
addEventHandler("savePlayer", getRootElement(), savePlayer)
setTimer(saveAllPlayers, 3600000, 0)
addCommandHandler("saveall", function(p) if exports.global:isPlayerScripter(p) then saveAllPlayers() outputChatBox("Done.", p) end end)
addCommandHandler("saveme", function(p) triggerEvent("savePlayer", p, "Save Me") end)