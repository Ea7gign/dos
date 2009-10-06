local screenX, screenY = guiGetScreenSize()
localPlayer = getLocalPlayer()
local window = nil
local activeWidget = nil

local headerText = ""
local colorWhite = tocolor( 255, 255, 255, 255 )

function createMainWindow( widget, param )
	if not window then
		-- create the window
		window = guiCreateWindow( 10, 10, 600, 480, "Mobile Data Computer", false )
		guiWindowSetSizable( window, false )
		
		-- border
		guiCreateStaticImage( 427, 10, 1, 470, "pixel.png", false, window )
		
		-- add a funky image
		local logo = guiCreateStaticImage( 435, 20, 150, 150, "lspdsmall.png", false, window )
		addEventHandler( "onClientGUIClick", logo, 
			function( button )
				if button == "left" then
					local enabled = not guiGetInputEnabled( )
					guiSetInputEnabled( enabled )
					if enabled then
						outputChatBox("Chatbox Input disabled.", 0, 255, 0)
					else
						outputChatBox("Chatbox Input enabled.", 0, 255, 0)
					end
				end
			end,
			false
		)
		
		-- show who he's logged in as
		guiSetFont( guiCreateLabel( 435, 180, 150, 20, "Logged in as " .. getElementData( localPlayer, "mdc.username" ), false, window ), "default-bold-small" )
		
		-- some buttons
		
		local buttons =
		{
			{
				name = "Home",
				func = function( ) createMainWindow( createMOTDWidget ) end
			},
			{
				name = "Vehicles",
				func = function( ) createMainWindow( createVehicleSearchWidget )end
			},
			{
				name = "Logout",
				func = function( )
					destroyElement( window )
					if messageBox then
						destroyElement( messageBox )
					end
					window, messageBox = nil, nil
					
					guiSetInputEnabled( false )
					showCursor( false )
					
					setHeader( "" )
					removeEventHandler( "onClientRender", root, drawHeader )
				end
			}
		}
		
		local y = 475 - #buttons * 30
		for _, button in pairs( buttons ) do
			local btn = guiCreateButton( 435, y, 150, 25, button.name, false, window )
			addEventHandler( "onClientGUIClick", btn, function( key ) if key == "left" then button.func( ) end end, false )
			y = y + 30
		end
	end
	
	if activeWidget then
		activeWidget( )
		activeWidget = nil
		
		setHeader( "" )
		removeEventHandler( "onClientRender", root, drawHeader )
	end
	
	-- load the widget
	activeWidget = widget( window, param )
	addEventHandler( "onClientRender", root, drawHeader )
	
	-- enable gui input, so we can type t, y etc.
	guiSetInputEnabled( true )
	showCursor( true )
end

-- dx drawing the header, as bankgothic isn't on that list
function drawHeader( )
	local x, y = guiGetPosition( window, false )
	dxDrawText( headerText, x + 10, y + 20, x + 420, y + 50, colorWhite, 1, "bankgothic", "center", "center", true, true, true )
end

function setHeader( header )
	headerText = header
end

-- messagebox
local messageBox = nil
function showMessageBox( header, text )
	if messageBox then
		destroyElement( messageBox )
		messageBox = nil
	end
	
	guiSetEnabled( window, false ) -- disable the mdc window
	
	-- create the window
	messageBox = guiCreateWindow( screenX / 2 - 130, screenY / 2 - 70, 260, 120, "", false )
	guiWindowSetSizable( messageBox, false ) -- not sizable
	guiSetText( messageBox, header )
	
	-- label
	local label = guiCreateLabel( 20, 25, 220, 60, text, false, messageBox )
	guiLabelSetHorizontalAlign( label, 'center', true )
	guiLabelSetVerticalAlign( label, 'center' )
	
	-- button
	local close = guiCreateButton( 55, 90, 150, 20, "Close", false, messageBox )
	addEventHandler( "onClientGUIClick", close,
		function( )
			destroyElement( messageBox )
			messageBox = nil
			
			guiSetEnabled( window, true )
		end,
		false
	)
end

-- login feedback
addEventHandler( "mdc.loginresult", localPlayer,
	function( user, level )
		createMainWindow( createMOTDWidget )
	end
)

-- TODO: remove in final version
if getElementData( localPlayer, "gameaccountusername" ) == "mabako" and #getElementsByType( "player" ) == 1 then
	triggerEvent( "mdc.loginresult", localPlayer, "Donut King", 1 )
end

-- vehicle search feedback
addEvent( "mdc.vehiclesearchresult", true )
addEventHandler( "mdc.vehiclesearchresult", localPlayer,
	function( vehicles )
		createMainWindow( createVehicleSearchResultWidget, vehicles )
	end
)

-- vehicle detail feedback
addEvent( "mdc.vehicledetails", true )
addEventHandler( "mdc.vehicledetails", localPlayer,
	function( data )
		createMainWindow( createVehicleDetailsWidget, data )
	end
)