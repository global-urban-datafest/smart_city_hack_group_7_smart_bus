show_info.php

<?php 
if(!isset($_REQUEST['id']) or $_REQUEST['id']=="") die("error: id none");
$id = $_REQUEST['id'];
//定位记录,读出
$conn=mysql_connect("localhost","root","admin");
if(!$conn) die("error: mysql connect failed");
mysql_select_db("nokiapaymentplat",$conn);
$sql = "select * from receive where id=$id";
$result = mysql_query($sql,$conn);
if(!$result) die("error: mysql query");

$num=mysql_num_rows($result);
if($num<1) die("error: no this recorder");

$data = mysql_result($result,0,"file_data");
$type = mysql_result($result,0,"file_type");
$name = mysql_result($result,0,"file_name");

mysql_close($conn);

//先输出相应的文件头,并且恢复原来的文件名
header("Content-type:$type");
header("Content-Disposition: attachment; filename=$name");
echo $data;
?> 

show_info.php

<?php 
if(!isset($_REQUEST['id']) or $_REQUEST['id']=="") die("error: id none");
$id = $_REQUEST['id'];
//定位记录,读出
$conn=mysql_connect("localhost","root","admin");
if(!$conn) die("error: mysql connect failed");
mysql_select_db("nokiapaymentplat",$conn);

$sql = "select file_name ,file_size from receive where id=$id";
$result = mysql_query($sql,$conn);
if(!$result) die(" error: mysql query");

//如果没有指定的记录，则报错
$num=mysql_num_rows($result);
if($num<1) die("error: no this recorder");

//下面两句程序也可以这么写
//$row=mysql_fetch_object($result);
//$name=$row->name;
//$size=$row->size;
$name = mysql_result($result,0,"file_name");
$size = mysql_result($result,0,"file_size");

mysql_close($conn);

echo "<hr>上传的文件的信息：";
echo "<br>The file's name - $name"; 
echo "<br>The file's size - $size"; 
echo "<br><a href=show_add.php?id=$id>附件</a>";
?> 

submit.php

<?php 
if(is_uploaded_file($_FILES['myfile']['tmp_name'])) { //有了上传文件了 

$myfile=$_FILES["myfile"];

//设置超时限制时间,缺省时间为 30秒,设置为0时为不限时
$time_limit=60; 
set_time_limit($time_limit); //

//把文件内容读到字符串中
$fp=fopen($myfile['tmp_name'], "rb");
if(!$fp) die("file open error");
$file_data = addslashes(fread($fp, filesize($myfile['tmp_name'])));
fclose($fp);
unlink($myfile['tmp_name']); 

//文件格式,名字,大小
$file_type=$myfile["type"];
$file_name=$myfile["name"];
$file_size=$myfile["size"];
die($file_type);
//连接数据库,把文件存到数据库中
$conn=mysql_connect("localhost","root","admin");
if(!$conn) die("error : mysql connect failed");
mysql_select_db("nokiapaymentplat",$conn);

$sql="insert into receive 
(file_data,file_type,file_name,file_size) 
values ('$file_data','$file_type','$file_name',$file_size)";
$result=mysql_query($sql,$conn);

//下面这句取出了刚才的insert语句的id
$id=mysql_insert_id();

mysql_close($conn);

set_time_limit(30); //恢复缺省超时设置 

echo "上传成功--- ";
echo "<a href='show_info.php?id=$id'>显示上传文件信息</a>";
} 
else { 
echo "你没有上传任何文件"; 
} 
?> 

upload.php

?<html> 
<head> 
<title>文件上传表单</title> 
</head> 
<body> 
<table> 
<form enctype='multipart/form-data' name='myform' action='submit.php' 
method='post'> 
<INPUT TYPE = "hidden" NAME = "MAX_FILE_SIZE" VALUE ="1000000">
<tr><td>选择上传文件</td><td>
<input name='myfile' type='file'></td></tr> 
<tr><td colspan='2'><input name='submit' value='上传' type='submit'></td></tr> 
</table> 
</body> 
</html>