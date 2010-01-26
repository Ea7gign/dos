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

-- status [0 = Both, 1 = sender, 2 = receiver, 3 = none] Delete all 3's.
function register_email(accountName, password)
	local result = mysql_query(handler, "SELECT username FROM emailaccounts WHERE username='" .. mysql_escape_string(handler, accountName) .."'")
	if (mysql_num_rows(result)>0) then
		triggerClientEvent("name_in_use", source) -- Error Message
	else
		triggerClientEvent("closeEmailLogin",getRootElement())
		outputDebugString("createEmailAccount server event triggered")
		local dbid = getElementData(source, "dbid")
		local query = mysql_query(handler, "INSERT INTO emailaccounts SET username='" .. mysql_escape_string(handler, accountName) .. "', password='" .. mysql_escape_string(handler, password) .. "', creator='"..dbid.."'") -- Create the account.
		local query = mysql_query(handler, "INSERT INTO emails SET date= NOW(), sender='Customer Services', receiver='" .. mysql_escape_string(handler, accountName) .. "', subject='Welcome', inbox='1',outbox='0', message='Welcome,\
\
Your email account has been registered.\
\
Username: " ..accountName.."\
Password: " ..password.."\
\
Thank you for registering.'") -- Create the welcome Email.
		
		get_inbox(accountName)
		
	end
end
addEvent("registerEmail", true)
addEventHandler("registerEmail", getRootElement(),register_email)

function login_email(accountName, password)
	local result = mysql_query(handler, "SELECT * FROM emailaccounts WHERE username='" .. mysql_escape_string(handler, accountName) .."' AND password='" .. mysql_escape_string(handler, password) .. "'")
	if (mysql_num_rows(result)==0) then
		outputDebugString("Login error. Incorrect username or password.")
		triggerClientEvent("loginError", source) -- Error Message
	else
		triggerClientEvent("closeEmailLogin",getRootElement()) -- Trigger function to build the tables.
		get_inbox(accountName)
		get_outbox(accountName)
	end
end
addEvent("loginEmail", true)
addEventHandler("loginEmail", getRootElement(),login_email)

function get_inbox(accountName)
	outputDebugString("get_inbox triggered")
	local result = mysql_query(handler, "SELECT id, date, sender, subject, message FROM emails WHERE receiver='".. mysql_escape_string(handler, accountName) .."' AND inbox='1'")
	if (result) then
		local inbox_table = { }
		local key = 1
		for result, row in mysql_rows(result) do
			inbox_table[key] = { }
			inbox_table[key][1] = row[1]
			inbox_table[key][2] = row[2]
			inbox_table[key][3] = row[3]
			inbox_table[key][4] = row[4]
			inbox_table[key][5] = row[5]
			key = key + 1
		end
		mysql_free_result(result)
		triggerClientEvent("showInbox",getRootElement(),inbox_table, accountName)
	else
		outputDebugString("Couldn't retreive inbox.")
	end
end

function get_outbox(accountName)
	outputDebugString("get_outbox triggered")
	
	local result = mysql_query(handler, "SELECT id, date, sender, subject, message FROM emails WHERE sender='".. mysql_escape_string(handler, accountName) .."' AND outbox='1'")
	if (result) then
		local outbox_table = { }
		local key = 1
		for result, row in mysql_rows(result) do
			outbox_table[key] = { }
			outbox_table[key][1] = row[1]
			outbox_table[key][2] = row[2]
			outbox_table[key][3] = row[3]
			outbox_table[key][4] = row[4]
			outbox_table[key][5] = row[5]
			key = key + 1
		end
		mysql_free_result(result)
		triggerClientEvent("showOutbox",getRootElement(),outbox_table)
	else
		outputDebugString("Couldn't retreive outbox")
	end
end

function send_message(accountName,to,subject,message)
	local result = mysql_query(handler, "SELECT username FROM emailaccounts WHERE username='" .. mysql_escape_string(handler, to) .."'")
	if (mysql_num_rows(result)==0) then
		triggerClientEvent("invalidAddress", source) -- Error Message
	else
		local query = mysql_query(handler, "INSERT INTO emails SET date= NOW(), sender='".. mysql_escape_string(handler, accountName) .."', receiver='" .. mysql_escape_string(handler, to) .. "', subject='" .. mysql_escape_string(handler,subject) .. "', message='" .. mysql_escape_string(handler, message) .. "', inbox='1', outbox='1'")
	end
end
addEvent("sendMessage", true)
addEventHandler("sendMessage", getRootElement(),send_message)