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
   $whichCustomer= $_POST["customers"];
   $query='select * from customers, purchinfo where customers.lastname=purchinfo.lastname and customers.customerid="'.$whichCustomer.'"'; 
   $result=mysqli_query($connection,$query);
    if (!$result) {
         die("database query failed.");
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
