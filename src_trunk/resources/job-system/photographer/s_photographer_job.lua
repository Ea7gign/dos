function getPaid(collectionValue)
	exports.global:giveMoney(source, tonumber(collectionValue))
	exports.global:sendLocalMeAction(source,"hands his collection of photographs to the woman behind the desk.")
	exports.global:sendLocalText(source, "Victoria Greene says: Thank you. These should make the morning edition. Keep up the good work.", nil, nil, nil, 10)
	outputChatBox("#FF9933You made $".. collectionValue .." from the photographs.", source, 255, 104, 91, true)
end
addEvent("submitCollection", true)
addEventHandler("submitCollection", getRootElement(), getPaid)