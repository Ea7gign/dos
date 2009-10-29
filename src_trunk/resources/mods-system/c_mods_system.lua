local club420 = nil

function applyMods()
	----------------------
	-- Pig Pen Interior --
	----------------------
	-- Bar
	pigpen1 = engineLoadTXD("lv/lee_stripclub1.txd")
	engineImportTXD(pigpen1, 14831)
	
	-- corver stage + seat
	pigpen2 = engineLoadTXD("lv/lee_stripclub.txd")
	engineImportTXD(pigpen2, 14832)
	-- Backwall seats
	engineImportTXD(pigpen2, 14833)
	-- columns
	engineImportTXD(pigpen2, 14835)
	-- corner seats
	engineImportTXD(pigpen2, 14837)
	-- main interior structure
	engineImportTXD(pigpen2, 14838)	
	
	------------------------
	--		 Cop Cars     --
	------------------------
	--copcarvg = engineLoadTXD ( "copcarvg.txd" )
	--engineImportTXD ( copcarvg, 596 )
	--copcarvgdff = engineLoadDFF ( "copcarvg.dff", 596 )
	--engineReplaceModel ( copcarvgdff, 596 )
	
	--copcarvgswat = engineLoadTXD ( "copcarvg.txd" )
	--engineImportTXD ( copcarvgswat, 597 )
	--copcarvgswatdff = engineLoadDFF ( "copcarvg.dff", 597 )
	--engineReplaceModel ( copcarvgswatdff, 597 )
	------------------------
	-- bus Stop --
	------------------------
	busStop = engineLoadTXD("lv/bustopm.txd")
	engineImportTXD(busStop, 1257)
			
	----------------
	-- Billboards --
	----------------
	
	------------------
	-- Police Skins --
	------------------
	-- LSPD
	--lspd = engineLoadTXD("skins/lvpd/lapd1.txd")
	--engineImportTXD(lspd, 280)
	
	-- SFPD
	--sfpd = engineLoadTXD("skins/lvpd/sfpd1.txd")
	--engineImportTXD(sfpd, 281)
	
	-- SWAT
	--swatCop = engineLoadTXD("skins/lvpd/swat.txd")
	--engineImportTXD(swatCop, 285)
	
	-- Cadet
	--cadet = engineLoadTXD("skins/lvpd/wmysgrd.txd")
	--engineImportTXD(cadet, 71)
	
	----------------
	-- Gang Tags --
	----------------
	tag1 = engineLoadTXD("tags/tags_lafront.txd") -- vG logo
	engineImportTXD(tag1, 1524)
	
	tag2 = engineLoadTXD("tags/tags_lakilo.txd") -- MTA 
	engineImportTXD(tag2, 1525)

	tag3 = engineLoadTXD ( "tags/tags_larifa.txd" )
	engineImportTXD ( tag3, 1526 )

	-- tag4 = engineLoadTXD ( "tags/tags_larollin.txd" )
	-- engineImportTXD ( tag4, 1527 )

	-- tag5 = engineLoadTXD ( "tags/tags_laseville.txd" )
	-- engineImportTXD ( tag5, 1528 )

	-- tag6 = engineLoadTXD ( "tags/tags_latemple.txd" )
	-- engineImportTXD ( tag6, 1529 )

	-- tag7 = engineLoadTXD ( "tags/tags_lavagos.txd" )
	-- engineImportTXD ( tag7, 1530 )

	tag8 = engineLoadTXD ( "tags/tags_laazteca.txd" ) -- Los Malvados
	engineImportTXD ( tag8, 1531 )
	
	----------------------------
	-- Pacific Flight Company --
	----------------------------
	pfc = engineLoadTXD ( "lv/airport3_las.txd" )
	engineImportTXD ( pfc, 4828 )
	
	ground3_las = engineLoadTXD ( "lv/ground3_las.txd" )
	engineImportTXD ( ground3_las, 1267 )
	engineImportTXD ( ground3_las, 5017 )

	towing = engineLoadTXD ( "lv/eastbeach3c_lae2.txd" )
	engineImportTXD ( towing, 17555 )
	
	------------
	-- PRO LS --
	------------
	proLS = engineLoadTXD ( "lv/sunset02_law2.txd" )
	engineImportTXD ( proLS, 6364 )
	
	-----------------
	-- Joe Lautner --
	-----------------
	lautner = engineLoadTXD( "lv/billbrd01_lan.txd" )
	engineImportTXD ( lautner, 4239 )
	
	--[[--------------
	-- Club 420 --
	--------------
	club420col = createColSphere( -2658.7900390625, 1410.015625, 910.17034912109, 100 )
	setElementDimension( club420col, 1355 )
	setElementInterior( club420col, 3 )
	
	addEventHandler( "onClientColShapeHit", club420col,
		function( p, d )
			if p == getLocalPlayer( ) and d and not club420 then
				club420 = engineLoadTXD( "lv/pdomes_logo.txd" )
				engineImportTXD ( club420, 14539 )
			end
		end
	)
	
	addEventHandler( "onClientColShapeLeave", club420col,
		function( p )
			if p == getLocalPlayer( ) and club420 then
				destroyElement( club420 )
				club420 = nil
			end
		end
	)
	club420b = engineLoadTXD( "lv/lanlacmab_lan2.txd" )
	engineImportTXD ( club420b, 4594 )
	]]
end
addEventHandler("onClientResourceStart", getResourceRootElement(), applyMods)