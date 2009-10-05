local rbWindow, rbList, bUse, bClose, tempObject, tempObjectID, tempObjectRot = nil
local tempObjectPosX, tempObjectPosY, tempObjectPosZ, tempObjectPosRot = nil

local roadblockID = 	{	"978",					"981", 					"3578", 		"1228", 				"1282", 							"1422", 				"1424", 			"1425",			"1459", 			"3091" 			} -- objectid
local roadblockTypes = 	{ 	"Small roadblock", 		"Large roadblock", 		"Yellow fence", "Small warning fence", 	"Small warning fence with light", 	"Ugly small fence", 	"Sidewalk block", 	"Detour ->", 	"Warning fence", 	"Vehicles ->" 	} -- name
local roadblockRot = 	{	"180",					"0", 					"0",			"90",					"90",								"0",					"0",				"0",			"0",				"0" 			} -- rotation needed to face to player

local thePlayer = getLocalPlayer()

function enableRoadblockGUI(enable)
	if not (rbWindow) then
		local width, height = 300, 400
		local scrWidth, scrHeight = guiGetScreenSize()
		
		local x = scrWidth*0.8 - (width/2)
		local y = scrHeight*0.75 - (height/2)
	
		rbWindow = guiCreateWindow ( x, y, width, height, "Create Roadblocks", false)
		rbList = guiCreateGridList(0.05, 0.05, 0.9, 0.8, true, rbWindow)
		addEventHandler("onClientGUIDoubleClick", rbList, selectRoadblockGUI, false)
		local column = guiGridListAddColumn(rbList, "ID", 0.2)
		local column2 = guiGridListAddColumn(rbList, "Type", 0.6)
		local column3 = guiGridListAddColumn(rbList, "Rot", 0.1)
		
		for key, value in ipairs(roadblockID) do
			local newRow = guiGridListAddRow(rbList)
			guiGridListSetItemText(rbList, newRow, column, roadblockID[key], true, false)
			guiGridListSetItemText(rbList, newRow, column2, roadblockTypes[key], false, false)
			guiGridListSetItemText(rbList, newRow, column3, roadblockRot[key], false, false)
		end

		bUse = guiCreateButton(0.05, 0.85, 0.45, 0.1, "Use", true, rbWindow)
		addEventHandler("onClientGUIClick", bUse, selectRoadblockGUI, false)
		
		bClose = guiCreateButton(0.5, 0.85, 0.45, 0.1, "Close", true, rbWindow)
		addEventHandler("onClientGUIClick", bClose, cancelRoadblockGUI, false)
	
		showCursor(true)
	else
		cleanupRoadblockGUI()
	end
end

function cleanupRoadblockGUI()
	cleanupRoadblock()
	destroyElement(rbWindow)
	rbWindow = nil
	showCursor(false)
end

function cleanupRoadblock()
	if (isElement(tempObject)) then
		destroyElement(tempObject)
		tempObjectPosX, tempObjectPosY, tempObjectPosZ, tempObjectPosRot = nil
		tempObjectID, tempObjectRot = nil
		unbindKey ( "lalt", "down", convertTempToRealObject)
	end
end

function selectRoadblockGUI(button, state)
	if (source==bUse) and (button=="left") or (source==rbList) and (button=="left") then
		local row, col = guiGridListGetSelectedItem(rbList)
		
		if (row==-1) or (col==-1) then
			outputChatBox("Please select a type first!", 255, 0, 0)
		else
			if (isElement(tempObject)) then
				destroyElement(tempObject)
			end
			
			local objectid = tonumber(guiGridListGetItemText(rbList, guiGridListGetSelectedItem(rbList), 1))
			local objectrot = tonumber(guiGridListGetItemText(rbList, guiGridListGetSelectedItem(rbList), 3))
			spawnTempObject(objectid, objectrot)
			showCursor(false)
		end
	end
end

function spawnTempObject(objectid, objectrot)
	tempObjectID = objectid
	tempObjectRot = objectrot
	tempObject = createObject( objectid, 0, 0, 0, 0, 0, 0)
	setElementAlpha(tempObject, 150)
	setElementInterior ( tempObject, getElementInterior ( thePlayer ) )
	setElementDimension ( tempObject, getElementDimension ( thePlayer ) )
	
	
	--bindKey ( "lctrl", "down", updateRoadblockObject)
	bindKey ( "lalt", "down", convertTempToRealObject)
	
	updateRoadblockObject()
end

function convertTempToRealObject(key, keyState)
	if (isElement(tempObject)) then
		triggerServerEvent("roadblockCreateWorldObject", thePlayer, tempObjectID, tempObjectPosX, tempObjectPosY, tempObjectPosZ, tempObjectPosRot)
		cleanupRoadblock()
		showCursor(true)
	end
end

function updateRoadblockObject(key, keyState)
	if (isElement(tempObject)) then
		local distance = 6
		local px, py, pz = getElementPosition ( thePlayer )
		local rz = getPedRotation ( thePlayer )    

		local x = distance*math.cos((rz+90)*math.pi/180)
		local y = distance*math.sin((rz+90)*math.pi/180)
		local b2 = 15 / math.cos(math.pi/180)
		local nx = px + x
		local ny = py + y
		local nz = pz - 0.5
		  
		local objrot =  rz + tempObjectRot
		if (objrot > 360) then
			objrot = objrot-360
		end
		  
		setElementRotation ( tempObject, 0, 0, objrot )
		moveObject ( tempObject, 10, nx, ny, nz)
		
		tempObjectPosX = nx
		tempObjectPosY = ny
		tempObjectPosZ = nz
		tempObjectPosRot = objrot
	end
end
addEventHandler("onClientPreRender",getRootElement(),updateRoadblockObject)

function cancelRoadblockGUI(button, state)
	if (source==bClose) and (button=="left") then
		cleanupRoadblockGUI()
	end
end

addEvent( "enableRoadblockGUI", true )
addEventHandler( "enableRoadblockGUI", getRootElement(), enableRoadblockGUI )