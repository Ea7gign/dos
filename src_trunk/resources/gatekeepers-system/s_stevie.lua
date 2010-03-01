mysql = exports.mysql

local phoneState = 0
local doneDeals = getElementData( getRootElement( ), "stevie.done" ) or 0

function timeCheck(res) -- When the resource starts check what time it is. If the time is between 1900 and 2359 spawn stevie in the steak house.
	hour, minutes = getTime()
	
	if (hour>=19) and (hour<=23) then -- If the time is between 1900 and 0000 create Stevie. Start a timer that will remove him at 0000.
		createStevie()
	else -- If the time is not between 1900 and 0000 calculate how many minutes are left start a timer to create stevie  at 1900.
		local minutesLeft = 60 - minutes
		local hoursLeft = 18 - hour
		local spawnTime = (hoursLeft*60) + minutesLeft
		stevieSpawnTimer = setTimer ( createStevie, spawnTime*60000, 1 ) -- spawn stevie at 1900
		outputDebugString("Stevie will spawn in "..spawnTime.." minutes.")			
	end
end
addEventHandler("onResourceStart", getResourceRootElement(), timeCheck)

function createStevie()

	stevie = createPed (258, 2511.6015625, -1680.1962890625, 1049.6678466797)
	exports.pool:allocateElement(stevie)
	setPedRotation (stevie, 90)
	setElementData(stevie, "rotation", getPedRotation(stevie), false)
	setElementInterior (stevie, 3)
	setElementDimension (stevie, 10601)
	setPedFrozen(stevie, true)
	setPedAnimation(stevie, "FOOD", "FF_Sit_Loop",  -1, true, false, true) -- Set the Peds Animation.
	setElementData(stevie, "name", "Steven Pullman")
	setElementData(stevie, "deals", 0) -- reset how many deals he has made today. Stevie will do 5 deals over the phone each day. He can't be called while he is in the game world (19:00-22:00).
	setElementData(stevie,"talk",true) -- allows the player to right click on him.
	doneDeals = 0
	setElementData( getRootElement( ), "stevie.done", 0, false )
	
	hours,minues = getTime()
	
	local minutesLeft = 60 - minutes
	local hoursLeft = 23 - hour
	local removeTime = (hoursLeft*60) + minutesLeft
	stevieRemoveTimer = setTimer ( removeStevie, removeTime*60000, 1 ) -- remove stevie at 2200.
	outputDebugString("Stevie will leave in "..removeTime.." minutes.")
	
end

function removeStevie()
	destroyElement(stevie)
	outputDebugString("Stevie was removed.")
	stevieSpawnTimer = setTimer ( createStevie, 68400000, 1 ) -- spawn stevie at 1900
end

function stevieIntro (thePlayer) -- When player enters the colSphere create GUI with intro output to all local players as local chat.
		
	-- Give the player the "Find Stevie" achievement.
	if(getElementData(stevie, "activeConvo")==1)then
		exports.global:sendLocalText(source, "* Stevie ignores the person trying to talk to him and contiues to eat.",  255, 51, 102, 5)
	else
		exports.logs:logMessage("[STEVIE] " .. getElementData(thePlayer, "gameaccountusername") .. "/".. getPlayerName(thePlayer) .." met Stevie" , 4)
		setElementData (stevie, "activeConvo", 1, false) -- set the NPCs conversation state to active so no one else can begin to talk to him.
		outputDebugString("Stevie is talking.")
		
		exports.global:sendLocalText(source, "Steven Pulman says: Do you want something, pal?", 255, 255, 255, 5) -- Stevies next question
		
		talkingToStevie = source
		addEventHandler("onPlayerQuit", source, resetStevieConvoStateDelayed)
		addEventHandler("onPlayerWasted", source, resetStevieConvoStateDelayed)
	end
end
addEvent( "startStevieConvo", true )
addEventHandler( "startStevieConvo", getRootElement(), stevieIntro )

-- Quick Close
function quickClose_S()
	
	exports.global:removeAnimation(source)
	toggleAllControls(source, true, true, true)
	
	removeElementData (stevie, "activeConvo") -- set the NPCs conversation state to not active so others can begin to talk to him.
	outputDebugString("Stevie is no longer talking.")
	
	local name = string.gsub(getPlayerName(source), "_", " ")
	exports.global:sendLocalText(source, name .." says: No. Sorry to bother you.", 255, 255, 255, 5) -- Stevies next question
end
addEvent( "quickCloseServerEvent", true )
addEventHandler( "quickCloseServerEvent", getRootElement(), quickClose_S )

