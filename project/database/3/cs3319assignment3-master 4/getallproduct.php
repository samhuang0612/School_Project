
<?php
   $query = "SELECT * FROM products";
   $result = mysqli_query($connection,$query);
   if (!$result) {
        die("databases query failed.");
    }
   echo "Who are you looking up? </br>";
   while ($row = mysqli_fetch_assoc($result)) {
        echo '<input type="radio" name="products" value="';
        echo $row["productid"];
        echo '">'. $row["description"]. ":". $row["cost"]. "<br>";
   }
   mysqli_free_result($result);
?>
