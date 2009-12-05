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

local peds = { }

local currentcycle = 1

local dancingcycles = 
{
	{
		{ "DANCING", "DAN_Down_A" },
		{ "DANCING", "DAN_Loop_A" },
		{ "DANCING", "DAN_Right_A" },
		{ "DANCING", "dnce_M_d" }
	},
	{
		{ "STRIP", "STR_Loop_C" },
		{ "STRIP", "strip_D" },
		{ "STRIP", "Strip_Loop_B" },
		{ "STRIP", "STR_C2" }
	}
}

addEventHandler( "onResourceStart", getResourceRootElement( ),
	function( )
		local result = mysql_query( handler, "SELECT id, x, y, z, rotation, skin, type, interior, dimension, offset FROM dancers" )
		for res, row in mysql_rows( result ) do
			local id = tonumber( row[1] )
			local x = tonumber( row[2] )
			local y = tonumber( row[3] )
			local z = tonumber( row[4] )
			local rotation = tonumber( row[5] )
			local skin = tonumber( row[6] )
			local type = tonumber( row[7] )
			local interior = tonumber( row[8] )
			local dimension = tonumber( row[9] )
			local offset = tonumber( row[10] )
			
			local ped = createPed( skin, x, y, z )
			setElementData( ped, "dbid", id, false )
			setElementData( ped, "position", { x, y, z, rotation }, false )
			setPedRotation( ped, rotation )
			setElementInterior( ped, interior )
			setElementDimension( ped, dimension )
			
			peds[ ped ] = { type, offset }
		end
		mysql_free_result( result )
		
		setTimer( updateDancing, 50, 1 )
		setTimer( updateDancing, 30000, 0 )
	end
)

addCommandHandler( "adddancer", 
	function( thePlayer, commandName, type, skin, offset )
		if exports.global:isPlayerAdmin( thePlayer ) then
			type = math.floor( tonumber( type ) )
			skin = math.floor( tonumber( skin ) )
			offset = math.floor( tonumber( offset ) )
			if not type or not skin or type < 1 or type > 2 or offset < 0 or offset > 3 then
				outputChatBox( "SYNTAX: /" .. commandName .. " [1=Dancer, 2=Stripper] [Skin] [Offset 0-3]", thePlayer, 255, 194, 14 )
			else
				local x, y, z = getElementPosition( thePlayer )
				local rotation = getPedRotation( thePlayer )
				local interior = getElementInterior( thePlayer )
				local dimension = getElementDimension( thePlayer )
				
				local ped = createPed( skin, x, y, z )
				if ped then
					local result = mysql_query( handler, "INSERT INTO dancers (x,y,z,rotation,skin,type,interior,dimension,offset) VALUES (" .. x .. "," .. y .. "," .. z .. "," .. rotation .. "," .. skin .. "," .. type .. "," .. interior .. "," .. dimension .. "," .. offset .. ")" )
					if result then
						local id = mysql_insert_id( handler )
						mysql_free_result( result )
						
						setElementData( ped, "dbid", id, false )
						setElementData( ped, "position", { x, y, z, rotation }, false )
						setPedRotation( ped, rotation )
						setElementInterior( ped, dimension )
						setElementDimension( ped, dimension )
						
						peds[ ped ] = { type, offset }
						setTimer( updateDancing, 50, 1 )
					else
						destroyElement( ped )
						outputDebugString( mysql_error( handler ) )
						outputChatBox( "SQL Error.", thePlayer, 255, 0, 0 )
					end
				else
					outputChatBox( "Invalid Skin ID.", thePlayer, 255, 0, 0 )
				end
			end
		end
	end
)

addCommandHandler( "nearbydancers", 
	function( thePlayer )
		if exports.global:isPlayerAdmin( thePlayer ) then
			outputChatBox( "Nearby Dancers:",thePlayer, 255, 126, 0 )
			local counter = 0
			for key, value in ipairs( exports.global:getNearbyElements( thePlayer, "ped" ) ) do
				if peds[ value ] then
					outputChatBox( "   Dancer with ID " .. getElementData( value, "dbid" ) .. ", Type " .. peds[ value ][ 1 ] .. ", Skin " .. getElementModel( value ) .. ", Offset " .. peds[ value ][ 2 ], thePlayer, 255, 126, 0 )
					counter = counter + 1
				end
			end
			
			if counter == 0 then
				outputChatBox( "   None.", thePlayer, 255, 126, 0 )
			end
		end
	end
)

addCommandHandler( "deldancer",
	function( thePlayer, commandName, id )
		if exports.global:isPlayerAdmin( thePlayer ) then
			id = tonumber( id )
			if not id then
				outputChatBox( "SYNTAX: /" .. commandName .. " [ID]", thePlayer, 255, 194, 14 )
			else
				for ped in pairs( peds ) do
					if getElementData( ped, "dbid" ) == tonumber( id ) then
						mysql_free_result( mysql_query( handler, "DELETE FROM dancers WHERE id = " .. id ) )
						
						destroyElement( ped )
						
						peds[ ped ] = nil
						return
					end
				end
				outputChatBox( "No Ped with that ID found.", thePlayer, 255, 0, 0 )
			end
		end
	end
)

function updateDancing( )
	currentcycle = currentcycle + 1
	if currentcycle > 4 then
		currentcycle = 1
	end
	
	for ped, options in pairs( peds ) do
		if isPedDead( ped ) then
			-- BAAAAAD
			peds[ ped ] = nil
			
			local x, y, z, rotation = unpack( getElementData( ped, "position" ) )
			local newped = createPed( getElementModel( ped ), x, y, z )
			setPedRotation( newped, rotation )
			setElementData( newped, "dbid", getElementData( ped, "dbid" ), false )
			setElementData( newped, "position", getElementData( ped, "position" ), false )
			
			peds[ newped ] = options
			setElementInterior( newped, getElementInterior( ped ) )
			setElementDimension( newped, getElementInterior( ped ) )
			
			destroyElement( ped )
			ped = newped
		end
		
		local type, offset = unpack( options )
		local animid = ( currentcycle + offset ) % 4 + 1
		setPedAnimation( ped, dancingcycles[ type ][ animid ][ 1 ], dancingcycles[ type ][ animid ][ 2 ], -1, true, false, false )
	end
end