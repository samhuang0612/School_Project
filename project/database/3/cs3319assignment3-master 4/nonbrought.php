<!DOCTYPE html>
<html>
<body>
<?php
include 'connectdb.php';
?>
<h1>Here are the  products never been brought:</h1>
<ol>
<?php
   $query = 'select description,quantity from products where productid not in (select productid from purchasing where customerid in (select customerid from customers))';
   $result=mysqli_query($connection,$query);
    if (!$result) {
         die("database query failed.");
     }
    while ($row=mysqli_fetch_assoc($result)) {
        echo '<li>';
        echo $row["description"]." ".$row["quantity"] ;
     }
     mysqli_free_result($result);
?>
</ol>
<?php
   mysqli_close($connection);
?>
</body>
</html>
