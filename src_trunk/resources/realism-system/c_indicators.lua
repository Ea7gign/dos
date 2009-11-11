function bindKeys()
	bindKey("vehicle_look_left", "down", "indicator_left", "")
	bindKey("vehicle_look_right", "down", "indicator_right", "")
end
addEventHandler("onClientResourceStart", getResourceRootElement(), bindKeys)

leftTimer = nil
rotation = 0
rightTimer = nil

function toggleLeftIndicators()
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	if (veh) then
		local vehicleType = getVehicleType(veh)
		if (vehicleType~="Plane" and vehicleType~="Helicopter" and vehicleType~="Boat" and vehicleType~="Train" and vehicleType~="BMX" and vehicleType~="Quad") then
			
			local state = getElementData(veh, "leftindicator")
			
			if not (state) then
				setElementData(veh, "leftindicator", true, true)
				rx, ry, rotation = getElementRotation(veh)
				leftTimer = setTimer(checkLeftAngle, 1000, 0, veh)
			else
				setElementData(veh, "leftindicator", nil, true)
				local key = vehicleids[veh]
				
				if (vehicles[key][2]) then
					destroyElement(vehicles[key][2])
					vehicles[key][2] = nil
				end
				
				if (vehicles[key][3]) then
					destroyElement(vehicles[key][3])
					vehicles[key][3] = nil
				end
			end
		end
	end
end

function checkLeftAngle(veh)
	rx, ry, rz = getElementRotation(veh)
	
	if (rz) then
		if (rz>=rotation+70) then
			if (isTimer(leftTimer)) then
				killTimer(leftTimer)
			end
			
			setElementData(veh, "leftindicator", nil, true)
			local key = vehicleids[veh]
			
			if ( key ~= nil ) then
				if (vehicles[key][2]) then
					destroyElement(vehicles[key][2])
					vehicles[key][2] = nil
				end
						
				if (vehicles[key][3]) then
					destroyElement(vehicles[key][3])
					vehicles[key][3] = nil
				end
			end
		end
	end
end

function checkRightAngle(veh)
	rx, ry, rz = getElementRotation(veh)

	if (rz) then
		if (rz<=rotation-70) then
			if (isTimer(rightTimer)) then
				killTimer(rightTimer)
			end
			setElementData(veh, "rightindicator", nil, true)
			local key = vehicleids[veh]
					
			if (vehicles[key][4]) then
				destroyElement(vehicles[key][4])
				vehicles[key][4] = nil
			end
					
			if (vehicles[key][5]) then
				destroyElement(vehicles[key][5])
				vehicles[key][5] = nil
			end
		end
	end
end

function toggleRightIndicators()
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	if (veh) then
		local vehicleType = getVehicleType(veh)
		if (vehicleType~="Plane" and vehicleType~="Helicopter" and vehicleType~="Boat" and vehicleType~="Train" and vehicleType~="BMX" and vehicleType~="Quad") then
			
			local state = getElementData(veh, "rightindicator")
			
			if not (state) then
				setElementData(veh, "rightindicator", true, true)
				rx, ry, rotation = getElementRotation(veh)
				rightTimer = setTimer(checkRightAngle, 1000, 0, veh)
			else
				setElementData(veh, "rightindicator", nil, true)
				local key = vehicleids[veh]
				
				if (vehicles[key][4]) then
					destroyElement(vehicles[key][4])
					vehicles[key][4] = nil
				end
				
				if (vehicles[key][5]) then
					destroyElement(vehicles[key][5])
					vehicles[key][5] = nil
				end
			end
		end
	end
end

addCommandHandler ("indicator_left", toggleLeftIndicators)
addCommandHandler ("indicator_right", toggleRightIndicators)

vehicles = { }
vehicleids = { }

function streamIn()
	if (getElementType(source)=="vehicle") then
		for i = 1, #vehicles+1 do
			if (vehicles[i]==nil) then
				vehicles[i] = { }
				vehicles[i][1] = source
				vehicleids[source] = i
				break
			end
		end
	end
end
addEventHandler("onClientElementStreamIn", getRootElement(), streamIn)

function streamOut()
	if (getElementType(source)=="vehicle") then
		if (vehicleids[source]~=nil) then
			local id = vehicleids[source]
			vehicleids[source] = nil
			vehicles[id] = nil
		end
	end
end
addEventHandler("onClientElementStreamOut", getRootElement(), streamOut)

function doFlashes()
	if (#vehicles==0) then return end

	for key, value in pairs(vehicles) do
		local veh = vehicles[key][1]
		
		if (veh==nil) then
			if (vehicles[key][2]) then
				destroyElement(vehicles[key][2])
				vehicles[key][2] = nil
			end
				
			if (vehicles[key][3]) then
				destroyElement(vehicles[key][3])
				vehicles[key][3] = nil
			end
			
			if (vehicles[key][4]) then
				destroyElement(vehicles[key][4])
				vehicles[key][4] = nil
			end
				
			if (vehicles[key][5]) then
				destroyElement(vehicles[key][5])
				vehicles[key][5] = nil
			end
		end
		
		-- indicators
		if (isElement(veh)) then
			local x1, y1, z1, x2, y2, z2 = getElementBoundingBox(veh)
			
			if (getElementData(veh, "leftindicator")) then
				if (vehicles[key][2]==nil) then
					
				
					vehicles[key][2] = createMarker(x1, y1, z1, "corona", 1, 255, 194, 14, 200)
					attachElements(vehicles[key][2], veh, x1+0.1, y1+0.5, z1+0.7)
				
					vehicles[key][3] = createMarker(x1, y1, z1, "corona", 1, 255, 194, 14, 200)
					attachElements(vehicles[key][3], veh, x1+0.1, y2, z1+0.7)
				else
					
					destroyElement(vehicles[key][2])
					destroyElement(vehicles[key][3])
					vehicles[key][2] = nil
					vehicles[key][3] = nil
				end
			elseif (vehicles[key][2]~=nil) then
				destroyElement(vehicles[key][2])
				destroyElement(vehicles[key][3])
				vehicles[key][2] = nil
				vehicles[key][3] = nil
			end
			
			if (getElementData(veh, "rightindicator")) then
				if (vehicles[key][4]==nil) then
					vehicles[key][4] = createMarker(x1, y1, z1, "corona", 1, 255, 194, 14, 200)
					attachElements(vehicles[key][4], veh, x2-0.3, y1+0.4, z1+0.7)
				
					vehicles[key][5] = createMarker(x1, y1, z1, "corona", 1, 255, 194, 14, 200)
					attachElements(vehicles[key][5], veh, x2-0.3, y2-0.1, z1+0.7)
				else
					destroyElement(vehicles[key][4])
					destroyElement(vehicles[key][5])
					vehicles[key][4] = nil
					vehicles[key][5] = nil
				end
			elseif (vehicles[key][4]~=nil) then
				destroyElement(vehicles[key][4])
				destroyElement(vehicles[key][5])
				vehicles[key][4] = nil
				vehicles[key][5] = nil
			end
		end
	end
end
setTimer(doFlashes, 500, 0)