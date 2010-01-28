----------------------------
-- natslife.net (IC blog) --
----------------------------

-- Website owner's forum name: mabako
-- Website owner's Character's name: Natalie Stafford

local p = false
local height = 600
local width = 660

local function showSinglePage( i, x )
	guiSetText(internet_address_label, "Nat's Life - " .. p[i].title .. ( #p[i] > 1 and " (" .. x .. "/" .. #p[i] .. ")" or "" ) .. " - Waterwolf")
	guiSetText(address_bar,"www.natslife.net/entry" .. i .. ( x > 1 and "/" .. x or "" ))
	bg = guiCreateStaticImage(0,0,width,height,"websites/colours/0.png",false,internet_pane)
	
	--
	
	local caption = guiCreateLabel(10, 35, width-20, 40, p[i].title .. ( #p[i] > 1 and " - Part " .. x .. " of " .. #p[i] or "" ) .. " - " .. p[i].date,false,bg)
	guiSetFont(caption, "default-bold-small")
	guiLabelSetColor(caption, 255, 255, 128)

	--
	
	local text = guiCreateLabel(10,60,width-20,height-70,p[i][x],false,bg)
	guiLabelSetHorizontalAlign(text, "left", true)
	guiSetFont(text, "clear-normal")
	
	-- next/previous page
	
	if x > 1 then
		previousPage = guiCreateButton( 280, 10, 18, 18, "<", false, bg )
		addEventHandler( "onClientGUIClick", previousPage,
			function( button, state )
				if button == "left" then
					showSinglePage( i, x - 1 )
				end
			end
		)
	end
	
	if x < #p[i] then
		nextPage = guiCreateButton( 342, 10, 18, 18, ">", false, bg )
		addEventHandler( "onClientGUIClick", nextPage,
			function( button, state )
				if button == "left" then
					showSinglePage( i, x + 1 )
				end
			end
		)
	end
	
	-- next/previous post
	if i > 1 then
		previousEntry = guiCreateButton( 200, 10, 78, 18, "< Previous", false, bg )
		addEventHandler( "onClientGUIClick", previousEntry,
			function( button, state )
				if button == "left" then
					showSinglePage( i - 1, 1 )
				end
			end
		)
	end
	
	if i < #p then
		nextEntry = guiCreateButton( 362, 10, 78, 18, "Next >", false, bg )
		addEventHandler( "onClientGUIClick", nextEntry,
			function( button, state )
				if button == "left" then
					showSinglePage( i + 1, 1 )
				end
			end
		)
	end
	
	
	-- jump to entrance
	local entryID = guiCreateEdit( 300, 10, 40, 18, tostring( i ), false, bg )
	addEventHandler( "onClientGUIAccepted", entryID, 
		function( element )
			local entry = tonumber( guiGetText( element ) )
			if entry then
				showSinglePage( entry, 1 )
			else
				guiSetText( element, tostring( i ) )
			end
		end,
		false
	)
	
	guiScrollPaneSetScrollBars(internet_pane,false,true)
	guiScrollPaneSetVerticalScrollPosition(internet_pane,0)
end

local function buildPages( )
	p = getElementData( getResourceRootElement( ), "page:natslife.net" )
	if p then
		-- build pages
		for i = #p, 1, -1 do
			_G['www_natslife_net_entry' .. i] = function( ) showSinglePage( i, 1 ) end
			-- split up in pieces
			local content = p[i].content
			while true do
				local pos = content:find("%s", 3000)
				if pos then
					local newindex = #p[i]+1
					p[i][newindex] = content:sub( 1, pos )
					_G['www_natslife_net_entry' .. i .. "_" .. newindex] = function( ) showSinglePage( i, newindex ) end
					content = content:sub( pos + 1 )
				else
					local newindex = #p[i]+1
					p[i][newindex] = content
					_G['www_natslife_net_entry' .. i .. "_" .. newindex] = function( ) showSinglePage( i, newindex ) end
					break
				end
			end
		end
		
		-- show the most recent entry when you open the site
		_G['www_natslife_net'] = function( ) showSinglePage( #p, 1 ) end
	end
end

addEventHandler( "onClientElementDataChange", getResourceRootElement( ),
	function( name )
		if name == "page:natslife.net" then
			buildPages( )
		end
	end
)

addEventHandler( "onClientResourceStart", getResourceRootElement( ), 
	function( )
		buildPages( )
	end
)