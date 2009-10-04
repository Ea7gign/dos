function sendWeaponSwitchToAll(oldSlot, newSlot)
	for key, value in ipairs(getElementsByType("player")) do
		if (value ~= source) then
			triggerClientEvent(value, "onPlayerWeaponSwitch", source, oldSlot, newSlot)
		end
	end
end
addEvent("sendWeaponSwitchToAll", true)
addEventHandler("sendWeaponSwitchToAll", getRootElement(), sendWeaponSwitchToAll)