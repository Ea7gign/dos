<?php
	if (!isset($_COOKIE["username"]) || !isset($_COOKIE["password"]) || !isset($_COOKIE["uid"]))
	{
		header('Location: index.php');
		exit;
	}
		
	if (!$_GET["show"] || $_GET["show"] < 1 || !$_GET["show"] > 3)
	{
		header('Location: main.php');
		exit;
	}

	include("config.php");
	
	$conn = mysql_pconnect($mysql_host, $mysql_user, $mysql_pass);
	$userid = mysql_real_escape_string($_COOKIE["uid"], $conn);
	
	mysql_select_db("mta", $conn);
	$result = mysql_query("SELECT username, admin, overseer FROM accounts WHERE id='" . $userid . "' LIMIT 1", $conn);

	if (!$result || mysql_num_rows($result)==0)
	{
		setcookie("uid", "", time()-3600);
		setcookie("username", "", time()-3600);
		setcookie("password", "", time()-3600);		
		header('Location: index.php');
	}
	$username = mysql_result($result, 0, 0);
	$admin = mysql_result($result, 0, 1);
	$overseer = mysql_result($result, 0, 2);
	
	if ($admin < 1 && ( $overseer == 0 || ( $overseer == 1 and $_GET['show'] != 1 ) ) )
	{
		header('Location: main.php');
		exit;
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
				<div class="nav-links"><a href="index.php">HOME</a></div>
				
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
							 <?php
								if ( $_GET["show"] == 1 ) // show new applications
								{
									echo "<h2>Applications</h2>";
									echo "<p>Older applications are shown at the top, please resolve them first.</p>";
									$query = mysql_query("SELECT id, username, appdatetime, DATEDIFF(NOW(), appdatetime) FROM accounts WHERE appstate=1 ORDER BY appdatetime ASC", $conn);
									
									echo "<h4>Username - Date Submitted - Action</h4>";
									
									if (mysql_num_rows($query) > 0)
									{
										echo "<ul style='list-style-type:none;margin-left:0px;padding-left:0px;'>";
										for ( $i = 0; $i < mysql_num_rows($query); $i++ )
										{
											$id = mysql_result($query, $i, 0);
											$username = mysql_result($query, $i, 1);
											$appdatetime = mysql_result($query, $i, 2);
											$diff = mysql_result($query, $i, 3);
											
											echo "<li><strong>". $username ."</strong> - ". $appdatetime ." (" . $diff . " Days Old) - <a href='reviewapp.php?id=" . $id . "'>Review ></a>";
										}
										echo "</ul>";
										mysql_free_result($query);
									}
									else
									{
										echo "<p>There are no applications waiting to be reviewed.</p>";
									}
								}
								elseif ( $_GET["show"] == 2 ) // show declined applications
								{
									echo "<h2>Declined Applications</h2>";
									$query = mysql_query("SELECT id, username, appdatetime, DATEDIFF(NOW(), appdatetime)+1, apphandler FROM accounts WHERE appstate=2 ORDER BY appdatetime ASC", $conn);
									
									echo "<h4>Username - Date Submitted - Application Handler - Action</h4>";
									
									if (mysql_num_rows($query) > 0)
									{
										echo "<ul style='list-style-type:none;margin-left:0px;padding-left:0px;'>";
										for ( $i = 0; $i < mysql_num_rows($query); $i++ )
										{
											$id = mysql_result($query, $i, 0);
											$username = mysql_result($query, $i, 1);
											$appdatetime = mysql_result($query, $i, 2);
											$diff = mysql_result($query, $i, 3);
											$apphandler = mysql_result($query, $i, 4);
											
											echo "<li><strong>". $username ."</strong> - ". $appdatetime ." (" . $diff . " Days Old) - ". $apphandler ." - <a href='reviewapp.php?id=" . $id . "'>View ></a>";
										}
										echo "</ul>";
										mysql_free_result($query);
									}
									else
									{
										echo "<br />";
									}
								}
								elseif ( $_GET["show"] == 3 ) // show accounts without applications
								{
									echo "<h2>Accounts Without Applications</h2>";
									echo "<p>Only delete these if you KNOW they are inactive and are not just being forced to retake the applications.</p>";
									$query = mysql_query("SELECT id, username, registerdate, DATEDIFF(NOW(), registerdate) FROM accounts WHERE appstate=0 ORDER BY appdatetime ASC", $conn);
									
									echo "<h4>Username - Registration Date - Action</h4>";
									
									//$ids = array();
									
									if (mysql_num_rows($query) > 0)
									{
										echo "<ul style='list-style-type:none;margin-left:0px;padding-left:0px;'>";
										for ( $i = 0; $i < mysql_num_rows($query); $i++ )
										{
											$id = mysql_result($query, $i, 0);
											$username = mysql_result($query, $i, 1);
											$registerdate = mysql_result($query, $i, 2);
											$diff = mysql_result($query, $i, 3);
											//$ids[$i] = $id;
											
											echo "<li><strong>". $username ."</strong> - ". $registerdate ." (" . $diff . " Days Old) - <a href='deleteaccount.php?id=" . $id . "'>Delete Account ></a>";
											
										}
										echo "</ul>";
										mysql_free_result($query);
									}
									else
									{
										echo "<br />";
									}
								}
								elseif ( $_GET["show"] == 4 ) // show accounts with successful applications
								{
									echo "<h2>Active Accounts</h2>";
									$query = mysql_query("SELECT id, username, appdatetime, DATEDIFF(NOW(), appdatetime), apphandler FROM accounts WHERE appstate=3 ORDER BY appdatetime ASC LIMIT 1000", $conn);
									
									echo "<h4>Username - Date Submitted - Application Handler - Action</h4>";

									if (mysql_num_rows($query) > 0)
									{
										echo "<ul style='list-style-type:none;margin-left:0px;padding-left:0px;'>";
										
										for ( $i = 0; $i < mysql_num_rows($query); $i++ )
										{
											$id = mysql_result($query, $i, 0);
											$username = mysql_result($query, $i, 1);
											$registerdate = mysql_result($query, $i, 2);
											$diff = mysql_result($query, $i, 3);
											$handler = mysql_result($query, $i, 4);
											
											echo "<li><strong>". $username ."</strong> - ". $registerdate ." (" . $diff . " Days Old) - ". $handler ." - <a href='reviewapp.php?id=" . $id . "'>View</a> - <a href='deactivateaccount.php?id=" . $id . "'>Deactivate Account ></a>";
											
										}
										echo "</ul>";
										mysql_free_result($query);
									}
									else
									{
										echo "<br />";
										
									}
								}
								elseif ( $_GET["show"] == 5 ) // show banned accounts
								{
									echo "<h2>Banned Accounts:</h2>";
									$query = mysql_query("SELECT id, username, banned_by, banned_reason FROM accounts WHERE banned>0", $conn);
									
									echo "<h4>Username - Banned By - Reason - Action</h4>";
									
									if (mysql_num_rows($query) > 0)
									{
										echo "<ul style='list-style-type:none;margin-left:0px;padding-left:0px;'>";
										
										for ( $i = 0; $i < mysql_num_rows($query); $i++ )
										{
											$id = mysql_result($query, $i, 0);
											$username = mysql_result($query, $i, 1);
											$banned_by = mysql_result($query, $i, 2);
											$banned_reason = mysql_result($query, $i, 3);
											
											echo "<li><strong>". $username ."</strong> - ". $banned_by ." - ". $banned_reason ." - <a href='reviewapp.php?id=" . $id . "'>View</a> - <a href='http://vg-lvpd.net/remote/unbanaccount.php?id=" . $id . "&uid=" . $userid . "'>Unban Account ></a>";
											
										}
										echo "</ul>";
										mysql_free_result($query);
									}
									else
									{
										echo "<br />";
										
									}
								}
							?>
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
