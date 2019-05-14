<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title> </title>
</head>
<body>
<?php
include 'connectdb.php';
?>
<h1>Here are your products:</h1>
<ol>
<?php
   $whichOrder= $_POST["order"];
   if( $whichOrder == "ad"){
   $query1='select * from products order by description';
}elseif($whichOrder == "dd"){
   $query1='select * from products order by description DESC';
}elseif($whichOrder == "ap"){
   $query1='select * from products order by cost';
}elseif($whichOrder == "dp"){
   $query1='select * from products order by cost DESC';
}



   $result=mysqli_query($connection,$query1);
    if (!$result) {
         die("database query1 failed.");
     }
    while ($row=mysqli_fetch_assoc($result)) {
        echo '<li>';
        echo $row["description"];
     }
     mysqli_free_result($result);
?>
</ol>
<?php
   mysqli_close($connection);
?>
</body>
</html>