-- Statement 2
function statement2_S()
	-- Output the text from the last option to all player in radius
	local name = string.gsub(getPlayerName(source), "_", " ")
	exports.global:sendLocalText(source, name .. " says: Can I take a seat?", 255, 255, 255, 5) -- Players response to last question
	exports.global:sendLocalText(source, "Steven Pullman says: Sure, sit down. Have you tried the food here? It's f****** unbelievable.", 255, 255, 255, 5) -- Stevies next question
	
	-- Set players position and anim so they are sitting opposite Stevie. Freeze them so they can't move until they end the conversation
	setElementPosition (source, 2510.71484375, -1680.1376953125, 1049.6678466797)
	setPedRotation (source, 270)
	exports.global:applyAnimation(source, "INT_OFFICE", "OFF_Sit_Watch", -1, false, false, true)
	
end
addEvent( "statement2ServerEvent", true )
addEventHandler( "statement2ServerEvent", getRootElement(), statement2_S )

-- Statement 3
function statement3_S()
	
	exports.global:removeAnimation(source)
	toggleAllControls(source, true, true, true)
	
	resetStevieConvoStateDelayed()
	
	-- Output the text from the last option to all player in radius
	local name = string.gsub(getPlayerName(source), "_", " ")
	exports.global:sendLocalText(source, name .. " says: I'm a vegetarian. The thought of those poor animals suffering for you to stuff your face makes me sick.", 255, 255, 255, 5)
	exports.global:sendLocalText(source, "Steven Pullman says: Hey f*** you, pal. You don't like it, go save a whale or some shit.", 255, 255, 255, 5)
end	
addEvent( "statement3ServerEvent", true )
addEventHandler( "statement3ServerEvent", getRootElement(), statement3_S )

-- statement 4
function statement4_S()
	
	-- Output the text from the last option to all player in radius
	local name = string.gsub(getPlayerName(source), "_", " ")
	exports.global:sendLocalText(source, name .. " says: Yeah I heard it's good. I was just about to order something.", 255, 255, 255, 5)
	exports.global:sendLocalText(source, "Steven Pullman says: Get the Angus rib-eye. You won't regret it. Where's my manners...", 255, 255, 255, 5)
	exports.global:sendLocalText(source, "* Steven Pullman wipes his hands on a napkin and offers "..name.." a hand shake.", 255, 51, 102, 5)
	exports.global:sendLocalText(source, "Steven Pullman says: The name's Stevie.", 255, 255, 255, 5)
end
addEvent( "statement4ServerEvent", true )
addEventHandler( "statement4ServerEvent", getRootElement(), statement4_S )

-- Statement 5
function statement5_S()
	
	exports.global:removeAnimation(source)
	toggleAllControls(source, true, true, true)
	
	resetStevieConvoStateDelayed()
	
	exports.global:sendLocalMeAction( source,"leaves Stevie's hand lingering in the air.")
	-- Output the text from the last option to all player in radius
	exports.global:sendLocalText(source, "Steven Pullman says: I was just being polite but if you want to be an ass about it how about you leave me to eat in peace.", 255, 255, 255, 5)
end	
addEvent( "statement5ServerEvent", true )
addEventHandler( "statement5ServerEvent", getRootElement(), statement5_S )

-- Statement 6
function statement6_S()
	-- Output the text from the last option to all player in radius
	exports.global:sendLocalMeAction(source, "shakes Stevie's hand.")
	exports.global:sendLocalText(source, "Steven Pullman says: Me and the boys from the freight depot come down here every week.", 255, 255, 255, 5)
	exports.global:sendLocalText(source, "Steven Pullman says: Football and steaks make a damn good combination don't you think?", 255, 255, 255, 5)
end
addEvent( "statement6ServerEvent", true )
addEventHandler( "statement6ServerEvent", getRootElement(), statement6_S )

-- Statement 7
function statement7_S()
	
	exports.global:removeAnimation(source)
	toggleAllControls(source, true, true, true)
	
	resetStevieConvoStateDelayed() -- set the NPCs conversation state to not active so others can begin to talk to him.
	
	-- Output the text from the last option to all player in radius
	local name = string.gsub(getPlayerName(source), "_", " ")
	exports.global:sendLocalText(source, name.." says: Are you kidding me? I've been a Beavers fan my whole life!", 255, 255, 255, 5)
	exports.global:sendLocalText(source, "Steven Pullman says: What?! The Beavers?", 255, 255, 255, 5)
	exports.global:sendLocalText(source, "Steven Pullman says: You're lucky I don't punch your lights out right here and now you piece-a beaver scum.", 255, 255, 255, 5)
	exports.global:sendLocalText(source, "Steven Pullman says: Look... now you made me lose my appetite.", 255, 255, 255, 5)
