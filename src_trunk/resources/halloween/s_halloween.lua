addCommandHandler( "serialkiller",
	function( thePlayer )
		if exports.global:isPlayerAdmin( thePlayer )
			if getElementModel( thePlayer ) > 0 then
				setElementModel( thePlayer, 0 )
				addPedClothes( thePlayer, "gimpleg", "gimpleg", 17 )
				exports.global:giveWeapon( thePlayer, 9, 1, true )
			else
				exports.global:takeWeapon( thePlayer, 9 )
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
	end
)