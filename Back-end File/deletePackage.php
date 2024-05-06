<?php
include("database.php");
$con = dbconnection();

if (isset($_POST["packageId"])) {
    $packageId = $_POST["packageId"];
} else {
    return;
}

$query = "DELETE FROM `packages` WHERE `packageId` = '$packageId'";
$execute = mysqli_query($con, $query);
$arr = [];

if ($execute) {
    $arr["Success"] = "true";
} else {
    $arr["Success"] = "false";
    $arr["Error"] = "Error Deleting Data : " . mysqli_error($con);
}

print(json_encode($arr));
?>
