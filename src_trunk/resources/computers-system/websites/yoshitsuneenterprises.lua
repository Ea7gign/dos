-- Website owner's forum name: Yoshitsune
-- Website owner's Character's name: Shin_Yoshitsune
-- Website designer's forum name: Izanagi
-- Website designer's Character's name: Ryuunosuke_Yasogami

local design = 
{
	title =
	{
		"Yoshitsune Enterprises - Home",
		"Yoshitsune Enterprises - About",
		"Yoshitsune Enterprises - Properties",
		"Yoshitsune Enterprises - Employment"
	},
	address =
	{
		"www.yoshitsuneenterprises.sa",
		"www.yoshitsuneenterprises.sa/about",
		"www.yoshitsuneenterprises.sa/properties",
		"www.yoshitsuneenterprises.sa/employment"
	},
	background = 2,
	body = 1,
	body_shadow = 93,
	banner = "yoshitsune-i",
	link = 	{ "Home", "About", "Properties", "Employment" },
	header = "Yoshitsune Enterprises",
	text_title = 
	{
		"Welcome",
		"About Us",
		"Properties",
		"Employment"
	},
	text = 
	{ 
		"Dear visitor, welcome to www.YoshitsuneEnterprises.sa. We hope you enjoy your stay.\
		\
		\
		\
		\
		This website has been created by Izanagi. You can find his works at www.izanagi.sa and contact him to request a website created by e-mailing him at izanagi@whiz.sa",
		"Yoshitsune Enterprises is a company founded by Shin Yoshitsune in 2010. It is a new company, that strives to be number one and provide their customers the best service that is possible.\
		\
		'Life is too short to waste it.' - Yoshitsune Shin",
		"", -- this is not used
		"You can find out if we're emplyoing or not by clicking on the Yoshitsune Enterprises logo on the top of this page, a little to the left from the header, and sending us an email. We will be sure to reply as soon as possible, providing you the data you require.\
		\
		You can also try calling Shin Yoshitsune, the head of Yoshitsune Enterprises on his phone, or sending an SMS.\
		Phone number: 1-800-45741\
		E-Mail: yoshitsune@saonline.sa"
	},
	businesses =
	{
		name =
		{
			"Yoshitsune Electronics"
		},
		description =
		{
			"Yoshitsune Electronics is located in Palomino Creek, on the street north from Palomino Creek Bank. If you are looking to get yourself a radio, a getthoblaster, or even a PDA, Y.E. is the place for you! We've got all kinds of helpful electronics for you. Check out selection of  sound systems!\
			Our stock at Y.E. includes getthoblasters, PDAs, Safes, Chemistry Sets and last but not least, 1/8 sized models of real vehicles, including Comet, Blista Compact, ZR-350, Turismo and even Infernus!"
		}
	}
}
local page_width = 660

