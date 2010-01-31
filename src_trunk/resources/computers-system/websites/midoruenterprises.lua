-- Website owner's forum name: Kaze
-- Website owner's Character's name: Kaze_Midoru


function www_midoruenterprises_sa()
	---------------------
	-- Page Properties --
	---------------------
	local page_length = 396
	guiSetText(internet_address_label, "Midoru Enterprises - Home")
	guiSetText(address_bar,"www.midoruenterprises.sa")
	
	----------------------------
	-- Page Background Colour --
	----------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/1.png",false,internet_pane) -- DO NOT REMOVE THE BACK GROUND.
		
	------------
	-- Header --
	------------
	local header = guiCreateStaticImage(0,0,660,20,"websites/colours/0.png",false,bg)
	local bg_2 = guiCreateStaticImage(125,20,410,745,"websites/colours/1.png",false,bg)
	
	local title_shadow = guiCreateLabel(141,24,350,45,"Midoru Enterprises",false,bg)
	guiLabelSetHorizontalAlign(title_shadow,"center")
	guiSetFont(title_shadow,"sa-header")
	guiLabelSetColor(title_shadow,28,28,28)
	
	local title = guiCreateLabel(140,23,350,45,"Midoru Enterprises",false,bg)
	guiLabelSetColor(title, 16, 86, 16)
	guiLabelSetHorizontalAlign(title,"center")
	guiSetFont(title,"sa-header")
	
	
	--------------------
	-- Navigation bar --
	--------------------
	local nav_bar = guiCreateStaticImage(0,90,660,18,"websites/colours/44.png",false,bg)
	
	-- Link 1
	local link_1 = guiCreateLabel(169,90,72, 16,"- Home -",false,bg)
	guiLabelSetHorizontalAlign(link_1, "center")
		addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.midoruenterprises.sa")
		get_page(url)
	end,false)
	
	-- Link 2
	local link_2 = guiCreateLabel(248,90,72, 16,"Contact Us",false,bg)
	guiLabelSetHorizontalAlign(link_2, "center")
			addEventHandler("onClientGUIClick",link_2,function()
		local url = tostring("www.midoruenterprises.sa/contact")
		get_page(url)
	end,false)
	
	-- Link 3
	local link_3 = guiCreateLabel(328,90,72, 16,"Properties",false,bg)
	guiLabelSetHorizontalAlign(link_3, "center")
		addEventHandler("onClientGUIClick",link_3,function()
		local url = tostring("www.midoruenterprises.sa/props")
		get_page(url)
	end,false)
	
	-- Link 4
	local link_4 = guiCreateLabel(408,90,86, 16,"Employment",false,bg)
	guiLabelSetHorizontalAlign(link_4, "center")
		addEventHandler("onClientGUIClick",link_4,function()
		local url = tostring("www.midoruenterprises.sa/employ")
		get_page(url)
	end,false)
	
	
	local designer_link = guiCreateStaticImage(519,286,146,110, "websites/images/izanagi-green.png", false, bg)


	addEventHandler("onClientGUIClick",designer_link,function()
		local url = tostring("www.izanagi.sa")
		get_page(url)
	end,false)
	-------------
	-- Content --
	-------------
	local title_1 = guiCreateLabel(170,128,86,16,"Welcome",false,bg)
	guiLabelSetColor(title_1,16,64,16)
	local text_1 = guiCreateLabel(179,144,301,128,"Welcome to the official website of Midoru Enterprises, if you are looking for a well paid job, or just want to know where are our fun facilities are located, you are at the right place , please feel free to browse among our website.",false,bg)
	guiLabelSetColor(text_1,28,28,28)
	guiLabelSetHorizontalAlign(text_1,"left",true)
	
	
	----------------------------------------------- End of webpage -- Do not edit below this line. -----------------------------------------------
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
end


