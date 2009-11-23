wItems, gItems, gKeys, colSlot, colName, colValue, items, lDescription, bDropItem, bUseItem, bShowItem, bDestroyItem, tabPanel, tabItems, tabWeapons = nil
gWeapons, colWSlot, colWName, colWValue = nil
toggleLabel, chkFood, chkKeys, chkDrugs, chkOther, chkBooks, chkClothes, chkElectronics, chkEmpty = nil

wRightClick = nil
bPickup, bToggle, bPreviousTrack, bNextTrack, bCloseMenu = nil
ax, ay = nil
item = nil
showinvPlayer = nil

showFood = true
showKeys = true
showDrugs = true
showOther = true
showBooks = true
showClothes = true
showElectronics = true
showEmpty = true
activeTab = 0

-- PLEASE WAIT window
local sx, sy = guiGetScreenSize( )
wWait = guiCreateButton( ( sx - 200 ) / 2, ( sy - 60 ) / 2, 200, 60, "Please wait a moment...", false )
guiSetEnabled( wWait, false )
guiSetVisible( wWait, false )
guiSetProperty( wWait, "AlwaysOnTop", "True" )

function clickItem(button, state, absX, absY, x, y, z, element)
	if (button == "right") and (state=="down") then
		if getElementData(getLocalPlayer(), "exclusiveGUI") then
			return
		end
		
		local px, py, pz = getElementPosition(getLocalPlayer())
		if getElementParent(getElementParent(element)) == getResourceRootElement(getResourceFromName("map-system")) or getElementParent(getElementParent(element)) == getResourceRootElement(getResourceFromName("interior-system")) then
			element = nil
		end
		
		if not element then
			local wx, wy, wz = x, y, z
			local x, y, z = nil
			for key, value in ipairs(getElementsByType("object",getResourceRootElement())) do
				if isElementStreamedIn(value) then
					x, y, z = getElementPosition(value)
					local minx, miny, minz, maxx, maxy, maxz = getElementBoundingBox(value)
					
					local offset = 0.34
					
					minx = x + minx - offset
					miny = y + miny - offset
					minz = z + minz - offset
					
					maxx = x + maxx + offset
					maxy = y + maxy + offset
					maxz = z + maxz + offset
					
					local dist = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
					
					if (wx >= minx and wx <=maxx) and (wy >= miny and wy <=maxy) and (wz >= minz and wz <=maxz) then
						element = value
						break
					end
				end
			end
		end
			
		if element and getElementParent(getElementParent(element)) == getResourceRootElement() then
			if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 3 then
				if (wRightClick) then
					hideItemMenu()
				end
				ax = absX
				ay = absY
				item = element
				showItemMenu()
			else
				outputChatBox("You are too far away from that item.", 255, 0, 0)
			end
		else
			if (wRightClick) then
				hideItemMenu()
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), clickItem, true)

function showItemMenu()
	local itemID = getElementData(item, "itemID")
	local itemValue = getElementData(item, "itemValue")
	local itemName = getItemName( itemID )
	
	wRightClick = guiCreateWindow(ax, ay, 150, 200, itemID == 80 and itemValue or ( itemName .. " (" .. itemValue .. ")" ), false)
	
	local y = 0.13
	if itemID == 81 then
		bPickup = guiCreateButton(0.05, y, 0.9, 0.1, "Open", true, wRightClick)
		addEventHandler("onClientGUIClick", bPickup,
			function(button)
				if button=="left" and not getElementData(localPlayer, "exclusiveGUI") then
					triggerServerEvent( "openFreakinInventory", getLocalPlayer(), item, ax, ay )
					hideItemMenu()
				end
			end,
			false
		)
	else
		bPickup = guiCreateButton(0.05, y, 0.9, 0.1, "Pick Item Up", true, wRightClick)
		addEventHandler("onClientGUIClick", bPickup, pickupItem, false)
	end
	y = y + 0.14
	
	if itemID == 54 then
		-- Ghettoblaster
		if getElementData(item, "itemValue") > 0 then
			bToggle = guiCreateButton(0.05, y, 0.9, 0.1, "Turn Off", true, wRightClick)
			
			y = y + 0.14
			
			bPreviousTrack = guiCreateButton(0.05, y, 0.42, 0.1, "Previous", true, wRightClick)
			addEventHandler("onClientGUIClick", bPreviousTrack, function() triggerServerEvent("changeGhettoblasterTrack", getLocalPlayer(), item, -1) end, false)
			
			bNextTrack = guiCreateButton(0.53, y, 0.42, 0.1, "Next", true, wRightClick)
			addEventHandler("onClientGUIClick", bNextTrack, function() triggerServerEvent("changeGhettoblasterTrack", getLocalPlayer(), item, 1) end, false)
		else
			bToggle = guiCreateButton(0.05, y, 0.9, 0.1, "Turn On", true, wRightClick)
		end
		addEventHandler("onClientGUIClick", bToggle, toggleGhettoblaster, false)
	
		y = y + 0.14
	end
	
	bCloseMenu = guiCreateButton(0.05, y, 0.9, 0.1, "Close Menu", true, wRightClick)
	addEventHandler("onClientGUIClick", bCloseMenu, hideItemMenu, false)
end

