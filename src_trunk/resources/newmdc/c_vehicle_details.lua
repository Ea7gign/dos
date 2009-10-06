local infoLabel = nil
local infoImage = nil
local infoBack = nil

-- vehicle colors
local colors = {
	"white", "blue", "red", "dark green", "purple",
	"yellow", "blue", "gray", "blue", "silver",
	"gray", "blue", "dark gray", "silver", "gray",
	"green", "red", "red", "gray", "blue",
	"red", "red", "gray", "dark gray", "dark gray",
	"silver", "brown", "blue", "silver", "brown",
	"red", "blue", "gray", "gray", "dark gray",
	"black", "green", "light green", "blue", "black",
	"brown", "red", "red", "green", "red",
	"pale", "brown", "gray", "silver", "gray",
	"green", "blue", "dark blue", "dark blue", "brown",
	"silver", "pale", "red", "blue", "gray",
	"brown", "red", "silver", "silver", "green",
	"dark red", "blue", "pale", "light pink", "red",
	"blue", "brown", "light green", "red", "black",
	"silver", "pale", "red", "blue", "dark red",
	"purple", "dark red", "dark green", "dark brown", "purple",
	"green", "blue", "red", "pale", "silver",
	"dark blue", "gray", "blue", "blue", "blue",
	"silver", "light blue", "gray", "pale", "blue",
	"black", "pale", "blue", "pale", "gray",
	"blue", "pale", "blue", "dark gray", "brown",
	"silver", "blue", "dark brown", "dark green", "red",
	"dark blue", "red", "silver", "dark brown", "brown",
	"red", "gray", "brown", "red", "blue",
	"pink", [0] = "black" }

local function vehicleColor( c1, c2 )
	local color1 = colors[ c1 ] or "unknown"
	local color2 = colors[ c2 ] or "unknown"
	
	if color1 ~= color2 then
		return color1 .. ", " .. color2
	else
		return color1
	end
end
outputChatBox( tostring( vehicleColor( 59, 0 ) ) )

function destroyVehicleDetailsWidget( )
	if infoLabel then
		destroyElement( infoLabel )
		infoLabel = nil
	end
	if infoImage then
		destroyElement( infoImage )
		infoImage = nil
	end
	if infoBack then
		destroyElement( infoBack )
		infoBack = nil
	end
end

function createVehicleDetailsWidget( window, data )
	setHeader( "Vehicle Details" )
	
	local plate, model, color1, color2, impounded, stolen, owner, faction = unpack( data[1] )
	
	-- pic for the vehicle
	-- infoImage = guiCreateStaticImage( 220, 60, 204, 125, "vehicleimages/" .. model .. ".jpg", false, window )
	
	-- information
	infoLabel = guiCreateLabel( 25, 60, 300, 200, "Vehicle Model: " .. getVehicleNameFromModel( model ) .. "\nVehicle Colors: " .. vehicleColor( color1, color2 ) .. "\n\nLicense Plate: " .. plate .. "\nRegistered to: " .. ( faction > 0 and getFactionByID( faction ) or owner:gsub("_", " ") ) .. "\n\nImpounded: " .. ( impounded > 0 and "Yes, for " .. impounded .. "days" or "No" ) .. "\nStolen: " .. ( stolen == 1 and "YES" or "No" ), false, window )
	
	-- back button
	if pastVehicleSearch then
		infoBack = guiCreateButton( 10, 445, 150, 25, "<- Back", false, window )
		
		local past = pastVehicleSearch
		addEventHandler( "onClientGUIClick", infoBack,
			function( )
				createMainWindow( createVehicleSearchResultWidget, past )
			end,
			false
		)
	end
	
	return destroyVehicleDetailsWidget
end
