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

chDimension = 125
chInterior = 3
--employmentCollision = createColSphere(360.8212890625, 173.62351989746, 1009.109375, 5)
--setElementDimension(employmentCollision, chDimension)
--exports.pool:allocateElement(employmentCollision)

-- /employment at cityhall
--function employment(thePlayer, matchingDimension)
--	if matchingDimension then
--		local logged = getElementData(thePlayer, "loggedin")
--		
--		if (logged==1) then
--			if (isElementWithinColShape(thePlayer, employmentCollision)) then
--				triggerClientEvent(thePlayer, "onEmployment", thePlayer)
--			end
--		end
--	end
--end
--addEventHandler("onColShapeHit", employmentCollision, employment)

-- CALL BACKS FROM CLIENT

function onEmploymentServer()
	exports.global:sendLocalText(source, "Jessie Smith says: Hello, are you looking for a new job?", nil, nil, nil, 10)
	exports.global:sendLocalText(source, " *Jessie Smith hands over a list with jobs to " .. getPlayerName(source):gsub("_", " ") .. ".", 255, 51, 102)
end

addEvent("onEmploymentServer", true)
addEventHandler("onEmploymentServer", getRootElement(), onEmploymentServer)

function givePlayerJob(jobID)
	local charname = getPlayerName(source)
	
	setElementData(source, "job", jobID)
	mysql_free_result( mysql_query( handler, "UPDATE characters SET job=" .. jobID .. " WHERE id = " .. getElementData(source, "dbid") ) )
	
	exports.global:givePlayerAchievement(source, 30)

	if (jobID==4) then -- CITY MAINTENANCE
		exports.global:giveWeapon(source, 41, 1500, true)
		outputChatBox("Use this paint to paint over tags you find.", source, 255, 194, 14)
		setElementData(source, "tag", 9)
		mysql_free_result( mysql_query( handler, "UPDATE characters SET tag=9 WHERE id = " .. getElementData(source, "dbid") ) )
	end
end
addEvent("acceptJob", true)
addEventHandler("acceptJob", getRootElement(), givePlayerJob)

function quitJob(job)
	setElementData(source, "job", 0)
	mysql_free_result( mysql_query( handler, "UPDATE characters SET job=0 WHERE id = " .. getElementData(source, "dbid") ) )
	if job == 4 then
		setElementData(source, "tag", 1)
		mysql_free_result( mysql_query( handler, "UPDATE characters SET tag=1 WHERE id = " .. getElementData(source, "dbid") ) )
	end
end
addEvent("quitJob", true)
addEventHandler("quitJob", getRootElement(), quitJob)