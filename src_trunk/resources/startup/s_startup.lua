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
	out("---------------------------------------------------------------")
	out("--  VG MTA:RP Script V" .. exports.global:getScriptVersion() .. " Loaded - By vG.MTA Scripting Team  --")
	out("--               www.valhallagaming.net                      --")
	out("---------------------------------------------------------------")
end