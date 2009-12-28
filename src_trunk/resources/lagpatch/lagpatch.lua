local unstreamedVehicles = { }
local root = getRootElement()
local enabled = true
local localPlayer = getLocalPlayer()

function checkStreamIn()
	if ( enabled ) then
		local x, y, z = getElementPosition(localPlayer)
		
		for key, value in pairs(unstreamedVehicles) do
			local vx, vy, vz = getElementPosition(key)
			local dist = getDistanceBetweenPoints3D(x, y, z, vx, vy, vz)
			
			if (dist <= 50) then
				local dimension = unstreamedVehicles[key]
				unstreamedVehicles[key] = nil
				setElementDimension(key, dimension)
			end
		end
	end
end
setTimer(checkStreamIn, 2000, 0)

local function vehicleRespawn()
	local vx, vy, vz = getElementPosition(source)
	local x, y, z = getElementPosition(localPlayer)
	
	if ( getDistanceBetweenPoints3D(vx, vy, vz, x, y, z) >50 ) then -- stream the vehicle out
		local dimension = getElementDimension(source)
		unstreamedObjects[source] = dimension
		setElementDimension(source, 65535)
	end
end
addEventHandler("onClientVehicleRespawn", getRootElement(), vehicleRespawn)

local function elementDestroy()
	if (getElementType(source) == "vehicle") then
		unstreamedVehicles[source] = nil
	end
end
addEventHandler("onClientElementDestroy", getRootElement(), elementDestroy)

function streamerStart(resource)
	if (resource == getThisResource() and enabled) then
		for key, value in ipairs(getElementsByType("vehicle")) do
			if (not isElementStreamedIn(value)) then
				local dimension = getElementDimension(value)
				unstreamedVehicles[value] = dimension
		
				setElementDimension(value, 65535)
			end
		end
	end
end
addEventHandler("onClientResourceStart", getRootElement(), streamerStart)

function streamerStop(resource)
	if (resource == getThisResource() and enabled) then
		for key, value in pairs(unstreamedVehicles) do
			local dimension = unstreamedVehicles[key]
			setElementDimension(key, dimension)
		end
	end
end
addEventHandler("onClientResourceStop", getRootElement(), streamerStop)

function streamOutVehicle()
	if (getElementType(source) == "vehicle" and enabled) then
		local dimension = getElementDimension(source)
		unstreamedVehicles[source] = dimension
		setElementDimension(source, 65535)
	end
end
addEventHandler("onClientElementStreamOut", root, streamOutVehicle)

function toggleStreamerPatch()
	enabled = not enabled
	
	if (enabled) then
		streamerStart(getThisResource())
		outputChatBox("The streamer patch is now enabled.", 0, 255, 0)
	else
		streamerStop(getThisResource())
		outputChatBox("The streamer patch is now disabled.", 255, 0, 0)
	end
end
addCommandHandler("togglepatch", toggleStreamerPatch)