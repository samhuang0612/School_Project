<!DOCTYPE html>
<html>
<?php
   include 'connectdb.php';
?>
<ol>
<?php
   $phoneid= $_POST["checkid"];
   $query ='select * from customers where customerid="' . $phoneid . '"';
   $result = mysqli_query($connection,$query);
   if(!$result) {
        die("databases query failed.");
    }
   while ($row = mysqli_fetch_assoc($result)) {
        echo $row["phone"];
   }
   mysqli_free_result($result);
?>
</ol>
</body>
</html>
