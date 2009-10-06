local mdcVehicles = { [427] = true, [490] = true, [596] = true, [697] = true, [598] = true, [599] = true, [601] = true }
local screenX, screenY = guiGetScreenSize()
localPlayer = getLocalPlayer()

local window = nil
local username = nil
local password = nil

local function tryLogin( )
	local user = guiGetText( username )
	local pass = guiGetText( password )
	if user and pass and #user > 0 and #pass > 0 then
		triggerServerEvent( "mdc.login", localPlayer, user, pass )
	else
		outputChatBox( "Login Failed - Wrong Username/Password.", 255, 0, 0 )
	end
end

function showLoginWindow( )
	-- create the window
	window = guiCreateWindow( screenX / 2 - 200, screenY / 2 - 90, 400, 180, "Mobile Data Computer", false )
	guiWindowSetMovable( window, false )
	guiWindowSetSizable( window, false )
	
	-- add a funky image
	guiCreateStaticImage( 15, 25, 150, 150, "lspdsmall.png", false, window )
	
	-- info
	guiCreateLabel( 180, 25, 200, 110, "Welcome to the LSPD Mobile\nData Computer. Please Login with\nyour Account Details below.\n\nUsername:\n\nPassword:", false, window )
	
	-- username box
	username = guiCreateEdit( 250, 80, 130, 23, getElementData(localPlayer, "mdc.username") or "", false, window )
	addEventHandler( "onClientGUIAccepted", username, tryLogin, false )
	
	-- password box
	password = guiCreateEdit( 250, 108, 130, 23, "", false, window )
	guiEditSetMasked( password, true )
	addEventHandler( "onClientGUIAccepted", password, tryLogin, false )
	
	-- login button
	local login = guiCreateButton( 175, 142, 90, 23, "Login", false, window )
	addEventHandler( "onClientGUIClick", login,
		function( button )
			if button == "left" then
				tryLogin( )
			end
		end,
		false
	)
	
	
	-- exit button
	local cancel = guiCreateButton( 290, 142, 90, 23, "Exit", false, window )
	addEventHandler( "onClientGUIClick", cancel,
		function( button )
			if button == "left" then
				destroyElement( window )
				window, username, password = nil, nil, nil
				
				guiSetInputEnabled( false )
				showCursor( false )
			end
		end,
		false
	)
	
	-- enable gui input, so we can type t, y etc.
	guiSetInputEnabled( true )
	showCursor( true )
end

-- TODO: change to /mdc in final version
addCommandHandler( "nmdc",
	function( )
		if not window and not guiGetInputEnabled() then
			if isPedInVehicle( localPlayer ) then
				local veh = getPedOccupiedVehicle( localPlayer )
				if veh and mdcVehicles[ getElementModel( veh ) ] then
					showLoginWindow( )
				else
					outputChatBox("You need to be in a police cruiser.", 255, 0 , 0)
				end
			end
		end
	end
)

addEvent( "mdc.loginresult", true )
addEventHandler( "mdc.loginresult", localPlayer,
	function( user, level )
		setElementData( localPlayer, "mdc.username", user, false )
		setElementData( localPlayer, "mdc.level", level, false )
		outputChatBox( "You've successfully logged in under account '" .. user .. "'.", 0, 255, 0 )
		
		if window then
			destroyElement( window )
			window, username, password = nil, nil, nil
		end
		
		guiSetInputEnabled( false )
		showCursor( false )
	end
)

-- misc functions
function isHighCommand( )
	return getElementData( localPlayer, "mdc.level" ) == 1
end
