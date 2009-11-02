function updateHudClock()
	-- 			watch											cellphone
	if (exports.global:hasItem(getLocalPlayer(), 17) or exports.global:hasItem(getLocalPlayer(), 2)) then
		showPlayerHudComponent("clock", true)
	else
		showPlayerHudComponent("clock", false)
	end
end
addEvent ( "updateHudClock", true )
addEventHandler ( "updateHudClock", getRootElement(), updateHudClock )