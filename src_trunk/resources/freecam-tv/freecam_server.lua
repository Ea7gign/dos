function setPlayerFreecamEnabled(player)
	if not isPlayerFreecamEnabled(player) then
		setElementData(player, "tv:dim", getElementDimension(player), false)
		setElementData(player, "tv:int", getElementInterior(player), false)
		
		setElementDimension(player, 127)
		setElementInterior(player, 3)
		setElementAlpha(player, 0)
		setElementData(player, "reconx", true)
		return triggerClientEvent(player,"doSetFreecamEnabledTV", getRootElement(), 1309.3671875, -1393.1240234375, 1022.1019897461, false)
	else
		return false
	end
end

local marker = createMarker( 1309.3671875, -1393.1240234375, 1022.1019897461, 'corona', 1, 255, 127, 0, 127)
setElementInterior(marker, 3)
setElementDimension(marker, 126)

function setPlayerFreecamDisabled(player)
	if isPlayerFreecamEnabled(player) then
		setElementDimension(player, getElementData(player, "tv:dim"))
		setElementInterior(player, getElementData(player, "tv:int"))
		setElementAlpha(player, 255)
		removeElementData(player, "reconx", true)
		
		return triggerClientEvent(player,"doSetFreecamDisabledTV", getRootElement(), false)
	else
		return false
	end
end

function setPlayerFreecamOption(player, theOption, value)
	return triggerClientEvent(player,"doSetFreecamOptionTV", getRootElement(), theOption, value)
end

function isPlayerFreecamEnabled(player)
	return getElementData(player,"freecamTV:state")
end

addCommandHandler("tv",
	function(player)
		if isPlayerFreecamEnabled(player) then
			setPlayerFreecamDisabled(player)
		elseif getElementDimension(marker) == 127 then
			setPlayerFreecamEnabled(player)
		else
			outputChatBox("There's no TV Show running.", player, 255, 194, 14)
		end
	end
)

addCommandHandler("starttv",
	function(player)
		if getElementData(player, "faction") == 20 then
			if setElementDimension(marker, 127) then
				outputChatBox("[TV] " .. getPlayerName(player):gsub("_", " ") .. " started a TV Show. (( /tv to watch ))", getRootElement( ), 200, 100, 200)
			else
				outputChatBox("The TV Show is already running.", player, 255, 0, 0)
			end
		end
	end
)

addCommandHandler("endtv",
	function(player)
		if getElementData(player, "faction") == 20 then
			if setElementDimension(marker, 126) then
				outputChatBox("[TV] " .. getPlayerName(player):gsub("_", " ") .. " ended the TV Show.", getRootElement( ), 200, 100, 200)
				
				for k, v in ipairs( getElementsByType( "player" ) ) do
					if isPlayerFreecamEnabled(v) then
						setPlayerFreecamDisabled(v)
					end
				end
			else
				outputChatBox("There's no TV Show running.", player, 255, 0, 0)
			end
		end
	end
)

