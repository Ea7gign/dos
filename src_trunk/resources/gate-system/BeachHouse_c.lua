local localPlayer = getLocalPlayer()

addEventHandler( "onClientClick", getRootElement( ),
	function( button, state, absX, absY, worldX, worldY, worldZ, element )
		if button == "left" and state == "up" and element then
			if getElementParent(getElementParent(element)) == getResourceRootElement() then
				local e = getElementData(element, "door:event")
				if e then
					local event, param = unpack( e )
					triggerServerEvent( event, localPlayer, param )
				end
			end
		end
	end
)