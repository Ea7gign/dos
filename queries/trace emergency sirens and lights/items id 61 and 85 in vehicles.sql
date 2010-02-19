select vehicles.id,characters.charactername,items.`index`,items.itemID from vehicles  
join items on vehicles.id=items.owner 
left join characters on vehicles.owner=characters.id 
where (items.itemID=61 or items.ItemID=85) 
and characters.faction_id != 1 
and characters.faction_id != 2 
and characters.faction_id != 3 
and items.type=2 
order by characters.`charactername` asc
