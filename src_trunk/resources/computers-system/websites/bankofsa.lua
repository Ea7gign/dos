---------------------
-- www.saonline.sa --
---------------------
function www_bankofsa_sa()
	local page_length = 500
	
	guiSetText(internet_address_label, "Credit & Commerce Bank of San Andreas - Waterwolf")
	guiSetText(address_bar,"www.bankofsa.sa")	
	
	bg = guiCreateStaticImage(0,0,460,page_length,"websites/colours/10.png",false,internet_pane)
	
	local banner = guiCreateStaticImage(5,5,450,60,"websites/colours/7.png",false,bg)
	local header = guiCreateLabel(10,5,460,40,"Bank of San Andreas",false,bg)
	guiSetFont(header, "sa-header")
	
	local mainStory = guiCreateLabel(5,65,450,165,"Website under construction.",false,bg)
	guiSetFont(mainStory,"default-bold-small")
	
	--------------------------------------------------------------------------------
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(bg,false,true)
	else
		guiSetSize(bg,460,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end	
	
end