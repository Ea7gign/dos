local blip, endblip
local jobstate = 0
local route = 0
local oldroute = -1
local marker, endmarker
local deliveryStopTimer = nil

local localPlayer = getLocalPlayer()

local routes = {
	{ 1615.5283203125, -1614.431640625, 12.10223865509 },
	{ 1476.5732421875, -1735.2548828125, 11.943592071533 },
	{ 1360.8798828125, -1284.318359375, 11.949401855469 },
	{ 1192.7392578125, -1333.7568359375, 12.945232391357 },
	{ 1019.5927734375, -928.279296875, 42.1796875 }, --northern gas station
	{ 1027, -1364.4248046875, 12.138906478882 },
	{ 649.2734375, -1467.0302734375, 13.317453384399 },
	{ 786.884765625, -1612.86328125, 11.937650680542 },
	{ 815.9462890625, -1392.9716796875, 12.95408821106 },
	{ 1826.69140625, -1845.1533203125, 13.578125 },
	{ 2400.4296875, -1486.8359375, 23.828125 },
	{ 2148.263671875, -1006.384765625, 61.870578765869 },
	{ 2857.71484375, -1536.0712890625, 10.576637268066 },
	{ 2197.541015625, -2657.6513671875, 13.118523597717 },
	{ 1751.4375, -2060.2880859375, 13.166693687439 }
}

local truck = { [414] = true }

function resetTruckerJob()
	jobstate = 0
	oldroute = -1
	
	if (isElement(marker)) then
		destroyElement(marker)
		marker = nil
	end
	
	if (isElement(blip)) then
		destroyElement(blip)
		blip = nil
	end
	
	if (isElement(endmarker)) then
		destroyElement(endmarker)
		endmarker = nil
	end
	
	if (isElement(endcolshape)) then
		destroyElement(endcolshape)
		endcolshape = nil
	end
	
	if (isElement(endblip)) then
		destroyElement(endblip)
		endblip = nil
	end
	
	if deliveryStopTimer then
		killTimer(deliveryStopTimer)
		deliveryStopTimer = nil
	end
end

function displayTruckerJob(notext)
	if (jobstate==0) then
		jobstate = 1
		blip = createBlip(-69.087890625, -1111.1103515625, 0.64266717433929, 51, 2, 255, 127, 255)
		
		if not notext then		
			outputChatBox("#FF9933Approach the #CCCCCCblip#FF9933 on your radar and enter the van to start your job.", 255, 194, 15, true)
		end
	end
end

addEvent("restoreTruckerJob", true)
addEventHandler("restoreTruckerJob", getRootElement(), function() displayTruckerJob(true) end )