function hideItemMenu()
	if (isElement(bPickup)) then
		destroyElement(bPickup)
	end
	bPickup = nil

	if (isElement(bToggle)) then
		destroyElement(bToggle)
	end
	bToggle = nil

	if (isElement(bPreviousTrack)) then
		destroyElement(bPreviousTrack)
	end
	bPreviousTrack = nil

	if (isElement(bNextTrack)) then
		destroyElement(bNextTrack)
	end
	bNextTrack = nil

	if (isElement(bCloseMenu)) then
		destroyElement(bCloseMenu)
	end
	bCloseMenu = nil

	if (isElement(wRightClick)) then
		destroyElement(wRightClick)
	end
	wRightClick = nil
	
	ax = nil
	ay = nil

	item = nil

	showCursor(false)
	triggerEvent("cursorHide", getLocalPlayer())
end

function updateMenu(dataname)
	if source == item and dataname == "itemValue" and getElementData(source, "itemID") == 54 then -- update the track while you're in menu
		guiSetText(wRightClick, "GHETTOBLASTER (" .. getElementData(source, "itemValue") .. ")")
	end
end
addEventHandler("onClientElementDataChange", getRootElement(), updateMenu)

function toggleGhettoblaster(button, state, absX, absY, step)
	triggerServerEvent("toggleGhettoblaster", getLocalPlayer(), item)
	hideItemMenu()
end

function pickupItem(button, state)
	if (button=="left") then
		local restrain = getElementData(getLocalPlayer(), "restrain")
		
		if (restrain) and (restrain==1) then
			outputChatBox("You are cuffed.", 255, 0, 0)
		elseif getElementData(item, "itemID") > 0 and not hasSpaceForItem(getLocalPlayer(), getElementData(item, "itemID")) then
			outputChatBox("Your Inventory is full.", 255, 0, 0)
		elseif isElement(item) then
			showCursor(false)
			triggerEvent("cursorHide", getLocalPlayer())
			
			local itemID = tonumber(getElementData(item, "itemID")) or 0
			local itemValue = tonumber(getElementData(item, "itemValue")) or 0
			if itemID < 0 then
				local free, totalfree = exports.weaponcap:getFreeAmmo( -itemID )
				local cap = exports.weaponcap:getAmmoCap( -itemID )
				if totalfree == 0 then
					outputChatBox( "You've got all weapons you can carry.", 255, 0, 0 )
				elseif free == 0 and cap == 0 then
					local weaponName = "other weapon"
					local slot = getSlotFromWeapon( -itemID )
					if slot and slot ~= 0 and getPedTotalAmmo( getLocalPlayer(), slot ) > 0 then
						local weapon = getPedWeapon( getLocalPlayer(), slot )
						weaponName = getWeaponNameFromID( weapon )
					end
					outputChatBox( "You don't carry that weapon, please drop your " .. weaponName .. " first.", 255, 0, 0 )
				elseif free == 0 then
					outputChatBox( "You can't carry any more of that weapon.", 255, 0, 0 )
				else
					triggerServerEvent("pickupItem", getLocalPlayer(), item, free )
				end
			else
				triggerServerEvent("pickupItem", getLocalPlayer(), item)
			end
			hideItemMenu()
		end
	end
end
	
function toggleCategory()
	if (source==chkFood) then
		showFood = not showFood
	elseif (source==chkKeys) then
		showKeys = not showKeys
	elseif (source==chkDrugs) then
		showDrugs = not showDrugs
	elseif (source==chkBooks) then
		showBooks = not showBooks
	elseif (source==chkClothes) then
		showClothes = not showClothes
	elseif (source==chkElectronics) then
		showElectronics = not showElectronics
	elseif (source==chkOther) then
		showOther = not showOther
	elseif (source==chkEmpty) then
		showEmpty = not showEmpty
	end
	
	-- let's add the items again
	if (isElement(gItems)) then
		guiGridListClear(gItems)
	end
	
	if (isElement(gKeys)) then
		guiGridListClear(gKeys)
	end
	
	local items, slots = getItems( showinvPlayer ), getInventorySlots( showinvPlayer )
	
	for i = 1, 3 * slots do
		if not items[i] then
			if showEmpty and i <= slots then
				local row = guiGridListAddRow(gItems)
				guiGridListSetItemText(gItems, row, colSlot, tostring(row+1), false, true)
				guiGridListSetItemText(gItems, row, colName, "Empty", false, false)
				guiGridListSetItemText(gItems, row, colValue, "None", false, false)
			end
		else
			local itemid = items[i][1]
			local itemvalue = items[i][2]
			local itemtype = getItemType(itemid)
	
			if not (itemtype) then
				return
			else
				local add = true
				
				if (itemtype==1) and not (showFood) then
					add = false
				elseif (itemtype==2) and not (showKeys) then
					add = false
				elseif (itemtype==3) and not (showDrugs) then
					add = false
				elseif (itemtype==4) and not (showOther) then
					add = false
				elseif (itemtype==5) and not (showBooks) then
					add = false
				elseif (itemtype==6) and not (showClothes) then
					add = false
				elseif (itemtype==7) and not (showElectronics) then
					add = false
				elseif (itemtype==false) then
					add = false
				end
				
				if (add) then
					local row = guiGridListAddRow(itemtype == 2 and gKeys or gItems)
					guiGridListSetItemText(itemtype == 2 and gKeys or gItems, row, colSlot, tostring(row+1), false, true)
					guiGridListSetItemData(itemtype == 2 and gKeys or gItems, row, colSlot, tostring(i))
					guiGridListSetItemText(itemtype == 2 and gKeys or gItems, row, colName, itemid == 80 and itemvalue or getItemName(itemid, itemvalue), false, false)
					guiGridListSetItemText(itemtype == 2 and gKeys or gItems, row, colValue, itemid == 80 and "" or tostring(itemvalue), false, false)
				end
			end
		end
	end
	
	while showEmpty and guiGridListGetRowCount( gItems ) < slots do
		local row = guiGridListAddRow(gItems)
		guiGridListSetItemText(gItems, row, colSlot, tostring(row+1), false, true)
		guiGridListSetItemText(gItems, row, colName, "Empty", false, false)
		guiGridListSetItemText(gItems, row, colValue, "None", false, false)
	end
