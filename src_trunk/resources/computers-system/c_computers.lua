-- Computer window
local wComputer,desktopImage,internetButton, emailButton, shutdownButton = nil
	-- Internet window
	wInternet, internet_close_button, internet_address_label, address_bar, go_button, internet_pane, shadow_top, shadow_left, shadow_bottom = nil
	-- Email Login
	local email_close_button, email_error_label, username_label, username_input, address_label, address_1, address_2, address_f, password_label, password_input, email_login_button, email_register_button, wEmail = nil
	-- Email Main
	local wEmail, email_tab_panel, inbox_tab, outbox_tab, send_tab = nil
		-- Inbox
		local inbox_grid, inbox_grid_date, inbox_grid_sender, inbox_grid_subject, inbox_message_datetitle_label, inbox_message_date_label, inbox_message_fromtitle_label, inbox_message_from_label, inbox_message_subjecttitle_label, inbox_message_subject_label, inbox_message_display, inbox_message_label, check_mail_button = nil
		-- Outbox
		local outbox_grid, outbox_grid_date, outbox_grid_sender, outbox_grid_subject, outbox_message_datetitle_label, outbox_message_date_label, outbox_message_totitle_label, outbox_message_from_label, outbox_message_subjecttitle_label, outbox_message_subject_label, outbox_message_display, outbox_message_label
		-- New message
		local new_message_to_label, new_message_to_input, new_message_subject_label, new_message_subject_input, new_message_content_label, new_message_content, send_button = nil
------------------------------------------------------------------
------------------------ Computer desktop ------------------------
------------------------------------------------------------------

function createComputerGUI()
	local Width = 700
	local Height = 500
	local screenwidth, screenheight = guiGetScreenSize()
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	if not (wComputer) then
		wComputer = guiCreateWindow(X, Y, Width, Height, "Computer", false)
		desktopImage = guiCreateStaticImage(0.0,0.05,1,0.95,"desktop.png",true,wComputer)
		internetButton = guiCreateStaticImage (100,105,56,66,"internet_icon.png",false,desktopImage)
		addEventHandler("onClientGUIClick",internetButton,openInternetWindow,false)
		emailButton = guiCreateStaticImage (180,205,56,66,"email_icon.png",false,desktopImage)
		addEventHandler("onClientGUIClick",emailButton,openEmailWindow,false)
		shutdownButton = guiCreateStaticImage(620,390,56,66,"shutdown_icon.png",false,desktopImage)
		addEventHandler("onClientGUIClick",shutdownButton,closeComputerWindow,false)
		showCursor(true)
		guiSetInputEnabled(true)		
	end
end
--addCommandHandler("computer",createComputerGUI)
addEvent("useCompItem",true)
addEventHandler("useCompItem",getRootElement(),createComputerGUI)

