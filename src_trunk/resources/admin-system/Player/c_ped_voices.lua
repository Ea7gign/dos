--[[setTimer(
	function()
		for key, value in ipairs( getElementsByType( "player" ) ) do
			if getElementDimension( value ) < 65000 then
				if getElementAlpha( value ) < 127 and not getElementData( value, "ped:voice" ) then
					setElementData( value, "ped:voice", { getPedVoice( value ) }, false )
					setPedVoice( value, "PED_TYPE_DISABLED" )
				elseif getElementData( value, "ped:voice" ) then
					setPedVoice( value, unpack( getElementData( value, "ped:voice" ) ) )
					setElementData( value, "ped:voice", false, false )
				end
			elseif getElementData( value, "ped:voice" ) then
				setElementData( value, "ped:voice", false, false )
			end
		end
	end,
	1000,
	0
)]]--