show_info.php

<?php 
if(!isset($_REQUEST['id']) or $_REQUEST['id']=="") die("error: id none");
$id = $_REQUEST['id'];
//��λ��¼,����
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

//�������Ӧ���ļ�ͷ,���һָ�ԭ�����ļ���
header("Content-type:$type");
header("Content-Disposition: attachment; filename=$name");
echo $data;
?> 

show_info.php

<?php 
if(!isset($_REQUEST['id']) or $_REQUEST['id']=="") die("error: id none");
$id = $_REQUEST['id'];
//��λ��¼,����
$conn=mysql_connect("localhost","root","admin");
if(!$conn) die("error: mysql connect failed");
mysql_select_db("nokiapaymentplat",$conn);

$sql = "select file_name ,file_size from receive where id=$id";
$result = mysql_query($sql,$conn);
if(!$result) die(" error: mysql query");

//���û��ָ���ļ�¼���򱨴�
$num=mysql_num_rows($result);
if($num<1) die("error: no this recorder");

//�����������Ҳ������ôд
//$row=mysql_fetch_object($result);
//$name=$row->name;
//$size=$row->size;
$name = mysql_result($result,0,"file_name");
$size = mysql_result($result,0,"file_size");

mysql_close($conn);

echo "<hr>�ϴ����ļ�����Ϣ��";
echo "<br>The file's name - $name"; 
echo "<br>The file's size - $size"; 
echo "<br><a href=show_add.php?id=$id>����</a>";
?> 

submit.php

<?php 
if(is_uploaded_file($_FILES['myfile']['tmp_name'])) { //�����ϴ��ļ��� 

$myfile=$_FILES["myfile"];

//���ó�ʱ����ʱ��,ȱʡʱ��Ϊ 30��,����Ϊ0ʱΪ����ʱ
$time_limit=60; 
set_time_limit($time_limit); //

//���ļ����ݶ����ַ�����
$fp=fopen($myfile['tmp_name'], "rb");
if(!$fp) die("file open error");
$file_data = addslashes(fread($fp, filesize($myfile['tmp_name'])));
fclose($fp);
unlink($myfile['tmp_name']); 

//�ļ���ʽ,����,��С
$file_type=$myfile["type"];
$file_name=$myfile["name"];
$file_size=$myfile["size"];
die($file_type);
//�������ݿ�,���ļ��浽���ݿ���
$conn=mysql_connect("localhost","root","admin");
if(!$conn) die("error : mysql connect failed");
mysql_select_db("nokiapaymentplat",$conn);

$sql="insert into receive 
(file_data,file_type,file_name,file_size) 
values ('$file_data','$file_type','$file_name',$file_size)";
$result=mysql_query($sql,$conn);

//�������ȡ���˸ղŵ�insert����id
$id=mysql_insert_id();

mysql_close($conn);

set_time_limit(30); //�ָ�ȱʡ��ʱ���� 

echo "�ϴ��ɹ�--- ";
echo "<a href='show_info.php?id=$id'>��ʾ�ϴ��ļ���Ϣ</a>";
} 
else { 
echo "��û���ϴ��κ��ļ�"; 
} 
?> 

upload.php

?<html> 
<head> 
<title>�ļ��ϴ���</title> 
</head> 
<body> 
<table> 
<form enctype='multipart/form-data' name='myform' action='submit.php' 
method='post'> 
<INPUT TYPE = "hidden" NAME = "MAX_FILE_SIZE" VALUE ="1000000">
<tr><td>ѡ���ϴ��ļ�</td><td>
<input name='myfile' type='file'></td></tr> 
<tr><td colspan='2'><input name='submit' value='�ϴ�' type='submit'></td></tr> 
</table> 
</body> 
</html>