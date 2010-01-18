-- This is a fix for the global resource not starting up

function resStart()
	setTimer(loadGlobal, 1000, 1)
end
addEventHandler("onResourceStart", getResourceRootElement(), resStart)


function loadGlobal()
	restartResource(getResourceFromName("global"))
	setTimer(displayCredits, 1000, 1)
end

function out(text)
	local irc = getResourceFromName( "irc" )
	if irc and getResourceState( irc ) == "running" then
		exports.irc:sendMessage(text)
	end
	outputServerLog(text)
end

function displayCredits()
	local ver = exports.global:getScriptVersion()
	out("------------------------------------------------------------" .. ("-"):rep(#ver))
	out("--  VG MTA:RP Script V" .. ver .. " Loaded - By vG.MTA Scripting Team  --")
	out("--               www.valhallagaming.net                   " .. (" "):rep(#ver) .. "--")
	out("------------------------------------------------------------" .. ("-"):rep(#ver))
end