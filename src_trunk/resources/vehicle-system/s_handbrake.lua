function cmdHandbrake(sourcePlayer)
	if isPlayerInVehicle ( sourcePlayer ) then
		local playerVehicle = getPlayerOccupiedVehicle ( sourcePlayer )
		if (getVehicleOccupant(playerVehicle, 0) == sourcePlayer) then
			if (isVehicleOnGround(playerVehicle)) then
				local handbrake = getElementData(playerVehicle, "handbrake")
				if (handbrake == 0) then
					setElementData(playerVehicle, "handbrake", 1, false)
					setVehicleFrozen(playerVehicle, true)
					outputChatBox("Handbrake has been applied.", sourcePlayer)
				else
					setElementData(playerVehicle, "handbrake", 0, false)
					setVehicleFrozen(playerVehicle, false) 
					outputChatBox("Handbrake has been released.", sourcePlayer)
				end
			else
			 outputChatBox("You cannot apply your handbrake in air, smartass...", sourcePlayer, 255, 0, 0)
			end
		else
			outputChatBox("You need to be an driver to control the handbrake...", sourcePlayer, 255, 0, 0)
		end
	else
		outputChatBox("Ahum, how would you apply a handbrake withoit a vehicle...", sourcePlayer, 255, 0, 0)
	end
end

addCommandHandler("handbrake", cmdHandbrake)