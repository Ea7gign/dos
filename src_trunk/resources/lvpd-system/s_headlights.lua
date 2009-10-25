function vehicleBlown()
	setElementData(source, "flashers", nil, true)
end
addEventHandler("onVehicleRespawn", getRootElement(), vehicleBlown)

function syncPoliceVehicleArray(element)
	triggerClientEvent("syncPoliceVehicleArray", getRootElement(), source)
end
addEvent("syncPoliceVehicleArray", true )
addEventHandler("syncPoliceVehicleArray", getRootElement(), syncPoliceVehicleArray)