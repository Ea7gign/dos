<?php
	if ( $_GET["key"] == NULL){
		header('Location: index.php');
		exit;
	}
		
	if (isset($_COOKIE["username"]) && isset($_COOKIE["password"]) && isset($_COOKIE["uid"]))
	{
		header('Location: main.php');
		exit;
	}
?><?php
									function generatePassword($length=9, $strength=0) {
										$vowels = 'aeuy';
										$consonants = 'bdghjmnpqrstvz';	if ($strength & 1) {
											$consonants .= 'BDGHJLMNPQRSTVWXZ';
										}
										if ($strength & 2) {
											$vowels .= "AEUY";
										}
										if ($strength & 4) {
											$consonants .= '23456789';
										}
										if ($strength & 8) {
											$consonants .= '@#$%';
										}
									 
										$password = '';
										$alt = time() % 2;
										for ($i = 0; $i < $length; $i++) {
											if ($alt == 1) {
												$password .= $consonants[(rand() % strlen($consonants))];
												$alt = 0;
											} else {
												$password .= $vowels[(rand() % strlen($vowels))];
												$alt = 1;
											}
										}
										return $password;
									} ?><?php include("config.php"); ?><?php

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
$result = mysql_query("SELECT account, keytimestamp FROM forgotdetails WHERE uniquekey='" . $escKey . "' AND DATEDIFF(NOW(), keytimestamp)<1 LIMIT 1", $conn);

if (!$result || mysql_num_rows($result)==0)
{
	setcookie("uid", "", time()-3600);
	setcookie("username", "", time()-3600);
	setcookie("password", "", time()-3600);
	header('Location: index.php?errno=5');
	exit;
}
else // send them a mail with the new username and password
{
	$account = mysql_result($result, 0, 0);
	
	mysql_query("DELETE FROM forgotdetails WHERE uniquekey='" . $escKey . "'", $conn);
	$result = mysql_query("SELECT username, email FROM accounts WHERE id='" . $account . "' LIMIT 1", $conn);
	
	$username = mysql_result($result, 0, 0);
	$email = mysql_result($result, 0, 1);
	
	$password = generatePassword(9, 4);
	$query = mysql_query("UPDATE accounts SET password='" . md5("vgrpkeyscotland" . $password) . "' WHERE id='" . $account . "'", $conn);
	
	// send mail
			$to      = $email;
			$subject = 'ValhallaGaming MTA - Forgot Details';
			
			$message = "Hello " . $username . "\n\n
			Your username is '" . $username . "' and your new password is '" . $password . "'.
			\n\n
				Thank you for playing on Valhalla MTA.
						";
			$headers = 'From: noreply@valhallagaming.net' . "\r\n" .
				'Reply-To: noreply@valhallagaming.net' . "\r\n" .
				'X-Mailer: PHP/' . phpversion();
				
			mail($to, $subject, $message, $headers);
			
			header('Location: index.php?errno=7');
}