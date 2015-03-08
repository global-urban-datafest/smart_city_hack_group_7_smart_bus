<?php

//extract values here
//http://localhost/driver.php/?busId=123456&time=12:30&position=15&routeId=123&heading=0

$busId = $_GET["busId"];
$time = $_GET["time"];
$position = $_GET["position"];
$routeId = $_GET["routeId"];
$heading = $_GET["heading"];

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "smartbus";


$conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
// set the PDO error mode to exception
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
if ($position==="0"){
	try {
		$sql = "INSERT INTO bus (busId, time, position, routeId, heading)
		VALUES ('$busId', '$time', '$position', '$routeId', '$heading')";
		// use exec() because no results are returned
		$conn->exec($sql);
		echo "New record created successfully";
	}
	catch(PDOException $e)
	{
		echo $sql . "<br>" . $e->getMessage();
	}
}else{
	try {
		// Prepare statement
		$stmt = $conn->prepare("UPDATE bus SET position=$position WHERE busId=$busId");
		// execute the query
		$stmt->execute();
		// echo a message to say the UPDATE succeeded
		echo "Rrecords UPDATED successfully";
    }
	catch(PDOException $e)
    {
		echo $sql . "<br>" . $e->getMessage();
    }
}
$conn = null;

?>