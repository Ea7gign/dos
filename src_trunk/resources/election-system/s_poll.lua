candidates = { }
setElementData( getResourceRootElement( ), "open", false )

addEventHandler( "onResourceStart", getResourceRootElement( ),
	function( )
		-- load candidates
		local result = mysql_query( handler, "SELECT id, charactername FROM characters WHERE election_candidate = 1 ORDER BY charactername" )
		if result then
			for res, row in mysql_rows( result ) do
				local id = tonumber( row[1] )
				local name = row[2]
				if name ~= mysql_null( ) then
					candidates[ id ] = name
					setElementData( getResourceRootElement( ), "open", true )
				end
			end
			mysql_free_result( result )
		end
		setElementData( getResourceRootElement( ), "candidates", candidates )
	end
)

addEvent( "electionWantVote", true )
addEventHandler( "electionWantVote", getRootElement( ),
	function( )
		local result = mysql_query( handler, "SELECT election_votedfor, election_canvote FROM characters WHERE id = " .. getElementData( source, "dbid" ) )
		if result then
			local id = tonumber( mysql_result( result, 1, 1 ) )
			local can = tonumber( mysql_result( result, 1, 2 ) )
			mysql_free_result( result )

			if can == 0 then
				outputChatBox( "Sorry, but you can't vote this turn.", source, 255, 0, 0 )
			elseif can == 2 then
				outputChatBox( "The vote is currently paused, come back later.", source, 255, 0, 0 )
			elseif id == 0 then
				triggerClientEvent( source, "showPoll", source )
			elseif candidates[ id ] then
				outputChatBox( "You already voted for " .. candidates[ id ]:gsub("_", " ") .. ".", source, 255, 255, 0 )
			else
				outputChatBox( "You voted already.", source, 255, 255, 0 )
			end
		else
			outputDebugString( mysql_error( handler ) )
			outputChatBox( "Failed - Error 3.", source, 255, 0, 0 )
		end
	end
)

addEvent( "electionVote", true )
addEventHandler( "electionVote", getRootElement( ),
	function( vid )
		local result = mysql_query( handler, "SELECT election_votedfor, election_canvote FROM characters WHERE id = " .. getElementData( source, "dbid" ) )
		if result then
			local id = tonumber( mysql_result( result, 1, 1 ) )
			local can = tonumber( mysql_result( result, 1, 2 ) )
			mysql_free_result( result )

			if can == 0 then
				outputChatBox( "Sorry, but you can't vote this turn.", source, 255, 0, 0 )
			elseif can == 2 then
				outputChatBox( "The vote is currently paused, come back later.", source, 255, 0, 0 )
			elseif id == 0 then
				if candidates[ vid ] then
					mysql_free_result( mysql_query( handler, "UPDATE characters SET election_votedfor = " .. mysql_escape_string( handler, tostring( vid ) ) .. " WHERE id = " .. getElementData( source, "dbid" ) ) )
					outputChatBox( "You voted for '" .. candidates[ vid ]:gsub("_", " ") .. "'.", source, 0, 255, 0 )
				else
					outputChatBox( "Error during the Vote, try later.", source, 255, 0, 0 )
				end
			elseif candidates[ id ] then
				outputChatBox( "You already voted for " .. candidates[ id ]:gsub("_", " ") .. ".", source, 255, 255, 0 )
			else
				outputChatBox( "You voted already.", source, 255, 255, 0 )
			end
		else
			outputDebugString( mysql_error( handler ) )
			outputChatBox( "Failed - Error 3.", source, 255, 0, 0 )
		end
	end
)