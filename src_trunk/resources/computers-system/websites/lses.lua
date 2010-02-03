-----------------------
--   LSES Website   ---
-----------------------

-- Website owner's forum name: fallenmaster1
-- Website owner's Character's name: John Brenkly


function www_lses_gov()
	---------------------
	-- Page Properties --
	---------------------
	local page_length = 390 
	guiSetText(internet_address_label, "LSES Website") -- This text is displayed at the top of the browser window when the page is opened. It is the same as the <title> tag used in the meta of a real webpage.
	guiSetText(address_bar,"www.LSES.gov") -- The url of the page. This should be the same as the function name but with the original "."s and "/". Example www.google.com.	
	
	---------------------------------------------- Start of webpage design ----------------------------------------------
	
	----------------------------
	-- Page Background Colour --
	----------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/31.png",false,internet_pane)
		
	------------
	-- Header --
	------------
	local link_1_bg = guiCreateStaticImage(0,4,76,24,"websites/colours/3.png",false,bg)
	local link_1_hl = guiCreateStaticImage(12,6,50,2,"websites/colours/1.png",false,bg)
	local link_1 = guiCreateLabel(2,10,72,16,"Home Page",false,bg)
	guiLabelSetColor(link_1,255,255,255)
	guiLabelSetHorizontalAlign(link_1,"center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.LSES.gov") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_2_bg = guiCreateStaticImage(78,4,76,24,"websites/colours/45.png",false,bg)
	local link_2_hl = guiCreateStaticImage(90,6,50,2,"websites/colours/36.png",false,bg)
	local link_2 = guiCreateLabel(80,10,72,16,"About us",false,bg)
	guiLabelSetColor(link_2,255,255,255)
	guiLabelSetHorizontalAlign(link_2,"center")
	addEventHandler("onClientGUIClick",link_2,function()
		local url = tostring("www.LSES.gov/About") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_3_bg = guiCreateStaticImage(156,4,76,24,"websites/colours/45.png",false,bg)
	local link_3_hl = guiCreateStaticImage(168,6,50,2,"websites/colours/36.png",false,bg)
	local link_3 = guiCreateLabel(158,10,72,16,"Our Members",false,bg)
	guiLabelSetColor(link_3,255,255,255)
	guiLabelSetHorizontalAlign(link_3,"center")
	addEventHandler("onClientGUIClick",link_3,function()
		local url = tostring("www.LSES.gov/Members") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_4_bg = guiCreateStaticImage(234,4,76,24,"websites/colours/45.png",false,bg)
	local link_4_hl = guiCreateStaticImage(246,6,50,2,"websites/colours/36.png",false,bg)
	local link_4 = guiCreateLabel(236,10,72,16,"Join",false,bg)
	guiLabelSetColor(link_4,255,255,255)
	guiLabelSetHorizontalAlign(link_4,"center")
	addEventHandler("onClientGUIClick",link_4,function()
		local url = tostring("www.LSES.gov/Join") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_end_bg = guiCreateStaticImage(312,4,148,24,"websites/colours/3.png",false,bg)
	local url_label_shadow = guiCreateLabel(325,11,130,16,"www.URL.sa",false,bg)
	guiLabelSetColor(url_label_shadow,30,30,30)
	guiLabelSetHorizontalAlign(url_label_shadow,"center")
	local url_label = guiCreateLabel(324,10,130,16,"www.URL.sa",false,bg)
	guiLabelSetColor(url_label,255,255,255)
	guiLabelSetHorizontalAlign(url_label,"center")
	
	local header_bg = guiCreateStaticImage(0,28,460,34,"websites/colours/3.png",false,bg)
	local header_label = guiCreateLabel(15,38,122,16,"WEBSITE TEMPLATE",false,bg)
	guiSetFont(header_label,"default-bold-smal")
	guiLabelSetColor(header_label,255,255,255)
	
	local header_shadow = guiCreateStaticImage(0,61,460,1,"websites/colours/13.png",false,bg)
	
	-------------
	-- Content --
	-------------
	local side_text = guiCreateLabel(10,110,105,120,"LSES\
												\
												Enjoy your stay\
												Since 29/01/2010\
												\
												Occupations:\
												EMT and FD	",false,bg)	
	-- Header 1
	local header_1_bg_shadow = guiCreateStaticImage(107,67,353,25,"websites/colours/13.png",false,bg)
	local header_1_bg = guiCreateStaticImage(108,66,353,25,"websites/colours/3.png",false,bg)
	local header_1_ul = guiCreateStaticImage(108,66,353,1,"websites/colours/1.png",false,bg)
	local header_1 = guiCreateLabel(131,70,200,16,"header 1",false,bg)
	local para1 = guiCreateLabel(128,94,329,70,"Welcome to the LSES Website. We hope you enjoy your Stay.",false,bg) 
	guiLabelSetHorizontalAlign(para1,"left",true)
	
	-- Header 2
	local header_2_bg_shadow = guiCreateStaticImage(107,167,353,25,"websites/colours/13.png",false,bg)
	local header_2_bg = guiCreateStaticImage(108,166,353,25,"websites/colours/3.png",false,bg)
	local header_2_ul = guiCreateStaticImage(108,166,353,1,"websites/colours/1.png",false,bg)
	local header_2 = guiCreateLabel(131,170,200,16,"header 2",false,bg)
	local para2 = guiCreateLabel(128,94,329,70,"Who and what are we? We are the medical and fire team, out there to help keep your lives safe. ",false,bg) 
	guiLabelSetHorizontalAlign(para2,"left",true)
	
	-- Header 3
	local header_3_bg_shadow = guiCreateStaticImage(107,267,353,25,"websites/colours/13.png",false,bg)
	local header_3_bg = guiCreateStaticImage(108,266,353,25,"websites/colours/3.png",false,bg)
	local header_3_ul = guiCreateStaticImage(108,266,353,1,"websites/colours/1.png",false,bg)
	local header_3 = guiCreateLabel(131,270,200,16,"header 2",false,bg)
	local para3 = guiCreateLabel(128,94,329,70,"Where can we be found? We can normally be found obvious at the Hospital and Fire Department, situated in Market. ",false,bg) 
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

---------- About
function www_lses_gov_about()
	---------------------
	-- Page Properties --
	---------------------
	local page_length = 390 
	guiSetText(internet_address_label, "LSES Website - About") -- This text is displayed at the top of the browser window when the page is opened. It is the same as the <title> tag used in the meta of a real webpage.
	guiSetText(address_bar,"www.lses.gov/about") -- The url of the page. This should be the same as the function name but with the original "."s and "/". Example www.google.com.	
	
	---------------------------------------------- Start of webpage design ----------------------------------------------
	
	----------------------------
	-- Page Background Colour --
	----------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/31.png",false,internet_pane)
		
	------------
	-- Header --
	------------
	local link_1_bg = guiCreateStaticImage(0,4,76,24,"websites/colours/3.png",false,bg)
	local link_1_hl = guiCreateStaticImage(12,6,50,2,"websites/colours/1.png",false,bg)
	local link_1 = guiCreateLabel(2,10,72,16,"About",false,bg)
	guiLabelSetColor(link_1,255,255,255)
	guiLabelSetHorizontalAlign(link_1,"center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.LSES.gov/About") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_2_bg = guiCreateStaticImage(78,4,76,24,"websites/colours/45.png",false,bg)
	local link_2_hl = guiCreateStaticImage(90,6,50,2,"websites/colours/36.png",false,bg)
	local link_2 = guiCreateLabel(80,10,72,16,"Home",false,bg)
	guiLabelSetColor(link_2,255,255,255)
	guiLabelSetHorizontalAlign(link_2,"center")
	addEventHandler("onClientGUIClick",link_2,function()
		local url = tostring("www.LSES.gov") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_3_bg = guiCreateStaticImage(156,4,76,24,"websites/colours/45.png",false,bg)
	local link_3_hl = guiCreateStaticImage(168,6,50,2,"websites/colours/36.png",false,bg)
	local link_3 = guiCreateLabel(158,10,72,16,"Our Members",false,bg)
	guiLabelSetColor(link_3,255,255,255)
	guiLabelSetHorizontalAlign(link_3,"center")
	addEventHandler("onClientGUIClick",link_3,function()
		local url = tostring("www.LSES.gov/Members") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_4_bg = guiCreateStaticImage(234,4,76,24,"websites/colours/45.png",false,bg)
	local link_4_hl = guiCreateStaticImage(246,6,50,2,"websites/colours/36.png",false,bg)
	local link_4 = guiCreateLabel(236,10,72,16,"Join",false,bg)
	guiLabelSetColor(link_4,255,255,255)
	guiLabelSetHorizontalAlign(link_4,"center")
	addEventHandler("onClientGUIClick",link_4,function()
		local url = tostring("www.LSES.gov/Join") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_end_bg = guiCreateStaticImage(312,4,148,24,"websites/colours/3.png",false,bg)
	local url_label_shadow = guiCreateLabel(325,11,130,16,"www.URL.sa",false,bg)
	guiLabelSetColor(url_label_shadow,30,30,30)
	guiLabelSetHorizontalAlign(url_label_shadow,"center")
	local url_label = guiCreateLabel(324,10,130,16,"www.URL.sa",false,bg)
	guiLabelSetColor(url_label,255,255,255)
	guiLabelSetHorizontalAlign(url_label,"center")
	
	local header_bg = guiCreateStaticImage(0,28,460,34,"websites/colours/3.png",false,bg)
	local header_label = guiCreateLabel(15,38,122,16,"WEBSITE TEMPLATE",false,bg)
	guiSetFont(header_label,"default-bold-smal")
	guiLabelSetColor(header_label,255,255,255)
	
	local header_shadow = guiCreateStaticImage(0,61,460,1,"websites/colours/13.png",false,bg)
	
	-------------
	-- Content --
	-------------
	local side_text = guiCreateLabel(10,110,105,120,"LSES\
												\
												Enjoy your stay\
												Since 29/01/2010\
												\
												Occupations:\
												EMT and FD	",false,bg)	
	-- Header 1
	local header_1_bg_shadow = guiCreateStaticImage(107,67,353,25,"websites/colours/13.png",false,bg)
	local header_1_bg = guiCreateStaticImage(108,66,353,25,"websites/colours/3.png",false,bg)
	local header_1_ul = guiCreateStaticImage(108,66,353,1,"websites/colours/1.png",false,bg)
	local header_1 = guiCreateLabel(131,70,200,16,"header 1",false,bg)
	local para1 = guiCreateLabel(128,94,329,70,"Who? We are the LSES. The proud, fully trained medical team and fire department. Working to keep you safe. ",false,bg) 
	guiLabelSetHorizontalAlign(para1,"left",true)
	
	-- Header 2
	local header_2_bg_shadow = guiCreateStaticImage(107,167,353,25,"websites/colours/13.png",false,bg)
	local header_2_bg = guiCreateStaticImage(108,166,353,25,"websites/colours/3.png",false,bg)
	local header_2_ul = guiCreateStaticImage(108,166,353,1,"websites/colours/1.png",false,bg)
	local header_2 = guiCreateLabel(131,170,200,16,"header 2",false,bg)
	local para2 = guiCreateLabel(128,94,329,70,"Where are we from? We're from places! We're just like normal people, but with training. That is all! ",false,bg) 
	guiLabelSetHorizontalAlign(para2,"left",true)
	
	-- Header 3
	local header_3_bg_shadow = guiCreateStaticImage(107,267,353,25,"websites/colours/13.png",false,bg)
	local header_3_bg = guiCreateStaticImage(108,266,353,25,"websites/colours/3.png",false,bg)
	local header_3_ul = guiCreateStaticImage(108,266,353,1,"websites/colours/1.png",false,bg)
	local header_3 = guiCreateLabel(131,270,200,16,"header 2",false,bg)
	local para3 = guiCreateLabel(128,94,329,70,"What do we get? We get the satisfaction in knowing YOU are safe! ",false,bg) 
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

-- Join
function www_lses_gov_join()
	---------------------
	-- Page Properties --
	---------------------
	local page_length = 390 
	guiSetText(internet_address_label, "LSES Website - Join") -- This text is displayed at the top of the browser window when the page is opened. It is the same as the <title> tag used in the meta of a real webpage.
	guiSetText(address_bar,"www.lses.gov/join") -- The url of the page. This should be the same as the function name but with the original "."s and "/". Example www.google.com.	
	
	---------------------------------------------- Start of webpage design ----------------------------------------------
	
	----------------------------
	-- Page Background Colour --
	----------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/31.png",false,internet_pane)
		
	------------
	-- Header --
	------------
	local link_1_bg = guiCreateStaticImage(0,4,76,24,"websites/colours/3.png",false,bg)
	local link_1_hl = guiCreateStaticImage(12,6,50,2,"websites/colours/1.png",false,bg)
	local link_1 = guiCreateLabel(2,10,72,16,"Join",false,bg)
	guiLabelSetColor(link_1,255,255,255)
	guiLabelSetHorizontalAlign(link_1,"center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.LSES.gov/Join") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_2_bg = guiCreateStaticImage(78,4,76,24,"websites/colours/45.png",false,bg)
	local link_2_hl = guiCreateStaticImage(90,6,50,2,"websites/colours/36.png",false,bg)
	local link_2 = guiCreateLabel(80,10,72,16,"Home",false,bg)
	guiLabelSetColor(link_2,255,255,255)
	guiLabelSetHorizontalAlign(link_2,"center")
	addEventHandler("onClientGUIClick",link_2,function()
		local url = tostring("www.LSES.gov") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_3_bg = guiCreateStaticImage(156,4,76,24,"websites/colours/45.png",false,bg)
	local link_3_hl = guiCreateStaticImage(168,6,50,2,"websites/colours/36.png",false,bg)
	local link_3 = guiCreateLabel(158,10,72,16,"Our Members",false,bg)
	guiLabelSetColor(link_3,255,255,255)
	guiLabelSetHorizontalAlign(link_3,"center")
	addEventHandler("onClientGUIClick",link_3,function()
		local url = tostring("www.LSES.gov/Members") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_4_bg = guiCreateStaticImage(234,4,76,24,"websites/colours/45.png",false,bg)
	local link_4_hl = guiCreateStaticImage(246,6,50,2,"websites/colours/36.png",false,bg)
	local link_4 = guiCreateLabel(236,10,72,16,"About",false,bg)
	guiLabelSetColor(link_4,255,255,255)
	guiLabelSetHorizontalAlign(link_4,"center")
	addEventHandler("onClientGUIClick",link_4,function()
		local url = tostring("www.LSES.gov/About") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_end_bg = guiCreateStaticImage(312,4,148,24,"websites/colours/3.png",false,bg)
	local url_label_shadow = guiCreateLabel(325,11,130,16,"www.URL.sa",false,bg)
	guiLabelSetColor(url_label_shadow,30,30,30)
	guiLabelSetHorizontalAlign(url_label_shadow,"center")
	local url_label = guiCreateLabel(324,10,130,16,"www.URL.sa",false,bg)
	guiLabelSetColor(url_label,255,255,255)
	guiLabelSetHorizontalAlign(url_label,"center")
	
	local header_bg = guiCreateStaticImage(0,28,460,34,"websites/colours/3.png",false,bg)
	local header_label = guiCreateLabel(15,38,122,16,"WEBSITE TEMPLATE",false,bg)
	guiSetFont(header_label,"default-bold-smal")
	guiLabelSetColor(header_label,255,255,255)
	
	local header_shadow = guiCreateStaticImage(0,61,460,1,"websites/colours/13.png",false,bg)
	
	-------------
	-- Content --
	-------------
	local side_text = guiCreateLabel(10,110,105,120,"LSES\
												\
												Enjoy your stay\
												Since 29/01/2010\
												\
												Occupations:\
												EMT and FD	",false,bg)	
	-- Header 1
	local header_1_bg_shadow = guiCreateStaticImage(107,67,353,25,"websites/colours/13.png",false,bg)
	local header_1_bg = guiCreateStaticImage(108,66,353,25,"websites/colours/3.png",false,bg)
	local header_1_ul = guiCreateStaticImage(108,66,353,1,"websites/colours/1.png",false,bg)
	local header_1 = guiCreateLabel(131,70,200,16,"header 1",false,bg)
	local para1 = guiCreateLabel(128,94,329,70,"Wanting to Join? Theres many ways you can get in. Read below for more information.. ",false,bg) 
	guiLabelSetHorizontalAlign(para1,"left",true)
	
	-- Header 2
	local header_2_bg_shadow = guiCreateStaticImage(107,167,353,25,"websites/colours/13.png",false,bg)
	local header_2_bg = guiCreateStaticImage(108,166,353,25,"websites/colours/3.png",false,bg)
	local header_2_ul = guiCreateStaticImage(108,166,353,1,"websites/colours/1.png",false,bg)
	local header_2 = guiCreateLabel(131,170,200,16,"header 2",false,bg)
	local para2 = guiCreateLabel(128,94,329,70,"EMS. The Medical department, you can usually find a form to fill out at the hospital. Fill it in and hand it back in! ((Look Out-Of-Game Forums)) ",false,bg) 
	guiLabelSetHorizontalAlign(para2,"left",true)
	
	-- Header 3
	local header_3_bg_shadow = guiCreateStaticImage(107,267,353,25,"websites/colours/13.png",false,bg)
	local header_3_bg = guiCreateStaticImage(108,266,353,25,"websites/colours/3.png",false,bg)
	local header_3_ul = guiCreateStaticImage(108,266,353,1,"websites/colours/1.png",false,bg)
	local header_3 = guiCreateLabel(131,270,200,16,"header 2",false,bg)
	local para3 = guiCreateLabel(128,94,329,70,"FD. Like the Medical, you can find the forms inside the FD Office, to the side of the building. ((Look Out-Of-Game Forums)) ",false,bg) 
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

-- members
function www_lses_gov_members()
	---------------------
	-- Page Properties --
	---------------------
	local page_length = 390 
	guiSetText(internet_address_label, "LSES Website - Members") -- This text is displayed at the top of the browser window when the page is opened. It is the same as the <title> tag used in the meta of a real webpage.
	guiSetText(address_bar,"www.lses.gov/memebers") -- The url of the page. This should be the same as the function name but with the original "."s and "/". Example www.google.com.	
	
	---------------------------------------------- Start of webpage design ----------------------------------------------
	
	----------------------------
	-- Page Background Colour --
	----------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/31.png",false,internet_pane)
		
	------------
	-- Header --
	------------
	local link_1_bg = guiCreateStaticImage(0,4,76,24,"websites/colours/3.png",false,bg)
	local link_1_hl = guiCreateStaticImage(12,6,50,2,"websites/colours/1.png",false,bg)
	local link_1 = guiCreateLabel(2,10,72,16,"Our Members",false,bg)
	guiLabelSetColor(link_1,255,255,255)
	guiLabelSetHorizontalAlign(link_1,"center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.LSES.gov/Members") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_2_bg = guiCreateStaticImage(78,4,76,24,"websites/colours/45.png",false,bg)
	local link_2_hl = guiCreateStaticImage(90,6,50,2,"websites/colours/36.png",false,bg)
	local link_2 = guiCreateLabel(80,10,72,16,"Home",false,bg)
	guiLabelSetColor(link_2,255,255,255)
	guiLabelSetHorizontalAlign(link_2,"center")
	addEventHandler("onClientGUIClick",link_2,function()
		local url = tostring("www.LSES.gov") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_3_bg = guiCreateStaticImage(156,4,76,24,"websites/colours/45.png",false,bg)
	local link_3_hl = guiCreateStaticImage(168,6,50,2,"websites/colours/36.png",false,bg)
	local link_3 = guiCreateLabel(158,10,72,16,"About",false,bg)
	guiLabelSetColor(link_3,255,255,255)
	guiLabelSetHorizontalAlign(link_3,"center")
	addEventHandler("onClientGUIClick",link_3,function()
		local url = tostring("www.LSES.gov/About") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_4_bg = guiCreateStaticImage(234,4,76,24,"websites/colours/45.png",false,bg)
	local link_4_hl = guiCreateStaticImage(246,6,50,2,"websites/colours/36.png",false,bg)
	local link_4 = guiCreateLabel(236,10,72,16,"Join",false,bg)
	guiLabelSetColor(link_4,255,255,255)
	guiLabelSetHorizontalAlign(link_4,"center")
	addEventHandler("onClientGUIClick",link_4,function()
		local url = tostring("www.LSES.gov/Join") -- Put hyperlink url in quotation marks
		get_page(url)
	end,false)
	
	local link_end_bg = guiCreateStaticImage(312,4,148,24,"websites/colours/3.png",false,bg)
	local url_label_shadow = guiCreateLabel(325,11,130,16,"www.URL.sa",false,bg)
	guiLabelSetColor(url_label_shadow,30,30,30)
	guiLabelSetHorizontalAlign(url_label_shadow,"center")
	local url_label = guiCreateLabel(324,10,130,16,"www.URL.sa",false,bg)
	guiLabelSetColor(url_label,255,255,255)
	guiLabelSetHorizontalAlign(url_label,"center")
	
	local header_bg = guiCreateStaticImage(0,28,460,34,"websites/colours/3.png",false,bg)
	local header_label = guiCreateLabel(15,38,122,16,"WEBSITE TEMPLATE",false,bg)
	guiSetFont(header_label,"default-bold-smal")
	guiLabelSetColor(header_label,255,255,255)
	
	local header_shadow = guiCreateStaticImage(0,61,460,1,"websites/colours/13.png",false,bg)
	
	-------------
	-- Content --
	-------------
	local side_text = guiCreateLabel(10,110,105,120,"LSES\
												\
												Enjoy your stay\
												Since 29/01/2010\
												\
												Occupations:\
												EMT and FD	",false,bg)	
	-- Header 1
	local header_1_bg_shadow = guiCreateStaticImage(107,67,353,25,"websites/colours/13.png",false,bg)
	local header_1_bg = guiCreateStaticImage(108,66,353,25,"websites/colours/3.png",false,bg)
	local header_1_ul = guiCreateStaticImage(108,66,353,1,"websites/colours/1.png",false,bg)
	local header_1 = guiCreateLabel(131,70,200,16,"header 1",false,bg)
	local para1 = guiCreateLabel(128,94,329,70,"Chief. We are proud to have TOM STEWART as our chief. He is one of the kindest people you will meet. ",false,bg) 
	guiLabelSetHorizontalAlign(para1,"left",true)
	
	-- Header 2
	local header_2_bg_shadow = guiCreateStaticImage(107,167,353,25,"websites/colours/13.png",false,bg)
	local header_2_bg = guiCreateStaticImage(108,166,353,25,"websites/colours/3.png",false,bg)
	local header_2_ul = guiCreateStaticImage(108,166,353,1,"websites/colours/1.png",false,bg)
	local header_2 = guiCreateLabel(131,170,200,16,"header 2",false,bg)
	local para2 = guiCreateLabel(128,94,329,70,"Deputy Chief. JOHN BRENKLY, Medically trained and planning events for the whole community! ",false,bg) 
	guiLabelSetHorizontalAlign(para2,"left",true)
	
	-- Header 3
	local header_3_bg_shadow = guiCreateStaticImage(107,267,353,25,"websites/colours/13.png",false,bg)
	local header_3_bg = guiCreateStaticImage(108,266,353,25,"websites/colours/3.png",false,bg)
	local header_3_ul = guiCreateStaticImage(108,266,353,1,"websites/colours/1.png",false,bg)
	local header_3 = guiCreateLabel(131,270,200,16,"header 2",false,bg)
	local para3 = guiCreateLabel(128,94,329,70,"The Departments. Obviously, without these guys, we'd be noone. ",false,bg) 
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





