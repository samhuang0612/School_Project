<!DOCTYPE html>
<html>
<?php
   include 'connectdb.php';
?>
<ol>
<?php
   $quantity= $_POST["quantity"];
   $query = 'select purchasing.customerid,sum(purchasing.quantity) as "sum",customers.firstname,customers.lastname from purchasing join customers on purchasing.customerid=customers.customerid group by purchasing.customerid having sum >'. $quantity. '';
   echo $query;
   
   $result = mysqli_query($connection,$query);
   if(!$result) {
        die("databases delete failed - in more than some purchases");
    }
    while ($row = mysqli_fetch_assoc($result)) {
        echo "Customer name: ". $row["firstname"]." ". $row["lastname"]. "   quantity: ".$row["sum"]. "<br>";
   }
   mysqli_close($connection);
?>
</ol>
</body>
</html>
