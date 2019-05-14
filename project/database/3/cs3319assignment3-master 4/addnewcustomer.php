<!DOCTYPE html>
<html>
<body>
<?php
   include 'connectdb.php';
?>
<ol>
<?php
   $customerID= $_POST["customerid"];
   $fname = $_POST["fname"];
   $lname =$_POST["lname"];
   $city = $_POST["city"];
   $phone = $_POST["phone"];
   $agentid = $_POST["agent"];
   $query1 ='select * from customers where customerid="' . $customerID . '"';
   $result=mysqli_query($connection, $query1);
   $row = mysqli_fetch_assoc($result);
   if($row != null){
       die("customer already existed.");
   }
   $query = 'INSERT INTO customers VALUES("' . $customerID . '", "' . $fname . '" , "' . $lname . '", "' . $city . '", "' . $phone . '" , "' . $agentid . '")';
   if (!mysqli_query($connection, $query)) {
        die("Error: insert failed" . mysqli_error($connection));
    }
   echo "Your customer was added!";
   mysqli_close($connection);
?>
</ol>
</body>
</html>

