-------------------------
-- San Andreas Network --
-------------------------

-- Website owner's forum name:
-- Website owner's Character's name:

-------------------
-- SAN Home Page --
-------------------
function www_sanetwork_sa()
	
	-- Webpage Properties
	---------------------
	local page_length = 600
	guiSetText(internet_address_label, "SANetwork.sa - Waterwolf")
	guiSetText(address_bar,"www.sanetwork.sa")
	
	-- Page Background Colour
	-------------------------
	bg = guiCreateStaticImage(0,0,460,page_length,"websites/colours/14.png",false,internet_pane)
	
	------------
	-- Header --
	------------
	local navigation_bar = guiCreateStaticImage(0,0,460,30,"websites/colours/7.png",false,bg)
	local white_stripe = guiCreateStaticImage(0,28,460,3,"websites/colours/1.png",false,bg)
	-- Page Title
	local site_title = guiCreateLabel(5,6,88,17,"SANetwork.sa",false,bg)
	guiSetFont(site_title,"default-bold-small")
	
	-- Nav Links
		-- News
		local news_link_bg = guiCreateStaticImage(140,6,62,22,"websites/colours/1.png",false,bg)
		local news_link = guiCreateLabel(140,8,62,22,"News",false,bg)
		guiLabelSetColor(news_link,76,117,183)
		guiSetFont(news_link,"default-bold-small")
		guiLabelSetHorizontalAlign(news_link,"center")
		addEventHandler("onClientGUIClick",news_link,function()
			local url = tostring("www.sanetwork.sa") -- Put hyperlink url in quotation marks
			get_page(url)
		end,false)
	
		-- Jobs
		local jobs_link_bg = guiCreateStaticImage(214,6,62,22,"websites/colours/7.png",false,bg)
		local jobs_link = guiCreateLabel(214,8,62,22,"Jobs",false,bg)
		guiSetFont(jobs_link,"default-bold-small")
		guiLabelSetHorizontalAlign(jobs_link,"center")
		addEventHandler("onClientGUIClick",jobs_link,function()
			local url = tostring("www.sanetwork.sa/jobs") -- Put hyperlink url in quotation marks
			get_page(url)
		end,false)
		
		-- Places
		local places_link_bg = guiCreateStaticImage(288,6,62,22,"websites/colours/7.png",false,bg)
		local places_link = guiCreateLabel(288,8,62,22,"Places",false,bg)
		guiSetFont(places_link,"default-bold-small")
		guiLabelSetHorizontalAlign(places_link,"center")
		addEventHandler("onClientGUIClick",places_link,function()
			local url = tostring("www.sanetwork.sa/places")
			get_page(url)
		end,false)
		
		-- Corporate
		local corporate_link_bg = guiCreateStaticImage(370,6,62,22,"websites/colours/7.png",false,bg)
		local corporate_link = guiCreateLabel(370,8,62,22,"Corporate",false,bg)
		guiSetFont(corporate_link,"default-bold-small")
		guiLabelSetHorizontalAlign(corporate_link,"center")
		addEventHandler("onClientGUIClick",corporate_link,function()
			local url = tostring("www.sanetwork.sa/corporate")
			get_page(url)
		end,false)
	
	-------------
	-- Content --
	-------------
	
	local left_content_bg = guiCreateStaticImage(5,65,290,560,"websites/colours/1.png",false,bg)
	local right_content_bg = guiCreateStaticImage(306,65,154,210,"websites/colours/1.png",false,bg)

	-- Left Column
	------------- Latest News -------------
	local top_story_image = guiCreateStaticImage(10,43,280,189,"websites/images/city_hall.png",false,bg)
	local top_story_mask_t = guiCreateStaticImage(5,65,290,5,"websites/colours/1.png",false,bg)
	local top_story_mask_b = guiCreateStaticImage(5,207,290,26,"websites/colours/1.png",false,bg)
	
	local latest_news_header_bg = guiCreateStaticImage(0,43,295,22,"websites/colours/7.png",false,bg)
	local latest_news_title = guiCreateLabel(5,45,105,20,"Latest News",false,bg)
	guiSetFont(latest_news_title,"default-bold-small")
	
	-- headline
	local top_story_headline =  guiCreateLabel(10,207,280,16,"Haggis stock depleting.",false,bg)
	guiLabelSetColor(top_story_headline,76,117,183)
	addEventHandler("onClientGUIClick",top_story_headline,function()
			local url = tostring("www.sanetwork.sa/haggis_stock_depleting")
			get_page(url)
		end,false)
	-- date
	local top_story_date =  guiCreateLabel(10,223,280,16,"Monday, January 25th, 2010.",false,bg)
	guiSetFont(top_story_date,"default-bold-small")
	guiLabelSetColor(top_story_date,38,38,38)
	-- Summary
	local top_story_summary =  guiCreateLabel(10,238,280,48,"Scottish residence in Los Santos are in a state of panic due to haggis shortages.",false,bg)
	guiLabelSetColor(top_story_summary,38,38,38)
	guiLabelSetHorizontalAlign(top_story_summary,"left",true)
	
	------------- Other News -------------
	local other_news_header_bg = guiCreateStaticImage(0,290,295,22,"websites/colours/7.png",false,bg)
	local other_news_title = guiCreateLabel(5,292,105,20,"Other News",false,bg)
	guiSetFont(other_news_title,"default-bold-small")
	
	-- Article 2
		-- bullet point
		local  story_2_bp = guiCreateStaticImage(9,334,6,6,"websites/images/dots/light_blue_dot.png",false,bg)
		-- headline
		local story_2_hl = guiCreateLabel(20,317,270,16,"Story 2",false,bg)
		guiLabelSetColor(story_2_hl,38,38,38)
		addEventHandler("onClientGUIClick",story_2_hl,function()
			local url = tostring("www.sanetwork.sa/story_2") -- Put hyperlink url in quotation marks
			get_page(url)
		end,false)
		--date
		local story_2_date = guiCreateLabel(20,333,270,16,"Monday, January 25th, 2010",false,bg)
		guiLabelSetColor(story_2_date,76,117,183)
		guiSetFont(story_2_date,"default-bold-small")
		-- first line
		local story_2_summary = guiCreateLabel(18,349,270,16,"The first line of story 2...",false,bg)
		guiLabelSetColor(story_2_summary,38,38,38)
		guiLabelSetHorizontalAlign(story_2_summary,"left",true)
	
	-- Article 3
		-- bullet point
		local  story_3_bp = guiCreateStaticImage(9,398,6,6,"websites/images/dots/light_blue_dot.png",false,bg)
		-- headline
		local story_3_hl = guiCreateLabel(20,381,270,16,"Story 3",false,bg)
		guiLabelSetColor(story_3_hl,38,38,38)
		addEventHandler("onClientGUIClick",story_3_hl,function()
			local url = tostring("www.sanetwork.sa/story_3") -- Put hyperlink url in quotation marks
			get_page(url)
		end,false)
		--date
		local story_3_date = guiCreateLabel(20,397,270,16,"Sunday, January 24th, 2010",false,bg)
		guiLabelSetColor(story_3_date,76,117,183)
		guiSetFont(story_3_date,"default-bold-small")
		-- first line
		local story_3_summary = guiCreateLabel(20,413,270,16,"The first line of story 3...",false,bg)
		guiLabelSetColor(story_3_summary,38,38,38)
		guiLabelSetHorizontalAlign(story_3_summary,"left",true)
		
	-- Article 4
		-- bullet point
		local  story_4_bp = guiCreateStaticImage(9,462,6,6,"websites/images/dots/light_blue_dot.png",false,bg)
		-- headline
		local story_4_hl = guiCreateLabel(20,445,270,16,"Story 4",false,bg)
		guiLabelSetColor(story_4_hl,38,38,38)
		addEventHandler("onClientGUIClick",story_4_hl,function()
			local url = tostring("www.sanetwork.sa/story_4") -- Put hyperlink url in quotation marks
			get_page(url)
		end,false)
		--date
		local story_4_date = guiCreateLabel(20,461,270,16,"Sunday, January 24th, 2010",false,bg)
		guiLabelSetColor(story_4_date,76,117,183)
		guiSetFont(story_4_date,"default-bold-small")
		-- first line
		local story_4_summary = guiCreateLabel(20,477,270,16,"The first line of story 4...",false,bg)
		guiLabelSetColor(story_4_summary,38,38,38)
		guiLabelSetHorizontalAlign(story_4_summary,"left",true)
		
	-- Article 5
		-- bullet point
		local  story_5_bp = guiCreateStaticImage(9,526,6,6,"websites/images/dots/light_blue_dot.png",false,bg)
		-- headline
		local story_5_hl = guiCreateLabel(20,509,270,16,"Story 5",false,bg)
		guiLabelSetColor(story_5_hl,38,38,38)
		addEventHandler("onClientGUIClick",story_5_hl,function()
			local url = tostring("www.sanetwork.sa/story_5") -- Put hyperlink url in quotation marks
			get_page(url)
		end,false)
		--date
		local story_5_date = guiCreateLabel(20,525,270,16,"Sunday, January 24th, 2010",false,bg)
		guiLabelSetColor(story_5_date,76,117,183)
		guiSetFont(story_5_date,"default-bold-small")
		-- first line
		local story_5_summary = guiCreateLabel(20,541,270,16,"The first line of story 5...",false,bg)
		guiLabelSetColor(story_5_summary,38,38,38)
		guiLabelSetHorizontalAlign(story_5_summary,"left",true)
	
	-- Right Column
	--------------------------- Top Links ---------------------------
	local top_links_header_bg = guiCreateStaticImage(298,43,162,22,"websites/colours/7.png",false,bg)
	local top_links_title = guiCreateLabel(303,45,105,20,"Top Links",false,bg)
	guiSetFont(top_links_title,"default-bold-small")
		
		-- LS Government
		local top_link_1_bp = guiCreateStaticImage(311,75,6,6,"websites/images/dots/light_blue_dot.png",false,bg)
		local top_link_1 = guiCreateLabel(322,70,142,16,"Los Santos Government",false,bg)
		guiLabelSetColor(top_link_1,38,38,38)
		addEventHandler("onClientGUIClick",top_link_1,function()
				local url = tostring("www.lossantos.gov")
				get_page(url)
			end,false)
		
		-- LSPD
		local top_link_2_bp = guiCreateStaticImage(311,91,6,6,"websites/images/dots/light_blue_dot.png",false,bg)
		local top_link_2 = guiCreateLabel(322,86,142,16,"LS Police Department",false,bg)
		guiLabelSetColor(top_link_2,38,38,38)
		addEventHandler("onClientGUIClick",top_link_2,function()
				local url = tostring("www.lspd.gov")
				get_page(url)
			end,false)

		-- LSES
		local top_link_3_bp = guiCreateStaticImage(311,107,6,6,"websites/images/dots/light_blue_dot.png",false,bg)
		local top_link_3 = guiCreateLabel(322,102,142,16,"LS Emergency Service",false,bg)
		guiLabelSetColor(top_link_3,38,38,38)
		addEventHandler("onClientGUIClick",top_link_3,function()
				local url = tostring("www.lses.gov")
				get_page(url)
			end,false)
	
		-- C&C Bank of San Andreas
		local top_link_4_bp = guiCreateStaticImage(311,123,6,6,"websites/images/dots/light_blue_dot.png",false,bg)
		local top_link_4 = guiCreateLabel(322,118,142,16,"Bank of San Andreas",false,bg)
		guiLabelSetColor(top_link_4,38,38,38)
		addEventHandler("onClientGUIClick",top_link_4,function()
				local url = tostring("www.bankofsa.sa")
				get_page(url)
			end,false)
			
			
	----------------------------------------------------------------------
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(bg,false,true)
	else
		guiSetSize(bg,460,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
	
end

-- SAN story: "Haggis stock depleting"
function www_sanetwork_sa_Haggis_stocks_depleting()

end