function closeComputerWindow()
	if(wInternet)then -- Internet window
		destroyElement(shadow_left)
		destroyElement(shadow_bottom)
		destroyElement(shadow_top)
		destroyElement(internet_pane)
		destroyElement(go_button)
		destroyElement(address_bar)
		destroyElement(internet_address_label)
		destroyElement(internet_close_button)
		destroyElement(wInternet)
		wInternet, internet_close_button, internet_address_label, address_bar, go_button, internet_pane, shadow_top, shadow_left, shadow_bottom, bg = nil
	end
	if (username_input) then -- email
		if (address_f) then
			destroyElement(address_f)
			address_f = nil
		end
		destroyElement(email_close_button)
		destroyElement(email_error_label)
		destroyElement(username_label)
		destroyElement(username_input)
		destroyElement(address_label)
		destroyElement(address_1)
		destroyElement(address_2)
		destroyElement(password_label)
		destroyElement(password_input)
		destroyElement(email_login_button)
		destroyElement(email_register_button)
		destroyElement(wEmail)
		email_close_button,	email_error_label, username_label, username_input, address_label, address_1, address_2,	address_f,	password_label,	password_input,	email_login_button,	email_register_button, wEmail = nil
	
	elseif (inbox_grid) then
	
		destroyElement(inbox_grid)
		destroyElement(inbox_message_datetitle_label)
		destroyElement(inbox_message_date_label)
		destroyElement(inbox_message_fromtitle_label)
		destroyElement(inbox_message_from_label)
		destroyElement(inbox_message_subjecttitle_label)
		destroyElement(inbox_message_subject_label)
		destroyElement(inbox_message_label)
		destroyElement(inbox_message_display)
		destroyElement(check_mail_button)
		
		destroyElement(outbox_grid)
		destroyElement(outbox_message_datetitle_label)
		destroyElement(outbox_message_date_label)
		destroyElement(outbox_message_totitle_label)
		destroyElement(outbox_message_from_label)
		destroyElement(outbox_message_subjecttitle_label)
		destroyElement(outbox_message_subject_label)
		destroyElement(outbox_message_label)
		destroyElement(outbox_message_display)
		
		destroyElement(new_message_to_label)
		destroyElement(new_message_to_input)
		destroyElement(new_message_subject_label)
		destroyElement(new_message_subject_input)
		destroyElement(new_message_content_label)
		destroyElement(new_message_content)
		destroyElement(send_button)
		
		destroyElement(email_close_button)
		destroyElement(inbox_tab)
		destroyElement(outbox_tab)
		destroyElement(send_tab)
		destroyElement(email_tab_panel)
		destroyElement(wEmail)
		
		inbox_grid, inbox_grid_date, inbox_grid_sender, inbox_grid_subject, inbox_message_datetitle_label, inbox_message_date_label, inbox_message_fromtitle_label, inbox_message_from_label, inbox_message_subjecttitle_label, inbox_message_subject_label, inbox_message_display, inbox_message_label, check_mail_button = nil
		outbox_grid, outbox_grid_date, outbox_grid_sender, outbox_grid_subject, outbox_message_datetitle_label, outbox_message_date_label, outbox_message_totitle_label, outbox_message_from_label, outbox_message_subjecttitle_label, outbox_message_subject_label, outbox_message_display, outbox_message_label = nil
		new_message_to_label, new_message_to_input, new_message_subject_label, new_message_subject_input, new_message_content_label, new_message_content, send_button = nil
		email_close_button, inbox_tab, outbox_tab, send_tab, email_tab_panel, wEmail = nil
	
	end
	-- Computer Desktop GUI.
	destroyElement(internetButton)
	destroyElement(emailButton)
	destroyElement(shutdownButton)
	destroyElement(desktopImage)
	destroyElement(wComputer)
	wComputer,desktopImage,internetButton, emailButton, shutdownButton = nil
	
	guiSetInputEnabled(false)
	showCursor(false)	
	
end
addCommandHandler("ctl+alt+del",closeComputerWindow) -- Emergency close command.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------- Internet   --------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function openInternetWindow()
	local Width = 504
	local Height = 500
	local screenwidth, screenheight = guiGetScreenSize()
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	if not (wInternet) then
		wInternet = guiCreateWindow(X, Y, Width, Height, "Internet", false,wComputer)
		internet_close_button = guiCreateButton(470,22,22,22,"x",false,wInternet)
		addEventHandler("onClientGUIClick",internet_close_button,closeInternetWindow,false)
		internet_address_label = guiCreateLabel(10,20,470,20,"",false,wInternet)
		address_bar = guiCreateEdit(5,45,320,24,"",false,wInternet)
		go_button = guiCreateButton(337,45,24,24,"Go",false,wInternet)
		addEventHandler("onClientGUIClick",go_button,function()
			local new_page = guiGetText(address_bar)
			get_page(new_page)
		end,false)		
		internet_pane = guiCreateScrollPane(2,85,480,397,false,wInternet)
		guiScrollPaneSetScrollBars(internet_pane, false, true)			
		shadow_top = guiCreateStaticImage(2,84,476,1,"websites/colours/13.png",false,wInternet)
		shadow_left = guiCreateStaticImage(2,85,1,397,"websites/colours/13.png",false,wInternet)
		shadow_bottom = guiCreateStaticImage(4,503,476,1,"websites/colours/1.png",false,wInternet)
		www_sanetwork_sa()
	else
		guiBringToFront(wInternet)
	end
