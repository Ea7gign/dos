function getPaid(collectionValue)
	exports.global:giveMoney(getPlayerTeam(source), tonumber(collectionValue))
	
	local gender = getElementData(source, "gender")
	local genderm = "his"
	if (gender == 1) then
		genderm = "her"
	end
	
	exports.global:sendLocalMeAction(source,"hands " .. genderm .. " collection of photographs to the woman behind the desk.")
	exports.global:sendLocalText(source, "Victoria Greene says: Thank you. These should make the morning edition. Keep up the good work.", nil, nil, nil, 10)
	outputChatBox("#FF9933SAN News made $".. collectionValue .." from the photographs.", source, 255, 104, 91, true)
	exports.global:sendMessageToAdmins("SANNews: " .. tostring(getPlayerName(source)) .. " sold photos for $" .. collectionValue .. ".")
	exports.logs:logMessage(tostring(getPlayerName(source)) .. " sold photos for $" .. collectionValue .. ".", 10)
end
addEvent("submitCollection", true)
addEventHandler("submitCollection", getRootElement(), getPaid)


function info()
	exports.global:sendLocalText(source, "Victoria Greene says: Hello, Sir. I'm taking the photos of our SAN News Photographers -", nil, nil, nil, 10)
	exports.global:sendLocalText(source, "but it seems you aren't one. Feel free to apply for SAN any time ((on the forums))!", nil, nil, nil, 10)
end
addEvent("sellPhotosInfo", true)
addEventHandler("sellPhotosInfo", getRootElement(), info)