end

function toggleInventory()
	if wItems then
		if guiGetEnabled( wItems ) then
			hideInventory()
		end
	elseif not getElementData(getLocalPlayer(), "adminjailed") and not getElementData(getLocalPlayer(), "pd.jailstation") then
		showInventory(getLocalPlayer())
	else
		outputChatBox("You can't access your inventory in jail", 255, 0, 0)
	end
end
bindKey("i", "down", toggleInventory)

function showInventory(player, syncw, synca)
	if not (wChemistrySet) then
		showinvPlayer = player
		if wItems then
			hideInventory()
		end
		if getElementData(getLocalPlayer(), "exclusiveGUI") then
			return
		end
		setElementData(getLocalPlayer(), "exclusiveGUI", true, false)
		local width, height = 600, 500
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)
		
		local title = "Inventory"
		if player ~= getLocalPlayer() then
			title = title .. " of " .. getPlayerName(player)
		end
		wItems = guiCreateWindow(x, y, width, height, title, false)
		guiWindowSetSizable(wItems, false)
		
		tabPanel = guiCreateTabPanel(0.025, 0.05, 0.95, 0.7, true, wItems)
		tabItems = guiCreateTab("Items", tabPanel)
		tabKeys = guiCreateTab("Keys", tabPanel)
		tabWeapons = guiCreateTab("Weapons", tabPanel)
		
		if activeTab == 0 then
			guiSetSelectedTab(tabPanel, tabItems)
		elseif activeTab == 1 then
			guiSetSelectedTab(tabPanel, tabKeys)
		else
			guiSetSelectedTab(tabPanel, tabWeapons)
		end
		
		addEventHandler( "onClientGUITabSwitched", tabPanel,
			function( tab )
				if tab == tabItems then
					activeTab = 0
				elseif tab == tabKeys then
					activeTab = 1
				elseif tab == tabWeapons then
					activeTab = 2
				end
			end,
			false )
		
		-- ITEMS
		gItems = guiCreateGridList(0.025, 0.05, 0.95, 0.9, true, tabItems)
		addEventHandler("onClientGUIClick", gItems, showDescription, false)
		
		colSlot = guiGridListAddColumn(gItems, "Slot", 0.1)
		colName = guiGridListAddColumn(gItems, "Name", 0.625)
		colValue = guiGridListAddColumn(gItems, "Value", 0.225)
		
		-- keys
		gKeys = guiCreateGridList(0.025, 0.05, 0.95, 0.9, true, tabKeys)
		addEventHandler("onClientGUIClick", gKeys, showDescription, false)
	
		colSlot = guiGridListAddColumn(gKeys, "Slot", 0.1)
		colName = guiGridListAddColumn(gKeys, "Name", 0.625)
		colValue = guiGridListAddColumn(gKeys, "Value", 0.225)
		
		-- type checkboxes
		toggleLabel = guiCreateLabel(0.025, 0.77, 0.95, 0.9, "Toggle Item Types:", true, wItems)
		guiSetFont(toggleLabel, "default-bold-small")
		
		chkFood = guiCreateCheckBox(0.025, 0.8, 0.15, 0.05, "Food & Drink", showFood, true, wItems)
		chkKeys = guiCreateCheckBox(0.2, 0.8, 0.1, 0.05, "Keys", showKeys, true, wItems)
		chkDrugs = guiCreateCheckBox(0.3, 0.8, 0.1, 0.05, "Drugs", showDrugs, true, wItems)
		chkBooks = guiCreateCheckBox(0.4, 0.8, 0.1, 0.05, "Books", showBooks, true, wItems)
		chkClothes = guiCreateCheckBox(0.5, 0.8, 0.125, 0.05, "Clothing", showClothes, true, wItems)
		chkElectronics = guiCreateCheckBox(0.625, 0.8, 0.15, 0.05, "Electronics", showElectronics, true, wItems)
		chkOther = guiCreateCheckBox(0.775, 0.8, 0.1, 0.05, "Other", showOther, true, wItems)
		chkEmpty = guiCreateCheckBox(0.875, 0.8, 0.1, 0.05, "Empty", showEmpty, true, wItems)
		
		addEventHandler("onClientGUIClick", chkFood, toggleCategory, false)
		addEventHandler("onClientGUIClick", chkKeys, toggleCategory, false)
		addEventHandler("onClientGUIClick", chkDrugs, toggleCategory, false)
		addEventHandler("onClientGUIClick", chkBooks, toggleCategory, false)
		addEventHandler("onClientGUIClick", chkClothes, toggleCategory, false)
		addEventHandler("onClientGUIClick", chkElectronics, toggleCategory, false)
		addEventHandler("onClientGUIClick", chkOther, toggleCategory, false)
		addEventHandler("onClientGUIClick", chkEmpty, toggleCategory, false)
		
		source = nil
		toggleCategory()
		addEventHandler("onClientGUIDoubleClick", gItems, useItem, false)
		addEventHandler("onClientGUIDoubleClick", gKeys, useItem, false)

		-- WEAPONS
		gWeapons = guiCreateGridList(0.025, 0.05, 0.95, 0.9, true, tabWeapons)
		addEventHandler("onClientGUIClick", gWeapons, showDescription, false)
		
		
		colWSlot = guiGridListAddColumn(gWeapons, "Slot", 0.1)
		colWName = guiGridListAddColumn(gWeapons, "Name", 0.625)
		colWValue = guiGridListAddColumn(gWeapons, "Ammo", 0.225)
		
		if syncw and synca then
			for i=0, 12 do
				local tokenweapon = tonumber(gettok(syncw, i+1, 59))
				local tokenammo = tonumber(gettok(synca, i+1, 59))
				
				if (not tokenweapon) or (not tokenammo) then
					break
				else
					local row = guiGridListAddRow(gWeapons)
					local weapon = getWeaponNameFromID(tokenweapon)
					guiGridListSetItemText(gWeapons, row, colWSlot, tostring(getSlotFromWeapon(tokenweapon)), false, true)
					guiGridListSetItemText(gWeapons, row, colWName, tostring(weapon), false, false)
					guiGridListSetItemText(gWeapons, row, colWValue, tostring(tokenammo), false, false)
				end
			end
		elseif player == getLocalPlayer() then
			for i = 0, 12 do
				if getPedWeapon(player, i) and getWeaponNameFromID(getPedWeapon(player, i)) ~= "Melee" and getPedTotalAmmo(player, i) > 0 then
					local row = guiGridListAddRow(gWeapons)
					local weapon = getWeaponNameFromID(getPedWeapon(player, i))
					local ammo = getPedTotalAmmo(player, i)
					guiGridListSetItemText(gWeapons, row, colWSlot, tostring(i), false, true)
					guiGridListSetItemText(gWeapons, row, colWName, tostring(weapon), false, false)
					guiGridListSetItemText(gWeapons, row, colWValue, tostring(ammo), false, false)
				end
			end
		else
			local row = guiGridListAddRow(gWeapons)
			guiGridListSetItemText(gWeapons, row, colWName, "Error", false, false)
		end
		guiSetVisible(colWSlot, false)
		
		addEventHandler("onClientGUIDoubleClick", gWeapons, useItem, false)
		
		-- ARMOR
		if getPedArmor(player) > 0 then
			local row = guiGridListAddRow(gWeapons)
			guiGridListSetItemText(gWeapons, row, colWSlot, tostring(13), false, true)
			guiGridListSetItemText(gWeapons, row, colWName, "Body Armor", false, false)
			guiGridListSetItemText(gWeapons, row, colWValue, tostring(getPedArmor(player)), false, false)
		end
		
		-- GENERAL
		lDescription = guiCreateLabel(0.025, 0.87, 0.95, 0.1, "Click an item to see it's description.", true, wItems)
		guiLabelSetHorizontalAlign(lDescription, "center", true)
		guiSetFont(lDescription, "default-bold-small")
		
		-- buttons
		if player == getLocalPlayer() then
			bUseItem = guiCreateButton(0.05, 0.91, 0.2, 0.15, "Use Item", true, wItems)
            addEventHandler("onClientGUIClick", bUseItem, useItem, false)
			guiSetEnabled(bUseItem, false)
			
			bDropItem = guiCreateButton(0.30, 0.91, 0.2, 0.15, "Drop Item", true, wItems)
			addEventHandler("onClientGUIClick", bDropItem, dropItem, false)
			guiSetEnabled(bDropItem, false)
			
			bShowItem = guiCreateButton(0.55, 0.91, 0.2, 0.15, "Show Item", true, wItems)
			addEventHandler("onClientGUIClick", bShowItem, showItem, false)
			guiSetEnabled(bShowItem, false)
			
			bDestroyItem = guiCreateButton(0.8, 0.91, 0.2, 0.15, "Destroy Item", true, wItems)
			addEventHandler("onClientGUIClick", bDestroyItem, destroyItem, false)
			guiSetEnabled(bDestroyItem, false)
		else
			bClose = guiCreateButton(0.375, 0.91, 0.2, 0.15, "Close Inventory", true, wItems)
			addEventHandler("onClientGUIClick", bClose, hideInventory, false)
		end
		showCursor(true)
	end
