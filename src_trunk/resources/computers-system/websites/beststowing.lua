----------------------
-- Template 1 (blue) --
----------------------

-- Website owner's forum name: Daft Punk
-- Website owner's Character's name: Nicky Corozzo
-- Website builder's forum name: Morgfarm1
-- Website builder's Character's name: Dale Greene


function www_beststowing_sa()
	---------------------
	-- Page Properties --
	---------------------
	local page_length = 390 
	guiSetText(internet_address_label, "Bests Towing & Recovery - Home") -- This text is displayed at the top of the browser window when the page is opened. It is the same as the <title> tag used in the meta of a real webpage.
	guiSetText(address_bar,"www.beststowing.sa") -- The url of the page. This should be the same as the function name but with the original "."s and "/". Example www.google.com.	
	
	---------------------------------------------- Start of webpage design ----------------------------------------------
	
	----------------------------
	-- Page Background Colour --
	----------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/10.png",false,internet_pane) -- DO NOT REMOVE THE BACKGROUND

	------------
	-- Header --
	------------
	local link_1_bg = guiCreateStaticImage(0,4,76,24,"websites/colours/7.png",false,bg)
	local link_1_hl = guiCreateStaticImage(12,6,50,2,"websites/colours/bt&r.png",false,bg)
	local link_1 = guiCreateLabel(2,10,72,16,"Home",false,bg)
	guiLabelSetColor(link_1,255,255,255)
	guiLabelSetHorizontalAlign(link_1,"center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.beststowing.sa") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_2_bg = guiCreateStaticImage(78,4,76,24,"websites/colours/54.png",false,bg)
	local link_2_hl = guiCreateStaticImage(90,6,50,2,"websites/colours/bt&r.png",false,bg)
	local link_2 = guiCreateLabel(80,10,72,16,"Information",false,bg)
	guiLabelSetColor(link_2,255,255,255)
	guiLabelSetHorizontalAlign(link_2,"center")
	addEventHandler("onClientGUIClick",link_2,function()
		local url = tostring("www.beststowing.sa/info") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_3_bg = guiCreateStaticImage(156,4,76,24,"websites/colours/54.png",false,bg)
	local link_3_hl = guiCreateStaticImage(168,6,50,2,"websites/colours/bt&r.png",false,bg)
	local link_3 = guiCreateLabel(158,10,72,16,"Drivers",false,bg)
	guiLabelSetColor(link_3,255,255,255)
	guiLabelSetHorizontalAlign(link_3,"center")
	addEventHandler("onClientGUIClick",link_3,function()
		local url = tostring("www.beststowing.sa/drivers") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_4_bg = guiCreateStaticImage(234,4,76,24,"websites/colours/54.png",false,bg)
	local link_4_hl = guiCreateStaticImage(246,6,50,2,"websites/colours/bt&r.png",false,bg)
	local link_4 = guiCreateLabel(236,10,72,16,"Contact",false,bg)
	guiLabelSetColor(link_1,255,255,255)
	guiLabelSetHorizontalAlign(link_1,"center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.beststowing.sa/contact") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_end_bg = guiCreateStaticImage(312,4,148,24,"websites/colours/7.png",false,bg)
	local url_label_shadow = guiCreateLabel(325,11,130,16,"www.BestsTowing.sa",false,bg)
	guiLabelSetColor(url_label_shadow,28,28,28)
	guiLabelSetHorizontalAlign(url_label_shadow,"center")
	local url_label = guiCreateLabel(324,10,130,16,"www.BestsTowing.sa",false,bg)
	guiLabelSetColor(url_label,255,255,255)
	guiLabelSetHorizontalAlign(url_label,"center")
	
	local header_bg = guiCreateStaticImage(0,28,460,34,"websites/colours/7.png",false,bg)
	local header_label = guiCreateLabel(15,38,122,16,"Home",false,bg)
	guiSetFont(header_label,"default-bold-smal")
	guiLabelSetColor(header_label,255,255,255)
	
	local header_shadow = guiCreateStaticImage(0,61,460,1,"websites/colours/13.png",false,bg)
	
	-------------
	-- Content --
	-------------
	local side_text = guiCreateLabel(10,110,105,120,"Best's Towing & Recovery\
												\
												Head Office Address:\
												Bests Towing & Recovery\
												BT&R Offices\
												Saints Boulevard\
												East Beach, Los Santos\
												San Andreas",false,bg)	
	-- Header 1
	local header_1_bg_shadow = guiCreateStaticImage(107,67,353,25,"websites/colours/13.png",false,bg)
	local header_1_bg = guiCreateStaticImage(108,66,353,25,"websites/colours/7.png",false,bg)
	local header_1_ul = guiCreateStaticImage(108,66,353,1,"websites/colours/bt&r.png",false,bg)
	local header_1 = guiCreateLabel(131,70,200,16,"About Us",false,bg)
	local para1 = guiCreateLabel(128,94,329,70,"Everyone at BT&R strives to bring you fast, quality service at the best price available to you.",false,bg) 
	guiLabelSetHorizontalAlign(para1,"left",true)	
	
	-- Header 2
	local header_2_bg_shadow = guiCreateStaticImage(107,167,353,25,"websites/colours/13.png",false,bg)
	local header_2_bg = guiCreateStaticImage(108,166,353,25,"websites/colours/7.png",false,bg)
	local header_2_ul = guiCreateStaticImage(108,166,353,1,"websites/colours/1.png",false,bg)
	local header_2 = guiCreateLabel(131,170,200,16,"What we do",false,bg)
	local para2 = guiCreateLabel(128,194,329,70,"Our Specialty is the towing of obstructive vehicles in LS and Surrounding areas. We also provide auto repair and repaint as requested.",false,bg) 
	guiLabelSetHorizontalAlign(para2,"left",true)	
	
	----------------------------------------------- End of webpage -- Do not edit below this line. -----------------------------------------------
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
end

--=========================================================================================== Information
function www_beststowing_sa_info()
	---------------------
	-- Page Properties --
	---------------------
	local page_length = 390 
	guiSetText(internet_address_label, "Best's Towing & Recovery - Information") -- This text is displayed at the top of the browser window when the page is opened. It is the same as the <title> tag used in the meta of a real webpage.
	guiSetText(address_bar,"www.beststowing/info") -- The url of the page. This should be the same as the function name but with the original "."s and "/". Example www.google.com.	
	
	---------------------------------------------- Start of webpage design ----------------------------------------------
	
	----------------------------
	-- Page Background Colour --
	----------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/10.png",false,internet_pane) -- DO NOT REMOVE THE BACKGROUND

	------------
	-- Header --
	------------
	local link_1_bg = guiCreateStaticImage(0,4,76,24,"websites/colours/54.png",false,bg)
	local link_1_hl = guiCreateStaticImage(12,6,50,2,"websites/colours/bt&r.png",false,bg)
	local link_1 = guiCreateLabel(2,10,72,16,"Home",false,bg)
	guiLabelSetColor(link_1,255,255,255)
	guiLabelSetHorizontalAlign(link_1,"center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.beststowing.sa") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_2_bg = guiCreateStaticImage(78,4,76,24,"websites/colours/54.png",false,bg)
	local link_2_hl = guiCreateStaticImage(90,6,50,2,"websites/colours/0.png",false,bg)
	local link_2 = guiCreateLabel(80,10,72,16,"Information",false,bg)
	guiLabelSetColor(link_2,255,255,255)
	guiLabelSetHorizontalAlign(link_2,"center")
	addEventHandler("onClientGUIClick",link_2,function()
		local url = tostring("www.beststowing.sa/info") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_3_bg = guiCreateStaticImage(156,4,76,24,"websites/colours/7.png",false,bg)
	local link_3_hl = guiCreateStaticImage(168,6,50,2,"websites/colours/0.png",false,bg)
	local link_3 = guiCreateLabel(158,10,72,16,"Drivers",false,bg)
	guiLabelSetColor(link_3,255,255,255)
	guiLabelSetHorizontalAlign(link_3,"center")
	addEventHandler("onClientGUIClick",link_3,function()
		local url = tostring("www.beststowing.sa/drivers") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_1_bg = guiCreateStaticImage(234,4,76,24,"websites/colours/54.png",false,bg)
	local link_1_hl = guiCreateStaticImage(246,6,50,2,"websites/colours/1.png",false,bg)
	local link_1 = guiCreateLabel(236,10,72,16,"Contact",false,bg)
	guiLabelSetColor(link_1,255,255,255)
	guiLabelSetHorizontalAlign(link_1,"center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.beststowing.sa/contact") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_end_bg = guiCreateStaticImage(312,4,148,24,"websites/colours/7.png",false,bg)
	local url_label_shadow = guiCreateLabel(325,11,130,16,"www.BestsTowing.sa",false,bg)
	guiLabelSetColor(url_label_shadow,28,28,28)
	guiLabelSetHorizontalAlign(url_label_shadow,"center")
	local url_label = guiCreateLabel(324,10,130,16,"www.BestsTowing.sa",false,bg)
	guiLabelSetColor(url_label,255,255,255)
	guiLabelSetHorizontalAlign(url_label,"center")
	
	local header_bg = guiCreateStaticImage(0,28,460,34,"websites/colours/7.png",false,bg)
	local header_label = guiCreateLabel(15,38,122,16,"Information",false,bg)
	guiSetFont(header_label,"default-bold-smal")
	guiLabelSetColor(header_label,255,255,255)
	
	local header_shadow = guiCreateStaticImage(0,61,460,1,"websites/colours/13.png",false,bg)
	
	-------------
	-- Content --
	-------------
	local side_text = guiCreateLabel(10,110,105,120,"Best's Towing & Recovery\
												\
												Head Office Address:\
												Bests Towing & Recovery\
												BT&R Offices\
												Saints Boulevard\
												Los Santos\
												San Andreas",false,bg)	
	-- Header 1
	local header_1_bg_shadow = guiCreateStaticImage(107,67,353,25,"websites/colours/13.png",false,bg)
	local header_1_bg = guiCreateStaticImage(108,66,353,25,"websites/colours/7.png",false,bg)
	local header_1_ul = guiCreateStaticImage(108,66,353,1,"websites/colours/bt&r.png",false,bg)
	local header_1 = guiCreateLabel(131,70,200,16,"Services",false,bg)
	local para1 = guiCreateLabel(128,94,329,70,"For all services, Call our hotline at 999 and a driver should be with you shortly. Just tell us where you are and whats wrong.",false,bg) 
	guiLabelSetHorizontalAlign(para1,"left",true)	
	
	-- Header 2
	local header_2_bg_shadow = guiCreateStaticImage(107,167,353,25,"websites/colours/13.png",false,bg)
	local header_2_bg = guiCreateStaticImage(108,166,353,25,"websites/colours/7.png",false,bg)
	local header_2_ul = guiCreateStaticImage(108,166,353,1,"websites/colours/bt&r.png",false,bg)
	local header_2 = guiCreateLabel(131,170,200,16,"Towing",false,bg)
	local para2 = guiCreateLabel(128,194,329,70,"Most Drivers will make house calls, just call the hotline and tell us what you need towed and where to.",false,bg) 
	guiLabelSetHorizontalAlign(para2,"left",true)

	-- Header 3
	local header_3_bg_shadow = guiCreateStaticImage(107,267,353,25,"websites/colours/13.png",false,bg)
	local header_3_bg = guiCreateStaticImage(108,266,353,25,"websites/colours/7.png",false,bg)
	local header_3_ul = guiCreateStaticImage(108,266,353,1,"websites/colours/1.png",false,bg)
	local header_3 = guiCreateLabel(131,270,200,16,"Automotive Repairs & Paint",false,bg)
	local para3 = guiCreateLabel(128,294,329,70,"Our drivers are skilled mechanics. Just call the hotline and request a repair or repaint. our drivers will be happy to help.",false,bg) 
	guiLabelSetHorizontalAlign(para3,"left",true)		
	
	----------------------------------------------- End of webpage -- Do not edit below this line. -----------------------------------------------
	
----------------------------------------------------------------------
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
end

--================================================================================================== Drivers
function www_beststowing_sa_drivers()
	---------------------
	-- Page Properties --
	---------------------
	local page_length = 390 
	guiSetText(internet_address_label, "Best's Towing & Recovery - Drivers") -- This text is displayed at the top of the browser window when the page is opened. It is the same as the <title> tag used in the meta of a real webpage.
	guiSetText(address_bar,"www.beststowing.sa/drivers") -- The url of the page. This should be the same as the function name but with the original "."s and "/". Example www.google.com.	
	
	---------------------------------------------- Start of webpage design ----------------------------------------------
	----------------------------
	-- Page Background Colour --
	----------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/10.png",false,internet_pane) -- DO NOT REMOVE THE BACKGROUND
	
	------------
	-- Header --
	------------
	local link_1_bg = guiCreateStaticImage(0,4,76,24,"websites/colours/54.png",false,bg)
	local link_1_hl = guiCreateStaticImage(12,6,50,2,"websites/colours/bt&r.png",false,bg)
	local link_1 = guiCreateLabel(2,10,72,16,"Home",false,bg)
	guiLabelSetColor(link_1,255,255,255)
	guiLabelSetHorizontalAlign(link_1,"center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.beststowing.sa") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_2_bg = guiCreateStaticImage(78,4,76,24,"websites/colours/54.png",false,bg)
	local link_2_hl = guiCreateStaticImage(90,6,50,2,"websites/colours/0.png",false,bg)
	local link_2 = guiCreateLabel(80,10,72,16,"Information",false,bg)
	guiLabelSetColor(link_2,255,255,255)
	guiLabelSetHorizontalAlign(link_2,"center")
	addEventHandler("onClientGUIClick",link_2,function()
		local url = tostring("www.beststowing.sa/info") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_3_bg = guiCreateStaticImage(156,4,76,24,"websites/colours/54.png",false,bg)
	local link_3_hl = guiCreateStaticImage(168,6,50,2,"websites/colours/0.png",false,bg)
	local link_3 = guiCreateLabel(158,10,72,16,"Drivers",false,bg)
	guiLabelSetColor(link_3,255,255,255)
	guiLabelSetHorizontalAlign(link_3,"center")
	addEventHandler("onClientGUIClick",link_3,function()
		local url = tostring("www.beststowing.sa/drivers") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_1_bg = guiCreateStaticImage(234,4,76,24,"websites/colours/7.png",false,bg)
	local link_1_hl = guiCreateStaticImage(246,6,50,2,"websites/colours/bt&r.png",false,bg)
	local link_1 = guiCreateLabel(236,10,72,16,"Contact",false,bg)
	guiLabelSetColor(link_1,255,255,255)
	guiLabelSetHorizontalAlign(link_1,"center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.beststowing.sa/contact") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_end_bg = guiCreateStaticImage(312,4,148,24,"websites/colours/7.png",false,bg)
	local url_label_shadow = guiCreateLabel(325,11,130,16,"www.BestsTowing.sa",false,bg)
	guiLabelSetColor(url_label_shadow,28,28,28)
	guiLabelSetHorizontalAlign(url_label_shadow,"center")
	local url_label = guiCreateLabel(324,10,130,16,"www.BestsTowing.sa",false,bg)
	guiLabelSetColor(url_label,255,255,255)
	guiLabelSetHorizontalAlign(url_label,"center")
	
	local header_bg = guiCreateStaticImage(0,28,460,34,"websites/colours/7.png",false,bg)
	local header_label = guiCreateLabel(15,38,122,16,"Drivers",false,bg)
	guiSetFont(header_label,"default-bold-smal")
	guiLabelSetColor(header_label,255,255,255)
	
	local header_shadow = guiCreateStaticImage(0,61,460,1,"websites/colours/13.png",false,bg)
	
	-------------
	-- Content --
	-------------
	local side_text = guiCreateLabel(10,110,105,120,"Best's Towing & Recovery\
												\
												Head Office Address:\
												Bests Towing & Recovery\
												BT&R Offices\
												Saints Boulevard\
												East Beach, Los Santos\
												San Andreas",false,bg)	
	-- Header 1
	local header_1_bg_shadow = guiCreateStaticImage(107,67,353,25,"websites/colours/13.png",false,bg)
	local header_1_bg = guiCreateStaticImage(108,66,353,25,"websites/colours/7.png",false,bg)
	local header_1_ul = guiCreateStaticImage(108,66,353,1,"websites/colours/1.png",false,bg)
	local header_1 = guiCreateLabel(131,70,200,16,"The Owner",false,bg)
	local para1 = guiCreateLabel(128,94,329,70,"Current owner is Nicky Corozzo, a nice guy that handles the companies Finances and overall operations.",false,bg) 
	guiLabelSetHorizontalAlign(para1,"left",true)	
	
	-- Header 2
	local header_2_bg_shadow = guiCreateStaticImage(107,167,353,25,"websites/colours/13.png",false,bg)
	local header_2_bg = guiCreateStaticImage(108,166,353,25,"websites/colours/7.png",false,bg)
	local header_2_ul = guiCreateStaticImage(108,166,353,1,"websites/colours/1.png",false,bg)
	local header_2 = guiCreateLabel(131,170,200,16,"The CEOs",false,bg)
	local para2 = guiCreateLabel(128,194,329,70,"The CEOs are Jimmy Jones and Greg Norris, two country boys that are about as helpful as can be, they also help the owner in his operations",false,bg) 
	guiLabelSetHorizontalAlign(para2,"left",true)

	-- Header 3
	local header_3_bg_shadow = guiCreateStaticImage(107,267,353,25,"websites/colours/13.png",false,bg)
	local header_3_bg = guiCreateStaticImage(108,266,353,25,"websites/colours/7.png",false,bg)
	local header_3_ul = guiCreateStaticImage(108,266,353,1,"websites/colours/1.png",false,bg)
	local header_3 = guiCreateLabel(131,270,200,16,"Head & Lead Drivers",false,bg)
	local para3 = guiCreateLabel(128,294,329,70,"The Head Drivers are Dale Greene, with the most experience in BT&R, and James Fields, 2nd most experience. Our Lead Driver is Rachel Wood.",false,bg) 
	guiLabelSetHorizontalAlign(para3,"left",true)		
	
	----------------------------------------------- End of webpage -- Do not edit below this line. -----------------------------------------------
	
----------------------------------------------------------------------
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
end

--=================================================================================================== Contact
function www_beststowing_sa_contact()
	---------------------
	-- Page Properties --
	---------------------
	local page_length = 390 
	guiSetText(internet_address_label, "Best's Towing & Recovery - Contact") -- This text is displayed at the top of the browser window when the page is opened. It is the same as the <title> tag used in the meta of a real webpage.
	guiSetText(address_bar,"www.beststowing.sa/info") -- The url of the page. This should be the same as the function name but with the original "."s and "/". Example www.google.com.	
	
	---------------------------------------------- Start of webpage design ----------------------------------------------
	
	----------------------------
	-- Page Background Colour --
	----------------------------
	bg = guiCreateStaticImage(0,0,460,page_length,"websites/colours/10.png",false,internet_pane) -- DO NOT REMOVE THE BACKGROUND

	------------
	-- Header --
	------------
	local link_1_bg = guiCreateStaticImage(0,4,76,24,"websites/colours/7.png",false,bg)
	local link_1_hl = guiCreateStaticImage(12,6,50,2,"websites/colours/1.png",false,bg)
	local link_1 = guiCreateLabel(2,10,72,16,"Home",false,bg)
	guiLabelSetColor(link_1,255,255,255)
	guiLabelSetHorizontalAlign(link_1,"center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.beststowing.sa") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_2_bg = guiCreateStaticImage(78,4,76,24,"websites/colours/7.png",false,bg)
	local link_2_hl = guiCreateStaticImage(90,6,50,2,"websites/colours/0.png",false,bg)
	local link_2 = guiCreateLabel(80,10,72,16,"Information",false,bg)
	guiLabelSetColor(link_2,255,255,255)
	guiLabelSetHorizontalAlign(link_2,"center")
	addEventHandler("onClientGUIClick",link_2,function()
		local url = tostring("www.beststowing.sa/info") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_3_bg = guiCreateStaticImage(156,4,76,24,"websites/colours/54.png",false,bg)
	local link_3_hl = guiCreateStaticImage(168,6,50,2,"websites/colours/0.png",false,bg)
	local link_3 = guiCreateLabel(158,10,72,16,"Drivers",false,bg)
	guiLabelSetColor(link_3,255,255,255)
	guiLabelSetHorizontalAlign(link_3,"center")
	addEventHandler("onClientGUIClick",link_3,function()
		local url = tostring("www.beststowing.sa/info") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_1_bg = guiCreateStaticImage(234,4,76,24,"websites/colours/54.png",false,bg)
	local link_1_hl = guiCreateStaticImage(246,6,50,2,"websites/colours/1.png",false,bg)
	local link_1 = guiCreateLabel(236,10,72,16,"Contact",false,bg)
	guiLabelSetColor(link_1,255,255,255)
	guiLabelSetHorizontalAlign(link_1,"center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.beststowing.sa/contact") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_end_bg = guiCreateStaticImage(312,4,148,24,"websites/colours/54.png",false,bg)
	local url_label_shadow = guiCreateLabel(325,11,130,16,"www.BestsTowing.sa",false,bg)
	guiLabelSetColor(url_label_shadow,28,28,28)
	guiLabelSetHorizontalAlign(url_label_shadow,"center")
	local url_label = guiCreateLabel(324,10,130,16,"www.BestsTowing.sa",false,bg)
	guiLabelSetColor(url_label,255,255,255)
	guiLabelSetHorizontalAlign(url_label,"center")
	
	local header_bg = guiCreateStaticImage(0,28,460,34,"websites/colours/7.png",false,bg)
	local header_label = guiCreateLabel(15,38,122,16,"Contact",false,bg)
	guiSetFont(header_label,"default-bold-smal")
	guiLabelSetColor(header_label,255,255,255)
	
	local header_shadow = guiCreateStaticImage(0,61,460,1,"websites/colours/13.png",false,bg)
	
	-------------
	-- Content --
	-------------
	local side_text = guiCreateLabel(10,110,105,120,"Best's Towing & Recovery\
												\
												Head Office Address:\
												Bests Towing & Recovery\
												BT&R Offices\
												Saints Boulevard\
												East Beach, Los Santos\
												San Andreas",false,bg)	
	-- Header 1
	local header_1_bg_shadow = guiCreateStaticImage(107,67,353,25,"websites/colours/13.png",false,bg)
	local header_1_bg = guiCreateStaticImage(108,66,353,25,"websites/colours/7.png",false,bg)
	local header_1_ul = guiCreateStaticImage(108,66,353,1,"websites/colours/1.png",false,bg)
	local header_1 = guiCreateLabel(131,70,200,16,"Contact the Owner",false,bg)
	local para1 = guiCreateLabel(128,94,329,70,"Contact Information for Nicky Corozzo is unavailable at this time.",false,bg) 
	guiLabelSetHorizontalAlign(para1,"left",true)	
	
	-- Header 2
	local header_2_bg_shadow = guiCreateStaticImage(107,167,353,25,"websites/colours/13.png",false,bg)
	local header_2_bg = guiCreateStaticImage(108,166,353,25,"websites/colours/7.png",false,bg)
	local header_2_ul = guiCreateStaticImage(108,166,353,1,"websites/colours/1.png",false,bg)
	local header_2 = guiCreateLabel(131,170,200,16,"Contact the CEOs",false,bg)
	local para2 = guiCreateLabel(128,194,329,70,"Contact Information for Greg Norris & Jimmy Jones is unavailable at this time.",false,bg) 
	guiLabelSetHorizontalAlign(para2,"left",true)

	-- Header 3
	local header_3_bg_shadow = guiCreateStaticImage(107,267,353,25,"websites/colours/13.png",false,bg)
	local header_3_bg = guiCreateStaticImage(108,266,353,25,"websites/colours/7.png",false,bg)
	local header_3_ul = guiCreateStaticImage(108,266,353,1,"websites/colours/1.png",false,bg)
	local header_3 = guiCreateLabel(131,270,200,16,"Contact a Head/Lead Driver",false,bg)
	local para3 = guiCreateLabel(128,294,329,70,"Dale Greene - Head Driver: D.Greene@btr.sa; James Fields - Head Driver: J.Fields@btr.sa; Contact Information for Rachel Wood is Unavailable at this time. ",false,bg) 
	guiLabelSetHorizontalAlign(para3,"left",true)		
	
	----------------------------------------------- End of webpage -- Do not edit below this line. -----------------------------------------------
	
----------------------------------------------------------------------
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
end