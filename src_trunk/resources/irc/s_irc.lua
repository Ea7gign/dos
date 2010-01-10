local server = "irc.gtanet.com"
local port = 6667
local username = "ValhallaGaming"
local channeladmins = "#Valhalla.admins"
local password = "adminmtavgl337"

local conn = { }
local count = 0
local distribute = 1

function spawnBot()
	local id = count+1
	conn[id] = ircOpen(server, port, username .. id, channeladmins, password)
	count = id
end

function initIRC()
	ircInit()
	spawnBot()
	spawnBot()
	spawnBot()
	
	sendMessage("Server Started.")
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), initIRC)

function stopIRC()
	sendMessage("Server Stopped.")

	for id, connection in ipairs(conn) do
		ircDisconnect(connection)
	end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), stopIRC)

function sendMessage(message)
	ircMessage(conn[distribute], channeladmins, tostring(message))
	
	distribute = distribute + 1
	if (distribute > count) then
		distribute = 1
	end
end

function sendAdminMessage(message)
	ircMessage(conn[distribute], channeladmins, tostring(message))
	
	distribute = distribute + 1
	if (distribute > count) then
		distribute = 1
	end
end

function sendRawCommand(command)
	ircRaw(conn[distribute],tostring(command))

	distribute = distribute + 1
	if (distribute > count) then
		distribute = 1
	end
end

function irc_onPrivMsg( szChannel, szNick, szText )
	-- filter our own messages
	if string.find( szNick, username ) == 0 then
		-- only react on the admin channel
		if szChannel == channeladmins then
			-- asay, broadcast to /a
			if string.find( szText, "!asay" ) == 1 then
				local message =  string.sub( szText, 7 )
				exports.logs:logMessage("[Admin Chat FROM IRC] " .. szNick .. ": " .. message, 3)
				sendAdminMessage("[IRC Admin Chat] " .. szNick .. ": " .. message)
				for k, arrayPlayer in ipairs(players) do
					local logged = getElementData(arrayPlayer, "loggedin")
					
					if(exports.global:isPlayerAdmin(arrayPlayer)) and (logged==1) then
						outputChatBox("IRC Admin " .. szNick .. ": " .. message, arrayPlayer, 51, 255, 102)
					end
				end

			-- dumbass function
			elseif string.find( szText, "!players" ) == 1 then
				ircMessage( pIRC, szChannel, "4There are currently " .. getPlayerCount() .. " players connected" )
			end
		end
	end
end