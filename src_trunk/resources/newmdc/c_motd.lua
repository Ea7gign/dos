local motdEdit = nil
local motdSave = nil

local function destroyMOTDWidget( )
	if motdEdit then
		destroyElement( motdEdit )
		motdEdit = nil
	end
	
	if motdSave then
		destroyElement( motdSave )
		motdSave = nil
	end
end

function createMOTDWidget( window )
	setHeader( "Welcome to the MDC" )
	
	motdEdit = guiCreateMemo( 10, 55, 410, 385, getElementData( getResourceRootElement( ), "motd" ), false, window )
	if isHighCommand( ) then
		motdSave = guiCreateButton( 270, 445, 150, 25, "Save", false, window )
		addEventHandler( "onClientGUIClick", motdSave,
			function( )
				if triggerServerEvent( "mdc.setmotd", localPlayer, guiGetText( motdEdit ) or "" ) then
					showMessageBox( "Message of the Day", "The Message of the Day has been successfully saved." )
				end
			end,
			false
		)
	else
		guiMemoSetReadOnly( motdEdit, true )
	end
	
	return destroyMOTDWidget
end
