<?php
	ob_start();
	if (!isset($_COOKIE["username"]) || !isset($_COOKIE["password"]) || !isset($_COOKIE["uid"]))
	{
		header('Location: index.php');
		exit;
	}
	
	include("config.php");
	
	$conn = mysql_pconnect($mysql_host, $mysql_user, $mysql_pass);
	$userid = mysql_real_escape_string($_COOKIE["uid"], $conn);
	
	mysql_select_db("mta", $conn);
	$result = mysql_query("SELECT username, admin, donator, appstate, apphandler, appreason, banned, email, appdatetime > NOW(), HOUR(TIMEDIFF(NOW(), appdatetime)), MINUTE(TIMEDIFF(NOW(), appdatetime)), overseer, banned_reason FROM accounts WHERE id='" . $userid . "' LIMIT 1", $conn);
	$result2 = mysql_query("SELECT count(*) FROM accounts WHERE banned = 1 AND (banned_reason LIKE '%cheat%' OR banned_reason LIKE '%hack%')", $conn);
	$result3 = mysql_query("SELECT count(*) FROM accounts WHERE banned = 0 AND (banned_reason LIKE '%cheat%' OR banned_reason LIKE '%hack%')", $conn);
	
	if (!$result || mysql_num_rows($result)==0)
	{
		setcookie("uid", "", time()-3600);
		setcookie("username", "", time()-3600);
		setcookie("password", "", time()-3600);		
		header('Location: index.php');
		exit;
	}
	$username = mysql_result($result, 0, 0);
	$admin = mysql_result($result, 0, 1);
	$donator = mysql_result($result, 0, 2);
	$appstate = mysql_result($result, 0, 3);
	$apphandler = mysql_result($result, 0, 4);
	$appreason = mysql_result($result, 0, 5);
	$banned = mysql_result($result, 0, 6);
	$email = mysql_result($result, 0, 7);
	$noapply = mysql_result($result, 0, 8);
	$timehour = mysql_result($result, 0, 9);
	$timeminute = mysql_result($result, 0, 10);
	$overseer = mysql_result($result, 0, 11);
	
	$globalbans = mysql_result($result2, 0, 0);
	$falsepos = mysql_result($result3, 0, 0);
	$bannedreason = mysql_result($result, 0, 12);
	
	if ((strpos($bannedreason, "hack") || strpos($bannedreason, "cheat")) && $banned == 1)
		$vacbanned = 1;
	else
		$vacbanned = 0;
	
	if ( is_null($email))
		$email = "None."
?>

<?php 
	function getAdminTitleFromIndex($index)
	{
		$ranks = array("No", "Trial Admin", "Administrator", "Super Admin", "Lead Admin", "Head Admin", "Owner");
		return $ranks[$index];
	}
	
	function getDonatorTitleFromIndex($index)
	{
		$ranks = array("No", "Bronze" ,"Silver", "Gold", "Platinum", "Pearl", "Diamond", "Godly");
		return $ranks[$index];
	}
	
	function getStandingFromIndex($index)
	{
		$ranks = array("<em><font color='#66FF00'>In Good Standing</font></em>", "<em><font color='#FF0000'>Banned</font></em>");
		return $ranks[$index];
	}
	
	function getVACStandingFromIndex($index)
	{
		$ranks = array("<em><font color='#66FF00'>In Good Standing</font></em>", "<em><font color='#FF0000'>VAC Banned</font></em>");
		return $ranks[$index];
	}
?>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

	<title>Valhalla Gaming: Multi Theft Auto</title>
	<meta name="description" content="Website of the Valhalla Gaming Multi Theft Auto role play server." />
	<meta name="keywords" content="GTA, multi, grand, theft, auto, san, andreas, multiplayer, player, CJ, Carl, Johnson, Role, Play, RP, SAMP, IV, MTA, valhalla, gaming, vg"/>
	<meta name="author" content="Chamberlain" />
	<meta name="copyright" content="Valhalla Gaming" />
	
	<link href="css/styles.css" rel="stylesheet" type="text/css" />
	<link rel="shortcut icon" href="images/favicon.ico" />
	
	<script type="text/javascript">
		//<![CDATA[
		AC_FL_RunContent = 0;
		//]]>
	</script>
	<script src="AC_RunActiveContent.js" type="text/javascript"></script>
	
</head>

