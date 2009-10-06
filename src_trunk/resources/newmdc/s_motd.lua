addEventHandler( "onResourceStart", getResourceRootElement( ),
	function( )
		motdr = mysql_query( handler, "SELECT value FROM settings WHERE name = 'mdcmotd'" )
		if motdr then
			if mysql_num_rows( motdr ) == 1 then
				setElementData( getResourceRootElement( ), "motd", tostring( mysql_result( motdr, 1, 1 ) ) )
			else
				setElementData( getResourceRootElement( ), "motd", '' )
			end
			mysql_free_result( motdr )
		else
			outputDebugString( mysql_error( handler ) )
			setElementData( getResourceRootElement( ), "motd", '' )
		end
	end
)

addEvent( "mdc.setmotd", true )
addEventHandler( "mdc.setmotd", getRootElement( ),
	function( text )
		setElementData( getResourceRootElement( ), "motd", text )
		mysql_free_result( mysql_query( handler, "UPDATE settings SET value = '" .. mysql_escape_string( handler, text ) .. "' WHERE name = 'mdcmotd'" ) )
	end
)