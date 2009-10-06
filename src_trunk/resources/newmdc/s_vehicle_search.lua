addEvent( "mdc.vehiclesearch", true )
addEventHandler( "mdc.vehiclesearch", getRootElement( ),
	function( plate, owner, model, stolen, page )
		local where = { }
		if plate and #plate > 0 then
			table.insert( where, "v.plate LIKE '" .. mysql_escape_string( handler, plate ):gsub('%*', '%%') .. "'" )
		end
		
		if owner and #owner > 0 then
			if owner == "Civilian" then
				table.insert( where, "v.owner < 0" )
			elseif getTeamFromName( owner ) then
				table.insert( where, "v.faction = " .. getElementData( getTeamFromName( owner ), "id" ) )
			else
				table.insert( where, "c.charactername LIKE '" .. mysql_escape_string( handler, owner ):gsub('_', '\\_'):gsub(' ','\\_'):gsub('?','_'):gsub('%*', '%%') .. "'" ) -- use ?, % and * as single/multiple escape chars, can't use _ as it's used in character names
				table.insert( where, "v.faction = -1" )
			end
		end
		
		if model ~= 0 then
			table.insert( where, "v.model = " .. model )
		end
		
		if stolen >= 0 then
			table.insert( where, "v.stolen = " .. stolen )
		end
		
		-- find out how many vehicles we have
		local _count = 0
		local count = mysql_query( handler, "SELECT COUNT(*) FROM vehicles v LEFT JOIN characters c ON v.owner = c.id WHERE " .. table.concat( where, " AND " ) )
		if count then
			_count = tonumber( mysql_result( count, 1, 1 ) ) or 0
			mysql_free_result( count )
		end
		
		-- find the actual vehicles
		local result = mysql_query( handler, "SELECT v.model, v.plate, c.charactername, v.stolen, v.faction FROM vehicles v LEFT JOIN characters c ON v.owner = c.id WHERE " .. table.concat( where, " AND " ) .. " ORDER BY plate LIMIT " .. ( ( page or 0 ) * 25 ) .. ", 25" )
		if result then
			local vehicles = {}
			for result, row in mysql_rows( result ) do
				table.insert( vehicles, { tonumber( row[1] ), row[2], row[3] == mysql_null( ) and "Civilian" or row[3], tonumber( row[4] ) == 1, tonumber( row[5] ) } )
			end
			mysql_free_result( result )
			
			triggerClientEvent( source, "mdc.vehiclesearchresult", source, { vehicles, plate, owner, model, stolen, page or 0, _count } )
		else
			outputDebugString( mysql_error( handler ) )
			outputChatBox( "MDC Vehicle Search failed - Report on Mantis.", source, 255, 0, 0 )
		end
	end
)