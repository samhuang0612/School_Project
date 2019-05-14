<!DOCTYPE html>
<html>
<?php
   include 'connectdb.php';
?>
<ol>
<?php
   $deleteid= $_POST["deleteid"];
   $query1 ='select * from customers where customerid="' . $deleteid . '"';
   $result = mysqli_query($connection,$query1);
   $row = mysqli_fetch_row($result);
   if($row==null) {
        die("customerid doesn't exist.");
    }
   $query='delete from customers where customerid ="' . $deleteid . '"';
   if (!mysqli_query($connection, $query)) {
        die("Error: deleted failed" . mysqli_error($connection));
   }
   echo "Your customers was deleted!";
   mysqli_close($connection);
?>
</ol>
</body>
</html>
