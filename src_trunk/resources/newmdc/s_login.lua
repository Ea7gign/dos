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

addEvent( "mdc.login", true )
addEventHandler( "mdc.login", getRootElement( ),
	function( user, pass )
		local result = mysql_query( handler, "SELECT high_command FROM mdcusers WHERE user_name = '" .. mysql_escape_string( handler, user ) .. "' AND `password` = '" .. mysql_escape_string( handler, pass ) .. "'" )
		if result then
			if mysql_num_rows( result ) == 1 then
				local highcommand = tonumber( mysql_result( result, 1, 1 ) ) or 0
				setElementData( source, "mdc.username", user, false )
				setElementData( source, "mdc.level", highcommand, false )
				triggerClientEvent( source, "mdc.loginresult", source, user, highcommand )
			else
				outputChatBox( "Login Failed - Wrong Username/Password.", source, 255, 0, 0 )
			end
			mysql_free_result( result )
		else
			outputDebugString( mysql_error( handler ) )
			outputChatBox( "Login Failed - Wrong Username/Password.", source, 255, 0, 0 )
		end
	end
)