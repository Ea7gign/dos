local gates = 
{
	{ gate = createObject(1533,477.35,-21.00,1000.47) },
	{ gate = createObject(1533,475.32,-21.32,1002.68,0,0,180) }
}

for _, gate in pairs(gates) do
	setElementInterior(gate.gate, 17)
	setElementDimension(gate.gate, 9717)
end

local gate2 = createObject(1533,0,0,0)
setElementInterior(gate2, 17)
setElementDimension(gate2, 9717)
attachElements(gate2, gates[1].gate,1.75,0.1,0,0,0,180)

local function resetBusy( shortestID )
	gates[ shortestID ].busy = nil
end

local function closeDoor( shortestID )
	gate = gates[ shortestID ]
	local nx, ny, nz = getElementPosition( gate.gate )
	moveObject( gate.gate, 1000, nx, ny, nz, 0, 0, -80 )
	gate.busy = true
	gate.timer = nil
	setTimer( resetBusy, 1000, 1, shortestID )
end

local function openDoor(thePlayer, commandName, pass)
	if getElementDimension(thePlayer) == 9717 and pass == "joshisanidiot" then
		local shortest, shortestID, dist = nil, nil, 5
		local px, py, pz = getElementPosition(thePlayer)
		
		for id, gate in pairs(gates) do
			local d = getDistanceBetweenPoints3D(px,py,pz,getElementPosition(gate.gate))
			if d < dist then
				shortest = gate
				shortestID = id
				dist = d
			end
		end
		
		if shortest then
			if shortest.busy then
				return
			elseif shortest.timer then
				killTimer( shortest.timer )
				shortest.timer = nil
				outputChatBox( "The door is already open!", thePlayer, 0, 255, 0 )
			else
				local nx, ny, nz = getElementPosition( shortest.gate )
				moveObject( shortest.gate, 1000, nx, ny, nz, 0, 0, 80 )
				outputChatBox( "You opened the door!", thePlayer, 0, 255, 0 )
			end
			shortest.timer = setTimer( closeDoor, 5000, 1, shortestID )
		end
	end
end
addCommandHandler( "gate", openDoor)

-- 

local gates2 =
{
	createObject(1533,507.33889770508,-3.5551257133484,999.60827636719,0,0,270),
	createObject(1533,504.04867553711,-10.92481136322,999.6796875,0,0,90),
	createObject(1533,504.0524597168,-10.423944473267,1002.1549072266,2,270,90),
	createObject(1533,504.05889892578,-13.850741386414,999.6796875,0,0,90),
	createObject(1533,504.0517578125,-10.423828125,1002.3050537109,1.99951171875,270,90),
	createObject(1533,504.0478515625,-10.875,999.6796875,0,0,270),
	createObject(1533,474.45993041992,-10.360939025879,1002.6777954102)
}

for _, gate in pairs(gates2) do
	setElementInterior(gate, 17)
	setElementDimension(gate, 9717)
end