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

function leader_check (accountName, password)
	local query = mysql_query(handler, "SELECT faction_leader FROM characters WHERE id='" .. getElementData(source, "dbid") .. "'")
	local leader = tonumber(mysql_result(query, 1, 1))
	mysql_free_result(query)
		
	if not (tonumber(leader)==1) then -- If the player is not the leader
		triggerClientEvent("notLeader",source)
	else
		register_email(accountName, password)
	end
end
addEvent("leaderCheck",true)
addEventHandler("leaderCheck",getRootElement(),leader_check)

function register_email(accountName, password)
	local result = mysql_query(handler, "SELECT username FROM emailaccounts WHERE username='" .. mysql_escape_string(handler, accountName) .."'")
	if (mysql_num_rows(result)>0) then
		triggerClientEvent("name_in_use", source) -- Error Message
	else
		triggerClientEvent("closeEmailLogin",source)
		local dbid = getElementData(source, "dbid")
		local query = mysql_query(handler, "INSERT INTO emailaccounts SET username='" .. mysql_escape_string(handler, accountName) .. "', password=MD5('" .. mysql_escape_string(handler, password) .. "'), creator='"..dbid.."'") -- Create the account.
		local query = mysql_query(handler, "INSERT INTO emails SET date= NOW(), sender='Customer Services', receiver='" .. mysql_escape_string(handler, accountName) .. "', subject='Welcome', inbox='1',outbox='0', message='Welcome,\
\
Your email account has been registered.\
\
Now you are online you are ableto receive email on the move.\
\
Username: " ..mysql_escape_string(handler, accountName).."\
Password: " ..mysql_escape_string(handler, password).."\
\
Rest assured your private details are secure with us and our arbitarary third party advertisers.\
\
Thank you for registering.'")
		
		get_inbox(accountName)
		get_outbox(accountName)
	end
end
addEvent("registerEmail", true)
addEventHandler("registerEmail", getRootElement(),register_email)

function login_email(accountName, password)
	local result = mysql_query(handler, "SELECT * FROM emailaccounts WHERE username='" .. mysql_escape_string(handler, accountName) .."' AND password=MD5('" .. mysql_escape_string(handler, password) .. "')")
	if (mysql_num_rows(result)==0) then
		triggerClientEvent("loginError", source) -- Error Message
	else
		triggerClientEvent("closeEmailLogin",source)
		get_inbox(accountName)
		get_outbox(accountName)
	end
end
addEvent("loginEmail", true)
addEventHandler("loginEmail", getRootElement(),login_email)

function get_inbox(accountName)
	-- `date` - INTERVAL 1 hour as 'newtime'
	-- hour correction
	local result = mysql_query(handler, "SELECT id, `date` - INTERVAL 1 hour as 'newdate', sender, subject, message FROM emails WHERE receiver='".. mysql_escape_string(handler, accountName) .."' AND inbox='1' ORDER BY date DESC")
	if (result) then
		inbox_table = { }
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
		if(key==1)then
			inbox_table = {
				{ "","","","","Inbox is empty" },
			}
		end
		mysql_free_result(result)
		triggerClientEvent("showInbox",source,inbox_table, accountName)
	end
end
addEvent("s_getInbox",true)
addEventHandler("s_getInbox",getRootElement(),get_inbox)

function get_outbox(accountName)
	local result = mysql_query(handler, "SELECT id, `date` - INTERVAL 1 hour as 'newdate', receiver, subject, message FROM emails WHERE sender='".. mysql_escape_string(handler, accountName) .."' AND outbox='1' ORDER BY date DESC")
	if (result) then
		outbox_table = { }
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
		if(key==1)then
			outbox_table = {
				{ "","","","","Outbox is empty" },
			}
		end
		mysql_free_result(result)
		triggerClientEvent("showOutbox",source,outbox_table, accountName)
	end
end
addEvent("s_getOutbox",true)
addEventHandler("s_getOutbox",getRootElement(),get_outbox)

function send_message(accountName,to,subject,message)
	local result = mysql_query(handler, "SELECT username FROM emailaccounts WHERE username='" .. mysql_escape_string(handler, to) .."'")
	if (mysql_num_rows(result)==0) then
		triggerClientEvent("invalidAddress", source) -- Error Message
	else
		local query = mysql_query(handler, "INSERT INTO emails SET date= NOW(), sender='".. mysql_escape_string(handler, accountName) .."', receiver='" .. mysql_escape_string(handler, to) .. "', subject='" .. mysql_escape_string(handler,subject) .. "', message='" .. mysql_escape_string(handler, message) .. "', inbox='1', outbox='1'")
		get_outbox(accountName)
		triggerClientEvent("c_sendMessage",source)
	end
end
addEvent("sendMessage",true)
addEventHandler("sendMessage", getRootElement(),send_message)

function delete_inbox_message(id,accountName)
	local result = mysql_query(handler, "UPDATE emails SET inbox=0 WHERE id='" .. mysql_escape_string(handler, id) .."'")
	mysql_free_result(result)
	local result = mysql_query(handler, "DELETE FROM emails WHERE inbox='0' AND outbox='0'")
	get_inbox(accountName)
end
addEvent("deleteInboxMessage",true)
addEventHandler("deleteInboxMessage", getRootElement(),delete_inbox_message)

function delete_outbox_message(id, accountName)
	local result = mysql_query(handler, "UPDATE emails SET outbox=0 WHERE id='" .. mysql_escape_string(handler, id) .."'")
	mysql_free_result(result)
	local result = mysql_query(handler, "DELETE FROM emails WHERE inbox='0' AND outbox='0'")
	get_outbox(accountName)
end
addEvent("deleteOutboxMessage",true)
addEventHandler("deleteOutboxMessage", getRootElement(),delete_outbox_message)