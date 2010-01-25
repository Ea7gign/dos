-- Still needs a Computer item (which is dropped like a safe) and a PDA item which can be used at any time. For now /turnon to test.

------------------
-- GUI Elements --
------------------
-- Computer window
local wComputer,desktopImage,internetButton,shutdownButton = nil
	-- Internet window
	wInternet, wInternet_bg, internet_close_button, internet_address_label, address_bar, go_button, internet_pane, shadow_top, shadow_left, shadow_bottom, bg = nil

------------------------------------------------------------------
------------------------ Computer desktop ------------------------
------------------------------------------------------------------

-- Player uses the computer item. -> Create the computer GUI.
function createComputerGUI( )
	-- Window variables
	local Width = 700
	local Height = 500
	local screenwidth, screenheight = guiGetScreenSize()
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	if not (wComputer) then
		--Freeze the player so they can't move while using a computer.
		
		wComputer = guiCreateWindow(X, Y, Width, Height, "Computer", false)
		desktopImage = guiCreateStaticImage(0.0,0.05,1,0.95,"desktop.png",true,wComputer)
		internetButton = guiCreateStaticImage (260,105,56,66,"internet_icon.png",false,desktopImage)
		addEventHandler("onClientGUIClick",internetButton,openInternetWindow,false)
		shutdownButton = guiCreateStaticImage(620,390,56,66,"shutdown_icon.png",false,desktopImage)
		addEventHandler("onClientGUIClick",shutdownButton,closeComputerWindow,false)
		showCursor(true)	
	end
end
addCommandHandler("turnon",createComputerGUI)

function closeComputerWindow()
	if(wInternet)then -- Internet window
		destroyElement(bg)
		destroyElement(shadow_left)
		destroyElement(shadow_bottom)
		destroyElement(shadow_top)
		destroyElement(internet_pane)
		destroyElement(go_button)
		destroyElement(address_bar)
		destroyElement(internet_address_label)
		destroyElement(internet_close_button)
		destroyElement(wInternet_bg)
		destroyElement(wInternet)
		wInternet, wInternet_bg, internet_close_button, internet_address_label, address_bar, go_button, internet_pane, shadow_top, shadow_left, shadow_bottom, bg = nil
	end
	-- Computer Desktop GUI.
	destroyElement(wComputer)
	destroyElement(desktopImage)
	destroyElement(internetButton)
	destroyElement(shutdownButton)
	wComputer,desktopImage,internetButton,shutdownButton = nil
	
	showCursor(false)	
	
end
addCommandHandler("ctl+alt+del",closeComputerWindow)

------------------------------------------------------------
------------------------ Internet   ------------------------
------------------------------------------------------------

function openInternetWindow()
	local Width = 504
	local Height = 500
	local screenwidth, screenheight = guiGetScreenSize()
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	if not (wInternet) then
		wInternet = guiCreateWindow(X, Y, Width, Height, "Internet", false,wComputer)
		wInternet_bg = guiCreateStaticImage(0.02,0.02,0.96,0.96,"websites/colours/14.png",true,wInternet)
		internet_close_button = guiCreateButton(462,11,20,20,"x",false,wInternet_bg)
		addEventHandler("onClientGUIClick",internet_close_button,closeInternetWindow,false)
		internet_address_label = guiCreateLabel(5,15,490,20,"",false,wInternet_bg)
		guiLabelSetColor(internet_address_label,28,28,28)
		address_bar = guiCreateEdit(5,40,320,24,"",false,wInternet_bg)
		go_button = guiCreateButton(337,40,24,24,"Go",false,wInternet_bg)
		addEventHandler("onClientGUIClick",go_button,function()
			local new_page = guiGetText(address_bar)
			get_page(new_page)
		end,false)		
		internet_pane = guiCreateScrollPane(2,80,480,397,false,wInternet_bg)
		guiScrollPaneSetScrollBars(internet_pane, false, true)			
		shadow_top = guiCreateStaticImage(2,79,476,1,"websites/colours/13.png",false,wInternet_bg)
		shadow_left = guiCreateStaticImage(2,80,1,397,"websites/colours/13.png",false,wInternet_bg)
		shadow_bottom = guiCreateStaticImage(4,498,476,1,"websites/colours/1.png",false,wInternet_bg)
		www_sanetwork_sa()		
	end
end

function closeInternetWindow()
	if(wInternet) then
		destroyElement(bg)
		destroyElement(shadow_left)
		destroyElement(shadow_bottom)
		destroyElement(shadow_top)
		destroyElement(internet_pane)
		destroyElement(go_button)
		destroyElement(address_bar)
		destroyElement(internet_address_label)
		destroyElement(internet_close_button)
		destroyElement(wInternet_bg)
		destroyElement(wInternet)
		wInternet, wInternet_bg, internet_close_button, internet_address_label, address_bar, go_button, internet_pane, shadow_top, shadow_left, shadow_bottom, bg = nil
	end
end