end

function get_page(new_page)
	destroyElement(bg)
	bg = nil
	guiSetText(address_bar,new_page)
	if new_page ~= "" then
		if new_page:sub(-1) == "/" then
			new_page = new_page:sub(0,-2)
		end
		local fn = new_page:gsub("%.", "_"):gsub("/","_"):gsub("[^a-zA-Z0-9_]", "")
		if string.find(new_page, "www%.") ~= 1 or not pcall(loadstring( "return " .. fn .. "()" ) ) then
			error_404()
		end
	end
end

function closeInternetWindow()
	if(wInternet) then
		destroyElement(shadow_left)
		destroyElement(shadow_bottom)
		destroyElement(shadow_top)
		destroyElement(internet_pane)
		destroyElement(go_button)
		destroyElement(address_bar)
		destroyElement(internet_address_label)
		destroyElement(internet_close_button)
		destroyElement(wInternet)
		wInternet, internet_close_button, internet_address_label, address_bar, go_button, internet_pane, shadow_top, shadow_left, shadow_bottom, bg = nil
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------- E-mail --------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function openEmailWindow()
	-- Window variables
	local Width = 300
	local Height = 220
	local screenwidth, screenheight = guiGetScreenSize()
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	if not (wEmail) then
		-- Create the window
		wEmail = guiCreateWindow(X,Y,Width,Height,"E-mail",false,wComputer)
		-- Close button
		email_close_button = guiCreateButton(272,23,22,22,"x",false,wEmail)
		addEventHandler("onClientGUIClick",email_close_button,close_email_window,false)
		
		-- Error Label
		email_error_label = guiCreateLabel(13,25,175,16,"",false,wEmail)
		guiLabelSetColor(email_error_label,255,0,0)
		guiSetFont(email_error_label,"default-bold-small")
		
		-- Username
		username_label = guiCreateLabel(13,54,63,16,"Username:",false,wEmail)
		username_input = guiCreateEdit(78,52,200,22,"J.Smith",false,wEmail)
		
		address_label = guiCreateLabel(13,88,63,16,"Provider:",false,wEmail)
		
		address_1 = guiCreateRadioButton(79,88,200,16,"@saonline.sa",false,wEmail)
		address_2 = guiCreateRadioButton(79,104,200,16,"@whiz.sa",false,wEmail)
		
		local theTeam = getPlayerTeam(getLocalPlayer())
		local teamName = getTeamName(theTeam)
		if (teamName=="Los Santos Police Department") then
			address_f = guiCreateRadioButton(79,121,200,16,"@lspd.gov",false,wEmail)
		elseif (teamName=="Los Santos Emergency Services") then
			address_f = guiCreateRadioButton(79,121,200,16,"@lses.gov",false,wEmail)
		elseif (teamName=="Government of Los Santos") then
			address_f = guiCreateRadioButton(79,121,200,16,"@lossantos.gov",false,wEmail)
		elseif (teamName=="San Andreas Network") then
			address_f = guiCreateRadioButton(79,121,200,16,"@sanetwork.sa",false,wEmail)
		elseif (teamName=="Best's Towing and Recovery") then
			address_f = guiCreateRadioButton(79,121,200,16,"@btr.sa",false,wEmail)
		elseif (teamName=="First Court of San Andreas") then
			address_f = guiCreateRadioButton(79,121,200,16,"@justice.gov",false,wEmail)
		end
		
		password_label = guiCreateLabel(13,154,63,16,"Password:",false,wEmail)
		password_input = guiCreateEdit(78,150,200,22,"",false,wEmail)
		guiEditSetMasked(password_input,true)

		-- Login
		email_login_button = guiCreateButton(67,184,70,26,"Login",false,wEmail)
		addEventHandler("onClientGUIClick",email_login_button,function()
			local username = tostring(guiGetText(username_input))
			if (tostring(username) =="") then -- username field
				guiSetText(email_error_label,"Enter a username!")
			elseif (guiRadioButtonGetSelected(address_1)==false) and (guiRadioButtonGetSelected(address_2)==false) and (guiRadioButtonGetSelected(address_f)==false) then -- provider
				guiSetText(email_error_label,"You need to select a provider!")
			elseif (tostring(guiGetText(password_input))=="") then
				guiSetText(email_error_label,"Enter a password!")
			else
				local password = tostring(guiGetText(password_input)) -- Password
				
				if (guiRadioButtonGetSelected(address_1)==true) then
					full_username = tostring(username.. "@saonline.sa")
				elseif (guiRadioButtonGetSelected(address_2)==true) then
					full_username = tostring(username.. "@whiz.sa")
				elseif (guiRadioButtonGetSelected(address_f)==true) then
					
					if (teamName=="Los Santos Police Department") then
						full_username = tostring(username.."@lspd.gov")
					elseif (teamName=="Los Santos Emergency Services") then
						full_username = tostring(username.."@lses.gov")
					elseif (teamName=="Government of Los Santos") then
						full_username = tostring(username.."@lossantos.gov")
					elseif (teamName=="San Andreas Network") then
						full_username = tostring(username.."@sanetwork.sa")
					elseif (teamName=="Best's Towing and Recovery") then
						full_username = tostring(username.."@btr.sa")
					elseif (teamName=="First Court of San Andreas") then
						full_username = tostring(username.."@justice.gov")
					end
				end
				
				triggerServerEvent("loginEmail",getLocalPlayer(),full_username,password)
			end
		end,false)

		-- Register
		email_register_button = guiCreateButton(164,184,70,26,"Register",false,wEmail)
		addEventHandler("onClientGUIClick",email_register_button,function()
			
			local username = tostring(guiGetText(username_input))
			if (tostring(username) =="") then -- username field
				guiSetText(email_error_label,"Enter a username!")
			elseif (guiRadioButtonGetSelected(address_1)==false) and (guiRadioButtonGetSelected(address_2)==false) and (guiRadioButtonGetSelected(address_f)==false) then-- provider
				guiSetText(email_error_label,"You need to select a provider!")
			elseif (tostring(guiGetText(password_input))=="") then
				guiSetText(email_error_label,"Enter a password!")
			else
				local password = tostring(guiGetText(password_input)) -- password
				
				if (guiRadioButtonGetSelected(address_1)==true) then
					full_username = tostring(username.. "@saonline.sa")
				elseif (guiRadioButtonGetSelected(address_2)==true) then
					full_username = tostring(username.. "@whiz.sa")
				elseif (guiRadioButtonGetSelected(address_f)==true) then
					
					if (teamName=="Los Santos Police Department") then
						full_username = tostring(username.."@lspd.gov")
					elseif (teamName=="Los Santos Emergency Services") then
						full_username = tostring(username.."@lses.gov")
					elseif (teamName=="Government of Los Santos") then
						full_username = tostring(username.."@lossantos.gov")
					elseif (teamName=="San Andreas Network") then
						full_username = tostring(username.."@sanetwork.sa")
					elseif (teamName=="Best's Towing and Recovery") then
						full_username = tostring(username.."@btr.sa")
					elseif (teamName=="First Court of San Andreas") then
						full_username = tostring(username.."@justice.gov")
					end
				end
				triggerServerEvent("registerEmail",getLocalPlayer(),full_username,password)				

			end			
		end,false)
	else
		guiBringToFront(wEmail)
	end