<body>

		<div id="vg-banner-background">
			<div id="vg-banner">
				<div id="vglogo"></div>
				<div class="vgLink"><a href="http://www.valhallagaming.net/forums/forumdisplay.php?f=110">San Andreas Multiplayer</a></div>
				<div class="vgLink"><a href="http://www.valhallagaming.net/site/mta/">Multi Theft Auto</a></div>
				<div class="vgLink"><a href="http://www.valhallagaming.net/forums/forumdisplay.php?f=216">Battlefield</a></div>
				<div class="vgLink"><a href="http://www.valhallagaming.net/forums/forumdisplay.php?f=503">Call of Duty</a></div>
				<div class="vgLink"><a href="http://www.valhallagaming.net/forums/forumdisplay.php?f=339">World of Warcraft</a></div>
				<div class="vgLink"><a href="http://www.valhallagaming.net/forums/forumdisplay.php?f=408">Steam Games</a></div>
			</div>
		</div>
			
		<div id="wrapper">
			<div id="header"></div>
			<div id="banner">
				<script type="text/javascript">
					//<![CDATA[
						if (AC_FL_RunContent == 0) {
							alert("This page requires AC_RunActiveContent.js.");
						} else {
							AC_FL_RunContent(
								'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0',
								'width', '1065',
								'height', '252',
								'src', 'preloader',
								'quality', 'high',
								'pluginspage', 'http://www.macromedia.com/go/getflashplayer',
								'align', 'middle',
								'play', 'true',
								'loop', 'false',
								'scale', 'showall',
								'wmode', 'window',
								'devicefont', 'false',
								'id', 'preloader',
								'bgcolor', '#000000',
								'name', 'preloader',
								'menu', 'false',
								'allowFullScreen', 'false',
								'allowScriptAccess','sameDomain',
								'movie', 'preloader',
								'salign', ''
							); //end AC code
						}
					//]]>
				</script>
			</div>
				
			<div id="navigation">
				<div class="nav-links"><a href="main.php">HOME</a></div>
				
				<div class="nav-links-right"><a href="logout.php">LOG OUT</a></div>
				<div class="nav-links-right">Welcome, <font color="#FF6600"><?php echo $username ?></font></div>
			</div>
			
			<div id="content">
				<!-- Column -->
				<div id="content-right">
					<div class="content-box">
						<div class="side-content-holder">
							<div style="margin-left:-30px;padding-top:10px;"><img src="images/serverinfo-title.png"/></div>
							<p>MTA Server IP: <span style="color:#FF6600;"><a href="mtasa://87.238.173.138:22003/">87.238.173.138:22003</a></span></p>
							<p>Ventrilo IP: <span style="color:#FF6600;">72.37.247.172:3797</span></p>														
						</div>
					</div>
					<div class="content-box">
						<div class="side-content-holder">
							<div style="margin-left:-30px;padding-top:10px;"><img src="images/donations-title.png"/></div>
							<p>Your donations go directly towards paying expenses relating to the upkeep of the Valhalla Gaming servers.</p>
							<h4><a href="http://www.valhallagaming.net/forums/showthread.php?t=32994">Donation Info</a></h4>
							<h4><a href="http://www.valhallagaming.net/forums/misc.php?do=donate">Donate Now</a></h4>
						</div>
					</div>
					<div class="content-box">
						<div class="side-content-holder">
							<div style="margin-left:-30px;padding-top:10px;"><img src="images/links-title.png"/></div>
							<script type="text/javascript">
							//<![CDATA[
								if (AC_FL_RunContent == 0) {
									alert("This page requires AC_RunActiveContent.js.");
								} else {
									AC_FL_RunContent(
										'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0',
										'width', '205',
										'height', '190',
										'src', 'link-preloader',
										'quality', 'high',
										'pluginspage', 'http://www.macromedia.com/go/getflashplayer',
										'align', 'middle',
										'play', 'true',
										'loop', 'false',
										'scale', 'showall',
										'wmode', 'transparent',
										'devicefont', 'false',
										'id', 'link-preloader',
										'bgcolor', '#000000',
										'name', 'link-preloader',
										'menu', 'false',
										'allowFullScreen', 'false',
										'allowScriptAccess','sameDomain',
										'movie', 'link-preloader',
										'salign', ''
									); //end AC code
								}
								//]]>
							</script>
						</div>
					</div>
				</div>
				<!-- End of column -->
				
				<!-- Middle Column - main content -->
				<div id="content-middle">
					<div class="content-box">
						<div class="content-holder">
							<h2>Account Information</h2>
							<span style="text-align:center;">
							 <?php
								if ($appstate == 3)
								{
									echo "<p><font color='#66FF00'>Your application was Accepted! (Handler: " . $apphandler . ").</font></p>";
								}
								elseif ($appstate == 2)
								{
									echo "<p><font color='#FF0000'>Your application was Denied! (Handler: " . $apphandler . ").</font></p><p>Reason: " . $appreason . "</p>";
								}
							?>
							</span>
							
							<ul style="list-style-type:none;margin-left:0px;padding-left:0px;">
								<li><b>Application Status:</b>							
								<?php
									if ($appstate == 0)
										echo "<a href='writeapplication.php'><font color='#FF9900' align='left'>Click here to write one</font></a></li>";
									elseif ($appstate == 1)
										echo "<font color='#FF9900' align='left'>Pending Review</font></li>";
									elseif ($appstate == 2)
										if( $noapply == 1 )
											echo "<font color='#FF0000'>Denied - You need to wait " . (($timehour > 0)?($timehour . ' hours and '):('')) . $timeminute . " minutes before applying again.</font></a></li>";
										else
											echo "<a href='writeapplication.php'><font color='#FF0000'>Denied - Click here to write a new application.</font></a></li>";
									elseif ($appstate == 3)
										echo "<font color='#66FF00'>Accepted</font></li>";
								?>
								
								<li><b>Administrator:</b> <?php echo getAdminTitleFromIndex($admin) ?></li>
								<?php echo ( ( $overseer == 1 ) ? '<li>Overseer: <b>Yes</b></li>' : '' ); ?> 
								<li><b>Donator:</b> <?php echo getDonatorTitleFromIndex($donator) ?></li>
								<li><b>Account Standing:</b> <?php echo getStandingFromIndex($banned) ?></li>
								<li><b>Email Address:</b> <?php echo $email; ?></li>
							</ul>
						</div>
					</div>
				</div>

				<!-- Column -->
				<div id="content-left">
					<div class="content-box">
						<div class="side-content-holder">
							<div style="margin-left:-30px;padding-top:10px;"><img src="images/admin-title.png"/></div>
							 <?php
								if ($admin > 0 || $overseer > 0)
								{
									// new applications
									$result = mysql_query("SELECT COUNT(*) FROM accounts WHERE appstate=1");
									$num = mysql_result($result, 0, 0);
									echo "<a href='applications.php?show=1'>New Applications (" . $num . ")</a><br>";
									
									if($admin > 0)
									{
										// accepted
										$result = mysql_query("SELECT COUNT(*) FROM accounts WHERE appstate=3");
										$num = mysql_result($result, 0, 0);
										echo "<a href='applications.php?show=4'>Accepted Applications (" . $num . ")</a><br>";
										
										// declined
										$result = mysql_query("SELECT COUNT(*) FROM accounts WHERE appstate=2");
										$num = mysql_result($result, 0, 0);
										echo "<a href='applications.php?show=2'>Declined Applications (" . $num . ")</a><br>";
										
										// accounts without applications
										$result = mysql_query("SELECT COUNT(*) FROM accounts WHERE appstate=0");
										$num = mysql_result($result, 0, 0);
										echo "<a href='applications.php?show=3'>Application-less Accounts (" . $num . ")</a><br>";
										
										// bans
										$result = mysql_query("SELECT COUNT(*) FROM accounts WHERE banned>0");
										$num = mysql_result($result, 0, 0);
										echo "<a href='applications.php?show=5'>Banned Accounts (" . $num . ")</a><br>";
										
										// friends
										$result = mysql_query("SELECT COUNT(*) FROM friends WHERE friend = " . $userid);
										echo "<a href='friends.php'>Your Friends (" . mysql_result($result, 0, 0) . ")</a><br>";
									}
								}
								else
								{
									echo "<p>You are not an admin.</p>";
								}
							?>
						</div>
					</div>
				</div>
				<!-- End of column -->
				
				<div id="content-middle">
					<div class="content-box">
						<div class="content-holder">
							<h2>Valhalla Anti-Cheat</h2>
							<ul style="list-style-type:none;margin-left:0px;padding-left:0px;">
								
								<li><b>Global Bans:</b> <?php echo $globalbans ?></li>
								<li><b>False Positives:</b> <?php echo $falsepos ?></li>
								<li><b>Accuracy:</b> <?php echo 100- (($falsepos/$globalbans) * 100) . "%" ?></li>
								<li><b>VAC Standing:</b> <?php echo getVACStandingFromIndex($vacbanned) ?></li>
							</ul>
						</div>
					</div>
				</div>
				
				
				
				<div id="break"></div>
			</div>
		</div>
		<div id="footer">
			<div class="footer-content">
				<div id="footer-logo-mta"></div><div id="footer-logo-vg"></div>
				<div id="copyright-text"><h6>Copyright &copy; 2007-2010 Valhalla Gaming. All rights reserved. Valhalla Gaming and all contents within this website are not affiliated with Rockstar Games, Rockstar North or Take-Two Interactive Software Inc. Grand Theft Auto, Grand Theft Auto: San Andreas and their logos are registered trademarks of Take-Two Interactive Software Inc.</h6></div>
				<div class="footer-content" style="width:160px;"><img src="images/mysql_powered.png"/><img src="images/php_powered.png"/></div>
			</div>
		</div>
</body>
</html>
