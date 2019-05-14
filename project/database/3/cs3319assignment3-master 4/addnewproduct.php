<!DOCTYPE html>
<html>
<body>
<?php
    include 'connectdb.php';
    ?>
<ol>
<?php
    $customerID= $_POST["customerID"];
    $productID = $_POST["productID"];
    $number =$_POST["number"];
    $query1='select * from customers where customerid= "'.$customerID. '"';
    $query2='select * from products  where productid= "'.$productID. '"';
    $query3= 'select * from purchasing where purchasing.productid="' . $productID . '" and purchasing.customerid="' . $customerID . '"';
    $result=mysqli_query($connection,$query3);
    $row = mysqli_fetch_assoc($result);
    $result2=mysqli_query($connection,$query1);
    $result3=mysqli_query($connection,$query2);
    $row2 = mysqli_fetch_assoc($result2);
    $row3 = mysqli_fetch_assoc($result3);
    if($row2 == null) {
        die("customerid doesn't exist.");
    }
    if($row3 == null) {
        die("productid doesn't exist.");
    }
    if(!$result) {
        die("database quantity query failed.");
    }
    if($row != null){
        if($row["quantity"]<$number){
            die("number is to small.");
        }else{
            $newkey = intval($row["quantity"]) + $number;
            $productid = (string)$newkey;
            $query = 'UPDATE purchasing SET quantity = "' . $newkey . '" where customerid = "' . $customerID . '" and productid="' . $productID . '"';
            if (!mysqli_query($connection, $query)) {
                die("Error: add new product fail" . mysqli_error($connection));
            }
            echo "Your new product  was added!";
        }
    }else{
        $query = 'INSERT INTO purchasing values("'.$customerID.'","'.$productID.'","'.$number.'")';
        if (!mysqli_query($connection, $query)) {
            die("Error: add new product fail" . mysqli_error($connection));
        }
        echo "Your new product  was added!";
        
    }
    mysqli_close($connection);
    ?>
</ol>
</body>
</html>
