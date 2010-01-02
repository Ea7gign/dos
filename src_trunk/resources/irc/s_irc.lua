local server = "irc.gtanet.com"
local port = 6667
local username = "ValhallaGaming"
local channeladmins = "#Valhalla.admins"
local password = "adminmtavgl337"

local conn = { }
local count = 0
local distribute = 1
local timer = nil

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