end
addEvent("showInventory", true)
addEventHandler("showInventory", getRootElement(), showInventory)

function hideInventory()
	colSlot = nil
	colName = nil
	colValue = nil
	
	colWSlot = nil
	colWName = nil
	colWValue = nil
	
	if wItems then
		destroyElement(wItems)
	end
	wItems = nil
	
	showCursor(false)
	setElementData(getLocalPlayer(), "exclusiveGUI", false, false)
end
addEvent("hideInventory", true)
addEventHandler("hideInventory", getRootElement(), hideInventory)

function showDescription(button, state)
	if (button=="left") then
		if (guiGetSelectedTab(tabPanel)==tabItems or guiGetSelectedTab(tabPanel)==tabKeys) then -- ITEMS
			local row, col = guiGridListGetSelectedItem(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems)
			
			if (row==-1) or (col==-1) then
				guiSetText(lDescription, "Click an item to see it's description.")
				guiSetEnabled(bUseItem, false)
				guiSetEnabled(bDropItem, false)
				guiSetEnabled(bShowItem, false)
				guiSetEnabled(bDestroyItem, false)
			else
				local slot = tonumber(guiGridListGetItemData(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems, row, 1))
				local items = getItems(showinvPlayer)
				if not items[slot] then
					guiSetText(lDescription, "An empty slot.")
					guiSetEnabled(bUseItem, false)
					guiSetEnabled(bDropItem, false)
					guiSetEnabled(bShowItem, false)
					guiSetEnabled(bDestroyItem, false)
				else
					local desc = tostring( getItemDescription( items[slot][1] ) )
					local value = items[slot][2]
					
					-- percent operators
					desc = string.gsub((desc), "#v", tostring(value))
					
					if (desc=="A Dictionary.") then
						local res = getResourceFromName("language-system")
						local lang = call(res, "getLanguageName", tonumber(value))
						desc = "A " .. lang .. " dictionary."
					end
					
					guiSetText(lDescription, desc)
					guiSetEnabled(bUseItem, true)
					guiSetEnabled(bDropItem, true)
					guiSetEnabled(bShowItem, true)
					guiSetEnabled(bDestroyItem, true)
				end
			end
		elseif (guiGetSelectedTab(tabPanel)==tabWeapons) then -- WEAPONS
			local row, col = guiGridListGetSelectedItem(gWeapons)
			if (row==-1) or (col==-1) then
				guiSetText(lDescription, "Click an item to see it's description.")
				guiSetEnabled(bUseItem, false)
				guiSetEnabled(bDropItem, false)
				guiSetEnabled(bShowItem, false)
				guiSetEnabled(bDestroyItem, false)
			else
				local name = tostring(guiGridListGetItemText(gWeapons, row, 2))
				local ammo = tostring(guiGridListGetItemText(gWeapons, row, 3))
				local desc = "A " .. name .. " with " .. ammo .. " ammunition."
					
				guiSetText(lDescription, desc)
				guiSetEnabled(bUseItem, true)
				guiSetEnabled(bDropItem, true)
				guiSetEnabled(bShowItem, true)
				guiSetEnabled(bDestroyItem, true)
			end
		end
	end