end
addEvent( "statement7ServerEvent", true )
addEventHandler( "statement7ServerEvent", getRootElement(), statement7_S )

-- Statement 8
function statement8_S()
	-- Output the text from the last option to all player in radius
	local name = string.gsub(getPlayerName(source), "_", " ")
	exports.global:sendLocalText(source, name.." says: I never really liked football.", 255, 255, 255, 5)
	exports.global:sendLocalText(source, "Steven Pullman says: Yeah, maybe it isn't to everyone's taste. So what do you do?", 255, 255, 255, 5)
end
addEvent( "statement8ServerEvent", true )
addEventHandler( "statement8ServerEvent", getRootElement(), statement8_S )

-- Statement 9
function statement9_S()
	exports.global:removeAnimation(source)
	toggleAllControls(source, true, true, true)
	
	-- Output the text from the last option to all player in radius
	local name = string.gsub(getPlayerName(source), "_", " ")
	exports.global:sendLocalText(source, name.." says: Over worked and underappreciated. You know how it is.", 255, 255, 255, 5)
	exports.global:sendLocalText(source, "Steven Pullman says: Tell me about it! They got me bustin' my ass at the freight yard for change.", 255, 255, 255, 5)
	exports.global:sendLocalText(source, "Steven Pullman says: See it's people like you and me that need to help each other out.", 255, 255, 255, 5)
	exports.global:sendLocalText(source, "Steven Pullman says: Tell you what, here's my card. You ever need anything I can help you out with, just give me a call.", 255, 255, 255, 5)
end
addEvent( "statement9ServerEvent", true )
addEventHandler( "statement9ServerEvent", getRootElement(), statement9_S )

-- Success
function stevieSuccess_S()
	
	exports.global:removeAnimation(source)
	
	resetStevieConvoStateDelayed() -- set the NPCs conversation state to not active so others can begin to talk to him.
	
	exports.global:sendLocalMeAction( source,"takes Stevie's business card.")
	
	-- Give the player an item. Name = "Business card"  Description = "Steven Pullman, L.V. Freight Depot, Tel: 12555"
	exports.global:giveItem(source, 55, 1) -- change the ID.
	
	-- set the players "stevie" stat to "1" meaning they have met him and successfully made it through the conversation.
	mysql:query_free("UPDATE characters SET stevie='1' WHERE charactername='" .. mysql:escape_string(getPlayerName(source)) .. "' LIMIT 1") -- NOT WORKING
	exports.logs:logMessage("[STEVIE] " .. getElementData(thePlayer, "gameaccountusername") .. "/".. getPlayerName(thePlayer) .." got Stevie' his businesscard" , 4)
end
addEvent( "stevieSuccessServerEvent", true )
addEventHandler( "stevieSuccessServerEvent", getRootElement(), stevieSuccess_S )

-- Close Button
function CloseButtonClick_S()
	
	exports.global:removeAnimation(source)
	toggleAllControls(source, true, true, true)
	
	resetStevieConvoStateDelayed() -- set the NPCs conversation state to not active so others can begin to talk to him.
	
	-- Output the text from the last option to all player in radius
	local name = string.gsub(getPlayerName(source), "_", " ")
	exports.global:sendLocalText(source, name .. " says: Is that the time? I have to go.", 255, 255, 255, 5)
	exports.global:sendLocalText(source, "Steven Pullman says: You take it easy. Maybe I'll run into you again some time.", 255, 255, 255, 5)
end
addEvent( "CloseButtonClickServerEvent", true )
addEventHandler( "CloseButtonClickServerEvent", getRootElement(), CloseButtonClick_S )

function resetStevieConvoState()
	setElementData(stevie,"activeConvo", 0, false)
end


function resetStevieConvoStateDelayed()
	if talkingToStevie then
		removeEventHandler("onPlayerQuit", talkingToStevie, resetStevieConvoStateDelayed)
		removeEventHandler("onPlayerWasted", talkingToStevie, resetStevieConvoStateDelayed)
		talkingToStevie = nil
	end
	setTimer(resetStevieConvoState, 360000, 1)
end

------------------------------------------------------------------------------------
------------------------------ telephone conversation ------------------------------
------------------------------------------------------------------------------------

