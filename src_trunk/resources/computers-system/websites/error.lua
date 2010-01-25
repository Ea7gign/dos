function error_404()

	local page_length = 300
	guiSetText(internet_address_label, "Error - Page not found - Waterwolf")
	
	bg = guiCreateStaticImage(0,0,460,page_length,"websites/colours/1.png",false,internet_pane)
	
	local image = guiCreateStaticImage(20,50,64,64,":help-system/info.png",false,bg)
	local text = guiCreateLabel(110,60,330,165,"Error 404\
											\
											The url address you have entered cannot be found.",false,bg)
	guiSetFont(text,"default-bold-small")
	guiLabelSetColor(text,28,28,28)
	
	if(page_length>=397)then
		guiScrollPaneSetScrollBars(bg,false,true)
	else
		guiSetSize(bg,460,397,false)
		guiScrollPaneSetScrollBars(internet_pane, false, false)
	end	
	
end


