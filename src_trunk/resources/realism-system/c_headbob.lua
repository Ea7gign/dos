
function bobHead()
	local logged = getElementData(getLocalPlayer(), "loggedin")
	
	if (logged==1) then
        local scrWidth, scrHeight = guiGetScreenSize()
        local sx = scrWidth/2
        local sy = scrHeight/2
        local x, y, z = getWorldFromScreenPosition(sx, sy, 10)
        setPedLookAt(getLocalPlayer(), x, y, z, 3000)
	end
end
addEventHandler("onClientRender", getRootElement(), bobHead)

function resetCam()
	setCameraTarget(getLocalPlayer())
end
addCommandHandler("resetcam", resetCam)

local show = false
function showColBox()
	if (show) then
		removeEventHandler("onClientPreRender", getRootElement(), drawBox)
		show = false
	else
		addEventHandler("onClientPreRender", getRootElement(), drawBox)
		show = true
	end
end
addCommandHandler("showcol", showColBox)

function drawBox()
	for key, value in ipairs(getElementsByType("player")) do
		if isElementStreamedIn(value) and (isElementOnScreen(value)) then
			if (value~=getLocalPlayer()) then
				local px, py, pz = getElementPosition(value)
				local x, y, z, x2, y2, z2 = getElementBoundingBox(value)
					
				local width = 4
				dxDrawLine3D(px+x, py+y, pz+z, px+x, py+y, pz+z2, tocolor(255, 0, 0, 150), width, true, 0)
				dxDrawLine3D(px+x, py+y2, pz+z2, px+x, py+y2, pz+z, tocolor(255, 0, 0, 150), width, true, 1)
				dxDrawLine3D(px+x2, py+y, pz+z2, px+x2, py+y, pz+z, tocolor(255, 0, 0, 150), width, true, 2)
				dxDrawLine3D(px+x2, py+y2, pz+z2, px+x2, py+y2, pz+z, tocolor(255, 0, 0, 150), width, true, 3)
					
				dxDrawLine3D(px+x, py+y2, pz+z2, px+x2, py+y2, pz+z2, tocolor(255, 0, 0, 150), width, true, 4)
				dxDrawLine3D(px+x2, py+y2, pz+z2, px+x2, py+y, pz+z2, tocolor(255, 0, 0, 150), width, true, 5)
				dxDrawLine3D(px+x, py+y, pz+z2, px+x, py+y2, pz+z2, tocolor(255, 0, 0, 150), width, true, 6)
				dxDrawLine3D(px+x, py+y, pz+z2, px+x2, py+y, pz+z2, tocolor(255, 0, 0, 150), width, true, 7)
					
				dxDrawLine3D(px+x, py+y2, pz+z2, px+x2, py+y2, pz+z, tocolor(255, 0, 0, 150), width, true, 8)
				dxDrawLine3D(px+x2, py+y2, pz+z2, px+x2, py+y, pz+z, tocolor(255, 0, 0, 150), width, true, 9)
				dxDrawLine3D(px+x, py+y, pz+z2, px+x, py+y2, pz+z, tocolor(255, 0, 0, 150), width, true, 10)
				dxDrawLine3D(px+x, py+y, pz+z2, px+x2, py+y, pz+z, tocolor(255, 0, 0, 150), width, true, 11)
					
				dxDrawLine3D(px+x, py+y2, pz+z, px+x2, py+y2, pz+z, tocolor(255, 0, 0, 150), width, true, 8)
				dxDrawLine3D(px+x2, py+y2, pz+z, px+x2, py+y, pz+z, tocolor(255, 0, 0, 150), width, true, 9)
				dxDrawLine3D(px+x, py+y, pz+z, px+x, py+y2, pz+z, tocolor(255, 0, 0, 150), width, true, 10)
				dxDrawLine3D(px+x, py+y, pz+z, px+x2, py+y, pz+z, tocolor(255, 0, 0, 150), width, true, 11)
					
				dxDrawLine3D(px+x, py+y2, pz+z2, px+x2, py+y, pz+z2, tocolor(255, 0, 0, 150), width, true, 12)
				dxDrawLine3D(px+x, py+y2, pz+z, px+x2, py+y, pz+z, tocolor(255, 0, 0, 150), width, true, 12)
			end
		end
	end
end


local cam = false
function togGta1()
	if (cam) then
		removeEventHandler("onClientPreRender", getRootElement(), gta1cam)
		setCameraTarget(getLocalPlayer())
		cam = false
	else
		setPedRotation(getLocalPlayer(), 360)
		setPedCameraRotation(getLocalPlayer(), 360)
		addEventHandler("onClientPreRender", getRootElement(), gta1cam)
		cam = true
	end
end
addCommandHandler("gta1", togGta1)

function gta1cam()
	local player = getLocalPlayer()
	local x, y, z = getElementPosition(player)
	setCameraMatrix(x, y, z+20, x, y, z)
end