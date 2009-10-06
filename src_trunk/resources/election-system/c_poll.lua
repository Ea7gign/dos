local clown = nil

function create( )
	clown = createPed(264, 356.2978515625, 181.873046875, 1008.37)
	setPedRotation(clown, 271.4609375)
	setElementDimension(clown, 125)
	setElementInterior(clown, 3)
	setElementData( clown, "talk", 1 )
	setElementData( clown, "name", "Mr. Clown" )
end

function destroy( )
	destroyElement( clown )
	clown = nil
end

addEventHandler( "onClientElementDataChange", getResourceRootElement( ),
	function( name )
		if name == "open" then
			if getElementData( source, name ) then
				if not clown then
					create( )
				end
			else
				if clown then
					destroy( )
				end
			end
		end
	end, 
	false
)

addEventHandler( "onClientResourceStart", getResourceRootElement( ),
	function( )
		if getElementData( getResourceRootElement( ), "open" ) then
			create( )
		end
	end
)

local wPoll, gPoll, bClose

-- window

addEvent( "showPoll", true )
addEventHandler( "showPoll", getLocalPlayer(),
	function( )
		if wPoll then
			destroyElement( wPoll )
			wPoll = nil
			
			showCursor( false )
		else
			outputChatBox( "Pick a Candidate from the List. ((double-click the name))", 255, 255, 0 )
			local sx, sy = guiGetScreenSize()
			wPoll = guiCreateWindow( sx / 2 - 125, sy / 2 - 250, 250, 500, "Election for LS Government", false )
			
			gPoll = guiCreateGridList( 0.03, 0.04, 0.94, 0.88, true, wPoll )
			local colName = guiGridListAddColumn( gPoll, "Name", 0.93 )
			for id, name in pairs( getElementData( getResourceRootElement( ), "candidates" ) ) do
				local row = guiGridListAddRow( gPoll )
				guiGridListSetItemText( gPoll, row, colName, name:gsub("_", " "), false, false, false )
				guiGridListSetItemData( gPoll, row, colName, tostring( id ) )
			end
			addEventHandler( "onClientGUIDoubleClick", gPoll,
				function( button )
					if button == "left" then
						local row, col = guiGridListGetSelectedItem( gPoll )
						if row ~= -1 and col ~= -1 then
							local id = guiGridListGetItemData( gPoll, row, col )
							triggerServerEvent( "electionVote", getLocalPlayer( ), tonumber( id ) )
							
							destroyElement( wPoll )
							wPoll = nil
							
							showCursor( false )
						else
							outputChatBox( "You need to pick a Candidate.", 255, 0, 0 )
						end
					end
				end,
				false
			)
			
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