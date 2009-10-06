pastVehicleSearch = {}

-- search form
local searchPlateLabel = nil
local searchPlate = nil
local searchOwnerLabel = nil
local searchOwner = nil
local searchModelLabel = nil
local searchModel = nil
local searchButton = nil
local searchStolen = nil

local function destroyVehicleSearchWidget( )
	if searchPlateLabel then
		destroyElement( searchPlateLabel )
		searchPlateLabel = nil
	end
	if searchPlate then
		destroyElement( searchPlate )
		searchPlate = nil
	end
	if searchOwnerLabel then
		destroyElement( searchOwnerLabel )
		searchOwnerLabel = nil
	end
	if searchOwner then
		destroyElement( searchOwner )
		searchOwner = nil
	end
	if searchModelLabel then
		destroyElement( searchModelLabel )
		searchModelLabel = nil
	end
	if searchModel then
		destroyElement( searchModel )
		searchModel = nil
	end
	if searchButton then
		destroyElement( searchButton )
		searchButton = nil
	end
	if searchStolen then
		destroyElement( searchStolen )
		searchStolen = nil
	end
end

function createVehicleSearchWidget( window )
	local function search( )
		if guiGetText( searchModel ) == "" or getVehicleModelFromName( guiGetText( searchModel ) ) then
			if guiGetText( searchPlate ) ~= "" or guiGetText( searchOwner ) ~= "" or guiGetText( searchModel ) ~= "" then
				triggerServerEvent( "mdc.vehiclesearch", localPlayer, guiGetText( searchPlate ), guiGetText( searchOwner ), getVehicleModelFromName( guiGetText( searchModel ) ) or 0, -1, 0 )
			end
		end
	end
	
	setHeader( "Vehicle Search" )
	
	searchPlateLabel = guiCreateLabel( 80, 130, 100, 15, "Search by Plate", false, window )
	searchPlate = guiCreateEdit( 180, 126, 130, 23, "", false, window )
	guiSetFont( searchPlateLabel, "default-bold-small" )
	
	searchOwnerLabel = guiCreateLabel( 80, 160, 100, 15, "Search by Owner", false, window )
	searchOwner = guiCreateEdit( 180, 156, 130, 23, "", false, window )
	guiSetFont( searchOwnerLabel, "default-bold-small" )
	
	searchModelLabel = guiCreateLabel( 80, 190, 100, 15, "Search by Model", false, window )
	searchModel = guiCreateEdit( 180, 186, 130, 23, "", false, window )
	guiSetFont( searchModelLabel, "default-bold-small" )
	addEventHandler( "onClientGUIChanged", searchModel,
		function( )
			local text = guiGetText( source )
			if text == "" then
				guiLabelSetColor( searchModelLabel, 255, 255, 255 )
				guiSetEnabled( searchButton, true )
			elseif getVehicleModelFromName( text ) then
				guiLabelSetColor( searchModelLabel, 0, 255, 0 )
				guiSetEnabled( searchButton, true )
			else
				guiLabelSetColor( searchModelLabel, 255, 0, 0 )
				guiSetEnabled( searchButton, false )
			end
		end,
		false
	)
	
	addEventHandler( "onClientGUIAccepted", searchPlate, search )
	addEventHandler( "onClientGUIAccepted", searchOwner, search )
	addEventHandler( "onClientGUIAccepted", searchModel, search )
	
	searchButton = guiCreateButton( 315, 126, 40, 84, "->", false, window )
	addEventHandler( "onClientGUIClick", searchButton, 
		function( button )
			if button == "left" then
				search( )
			end
		end,
		false
	)
	
	searchStolen = guiCreateButton( 80, 300, 275, 40, "show stolen vehicles", false, window )
	addEventHandler( "onClientGUIClick", searchStolen, 
		function( button )
			if button == "left" then
				triggerServerEvent( "mdc.vehiclesearch", localPlayer, "", "", 0, 1, 0 )
			end
		end,
		false
	)
	
	return destroyVehicleSearchWidget
end

-- result
local resultGrid = nil
local resultPrevious = nil
local resultCurrent = nil
local resultNext = nil
local resultBack = nil

local colModel, colOwner, colPlate, colStolen = nil, nil, nil, nil

local factionCache = { }
function getFactionByID( id )
	if not factionCache[ id ] then
		for _, team in pairs( getElementsByType( "team" ) ) do
			if getElementData( team, "id" ) == id then
				factionCache[ id ] = getTeamName( team )
				break
			end
		end
	end
	return factionCache[ id ] or "Unknown Faction"
