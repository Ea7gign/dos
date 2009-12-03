<?php
	if (isset($_COOKIE["username"]) &&isset($_COOKIE["password"]) && isset($_COOKIE["uid"]))
	{
		header('Location: main.php');
		exit;
	}
?>

<?php include("config.php"); ?>

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
				<div class="nav-links-right"><a href="index.php">Not logged in</a></div>
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
							<h2>Register</h2>
							<div style="text-align:center;">
								<script type="text/javascript" src="js/prototype/prototype.js"></script>
								<script type="text/javascript" src="js/bramus/jsProgressBarHandler.js"></script>
								<script type="text/javascript">
								<!--
								function validate_form(thisform)
								{
									with (thisform)
									  {
										if (thisform.username.value==null || thisform.username.value==""  || thisform.username.value.length<3 || thisform.username.value.length>30 )
										{
											alert("Please ensure you have entered a valid username.\n\n Usernames must be between 3 and 30 characters long.");
											return false;
										}
										else if (thisform.password.value==null || thisform.password.value==""  || thisform.password.value.length<3 || thisform.password.value.length>30 )
										{
											alert("Please ensure you have entered a valid password.\n\n Passwords must be between 3 and 30 characters long.");
											return false;
										}
										else
										{
											return true;
										}
									  }
								 }
								 
								 

								Event.observe(window, 'load', function() {
								  securityPB = new JS_BRAMUS.jsProgressBar($('securitybar'), 0, {animate: true, width:120, height: 12});
								}, false);


								 function hasNumbers(t)
								 {
									var regex = /\d/g;
									return regex.test(t);
								 }
								 
								 function hasSpecialCharacters(t)
								 {
									 var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?~_"; 
									 for (var i = 0; i < t.length; i++) 
									 {
										if (iChars.indexOf(t.charAt(i)) != -1) 
											return true;
									 }
									 return false;
								  }
								  
								function isValidEmail(t)
								{
									for (var i = 0; i < t.length; i++) 
									{
										if ( t.charAt(i) == "@")
											return true;
									}
									return false;
								}
								 
								 function checkSecurity(field)
								 {
									 var value = field.value
									 var len = value.length
									 
									 if (hasNumbers(value))
										len = len * 2
										
									 if (hasSpecialCharacters(value))
										len = len * 2
									 
									 len = Math.round((len / 30) * 100, 0)
										
									 securityPB.setPercentage(len, false)
								 }
								 //-->
								 </script>
								 
								 <form action="register2.php" method="post" onSubmit="return validate_form(this)">
									<span style="text-align:left;"><p>Please enter the details for your new account below.</p></span>
									<label for="username"><span style="font-weight:bold">Username</span> (This is not your character's name):</label><br />
									<input name="username" type="text" id="username" size="30" maxlength="30">
									<br />
									<br />
									<label for="username" style="font-weight:bold">Password:</label><br />
									<input name="password" type="password" id="password" size="30" maxlength="30" onKeyUp="checkSecurity(this)">
									<br />
									<br />
				
									<label for="username" style="font-weight:bold">Email Address:</label><br />
									<input name="emailaddress" type="emailaddress" id="emailaddress" size="30" maxlength="30">
									<br />
									<br />
									<label for="securitybar" style="font-weight:bold">Password Strength:</label><br />
									<div class="percentImage1" id="securitybar"></div><br />
									<?php
										$errno = $_GET["errno"];
										
										if ($errno==1)
											echo "<p>An account with this username already exists!</p><br />";
										elseif ($errno==2)
											echo "<p>An unknown error occured, please report this on the forums!</p><br />";
										elseif ($errno==3)
											echo "<p>An account already exists with that email address, please use Reset Password!</p><br />";
									?>
									<input type="submit" name="register" id="register" value="Register">
								</form>
							</div>
						</div>
					</div>
				</div>
				
				<!-- Column -->
				<div id="content-left">
					<div class="content-box">
						<div class="side-content-holder">
							<div style="margin-left:-30px;padding-top:10px;"><img src="images/news-title.png"/></div>
							<?php
								$phpns['category'] = '1';
								$phpns['disable_pagination'] = 'True';
								$phpns['script_link'] = 'news.php';
								//after variable declaration(s), include shownews.php
								include("/www/valhallagmaing.net/site/mta/admin/shownews.php");
							?>
							<h4><a href="archive.php">News Archive</a></h4>
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
