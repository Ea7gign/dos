local unstreamedObjects = { }
local root = getRootElement()
local enabled = true
local localPlayer = getLocalPlayer()

local function checkStreamIn()
	if ( enabled ) then
		local x, y, z = getElementPosition(localPlayer)
		
		for key, value in pairs(unstreamedObjects) do
			local vx, vy, vz = getElementPosition(key)
			local dist = getDistanceBetweenPoints3D(x, y, z, vx, vy, vz)
			
			if (dist <= 50) then
				local dimension = unstreamedObjects[key]
				unstreamedObjects[key] = nil
				setElementDimension(key, dimension)
			end
		end
	end
end
setTimer(checkStreamIn, 2000, 0)

local function elementDestroy()
	if (getElementType(source) == "object") then
		unstreamedObjects[source] = nil
	end
end
addEventHandler("onClientElementDestroy", getRootElement(), elementDestroy)

local function streamerStart(resource)
	if (resource == getThisResource() and enabled) then
		for key, value in ipairs(getElementsByType("object")) do
			if (not isElementStreamedIn(value)) then
				local dimension = getElementDimension(value)
				unstreamedObjects[value] = dimension
		
				setElementDimension(value, 65535)
			end
		end
	end
end
addEventHandler("onClientResourceStart", getRootElement(), streamerStart)

local function streamerStop(resource)
	if (resource == getThisResource() and enabled) then
		for key, value in pairs(unstreamedObjects) do
			local dimension = unstreamedObjects[key]
			setElementDimension(key, dimension)
		end
	end
end
addEventHandler("onClientResourceStop", getRootElement(), streamerStop)

local function streamOutObject()
	if (getElementType(source) == "object" and enabled) then
		local dimension = getElementDimension(source)
		unstreamedObjects[source] = dimension
		setElementDimension(source, 65535)
	end
end
addEventHandler("onClientElementStreamOut", root, streamOutObject)

local function toggleStreamerPatch()
	enabled = not enabled
end
addCommandHandler("togglepatch", toggleStreamerPatch)