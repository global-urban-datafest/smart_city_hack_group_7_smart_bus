<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;" />
		<title>Lesson 1 - Hello TerraMap, the Simplest Map</title>      
		<script type="text/javascript" src="http://tfcore.cs.fiu.edu/api/8.5.0/default.aspx"></script>
	</head>
	<body>
		<h1>Lesson 1 - Hello World</h1>
		<?php
		echo "Hello World!";
		?> 
		<div id="mapContainer0"  style="width: 640px; height: 400px;"></div>
		<script language="javascript" type="text/javascript">
			var map0 = new TMap(mapContainer0, 25.75869, -80.37388, 15, "", 1, true, "", "hybrid");
		</script>

		<?php
		$servername = "localhost";
		$username = "root";
		$password = "";


		try {
			$conn = new PDO("mysql:host=$servername;dbname=myDB", $username, $password);
			// set the PDO error mode to exception
			$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			echo "Connected successfully"; 
			}
		catch(PDOException $e)
			{
			echo "Connection failed: " . $e->getMessage();
			}

		$conn = null;
		?>
		<br>
		
		
		<form action="welcome.php" method="post">
		Name: <input type="text" name="name"><br>
		E-mail: <input type="text" name="email"><br>
		<input type="submit">
		</form>
		
	</body>
</html>