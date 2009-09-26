oocState = 1

function getOOCState()
	return oocState
end

function setOOCState(state)
	oocState = state
end

function sendMessageToAdmins(message)
	local players = exports.pool:getPoolElementsByType("player")
	
	for k, thePlayer in ipairs(players) do
		if (exports.global:isPlayerAdmin(thePlayer)) then
			outputChatBox(tostring(message), thePlayer, 255, 0, 0)
		end
	end
end

function findPlayerByPartialNick(partialNick)
	local matchNick = nil
	local matchNickAccuracy=0
	local partialNick = string.lower(partialNick)

	local players = exports.pool:getPoolElementsByType("player")
	local count = 0
	
	-- IDS
	if tonumber(partialNick) then
		for key, value in ipairs(players) do
			if isElement(value) then
				local id = getElementData(value, "playerid")
				
				if id and id == tonumber(partialNick) then
					matchNick = getPlayerName(value)
					break
				end
			end
		end
	else -- Look for player nicks
		for playerKey, arrayPlayer in ipairs(players) do
			if isElement(arrayPlayer) then
				local playerName = string.lower(getPlayerName(arrayPlayer))
				
				if(string.find(playerName, tostring(partialNick))) then
					local posStart, posEnd = string.find(playerName, tostring(partialNick))
					if posEnd - posStart > matchNickAccuracy then
						-- better match
						matchNickAccuracy = posEnd-posStart
						matchNick = playerName
					elseif posEnd - posStart == matchNickAccuracy then
						-- found someone who matches up the same way, so pretend we didnt find any
						matchNick = nil
					end
				end
			end
		end
	end
	
	if matchNick == nil then
		return false
	else
		local matchPlayer = getPlayerFromName(matchNick)
		local dbid = getElementData(matchPlayer, "dbid")
		return matchPlayer, dbid
	end
end

function sendLocalText(root, message, r, g, b, distance, exclude)
	exclude = exclude or {}
	local x, y, z = getElementPosition(root)
	
	for index, nearbyPlayer in ipairs(getElementsByType("player")) do
		if isElement(nearbyPlayer) and getDistanceBetweenPoints3D(x, y, z, getElementPosition(nearbyPlayer)) < ( distance or 20 ) then
			local logged = getElementData(nearbyPlayer, "loggedin")
			if not exclude[nearbyPlayer] and not isPedDead(nearbyPlayer) and logged==1 and getElementDimension(root) == getElementDimension(nearbyPlayer) then
				outputChatBox(message, nearbyPlayer, r, g, b)
			end
		end
	end
end

function sendLocalMeAction(thePlayer, message)
	sendLocalText(thePlayer, " *" .. getPlayerName(thePlayer) .. " " .. message, 255, 51, 102)
end
addEvent("sendLocalMeAction", true)
addEventHandler("sendLocalMeAction", getRootElement(), sendLocalMeAction)

function sendLocalDoAction(thePlayer, message)
	sendLocalText(thePlayer, " * " .. message .. " *      ((" .. getPlayerName(thePlayer) .. "))", 255, 51, 102)
end