end

function useItem(button)
	if getElementHealth(getLocalPlayer()) == 0 then return end
	if (button=="left") then
		local x, y, z = getElementPosition(getLocalPlayer())
		local groundz = getGroundPosition(x, y, z)
		if (guiGetSelectedTab(tabPanel)==tabItems or guiGetSelectedTab(tabPanel)==tabKeys) then -- ITEMS
			local row, col = guiGridListGetSelectedItem(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems)
			local itemSlot = tonumber(guiGridListGetItemData(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems, row, 1))
			local itemID = getItems( showinvPlayer )[itemSlot][1]
			local itemName = getItemName( itemID )
			local itemValue = getItems( showinvPlayer )[itemSlot][2]
			local additional = nil
			
			if (itemID==2) then -- cellphone
				hideInventory()
				triggerEvent("showPhoneGUI", getLocalPlayer(), itemValue)
				outputChatBox("Use /call to use this item.", 255, 194, 14)
				return
			elseif (itemID==6) then -- radio
				outputChatBox("Press Y to use this item. You can also use /tuneradio to tune your radio.", 255, 194, 14)
				return
			elseif (itemID==7) then -- phonebook
				outputChatBox("Use /phonebook to use this item.", 255, 194, 14)
				return
			elseif (itemID==18) then -- City Guide
				triggerEvent( "showCityGuide", getLocalPlayer( ) )
				return
			elseif (itemID==19) then -- MP3 PLayer
				outputChatBox("Use the - and = keys to use the MP3 Player.", 255, 194, 14)
				return
			elseif (itemID==27) then -- Flashbang
				local x, y, z = getElementPosition(getLocalPlayer( ))
				local rot = getPedRotation(getLocalPlayer( ))
				x = x + math.sin(math.rad(-rot)) * 10
				y = y + math.cos(math.rad(-rot)) * 10
				z = getGroundPosition(x, y, z + 2)
				additional = { x, y, z }
			elseif (itemID==28 or itemID==54) then -- Glowstick or Ghettoblaster
				local x, y, z = getElementPosition(getLocalPlayer( ))
				local rot = getPedRotation(getLocalPlayer( ))
				x = x + math.sin(math.rad(-rot)) * 2
				y = y + math.cos(math.rad(-rot)) * 2
				z = getGroundPosition(x, y, z)
				additional = { x, y, z - 0.5 }
			elseif (itemID==30) or (itemID==31) or (itemID==32) or (itemID==33) then
				outputChatBox("Use the chemistry set purchasable from 24/7 to use this item.", 255, 0, 0)
				return
			elseif (itemID==34) then -- COCAINE
				doDrug1Effect()
			elseif (itemID==35) then
				doDrug2Effect()
			elseif (itemID==36) then
				doDrug3Effect()
			elseif (itemID==37) then
				doDrug4Effect()
			elseif (itemID==38) then
				if not getPedOccupiedVehicle(getLocalPlayer()) then
					doDrug5Effect()
				end
			elseif (itemID==39) then
				doDrug6Effect()
			elseif (itemID==40) then
				doDrug3Effect()
				doDrug1Effect()
			elseif (itemID==41) then
				doDrug4Effect()
				doDrug6Effect()
			elseif (itemID==42) then
				if not getPedOccupiedVehicle(getLocalPlayer()) then
					doDrug5Effect()
					doDrug2Effect()
				end
			elseif (itemID==43) then
				doDrug4Effect()
				doDrug1Effect()
				doDrug6Effect()
			elseif (itemID==44) then
				hideInventory()
				showChemistrySet()
				return
			elseif (itemID==45) or (itemID==46) or (itemID==47) or (itemID==66) then
				outputChatBox("Right click a player to use this item.", source, 255, 0, 0)
				return
			elseif (itemID==48) then
				outputChatBox("Your inventory is extended.", 0, 255, 0)
				return
			elseif (itemID==50) or (itemID==51) or (itemID==52) then
				hideInventory()
			elseif (itemID==53) then -- Breathalizer
				outputChatBox("Use /breathtest to use this item.", 255, 194, 15)
				return
			elseif (itemID==57) then -- FUEL CAN
				hideInventory()
			elseif (itemID==58) then
				setTimer(
					function()
						setElementData(getLocalPlayer(), "alcohollevel", ( getElementData(getLocalPlayer(), "alcohollevel") or 0 ) + 0.1, false)
					end, 15000, 1
				)
			elseif (itemID==61) then -- Emergency Light Becon
				outputChatBox("Put it in your car inventory and press 'P' to toggle it.", 255, 194, 14)
				return
			elseif (itemID==62) then
				setTimer(
					function()
						setElementData(getLocalPlayer(), "alcohollevel", ( getElementData(getLocalPlayer(), "alcohollevel") or 0 ) + 0.3, false)
					end, 5000, 1
				)
			elseif (itemID==63) then
				setTimer(
					function()
						setElementData(getLocalPlayer(), "alcohollevel", ( getElementData(getLocalPlayer(), "alcohollevel") or 0 ) + 0.2, false)
					end, 10000, 1
				)
			elseif (itemID==67) then -- GPS
				outputChatBox("Put it in your car inventory and Press 'F5'.", 255, 194, 14)
				return
			elseif (itemID==70) then -- First Aid Kit
				outputChatBox("Right click on a player who's knocked out to stabilize him.", 255, 194, 14)
				return
			elseif (itemID==71) then -- Notebook
				outputChatBox("Use /writenote [text] to write a note. There are " .. itemValue .. " pages left.", 255, 194, 14)
				return
			elseif (itemID==72) then -- Note
				outputChatBox("The Note reads: " .. itemValue, 255, 194, 14)
			elseif (itemID==78) then
				outputChatBox("This San Andreas Pilot License was issued for " .. itemValue .. ".", 255, 194, 14)
				return
			elseif (itemID==80) then
				outputChatBox("This is a Generic Item. It only exists for roleplay purposes.", 255, 194, 14)
				return
			elseif (itemID==81) then
				outputChatBox("Drop this Fridge in an Interior.", 255, 194, 14)
				return
			elseif (itemID==82) then
				outputChatBox("A BT&R identification, issued to " .. itemValue .. ".", 255, 194, 14)
				return
			elseif (itemID==84) then
				outputChatBox("Put it in a car or carry it to know when police is around.", 255, 194, 14)
				return
			elseif (itemID==85) then -- Emergency Light Becon
				outputChatBox("Put it in your car inventory and press 'N' to toggle it.", 255, 194, 14)
				return
			elseif (itemID==86) then
				outputChatBox("A SAN identification, issued to " .. itemValue .. ".", 255, 194, 14)
				return
			end
			
			triggerServerEvent("useItem", getLocalPlayer(), itemSlot, additional)
		elseif (guiGetSelectedTab(tabPanel)==tabWeapons) then -- WEAPONS
			local row, col = guiGridListGetSelectedItem(gWeapons)
			local itemSlot = tonumber(guiGridListGetItemText(gWeapons, row, 1))
			if itemSlot == 13 then
				outputChatBox("You wear Body Armor.", 0, 255, 0)
			else
				setPedWeaponSlot( getLocalPlayer(), itemSlot )
			end
		end
	end
