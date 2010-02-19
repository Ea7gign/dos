SELECT 
c1.`charactername`,
' => ',
c2.`charactername`,
' $',
w.`amount`,
' at ',
w.`time`,
' reason: ',w.`reason` 
FROM 
`wiretransfers` w 
LEFT JOIN `characters` c1 on c1.`id` = w.`from` 
LEFT JOIN `characters` c2 on c2.`id`=w.`to` 
WHERE c1.`account` = c2.`account` 
ORDER BY `time` DESC
