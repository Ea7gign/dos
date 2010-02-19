select characters.charactername,items.`index`,items.itemID from characters  
join items on characters.id=items.owner 
where (items.itemID=61 or items.ItemID=85) 
and characters.faction_id != 1 
and characters.faction_id != 2 
and characters.faction_id != 3 
and items.type=1 
order by characters.`charactername` asc
