---------------------
-- www.lossantos.gov --
---------------------
function www_lossantos_gov()
	local page_length = 300
	guiSetText(internet_address_label, "Official website of the Los Santos Government - Waterwolf")
	guiSetText(address_bar,"www.lossantos.gov")
	
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/8.png",false,internet_pane)
	
	local header = guiCreateStaticImage(106,5,447,198,"websites/images/lsgov-logo.png",false,bg)
	
	local text = guiCreateLabel(350,100,450,165,"Site currently under construction.\
											\
											Please check back soon.",false,bg)
	guiSetFont(mainStory,"default-bold-small")
	
----------------------------------------------------------------------
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(internet_pane,false,true)
		guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
	else
		guiSetSize(bg,660,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end
end


