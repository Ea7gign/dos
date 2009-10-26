local pdgates = 
{
	{
		{ createObject(3089,239.5,116.1,1003.5477294922,0,0,90), 90 },
		{ createObject(3089,239.5,119.0,1003.5477294922,0,0,270), -90 }
	},
	{
		{ createObject(3089,253.2,107.6,1003.5477294922,0,0,90), -90 },
		{ createObject(3089,253.2,110.5,1003.5477294922,0,0,270), 90 }
	},
	{
		{ createObject(3089,239.62,123.6,1003.5477294922,0,0,90), -90 },
		{ createObject(3089,239.62,126.5,1003.5477294922,0,0,270), 90 }
	},
	{
		{ createObject(3089,253.2,123.84042358398,1003.5477294922,0,0,90), -90 },
		{ createObject(3089,253.2,126.75514221191,1003.5477294922,0,0,270), 90 }
	},
	{
		{ createObject(3089,229.7,119.5,1010.5477294922,0,0,0), 90 },
		{ createObject(3089,232.6,119.5,1010.5477294922,0,0,180), -90 }
	},
	{
		{ createObject(3089,232.9,110.55,1010.5477294922,0,0,270), 90 },
		{ createObject(3089,232.9,107.65,1010.5477294922,0,0,90), -90 }
	},
	{
		{ createObject(1495,213.78079223633,123.9891204834,998.015625,0,0,0), 90 }
	},
	{
		{ createObject(1495,215.49610900879,123.78,998.015625,0,0,269.72082519531), 90 }
	},
	{
		{ createObject(1495,213.6,118.73033905029,998.015625,0,0,358.8828125), -88 }
	},
	{
		{ createObject(1495,216.30,116.5,998.03,0,0,0), -90 },
		{ createObject(1495,219.28,116.51,998.03,0,0,180), 90 }
	},
	{
		{ createObject(3089,222.1875,119.51522064209,1010.5477294922,0,0,0), 90 }
	}
}

for _, group in pairs(pdgates) do
	for _, gate in ipairs(group) do
		setElementInterior(gate[1], 10)
		setElementDimension(gate[1], 10583)
	end
end

local function resetBusy( shortestID )
	pdgates[ shortestID ].busy = nil
end

local function closeDoor( shortestID )
	group = pdgates[ shortestID ]
	for _, gate in ipairs(group) do
		local nx, ny, nz = getElementPosition( gate[1] )
		moveObject( gate[1], 1000, nx, ny, nz, 0, 0, -gate[2] )
	end
	group.busy = true
	group.timer = nil
	setTimer( resetBusy, 1000, 1, shortestID )
end

local function openDoor(thePlayer)
	if getElementDimension(thePlayer) == 10583 and getElementInterior(thePlayer) == 10 and exports.global:hasItem(thePlayer, 64) then
		local shortest, shortestID, dist = nil, nil, 5
		local px, py, pz = getElementPosition(thePlayer)
		
		for id, group in pairs(pdgates) do
			for _, gate in ipairs(group) do
				local d = getDistanceBetweenPoints3D(px,py,pz,getElementPosition(gate[1]))
				if d < dist then
					shortest = group
					shortestID = id
					dist = d
				end
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
				for _, gate in ipairs(shortest) do
					local nx, ny, nz = getElementPosition( gate[1] )
					moveObject( gate[1], 1000, nx, ny, nz, 0, 0, gate[2] )
				end
				outputChatBox( "You opened the door!", thePlayer, 0, 255, 0 )
			end
			shortest.timer = setTimer( closeDoor, 5000, 1, shortestID )
		end
	end
end
addCommandHandler( "gate", openDoor)
