function getVehicleVelocity(vehicle)
	speedx, speedy, speedz = getElementVelocity (vehicle)
	actualspeed = ((speedx^2 + speedy^2 + speedz^2)^(0.5)*100) * 2
	
	return actualspeed
end