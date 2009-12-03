<?php
	if ( $_GET["key"] == NULL){
		header('Location: index.php');
		exit;
	}
?><?php include("config.php"); ?><?php
$key = $_GET["key"];

$conn = mysql_pconnect($mysql_host, $mysql_user, $mysql_pass);

if (!$conn)
{
	setcookie("uid", "", time()-3600);
	setcookie("username", "", time()-3600);
	setcookie("password", "", time()-3600);
	header('Location: index.php?errno=2');
}
		
$escKey = mysql_real_escape_string($key, $conn);

mysql_select_db("mta", $conn);
$result = mysql_query("SELECT keytimestamp FROM forgotdetails WHERE uniquekey='" . $escKey . "' AND DATEDIFF(NOW(), keytimestamp)<1 LIMIT 1", $conn);

if (!$result || mysql_num_rows($result)==0)
{
	setcookie("uid", "", time()-3600);
	setcookie("username", "", time()-3600);
	setcookie("password", "", time()-3600);
	header('Location: index.php?errno=5');
	exit;
}
else
{	
	mysql_query("DELETE FROM forgotdetails WHERE uniquekey='" . $escKey . "'", $conn);
	header('Location: index.php?errno=6');
}