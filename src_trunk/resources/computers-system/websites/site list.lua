function get_page(new_page)
	
	if not(new_page==tostring(""))then
	
		destroyElement(bg)
		bg = nil
		guiSetText(address_bar,new_page)
		
		---- Alphabetical sight list ----
		if(new_page==tostring("www.bankofsa.sa")) or (new_page==tostring("www.bankofsa.sa/")) then ------------------------------------ www.bankofsa.sa (Credit & Commerce Bank of San Andreas) 
			www_bankofsa_sa()
		elseif(new_page==tostring("www.lossantos.gov")) or (new_page==tostring("www.lossantos.gov/")) then ---------------------------- www.lossantos.gov (Los Santos Government)
			www_lossantos_gov()
		elseif(new_page==tostring("www.lses.gov")) or (new_page==tostring("www.lses.gov/")) then -------------------------------------- www.lses.gov (Los Santos Emergency Service)
			www_lses_gov()
		elseif(new_page==tostring("www.lspd.gov")) or (new_page==tostring("www.lspd.gov/")) then -------------------------------------- www.lspd.gov (Los Santos Police Department)
			www_lspd_gov()
		elseif(new_page==tostring("www.sanetwork.sa")) or (new_page==tostring("www.sanetwork.sa/"))then ------------------------------- www.sanetwork.sa (San Andreas Network. Everyone's home page)
			www_sanetwork_sa()
		elseif(new_page==tostring("www.preview.sa")) or (new_page==tostring("www.preview.sa/"))then ----------------------------------- www.preview.sa (test page)
			www_preview_sa()
			
	  ----------------------------------------------------------------------------------------
	  ----------------------------------------------------------------------------------------
		
		else
			error_404() -- Error!?!
		end
	end
end