function yoshitsune_showpage()
	
	-- Webpage Properties
	---------------------
	local page_length = 396
	local yoshitsune_page = getElementData(getLocalPlayer(), "yoshitsune.page")
	if yoshitsune_page == false then yoshitsune_page = 1 end
	setElementData(getLocalPlayer(), "yoshitsune.page", yoshitsune_page)
	
	if yoshitsune_page > 0 and yoshitsune_page < 5 then
		guiSetText(internet_address_label, 	tostring(design.title[yoshitsune_page]))
		guiSetText(address_bar, 			tostring(design.address[yoshitsune_page]))
	elseif yoshitsune_page > 4 then
		guiSetText(internet_address_label, 	tostring(design.title[3].." - "..design.businesses.name[yoshitsune_page-4]))
		guiSetText(address_bar, 			tostring(design.address[3]))
	end
	-- Default page setup
	-------------------------
	bg = guiCreateStaticImage(0, 0, page_width, page_length, "websites/colours/"..design.background..".png", false, internet_pane)
	local body_shadow = guiCreateStaticImage(45, 0, page_width-89, 720, "websites/colours/"..design.body_shadow..".png", false, bg)
	local body = guiCreateStaticImage(50, 0, page_width-100 ,720, "websites/colours/"..design.body..".png", false, bg)
	
	local banner = guiCreateStaticImage(60, 10, 50, 95,"websites/images/"..design.banner..".png", false, bg)
	
	local header_shadow = guiCreateLabel(122, 12, 510, 65, design.header, false, bg)
	guiLabelSetColor(header_shadow, 7, 53, 68 )
	guiSetFont(header_shadow, "sa-gothic")

	local header = guiCreateLabel(120, 10, 510, 65, design.header, false, bg)
	guiLabelSetColor(header, 15, 106, 137 )
	guiSetFont(header, "sa-gothic")
	
	local navbar = guiCreateStaticImage(50, 110, 560, 24, "websites/colours/"..design.background..".png", false, bg)
	
	local j = yoshitsune_page
	if j > 4 then j = 3 end
	local link_bar_selected = guiCreateStaticImage(50+(560/4*(j-1)), 107, 560/4, 30, "websites/colours/"..design.body_shadow..".png", false, bg)
	
	local navbar_link = {}
	for i = 1,4 do
		navbar_link[i] = guiCreateLabel (60+(540/4*(i-1)), 110, 560/4, 24, design.link[i], false, bg)
		guiLabelSetHorizontalAlign(navbar_link[i], "center")
		
		addEventHandler("onClientGUIClick",navbar_link[i],function()
		local url = tostring(design.address[i])
		get_page(url) 
		end,false)
	end

	local i = yoshitsune_page
	if i == 3 or i > 4 then
		local split_bar = guiCreateStaticImage(180, 134, 30, 586, "websites/colours/"..design.background..".png", false, bg)
		local bizlist = {}
		for i = 1, #design.businesses.name do
			bizlist[i] = guiCreateLabel(60, 140+(20*i), 120, 20, design.businesses.name[i], false, bg)
			guiLabelSetColor(bizlist[i], 15, 106, 137)
			guiSetFont(bizlist[i], "default-small")
			guiLabelSetHorizontalAlign(bizlist[i], "center")
		
			addEventHandler("onClientGUIClick",bizlist[i],function()
				setElementData(getLocalPlayer(), "yoshitsune.page", 4+i)
				yoshitsune_showpage() 
			end,false)
		end
		if i > 4 then
			local right_title = guiCreateLabel(220, 140, 128, 20, design.businesses.name[i-4], false, bg)
			guiLabelSetColor(right_title, 15, 106, 137)
			guiSetFont(right_title, "default-bold-small")
			guiLabelSetHorizontalAlign(right_title, "left")

		
			local right_text = guiCreateLabel(220, 160, 340, 200, design.businesses.description[i-4], false, bg)
			guiLabelSetColor(right_text, 15, 106, 137)
			guiSetFont(right_text, "default-small")
			guiLabelSetHorizontalAlign(right_text, "left", true)
		end
	end
	local page_text_title, page_text = {}, {}
	if i > 4 then i = 3 end
	page_text_title[i] = guiCreateLabel(60, 140, 120, 20, design.text_title[i], false, bg)
	guiLabelSetColor(page_text_title[i], 15, 106, 137)
	guiSetFont(page_text_title[i], "default-bold-small")
	guiLabelSetHorizontalAlign(page_text_title[i], "left", true)
	
	if i ~= 3 and i < 5 then
		page_text[i] = guiCreateLabel(80, 160, 500, 200, design.text[i], false, bg)
		guiLabelSetColor(page_text[i], 15, 106, 137)
		guiSetFont(page_text[i], "default-small")
		guiLabelSetHorizontalAlign(page_text[i], "left", true)
	end

	addEventHandler("onClientGUIClick",banner,function()
		compose_mail( "yoshitsune@saonline.sa" )
	end,false)

	if(page_length>=397)then
		guiScrollPaneSetScrollBars(bg,false,true)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(bg, false, false)
	end
	
end

-- redirection

function www_yoshitsuneenterprises_sa()
	setElementData(getLocalPlayer(), "yoshitsune.page", 1)
	yoshitsune_showpage()
end

function www_yoshitsuneenterprises_sa_about()
	setElementData(getLocalPlayer(), "yoshitsune.page", 2)
	yoshitsune_showpage()
end

function www_yoshitsuneenterprises_sa_properties()
	setElementData(getLocalPlayer(), "yoshitsune.page", 3)
	yoshitsune_showpage()
end

function www_yoshitsuneenterprises_sa_employment()
	setElementData(getLocalPlayer(), "yoshitsune.page", 4)
	yoshitsune_showpage()
end

function update_prop_text()
	
end