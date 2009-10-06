local wPoll, gPoll, bClose

-- window

addEvent( "showPollResults", true )
addEventHandler( "showPollResults", getLocalPlayer(),
	function( results, total, notvoted )
		if wPoll then
			destroyElement( wPoll )
			wPoll = nil
			
			showCursor( false )
		else
			local sx, sy = guiGetScreenSize()
			wPoll = guiCreateWindow( sx / 2 - 150, sy / 2 - 250, 300, 500, "Election for LS Government - Results", false )
			
			gPoll = guiCreateGridList( 0.03, 0.04, 0.94, 0.88, true, wPoll )
			local colName = guiGridListAddColumn( gPoll, "Name", 0.45 )
			local colVotes = guiGridListAddColumn( gPoll, "Votes", 0.2 )
			local colPercent = guiGridListAddColumn( gPoll, "% of Votes", 0.25 )
			for _, res in pairs( results ) do
				local row = guiGridListAddRow( gPoll )
				guiGridListSetItemText( gPoll, row, colName, res[1]:gsub("_", " "), false, false )
				guiGridListSetItemText( gPoll, row, colVotes, tostring( res[2] ), false, true )
				
				if total > 0 and res[1] ~= "Not voted" then
					guiGridListSetItemText( gPoll, row, colPercent, ("%.2f%%"):format( tonumber( res[2] ) / total * 100 ), false, true )
				else
					guiGridListSetItemText( gPoll, row, colPercent, " ", false, false )
				end
			end
			
			bClose = guiCreateButton( 0.03, 0.93, 0.94, 0.07, "Close", true, wPoll )
			addEventHandler( "onClientGUIClick", bClose,
				function( button, state )
					if button == "left" and state == "up" then
						destroyElement( wPoll )
						wPoll = nil
						
						showCursor( false )
					end
				end, false
			)
			
			showCursor( true )
		end
	end
)