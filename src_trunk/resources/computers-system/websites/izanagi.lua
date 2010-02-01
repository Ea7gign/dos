-------------------
-- WEBSITE TITLE --
-------------------

-- Website owner's forum name: Izanagi
-- Website owner's Character's name: Vincenzo_Rossi

function www_izanagi_sa()
	
	local page_length = 396
	guiSetText(internet_address_label, "Izanagi.sa - Get your website today!")
	guiSetText(address_bar,"www.izanagi.sa")
	
	-- Page Background Colour
	-------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/19.png",false,internet_pane)

	local title_shadow = guiCreateLabel(161,24,350,64,"Izanagi",false,bg)
	guiLabelSetHorizontalAlign(title_shadow,"center")
	guiSetFont(title_shadow,"sa-header")
	guiLabelSetColor(title_shadow,128,8,8)
	
	local title = guiCreateLabel(160,23,350,64,"Izanagi",false,bg)
	guiLabelSetColor(title,  255,16,16)
	guiLabelSetHorizontalAlign(title,"center")
	guiSetFont(title,"sa-header")
	
	local head1 = guiCreateLabel(160,88,350,16, "My works",false,bg)
	guiLabelSetColor(head1,  255,16,16)
	guiLabelSetHorizontalAlign(head1, "center")
	guiSetFont(head1, "default-bold-small")
	
	local list1 = guiCreateLabel(160,104,350, 16, "Midoru Enterprises",false,bg)
	guiLabelSetColor(list1, 255,255,255)
	guiLabelSetHorizontalAlign(list1, "center")
	guiSetFont(list1, "default-normal")
	
	local list2 = guiCreateLabel(160,120,350,16, "www.midoruenterprises.sa",false,bg)
	guiLabelSetColor(list2, 255,255,255)
	guiLabelSetHorizontalAlign(list2, "center")
	guiSetFont(list2, "default-small")

	local list3 = guiCreateLabel(160,152,350, 16, "Bibles",false,bg)
	guiLabelSetColor(list3, 255,255,255)
	guiLabelSetHorizontalAlign(list3, "center")
	guiSetFont(list3, "default-normal")
	
	local list4 = guiCreateLabel(160,168,350,16, "www.bibles.sa",false,bg)
	guiLabelSetColor(list4, 255,255,255)
	guiLabelSetHorizontalAlign(list4, "center")
	guiSetFont(list4, "default-small")
	
	local request_info = guiCreateLabel(8,300,230,96,"If you would like me to create you a website for a reasonable price, mail to izanagi@whiz.sa. I will try to sort and reply to your request ASAP.",false,bg)
	guiLabelSetHorizontalAlign(request_info,"left",true)
	guiLabelSetColor(request_info, 255,16,16)
	
	local logo = guiCreateStaticImage(519,286,146,110, "websites/images/izanagi-red.png", false, bg)

	addEventHandler("onClientGUIClick",logo,function()
		local url = tostring("www.izanagi.sa")
		get_page(url)
	end,false)
	
	addEventHandler("onClientGUIClick",list1,function()
		local url = tostring("www.midoruenterprises.sa")
		get_page(url)
	end,false)
	
	addEventHandler("onClientGUIClick",list3,function()
		local url = tostring("www.bibles.sa")
		get_page(url)
	end,false)
	
	
	
	----------------------------------------------- End of webpage design -- Do not edit below this line. -----------------------------------------------
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(bg,false,true)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
	
end
