<?php
   $query = "SELECT * FROM customers order by lastname";
   $result = mysqli_query($connection,$query);
   if(!$result) {
        die("databases query failed.");
    }
   echo "Who are you looking up? </br>";
   while ($row = mysqli_fetch_assoc($result)) {
        echo '<input type="radio" name="customers" value="';
        echo $row["customerid"];
        echo '">' ."Customerid: ".$row["customerid"]. "  Name: ". $row["firstname"]."   ". $row["lastname"]."   Location: ". $row["city"]. "   Phone number: ".$row["phone"]. " agentid: ". $row["agentid"]. "<br>";
   }
   mysqli_free_result($result);
?>
<?php
mysqli_close($connection);
?>
