function get_page(new_page)
	
	destroyElement(bg)
	bg = nil
	guiSetText(address_bar,new_page)
	
	if new_page ~= "" then
		-- strip the last /
		if new_page:sub(-1) == "/" then
			new_page = new_page::sub(0,-2)
		end
		
		-- function to get urls->actual functions, such as www.bankofsa.sa/jobs -> www_bankofsa_sa_jobs
		local fn = new_page:gsub("%.", "_"):gsub("/","_"):gsub("[^a-zA-Z0-9_]", "")
		if string.find(new_page, "www%.") ~= 1 or not pcall(loadstring( "return " .. fn .. "()" ) ) then
			error_404() -- Error!?!
		end
	end
end