<?php
ob_start();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<?php
	if (!isset($_COOKIE["username"]) || !isset($_COOKIE["password"]) || !isset($_COOKIE["uid"]))
	{
		header('Location: index.php');
		exit;
	}
?>

<?php include("config.php"); ?>

<?php 
	$conn = mysql_pconnect($mysql_host, $mysql_user, $mysql_pass);
	$userid = mysql_real_escape_string($_COOKIE["uid"], $conn);
	
	mysql_select_db("mta", $conn);
	$result = mysql_query("SELECT username, admin, donator, appstate, appgamingexperience, appcountry, applanguage, apphow, appwhy, appexpectations, appdefinitions, appfirstcharacter, appclarifications, appdatetime < NOW(), HOUR(TIMEDIFF(NOW(), appdatetime)), MINUTE(TIMEDIFF(NOW(), appdatetime)) FROM accounts WHERE id='" . $userid . "' LIMIT 1", $conn);

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
	
	$gamingexperience = mysql_result($result, 0, 4);
	$country = mysql_result($result, 0, 5);
	$language = mysql_result($result, 0, 6);
	$how = mysql_result($result, 0, 7);
	$why = mysql_result($result, 0, 8);
	$expectations = mysql_result($result, 0, 9);
	$definitions = mysql_result($result, 0, 10);
	$firstcharacter = mysql_result($result, 0, 11);
	$clarifications = mysql_result($result, 0, 12);
	$canapply = mysql_result($result, 0, 13);
	$timehour = mysql_result($result, 0, 14);
	$timeminute = mysql_result($result, 0, 15);
	
	if ($appstate == 1 || $appstate == 3)
	{
		header('Location: main.php');
		exit;
	}
?>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

	<title>Valhalla Gaming: Multi Theft Auto | Application</title>
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
							<h2>Application</h2>
<?php
						if( $canapply == 0 )
						{
?>
							<p>You need to wait <?= (($timehour > 0)?($timehour . ' hours and '):('')) . $timeminute ?> minutes before applying again.</p>
<?php
						}
						else
						{
?>
							<script type="text/javascript" src="js/prototype/prototype.js"></script>
							<script type="text/javascript" src="js/bramus/jsProgressBarHandler.js"></script>
							<script type="text/javascript">
							<!--
							function validate_form(thisform)
							{
								with (thisform)
								  {
									var notcomplete = false;
									var field = "None";
									
									if (thisform.gamingexperience.value==null || thisform.gamingexperience.value==""  || thisform.gamingexperience.value.length<20 )
									{
										notcomplete = true;
										field = "Gaming Experience";
									}
									else if (thisform.country.value==null || thisform.country.value==""  || thisform.country.value.length<2 )
									{
										notcomplete = true;
										field = "Country";
									}
									else if (thisform.language.value==null || thisform.language.value==""  || thisform.language.value.length<2 )
									{
										notcomplete = true;
										field = "Language";
									}
									else if (thisform.country.value==null || thisform.country.value==""  || thisform.country.value.length<2 )
									{
										notcomplete = true;
										field = "Country";
									}
									else if (thisform.how.value==null || thisform.how.value==""  || thisform.how.value.length<2 )
									{
										notcomplete = true;
										field = "How you found Valhalla";
									}
									else if (thisform.why.value==null || thisform.why.value==""  || thisform.why.value.length<2 )
									{
										notcomplete = true;
										field = "Why you picked Valhalla";
									}
									else if (thisform.expectations.value==null || thisform.expectations.value==""  || thisform.expectations.value.length<2 )
									{
										notcomplete = true;
										field = "Expectations of the community";
									}
									else if (thisform.definitions.value==null || thisform.definitions.value==""  || thisform.definitions.value.length<2 )
									{
										notcomplete = true;
										field = "Definitions of Metagaming and Powergaming";
									}
									else if (thisform.firstcharacter.value==null || thisform.firstcharacter.value==""  || thisform.firstcharacter.value.length<2 )
									{
										notcomplete = true;
										field = "First Character Description";
									}
									else if (thisform.clarifications.value==null || thisform.clarifications.value==""  || thisform.clarifications.value.length<2 )
									{
										notcomplete = true;
										field = "Clarifications & Other";
									}
									
									if ( notcomplete )
										alert ( "You have not completed the application form. \n\n Missing Field : " + field );
										
									return !notcomplete;
								  }
							 }
							 //-->
							 </script>
							 
							 <form action="submitapplication.php" method="post" onSubmit="return validate_form(this)">
								<p>We aim to review all applications within a few hours of their submission. You will not be declined for being new to role play, infact we encourage new RolePlayers to join. This test avoids powergamers, metagamers, deathmatchers, etc from ruining the experience for others.</p>
								<p>Before submitting your application please take the time to read the guides available on the <a href="http://www.valhallagaming.net/forums/forumdisplay.php?f=489">Valhalla Gaming forum</a>.<p>
								<h3>Tips</h3>
								<ul>
									<li>Write in complete sentences.</li>
									<li>Write more than one sentece for each answer. Show us that you are willing to put in some effort.</li>
									<li>Check your spelling, grammar and punctuation. This does not have to be perfect but this is an English speaking server and text is the main form of communication so we need to see that you will be able to keep up and that others will be able to understand you.</li>
									<li>Sentences begin with a capital letter!</li>
								</ul>
								<br />
								<p>Tell us about your gaming experience:</p>
								<textarea name="gamingexperience" id="gamingexperience" style="width:580px;height:150px"><?php echo $gamingexperience; ?></textarea>
								<br />
								<br />
								<label for="country" style="color:#FFF;">Country of residence:</label>
								<input type="text" name="country" id="country" value="<?php echo $country; ?>">
								<br />
								<br />
								<label for="language" style="color:#FFF;">Primary language:</label>
								<input type="text" name="language" id="language" value="<?php echo $language; ?>">
								<p>How did you get into Grand Theft Auto roleplay?</p>
								<textarea name="how" id="how" style="width:580px;height:180px"><?php echo $how; ?></textarea>
								<p>Why did you choose the Valhalla Gaming MTA Roleplay server over others?</p>
								<textarea name="why" id="why" style="width:580px;height:180px"><?php echo $why; ?></textarea></td>
								<p>What are your expectations of this server and what do you hope to get out of the server?</p>
								<textarea name="expectations" id="expectations" style="width:580px;height:150px"><?php echo $expectations; ?></textarea>
								<p>In your own words write a brief definition of "metagaming" and "powergaming".</p>
								<textarea name="definitions" id="definitions" style="width:580px;height:150px"><?php echo $definitions; ?></textarea>
								<p>Briefly tell us about the first character you intend to play as. Try to be original but overall be realistic. This does not need to be a full back story however we would like to see that you have put some thought into the character you will be playing.</p>
								<textarea name="firstcharacter" id="firstcharacter" style="width:580px;height:150px"><?php echo $firstcharacter; ?></textarea>
								<p>Is there anything else you would like to add, ask or otherwise clarify?</p>
								<textarea name="clarifications" id="clarifications" style="width:580px;height:150px"><?php echo $clarifications; ?></textarea>
								<p>Your registration will be reviewed by a member of our administration team. Once your application has been accepted you will be able to login to the server and play.</p>
								<input type="submit" name="submit" id="submit" value="Submit" style="color:#FFF;">
							</form>
<?php
						}
?>
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
