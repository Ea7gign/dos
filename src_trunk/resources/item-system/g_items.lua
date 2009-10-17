g_items = {
	-- name, description, category, model, rx, ry, rz, zoffset
	
	-- categories:
	-- 1 = Food & Drink
	-- 2 = Keys
	-- 3 = Drugs
	-- 4 = Other
	-- 5 = Books
	-- 6 = Clothing & Accessories
	-- 7 = Electronics
	{ "Haggis", "A plump haggis animal, straight from the hills of Scotland.", 1, 2215, 205, 205, 0, 0.2 },
	{ "Cellphone", "A sleek cellphone, look's like a new one too.", 7, 330, 90, 90, 0, 0.3 },
	{ "Vehicle Key", "A vehicle key with a small manufacturers badge on it. (( Opens vehicle ##v ))", 2, 1581, 270, 270, 0, 0.3 },
	{ "House Key", "A green house key.", 2, 1581, 270, 270, 0, 0.3 },
	{ "Business Key", "A blue business key.", 2, 1581, 270, 270, 0, 0.3 },
	{ "Radio", "A black radio.", 7, 330, 90, 90, 0, 0.3  },
	{ "Phonebook", "A torn phonebook.", 5, 2824, 0, 0, 0, 0.3 },
	{ "Sandwich", "A yummy sandwich with cheese.", 1, 2355, 205, 205, 0, 0.2 },
	{ "Softdrink", "A can of Sprunk.", 1, 2647, 0, 0, 0, 0.2 },
	{ "Dice", "A red dice with white dots.", 4, 1271, 0, 0, 0, 0 }, 
	{ "Taco", "A greasy mexican taco.", 1, 2215, 205, 205, 0, 0.2 },
	{ "Burger", "A double cheeseburger with bacon.", 1, 2703, 265, 0, 0, 0.25 },
	{ "Donut", "Hot sticky sugar covered donut.", 1, 2222, 0, 0, 0, 0.2 },
	{ "Cookie", "A luxury chocolate chip cookie.", 1, 2222, 0, 0, 0, 0.2 },
	{ "Water", "A bottle of mineral water.", 1, 1484, -15, 30, 0, 0.1 },
	{ "Clothes", "A set of clean clothes. (( Skin ID ##v ))", 6, 2386, 0, 0, 0, 0.2 },
	{ "Watch", "A smart gold watch.", 6, 2386, 0, 0, 0, 0.2 },
	{ "City Guide", "A small city guide booklet.", 5, 2824, 0, 0, 0, 0.3 },
	{ "MP3 Player", "A white, sleek looking MP3 Player. The brand reads EyePod.", 7, 2886, 270, 0, 0, 0.3 },
	{ "Standard Fighting for Dummies", "A book on how to do standard fighting.", 5, 1271, 2824, 0, 0, 0, 0.3 },
	{ "Boxing for Dummies", "A book on how to do boxing.", 5, 1271, 2824, 0, 0, 0, 0.3 },
	{ "Kung Fu for Dummies", "A book on how to do kung fu.", 5, 1271, 2824, 0, 0, 0, 0.3 },
	{ "Knee Head Fighting for Dummies", "A book on how to do grab kick fighting.", 5, 1271, 2824, 0, 0, 0, 0.3 },
	{ "Grab Kick Fighting for Dummies", "A book on how to do elbow fighting.", 5, 1271, 2824, 0, 0, 0, 0.3 },
	{ "Elbow Fighting for Dummies", "A book on how to do elbow fighting.", 5, 1271, 2824, 0, 0, 0, 0.3 },
	{ "Gas Mask", "A black gas mask, blocks out the effects of gas and flashbangs.", 6, 2386, 0, 0, 0, 0.2 },
	{ "Flashbang", "A small grenade canister with FB written on the side.", 4, 343, 0, 0, 0, 0.3 },
	{ "Glowstick", "A green glowstick.", 4, 343, 0, 0, 0, 0.3 },
	{ "Door Ram", "A red metal door ram.", 4, 1587, 90, 0, 0, 0.2 },
	{ "Cannabis Sativa", "Cannabis Sativa, when mixed can create some strong drugs.", 3, 1279, 0, 0, 0, 0.3 },
	{ "Cocaine Alkaloid", "Cocaine Alkaloid, when mixed can create some strong drugs.", 3, 1279, 0, 0, 0, 0.3 },
	{ "Lysergic Acid", "Lysergic Acid, when mixed can create some strong drugs.", 3, 1279, 0, 0, 0, 0.3 },
	{ "Unprocessed PCP", "Unprocessed PCP, when mixed can create some strong drugs.", 3, 1279, 0, 0, 0, 0.3 },
	{ "Cocaine", "1g of cocaine.", 3, 1575, 0, 0, 0, 0.32 },
	{ "Drug 2", "A marijuana joint laced in cocaine.", 3, 1576, 0, 0, 0, 0.32 },
	{ "Drug 3", "50mg of cocaine laced in lysergic acid.", 3, 1578, 0, 0, 0, 0.32 },
	{ "Drug 4", "50mg of cocaine laced in phencyclidine.", 3, 1579, 0, 0, 0, 0.32 },
	{ "Marijuana", "A marijuana joint.", 3, 3044, 0, 0, 0, 0.32 },
	{ "Drug 6", "A marijuana joint laced in lysergic acid.", 3, 1580, 0, 0, 0, 0.32 },
	{ "Angel Dust", "A marijuana joint laced in phencyclidine.", 3, 1575, 0, 0, 0, 0.32 },
	{ "LSD", "80 micrograms of LSD.", 3, 1576, 0, 0, 0, 0.32 },
	{ "Drug 9", "100milligrams of yellow liquid.", 3, 1577, 0, 0, 0, 0.32 },
	{ "PCP Hydrochloride", "10mg of phencyclidine powder.", 3, 1578, 0, 0, 0, 0.32 },
	{ "Chemistry Set", "A small chemistry set.", 4, 1210, 90, 0, 0, 0.2 },
	{ "Handcuffs", "A pair of metal handcuffs.", 4, 2386, 0, 0, 0, 0.2 },
	{ "Rope", "A long rope.", 4, 1271, 0, 0, 0, 0.0 },
	{ "Handcuff Keys", "A small pair of handcuff keys.", 4, 2386, 0, 0, 0, 0.2 },
	{ "Backpack", "A reasonably sized backpack.", 4, 3026, 270, 0, 0, 0.3 },
	{ "Fishing Rod", "A 7 foot carbon steel fishing rod.", 4, 338, 80, 0, 0, 0.32 },
	{ "Los Santos Highway Code", "The Los Santos Highway Code.", 5, 2824, 0, 0, 0, 0.3 },
	{ "Chemistry 101",  "An Introduction to Useful Chemistry.", 5, 2824, 0, 0, 0, 0.3 },
	{ "Police Officer's Manual", "The Police Officer's Manual.", 5, 2824, 0, 0, 0, 0.3 },
	{ "Breathalizer", "A small black breathalizer.", 4, 1271, 0, 0, 0, 0.0 },
	{ "Ghettoblaster", "A black Ghettoblaster.", 7, 2226, 0, 0, 0, 0.3 },
	{ "Business Card", "Steven Pullman - L.V. Freight Depot, Tel: ((/081016))", 4, 1581, 270, 270, 0, 0.3 },
	{ "Ski Mask", "A Ski mask.", 6, 2386, 0, 0, 0, 0.2 },
	{ "Fuel Can", "A small metal fuel canister.", 4, 1517, 0, 0, 0, 0.15 },
	{ "Ziebrand Beer", "The finest beer, imported from Holland.", 1, 1520, 0, 0, 0, 0.25 },
	{ "Mudkip", "So i herd u liek mudkips? mabako's Favorite.", 1, 1579, 0, 0, 0, 0.32 },
	{ "Safe",  "A safe to store your items in.", 4, 2332, 0, 0, 0, 0.0 },
	{ "Emergency Light Becon", "An Emergency Light Becon which you can put on you car.", 7, 2886, 270, 0, 0, 0.3  },
	{ "Bastradov Vodka", "For your best friends - Bastradov Vodka.", 1, 1512, 0, 0, 0, 0.15 },
	{ "Scottish Whiskey", "The Best Scottish Whiskey, now exclusively made from Haggis.", 1, 1512, 0, 0, 0, 0.15 },
	{ "LSPD Badge", "A Los Santos Police Department badge.", 4, 1581, 270, 270, 0, 0.3 },
	{ "LSES Identification", "An Los Santos Emergency Service Identification.", 4, 1581, 270, 270, 0, 0.3 },
	{ "Blindfold", "A black blindfold.", 6, 2386, 0, 0, 0, 0.2 },
	{ "GPS", "A GPS Satnav for a car.", 6, 2886, 270, 0, 0, 0.3 },
	{ "Lottery Ticket", "A Los Santos Lottery ticket.", 6, 1581, 270, 270, 0, 0.3 },
	{ "Dictionary", "A Dictionary.", 5, 2824, 0, 0, 0, 0.3 },
	{ "First Aid Kit", "Saves a Life. Can be used #v times.", 4, 1240, 90, 0, 0, 0.25 },
	{ "Notebook", "A small collection of blank papers, useful for writing notes. There are #v pages left. ((/writenote))", 4, 2824, 0, 0, 0, 0.3 },
	{ "Note", "The note reads: #v", 4, 2824, 0, 0, 0, 0.3 },
	{ "Elevator Remote", "A small remote to change an elevator's mode.", 2, 364, 0, 0, 0, 0.25 },
	{ "Bomb", "What could possibly happen when you use this?", 4, 363, 270, 0, 0, 0.22 },
	{ "Bomb Remote", "Has a funny red button.", 4, 364, 0, 0, 0, 0.25 },
	{ "Riot Shield", "A heavy riot shield.", 4, 1631, 90, 0, 0, 0.1 },
	{ "Card Deck", "A card deck to play some games.", 4,2824, 0, 0, 0, 0.3 },
	{ "San Andreas Pilot Certificate", "An official permission to fly planes and helicopters.", 4, 1581, 270, 270, 0, 0.3 },
	{ "Porn Tape", "A porn tape, #v", 4,2824, 0, 0, 0, 0.3 },
	{ "Generic Item", "#v", 4, 1271, 0, 0, 0, 0.3 }
}

function getItemRotInfo(id)
	if not g_items[id] then
		return "?"
	else
		return  g_items[id][5], g_items[id][6], g_items[id][7], g_items[id][8]
	end
end

function getItemName(id)
	if id == -100 then
		return "Body Armor"
	elseif id < 0 then
		return getWeaponNameFromID( -id )
	elseif not g_items[id] then
		return "?"
	else
		return g_items[id][1]
	end
end

function getItemDescription(id)
	return ( g_items[id] or { nil, "?" } )[2]
end

function getItemType(id)
	return ( g_items[id] or { nil, nil, 4 } )[3]
end

function getItemModel(id)
	return ( g_items[id] or { nil, nil, nil, 1271 } )[4]
end
