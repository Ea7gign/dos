-- Website owner's forum name: knash94
-- Website owner's Character's name: Kyle Nash

-------------------------------------------------------
---------- SAN ANDREAS WEB DESIGNS HOMEPAGE -----------
-------------------------------------------------------

function www_sadesigns_sa() 
	-- Webpage Properties
	---------------------
	local page_length = 765
	guiSetText(address_bar,"www.sadesigns.sa") 
	
	-- Page Background Colour
	-------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/102.png",false,internet_pane)
	
	------------
	-- Header --
	------------
	local banner_ = guiCreateStaticImage(5,5,450,60,"websites/colours/17.png",false,bg) -- Creates a red square with dimensions 450 X 60px.
	local header_ = guiCreateLabel(10,5,460,40,"San Andreas Web Designs",false,bg) -- Creates a text box.
	guiSetFont(header_, "sa-header")
	local underline_ = guiCreateStaticImage(5,47,450,22,"websites/colours/52.png",false,bg) -- Creates a white square (in this case a line) 450px long and 1px high.
	
	------------
	-- NAV Bar -
	------------
	
	--Nav_bar = guiCreateStaticImage(7,50,87,14,"websites/colours/86.png",false,bg)
	local linkhp = guiCreateLabel(10,50,80,20,"Home page",false,bg)
	guiLabelSetColor(link,255,255,255)
	local linkpl = guiCreateLabel(90,50,80,20,"Prices",false,bg)
	guiLabelSetColor(link,255,255,255)
	local linkpf = guiCreateLabel(140,50,80,20,"Portfolio",false,bg)
	local linksl = guiCreateLabel(200,50,80,20,"Sponsers",false,bg)
	--[[
	Content blocks
	--]]
	local main_box = guiCreateStaticImage(5,75,270,25,"websites/colours/117.png",false,bg)
	local main_box_text_area = guiCreateStaticImage(5,100,270,270,"websites/colours/112.png",false,bg)
	local main_box_text = guiCreateLabel(10,80,100,40,"Main",false,bg)
	guiSetFont(main_box_text, "default-bold-small")
	--
	local add_box = guiCreateStaticImage(290,75,160,25,"websites/colours/117.png",false,bg)
	local add_box_text_area = guiCreateStaticImage(290,100,160,110,"websites/colours/112.png",false,bg)
	local add_box_text = guiCreateLabel(295,80,100,40,"Links",false,bg)
	guiSetFont(add_box_text, "default-bold-small")
	--
	local news_box = guiCreateStaticImage(290,230,160,25,"websites/colours/117.png",false,bg)
	local news_box_text_area = guiCreateStaticImage(290,255,160,115,"websites/colours/112.png",false,bg)
	local news_box_text = guiCreateLabel(295,235,100,40,"Contact details",false,bg)
	guiSetFont(news_box_text, "default-bold-small")	
	
	--[[
	Content block text [MAIN_BOX]
	--]]
	local mbtext = guiCreateLabel(10,105,300,250,	"Hello,\
													Welcome to the San Andreas Web Designs site\
													\
													Number: #18415\
													Email: Kyle_Nash@whiz.sa\
													Address: 1 St. George Street",false,bg)
	--[[
	Content block text [ADD_BOX]
	--]]
	local tbtext = guiCreateLabel(295,105,300,250,"> No links",false,bg)
	--local tbtext2 = guiCreateLabel(295,125,300,250,"> Test link 2",false,bg)	
	
	--[[
	Content block text [NEWS_BOX]
	--]]
	local ctext = guiCreateLabel(295,260,250,250,	"Number: #18415\
													Email: Kyle_Nash@whiz.sa\
													Address: 1 St. George Street",false,bg)	
	
	
	addEventHandler("onClientGUIClick",linkhp,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	addEventHandler("onClientGUIClick",linkpf,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa/portfolio") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	addEventHandler("onClientGUIClick",linkpl,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa/prices") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	addEventHandler("onClientGUIClick",linksl,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa/sponsers") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	----------------------------------------------- End of webpage design -- Do not edit below this line. -----------------------------------------------
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
	
end

function www_sadesigns_sa_prices()
	-- Webpage Properties
	---------------------
	local page_length = 765
	guiSetText(address_bar,"www.sadesigns.sa/prices") 
	
	-- Page Background Colour
	-------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/102.png",false,internet_pane)
	
	------------
	-- Header --
	------------
	local banner_ = guiCreateStaticImage(5,5,450,60,"websites/colours/17.png",false,bg) -- Creates a red square with dimensions 450 X 60px.
	local header_ = guiCreateLabel(10,5,460,40,"San Andreas Web Designs",false,bg) -- Creates a text box.
	guiSetFont(header_, "sa-header")
	local underline_ = guiCreateStaticImage(5,47,450,22,"websites/colours/52.png",false,bg) -- Creates a white square (in this case a line) 450px long and 1px high.
	
	------------
	-- NAV Bar -
	------------
	
	--Nav_bar = guiCreateStaticImage(7,50,87,14,"websites/colours/86.png",false,bg)
	local linkhp = guiCreateLabel(10,50,80,20,"Home page",false,bg)
	guiLabelSetColor(link,255,255,255)
	local linkpl = guiCreateLabel(90,50,80,20,"Prices",false,bg)
	guiLabelSetColor(link,255,255,255)
	local linkpf = guiCreateLabel(140,50,80,20,"Portfolio",false,bg)
	local linksl = guiCreateLabel(200,50,80,20,"Sponsers",false,bg)
	--[[
	Content blocks
	--]]
	local main_box = guiCreateStaticImage(5,75,270,25,"websites/colours/117.png",false,bg)
	local main_box_text_area = guiCreateStaticImage(5,100,270,270,"websites/colours/112.png",false,bg)
	local main_box_text = guiCreateLabel(10,80,100,40,"Prices",false,bg)
	guiSetFont(main_box_text, "default-bold-small")
	--
	local add_box = guiCreateStaticImage(290,75,160,25,"websites/colours/117.png",false,bg)
	local add_box_text_area = guiCreateStaticImage(290,100,160,110,"websites/colours/112.png",false,bg)
	local add_box_text = guiCreateLabel(295,80,100,40,"Links",false,bg)
	guiSetFont(add_box_text, "default-bold-small")
	--
	local news_box = guiCreateStaticImage(290,230,160,25,"websites/colours/117.png",false,bg)
	local news_box_text_area = guiCreateStaticImage(290,255,160,115,"websites/colours/112.png",false,bg)
	local news_box_text = guiCreateLabel(295,235,100,40,"Contact details",false,bg)
	guiSetFont(news_box_text, "default-bold-small")	
	
	--[[
	Content block text [MAIN_BOX]
	--]]
	local mbtext = guiCreateLabel(10,105,300,250,   "Prices:\
													\
													Premade template: 0$\
													Custom template: 1500$\
													Per page: 1000$\
													\
													Our prices are competitive and always will be.\
													The market researchers we have will finding you\
													the best deal around, giving you a great price\
													with a great design. We also do regular sales\
													giving you even a cheaper price for you're site.",false,bg)
	--[[
	Content block text [ADD_BOX]
	--]]
	local tbtext = guiCreateLabel(295,105,300,250,"> No links",false,bg)
	--local tbtext2 = guiCreateLabel(295,125,300,250,"> Test link 2",false,bg)	
	
	--[[
	Content block text [NEWS_BOX]
	--]]
	local ctext = guiCreateLabel(295,260,250,250,	"Number: #18415\
													Email: Kyle_Nash@whiz.sa\
													Address: 1 St. George Street",false,bg)	
	
	
	addEventHandler("onClientGUIClick",linkhp,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	addEventHandler("onClientGUIClick",linkpf,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa/portfolio") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	addEventHandler("onClientGUIClick",linkpl,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa/prices") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	addEventHandler("onClientGUIClick",linksl,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa/sponsers") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	----------------------------------------------- End of webpage design -- Do not edit below this line. -----------------------------------------------
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
	
end

function www_sadesigns_sa_portfolio()
	-- Webpage Properties
	---------------------
	local page_length = 765
	guiSetText(address_bar,"www.sadesigns.sa/portfollio") 
	
	-- Page Background Colour
	-------------------------
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/102.png",false,internet_pane)
	
	------------
	-- Header --
	------------
	local banner_ = guiCreateStaticImage(5,5,450,60,"websites/colours/17.png",false,bg) -- Creates a red square with dimensions 450 X 60px.
	local header_ = guiCreateLabel(10,5,460,40,"San Andreas Web Designs",false,bg) -- Creates a text box.
	guiSetFont(header_, "sa-header")
	local underline_ = guiCreateStaticImage(5,47,450,22,"websites/colours/52.png",false,bg) -- Creates a white square (in this case a line) 450px long and 1px high.
	
	------------
	-- NAV Bar -
	------------
	
	--Nav_bar = guiCreateStaticImage(7,50,87,14,"websites/colours/86.png",false,bg)
	local linkhp = guiCreateLabel(10,50,80,20,"Home page",false,bg)
	guiLabelSetColor(link,255,255,255)
	local linkpl = guiCreateLabel(90,50,80,20,"Prices",false,bg)
	guiLabelSetColor(link,255,255,255)
	local linkpf = guiCreateLabel(140,50,80,20,"Portfolio",false,bg)
	local linksl = guiCreateLabel(200,50,80,20,"Sponsers",false,bg)
	--[[
	Content blocks
	--]]
	local main_box = guiCreateStaticImage(5,75,270,25,"websites/colours/117.png",false,bg)
	local main_box_text_area = guiCreateStaticImage(5,100,270,270,"websites/colours/112.png",false,bg)
	local main_box_text = guiCreateLabel(10,80,100,40,"Portfolio",false,bg)
	guiSetFont(main_box_text, "default-bold-small")
	--
	local add_box = guiCreateStaticImage(290,75,160,25,"websites/colours/117.png",false,bg)
	local add_box_text_area = guiCreateStaticImage(290,100,160,110,"websites/colours/112.png",false,bg)
	local add_box_text = guiCreateLabel(295,80,100,40,"Links",false,bg)
	guiSetFont(add_box_text, "default-bold-small")
	--
	local news_box = guiCreateStaticImage(290,230,160,25,"websites/colours/117.png",false,bg)
	local news_box_text_area = guiCreateStaticImage(290,255,160,115,"websites/colours/112.png",false,bg)
	local news_box_text = guiCreateLabel(295,235,100,40,"Contact details",false,bg)
	guiSetFont(news_box_text, "default-bold-small")	
	
	--[[
	Content block text [MAIN_BOX]
	--]]
	local mbtext = guiCreateLabel(10,105,300,250,	"A portfolio is where we show you our work,\
													right now we have no previous work that is\
													complete.",false,bg)
	--[[
	Content block text [ADD_BOX]
	--]]
	local tbtext = guiCreateLabel(295,105,300,250,"> No links",false,bg)
	--local tbtext2 = guiCreateLabel(295,125,300,250,"> Test link 2",false,bg)	
	
	--[[
	Content block text [NEWS_BOX]
	--]]
	local ctext = guiCreateLabel(295,260,250,250,	"Number: #18415\
													Email: Kyle_Nash@whiz.sa\
													Address: 1 St. George Street",false,bg)	
	
	
	addEventHandler("onClientGUIClick",linkhp,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	addEventHandler("onClientGUIClick",linkpf,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa/portfolio") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	addEventHandler("onClientGUIClick",linkpl,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa/prices") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	addEventHandler("onClientGUIClick",linksl,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa/sponsers") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	----------------------------------------------- End of webpage design -- Do not edit below this line. -----------------------------------------------
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
	
end

function www_sadesigns_sa_sponsers()
	-- Webpage Properties
	---------------------
	local page_length = 765
	guiSetText(address_bar,"www.sadesigns.sa/sponsers") 
	
	-- Page Background Colour
	-------------------------
	bg = guiCreateStaticImage(0,0,460,page_length,"websites/colours/102.png",false,internet_pane)
	
	------------
	-- Header --
	------------
	local banner_ = guiCreateStaticImage(5,5,450,60,"websites/colours/17.png",false,bg) -- Creates a red square with dimensions 450 X 60px.
	local header_ = guiCreateLabel(10,5,460,40,"San Andreas Web Designs",false,bg) -- Creates a text box.
	guiSetFont(header_, "sa-header")
	local underline_ = guiCreateStaticImage(5,47,450,22,"websites/colours/52.png",false,bg) -- Creates a white square (in this case a line) 450px long and 1px high.
	
	------------
	-- NAV Bar -
	------------
	
	--Nav_bar = guiCreateStaticImage(7,50,87,14,"websites/colours/86.png",false,bg)
	local linkhp = guiCreateLabel(10,50,80,20,"Home page",false,bg)
	guiLabelSetColor(link,255,255,255)
	local linkpl = guiCreateLabel(90,50,80,20,"Prices",false,bg)
	guiLabelSetColor(link,255,255,255)
	local linkpf = guiCreateLabel(140,50,80,20,"Portfolio",false,bg)
	local linksl = guiCreateLabel(200,50,80,20,"Sponsers",false,bg)
	--[[
	Content blocks
	--]]
	local main_box = guiCreateStaticImage(5,75,270,25,"websites/colours/117.png",false,bg)
	local main_box_text_area = guiCreateStaticImage(5,100,270,270,"websites/colours/112.png",false,bg)
	local main_box_text = guiCreateLabel(10,80,100,40,"Sponsers",false,bg)
	guiSetFont(main_box_text, "default-bold-small")
	--
	local add_box = guiCreateStaticImage(290,75,160,25,"websites/colours/117.png",false,bg)
	local add_box_text_area = guiCreateStaticImage(290,100,160,110,"websites/colours/112.png",false,bg)
	local add_box_text = guiCreateLabel(295,80,100,40,"Links",false,bg)
	guiSetFont(add_box_text, "default-bold-small")
	--
	local news_box = guiCreateStaticImage(290,230,160,25,"websites/colours/117.png",false,bg)
	local news_box_text_area = guiCreateStaticImage(290,255,160,115,"websites/colours/112.png",false,bg)
	local news_box_text = guiCreateLabel(295,235,100,40,"Contact details",false,bg)
	guiSetFont(news_box_text, "default-bold-small")	
	
	--[[
	Content block text [MAIN_BOX]
	--]]
	local mbtext = guiCreateLabel(10,105,300,250,	"COMMING SOON!",false,bg)
	--[[
	Content block text [ADD_BOX]
	--]]
	local tbtext = guiCreateLabel(295,105,300,250,"> No links",false,bg)
	--local tbtext2 = guiCreateLabel(295,125,300,250,"> Test link 2",false,bg)	
	
	--[[
	Content block text [NEWS_BOX]
	--]]
	local ctext = guiCreateLabel(295,260,250,250,	"Number: #18415\
													Email: Kyle_Nash@whiz.sa\
													Address: 1 St. George Street",false,bg)	
	
	
	addEventHandler("onClientGUIClick",linkhp,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	addEventHandler("onClientGUIClick",linkpf,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa/portfolio") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	addEventHandler("onClientGUIClick",linkpl,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa/prices") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	addEventHandler("onClientGUIClick",linksl,function() -- The following code tells the script what to do when someone clicks on the link we just made. You need to replace "link" with the name of the element that you want to act as a link.
		local url = tostring("www.sadesigns.sa/sponsers") -- Write the url of the page you are linking to in the quotation marks.
		get_page(url) 
	end,false)
	
	----------------------------------------------- End of webpage design -- Do not edit below this line. -----------------------------------------------
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
	
end