end

function name_error()
	guiSetText(email_error_label, "Username already in use!")
end
addEvent("name_in_use",true)
addEventHandler("name_in_use", getLocalPlayer(),name_error)

function login_error()
	guiSetText(email_error_label, "Invalid username or password!")
end
addEvent("loginError",true)
addEventHandler("loginError", getLocalPlayer(),login_error)

function close_email_window()
	if (username_input) then
		if (address_f) then
			destroyElement(address_f)
			address_f = nil
		end
		destroyElement(email_close_button)
		destroyElement(email_error_label)
		destroyElement(username_label)
		destroyElement(username_input)
		destroyElement(address_label)
		destroyElement(address_1)
		destroyElement(address_2)
		destroyElement(password_label)
		destroyElement(password_input)
		destroyElement(email_login_button)
		destroyElement(email_register_button)
		destroyElement(wEmail)
		email_close_button,	email_error_label, username_label, username_input, address_label, address_1, address_2,	address_f,	password_label,	password_input,	email_login_button,	email_register_button, wEmail = nil
	
	elseif (inbox_grid) then
	
		destroyElement(inbox_grid)
		destroyElement(inbox_message_datetitle_label)
		destroyElement(inbox_message_date_label)
		destroyElement(inbox_message_fromtitle_label)
		destroyElement(inbox_message_from_label)
		destroyElement(inbox_message_subjecttitle_label)
		destroyElement(inbox_message_subject_label)
		destroyElement(inbox_message_label)
		destroyElement(inbox_message_display)
		destroyElement(check_mail_button)
		
		destroyElement(outbox_grid)
		destroyElement(outbox_message_datetitle_label)
		destroyElement(outbox_message_date_label)
		destroyElement(outbox_message_totitle_label)
		destroyElement(outbox_message_from_label)
		destroyElement(outbox_message_subjecttitle_label)
		destroyElement(outbox_message_subject_label)
		destroyElement(outbox_message_label)
		destroyElement(outbox_message_display)
		
		destroyElement(new_message_to_label)
		destroyElement(new_message_to_input)
		destroyElement(new_message_subject_label)
		destroyElement(new_message_subject_input)
		destroyElement(new_message_content_label)
		destroyElement(new_message_content)
		destroyElement(send_button)
		
		destroyElement(email_close_button)
		destroyElement(inbox_tab)
		destroyElement(outbox_tab)
		destroyElement(send_tab)
		destroyElement(email_tab_panel)
		destroyElement(wEmail)
		
		inbox_grid, inbox_message_datetitle_label, inbox_message_date_label, inbox_message_fromtitle_label, inbox_message_from_label, inbox_message_subjecttitle_label, inbox_message_subject_label, inbox_message_display, inbox_message_label, check_mail_button = nil
		outbox_grid, outbox_message_datetitle_label, outbox_message_date_label, outbox_message_totitle_label, outbox_message_from_label, outbox_message_subjecttitle_label, outbox_message_subject_label, outbox_message_display, outbox_message_label = nil
		new_message_to_label, new_message_to_input, new_message_subject_label, new_message_subject_input, new_message_content_label, new_message_content, send_button = nil
		email_close_button, inbox_tab, outbox_tab, send_tab, email_tab_panel, wEmail = nil
	end
