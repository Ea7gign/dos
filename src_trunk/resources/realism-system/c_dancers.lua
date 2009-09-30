----------------------------------------------------
-------------------- DANCE PEDS --------------------
----------------------------------------------------

------/////////////////////// The Starlight ///////////////////////------

local starlight1=createPed(192,484.998046875, -17.3203125, 1000.6796875)
setElementInterior(starlight1,17)
setElementDimension(starlight1,9908)
setPedRotation(starlight1, 310)
setPedAnimation(starlight1,"DANCING","DAN_Down_A")

local starlight2=createPed(195,485.3095703125, -11.859375, 1000.6796875)
setElementInterior(starlight2,17)
setElementDimension(starlight2,9908)
setPedRotation(starlight2, 200)
setPedAnimation(starlight2,"DANCING","DAN_Loop_A")

local starlight3=createPed(233,489.720703125, -12.7744140625, 1000.6796875)
setElementInterior(starlight3,17)
setElementDimension(starlight3,9908)
setPedRotation(starlight3, 150)
setPedAnimation(starlight3,"DANCING","DAN_Right_A")

local current = 1
function updateLoop()
	if current == 1 then
		setPedAnimation(starlight1,"DANCING","DAN_Down_A")
		setPedAnimation(starlight2,"DANCING","DAN_Loop_A")
		setPedAnimation(starlight3,"DANCING","DAN_Right_A")
		current = 2
	elseif current == 2 then
		setPedAnimation(starlight1,"DANCING","DAN_Loop_A")
		setPedAnimation(starlight2,"DANCING","DAN_Right_A")
		setPedAnimation(starlight3,"DANCING","dnce_M_d")
		current = 3
	elseif current == 3 then
		setPedAnimation(starlight1,"DANCING","DAN_Right_A")
		setPedAnimation(starlight2,"DANCING","dnce_M_d")
		setPedAnimation(starlight3,"DANCING","DAN_Down_A")
		current = 4
	elseif current == 4 then
		setPedAnimation(starlight1,"DANCING","dnce_M_d")
		setPedAnimation(starlight2,"DANCING","DAN_Down_A")
		setPedAnimation(starlight3,"DANCING","DAN_Loop_A")
		current = 1
	end
end

setTimer(updateLoop, 15000, 0)