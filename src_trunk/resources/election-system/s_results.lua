addCommandHandler( "pollresults",
	function( thePlayer )
		if exports.global:isPlayerAdmin( thePlayer ) or exports.global:isPlayerScripter( thePlayer ) or getPlayerTeam( thePlayer ) == getTeamFromName( "San Andreas Network News" ) then
			local result = mysql_query( handler, "SELECT ( SELECT charactername FROM characters x WHERE x.id = c.election_votedfor ), COUNT(DISTINCT(id)) AS cnt FROM characters c GROUP BY election_votedfor ORDER BY cnt DESC" )
			local results = { }
			local total = 0
			local notvoted = 0
			for res, row in mysql_rows( result ) do
				table.insert( results, { row[1] == mysql_null( ) and "Not voted" or row[1], row[2] } )
				if row[1] ~= mysql_null( ) then
					total = total + tonumber( row[2] )
				else
					notvoted = notvoted + tonumber( row[2] )
				end
			end
			mysql_free_result( result )
			triggerClientEvent( thePlayer, "showPollResults", thePlayer, results, total, notvoted )
		end
	end
)