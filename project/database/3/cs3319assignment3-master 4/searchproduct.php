<!DOCTYPE html>
<html>
<body>
<?php
include 'connectdb.php';
?>
<h1>Here are your products infromation :</h1>
<ol>
<?php
   $search= $_POST["search"];
   $query = 'select description, quantity,cost, quantity * cost as "total" from purchinfo  where description in (select products.description from products where productid ="'.$search.'") group by purchinfo.description';
   $result=mysqli_query($connection,$query);
    if (!$result) {
         die("database query failed.");
     }
    while ($row=mysqli_fetch_assoc($result)) {
        echo '<li>';
        echo "Target product:".$row["description"]." Total number be brought:".$row["quantity"]." total cost:".$row["total"];
     }
     mysqli_free_result($result);
?>
</ol>
<?php
   mysqli_close($connection);
?>
</body>
</html>