function www_midoruenterprises_sa_contact()
	---------------------
	-- Page Properties --
	---------------------
	local page_length = 396
	guiSetText(internet_address_label, "Midoru Enterprises - Contact Us")
	guiSetText(address_bar,"www.midoruenterprises.sa/contact")
	
	----------------------------
	-- Page Background Colour --
	----------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/1.png",false,internet_pane) -- DO NOT REMOVE THE BACK GROUND.
		
	------------
	-- Header --
	------------
	local header = guiCreateStaticImage(0,0,660,20,"websites/colours/0.png",false,bg)
	local bg_2 = guiCreateStaticImage(158,20,450,745,"websites/colours/1.png",false,bg)
	
	local title_shadow = guiCreateLabel(141,24,350,45,"Midoru Enterprises",false,bg)
	guiLabelSetHorizontalAlign(title_shadow,"center")
	guiSetFont(title_shadow,"sa-header")
	guiLabelSetColor(title_shadow,28,28,28)
	
	local title = guiCreateLabel(140,23,350,45,"Midoru Enterprises",false,bg)
	guiLabelSetColor(title, 16, 86, 16)
	guiLabelSetHorizontalAlign(title,"center")
	guiSetFont(title,"sa-header")
	
	
	--------------------
	-- Navigation bar --
	--------------------
	local nav_bar = guiCreateStaticImage(0,90,660,18,"websites/colours/44.png",false,bg)
	
	-- Link 1
	local link_1 = guiCreateLabel(169,90,72, 16,"Home",false,bg)
	guiLabelSetHorizontalAlign(link_1, "center")
	addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.midoruenterprises.sa")
		get_page(url)
	end,false)
	
	-- Link 2
	local link_2 = guiCreateLabel(248,90,72, 16,"- Contact Us -",false,bg)
	guiLabelSetHorizontalAlign(link_2, "center")
	addEventHandler("onClientGUIClick",link_2,function()
		local url = tostring("www.midoruenterprises.sa/contact")
		get_page(url)
	end,false)
	
	-- Link 3
	local link_3 = guiCreateLabel(328,90,72, 16,"Properties",false,bg)
	guiLabelSetHorizontalAlign(link_3, "center")
	addEventHandler("onClientGUIClick",link_3,function()
		local url = tostring("www.midoruenterprises.sa/props")
		get_page(url)
	end,false)
	
	-- Link 4
	local link_4 = guiCreateLabel(408,90,86, 16,"Employment",false,bg)
	guiLabelSetHorizontalAlign(link_4, "center")
		addEventHandler("onClientGUIClick",link_4,function()
		local url = tostring("www.midoruenterprises.sa/employ")
		get_page(url)
	end,false)
	
	local designer_link = guiCreateStaticImage(519,286,146,110, "websites/images/izanagi-green.png", false, bg)

	addEventHandler("onClientGUIClick",designer_link,function()
		local url = tostring("www.izanagi.sa")
		get_page(url)
	end,false)
	-------------
	-- Content --
	-------------
	local title_1 = guiCreateLabel(170,128,330,16,"Ways to contact us",false,bg)
	guiLabelSetColor(title_1,16,64,16)
	local text_1 = guiCreateLabel(179,144,301,64,   "E-Mail : MidoruEnterprises@whiz.sa\
							Phone number : 1-800-37834\
							Fax : 1-700-37834\
							Headquarters : W. Broadway.",false,bg)
	guiLabelSetColor(text_1,28,28,28)
	guiLabelSetHorizontalAlign(text_1,"left",true)
	
	--local title_2 = guiCreateLabel(70,221,330,16,"Title 2",false,bg)
	--guiLabelSetColor(title_2,153,0,102)
	--local text_2 = guiCreateLabel(79,248,301,64,"Some text goes here. Some text goes here. Some text goes here. Some text goes here. Some text goes here. Some text goes here. Some text goes here. Some text goes here. Some text goes here. Some",false,bg)
	--guiLabelSetColor(text_2,28,28,28)
	--guiLabelSetHorizontalAlign(text_2,"left",true)
	
	----------------------------------------------- End of webpage -- Do not edit below this line. -----------------------------------------------
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end


