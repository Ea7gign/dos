---------------------
-- www.lspd.gov --
---------------------
function www_lspd_gov()
	local page_length = 350
	
	guiSetText(internet_address_label, "Los Santos Police Department - 'Taking the law into our own hands...' - Waterwolf")
	guiSetText(address_bar,"www.lspd.gov")
	
	bg = guiCreateStaticImage(0,0,460,page_length,"websites/colours/10.png",false,internet_pane)
	
	local header = guiCreateLabel(10,5,460,40,"LSPD",false,bg)
	
	local text = guiCreateLabel(5,100,450,165,"Site currently under construction.\
											\
											Please check back soon.",false,bg)
	guiSetFont(mainStory,"default-bold-small")
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(bg,false,true)
	else
		guiSetSize(bg,460,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end	
	
end


