local names =
{
	-- highways etc.
	{ { 786912, 786456, 786503, 852353, 852333, 852169 }, { 852161, 852231, 852221, 786493, 786477, 786745, 786908 }, { 786817 }, { 786818 }, { 786821 }, { 786822 }, { 786823 }, { 852347 }, { 852349 }, { 852351 }, { 852362 }, { 852363 }, { 786819 }, { 852346 }, { 852364 }, name = "Interstate 425 West - Los Santos Expressway" },
	{ { 852176, 852170 }, { 852162, 852168 }, name = "Interstate 425 West - Liberty Tunnel" },
	{ { 327793, 327781, 393270, 327794, 327797, 327773, 327791 }, name = "Interstate 425 West" },
	{ { 1310734, 1310778 }, { 1310813, 1310784 }, name = "Los Santos Tunnel" },
	
	{ { 786718, 1310891, 1311498, 1376621, 1376626, 1376669, 1376725 }, { 1376721, 1376845, 1376650, 1376508, 1376733, 1376609, 1311156, 1310927, 786508 }, { 786828 }, { 1311510 }, { 1311512 }, { 1311513 }, { 1376935 }, { 1376936 }, { 1311511 }, { 1376945 }, { 1376946 }, { 1376947 }, { 1376948 }, { 1376943 }, { 1376939 }, { 1376938 }, { 1376940 }, { 1376941 }, name = "West Broadway" },

	-- Santa Maria Beach
	{ { 786752, 786761, 786777, 786792 }, name = "Beach Rd" },
	{ { 786567, 786705 }, name = "Carnival Rd" },
	{ { 852419, 852405, 786945 }, name = "Verona Beach Blvd" },
	{ { 786944, 786935 }, { 786927, 786918 }, name = "Santa Maria Blvd" },
	
	-- Rodeo
	{ { 852365, -786659, -786824, -786640, 786589, 786524, 1310900, 1310947, -1311009, -1311514, -1311010, -1376395, 1376371, 1376293 }, name = "Rodeo Drive" },
	{ { 786533, -786539, -786826, -786540, -786652, -786825, -786664, 852019 }, name = "Olympic Blvd" },
	{ { 786591, -786561, -1310907, -1311518, -1310906, 1310916 }, name = "Royal St" },
	{ { 786623, -786620, 1310978, 1310977 }, name = "Soho Drive" },
	{ { 1310981, -1310940, 1310949 }, name = "York St" },
	{ { 1311142, 1311148, 786722 }, name = "Curve St" },
	{ { 1311011, -1311052, -1311053, 786680, 786649 }, { 786661, 786668, 786686, -1311055, -1311054, 1311470 }, { 1311514 }, { 786825 }, { 786824 }, name = "Western Ave" },
	{ { 786546, 786609, 1311067, 1376817, 1376814, 1376540, -1376520, -1376914, -1376521, 1376600, 1376601, 1376408, 1442251, 1442226, 1442183 }, { 1376584, 1376585, 1376577, -1376519, -1376913, -1376518, 1376524, 1376835, 1311091, 1310960, 786599, 786542 }, { 786826 }, { 1311518 }, { 1311517 }, { 1376908 }, { 1376907 }, { 1376900 }, { 1376899 }, { 1376898 }, { 1376910 }, { 1376909 }, { 1376912 }, { 1376298 }, { 1376299 }, name = "Pasadena Blvd" },
	
	-- Richman/Mulholland
	{ { 786802, 1311212, 1311446, 1311429 }, name = "Providence St" },
	{ { 1310732, 1311388, 1311416, 1311454, 1376446, 1900740, 1376772 }, { 1376795, 1442262 }, { 1900928, 1900926 }, name = "Rich St" },
	{ { 1311181, 1311175, 1311166 }, name = "Owl St" },
	{ { 1311201, 1311200 }, name = "Owl/Providence St" },
	{ { 1311215, -1311386, 1311120 }, name = "Belmont Drive" },
	{ { 1311117, 1835548 }, name = "Square Rd" },
	{ { 1311500, 1310854, 1311267 }, name = "Tory St" },
	{ { 1311312, 1310860, 1376503 }, name = "McCain St" },
	{ { 1376755, 1376764 }, name = "VGB Circle Drive" },
	{ { 1376897, 1900911, 1900867, 1900925 }, name = "Palin St" },
	{ { 1376877, 1376875, 1376735 }, name = "State Rd" },
	
	-- Temple
	{ { 1376389, 1376379 }, { 1376384, 852011 }, { 852380, 852371 }, name = "Giggles St" },
	{ { 1376362, 1376269 }, name = "West Vinewood Blvd" },
	{ { 1376455, 1376458 }, { 1376316, 1376313 }, { 1376382, 1376381 }, { 1376291, 852008 }, { 852391, 852198 }, name = "Liberty Ave" },
	{ { 1376351, 1376352 }, { 1376358, 1376359 }, name = "Penn St" },
	{ { 1376450, 1376336, 1442328, 1441822 }, name = "Sunset Blvd" },
	{ { 1376326, 1376325 }, { 1376342, 1376341 }, name = "Mint St" },
	{ { 1376347, 1376348 }, { 1376346, 1376343 }, name = "Vice St" },
	{ { 1376302, 1376263 }, name = "Holy Cross St" },
	{ { 1376273, 1376272 }, name = "Pawn St" },
	{ { 1376307, 1376306 }, name = "Shine St" },
	
	-- Central Los Santos/Marina
	{ { 852032, 852057, 852195, 917514, 917527 }, name = "Metropolitean Ave" },
	{ { 917533, 917534 }, name = "Church St" },
	{ { 918146, 917641, 918039, 852036 }, { 851986, 852005, 852027, 852020 }, name = "Panopticon Ave" },
	{ { 851997, 851993 }, { 852002, 1376285 }, { 1376281, 1376983 }, name = "Beverly Ave" },
	{ { 1376677, 1376676 }, { 1376694, 1376928, 1376550, 1376573, 852307, 852312 }, { 1376931 }, { 1376932 }, { 852267, 852284, 1376564, 1376558, 1376702 }, { 1376686, 1376685 }, { 1376913 }, { 1376914 }, { 1376920, 1376919 }, { 1376926 }, name = "St. Lawrence Blvd" },
	{ { 1376531, 1376532 }, name = "Light St" },
	{ { 1376262, 1376259 }, name = "Saint St" },
	{ { 1376287, 1376286 }, name = "Hell St" },
	{ { 1376256, 852001 }, name = "Benedict XVI St" },
	{ { 851978, 851979 }, name = "Pius IX St" },
	{ { 852051, 852050 }, name = "Wells St" },
	{ { 852213, 852203 }, name = "Constitution Ave" },
	{ { 917598, 917599 }, name = "Pine St" },
	{ { 917506, 917809 }, { 918067, 918070, 918049, 918052 }, name = "Police Plaza" },
	{ { 851974, 851972 }, { 852062, 917605, 917607 }, { 917541, 917697 }, { 917832, 917684 }, { 852065 }, name = "San Andreas Blvd" },
	{ { 852066, 852067 }, { 852190, 1376469 }, { 1376397, 1376421 }, name = "Central Ave" },
	{ { 1376415, 1376410 }, name = "Elm St" },
	{ { 1376425, 1376424 }, name = "Eye St" },
	
	-- South Los Santos
	{ { 852087, 852403 }, name = "Erp Rd" },
	
	-- East Los Santos
	{ { 1376434, 1441954, 1442387, 1441992, 1442044, 1442257 }, name = "East Vinewood Blvd" },
}