function www_midoruenterprises_sa_props()
	---------------------
	-- Page Properties --
	---------------------
	local page_length = 416
	guiSetText(internet_address_label, "Midoru Enterprises - Properties")
	guiSetText(address_bar,"www.midoruenterprises.sa/props")
	
	----------------------------
	-- Page Background Colour --
	----------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/1.png",false,internet_pane) -- DO NOT REMOVE THE BACK GROUND.
		
	------------
	-- Header --
	------------
	local header = guiCreateStaticImage(0,0,660,20,"websites/colours/0.png",false,bg)
	local bg_2 = guiCreateStaticImage(158,20,450,745,"websites/colours/1.png",false,bg)
	
	local title_shadow = guiCreateLabel(141,24,350,45,"Midoru Enterprises",false,bg)
	guiLabelSetHorizontalAlign(title_shadow,"center")
	guiSetFont(title_shadow,"sa-header")
	guiLabelSetColor(title_shadow,28,28,28)
	
	local title = guiCreateLabel(140,23,350,45,"Midoru Enterprises",false,bg)
	guiLabelSetColor(title, 16, 86, 16)
	guiLabelSetHorizontalAlign(title,"center")
	guiSetFont(title,"sa-header")
	
	
	--------------------
	-- Navigation bar --
	--------------------
	local nav_bar = guiCreateStaticImage(0,90,660,18,"websites/colours/44.png",false,bg)
	
	-- Link 1
	local link_1 = guiCreateLabel(169,90,72, 16,"Home",false,bg)
	guiLabelSetHorizontalAlign(link_1, "center")
		addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.midoruenterprises.sa")
		get_page(url)
	end,false)
	
	-- Link 2
	local link_2 = guiCreateLabel(248,90,72, 16,"Contact Us",false,bg)
	guiLabelSetHorizontalAlign(link_2, "center")
			addEventHandler("onClientGUIClick",link_2,function()
		local url = tostring("www.midoruenterprises.sa/contact")
		get_page(url)
	end,false)
	
	-- Link 3
	local link_3 = guiCreateLabel(328,90,72, 16,"- Properties -",false,bg)
	guiLabelSetHorizontalAlign(link_3, "center")
		addEventHandler("onClientGUIClick",link_3,function()
		local url = tostring("www.midoruenterprises.sa/props")
		get_page(url)
	end,false)
	
	-- Link 4
	local link_4 = guiCreateLabel(408,90,86, 16,"Employment",false,bg)
	guiLabelSetHorizontalAlign(link_4, "center")
		addEventHandler("onClientGUIClick",link_4,function()
		local url = tostring("www.midoruenterprises.sa/employ")
		get_page(url)
	end,false)
	
	local designer_link = guiCreateStaticImage(519,286,146,110, "websites/images/izanagi-green.png", false, bg)

	addEventHandler("onClientGUIClick",designer_link,function()
		local url = tostring("www.izanagi.sa")
		get_page(url)
	end,false)	
	-------------
	-- Content --
	-------------
	local title_1 = guiCreateLabel(170,128,330,16,"Properties",false,bg)
	guiLabelSetColor(title_1,16,64,16)
	local text_1 = guiCreateLabel(179,144,301,32,"Midoru Enterprises facilities throughout Los Santos",false,bg)
	guiLabelSetColor(text_1,28,28,28)
	guiLabelSetHorizontalAlign(text_1,"left",true)
	
	local title_2 = guiCreateLabel(170,176,330,16,"Club Akai",false,bg)
	guiLabelSetColor(title_2,16,64,16)
	local text_2 = guiCreateLabel(179,192,301,32,"Best club in Los Santos, it's a big square orange building located at W. Broadway, east of the LS Bank",false,bg)
	guiLabelSetColor(text_2,28,28,28)
	guiLabelSetHorizontalAlign(text_2,"left",true)
		
	local title_3 = guiCreateLabel(170,224,330,16,"Midoru no Diner",false,bg)
	guiLabelSetColor(title_3,16,64,16)
	local text_3 = guiCreateLabel(179,240,330,32,"Cheap but high quality food here at Midoru no Dinner, located west of the Vinewood Gas Station.",false,bg)
	guiLabelSetColor(text_3,28,28,28)
	guiLabelSetHorizontalAlign(text_3,"left",true)
			
	local title_4 = guiCreateLabel(170,272,330,16,"Midoru no Casino",false,bg)
	guiLabelSetColor(title_4,16,64,16)
	local text_4 = guiCreateLabel(179,288,330,256,"This by far is the greatest Casino in Los Santos after The Starlight Casino, it is located West of the LS bank, at the exterior we have a fabulous Cafe serving only the best coffee, tea, you could even have a luxury desert here, in the interior, we have a great bar, serving drinks from all around the world, from Sake to Vodka, we also have great starts by our weekly car prize, high quality security and employees, best place to gamble in.",false,bg)
	guiLabelSetColor(text_4,28,28,28)
	guiLabelSetHorizontalAlign(text_4,"left",true)
	
	----------------------------------------------- End of webpage -- Do not edit below this line. -----------------------------------------------
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
end


