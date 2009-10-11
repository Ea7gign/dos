function doCheck(sourcePlayer, command, ...)
	if (exports.global:isPlayerAdmin(sourcePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. command .. " [Partial Player Name / ID]", sourcePlayer, 255, 194, 14)
		else
			local noob = exports.global:findPlayerByPartialNick(...)
			
			if noob and isElement(noob) then
				local ip = getPlayerIP(noob)
				local adminreports = tonumber(getElementData(noob, "adminreports"))
				local donatorlevel = exports.global:getPlayerDonatorTitle(noob)
				
				-- get admin note
				local note = ""
				local result = mysql_query( handler, "SELECT adminnote FROM accounts WHERE id = " .. tostring(getElementData(noob, "gameaccountid")) )
				if result then
					local text = mysql_result( result, 1, 1 )
					if text ~= mysql_null() then
						note = text
					end
					mysql_free_result( result )
				else
					outputDebugString( "Check Error: " .. mysql_error( handler ) )
				end
				
				-- get admin history count
				local history = '?'
				local result = mysql_query( handler, "SELECT COUNT(*) FROM adminhistory WHERE user = " .. tostring(getElementData(noob, "gameaccountid")) )
				if result then
					history = tonumber( mysql_result( result, 1, 1 ) ) or '?'
					mysql_free_result( result )
				else
					outputDebugString( "Check2 Error: " .. mysql_error( handler ) )
				end
				
				triggerClientEvent( sourcePlayer, "onCheck", noob, ip, adminreports, donatorlevel, note, history)
			else
				outputChatBox("No such player online.", sourcePlayer, 255, 194, 14)
			end
		end
	end
end
addCommandHandler("check", doCheck)

function savePlayerNote( target, text )
	if exports.global:isPlayerAdmin(source) then
		local account = getElementData(target, "gameaccountid")
		if account then
			local result = mysql_query( handler, "UPDATE accounts SET adminnote = '" .. mysql_escape_string( handler, text ) .. "' WHERE id = " .. account )
			if result then
				mysql_free_result( result )
				
				outputChatBox( "Note for the " .. getPlayerName( target ):gsub("_", " ") .. " (" .. getElementData( target, "gameaccountusername" ) .. ") has been updated.", source, 0, 255, 0 )
			else
				outputDebugString( "Save Note Error: " .. mysql_error( handler ) )
				outputChatBox( "Note Update failed.", source, 255, 0, 0 )
			end
		else
			outputChatBox( "Unable to get Account ID.", source, 255, 0, 0 )
		end
	end
end
addEvent( "savePlayerNote", true )
addEventHandler( "savePlayerNote", getRootElement(), savePlayerNote )

function showAdminHistory( target )
	if exports.global:isPlayerAdmin( source ) then
		local targetID = getElementData( target, "gameaccountid" )
		if targetID then
			local result = mysql_query( handler, "SELECT date, action, reason, duration, a.username, user_char FROM adminhistory h LEFT JOIN accounts a ON a.id = h.admin WHERE user = " .. targetID .. " ORDER BY h.id DESC" )
			if result then
				local info = {}
				for res, row in mysql_rows( result ) do
					table.insert( info, row )
				end
				
				triggerClientEvent( source, "cshowAdminHistory", target, info )
				mysql_free_result( result )
			else
				outputDebugString( "History: " .. mysql_error( handler ) )
				outputChatBox( "Failed to retrieve history.", source, 255, 0, 0)
			end
		else
			outputChatBox("Unable to find the account id.", source, 255, 0, 0)
		end
	end
end
addEvent( "showAdminHistory", true )
addEventHandler( "showAdminHistory", getRootElement(), showAdminHistory )

addCommandHandler( "history", 
	function( thePlayer, commandName, ... )
		if exports.global:isPlayerAdmin( thePlayer ) then
			if not (...) then
				outputChatBox("SYNTAX: /" .. commandName .. " [player]", thePlayer, 255, 194, 14)
			else
				local targetPlayer = exports.global:findPlayerByPartialNick(...)
				if not targetPlayer then
					outputChatBox("No such player online.", thePlayer, 255, 194, 14)
				else
					triggerEvent("showAdminHistory", thePlayer, targetPlayer)
				end
			end
		end
	end
)

function deleteall()
	for key, value in ipairs(getElementChildren(getRootElement())) do
		local element = getElementType(value)
		
		if (element=="pickup" or element=="ped" or element=="vehicle" or element=="marker" or element=="colshape") then
			destroyElement(value)
		end
	end
end
addCommandHandler("deleteall", deleteall)