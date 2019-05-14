<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Customer information</title>
</head>
<body>
<?php
include 'connectdb.php';
?>
<h1>Introduce to customer information</h1>
<h2>Our Customers</h2>
<form action="getproduct.php" method="post">
<?php
   include 'getdata.php';
?>
<input type="submit" value="Get Customer information">
</form>
<h3>Product by order</h3>
<form action="posproduct.php" method="post">
<input type="radio" name="order" value="ad">Ascending by description <br>
<input type="radio" name="order" value="dd">Decending by description <br>
<input type="radio" name="order" value="ap">Ascending by price <br>
<input type="radio" name="order" value="dp">Decending by price <br>
<input type="submit" value="Choose your order">
</form>
<h4>Add New Purchase></h4>
<form action="addnewproduct.php" method="post">
New Purchasing number: <input type="text" name="number"><br>
New Purchasing customerID: <input type="text" name="customerID"><br>
New purchasing productID: <input type="text" name="productID"><br>
<input type="submit" value="Add New Purchasing">
</form>
<h5>Add New Customer></h5>
<form action="addnewcustomer.php" method="post">
New Customer firstname: <input type="text" name="fname"><br>
New Customer lastname: <input type="text" name="lname"><br>
New CusomterID <input type="text" name="customerid"><br>
New Cusomter city  <input type="text" name="city"><br>
New Cusomter phone <input type="text" name="phone"><br>
New Cusomter agentid <input type="text" name="agent"><br>
<input type="submit" value="Add New Customer">
</form>
<h6>Update Phone number></h6>
<form action="" method="post">
which customerid changes phone number : <input type="text" name="checkid"><br>
<input type="submit" value="Check phone number">
</form>
<?php

if (isset($_POST["checkid"]))  {

$phoneid= $_POST["checkid"];
   $query ='select * from customers where customerid="' . $phoneid . '"';
   include 'connectdb.php';
   $result = mysqli_query($connection,$query);
   if(!$result) {
        die("databases query failed.");
    }
   while ($row = mysqli_fetch_assoc($result)) {
        echo $row["phone"];
   }
   mysqli_free_result($result);
   echo   ' <form action="" method="post">';
   echo 'Input new phone number: <input type="text" name="newphone"><br>';
   echo ' <input type="submit" value="Update phone number">';
   echo '<input type="hidden" name="cusid" value="'. $phoneid . '">';
   echo '</form>';
}
if(isset($_POST["newphone"])){
   include 'connectdb.php';
   $checkid= $_POST["cusid"];
   $newphone = $_POST["newphone"];
   $query = 'UPDATE customers SET phone="' . $newphone . '" where customerid = "'.$checkid . '"';
  echo $query;
   if (!mysqli_query($connection, $query)) {
        die("Error: update failed" . mysqli_error($connection));
   }
   echo "Your phone number was updated!";
   mysqli_close($connection);
}
?>
<h7>Delete Customer></h7>
<form action="deletecustomer.php" method="post">
CustomerID to be deleted: <input type="text" name="deleteid"><br>
<input type="submit" value="Delete customer">
</form>
<h8>Display who bought more than a given quantity of any product></h8>
<form action="display.php" method="post">
More than which number quantity: <input type="text" name="quantity"><br>
<input type="submit" value="Display">
</form>
<h8>Product never been brought></h8>
<?php
   include 'nonbrought.php';
?>
<h9>Search for particular product></h9>
<form action="searchproduct.php" method="post">
Which productid want to search for: <input type="text" name="search"><br>
<input type="submit" value="Show result">
</form>
</body>
</html> 
