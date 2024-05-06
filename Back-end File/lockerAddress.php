<?php
include("database.php");

$arr = [];
$con = dbconnection();

if (!$con) {
    die("Connection Failed : " . mysqli_connect_error());
}

if(isset($_GET["id"])){
    $lockerId = $_GET["id"];
    $lockerId = mysqli_real_escape_string($con, $lockerId);
    $query = "SELECT * FROM `lockers` WHERE `id` = '$lockerId'";
    $result = mysqli_query($con, $query);

    if($result && mysqli_num_rows($result) > 0){
        $locker = mysqli_fetch_assoc($result);
        $arr['address'] = $locker['address']; 
    } else {
        $arr["error"] = "Locker not found";
    }
} else {
    $arr["error"] = "Locker ID not provided";
}

mysqli_close($con);

echo json_encode($arr);
?>
