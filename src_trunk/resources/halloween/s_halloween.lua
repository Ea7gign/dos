addCommandHandler( "serialkiller",
	function( thePlayer )
		if getElementModel( thePlayer ) > 0 then
			setElementModel( thePlayer, 0 )
			addPedClothes( thePlayer, "gimpleg", "gimpleg", 17 )
		else
			for i = 1, 17 do
				removePedClothes( thePlayer, i )
			end
			local has, _, skin = exports.global:hasItem( thePlayer, 16 )
			if has then
				setElementModel( thePlayer, skin )
			else
				setElementModel( thePlayer, 264 )
			end
		end
	end
)