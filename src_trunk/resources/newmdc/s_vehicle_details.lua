--[[
Vehicle Make:
Vehicle Model:
Vehicle Year:
Vehicle Color(s):
License Plate:
Registered to:
Stolen:
Any visible damages:
Any modifications:
]]

addEvent( "mdc.vehicledetails", true )
addEventHandler( "mdc.vehicledetails", getRootElement( ),
	function( plate )
		local result = mysql_query( handler, "SELECT v.model, v.color1, v.color2, v.Impounded, v.stolen, c.charactername, v.faction FROM vehicles v LEFT JOIN characters c ON v.owner = c.id WHERE v.plate = '" .. mysql_escape_string( handler, plate ) .. "' LIMIT 1" )
		if result then
			for result, row in mysql_rows( result ) do
				triggerClientEvent( source, "mdc.vehicledetails", source, { { plate, tonumber( row[1] ), tonumber( row[2] ), tonumber( row[3] ), tonumber( row[4] ), tonumber( row[5] ), row[6] == mysql_null() and "Civilian" or row[6], tonumber( row[7] ) } } )
				break
			end
			mysql_free_result( result )
		else
			outputDebugString( mysql_error( handler ) )
			outputChatBox( "MDC Vehicle Details failed - Report on Mantis.", source, 255, 0, 0 )
		end
	end
)