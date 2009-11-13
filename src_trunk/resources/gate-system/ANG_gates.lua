local Gate = {
	[1] = createObject(985 ,-1526.040,496.020,7.929,0,0,355.726), -- Front Gate 
    [2] = createObject(986, -1533.874,496.718,7.929,0,0,354.039), -- Front Gate
    
    [3] = createObject(2990, -1530.347, 482.191, 8.343, 0, 0,  178.648), -- Second Front Gate
    
    [4] = createObject(3115, -1456.597,501.305,9.839,0,0,0), -- Plane Lift
    
    [5] = createObject(3114, -1414.451,516.467,9.617,0,0,0), -- Helicopter Lift
    
    [6] = createObject(3113,-1466.03,501.091,2,0,0,0) -- Bottom Carrier Door (Boat Door)
}

local GateName = "Gate"
local open = false
local liftOpen = false


local function ResetOpenState()
	open = false
end

-- 1st Enterance Gate --
local function closeGateOne(thePlayer)
	if (getElementType(thePlayer)) then
		outputChatBox("The " .. GateName .. " is now closed!", thePlayer, 255, 0, 0)
	end
	moveObject(Gate[1], 1000, -1526.04,496.020,7.929,0,0,0)
	moveObject(Gate[2], 1000, -1533.874,496.718,7.929,0,0,0)
	setTimer(ResetOpenState, 1000, 1)
end


local function useGateOne(thePlayer, commandName, ...)
	local x, y, z = getElementPosition(thePlayer)
	local distance = getDistanceBetweenPoints3D(-1526.040,496.020,7.929, x, y, z)
	
	if (distance<=20) and (open==false) then
		if getPlayerTeam(thePlayer) == getTeamFromName("Air National Guard") then
			outputChatBox("The " .. GateName .. " is now open!", thePlayer, 0, 255, 0)
			moveObject(Gate[1], 1000, -1520, 495, 7, 0, 0, 0)
			moveObject(Gate[2], 1000, -1539, 497, 7, 0, 0, 0)
			setTimer(closeGateOne, 5000, 1, thePlayer)
			open = true
		end
	end
end
addCommandHandler("gate1", useGateOne)

-- 2nd Enterance Gate -- 
local function closeGateTwo(thePlayer)
	if (getElementType(thePlayer)) then
		outputChatBox("The " .. GateName .. " is now closed!", thePlayer, 255, 0, 0)
	end
	moveObject(Gate[3], 1000,  -1530.347, 482.191, 8.3438, 0, 0,  0)
	setTimer(ResetOpenState, 1000, 1)
end

local function useGateTwo(thePlayer, commandName, ...)
	local x, y, z = getElementPosition(thePlayer)
	local distance = getDistanceBetweenPoints3D(-1530.347, 482.191, 8.34, x, y, z)
	
	if (distance<=20) and (open==false) then
		if getPlayerTeam(thePlayer) == getTeamFromName("Air National Guard") then
			outputChatBox("The " .. GateName .. " is now open!", thePlayer, 0, 255, 0)
			moveObject(Gate[3], 1000, -1539, 482, 8, 0, 0, 0)
			setTimer(closeGateTwo, 5000, 1, thePlayer)
			open = true
		end
	end
end
addCommandHandler("gate2", useGateTwo)

-- Plane Lift --
local function usePlaneLift(thePlayer, commandName, ...)
	local x, y, z = getElementPosition(thePlayer)
	local distance = getDistanceBetweenPoints3D(-1456.597,501.305,9.839, x, y, z)
	
	if (distance<=30) and (liftOpen==false) then
		if getPlayerTeam(thePlayer) == getTeamFromName("Air National Guard") then
			outputChatBox("The lift is now going up...", thePlayer, 0, 255, 0)
			moveObject(Gate[4], 5000, -1456.598,501.305,16.889, 0, 0, 0)
			liftOpen = true
		end
	elseif (distance<=30) and (liftOpen==true) then
		if getPlayerTeam(thePlayer) == getTeamFromName("Air National Guard") then
			outputChatBox("The lift is now going down...", thePlayer, 255, 0, 0)
			moveObject(Gate[4], 5000, -1456.597,501.305,9.839, 0, 0, 0)
			liftOpen = false
		end
	end
end
addCommandHandler("planelift", usePlaneLift)

-- Helicopter Lift --
local function useHelicopterLift(thePlayer, commandName, ...)
	local x, y, z = getElementPosition(thePlayer)
	local distance = getDistanceBetweenPoints3D(-1414.451,516.467,9.617, x, y, z)
	
	if (distance<=30) and (liftOpen==false) then
		if getPlayerTeam(thePlayer) == getTeamFromName("Air National Guard") then
			outputChatBox("The lift is now going up...", thePlayer, 0, 255, 0)
			moveObject(Gate[5], 5000, -1414.452,516.468,16.687, 0, 0, 0)
			liftOpen = true
		end
	elseif (distance<=30) and (liftOpen==true) then
		if getPlayerTeam(thePlayer) == getTeamFromName("Air National Guard") then
			outputChatBox("The lift is now going down...", thePlayer, 255, 0, 0)
			moveObject(Gate[5], 5000, -1414.451,516.467,9.617,0,0,0)
			liftOpen = false
		end
	end
end
addCommandHandler("helilift", useHelicopterLift)

-- Bottom Carrier Door (Boat Door) --
local function useBoatDoor(thePlayer, commandName, ...)
	local x, y, z = getElementPosition(thePlayer)
	local distance = getDistanceBetweenPoints3D(-1466.03,501.091,2, x, y, z)
	
	if (distance<=50) and (liftOpen==false) then
		if getPlayerTeam(thePlayer) == getTeamFromName("Air National Guard") then
			outputChatBox("The Carrier Door is going up...", thePlayer, 0, 255, 0)
			moveObject(Gate[6], 5000, -1468.901,501.333,12,0,0,0)
			liftOpen = true
		end
	elseif (distance<=50) and (liftOpen==true) then
		if getPlayerTeam(thePlayer) == getTeamFromName("Air National Guard") then
			outputChatBox("The Carrier Door is now going down...", thePlayer, 255, 0, 0)
			moveObject(Gate[6], 5000, -1466.03,501.091,2,0,0,0)
			liftOpen = false
		end
	end
end
addCommandHandler("boatdoor", useBoatDoor)