for k, node in ipairs( names ) do
	for _, route in ipairs( node ) do
		if #route == 1 then
			local value = getNodeByID( vehicleNodes, route[1] )
			if value then
				if not value.streetname then
					value.streetname = node.name
				elseif value.streetname ~= node.name then
					--createBlip( value.x, value.y, value.z, 0, 1, 255, 0, 0, 127, 0, 100 )
					--outputChatBox( "F: " .. value.id .. ": " .. value.streetname .. "/" .. node.name)
					value.streetname = value.streetname .. "/" .. node.name
				end
			end
		else
			for i = 1, #route - 1 do
				local path = calculatePathByNodeIDs( math.abs(route[i]), math.abs(route[i+1]) )
				for key, value in ipairs(path) do
					if value.id == -route[i] or value.id == -route[i+1] then
					
					elseif not value.streetname then
						value.streetname = node.name
						--[[if k == #names then
							createBlip( value.x, value.y, value.z, 0, 1, 0, 255, 0, 127, 0, 100 )
						else
							createBlip( value.x, value.y, value.z, 0, 1, 80, 80, 80, 127, 0, 100 )
						end]]
					elseif value.streetname ~= node.name then
						--createBlip( value.x, value.y, value.z, 0, 1, 255, 0, 0, 127, 0, 100 )
						--outputChatBox( route[i] .. ": " .. value.id .. ": " .. value.streetname .. "/" .. node.name)
						value.streetname = value.streetname .. "/" .. node.name
					end
				end
			end
		end
	end
end

--[[

for a, b in pairs( vehicleNodes ) do
	for c, d in pairs( b ) do
		if not d.streetname and d.x > 50 and d.y < -400 then
			createBlip( d.x, d.y, d.z, 0, 1, 255, 255, 0, 127, 0, 100 )
		end
	end
end

]]--

--[[local function cnt(a)
	local b = 0
	for k, v in pairs(a) do
		b = b + 1
	end
	return b
end]]

addEventHandler("onClientRender", getRootElement(),
	function()
		local node = findNodeClosestToPoint(vehicleNodes, getElementPosition(getLocalPlayer()))
		setElementData(getLocalPlayer(), "speedo:street", node.streetname, false) --( node.streetname or "Unknown" ) .. " " .. tostring(node.id) .. " " .. tostring(cnt(node.neighbours)), false)
	end
)