end

local function destroyVehicleSearchResultWidget( )
	if resultGrid then
		destroyElement( resultGrid )
		resultGrid = nil
		colModel, colOwner, colPlate, colStolen = nil, nil, nil, nil
	end
	if resultPrevious then
		destroyElement( resultPrevious )
		resultPrevious = nil
	end
	if resultCurrent then
		destroyElement( resultCurrent )
		resultCurrent = nil
	end
	if resultNext then
		destroyElement( resultNext )
		resultNext = nil
	end
	if resultBack then
		destroyElement( resultBack )
		resultBack = nil
	end
	
	setTimer(
		function( )
			pastVehicleSearch = nil
		end, 50, 1
	)
end

function createVehicleSearchResultWidget( window, vehicles )
	setHeader( "Vehicle Search Result" )
	
	resultGrid = guiCreateGridList( 10, 55, 410, 385, false, window )
	colPlate = guiGridListAddColumn( resultGrid, "Plate", 0.2 )
	colOwner = guiGridListAddColumn( resultGrid, "Owner", 0.4 )
	colModel = guiGridListAddColumn( resultGrid, "Model", 0.2 )
	colStolen = guiGridListAddColumn( resultGrid, "Stolen?", 0.1 )
	
	pastVehicleSearch = vehicles
	if #vehicles[ 1 ] > 0 then
		for _, vehicle in pairs( vehicles[ 1 ] ) do
			local row = guiGridListAddRow( resultGrid )
			
			guiGridListSetItemText( resultGrid, row, colModel, getVehicleNameFromModel( vehicle[1] ), false, false )
			guiGridListSetItemText( resultGrid, row, colPlate, vehicle[2], false, false )
			guiGridListSetItemText( resultGrid, row, colOwner, vehicle[5] > 0 and getFactionByID( vehicle[5] ) or vehicle[3]:gsub("_", " "), false, false )
			guiGridListSetItemText( resultGrid, row, colStolen, vehicle[4] and "Yes" or "No", false, false )
		end
		
		-- page switch
		local page = vehicles[ 6 ]
		local count = vehicles[ 7 ]
		local maxpage = math.ceil( count / 25 ) - 1
		if page > 0 then
			resultPrevious = guiCreateButton( 270, 445, 40, 25, "<-", false, window )
			addEventHandler( "onClientGUIClick", resultPrevious,
				function( )
					triggerServerEvent( "mdc.vehiclesearch", localPlayer, vehicles[ 2 ], vehicles[ 3 ], vehicles[ 4 ], vehicles[ 5 ], page - 1 )
				end,
				false
			)
		end
		
		resultCurrent = guiCreateLabel( 310, 445, 70, 25, "Page " .. ( page + 1 ) .. "/" .. ( maxpage + 1 ), false, window )
		guiLabelSetHorizontalAlign( resultCurrent, 'center', true )
		guiLabelSetVerticalAlign( resultCurrent, 'center' )
		
		if page < maxpage then
			resultNext = guiCreateButton( 380, 445, 40, 25, "->", false, window )
			addEventHandler( "onClientGUIClick", resultNext,
				function( )
					triggerServerEvent( "mdc.vehiclesearch", localPlayer, vehicles[ 2 ], vehicles[ 3 ], vehicles[ 4 ], vehicles[ 5 ], page + 1 )
				end,
				false
			)
		end
		
		-- event for double clicking - show details
		addEventHandler( "onClientGUIDoubleClick", resultGrid,
			function( button )
				if button == "left" then
					local row, col = guiGridListGetSelectedItem( source )
					if row ~= -1 and col ~= -1 then
						triggerServerEvent( "mdc.vehicledetails", localPlayer, guiGridListGetItemText( source, row, 1 ) )
					else
						showMessageBox( "Vehicles", "You need to select a vehicle first." )
					end
				end
			end,
			false
		)
		
		-- back button
		resultBack = guiCreateButton( 10, 445, 150, 25, "<- Back", false, window )
		addEventHandler( "onClientGUIClick", resultBack,
			function( )
				createMainWindow( createVehicleSearchWidget )
				guiSetText( searchPlate, vehicles[ 2 ] )
				guiSetText( searchOwner, vehicles[ 3 ] )
				guiSetText( searchModel, getVehicleNameFromModel( vehicles[ 4 ] ) )
			end,
			false
		)
	else
		guiGridListSetItemText( resultGrid, guiGridListAddRow( resultGrid ), colOwner, "No results found.", false, false )
	end
	
	return destroyVehicleSearchResultWidget
end