function startTruckerJob()
	if (jobstate==1) then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle and getVehicleController(vehicle) == localPlayer and truck[getElementModel(vehicle)] then
			outputChatBox("#FF9933Drive to the #FFFF00blip#FF9933 to complete your first delivery.", 255, 194, 15, true)
			outputChatBox("#FF9933Remember to #FFFF00follow the street rules#FF9933.", 255, 194, 15, true)
			outputChatBox("#FF9933If your truck is #FFFF00damaged#FF9933, the customers may pay less or refuse to accept the goods.", 255, 194, 15, true)
			outputChatBox("#FF9933Your wage is bound to this truck, #FFFF00don't loose it#FF9933!", 255, 194, 15, true)
			destroyElement(blip)
			
			local rand = math.random(1, #routes)
			route = routes[rand]
			local x, y, z = route[1], route[2], route[3]
			blip = createBlip(x, y, z, 0, 2, 255, 200, 0)
			marker = createMarker(x, y, z, "checkpoint", 4, 255, 200, 0, 150)
			addEventHandler("onClientMarkerHit", marker, waitAtDelivery)
							
			jobstate = 2
			oldroute = rand
		else
			outputChatBox("You must be in the van to start this job.", 255, 0, 0)
		end
	end
end

addEvent("startTruckJob", true)
addEventHandler("startTruckJob", getRootElement(), startTruckerJob)

function waitAtDelivery(thePlayer)
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if thePlayer == localPlayer and vehicle and getVehicleController(vehicle) == localPlayer and truck[getElementModel(vehicle)] then
		if getElementHealth(vehicle) < 350 then
			outputChatBox("You need to get your truck repaired.", 255, 0, 0)
		else
			deliveryStopTimer = setTimer(nextDeliveryCheckpoint, 5000, 1)
			outputChatBox("#FF9933Wait a moment while your truck is processed.", 255, 0, 0, true )
			addEventHandler("onClientMarkerLeave", marker, checkWaitAtDelivery)
		end
	end
end

function checkWaitAtDelivery(thePlayer)
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle and thePlayer == localPlayer and getVehicleController(vehicle) == localPlayer and truck[getElementModel(vehicle)] then
		if getElementHealth(vehicle) >= 350 then
			outputChatBox("You didn't wait at the dropoff point.", 255, 0, 0)
			if deliveryStopTimer then
				killTimer(deliveryStopTimer)
				deliveryStopTimer = nil
			end
			removeEventHandler("onClientMarkerLeave", source, checkWaitAtDelivery)
		end
	end
end

function nextDeliveryCheckpoint()
	deliveryStopTimer = nil
	if jobstate == 2 or jobstate == 3 then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle and getVehicleController(vehicle) == localPlayer and truck[getElementModel(vehicle)] then
			destroyElement(marker)
			destroyElement(blip)
			
			vehicleid = tonumber( getElementData(vehicle, "dbid") )
			
			local health = getElementHealth(vehicle)
			if health >= 975 then
				pay = 60 -- bonus: $60
			elseif health >= 800 then
				pay = 50
			elseif health >= 350 then
				-- 350 (black smoke) to 800, round to $5
				pay = math.ceil( 10 * ( health - 300 ) / 500 ) * 5
			else
				pay = 0
			end
			spawnFinishMarkerTruckJob()
			triggerServerEvent("saveDeliveryProgress", localPlayer, vehicle, pay)	
			
		else
			outputChatBox("#FF9933You must be in a van to complete deliverys.", 255, 0, 0, true ) -- Wrong car type.
		end
	end
end

function spawnFinishMarkerTruckJob()
	if jobstate == 2 then
		-- no final checkpoint set yet
		endblip = createBlip(-69.087890625, -1111.1103515625, 0.64266717433929, 0, 2, 255, 0, 0)
		endmarker = createMarker(-69.087890625, -1111.1103515625, 0.64266717433929, "checkpoint", 4, 255, 0, 0, 150)
		setMarkerIcon(endmarker, "finish")
		addEventHandler("onClientMarkerHit", endmarker, endDelivery)
	end
	jobstate = 3
end

addEvent("spawnFinishMarkerTruckJob", true)
addEventHandler("spawnFinishMarkerTruckJob", getRootElement(), spawnFinishMarkerTruckJob)

function loadNewCheckpointTruckJob()
	-- next drop off
	local rand = -1
	repeat
		rand = math.random(1, #routes)
	until oldroute ~= rand and getDistanceBetweenPoints2D(routes[oldroute][1], routes[oldroute][2], routes[rand][1], routes[rand][2]) > 250
	route = routes[rand]
	oldroute = rand
	local x, y, z = route[1], route[2], route[3]
	blip = createBlip(x, y, z, 0, 2, 255, 200, 0)
	marker = createMarker(x, y, z, "checkpoint", 4, 255, 200, 0, 150)
	addEventHandler("onClientMarkerHit", marker, waitAtDelivery)
end

addEvent("loadNewCheckpointTruckJob", true)
addEventHandler("loadNewCheckpointTruckJob", getRootElement(), loadNewCheckpointTruckJob)

function endDelivery(thePlayer)
	if thePlayer == localPlayer then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		local id = getElementModel(vehicle) or 0
		if not vehicle or getVehicleController(vehicle) ~= localPlayer or not (truck[id]) then
			outputChatBox("#FF9933You must be in a van to complete deliverys.", 255, 0, 0, true ) -- Wrong car type.
		else
			local health = getElementHealth(vehicle)
			if health <= 700 then
				outputChatBox("This truck is damaged, fix it first.", 255, 194, 15)
			else
				triggerServerEvent("giveTruckingMoney", localPlayer, vehicle)
				resetTruckerJob()
				displayTruckerJob(true)
			end
		end
	end
end