end

function destroyItem(button)
	if getElementHealth(getLocalPlayer()) == 0 then return end
	if (button=="left") then
		if (guiGetSelectedTab(tabPanel)==tabItems or guiGetSelectedTab(tabPanel)==tabKeys) then -- ITEMS
			local row, col = guiGridListGetSelectedItem(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems)
			local itemSlot = tonumber(guiGridListGetItemData(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems, row, 1))
			if itemSlot and getItems(getLocalPlayer())[itemSlot] then
				local itemID = getItems(getLocalPlayer())[itemSlot][1]
				if itemID == 48 and countItems( getLocalPlayer(), 48 ) == 1 then -- backpack
					local keycount = countItems( getLocalPlayer(), 3 ) + countItems( getLocalPlayer(), 4 ) + countItems( getLocalPlayer(), 5 )
					if keycount > getInventorySlots(getLocalPlayer()) or #getItems( getLocalPlayer() ) - keycount - 1 > getInventorySlots(getLocalPlayer()) / 2 then
						outputChatBox("You have too much stuff in your inventory.", getLocalPlayer())
						return
					end
				end
				
				guiGridListRemoveRow(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems, row)
				
				if guiGetSelectedTab(tabPanel) == tabItems then
					local row = guiGridListAddRow(gItems)
					guiGridListSetItemText(gItems, row, colName, "Empty", false, false)
					guiGridListSetItemText(gItems, row, colValue, "None", false, false)
					
					for i = 0, getInventorySlots( getLocalPlayer() ) - 1 do
						guiGridListSetItemText(gItems, i, colSlot, tostring(i + 1), false, true)
					end
				end
				
				guiGridListSetSelectedItem(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems, 0, 0)
				
				triggerServerEvent("destroyItem", getLocalPlayer(), itemSlot)
			end
		elseif (guiGetSelectedTab(tabPanel)==tabWeapons) then -- WEAPONS
			local row, col = guiGridListGetSelectedItem(gWeapons)
			local itemSlot = tonumber(guiGridListGetItemText(gWeapons, row, 1))
			local itemID = tonumber(getPedWeapon(getLocalPlayer(), itemSlot))
			
			guiGridListSetSelectedItem(gWeapons, 0, 0)
			guiGridListRemoveRow(gWeapons, row)
			
			triggerServerEvent("destroyItem", getLocalPlayer(), itemID, true)
		end
		
		guiSetEnabled(bUseItem, false)
		guiSetEnabled(bDropItem, false)
		guiSetEnabled(bShowItem, false)
		guiSetEnabled(bDestroyItem, false)
	end
