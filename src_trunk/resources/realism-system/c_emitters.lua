local emitters = { }

function streamInEmitter()
	if (getElementType(source)=="object") then
		local model = getElementModel(source)
		local x, y, z = getElementPosition(source)
			
		if (model == 849) then -- small fire emitter
			emitters[source] = createFire(x, y, z, 1.8)
			setElementCollisionsEnabled(source, false)
		elseif (model == 850) then -- large fire emitter
			emitters[source] = createFire(x, y, z, 15.0)
			setElementCollisionsEnabled(source, false)
		elseif (model == 851) then -- water
			emitters[source] = fxAddWaterHydrant(x, y, z)
			setElementCollisionsEnabled(source, false)
		end
	end
end
addEventHandler("onClientElementStreamIn", getRootElement(), streamInEmitter)

function streamOutEmitter()
	if (getElementType(source)=="object") then
		local model = getElementModel(source)
		local id = #emitters + 1
		local x, y, z = getElementPosition(source)
			
		if (model >= 849 and model <= 851) then -- is an emitter
			destroyElement(emitters[source])
		end
	end
end
addEventHandler("onClientElementStreamOut", getRootElement(), streamOutEmitter)