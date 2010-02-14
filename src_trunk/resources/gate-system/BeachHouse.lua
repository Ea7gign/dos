local gates =
{
	{ gate = createObject(2930,234.20394897461,1033.2303955078,1089.9243164063,0,0,0), offset = { 0, -1.3, 0, 0, 0, 0 }, open = true },
	{ gate = createObject(2930,236.91362304688,1036.974609375,1089.8624267578,0,0,90), offset = { -1.3, 0, 0, 0, 0, 0 }, open = true },
	{ gate = createObject(2886,233.85272216797,1035.259765625,1088.6968994141,0,0,270) },
	{ gate = createObject(2886,233.85821533203,1035.7263183594,1088.6968994141,0,0,270) },
	{ gate = createObject(14888,240.83984375,1034.841796875,1088.1696777344,0,0,90) },
	{ gate = createObject(14890,240.98783874512,1034.8640136719,1088.1726074219,0,0,90) },
}

for _, gate in pairs(gates) do
	setElementInterior(gate.gate, 7)
	setElementDimension(gate.gate, 9700)
end

setElementData( gates[3].gate, "door:event", { "doorBeachHouse", 1 } )
setElementData( gates[4].gate, "door:event", { "doorBeachHouse", 2 } )

local function resetBusy( shortestID )
	gates[ shortestID ].busy = nil
end

local function openDoor(id)
	if getElementDimension(source) == 9700 then
		local gate = gates[id]
		if gate and gate.offset then
			if not gate.busy then
				if gate.open then
					local nx, ny, nz = getElementPosition( gate.gate )
					moveObject( gate.gate, 1000, nx - gate.offset[1], ny - gate.offset[2], nz - gate.offset[3], -gate.offset[4], -gate.offset[5], -gate.offset[6] )
					outputChatBox( "You closed the door!", source, 0, 255, 0 )
					gate.open = false
				else
					local nx, ny, nz = getElementPosition( gate.gate )
					moveObject( gate.gate, 1000, nx + gate.offset[1], ny + gate.offset[2], nz + gate.offset[3], gate.offset[4], gate.offset[5], gate.offset[6] )
					outputChatBox( "You opened the door!", source, 0, 255, 0 )
					gate.open = true
				end
				gate.busy = true
				setTimer( resetBusy, 1000, 1, id )
			end
		end
	end
end
addEvent( "doorBeachHouse", true )
addEventHandler( "doorBeachHouse", getRootElement( ), openDoor)