end

function dropItem(button)
	if getElementHealth(getLocalPlayer()) == 0 then return end
	if (button=="left") then
		guiSetEnabled(bUseItem, false)
		guiSetEnabled(bDropItem, false)
		guiSetEnabled(bShowItem, false)
		guiSetEnabled(bDestroyItem, false)
		
		if (guiGetSelectedTab(tabPanel)==tabItems or guiGetSelectedTab(tabPanel)==tabKeys) then -- ITEMS
			local row, col = guiGridListGetSelectedItem(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems)
			local itemSlot = tonumber(guiGridListGetItemData(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems, row, 1))
			local item = getItems(getLocalPlayer())[itemSlot]
			if item then
				local itemID = item[1]
				if itemID == 60 then
					outputChatBox("This item cannot be dropped.", 255, 0, 0)
					return
				elseif itemID == 81 and getElementDimension(getLocalPlayer()) == 0 then
					outputChatBox("You need to drop this in an interior.", 255, 0, 0)
					return
				end
				
				guiGridListRemoveRow(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems, row)
				if guiGetSelectedTab(tabPanel) == tabItems then
					local row = guiGridListAddRow(gItems)
					guiGridListSetItemText(gItems, row, colName, "Empty", false, false)
					guiGridListSetItemText(gItems, row, colValue, "None", false, false)
					
					for i = 0, getInventorySlots( getLocalPlayer() ) - 1 do
						guiGridListSetItemText(gItems, i, colSlot, tostring(i + 1), false, true)
					end
				end

				guiGridListSetSelectedItem(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems, 0, 0)
				
				-- DIRECTLY INFRONT OF PLAYER
				local matrix = getElementMatrix(getLocalPlayer())
				local oldX = 0
				local oldY = 1
				local oldZ = 0
				local x = oldX * matrix[1][1] + oldY * matrix [2][1] + oldZ * matrix [3][1] + matrix [4][1]
				local y = oldX * matrix[1][2] + oldY * matrix [2][2] + oldZ * matrix [3][2] + matrix [4][2]
				local z = oldX * matrix[1][3] + oldY * matrix [2][3] + oldZ * matrix [3][3] + matrix [4][3]
				
				local z = getGroundPosition( x, y, z + 2 )
				guiSetEnabled( wItems, false )
				guiSetVisible( wWait, true )
				triggerServerEvent("dropItem", getLocalPlayer(), itemSlot, x, y, z)
			end
		elseif (guiGetSelectedTab(tabPanel)==tabWeapons) then -- WEAPONS
			local row, col = guiGridListGetSelectedItem(gWeapons)
			local itemSlot = tonumber(guiGridListGetItemText(gWeapons, row, 1))
			local itemValue = tonumber(guiGridListGetItemText(gWeapons, row, 3))
			local itemID = 0
			if itemSlot == 13 then
				itemID = 100
				itemValue = getPedArmor(getLocalPlayer())
			else
				itemID = tonumber(getPedWeapon(getLocalPlayer(), itemSlot))
				itemValue = math.min( getPedTotalAmmo(getLocalPlayer(), itemSlot), getElementData(getLocalPlayer(), "ACweapon" .. itemID) or 0 )
			end
			
			if itemValue > 0 then
				guiGridListSetSelectedItem(gWeapons, 0, 0)
				if itemSlot >= 2 and itemSlot <= 9 then
					openWeaponDropGUI(itemID, itemValue, row)
				else
					guiGridListRemoveRow(gWeapons, row)
				
					-- DIRECTLY INFRONT OF PLAYER
					local matrix = getElementMatrix(getLocalPlayer())
					local oldX = 0
					local oldY = 1
					local oldZ = 0
					local x = oldX * matrix[1][1] + oldY * matrix [2][1] + oldZ * matrix [3][1] + matrix [4][1]
					local y = oldX * matrix[1][2] + oldY * matrix [2][2] + oldZ * matrix [3][2] + matrix [4][2]
					local z = oldX * matrix[1][3] + oldY * matrix [2][3] + oldZ * matrix [3][3] + matrix [4][3]
					
					local z = getGroundPosition( x, y, z + 2 )
					
					guiSetEnabled( wItems, false )
					guiSetVisible( wWait, true )
					triggerServerEvent("dropItem", getLocalPlayer(), itemID, x, y, z, itemValue)
				end
			end
		end
	end
