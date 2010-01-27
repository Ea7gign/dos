---------------------
-- www.bankofsa.sa --
---------------------
function www_bankofsa_sa()
	local page_length = 500
	
	guiSetText(internet_address_label, "Credit & Commerce Bank of San Andreas - Waterwolf")
	guiSetText(address_bar,"www.bankofsa.sa")	
	
	bg = guiCreateStaticImage(0,0,660,page_length,"websites/colours/10.png",false,internet_pane)
	
	local banner = guiCreateStaticImage(5,5,450,60,"websites/colours/7.png",false,bg)
	local header = guiCreateLabel(10,5,460,40,"Bank of San Andreas",false,bg)
	guiSetFont(header, "sa-header")
	
	local mainStory = guiCreateLabel(100,65,450,165,"Website under construction.",false,bg)
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