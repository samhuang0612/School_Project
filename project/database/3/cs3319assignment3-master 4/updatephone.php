<!DOCTYPE html>
<html>
<body>
<?php
   include 'connectdb.php';
?>
<ol>
<?php
   $checkid= $_POST["checkid"];
   $newphone = $_POST["newphone"];
   $query = 'UPDATE customers SET phone="' . $newphone . '" where customerid = "' . $checkid . '"';
   if (!mysqli_query($connection, $query)) {
        die("Error: update failed" . mysqli_error($connection));
   }
   echo "Your phone number was updated!";
   mysqli_close($connection);
?>
</ol>
</body>
</html>
