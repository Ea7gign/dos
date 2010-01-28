local function returnPosts( result, ... )
	if result ~= "ERROR" then
		result = { result, ... }
		local pages = { }
		for key, value in pairs( result ) do
			pages[ key ] =
			{
				title = value.post_title,
				content = value.post_content,
				date = value.post_date_gmt
			}
		end
		setElementData( getResourceRootElement(), "page:natslife.net", pages )
	end
end

addEventHandler( "onResourceStart", getResourceRootElement( ),
	function( )
		callRemote( "http://natslife.net/pda.php", returnPosts )
	end
)