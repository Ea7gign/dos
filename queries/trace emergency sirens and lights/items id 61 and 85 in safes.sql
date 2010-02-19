select interiors.id,characters.charactername,items.`index`,items.itemID from interiors  
join items on interiors.id=items.owner 
left join characters on interiors.owner=characters.id 
where (items.itemID=61 or items.ItemID=85) 
and characters.faction_id != 1 
and characters.faction_id != 2 
and characters.faction_id != 3 
and items.type=4 
order by characters.`charactername` asc
