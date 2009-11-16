local function canAccessElement( player, element )
	if getElementType( element ) == "vehicle" then
		if not isVehicleLocked( element ) then
			return true
		else
			local veh = getPedOccupiedVehicle( player )
			local inVehicle = getElementData( player, "realinvehicle" )
			
			if veh == element and inVehicle == 1 then
				return true
			elseif veh == element and inVehicle == 0 then
				outputDebugString( "canAcccessElement failed (hack?): " .. getPlayerName( player ) .. " on Vehicle " .. getElementData( element, "dbid" ) )
				return false
			else
				outputDebugString( "canAcccessElement failed (locked): " .. getPlayerName( player ) .. " on Vehicle " .. getElementData( element, "dbid" ) )
				return false
			end
		end
	else
		return true
	end
end

--

local function openInventory( element, ax, ay )
	if canAccessElement( source, element ) then
		triggerEvent( "subscribeToInventoryChanges", source, element )
		triggerClientEvent( source, "openElementInventory", element, ax, ay )
	end
end

addEvent( "openFreakinInventory", true )
addEventHandler( "openFreakinInventory", getRootElement(), openInventory )

--

local function closeInventory( element )
	triggerEvent( "unsubscribeFromInventoryChanges", source, element )
end

addEvent( "closeFreakinInventory", true )
addEventHandler( "closeFreakinInventory", getRootElement(), closeInventory )

--

local function moveToElement( element, slot, ammo )
	if not canAccessElement( source, element ) then
		return
	end
	
	local name = getElementModel( element ) == 2147 and "Fridge" or ( getElementType( element ) == "vehicle" and "Vehicle" or "Safe" )
			
	if not ammo then
		local item = getItems( source )[ slot ]
		if item then
			if not hasSpaceForItem( element, item[1] ) then
				outputChatBox( "The Inventory is full.", source, 255, 0, 0 )
			else
				if getElementType( element ) == "object" then -- safe
					if ( item[1] == 4 or item[1] == 5 ) and getElementDimension( element ) == item[2] then -- keys to that safe as well
						if countItems( source, item[1], item[2] ) < 2 then
							outputChatBox("You can't place your only key to that safe in the safe.", source, 255, 0, 0)
							return
						end
					end
				end
			
				local success, reason = moveItem( source, element, slot )
				if not success then
					outputChatBox( "Moving failed: " .. tostring( reason ), source, 255, 0, 0 )
				else
					exports.logs:logMessage( getPlayerName( source ) .. "->" .. name .. " #" .. getElementID(element) .. " - " .. getItemName( item[1] ) .. " - " .. item[2], 17)
				end
			end
		end
	else
		if not hasSpaceForItem( element, -slot ) then
			outputChatBox( "The Inventory is full.", source, 255, 0, 0 )
		else
			if tonumber(getElementData(source, "duty")) > 0 then
				outputChatBox("You can't put your weapons in a " .. name .. " while being on duty.", source, 255, 0, 0)
			elseif tonumber(getElementData(source, "job")) == 4 and slot == 41 then
				outputChatBox("You can't put this spray can into a " .. name .. ".", source, 255, 0, 0)
			else
				exports.global:takeWeapon( source, slot )
				if ammo > 0 then
					giveItem( element, -slot, ammo )
					exports.logs:logMessage( getPlayerName( source ) .. "->" .. name .. " #" .. getElementID(element) .. " - " .. getItemName( -slot ) .. " - " .. ammo, 17)
				end
			end
		end
	end
	triggerClientEvent( source, "finishItemMove", source )
end

addEvent( "moveToElement", true )
addEventHandler( "moveToElement", getRootElement(), moveToElement )

local function moveFromElement( element, slot, ammo, index )
	if not canAccessElement( source, element ) then
		return
	end
	
	local name = getElementModel( element ) == 2147 and "Fridge" or ( getElementType( element ) == "vehicle" and "Vehicle" or "Safe" )
	
	local item = getItems( element )[slot]
	if item and item[3] == index then
		if item[1] > 0 then
			moveItem( element, source, slot )
			exports.logs:logMessage( name .. " #" .. getElementID(element) .. "->" .. getPlayerName( source ) .. " - " .. getItemName( item[1] ) .. " - " .. item[2], 17)
		else
			takeItemFromSlot( element, slot )
			if ammo < item[2] then
				exports.global:giveWeapon( source, -item[1], ammo )
				giveItem( element, item[1], item[2] - ammo )
				exports.logs:logMessage( name .. " #" .. getElementID(element) .. "->" .. getPlayerName( source ) .. " - " .. getItemName( item[1] ) .. " - " .. ( item[2] - ammo ), 17)
			else
				exports.global:giveWeapon( source, -item[1], item[2] )
				exports.logs:logMessage( name .. " #" .. getElementID(element) .. "->" .. getPlayerName( source ) .. " - " .. getItemName( item[1] ) .. " - " .. item[2], 17)
			end
			triggerClientEvent( source, "forceElementMoveUpdate", source )
		end
	elseif item then
		outputDebugString( "Index mismatch: " .. tostring( item[3] ) .. " " .. tostring( index ) )
	end
	triggerClientEvent( source, "finishItemMove", source )
end

addEvent( "moveFromElement", true )
addEventHandler( "moveFromElement", getRootElement(), moveFromElement )