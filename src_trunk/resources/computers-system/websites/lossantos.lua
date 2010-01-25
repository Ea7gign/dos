---------------------
-- www.lossantos.gov --
---------------------
function www_lossantos_gov()
	local page_length = 300
	guiSetText(internet_address_label, "Official website of the Los Santos Government - Waterwolf")
	guiSetText(address_bar,"www.lossantos.gov")
	
	bg = guiCreateStaticImage(0,0,460,page_length,"websites/colours/8.png",false,internet_pane)
	
	local header = guiCreateLabel(10,5,460,40,"Los Santos Government",false,bg)
	guiSetFont(header, "sa-header")
	
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