function startPhoneCall(thePlayer)
	if not(exports.global:hasItem(thePlayer, 2)) then -- does the player have a cell phone?
		outputChatBox("You need a cellphone to call someone.", thePlayer, 255, 0, 0)
	else
		local calling = getElementData(thePlayer, "calling")
		if (calling) then -- Using phone already.
			outputChatBox("You are already using your phone.", thePlayer, 255, 0, 0)
		else
			if not exports.global:isPlayerSilverDonator(thePlayer) and not exports.global:hasMoney(thePlayer, 10) then
				outputChatBox("You cannot afford a call.", thePlayer, 255, 0, 0)
			else
				if(stevie)then -- If stevie is currently spawned (i.e., if it's between 1900 and 2200).   -- disabled while testing.
					outputChatBox("The phone you are trying to call is switched off.", thePlayer, 255, 0, 0)
				else
					if (phoneState==1) then -- is someone already speaking to stevie?
						outputChatBox("The number you are trying to call is engaged.", thePlayer, 255, 0, 0)
					else
						phoneState = 1
						setElementData(thePlayer, "calling", "stevie")
						exports.global:sendLocalMeAction(thePlayer, "takes out a cell phone.")
						exports.global:applyAnimation(thePlayer, "ped", "phone_in", 3000, false)
						toggleAllControls(thePlayer, true, true, true)
						setTimer(startPhoneAnim, 3050, 2, thePlayer)
						-- are they a friend?
						local query = mysql:query_fetch_assoc("SELECT stevie, faction_leader FROM characters WHERE charactername='" .. mysql:escape_string(getPlayerName(thePlayer)) .."'")
						local steviesFriend = tonumber(query["stevie"])
						local factionLeader = tonumber(query["faction_leader"])
						
						-- are they in law enforcement?
						local theTeam = getPlayerTeam(thePlayer)
						local factionType = getElementData(theTeam, "type")
						
						if not(steviesFriend==1) or (factionType==4) or (factionType==2) or (factionType==3) then
							setTimer( endCall, 6000, 1, thePlayer)
							outputChatBox("#12555 [Cellphone]: Yeah?", thePlayer)
							setTimer(outputChatBox, 3000, 1, "#12555 [Cellphone]: How did you get this number? ", thePlayer)
							setTimer(outputChatBox, 6000, 1, "#12555 [Cellphone]: Sorry you must have the wrong number, pal.", thePlayer)
							setTimer(outputChatBox, 6000, 1, "They hung up.", thePlayer)
							phoneState = 0
						else
							if(doneDeals >= 5) then
								triggerClientEvent ( thePlayer, "outOfDeals", getRootElement() ) -- Trigger Client side function to create GUI.
							elseif stevieMarker then
								outputChatBox("((Steven Pullman)) #12555 [Cellphone]: Just a bad time - call later.", thePlayer)
								endCall()
							else
								triggerClientEvent ( thePlayer, "showPhoneConvo", getRootElement(), factionLeader ) -- Trigger Client side function to create GUI.
								addEventHandler ( "onPlayerQuit", thePlayer, endCall )
								exports.logs:logMessage("[STEVIE] " .. getElementData(thePlayer, "gameaccountusername") .. "/".. getPlayerName(thePlayer) .." called Stevie" , 4)
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler ( "12555", startPhoneCall )

function startPhoneAnim() -- taken from phone res.
	exports.global:applyAnimation(source, "ped", "phone_talk", -1, true, true, true)
end

-------------------------
-- Declining phone deal. --
-------------------------
function declineDeal_S ()
	
	-- Output the text from the last option to all player in radius
	local name = string.gsub(getPlayerName(source), "_", " ")
	exports.global:sendLocalText(source, name.. " says: Maybe another time.", 255, 255, 255, 10)
	outputChatBox("((Steven Pullman)) #12555 [Cellphone]: Sure thing.", source)
	
	endCall()
	
end
addEvent( "declineSteviePhoneDeal", true )
addEventHandler( "declineSteviePhoneDeal", getRootElement(), declineDeal_S )

------------------------------
-- Accepting phone deal --
------------------------------

-- The item spawn locations. Stack the items 3 high to give 15 items in total.
locations = {
	{ 2781.3776, -2531.0056, 13.3160 },
	{ 2269.4335, -2535.6457, 8.3108 },
	{ -159.9091, -290.0009, 3.5817 },
	{ -2258.0092, 2383.6354, 4.6420 },
	{ -1815.1345, -75.5974, 14.7400  }
}

function acceptDeal_S( dealNumber )
	
	if(dealNumber==1)then -- work out the cost of the selected deal.
		cost = 7500
	elseif(dealNumber==2)then
		cost = 1000
	elseif(dealNumber==3)then
		cost = 15000
	elseif(dealNumber==4)then
		cost = 3000
	elseif(dealNumber==5) then
		cost = 2000
	end
	
	if not exports.global:takeMoney(source, cost) then -- can the player afford the deal?
		outputChatBox("((Steven Pullman)) #12555 [Cellphone]: Call me when you've got some money.", source)
		outputChatBox("You can't afford to pay Stevie for the deal.", source, 255, 0, 0)
		endCall()
	elseif stevieMarker then
		outputChatBox("((Steven Pullman)) #12555 [Cellphone]: Just a bad time - call later.", source)
		endCall()
	else
		-- just some check to make sure the table has that value, i.e. deals are accepted (shouldn't happen, just in case)
		if not locations[doneDeals+1] then
			return
		end
		doneDeals = doneDeals + 1
		setElementData( getRootElement( ), "stevie.done", doneDeals, false )
		exports.logs:logMessage("[STEVIE-CALL] " .. getElementData(source, "gameaccountusername") .. "/".. getPlayerName(source) .." accepted deal no " .. dealNumber .. " for ".. cost , 4)
		outputChatBox("You have sent Stevie $".. cost .." for the deal.", source, 0, 255, 0)
		
		local x, y, z = locations[doneDeals][1], locations[doneDeals][2], locations[doneDeals][3]
		
		triggerClientEvent(source, "addStevieBlip", source, x, y, z)
		stevieMarker = createMarker(x, y, z, "cylinder", 2, 255, 127, 255, 150)
		stevieCol = createColSphere(x, y, z, 2)
			
		exports.pool:allocateElement(stevieMarker)
		exports.pool:allocateElement(stevieCol)
			
		setElementData(stevieCol, "dealNumber", dealNumber, false)
		setElementData(source, "stevie.money", cost, false)
	
		addEventHandler("onColShapeHit", stevieCol, giveGoods)		
		endCall() -- end the call.
	end
end
addEvent( "acceptSteviePhoneDeal", true )
addEventHandler( "acceptSteviePhoneDeal", getRootElement(), acceptDeal_S )

function decreaseDeals_S()
	if getElementData(source, "stevie.money") and doneDeals > 0 then
		doneDeals = doneDeals - 1
		setElementData( getRootElement( ), "stevie.done", doneDeals, false )
		
		destroyElement(stevieCol)
		stevieCol = nil
		destroyElement(stevieMarker)
		stevieMarker = nil
	end
end
addEventHandler( "onPlayerQuit", getRootElement(), decreaseDeals_S )
addEventHandler( "savePlayer", getRootElement(),
	function( reason )
		if reason == "Change Character" then
			decreaseDeals_S( )
			setTimer( removeElementData, 500, 1, source, "stevie.money" )
		end
	end
)
-- { isWeapon, item/weapon ID, Value/Ammo }
deals = { 
	{ 
		{ true, 23, 60 },	-- silenced pistol
		{ true, 25, 30 },	-- shotgun
		{ true, 28, 150 },	-- Uzi
		{ true, 32, 150 },	-- tec 9
		{ true, 23, 100 },	-- silenced pistol
		{ true, 25, 20 },	-- shotgun
		{ true, 28, 100 },	-- Uzi
		{ true, 32, 100 },	-- tec 9
	},
	{
		{ false, 19, 1 },	-- MP3
		{ false, 54, 1 },	-- Ghettoblaster
		{ false, 6, 1 },	-- radio
		{ false, 2, 1 },	-- cellphone
		{ false, 88, 1 },	-- Earpiece
		{ false, 67, 1 },	-- GPS
	},
	{ -- MAFIA GUN DEAL
		{ true, 30, 100 },	-- AK47
		{ false, 6, 1 },	-- radio
		{ false, 88, 1 },	-- Earpiece
		{ false, 6, 1 },	-- radio
		{ false, 88, 1 },	-- Earpiece
		{ true, 34, 5 },	-- Sniper rifle
		-- { true, 16, 6 },	-- grenade
		-- { true, 39, 4 },	-- satchel
		{ false, 16, 287 },	-- uniform
		{ true, 29, 100 },	-- MP5
		{ true, 31, 80 },	-- M4
		{ true, 29, 70 },	-- MP5
		{ true, 31, 30 },	-- M4
		{ true, 17, 4 },	-- teargas
		{ true, 17, 3 }		-- teargas
	},
	{ -- MAFIA DRUG DEAL
		{ false, 32, 1 },		-- Lysergic acid
		{ false, 31, 1 },		-- Cocaine Alcaloid
	},
	{ -- GANG DRUG DEAL
		{ false, 32, 1 },		-- Lysergic acid
		{ false, 33, 1 },		-- PCP
		{ false, 31, 1 },		-- Cocaine Alcaloid
	}
}

function giveGoods(thePlayer)
	if getElementType(thePlayer) ~= 'player' then
		return
	end
	local veh = getPedOccupiedVehicle(thePlayer)
	if not(veh)then
		outputChatBox("You'll need a vehicle to carry all these items.", thePlayer, 255, 0, 0)
	elseif not exports.global:hasSpaceForItem(veh) then
		outputChatBox("There isn't any space in that vehicle left.", thePlayer, 255, 0, 0)
	else
		local deal = getElementData(source, "dealNumber")
		
		destroyElement(stevieCol)
		stevieCol = nil
		triggerClientEvent(thePlayer, "removeStevieBlip", thePlayer)
		
		-- give the player the items.
		giveItemsTimer = setTimer(givePlayerStevieItems, 2000, exports['item-system']:getInventorySlots(veh) - #exports['item-system']:getItems(veh), thePlayer, veh, deal)
		stopItemsTimer = setTimer(stopPlayerStevieItems, ( exports['item-system']:getInventorySlots(veh) - #exports['item-system']:getItems(veh) + 1 ) * 2000, 1, thePlayer)
		exports.global:sendLocalMeAction(thePlayer,"loads the car up with packages.")
		outputChatBox("((Wait while the vehicle is loaded with the items.))", thePlayer)
		local x,y,z = getElementPosition(veh)
		collectionCol = createColSphere(x, y, z, 5)
		removeElementData(thePlayer, "stevie.money")
		exports.logs:logMessage("[STEVIE] " .. getElementData(thePlayer, "gameaccountusername") .. "/".. getPlayerName(thePlayer) .." starts loading stuff from deal no " .. deal , 4)
	end
end

function givePlayerStevieItems(thePlayer, veh, deal)
	if not(isElementWithinColShape(veh, collectionCol)) then
		outputChatBox("You didn't wait to load the vehicle!", thePlayer, 255, 0, 0)
		if giveItemsTimer then
			killTimer(giveItemsTimer)
			giveItemsTimer = nil
		end
		if stopItemsTimer then
			killTimer(stopItemsTimer)
			stopItemsTimer = nil
		end
		destroyElement(stevieMarker)
		stevieMarker = nil
	else
		if not(exports.global:hasSpaceForItem(veh))then
			outputChatBox("The vehicle is full.", thePlayer, 255, 0, 0)
			destroyElement(collectionCol)
			collectionCol = nil
			if giveItemsTimer then
				killTimer(giveItemsTimer)
				giveItemsTimer = nil
			end
			if stopItemsTimer then
				killTimer(stopItemsTimer)
				stopItemsTimer = nil
			end
			destroyElement(stevieMarker)
			stevieMarker = nil
		else
			local deal = deals[deal]
			local rand = math.random(1,#deal) -- select a random item to give the player.
			
			local isWeapon = deal[rand][1]
			local itemID = deal[rand][2]
			local value = deal[rand][3]
			if(isWeapon==true)then
				exports.global:giveItem(veh, -itemID, value)
			else
				exports.global:giveItem(veh, itemID, value)
			end
		end
	end
end

function stopPlayerStevieItems(thePlayer)
	outputChatBox("The vehicle is full.", thePlayer, 255, 0, 0)
	destroyElement(stevieMarker)
	stevieMarker = nil
end

---------------------
-- ending the call --
---------------------
function endCall(thePlayer) -- to cancel the phone animation and reset the phone states.
	if not thePlayer or not isElement(thePlayer) or getElementType(thePlayer) ~= "player" then
		thePlayer = source
	end
	exports.global:removeAnimation(thePlayer)
	toggleAllControls(thePlayer, true, true, true)
	removeElementData(thePlayer, "calling")
	if not exports.global:isPlayerSilverDonator(thePlayer) then
		exports.global:takeMoney(thePlayer, 10, true)
	end
	phoneState = 0
	removeEventHandler ( "onPlayerQuit", thePlayer, endCall )
end
