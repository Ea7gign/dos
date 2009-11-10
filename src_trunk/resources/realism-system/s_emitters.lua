local emitters = { }

function createEmitter(thePlayer, commandName, type)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (type) or (type - 0 > 3) or (type - 0 < 1) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Emitter Type]", thePlayer, 255, 194, 14)
			outputChatBox("Type 1: Synced Small Fire Emitter", thePlayer, 255, 194, 14)
			outputChatBox("Type 2: Synced Large Fire Emitter", thePlayer, 255, 194, 14)
			outputChatBox("Type 3: Synced Water Emitter", thePlayer, 255, 194, 14)
		else
			local id = #emitters + 1
			local x, y, z = getElementPosition(thePlayer)
			
			emitters[id] = { }
			emitters[id][1] = x
			emitters[id][2] = y
			emitters[id][3] = z - 1
			emitters[id][4] = type
			emitters[id][5] = createObject(848 + type, x, y, z)
			
			setElementAlpha(emitters[id][5], 0)
			outputChatBox("Emitter created with ID " .. id .. " and Type " .. type .. ".", thePlayer, 0, 255, 0)
		end
	end
end
addCommandHandler("createemitter", createEmitter, false, false)