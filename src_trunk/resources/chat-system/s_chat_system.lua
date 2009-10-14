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
	if (handler~=nil) then
		mysql_close(handler)
	end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), closeMySQL)
-- ////////////////////////////////////
-- //			MYSQL END			 //
-- ////////////////////////////////////
function trunklateText(thePlayer, text, factor)
	if getElementData(thePlayer,"alcohollevel") and getElementData(thePlayer,"alcohollevel") > 0 then
		local level = math.ceil( getElementData(thePlayer,"alcohollevel") * #text / ( factor or 5.5 ) )
		for i = 1, level do
			x = math.random( 1, #text )
			-- dont replace spaces
			if text.sub( x, x ) == ' ' then
				i = i - 1
			else
				local a, b = text:sub( 1, x - 1 ) or "", text:sub( x + 1 ) or ""
				local c = ""
				if math.random( 1, 6 ) == 1 then
					c = string.char(math.random(65,90))
				else
					c = string.char(math.random(97,122))
				end
				text = a .. c .. b
			end
		end
	end
	return text
end

function getElementDistance( a, b )
	if not isElement(a) or not isElement(b) then
		return math.huge
	else
		local x, y, z = getElementPosition( a )
		return getDistanceBetweenPoints3D( x, y, z, getElementPosition( b ) )
	end
end

local gpn = getPlayerName
function getPlayerName(p)
	return gpn(p):gsub("_", " ")
end

-- /ad
function advertMessage(thePlayer, commandName, showNumber, ...)
	local logged = tonumber(getElementData(thePlayer, "loggedin"))
	 
	if (logged==1) then
		if not (...) or not (showNumber) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Show Phone Number 0/1] [Message]", thePlayer, 255, 194, 14)
		elseif getElementData(thePlayer, "adminjailed") then
			outputChatBox("You cannot advertise in jail.", thePlayer, 255, 0, 0)
		elseif getElementData(thePlayer, "alcohollevel") and getElementData(thePlayer, "alcohollevel") ~= 0 then
			outputChatBox("You are too drunk to advertise!", thePlayer, 255, 0, 0)
		else
			if (exports.global:hasItem(thePlayer, 2)) then
				message = table.concat({...}, " ")
				if showNumber ~= "0" and showNumber ~= "1" then
					message = showNumber .. " " .. message
					showNumber = 0
				end
				
				local cost = math.ceil(string.len(message)/6)
				if exports.global:takeMoney(thePlayer, cost) then
					local name = getPlayerName(thePlayer)
					local phoneNumber = getElementData(thePlayer, "cellnumber")
					
					exports.logs:logMessage("ADVERT: " .. message .. ". ((" .. name .. "))", 2)
					for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
						if (getElementData(value, "loggedin")==1) then
							outputChatBox("   ADVERT: " .. message .. ". ((" .. name .. "))", value, 0, 255, 64)
							
							if (tonumber(showNumber)==1) then
								outputChatBox("   Contact: #" .. phoneNumber .. ".", value, 0, 255, 64)
							end
						end
					end
					outputChatBox("Thank you for placing your advert. Total Cost: $" .. cost .. ".", thePlayer)
				else
					outputChatBox("You cannot afford to place such an advert, try making it smaller.", thePlayer)
				end
			else
				outputChatBox("You do not have a cellphone to call the advertisement agency.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("ad", advertMessage, false, false)
					
-- Main chat: Local IC, Me Actions & Faction IC Radio
function localIC(source, message, language)
	local x, y, z = getElementPosition(source)
	local playerName = getPlayerName(source)
	
	message = string.gsub(message, "#%x%x%x%x%x%x", "") -- Remove colour codes
	local languagename = call(getResourceFromName("language-system"), "getLanguageName", language)
	message = trunklateText( source, message )
	
	-- Show chat to console, for admins + log
	exports.irc:sendMessage("[IC: Local Chat] " .. playerName .. ": " .. message)
	exports.logs:logMessage("[IC: Local Chat] " .. playerName .. ": " .. message, 1)
	outputChatBox( "#EEEEEE [" .. languagename .. "] " .. playerName .. " Says: " .. message, source, 133, 44, getElementData(source, "chatbubbles") == 2 and 89 or 88, true)
	
	local dimension = getElementDimension(source)
	local interior = getElementInterior(source)
	
	for key, nearbyPlayer in ipairs(getElementsByType( "player" )) do
		local dist = getElementDistance( source, nearbyPlayer )

		if dist < 20 then
			local nearbyPlayerDimension = getElementDimension(nearbyPlayer)
			local nearbyPlayerInterior = getElementInterior(nearbyPlayer)

			if (nearbyPlayerDimension==dimension) and (nearbyPlayerInterior==interior) then
				local logged = tonumber(getElementData(nearbyPlayer, "loggedin"))
				if not (isPedDead(nearbyPlayer)) and (logged==1) and (nearbyPlayer~=source) then
					local message2 = call(getResourceFromName("language-system"), "applyLanguage", source, nearbyPlayer, message, language)
					message2 = trunklateText( nearbyPlayer, message2 )
					
					--local mode = tonumber(getElementData(nearbyPlayer, "chatbubbles"))
					--if mode > 0 then
						--triggerClientEvent(nearbyPlayer, "onMessageIncome", source, message2, mode)
					--end
					
					if dist < 4 then
						outputChatBox( "#EEEEEE [" .. languagename .. "] " .. playerName .. " Says: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
					elseif dist < 8 then
						outputChatBox( "#DDDDDD [" .. languagename .. "] " .. playerName .. " Says: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
					elseif dist < 12 then
						outputChatBox( "#CCCCCC [" .. languagename .. "] " .. playerName .. " Says: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
					elseif dist < 16 then
						outputChatBox( "#BBBBBB [" .. languagename .. "] " .. playerName .. " Says: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
					else
						outputChatBox( "#AAAAAA [" .. languagename .. "] " .. playerName .. " Says: " .. message2, nearbyPlayer, 133, 44, getElementData(nearbyPlayer, "chatbubbles") > 0 and 89 or 88, true)
					end
				end
			end
		end
	end
end
for i = 1, 3 do
	addCommandHandler( tostring( i ), 
		function( thePlayer, commandName, ... )
			local lang = tonumber( getElementData( thePlayer, "languages.lang" .. i ) )
			if lang ~= 0 then
				localIC( thePlayer, table.concat({...}, " "), lang )
			end
		end
	)
end

function chatMain(message, messageType)
	local logged = getElementData(source, "loggedin")
	
	if not (isPedDead(source)) and (logged==1) and not (messageType==2) then -- Player cannot chat while dead or not logged in, unless its OOC
		local dimension = getElementDimension(source)
		local interior = getElementInterior(source)
		-- Local IC
		if (messageType==0) then
			local languageslot = getElementData(source, "languages.current")
			local language = getElementData(source, "languages.lang" .. languageslot)
			localIC(source, message, language)
		elseif (messageType==1) then -- Local /me action
		
			if not (message) then
				outputChatBox("SYNTAX: /me [Action]", source, 255, 194, 14)
			else
				exports.irc:sendMessage("[IC OOC: ME ACTION] *" .. getPlayerName(source) .. " " .. message)
				exports.logs:logMessage("[IC OOC: ME ACTION] *" .. getPlayerName(source) .. " " .. message, 7)
				
				exports.global:sendLocalMeAction(source, message)
			end
		end
	elseif (messageType==2) and (logged==1) then -- Radio
		if (exports.global:hasItem(source, 6)) then
			local theChannel = getElementData(source, "radiochannel")
			if theChannel > 0 then
				triggerClientEvent (source, "playRadioSound", getRootElement())
				local username = getPlayerName(source)
				local languageslot = getElementData(source, "languages.current")
				local language = getElementData(source, "languages.lang" .. languageslot)
				local languagename = call(getResourceFromName("language-system"), "getLanguageName", language)
				
				-- get faction rank title
				local result = mysql_query(handler, "SELECT faction_id, faction_rank FROM characters WHERE id = " .. getElementData(source, "dbid") .. " LIMIT 1")
									
				local factionID = tonumber(mysql_result(result, 1, 1))
				local factionRank = tonumber(mysql_result(result, 1, 2))
				mysql_free_result(result)
									
				local titleresult = mysql_query(handler, "SELECT rank_" .. factionRank .. " FROM factions WHERE id='" .. factionID .. "' LIMIT 1")
				if mysql_num_rows(titleresult) == 0 then
					factionRankTitle = ""
				else
					factionRankTitle = tostring(mysql_result(titleresult, 1, 1)) .. " - "
				end
				mysql_free_result(titleresult)
				
				message = trunklateText( source, message )
				outputChatBox("[" .. languagename .. "] [RADIO #" .. theChannel .. "] " .. factionRankTitle .. username .. " says: " .. message, source, 0, 102, 255)
				
				for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
					local targetChannel = getElementData(value, "radiochannel")
					local logged = getElementData(source, "loggedin")
					
					if (logged==1) and (targetChannel) and (exports.global:hasItem(value, 6)) and (value~=source) then
						if (targetChannel==theChannel) then
							triggerClientEvent (value, "playRadioSound", getRootElement())

							local message2 = call(getResourceFromName("language-system"), "applyLanguage", source, value, message, language)
							outputChatBox("[" .. languagename .. "] [RADIO #" .. theChannel .. "] " .. factionRankTitle .. username .. " says: " .. trunklateText( value, message2 ), value, 0, 102, 255)
							
							-- Show it to people near who can hear his radio
							for k, v in ipairs(getElementsByType("player")) do
								if getElementDistance(value, v) < 10 then
									local channel = getElementData(v, "radiochannel")
									if (v~=source) and (channel~=targetChannel) then
										local message2 = call(getResourceFromName("language-system"), "applyLanguage", source, v, message, language)
										outputChatBox("[" .. languagename .. "] " .. getPlayerName(value) .. "'s Radio: " .. trunklateText( v, message2 ), v, 255, 255, 255)
									end
								end
							end
							
						end
					end
				end
				
				-- Show the radio to nearby listening in people near the speaker
				for key, value in ipairs(getElementsByType("player")) do
					if getElementDistance(source, value) < 10 then
						if (value~=source) then
							local message2 = call(getResourceFromName("language-system"), "applyLanguage", source, value, message, language)
							outputChatBox("[" .. languagename .. "] " .. getPlayerName(source) .. " [RADIO] Says: " .. message2, value, 255, 255, 255)
						end
					end
				end
			else
				outputChatBox("Your radio is off. ((/toggleradio))", source, 255, 0, 0)
			end
		else
			outputChatBox("You do not have a radio.", source, 255, 0, 0)
		end
	end
end
addEventHandler("onPlayerChat", getRootElement(), chatMain)

function radio(thePlayer, commandName, ...)
	if (...) then
		local message = table.concat({...}, " ")
		triggerEvent("onPlayerChat", thePlayer, message, 2)
	else
		outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
	end
end
addCommandHandler("r", radio, false, false)
addCommandHandler("radio", radio, false, false)

function govAnnouncement(thePlayer, commandName, ...)
	local theTeam = getPlayerTeam(thePlayer)
	
	if (theTeam) then
		local teamID = tonumber(getElementData(theTeam, "id"))
	
		if (teamID==1 or teamID==2 or teamID==4) then
			local message = table.concat({...}, " ")
			
			local result = mysql_query(handler, "SELECT faction_id, faction_rank FROM characters WHERE id=" .. getElementData(thePlayer, "dbid") .. " LIMIT 1")
								
			local factionID = tonumber(mysql_result(result, 1, 1))
			local factionRank = tonumber(mysql_result(result, 1, 2))
			
			if (factionRank<10) then
				outputChatBox("You do not have permission to use this command.", thePlayer, 255, 0, 0)
			elseif #message == 0 then
				outputChatBox("SYNTAX: " .. commandName .. " [message]", thePlayer, 255, 194, 14)
			else
				mysql_free_result(result)
				
				local factionRankTitle
				local titleresult = mysql_query(handler, "SELECT rank_" .. factionRank .. " FROM factions WHERE id='" .. factionID .. "' LIMIT 1")
				if not mysql_result(titleresult, 1, 1) then
					factionRankTitle = ""
				else
					factionRankTitle = tostring(mysql_result(titleresult, 1, 1))
				end
				mysql_free_result(titleresult)
				
				for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
					local logged = getElementData(value, "loggedin")
					
					if (logged==1) then
						outputChatBox(">> Government Announcement from " .. factionRankTitle .. " " .. getPlayerName(thePlayer), value, 0, 183, 239)
						outputChatBox(message, value, 0, 183, 239)
					end
				end
			end
		end
	end
end
addCommandHandler("gov", govAnnouncement)

function departmentradio(thePlayer, commandName, ...)
	local theTeam = getPlayerTeam(thePlayer)
	
	if (theTeam) then
		local teamID = tonumber(getElementData(theTeam, "id"))

		if (teamID==1 or teamID==2 or teamID==4 or teamID == 30) then
			if (...) then
				local message = trunklateText( thePlayer, table.concat({...}, " ") )
				local PDFaction = getPlayersInTeam(getTeamFromName("Los Santos Police Department"))
				local ESFaction = getPlayersInTeam(getTeamFromName("Los Santos Emergency Services"))
				local TowFaction = getPlayersInTeam(getTeamFromName("Best's Towing and Recovery"))
				local playerName = getPlayerName(thePlayer)
				
				for key, value in ipairs(PDFaction) do
					outputChatBox("[DEPARTMENT RADIO] " .. playerName .. " says: " .. message, value, 0, 102, 255)
				end
				
				for key, value in ipairs(ESFaction) do
					outputChatBox("[DEPARTMENT RADIO] " .. playerName .. " says: " .. message, value, 0, 102, 255)
				end
				
				for key, value in ipairs(TowFaction) do
					outputChatBox("[DEPARTMENT RADIO] " .. playerName .. " says: " .. message, value, 0, 102, 255)
				end
			else
				outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
			end
		end
	end
end
addCommandHandler("d", departmentradio, false, false)
addCommandHandler("department", departmentradio, false, false)

function blockChatMessage()
    cancelEvent()
end

addEventHandler("onPlayerChat", getRootElement(), blockChatMessage)
-- End of Main Chat

function globalOOC(thePlayer, commandName, ...)
	local logged = tonumber(getElementData(thePlayer, "loggedin"))
	
	if (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local oocEnabled = exports.global:getOOCState()
			message = table.concat({...}, " ")
			local muted = getElementData(thePlayer, "muted")
			if (oocEnabled==0) and not (exports.global:isPlayerAdmin(thePlayer)) then
				outputChatBox("OOC Chat is currently disabled.", thePlayer, 255, 0, 0)
			elseif (muted==1) then
				outputChatBox("You are currenty muted from the OOC Chat.", thePlayer, 255, 0, 0)
			else	
				local players = exports.pool:getPoolElementsByType("player")
				local playerName = getPlayerName(thePlayer)
				local playerID = getElementData(thePlayer, "playerid")
					
				exports.irc:sendMessage("[OOC: Global Chat] " .. playerName .. ": " .. message)
				exports.logs:logMessage("[OOC: Global Chat] " .. playerName .. ": " .. message, 1)
				for k, arrayPlayer in ipairs(players) do
					local logged = tonumber(getElementData(arrayPlayer, "loggedin"))
					local targetOOCEnabled = getElementData(arrayPlayer, "globalooc")

					if (logged==1) and (targetOOCEnabled==1) then
						outputChatBox("(( (" .. playerID .. ") " .. playerName .. ": " .. message .. " ))", arrayPlayer, 196, 255, 255)
					end
				end
			end
		end
	end
end
addCommandHandler("o", globalOOC, false, false)
addCommandHandler("GlobalOOC", globalOOC)

function playerToggleOOC(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		local playerOOCEnabled = getElementData(thePlayer, "globalooc")
		
		if (playerOOCEnabled==1) then
			outputChatBox("You have now hidden Global OOC Chat.", thePlayer, 255, 194, 14)
			setElementData(thePlayer, "globalooc", 0, false)
		else
			outputChatBox("You have now enabled Global OOC Chat.", thePlayer, 255, 194, 14)
			setElementData(thePlayer, "globalooc", 1, false)
		end
		mysql_free_result( mysql_query( handler, "UPDATE accounts SET globalooc=" .. getElementData(thePlayer, "globalooc") .. " WHERE id = " .. getElementData(thePlayer, "gameaccountid") ) )
	end
end
addCommandHandler("toggleooc", playerToggleOOC, false, false)


local advertisementMessages = { "sincityrp", "ls-rp", "sincity", "eg", "tri0n3", "www.", ".com", ".net", ".co.uk", ".org", "Bryan", "Danny", "everlast", "neverlast", "www.everlastgaming.com"}

function isFriendOf(thePlayer, targetPlayer)
	local friends = getElementData(targetPlayer, "friends")
	if friends then
		local targetID = tonumber( getElementData( thePlayer, "gameaccountid" ) )
		if friends[ targetID ] then
			return true
		end
	end
	return false
end

function pmPlayer(thePlayer, commandName, who, ...)

		if not (who) or not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick] [Message]", thePlayer, 255, 194, 14)
		else
			message = table.concat({...}, " ")
			local targetPlayer = exports.global:findPlayerByPartialNick(who)
			
			if (targetPlayer) then
				local logged = getElementData(targetPlayer, "loggedin")
				local pmblocked = getElementData(targetPlayer, "pmblocked")

				if not (pmblocked) then
					pmblocked = 0
					setElementData(targetPlayer, "pmblocked", 0, false)
				end
				
				if (logged==1) and (pmblocked==0 or exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer) or getElementData(thePlayer, "reportadmin") == targetPlayer or isFriendOf(thePlayer, targetPlayer)) then
					local playerName = getPlayerName(thePlayer)
					local targetPlayerName = getPlayerName(targetPlayer)
					
					if not exports.global:isPlayerScripter(thePlayer) and not exports.global:isPlayerScripter(targetPlayer) then
						-- Check for advertisements
						for k,v in ipairs(advertisementMessages) do
							local found = string.find(string.lower(message), "%s" .. tostring(v))
							local found2 = string.find(string.lower(message), tostring(v) .. "%s")
							if (found) or (found2) or (string.lower(message)==tostring(v)) then
								exports.global:sendMessageToAdmins("AdmWrn: " .. tostring(playerName) .. " sent a possible advertisement PM to " .. tostring(targetPlayerName) .. ".")
								exports.global:sendMessageToAdmins("AdmWrn: Message: " .. tostring(message))
								break
							end
						end
					end
					
					-- Send the message
					local playerid = getElementData(thePlayer, "playerid")
					local targetid = getElementData(targetPlayer, "playerid")
					outputChatBox("PM From (" .. playerid .. ") " .. playerName .. ": " .. message, targetPlayer, 255, 255, 0)
					outputChatBox("PM Sent to (" .. targetid .. ") " .. targetPlayerName .. ": " .. message, thePlayer, 255, 255, 0)
					
					exports.logs:logMessage("[PM From " ..playerName .. " TO " .. targetPlayerName .. "]" .. message, 8)
					
					if not exports.global:isPlayerScripter(thePlayer) and not exports.global:isPlayerScripter(targetPlayer) then
						-- big ears
						local received = {}
						received[thePlayer] = true
						received[targetPlayer] = true
						for key, value in pairs( getElementsByType( "player" ) ) do
							if isElement( value ) and not received[value] then
								local listening = getElementData( value, "bigears" )
								if listening == thePlayer or listening == targetPlayer then
									received[value] = true
									outputChatBox("(" .. playerid .. ") " .. playerName .. " -> (" .. targetid .. ") " .. targetPlayerName .. ": " .. message, value, 255, 255, 0)
								end
							end
						end
					end
				elseif (logged==0) then
					outputChatBox("Player is not logged in yet.", thePlayer, 255, 255, 0)
				elseif (pmblocked==1) then
					outputChatBox("Player is ignoring whispers!", thePlayer, 255, 255, 0)
				end
			else
				outputChatBox("Player not found or multiple were found.", thePlayer, 255, 255, 0)
			end
		end
end
addCommandHandler("pm", pmPlayer, false, false)

function localOOC(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
		
	if (logged==1) and not (isPedDead(thePlayer)) then
		local muted = getElementData(thePlayer, "muted")
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		elseif (muted==1) then
			outputChatBox("You are currenty muted from the OOC Chat.", thePlayer, 255, 0, 0)
		else
			exports.global:sendLocalText(thePlayer, getPlayerName(thePlayer) .. ": (( " .. table.concat({...}, " ") .. " ))", 196, 255, 255)
		end
	end
end
addCommandHandler("b", localOOC, false, false)
addCommandHandler("LocalOOC", localOOC)

function districtIC(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
		
	if (logged==1) and not (isPedDead(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local playerName = getPlayerName(thePlayer)
			local message = table.concat({...}, " ")
			local zonename = exports.global:getElementZoneName(thePlayer)
			
			for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
				local playerzone = exports.global:getElementZoneName(value)
				local playerdimension = getElementDimension(value)
				local playerinterior = getElementInterior(value)
				
				if (zonename==playerzone) and (dimension==playerdimension) and (interior==playerinterior) then
					local logged = getElementData(value, "loggedin")
					if (logged==1) then
						outputChatBox("District IC: " .. message .. " ((".. playerName .."))", value, 255, 255, 255)
					end
				end
			end
		end
	end
end
addCommandHandler("district", districtIC, false, false)

function localDo(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
		
	if not (isPedDead(thePlayer)) and (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Action/Event]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			exports.irc:sendMessage("[IC: Local Do] * " .. message .. " *      ((" .. getPlayerName(thePlayer) .. "))")
			exports.global:sendLocalDoAction(thePlayer, message)
		end
	end
end
addCommandHandler("do", localDo, false, false)


function localShout(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
		
	if not (isPedDead(thePlayer)) and (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local playerName = getPlayerName(thePlayer)
			
			local languageslot = getElementData(thePlayer, "languages.current")
			local language = getElementData(thePlayer, "languages.lang" .. languageslot)
			local languagename = call(getResourceFromName("language-system"), "getLanguageName", language)
			
			local message = trunklateText(thePlayer, table.concat({...}, " "))
			outputChatBox("[" .. languagename .. "] " .. playerName .. " shouts: " .. message .. "!!", thePlayer, 255, 255, 255)
			
			exports.irc:sendMessage("[IC: Local Shout] " .. playerName .. ": " .. message)
			exports.logs:logMessage("[IC: Local Shout] " .. playerName .. ": " .. message, 1)
			for index, nearbyPlayer in ipairs(getElementsByType("player")) do
				if getElementDistance( thePlayer, nearbyPlayer ) < 40 then
					local nearbyPlayerDimension = getElementDimension(nearbyPlayer)
					local nearbyPlayerInterior = getElementInterior(nearbyPlayer)
					
					if (nearbyPlayerDimension==dimension) and (nearbyPlayerInterior==interior) and (nearbyPlayer~=thePlayer) then
						local logged = getElementData(nearbyPlayer, "loggedin")
						
						if (logged==1) and not (isPedDead(nearbyPlayer)) then
							--local mode = tonumber(getElementData(nearbyPlayer, "chatbubbles"))
							local message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, nearbyPlayer, message, language)
							message2 = trunklateText(nearbyPlayer, message2)
							--if mode > 0 then
							--	triggerClientEvent(nearbyPlayer, "onMessageIncome", thePlayer, message2, mode)
							--end
							outputChatBox("[" .. languagename .. "] " .. playerName .. " shouts: " .. message2 .. "!!", nearbyPlayer, 255, 255, 255)
						end
					end
				end
			end
		end
	end
end
addCommandHandler("s", localShout, false, false)

function megaphoneShout(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
		
	if not (isPedDead(thePlayer)) and (logged==1) then
		local faction = getPlayerTeam(thePlayer)
		local factiontype = getElementData(faction, "type")
		
		if (factiontype==2) or (factiontype==3) or (factiontype==4) then
			if not (...) then
				outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
			else
				local playerName = getPlayerName(thePlayer)
				local message = trunklateText(thePlayer, table.concat({...}, " "))
				
				exports.irc:sendMessage("[IC: Megaphone] " .. playerName .. ": " .. message)
				
				local languageslot = getElementData(thePlayer, "languages.current")
				local language = getElementData(thePlayer, "languages.lang" .. languageslot)
				local langname = call(getResourceFromName("language-system"), "getLanguageName", language)
				
				for index, nearbyPlayer in ipairs(getElementsByType("player")) do
					if getElementDistance( thePlayer, nearbyPlayer ) < 40 then
						local nearbyPlayerDimension = getElementDimension(nearbyPlayer)
						local nearbyPlayerInterior = getElementInterior(nearbyPlayer)
						
						if (nearbyPlayerDimension==dimension) and (nearbyPlayerInterior==interior) then
							local logged = getElementData(nearbyPlayer, "loggedin")
						
							if (logged==1) and not (isPedDead(nearbyPlayer)) then
								local message2 = message
								if nearbyPlayer ~= thePlayer then
									message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, nearbyPlayer, message, language)
								end
								outputChatBox(" [" .. langname .. "] ((" .. playerName .. ")) Megaphone <O: " .. trunklateText(nearbyPlayer, message2), nearbyPlayer, 255, 255, 0)
							end
						end
					end
				end
			end
		else
			outputChatBox("Believe it or not, it's hard to shout through a megaphone you do not have.", thePlayer, 255, 0 , 0)
		end
	end
end
addCommandHandler("m", megaphoneShout, false, false)
	
function factionOOC(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local theTeam = getPlayerTeam(thePlayer)
			local theTeamName = getTeamName(theTeam)
			local playerName = getPlayerName(thePlayer)
			
			if not(theTeam) or (theTeamName=="Citizen") then
				outputChatBox("You are not in a faction.", thePlayer)
			else
				local message = table.concat({...}, " ")
				
				if (theTeamName=="Los Santos Police Department") then
					exports.logs:logMessage("[OOC: Faction Chat] " .. playerName .. ": " .. message, 6)
				end
			
				for index, arrayPlayer in ipairs( getElementsByType( "player" ) ) do
					if isElement( arrayPlayer ) then
						if getElementData( arrayPlayer, "bigearsfaction" ) == theTeam then
							outputChatBox("((" .. theTeamName .. ")) " .. playerName .. ": " .. message, arrayPlayer, 3, 157, 157)
						elseif getPlayerTeam( arrayPlayer ) == theTeam and getElementData(thePlayer, "loggedin") == 1 then
							outputChatBox("((OOC Faction Chat)) " .. playerName .. ": " .. message, arrayPlayer, 3, 237, 237)
						end
					end
				end
			end
		end
	end
end
addCommandHandler("f", factionOOC, false, false)

function setRadioChannel(thePlayer, commandName, channel)
	channel = tonumber( channel )
	if not (channel) then
		outputChatBox("SYNTAX: /" .. commandName .. " [Channel Number]", thePlayer, 255, 194, 14)
	else
		if (exports.global:hasItem(thePlayer, 6)) then
			if getElementData(thePlayer, "radiochannel") > 0 then
				local channel = tonumber(channel)
				if channel > 0 then
					setElementData(thePlayer, "radiochannel", channel, false)
					outputChatBox("You retuned your radio to channel #" .. channel .. ".", thePlayer)
					exports.global:sendLocalMeAction(thePlayer, "retunes their radio.")
					mysql_free_result( mysql_query( handler, "UPDATE characters SET radiochannel=" .. channel .. " WHERE id = " .. getElementData(thePlayer, "dbid") ) )
				else
					outputChatBox("You can't tune your radio to that frequency!", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("Your radio is off. ((/toggleradio))", thePlayer, 255, 0, 0)
			end
		else
			outputChatBox("You do not have a radio!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("tuneradio", setRadioChannel, false, false)

function toggleRadio(thePlayer, commandName)
	if (exports.global:hasItem(thePlayer, 6)) then
		local gender = getElementData(thePlayer, "gender")
		local genderm = "his"
		if (gender == 1) then
			genderm = "her"
		end
		
		local channel = getElementData(thePlayer, "radiochannel")
		if not channel or channel == 0 then
			channel = 1
		else
			channel = -channel
		end
		if channel > 0 then
			outputChatBox("You turned your radio on.", thePlayer, 255, 194, 14)
			exports.global:sendLocalMeAction(thePlayer, "turns " .. genderm .. " radio on.")
		else
			outputChatBox("You turned your radio off.", thePlayer, 255, 194, 14)
			exports.global:sendLocalMeAction(thePlayer, "turns " .. genderm .. " radio off.")
		end
		setElementData(thePlayer, "radiochannel", channel, false)
	else
		outputChatBox("You do not have a radio!", thePlayer, 255, 0, 0)
	end
end
addCommandHandler("toggleradio", toggleRadio, false, false)

-- Admin chat
function adminChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and (exports.global:isPlayerAdmin(thePlayer))  then
		if not (...) then
			outputChatBox("SYNTAX: /a [Message]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
			exports.logs:logMessage("[Admin Chat] " .. username .. ": " .. message, 3)
			
			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				
				if(exports.global:isPlayerAdmin(arrayPlayer)) and (logged==1) then
					outputChatBox(adminTitle .. " " .. username .. ": " .. message, arrayPlayer, 51, 255, 102)
				end
			end
		end
	end
end

addCommandHandler("a", adminChat, false, false)


-- Scripter Chat
function scripterChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and (exports.global:isPlayerScripter(thePlayer))  then
		if not (...) then
			outputChatBox("SYNTAX: /s [Message]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)
			
			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				
				if(exports.global:isPlayerScripter(arrayPlayer)) and (logged==1) then
					outputChatBox("~" .. username .. "~ " .. message, arrayPlayer, 255, 255, 128)
				end
			end
		end
	end
end
addCommandHandler("ss", scripterChat, false, false)
addCommandHandler("sc", scripterChat, false, false)

-- Admin announcement
function adminAnnouncement(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and (exports.global:isPlayerAdmin(thePlayer))  then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)

			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				
				if (logged) then
					if exports.global:isPlayerAdmin(arrayPlayer) then
						outputChatBox( "Admin Announcement by " .. getPlayerName(thePlayer) .. ":", arrayPlayer, 255, 194, 14)
					end
					outputChatBox("   *** " .. message .. " ***", arrayPlayer, 255, 194, 14)
				end
			end
			exports.irc:sendMessage("[OOC ANNOUNCEMENT] " .. username .. ": " .. message)
		end
	end
end
addCommandHandler("ann", adminAnnouncement, false, false)

function leadAdminChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and (exports.global:isPlayerLeadAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)

			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				
				if (exports.global:isPlayerLeadAdmin(arrayPlayer)) and (logged==1) then
					outputChatBox("*4+* " ..adminTitle .. " " .. username .. ": " .. message, arrayPlayer, 204, 102, 255)
				end
			end
		end
	end
end

addCommandHandler("l", leadAdminChat, false, false)

function headAdminChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and (exports.global:isPlayerHeadAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)

			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				
				if(exports.global:isPlayerHeadAdmin(arrayPlayer)) and (logged==1) then
					outputChatBox("*5+* " ..adminTitle .. " " .. username .. ": " .. message, arrayPlayer, 255, 204, 51)
				end
			end
		end
	end
end

addCommandHandler("h", headAdminChat, false, false)

-- Misc
function showAdmins(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) then
		local players = exports.global:getAdmins()
		local counter = 0
		
		outputChatBox("ADMINS:", thePlayer)
		for k, arrayPlayer in ipairs(players) do
			local hiddenAdmin = getElementData(arrayPlayer, "hiddenadmin")
			local logged = getElementData(arrayPlayer, "loggedin")
			
			if logged == 1 then
				if hiddenAdmin == 0 or exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer) then
					local username = string.gsub(getPlayerName(arrayPlayer), "_", " ")
					local adminTitle = exports.global:getPlayerAdminTitle(arrayPlayer)
					local duty = getElementData(arrayPlayer, "adminduty")
					
					if exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer) then
						username = username .. " (" .. tostring(getElementData(arrayPlayer, "gameaccountusername")) .. ")"
					end
					
					if(duty==1)then
						outputChatBox("    " .. tostring(adminTitle) .. " " .. username.." - On Duty", thePlayer, 255, 194, 14)
					else
						outputChatBox("    " .. tostring(adminTitle) .. " " .. username, thePlayer)
					end
					counter = counter + 1
				end
			end
		end
		
		if (counter==0) then
			outputChatBox("     Currently no admins online.", thePlayer)
		end
	end
end
addCommandHandler("admins", showAdmins, false, false)

function playerChangeChatbubbleMode(thePlayer, commandName, mode)
	local logged = getElementData(thePlayer, "loggedin")
	
	if logged == 1 then
		mode = tonumber(mode)
		if not mode or mode < 0 or mode > 2 then
			outputChatBox("SYNTAX: /" .. commandName .. " [Mode]", thePlayer, 255, 194, 14)
			outputChatBox("0 = hide all  1 = hide own  2 = show all", thePlayer, 255, 194, 14)
		else
			if (mode == 0) then
				outputChatBox("All chatbubbles are now hidden.", thePlayer, 255, 194, 14)
			elseif (mode == 1) then
				outputChatBox("Only your own chatbubbles are hidden others are visible.", thePlayer, 255, 194, 14)
			elseif (mode == 2) then
				outputChatBox("All chatbubbles are now visible.", thePlayer, 255, 194, 14)
			end
			setElementData(thePlayer, "chatbubbles", mode, false)
			mysql_free_result( mysql_query( handler, "UPDATE accounts SET chatbubbles=" .. mode .. " WHERE id = " .. getElementData( thePlayer, "gameaccountid" ) ) )
		end
	end
end
addCommandHandler("changecbmode", playerChangeChatbubbleMode, false, false)

function toggleOOC(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if(logged==1) and (exports.global:isPlayerAdmin(thePlayer)) then
		local players = exports.pool:getPoolElementsByType("player")
		local oocEnabled = exports.global:getOOCState()
		
		if (oocEnabled==0) then
			exports.global:setOOCState(1)
			exports.irc:sendMessage("[ADMIN] " .. getPlayerName(thePlayer) .. " enabled OOC Chat.")
			
			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				
				if	(logged==1) then
					outputChatBox("OOC Chat Enabled by Admin.", arrayPlayer, 0, 255, 0)
				end
			end
		elseif (oocEnabled==1) then
			exports.global:setOOCState(0)
			exports.irc:sendMessage("[ADMIN] " .. getPlayerName(thePlayer) .. " disabled OOC Chat.")
			
			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				
				if	(logged==1) then
					outputChatBox("OOC Chat Disabled by Admin.", arrayPlayer, 255, 0, 0)
				end
			end
		end
	end
end

addCommandHandler("togooc", toggleOOC, false, false)
		
function togglePM(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if(logged==1) and ((exports.global:isPlayerAdmin(thePlayer)) or (exports.global:isPlayerBronzeDonator(thePlayer)))then
		local pmenabled = getElementData(thePlayer, "pmblocked")
		
		if (pmenabled==1) then
			setElementData(thePlayer, "pmblocked", 0, false)
			outputChatBox("PM's are now enabled.", thePlayer, 0, 255, 0)
		else
			setElementData(thePlayer, "pmblocked", 1, false)
			outputChatBox("PM's are now disabled.", thePlayer, 255, 0, 0)
		end
		mysql_free_result( mysql_query( handler, "UPDATE accounts SET pmblocked=" .. getElementData(thePlayer, "pmblocked") .. " WHERE id = " .. getElementData(thePlayer, "gameaccountid") ) )
	end
end
addCommandHandler("togpm", togglePM)

-- /pay
function payPlayer(thePlayer, commandName, targetPlayerNick, amount)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		if not (targetPlayerNick) or not (amount) or not tonumber(amount) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick] [Amount]", thePlayer, 255, 194, 14)
		else
			local targetPlayer = exports.global:findPlayerByPartialNick(targetPlayerNick)
			
			if not (targetPlayer) then
				outputChatBox("Player is not online.", thePlayer, 255, 0, 0)
			else
				local x, y, z = getElementPosition(thePlayer)
				local tx, ty, tz = getElementPosition(targetPlayer)
				
				local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
				
				if (distance<=10) then
					amount = math.floor(math.abs(tonumber(amount)))
					
					local hoursplayed = getElementData(thePlayer, "hoursplayed")
					
					if (targetPlayer==thePlayer) then
						outputChatBox("You cannot pay money to yourself.", thePlayer, 255, 0, 0)
					elseif amount == 0 then
						outputChatBox("You need to enter an amount larger than 0.", thePlayer, 255, 0, 0)
					elseif (hoursplayed<5) and (amount>50) then
						outputChatBox("You must play atleast 5 hours before transferring over 50$", thePlayer, 255, 0, 0)
					elseif exports.global:takeMoney(thePlayer, amount) then
						
						exports.logs:logMessage("[Money Transfer From " .. getPlayerName(thePlayer) .. " To: " .. getPlayerName(targetPlayer) .. "] Value: " .. amount .. "$", 5)
						if (hoursplayed<5) then
							exports.global:sendMessageToAdmins("AdmWarn: New Player '" .. getPlayerName(thePlayer) .. "' transferred " .. amount .. "$ to '" .. getPlayerName(targetPlayer) .. "'.")
						end
						
						exports.global:giveMoney(targetPlayer, amount)
						
						local gender = getElementData(thePlayer, "gender")
						local genderm = "his"
						if (gender == 1) then
							genderm = "her"
						end
						
						exports.global:sendLocalMeAction(thePlayer, "takes some dollar notes from " .. genderm .. " wallet and gives them to " .. getPlayerName(targetPlayer) .. ".")
						outputChatBox("You gave $" .. amount .. " to " .. getPlayerName(targetPlayer) .. ".", thePlayer)
						outputChatBox(getPlayerName(thePlayer) .. " gave you $" .. amount .. ".", targetPlayer)
						exports.irc:sendMessage("[MONEY TRANSFER] From '" .. getPlayerName(thePlayer) .. "' to " .. getPlayerName(targetPlayer) .. "' Amount: $" .. amount .. ".")
						
						exports.global:applyAnimation(thePlayer, "DEALER", "shop_pay", 4000, false, true, true)
					else
						outputChatBox("You do not have enough money.", thePlayer, 255, 0, 0)
					end
				else
					outputChatBox("You are too far away from " .. getPlayerName(targetPlayer) .. ".", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("pay", payPlayer, false, false)

function removeAnimation(thePlayer)
	exports.global:removeAnimation(thePlayer)
end

-- /w(hisper)
function localWhisper(thePlayer, commandName, targetPlayerNick, ...)
	local logged = tonumber(getElementData(thePlayer, "loggedin"))
	 
	if (logged==1) then
		if not (targetPlayerNick) or not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Message]", thePlayer, 255, 194, 14)
		else
			local targetPlayer = exports.global:findPlayerByPartialNick(targetPlayerNick)
			
			if not (targetPlayer) then
				outputChatBox("Player not found or multiple were found.", thePlayer, 255, 0, 0)
			else
				local x, y, z = getElementPosition(thePlayer)
				local tx, ty, tz = getElementPosition(targetPlayer)
				
				if (getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)<3) then
					local message = table.concat({...}, " ")
					
					local languageslot = getElementData(thePlayer, "languages.current")
					local language = getElementData(thePlayer, "languages.lang" .. languageslot)
					local languagename = call(getResourceFromName("language-system"), "getLanguageName", language)
					local message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, targetPlayer, message, language)
					
					local name = getPlayerName(thePlayer)
					local targetName = getPlayerName(targetPlayer)
					
					exports.global:sendLocalMeAction(thePlayer, "whispers to " .. targetName .. ".")
					outputChatBox("[" .. languagename .. "] " .. name .. " whispers: " .. message, thePlayer, 255, 255, 255)
					outputChatBox("[" .. languagename .. "] " .. name .. " whispers: " .. message2, targetPlayer, 255, 255, 255)
				else
					outputChatBox("You are too far away from " .. getPlayerName(targetPlayer) .. ".", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("w", localWhisper, false, false)

-- /c(lose)
function localClose(thePlayer, commandName, ...)
	local logged = tonumber(getElementData(thePlayer, "loggedin"))
	 
	if (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local name = getPlayerName(thePlayer)
			
			local languageslot = getElementData(thePlayer, "languages.current")
			local language = getElementData(thePlayer, "languages.lang" .. languageslot)
			local languagename = call(getResourceFromName("language-system"), "getLanguageName", language)
			
			for index, targetPlayers in ipairs( getElementsByType( "player" ) ) do
				if getElementDistance( thePlayer, targetPlayers ) < 5 then
					local message2 = message
					if targetPlayers ~= thePlayer then
						message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, targetPlayers, message, language)
					end
					outputChatBox( " [" .. languagename .. "] " .. name .. " whispers: " .. message2, targetPlayers, 255, 255, 255)
				end
			end
		end
	end
end
addCommandHandler("c", localClose, false, false)

bike = { [581]=true, [509]=true, [481]=true, [462]=true, [521]=true, [463]=true, [510]=true, [522]=true, [461]=true, [448]=true, [468]=true, [586]=true, [536]=true, [575]=true, [567]=true, [480]=true, [555]=true }

-- /cw(car whisper)
function localCarWhisper(thePlayer, commandName, ...)
	local logged = tonumber(getElementData(thePlayer, "loggedin"))
	 
	if (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local vehicle = getPedOccupiedVehicle(thePlayer)
			
			if (isElement(vehicle)) then
				local id = getElementModel(vehicle)
				
				if (bike[id]) then
					outputChatBox("Car whisper is not available in this vehicle", thePlayer, 255, 194, 14)
				else
					exports.global:sendLocalDoAction(thePlayer, "Strangers whisper in the car." )
					
					local languageslot = getElementData(thePlayer, "languages.current")
					local language = getElementData(thePlayer, "languages.lang" .. languageslot)
					local languagename = call(getResourceFromName("language-system"), "getLanguageName", language)
					
					message = table.concat({...}, " ")
					local name = getPlayerName(thePlayer)
					
					for i = 0, getVehicleMaxPassengers(vehicle) do
						player = getVehicleOccupant(vehicle, i)
						
						if (player) and (player~=thePlayer) then
							local message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, player, message, language)
							outputChatBox("[" .. languagename .. "] ((In Car)) " .. name .. " whispers: " .. message2, player, 255, 255, 255)
						elseif (player) then
							outputChatBox("[" .. languagename .. "] ((In Car)) " .. name .. " whispers: " .. message, player, 255, 255, 255)
						end
					end
				end
			end
		end
	end
end
addCommandHandler("cw", localCarWhisper, false, false)

------------------
-- News Faction --
------------------
-- /n(ews)
function newsMessage(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		local theTeam = getPlayerTeam(thePlayer)
		local factionType = getElementData(theTeam, "type")
		
		if(factionType==6)then -- news faction
			
			if not(...)then
				outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
			else
				message = table.concat({...}, " ")
				local name = getPlayerName(thePlayer)
				for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
						
					if (getElementData(value, "loggedin")==1) then
							
						if not(getElementData(value, "tognews")==1) then
							outputChatBox("[NEWS] ".. name .." says: ".. message, value, 200, 100, 200)
						end
					end
				end
				
				exports.global:giveMoney(theTeam, 200)
			end
		end
	end
end
addCommandHandler("n", newsMessage, false, false)

-- /tognews
function togNews(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		local newsTog = getElementData(thePlayer, "tognews")
		
		if (newsTog~=1) then
			outputChatBox("/news disabled.", thePlayer, 255, 194, 14)
			setElementData(thePlayer, "tognews", 1, false)
		else
			outputChatBox("/news enabled.", thePlayer, 255, 194, 14)
			setElementData(thePlayer, "tognews", 0, false)
		end
	end
end
addCommandHandler("tognews", togNews, false, false)


-- /startinterview
function StartInterview(thePlayer, commandName, targetPartialPlayer)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		local theTeam = getPlayerTeam(thePlayer)
		local factionType = getElementData(theTeam, "type")
		if(factionType==6)then -- news faction
			if not (targetPartialPlayer) then
				outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick]", thePlayer, 255, 194, 14)
			else
				local targetPlayer = exports.global:findPlayerByPartialNick(targetPartialPlayer)
				if not(targetPlayer) then
					outputChatBox("Player not found.", thePlayer, 255, 255, 0)
				else
					local targetLogged = getElementData(targetPlayer, "loggedin")
					if (targetLogged==1) then
						if(getElementData(targetPlayer,"interview"))then
							outputChatBox("This player is already being interviewed.", thePlayer, 255, 0, 0)
						else
							setElementData(targetPlayer, "interview", true, false)
							local playerName = getPlayerName(thePlayer)
							local targetPlayerName = getPlayerName(targetPlayer)
							outputChatBox(playerName .." has offered you for an interview.", targetPlayer, 0, 255, 0)
							outputChatBox("((Use /i to talk during the interview.))", targetPlayer, 0, 255, 0)
							local NewsFaction = getPlayersInTeam(getPlayerTeam(thePlayer))
							for key, value in ipairs(NewsFaction) do
								outputChatBox("((".. playerName .." has invited " .. targetPlayerName .. " for an interview.))", value, 0, 255, 0)
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler("interview", StartInterview, false, false)

-- /endinterview
function endInterview(thePlayer, commandName, targetPartialPlayer)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		local theTeam = getPlayerTeam(thePlayer)
		local factionType = getElementData(theTeam, "type")
		if(factionType==6)then -- news faction
			if not (targetPartialPlayer) then
				outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick]", thePlayer, 255, 194, 14)
			else
				local targetPlayer = exports.global:findPlayerByPartialNick(targetPartialPlayer)
				if not(targetPlayer) then
					outputChatBox("Player not found.", thePlayer, 255, 255, 0)
				else
					local targetLogged = getElementData(targetPlayer, "loggedin")
					if (targetLogged==1) then
						if not(getElementData(targetPlayer,"interview"))then
							outputChatBox("This player is not being interviewed.", thePlayer, 255, 0, 0)
						else
							removeElementData(targetPlayer, "interview")
							local playerName = getPlayerName(thePlayer)
							local targetPlayerName = getPlayerName(targetPlayer)
							outputChatBox(playerName .." has ended your interview.", targetPlayer, 255, 0, 0)
						
							local NewsFaction = getPlayersInTeam(getPlayerTeam(thePlayer))
							for key, value in ipairs(NewsFaction) do
								outputChatBox("((".. playerName .." has ended " .. targetPlayerName .. "'s interview.))", value, 255, 0, 0)
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler("endinterview", endInterview, false, false)

-- /i
function interviewChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		if(getElementData(thePlayer, "interview"))then			
			if not(...)then
				outputChatBox("SYNTAX: /" .. commandName .. "[Message]", thePlayer, 255, 194, 14)
			else
				message = table.concat({...}, " ")
				local name = getPlayerName(thePlayer)
				for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
					if (getElementData(value, "loggedin")==1) then
						if not (getElementData(value, "tognews")==1) then
							outputChatBox("[NEWS] Interview Guest " .. name .." says: ".. message, value, 200, 100, 200)
						end
					end
				end
			end
		end
	end
end
addCommandHandler("i", interviewChat, false, false)

-- news hotline /news
function newsHotline(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Description of Situation]", thePlayer, 255, 194, 14)
		else
			local playerName = getPlayerName(thePlayer)
			local dimension = getElementDimension(thePlayer)
			local interior = getElementInterior(thePlayer)
			
			local message = table.concat({...}, " ")
			message = string.gsub(message, "#%x%x%x%x%x%x", "") -- Remove colour codes
			
			-- Show chat to console, for admins + log
			exports.irc:sendMessage("[IC: Local Chat] " .. playerName .. ": " .. message)
			exports.global:sendLocalMeAction(thePlayer,"dials a number on their cellphone.")
			for index, nearbyPlayer in ipairs(getElementsByType("player")) do
				local dist = getElementDistance( thePlayer, targetPlayers )
				if dist < 20 then
					local nearbyPlayerDimension = getElementDimension(nearbyPlayer)
					local nearbyPlayerInterior = getElementInterior(nearbyPlayer)
					if (nearbyPlayerDimension==dimension) and (nearbyPlayerInterior==interior) then
						local logged = tonumber(getElementData(nearbyPlayer, "loggedin"))
						if not (isPedDead(nearbyPlayer)) and (logged==1) then
							if dist < 4 then
								outputChatBox( "#EEEEEE" .. playerName .. " [Cellphone]: " .. message, nearbyPlayer, 255, 255, 255, true)
							elseif dist < 8 then
								outputChatBox( "#DDDDDD" .. playerName .. " [Cellphone]: " .. message, nearbyPlayer, 255, 255, 255, true)
							elseif dist < 12 then          
								outputChatBox( "#CCCCCC" .. playerName .. " [Cellphone]: " .. message, nearbyPlayer, 255, 255, 255, true)
							elseif dist < 16 then
								outputChatBox( "#BBBBBB" .. playerName .. " [Cellphone]: " .. message, nearbyPlayer, 255, 255, 255, true)
							else
								outputChatBox( "#AAAAAA" .. playerName .. " [Cellphone]: " .. message, nearbyPlayer, 255, 255, 255, true)
							end
						end
					end
				end
			end
		
			outputChatBox("Thank you for calling the San Andreas Network News Desk. Your tip will be forwarded to our staff.", thePlayer, 255, 194, 14)
			exports.global:sendLocalMeAction(thePlayer,"hangs up their cellphone.")
			
			local playerNumber = getElementData(thePlayer, "cellnumber")
			local theTeam = getTeamFromName("San Andreas Network News")
			local teamMembers = getPlayersInTeam(theTeam)
			
			for key, value in ipairs(teamMembers) do
				if(exports.global:hasItem(value,2))then
					for _,nearbyPlayer in ipairs(exports.global:getNearbyElements(value, "player")) do
						triggerClientEvent(nearbyPlayer, "startRinging", value, 2)
					end
					exports.global:sendLocalMeAction(value,"receives a text message.")
					outputChatBox("SMS From: News Desk - '".. message.."' Ph:".. playerNumber .." (("..getPlayerName(thePlayer) .."))", value)
				end
			end			
		end
	end
end
addCommandHandler("news", newsHotline, false, false)

function showRoadmap(thePlayer)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		outputChatBox("Loading Progress... Please Wait...", thePlayer, 255, 194, 15)
		callRemote("http://vg-lvpd.net/remote/roadmap.php", displayRoadmap, thePlayer)
	end
end
--addCommandHandler("roadmap", showRoadmap)
--addCommandHandler("progress", showRoadmap)

function displayRoadmap(thePlayer, version1, percent1, changes1, version2, percent2, changes2, version3, percent3, changes3, mtaversion, mtapercent, mtachanges)
	if (thePlayer~="ERROR") then
		outputChatBox("~~~~~~~~~~~~~~~~~~ Progress ~~~~~~~~~~~~~~~~~~", thePlayer, 255, 194, 15)
		outputChatBox("vG " .. version1 .. ": " .. percent1 .. ". Changes: " .. changes1 .. ".", thePlayer, 255, 194, 15)
		outputChatBox("vG " .. version2 .. ": " .. percent2 .. ". Changes: " .. changes2 .. ".", thePlayer, 255, 194, 15)
		outputChatBox("vG " .. version3 .. ": " .. percent3 .. ". Changes: " .. changes3 .. ".", thePlayer, 255, 194, 15)
		outputChatBox("MultiTheftAuto " .. mtaversion .. ": " .. mtapercent .. ". Changes: " .. mtachanges .. ".", thePlayer, 255, 194, 15)
	end
end

-- /charity
function charityCash(thePlayer, commandName, amount)
	if not (amount) then
		outputChatBox("SYNTAX: /" .. commandName .. " [Amount]", thePlayer, 255, 194, 14)
	else
		local donation = tonumber(amount)
		if (donation<=0) then
			outputChatBox("You must enter an amount greater than zero.", thePlayer, 255, 0, 0)
		else
			if not exports.global:takeMoney(thePlayer, donation) then
				outputChatBox("You don't have that much money to remove.", thePlayer, 255, 0, 0)
			else
				outputChatBox("You have donated $".. donation .." to charity.", thePlayer, 0, 255, 0)
				if(donation>=1000)then
					local name = getPlayerName(thePlayer)
					
					local gender = getElementData(thePlayer, "gender")
					local genderm = "his"
					if (gender == 1) then
						genderm = "her"
					end
					outputChatBox("The hungry orphans would like to thank " ..name.. " for " .. genderm .. " sizable $" ..donation.. " donation to charity.", getRootElement())
					exports.global:givePlayerAchievement(thePlayer, 37) -- The Good Samaritan
				end
			end
		end
	end
end
addCommandHandler("charity", charityCash, false, false)

-- /bigears
function bigEars(thePlayer, commandName, targetPlayerNick)
	if exports.global:isPlayerLeadAdmin(thePlayer) then
		local current = getElementData(thePlayer, "bigears")
		if not current and not targetPlayerNick then
			outputChatBox("SYNTAX: /" .. commandName .. " [player]", thePlayer, 255, 194, 14)
		elseif current and not targetPlayerNick then
			removeElementData(thePlayer, "bigears")
			outputChatBox("Big Ears turned off.", thePlayer, 255, 0, 0)
		else
			local targetPlayer = exports.global:findPlayerByPartialNick(targetPlayerNick)
			
			if not targetPlayer then
				outputChatBox("Player not found or multiple were found.", thePlayer, 255, 0, 0)
			else
				outputChatBox("Now Listening to " .. getPlayerName(targetPlayer) .. ".", thePlayer, 0, 255, 0)
				setElementData(thePlayer, "bigears", targetPlayer, false)
			end
		end
	end
end
addCommandHandler("bigears", bigEars)

function removeBigEars()
	for key, value in pairs( getElementsByType( "player" ) ) do
		if isElement( value ) and getElementData( value, "bigears" ) == source then
			removeElementData( value, "bigears" )
			outputChatBox("Big Ears turned off (Player Left).", value, 255, 0, 0)
		end
	end
end
addEventHandler( "onPlayerQuit", getRootElement(), removeBigEars)

function bigEarsFaction(thePlayer, commandName, factionID)
	if exports.global:isPlayerLeadAdmin(thePlayer) then
		factionID = tonumber( factionID )
		local current = getElementData(thePlayer, "bigearsfaction")
		if not current and not factionID then
			outputChatBox("SYNTAX: /" .. commandName .. " [faction id]", thePlayer, 255, 194, 14)
		elseif current and not factionID then
			removeElementData(thePlayer, "bigearsfaction")
			outputChatBox("Big Ears turned off.", thePlayer, 255, 0, 0)
		else
			local team = nil
			for k, v in pairs( getElementsByType( "team" ) ) do
				if getElementData( v, "id" ) == factionID then
					team = v
					break
				end
			end
			
			if not team then
				outputChatBox("No faction with that ID found.", thePlayer, 255, 0, 0)
			else
				outputChatBox("Now Listening to " .. getTeamName(team) .. " OOC Chat.", thePlayer, 0, 255, 0)
				setElementData(thePlayer, "bigearsfaction", team, false)
			end
		end
	end
end
addCommandHandler("bigearsf", bigEarsFaction)