function www_midoruenterprises_sa_employ()
	---------------------
	-- Page Properties --
	---------------------
	local page_length = 396
	guiSetText(internet_address_label, "Midoru Enterprises - Employment")
	guiSetText(address_bar,"www.midoruenterprises.sa/employ")
	
	----------------------------
	-- Page Background Colour --
	----------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/1.png",false,internet_pane) -- DO NOT REMOVE THE BACK GROUND.
		
	------------
	-- Header --
	------------
	local header = guiCreateStaticImage(0,0,660,20,"websites/colours/0.png",false,bg)
	local bg_2 = guiCreateStaticImage(158,20,450,745,"websites/colours/1.png",false,bg)
	
	local title_shadow = guiCreateLabel(141,24,350,45,"Midoru Enterprises",false,bg)
	guiLabelSetHorizontalAlign(title_shadow,"center")
	guiSetFont(title_shadow,"sa-header")
	guiLabelSetColor(title_shadow,28,28,28)
	
	local title = guiCreateLabel(140,23,350,45,"Midoru Enterprises",false,bg)
	guiLabelSetColor(title, 16, 86, 16)
	guiLabelSetHorizontalAlign(title,"center")
	guiSetFont(title,"sa-header")
	
	
	--------------------
	-- Navigation bar --
	--------------------
	local nav_bar = guiCreateStaticImage(0,90,660,18,"websites/colours/44.png",false,bg)
	
	-- Link 1
	local link_1 = guiCreateLabel(169,90,72, 16,"Home",false,bg)
	guiLabelSetHorizontalAlign(link_1, "center")
		addEventHandler("onClientGUIClick",link_1,function()
		local url = tostring("www.midoruenterprises.sa")
		get_page(url)
	end,false)
	
	-- Link 2
	local link_2 = guiCreateLabel(248,90,72, 16,"Contact Us",false,bg)
	guiLabelSetHorizontalAlign(link_2, "center")
			addEventHandler("onClientGUIClick",link_2,function()
		local url = tostring("www.midoruenterprises.sa/contact")
		get_page(url)
	end,false)
	
	-- Link 3
	local link_3 = guiCreateLabel(328,90,72, 16,"Properties",false,bg)
	guiLabelSetHorizontalAlign(link_3, "center")
		addEventHandler("onClientGUIClick",link_3,function()
		local url = tostring("www.midoruenterprises.sa/props")
		get_page(url)
	end,false)
	
	-- Link 4
	local link_4 = guiCreateLabel(408,90,86, 16,"- Employment -",false,bg)
	guiLabelSetHorizontalAlign(link_4, "center")
		addEventHandler("onClientGUIClick",link_4,function()
		local url = tostring("www.midoruenterprises.sa/employ")
		get_page(url)
	end,false)
	
	local designer_link = guiCreateStaticImage(519,286,146,110, "websites/images/izanagi-green.png", false, bg)
	
addEventHandler("onClientGUIClick",designer_link,function()
		local url = tostring("www.izanagi.sa")
		get_page(url)
	end,false)	
	-------------
	-- Content --
	-------------
	local title_1 = guiCreateLabel(170,128,330,16,"Employment",false,bg)
	guiLabelSetColor(title_1,16,64,16)
	local text_1 = guiCreateLabel(179,144,301,64,"Currently we are hiring young experienced Guards, also are looking for professional Managers for our facilities, for more information, E-Mail the CEO at \
	 K.Midoru@saonline.sa .",false,bg)
	guiLabelSetColor(text_1,28,28,28)
	guiLabelSetHorizontalAlign(text_1,"left",true)
	
	--local title_2 = guiCreateLabel(70,221,330,16,"Title 2",false,bg)
	--guiLabelSetColor(title_2,153,0,102)
	--local text_2 = guiCreateLabel(79,248,301,64,"Some text goes here. Some text goes here. Some text goes here. Some text goes here. Some text goes here. Some text goes here. Some text goes here. Some text goes here. Some text goes here. Some",false,bg)
	--guiLabelSetColor(text_2,28,28,28)
	--guiLabelSetHorizontalAlign(text_2,"left",true)
	
	----------------------------------------------- End of webpage -- Do not edit below this line. -----------------------------------------------
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
end