end

function showItem(button)
	if getElementHealth(getLocalPlayer()) == 0 then return end
	if (button=="left") then
		if (guiGetSelectedTab(tabPanel)==tabItems or guiGetSelectedTab(tabPanel)==tabKeys) then -- ITEMS
			local row, col = guiGridListGetSelectedItem(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems)
			local itemName = guiGridListGetItemText(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems, row, 2)
			if itemName == "Porn Tape" then
				itemName = itemName .. ", " .. guiGridListGetItemText(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems, row, 3)
			elseif itemName == "BT&R Identification" then
				itemName = itemName .. ", issued to " .. guiGridListGetItemText(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems, row, 3)
			elseif itemName == "SAN Identifcation" then
				itemName = itemName .. ", issued to " .. guiGridListGetItemText(guiGetSelectedTab(tabPanel) == tabKeys and gKeys or gItems, row, 3)
			end
			triggerServerEvent("showItem", getLocalPlayer(), itemName)
		elseif (guiGetSelectedTab(tabPanel)==tabWeapons) then -- WEAPONS
			local row, col = guiGridListGetSelectedItem(gWeapons)
			local itemName = guiGridListGetItemText(gWeapons, row, 2)
			triggerServerEvent("showItem", getLocalPlayer(), itemName)
		end
	end
end

function stopGasmaskDamage(attacker, weapon)
	local gasmask = getElementData(getLocalPlayer(), "gasmask")

	if (weapon==17 or weapon==41) and (gasmask==1) then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage", getLocalPlayer(), stopGasmaskDamage)

-- /itemlist (admin command to get item IDs)
wItemList, bItemListClose = nil

function showItemList()
	if getElementData(getLocalPlayer(), "adminlevel") == 0 then
		return
	end
	if not (wItemsList) then
		wItemsList = guiCreateWindow(0.15, 0.15, 0.7, 0.7, "Items List", true)
		local gridItems = guiCreateGridList(0.025, 0.1, 0.95, 0.775, true, wItemsList)
		
		local colID = guiGridListAddColumn(gridItems, "ID", 0.1)
		local colName = guiGridListAddColumn(gridItems, "Item Name", 0.3)
		local colDesc = guiGridListAddColumn(gridItems, "Description", 0.6)
		
		for key, value in pairs(g_items) do
			if key ~= 74 and key ~= 75 then
				local row = guiGridListAddRow(gridItems)
				guiGridListSetItemText(gridItems, row, colID, tostring(key), false, true)
				guiGridListSetItemText(gridItems, row, colName, value[1], false, false)
				guiGridListSetItemText(gridItems, row, colDesc, value[2], false, false)
			end
		end

		bItemListClose = guiCreateButton(0.025, 0.9, 0.95, 0.1, "Close", true, wItemsList)
		addEventHandler("onClientGUIClick", bItemListClose, closeItemsList, false)
		
		showCursor(true)
	else
		guiSetVisible(wItemsList, true)
		guiBringToFront(wItemsList)
		showCursor(true)
	end
end
addCommandHandler("itemlist", showItemList)

function closeItemsList(button, state)
	if (source==bItemListClose) and (button=="left") and (state=="up") then
		showCursor(false)
		destroyElement(bItemListClose)
		destroyElement(wItemsList)
		bItemListClose = nil
		wItemsList = nil
	end
end

addEventHandler("onClientChangeChar", getRootElement(), hideInventory)

local function updateInv()
	if wItems and source == showinvPlayer then
		source = nil
		setTimer(toggleCategory, 50, 1)
		
		if guiGetSelectedTab( tabPanel ) == tabItems then
			guiSetEnabled(bUseItem, false)
			guiSetEnabled(bDropItem, false)
			guiSetEnabled(bShowItem, false)
			guiSetEnabled(bDestroyItem, false)
		end
	end
end
addEventHandler("recieveItems", getRootElement(), updateInv)

addEvent("finishItemDrop", true)
addEventHandler("finishItemDrop", getLocalPlayer(),
	function( )
		if wItems then
			guiSetVisible( wWait, false )
			guiSetEnabled( wItems, true )
		end
	end
)
