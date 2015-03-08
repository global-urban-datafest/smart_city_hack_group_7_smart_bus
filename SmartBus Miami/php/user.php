<head>
	<meta http-equiv="Content-Type" content="text/html;" />
	<title>Bus Map</title>      
	<script type="text/javascript" src="http://tfcore.cs.fiu.edu/api/8.5.0/default.aspx"></script>
</head>

<?php
	$routeId = $_GET["routeId"];
	$heading = $_GET["heading"];
	$position = $_GET["position"];
	  
	 
	 $j = 1;
	 $l = 1;
	 $arr_xy = Array();
	 $arr_time = Array();
	 $arr_cur_time = Array();
	 $arr_ini_time = Array();
	 $arr_fin_time = Array();
	  
	class TableRows extends RecursiveIteratorIterator { 
		 function __construct($it) { 
			 parent::__construct($it, self::LEAVES_ONLY); 
		 }
		 function current() {
			 return "<td style='width: 150px; border: 1px solid black;'>" . parent::current(). "</td>";
		 }
		 function beginChildren() { 
			 echo "<tr>"; 
		 } 
		 function endChildren() { 
			 echo "</tr>" . "\n";
		 } 
	} 
	
	$servername = "localhost";
	$username = "root";
	$password = "";
	$dbname = "smartbus";
	//Selection

	try {
		 $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
		 $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		
		 $stmt = $conn->prepare("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='smartbus' AND TABLE_NAME='test'");
		 $stmt->execute();
		 $stmt->setFetchMode(PDO::FETCH_ASSOC); 
		 //"nameOfIndex"=> $value
		 $pos = array();
		 $i = 0;
		 foreach(new TableRows(new RecursiveArrayIterator($stmt->fetchAll())) as $k=>$v) { 
			 $pos[$i++] = $v;
		 }
		 
		 //$stmt1 = $conn->prepare("INSERT INTO available SELECT * FROM test NATURAL JOIN bus WHERE position<$position");
		 // create array with different queries..then run the queries from array
		 $stmt = $conn->prepare("SELECT * FROM bus NATURAL JOIN test WHERE position<$position");
		 $stmt->execute();
		 $stmt->setFetchMode(PDO::FETCH_ASSOC);
		 while($result = $stmt->fetch()){
			 $key_p = "position";
			 $pos = $result[$key_p];
			 $key_s = "s".strval($pos);
			 $stmt1 = $conn->prepare("SELECT X($key_s), Y($key_s) FROM test");
			 $stmt1->execute();
			 $stmt1->setFetchMode(PDO::FETCH_ASSOC);
			 while ($coordinate = $stmt1->fetch()){
				//print_r($coordinate);
				$arr_xy[$j."x"] = $coordinate["X(".$key_s.")"];
				$arr_xy[$j."y"] = $coordinate["Y(".$key_s.")"];
				$j++;
			 }
			 
			 $j=1;
			 $key_t = "t".strval($pos);
			 $stmt1 = $conn->prepare("SELECT $key_t FROM test");
			 $stmt1->execute();
			 $stmt1->setFetchMode(PDO::FETCH_ASSOC);
			 while ($origintime = $stmt1->fetch()){
				//print_r($origintime);
				//$arr_xy[$j."x"] = $coordinate["X(".$key_s.")"];
				//$arr_xy[$j."y"] = $coordinate["Y(".$key_s.")"];
				$array_time[$j] = $origintime[$key_t];
				$j++;
				
				//start time Estimates
				//passing stop time
				//actual time estimate <- this gets updated from passing stop time
			 }
		 }
		 
		 $j=0;
		 $stmt = $conn->prepare("SELECT * FROM bus NATURAL JOIN test WHERE position<$position");
		 $stmt->execute();
		 $stmt->setFetchMode(PDO::FETCH_ASSOC);
		 while($result = $stmt->fetch()){
			 $key_dest = "t".$position;
			 $id = $result[$key_dest];
			 $arr_fin_time[$j] = $result[$key_dest];
			 $arr_cur_time[$j] = $result["time"];
			 $arr_ini_time[$j] = $result["estime"];
		 }	 
			 
		 $stmt = $conn->prepare("SELECT * FROM bus NATURAL JOIN test WHERE position<$position");
		 $stmt->execute();
		 $stmt->setFetchMode(PDO::FETCH_ASSOC);
		 while($result = $stmt->fetch()){
		 
		 
		 }
	}
	catch(PDOException $e) {
		 echo "Error: " . $e->getMessage();
	}
	
	//$array_xy = array('apple', 'orange', 'banana', 'strawberry');
	//json_encode($array_xy); // ["apple","orange","banana","strawberry"]

	//$est_time  = 0;
	//for ($x = 1; $x <= 11; $x++) {
	//	$est_time = $arr_cur_time[$x] - ($arr_ini_time[$x] + $arr_time[$x]) + $arr_fin_time[$x];
	//	echo $est_time;
	//}
	//echo 1;
	
	
	json_encode($arr_xy); 
	json_encode($arr_time);
	json_encode($arr_cur_time);
	json_encode($arr_ini_time);
	json_encode($arr_fin_time);
	$conn = null;
?>

<body>
    <div id="mapContainer0"  style="width: 640px; height: 400px;"></div>
	
    <script type="text/javascript">
        //  Create a map with navigation panel, zoom panel , and overview panel shown.           
        var map0 = new TMap(mapContainer0, 25.7590256665386, -80.3738769902151, 15, mapLoaded, 1, true, "", "hybrid");
		
		var arr_xy = <?php echo json_encode($arr_xy); ?>;
		var arr_time = <?php echo json_encode($arr_time); ?>;
		var arr_cur_time = <?php echo json_encode($arr_cur_time); ?>;
		var arr_ini_time = <?php echo json_encode($arr_ini_time); ?>;
		var arr_fin_time = <?php echo json_encode($arr_fin_time); ?>;
		
		
        function mapLoaded(){
            //Layers are containers of Markers, but not visible.
            //You could add a group of Markers into one Layer
            //  and adjust the attributes of the Markers by group.
            var layer0 = map0.AddLayer("Markers", "Markers", true, false);
			//console.log(array_xy);
			//console.log(arr_xy);
			//var j = 0;
			//for (var i = 0; i < arr_xy.length; i++){
			//	j++;
			 //layer0.AddMarker(arr_xy[1+"x"], arr_xy[1+"y"], "ddddddddddddddddddddddddddddddddddddddddddddddddabc");
			//}
			//for ($k=0; $k < sizeof($arr_time); $k++) {
			//	var marker.$k = layer0.AddMarker($arr_xy[k."x"], $arr_xy[k."y"], "si
			//}
            //var marker0=layer0.AddMarker( 25.7590256665386, -80.3738769902151, "Click me ...");
            //var marker1=layer0.AddMarker( 25.7590256665386, -80.37, "Show tabs"); 
			//var marker2=layer0.AddMarker( arr_xy[1+"x"], arr_xy[1+"y"], "DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD tabs"); 
			ShowPanels();
		}
		//document.write(j);
		function ShowPanels(){
            map0.SetPanelVisibility("FLY", "SHOW");
            map0.SetPanelVisibility("ZOOM", "SHOW");
            map0.SetPanelVisibility("OVERVIEW", "SHOW");
        }
        
        //  Show/hide the panels by button clicks.
        function Button1_onclick() {
        	 map0.SetPanelPosition("ZOOM", zoomX.value ,zoomY.value);
    		 map0.SetPanelPosition("NAV", navX.value, navY.value);
    		 map0.SetPanelPosition("OVERVIEW", overX.value, overY.value);
		}
    </script>
	
	
</body>
