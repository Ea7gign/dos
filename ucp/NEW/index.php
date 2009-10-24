<?php
	if (isset($_COOKIE["username"]) &&isset($_COOKIE["password"]) && isset($_COOKIE["uid"]))
	{
		header('Location: main.php');
		exit;
	}
		
	$errno = $_GET["errno"];
	if ($errno==3)
	{
		// allow 3 tries				
		if (!isset($_COOKIE["loginattempts"]))
			setcookie("loginattempts", "1", time()+900);
		else
			setcookie("loginattempts", $_COOKIE["loginattempts"]+1, time()+900);
	}
?><?php include("config.php"); ?><html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /><title>Valhalla Gaming: Multi Theft Auto</title>
	<meta name="description" content="Website of the Valhalla Gaming Multi Theft Auto role play server." /><meta name="keywords"content="GTA, multi, grand, theft, auto, san, andreas, multiplayer, player, CJ, Carl, Johnson, Role, Play, RP, SAMP, IV, MTA, valhalla, gaming, vg"/><meta name="author" content="Chamberlain" /><meta name="copyright" content="Valhalla Gaming" /><link href="css/styles.css" rel="stylesheet" type="text/css" /><link rel="shortcut icon" href="images/favicon.ico" /><script type="text/javascript">
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
				<div class="nav-links"><a href="http://www.valhallagaming.net/site/mta/">HOME</a></div>	
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
							<h2>Login</h2>
							<div style="text-align:center;">
								<form action="login.php" method="post">
									
									<?php
									$errno = $_GET["errno"];
									$loggedout = $_GET["loggedout"];
										
									if ($errno==2)
									{
										echo "<span style='text-align:left;'><p>UCP is currently unavailable!</p></span>";
									}
									elseif ($errno==3)
									{
										echo "<span style='text-align:left;'><p>Invalid Username / Password!</p><p>Please login using your vG MTA account details to continue.</p></span>";
									}
									else if ($errno==4)
									{
										echo "<span style='text-align:left;'><p>You have used up your 3 login attempts. You are now locked out for 15 minutes.</p></span>";
									}
									elseif ($loggedout==1)
									{
										echo "<span style='text-align:left;'><p>You are now logged out.</p><p>Please login using your vG MTA account details to continue.</p></span>";
									}
									else
									{
										echo "<span style='text-align:left;'><p>Please login using your vG MTA account details to continue.</p></span>";
									}
									?>
										
									<?php
									function generatePassword($length=9, $strength=0) {
										$vowels = 'aeuy';
										$consonants = 'bdghjmnpqrstvz';
										if ($strength & 1) {
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
									}

									
									$securitykey = $_POST["securitykey"];

									if ($securitykey) // was reset password
									{
										$conn = mysql_pconnect($mysql_host, $mysql_user, $mysql_pass);
										
										if (!$conn)
											header('Location: resetpassword.php?errno=2');

										mysql_select_db("mta",$conn);
										$result = mysql_query("SELECT username FROM accounts WHERE securitykey='" . $securitykey . "'", $conn);
											
											
										if (!$result || mysql_num_rows($result)==0)
										{
											echo "<p>Invalid Security Key!</p>"; 
											//header('Location: resetpassword.php?errno=2');
										}
										else
										{
											$username = mysql_result($result, 0);
											$password = generatePassword(9, 4);
											$salt = "vgrpkeyscotland";
												
											$query = mysql_query("UPDATE accounts SET password='" . md5($salt . $password) . "' WHERE username='" . $username . "'", $conn);
											
											echo "<p>Your username is <i>" . $username . "</i> and your new password is <i>" . $password . ".</i></p>"; 
										}
									}
									?>
									<br />
									<label for="username">Username:</label>
									<!--webbot bot="Validation" b-value-required="TRUE" i-minimum-length="3" i-maximum-length="32" -->
									<input type="text" name="username" maxlength="32" style="width:150px;height:16px"/><br/>
									<label for="password">Password:</label>
									<!--webbot bot="Validation" b-value-required="TRUE" i-minimum-length="3" i-maximum-length="32" --> 
									<input type="password" name="password" maxlength="32" style="width:150px;height:16px"/>
									<br />
									<p><a href="resetpassword.php">Forgot Password</a><strong> | </strong><a href="register.php">Register</a></p>
									<input type="submit" value="Login"/>
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
								include("../site/mta/admin/shownews.php");
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