end
addEvent("closeEmailLogin",true)
addEventHandler("closeEmailLogin", getRootElement(),close_email_window)

function show_inbox(inbox_table, accountName)
	if not (wEmail) then
		local Width = 550
		local Height = 450
		local screenwidth, screenheight = guiGetScreenSize()
		local X = (screenwidth - Width)/2
		local Y = (screenheight - Height)/2
	
		-- Create the window
		wEmail = guiCreateWindow(X,Y,Width,Height,"E-mail",false,wComputer)
		
		-- Tabs (Inbox, Outbox, Send Message)
		email_tab_panel = guiCreateTabPanel(0.0,0.06,1.0,1.0,true,wEmail)
		inbox_tab = guiCreateTab("Inbox",email_tab_panel)
		outbox_tab = guiCreateTab("Outbox",email_tab_panel)
		send_tab = guiCreateTab("Compose Message",email_tab_panel)
		--account_tab = guiCreateTab("Account Settings",email_tab_panel)
		
		------------------
		-- Send Message --
		------------------
		-- To:
		new_message_to_label = guiCreateLabel(0.1,0.1,0.2,0.05,"To:",true,send_tab)
		new_message_to_input = guiCreateEdit(0.2,0.1,0.3,0.05,"",true,send_tab)
		-- Subject:
		new_message_subject_label = guiCreateLabel(0.1,0.2,0.2,0.05,"Subject:",true,send_tab)
		new_message_subject_input = guiCreateEdit(0.2,0.2,0.5,0.05,"",true,send_tab)
		-- Message:
		new_message_content_label = guiCreateLabel(0.1,0.3,0.3,0.05,"Message:",true,send_tab)
		new_message_content = guiCreateMemo(0.1,0.4,0.8,0.45,"Hi...",true,send_tab)
		-- Send Button
		send_button = guiCreateButton(0.4,0.9,0.2,0.08,"Send",true,send_tab)
		addEventHandler("onClientGUIClick",send_button,function()
			local to = guiGetText(new_message_to_input)
			local subject = guiGetText(new_message_subject_input)
			local message = guiGetText(new_message_content)
			
			triggerServerEvent("sendMessage",getLocalPlayer(),accountName,to,subject,message)
		end,false)
		
		--[[
		---------------------
		-- Account Options --
		---------------------
		
		-- Change Password
		old_password_label = guiCreateLabel(0.1,0.1,0.3,0.05,"Old Password",true,account_tab)
		old_password_input = guiCreateEdit(0.4,0.1,0.3,0.05,"",true,account_tab)
		guiEditSetMasked(old_password_input,true)
		new_password_label = guiCreateLabel(0.1,0.2,0.3,0.05,"New Password",true,account_tab)
		new_password_input = guiCreateEdit(0.4,0.2,0.3,0.05,"",true,account_tab)
		guiEditSetMasked(new_password_input,true)
		confirm_password_label = guiCreateLabel(0.1,0.3,0.3,0.05,"Confirm New Password",true,account_tab)
		confirm_password_input = guiCreateEdit(0.4,0.3,0.3,0.05,"",true,account_tab)
		guiEditSetMasked(confirm_password_input,true)
		--save button
		save_button = guiCreateButton(0.4,0.4,0.2,0.08,"Save",true,account_tab)
		-- Clear Button
		
		-- Delete Account
		delete_account_label = guiCreateLabel(0.1,0.5,0.8,0.3,"To delete this email account enter your password below and\
															press the delete account button.\
															\
															Deleting an account is permenant and can not be undone.",true,account_tab)
		delete_account_input = guiCreateEdit(0.1,0.7,0.3,0.05,"",true,account_tab)
		guiEditSetMasked(delete_account_input,true)
		--button
		delete_account_button = guiCreateButton(0.4,0.8,0.2,0.08,"Delete Account",true,account_tab)]]
		
		-- Close button
		email_close_button = guiCreateButton(0.94,0.05,0.06,0.05,"x",true,wEmail)
		addEventHandler("onClientGUIClick",email_close_button,close_email_window,false)
	end
	
	-----------
	-- Inbox --
	-----------
	
	if (inbox_grid) then
		guiGridListClear(inbox_grid)
		destroyElement(inbox_grid)
		inbox_grid = nil
	end	
	-- Create the grid list of received messages
	inbox_grid = guiCreateGridList (0.01,0.02,0.98,0.36,true,inbox_tab)
	inbox_grid_date = guiGridListAddColumn(inbox_grid,"Date",0.16)
	inbox_grid_sender = guiGridListAddColumn(inbox_grid,"From",0.3)
	inbox_grid_subject = guiGridListAddColumn(inbox_grid,"Subject",0.5)
	guiGridListSetSortingEnabled(inbox_grid,false)
	for key, value in pairs(inbox_table) do
		i_message_date = inbox_table[key][2]
		i_message_sender = inbox_table[key][3]
		i_message_subject = inbox_table[key][4]
		inbox_row = guiGridListAddRow(inbox_grid)
		guiGridListSetItemText(inbox_grid, inbox_row, inbox_grid_date, i_message_date, false, false) -- Date Sent
		guiGridListSetItemText(inbox_grid, inbox_row, inbox_grid_sender, i_message_sender, false, false) -- Sender
		guiGridListSetItemText(inbox_grid, inbox_row, inbox_grid_subject, i_message_subject, false, false) -- Subject	
	end
	if not(inbox_message_datetitle_label) then
		-- Static labels showing date and sender
		inbox_message_datetitle_label = guiCreateLabel(0.02,0.4,0.96,0.1,"Date received:",true,inbox_tab)
		guiSetFont(inbox_message_datetitle_label,"default-bold-small")
		inbox_message_date_label = guiCreateLabel(0.185,0.4,0.96,0.1,tostring(inbox_table[1][2]),true,inbox_tab)
		
		inbox_message_fromtitle_label = guiCreateLabel(0.5,0.4,0.96,0.1,"From:",true,inbox_tab)
		guiSetFont(inbox_message_fromtitle_label,"default-bold-small")
		inbox_message_from_label = guiCreateLabel(0.575,0.4,0.45,0.1,tostring(inbox_table[1][3]),true,inbox_tab)
		
		inbox_message_subjecttitle_label = guiCreateLabel(0.02,0.45,0.96,0.1,"Subject:",true,inbox_tab)
		guiSetFont(inbox_message_subjecttitle_label,"default-bold-small")
		inbox_message_subject_label = guiCreateLabel(0.115,0.45,0.8,0.1,tostring(inbox_table[1][4]),true,inbox_tab)
		
		-- Scroll pane displaying selected message
		inbox_message_display = guiCreateScrollPane(0.02,0.52,0.96,0.34,true,inbox_tab)
		guiScrollPaneSetScrollBars(inbox_message_display, false, true)
		-- Display first message in text label
		inbox_message_label = guiCreateLabel(0.02,0.05,0.96,2.0, tostring(inbox_table[1][5]),true,inbox_message_display)
		guiLabelSetHorizontalAlign(inbox_message_label,"left",true)
	else
		guiSetText(inbox_message_date_label,tostring(inbox_table[1][2]))
		guiSetText(inbox_message_from_label,tostring(inbox_table[1][3]))
		guiSetText(inbox_message_subject_label,tostring(inbox_table[1][4]))
		guiSetText(inbox_message_label,tostring(inbox_table[1][5]))
	end
	addEventHandler("onClientGUIDoubleClick",inbox_grid,function(button, state)
		if(button == "left") then
			
			local row = nil
			local row = tonumber(guiGridListGetSelectedItem(inbox_grid)+1)
			
			guiSetText(inbox_message_date_label,tostring(inbox_table[row][2]))
			guiSetText(inbox_message_from_label,tostring(inbox_table[row][3]))
			guiSetText(inbox_message_subject_label,tostring(inbox_table[row][4]))
			guiSetText(inbox_message_label,tostring(inbox_table[row][5]))
		end
	end,false)
	
	if not (check_mail_button) then
		check_mail_button = guiCreateButton(0.3,0.9,0.2,0.08,"Check Mail",true,inbox_tab)
		addEventHandler("onClientGUIClick",check_mail_button, function()
			triggerServerEvent("s_getInbox",getRootElement(),accountName)
		end,false)	
		
		--[[DELETE FUNCTION (INBOX)
		inbox_delete_mail_button = guiCreateButton(0.5,0.9,0.2,0.08,"Delete",true,inbox_tab)
		addEventHandler("onClientGUIClick",inbox_delete_mail_button,function()
			local del_row = nil
			del_row = tonumber(guiGridListGetSelectedItem(inbox_grid)+1)
			local id = inbox_table[del_row][1]
			triggerServerEvent("deleteInboxMessage",getLocalPlayer(),id,accountName)
		end,false)]]
	end
