local voices = { }

setTimer(
	function()
		for key, value in ipairs( getElementsByType( "player" ) ) do
			if getElementDimension( value ) < 65000 then
				if getElementAlpha( value ) < 127 and not voices[ value ] then
					voices[ value ] = { getPedVoice( value ) }
					setPedVoice( value, "PED_TYPE_DISABLED" )
				elseif voices[ value ] then
					setPedVoice( value, unpack( voices[ value ] ) )
					voices[ value ] = nil
				end
			elseif voices[ value ] then
				voices[ value ] = nil
			end
		end
	end,
	1000,
	0
)

addEventHandler( "onClientPlayerQuit", getRootElement( ),
	function( )
		voices[ source ] = nil
	end
)