function quitPlayer ( quitReason )
	if (quitReason == "Timed out") or (quitReason == "Bad Connection") then -- if timed out
		outputDebugString("(( "..getPlayerName(source):gsub("_", " ").." disconnected (".. quitReason ..") ))")
		exports.global:sendLocalText(source, "(( "..getPlayerName(source):gsub("_", " ").." disconnected (".. quitReason .."). ))", nil, nil, nil, 10)
	end
end
addEventHandler("onPlayerQuit",getRootElement(), quitPlayer)