end
addEvent("showInbox",true)
addEventHandler("showInbox",getRootElement(),show_inbox)

function show_outbox(outbox_table,accountName)
	------------
	-- Outbox --
	------------
	
	if (outbox_grid) then
		destroyElement(outbox_grid)
		outbox_grid = nil
	end

	-- Create the grid list of received messages
	outbox_grid = guiCreateGridList (0.01,0.02,0.98,0.36,true,outbox_tab)
	outbox_grid_date = guiGridListAddColumn(outbox_grid,"Date",0.16)
	outbox_grid_sender = guiGridListAddColumn(outbox_grid,"From",0.3)
	outbox_grid_subject = guiGridListAddColumn(outbox_grid,"Subject",0.5)
	guiGridListSetSortingEnabled(outbox_grid,false)
	
	for key, value in pairs(outbox_table) do

		local o_message_date = outbox_table[key][2]
		local o_message_sender = outbox_table[key][3]
		local o_message_subject = outbox_table[key][4]
		
		local outbox_row = guiGridListAddRow(outbox_grid)
		guiGridListSetItemText(outbox_grid, outbox_row, outbox_grid_date, o_message_date, false, false) -- Date Sent
		guiGridListSetItemText(outbox_grid, outbox_row, outbox_grid_sender, o_message_sender, false, false) -- Sender
		guiGridListSetItemText(outbox_grid, outbox_row, outbox_grid_subject, o_message_subject, false, false) -- Subject	
	end
	
	if not(outbox_message_datetitle_label) then
		-- Static labels showing date and sender
		outbox_message_datetitle_label = guiCreateLabel(0.02,0.4,0.96,0.1,"Date received:",true,outbox_tab)
		guiSetFont(outbox_message_datetitle_label,"default-bold-small")
		outbox_message_date_label = guiCreateLabel(0.185,0.4,0.96,0.1,tostring(outbox_table[1][2]),true,outbox_tab)
		
		outbox_message_totitle_label = guiCreateLabel(0.5,0.4,0.96,0.1,"To:",true,outbox_tab)
		guiSetFont(outbox_message_totitle_label,"default-bold-small")
		outbox_message_from_label = guiCreateLabel(0.575,0.4,0.45,0.1,tostring(outbox_table[1][3]),true,outbox_tab)
		
		outbox_message_subjecttitle_label = guiCreateLabel(0.02,0.45,0.96,0.1,"Subject:",true,outbox_tab)
		guiSetFont(outbox_message_subjecttitle_label,"default-bold-small")
		outbox_message_subject_label = guiCreateLabel(0.115,0.45,0.8,0.1,tostring(outbox_table[1][4]),true,outbox_tab)
		
		-- Scroll pane displaying selected message
		outbox_message_display = guiCreateScrollPane(0.02,0.52,0.96,0.34,true,outbox_tab)
		guiScrollPaneSetScrollBars(outbox_message_display, false, true)
		-- Display first message in text label
		outbox_message_label = guiCreateLabel(0.02,0.05,0.96,2.0, tostring(outbox_table[1][5]),true,outbox_message_display)
		guiLabelSetHorizontalAlign(outbox_message_label,"left",true)
	else
		guiSetText(outbox_message_date_label,tostring(outbox_table[1][2]))
		guiSetText(outbox_message_from_label,tostring(outbox_table[1][3]))
		guiSetText(outbox_message_subject_label,tostring(outbox_table[1][4]))
		guiSetText(outbox_message_label,tostring(outbox_table[1][5]))
	end
	
	addEventHandler("onClientGUIDoubleClick",outbox_grid,function(button, state)
		if(button == "left") then
		
			local row = nil
			local row = tonumber(guiGridListGetSelectedItem(outbox_grid)+1)
			
			guiSetText(outbox_message_date_label,tostring(outbox_table[row][2]))
			guiSetText(outbox_message_from_label,tostring(outbox_table[row][3]))
			guiSetText(outbox_message_subject_label,tostring(outbox_table[row][4]))
			guiSetText(outbox_message_label,tostring(outbox_table[row][5]))
		end
	end,false)
	
	if not (outbox_delete_mail_button) then
		
		--[[ DELETE FUNCTION (OUTBOX)
		outbox_delete_mail_button = guiCreateButton(0.4,0.9,0.2,0.08,"Delete",true,outbox_tab)
		addEventHandler("onClientGUIClick",outbox_delete_mail_button,function()
			local o_del_row = nil
			o_del_row = tonumber(guiGridListGetSelectedItem(outbox_grid)+1)
			local id = outbox_table[o_del_row][1]
			triggerServerEvent("deleteOutboxMessage",getLocalPlayer(),id, accountName)
		end,false)]]
	end
end
addEvent("showOutbox",true)
addEventHandler("showOutbox",getRootElement(),show_outbox)


function invalid_address()
	guiSetText(new_message_to_input, "Address not found!")
end
addEvent("invalidAddress",true)
addEventHandler("invalidAddress",getRootElement(),invalid_address)

function c_send_message()
	guiSetSelectedTab(email_tab_panel,outbox_tab)
end
addEvent("c_sendMessage",true)
addEventHandler("c_sendMessage",getRootElement(),c_send_message)