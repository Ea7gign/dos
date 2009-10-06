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

function addCandidate( thePlayer, commandName, targetPlayer )
	if exports.global:isPlayerAdmin( thePlayer ) then
		if not targetPlayer then
			outputChatBox("SYNTAX: /" .. commandName .. " [player]", thePlayer, 255, 194, 14 )
		else
			local targetPlayer = exports.global:findPlayerByPartialNick( targetPlayer )
			if targetPlayer then
				if getElementData( targetPlayer, "loggedin" ) == 1 then
					mysql_free_result( mysql_query( handler, "UPDATE characters SET election_candidate = 1 WHERE id = " .. getElementData( targetPlayer, "dbid" ) ) )
					outputChatBox(getPlayerName( targetPlayer ) .. " is now a candidate for the election.", thePlayer, 0, 255, 0)
					candidates[ getElementData( targetPlayer, "dbid" ) ] = getPlayerName( targetPlayer )
					setElementData( getResourceRootElement( ), "candidates", candidates )
				else
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("No such player online.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler( "addcandidate", addCandidate )

function delCandidate( thePlayer, commandName, targetPlayer )
	if exports.global:isPlayerAdmin( thePlayer ) then
		if not targetPlayer then
			outputChatBox("SYNTAX: /" .. commandName .. " [player]", thePlayer, 255, 194, 14 )
		else
			local targetPlayer = exports.global:findPlayerByPartialNick( targetPlayer )
			if targetPlayer then
				if getElementData( targetPlayer, "loggedin" ) == 1 then
					mysql_free_result( mysql_query( handler, "UPDATE characters SET election_candidate = 0 WHERE id = " .. getElementData( targetPlayer, "dbid" ) ) )
					outputChatBox(getPlayerName( targetPlayer ) .. " is now no candidate for the election anymore.", thePlayer, 0, 255, 0)
					candidates[ getElementData( targetPlayer, "dbid" ) ] = nil
					setElementData( getResourceRootElement( ), "candidates", candidates )
				else
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("No such player online.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler( "delcandidate", delCandidate )

-- /resetpoll - deletes all votes
function resetPoll( thePlayer )
	if exports.global:isPlayerHeadAdmin( thePlayer ) then
		-- nobody voted for anyone
		mysql_free_result( mysql_query( handler, "UPDATE characters SET election_candidate = 0, election_canvote = 0, election_votedfor = 0" ) )
		candidates = { }
		setElementData( getResourceRootElement( ), "candidates", candidates )
		
		outputChatBox( "The poll has been reset.", thePlayer, 0, 255, 0 )
		
		setElementData( getResourceRootElement( ), "open", false )
	end
end
addCommandHandler( "resetpoll", resetPoll )

function openPoll( thePlayer )
	if exports.global:isPlayerAdmin( thePlayer ) then
		-- check if there is an open poll
		local result = mysql_query( handler, "SELECT COUNT(*) FROM characters WHERE election_canvote > 0" )
		if result then
			if tonumber( mysql_result( result, 1, 1 ) ) == 0 then -- noone can vote, evil
				-- grant permissions to vote if you have 12 hours ingame and a license
				mysql_free_result( mysql_query( handler, "UPDATE characters SET election_canvote = 1 WHERE hoursplayed > 12 AND car_license = 1 AND cked = 0" ) )
				
				outputChatBox( "The poll has been opened.", thePlayer, 0, 255, 0 )
			else -- people can vote already
				mysql_free_result( mysql_query( handler, "UPDATE characters SET election_canvote = 1 WHERE election_canvote > 0" ) )
				
				outputChatBox( "The poll has been re-opened.", thePlayer, 0, 255, 0 )
			end
			
			setElementData( getResourceRootElement( ), "open", true )
			
			mysql_free_result( result )
		else
			outputDebugString( mysql_error( handler ) )
			outputChatBox( "Failed to open the Poll.", thePlayer )
		end
	end
end
addCommandHandler( "openpoll", openPoll )

function closePoll( thePlayer )
	if exports.global:isPlayerAdmin( thePlayer ) then
		-- check if there is an open poll
		local result = mysql_query( handler, "SELECT COUNT(*) FROM characters WHERE election_canvote > 0" )
		if result then
			if tonumber( mysql_result( result, 1, 1 ) ) == 0 then -- noone can vote, can't stop
				outputChatBox( "There is no running poll!", thePlayer, 255, 0, 0 )
			else -- people can vote already
				mysql_free_result( mysql_query( handler, "UPDATE characters SET election_canvote = 2 WHERE election_canvote > 0" ) )
				
				outputChatBox( "The poll has been stopped.", thePlayer, 0, 255, 0 )
			end
			
			setElementData( getResourceRootElement( ), "open", false )
			
			mysql_free_result( result )
		else
			outputDebugString( mysql_error( handler ) )
			outputChatBox( "Failed to close the Poll.", thePlayer )
		end
	end
end
addCommandHandler( "closepoll", closePoll )