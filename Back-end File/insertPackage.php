<?php
include("database.php");
$con = dbconnection();

$arr = [];

if (isset($_POST["packageId"])) {
    $packageId = $_POST['packageId'];
} else {
    $arr["Success"] = "false";
    $arr["Error"] = "Package ID is missing";
    echo json_encode($arr);
    exit; 
}

if (isset($_POST["packageCustomerNo"])) {
    $packageCustomerNo = $_POST['packageCustomerNo'];
} else {
    $arr["Success"] = "false";
    $arr["Error"] = "Package Customer No is missing";
    echo json_encode($arr);
    exit;
}

if (isset($_POST["packageCustomerName"])) {
    $packageCustomerName = $_POST['packageCustomerName'];
} else {
    $arr["Success"] = "false";
    $arr["Error"] = "Package Customer Name is missing";
    echo json_encode($arr);
    exit;
}

$query = "INSERT INTO `packages` (`id`, `packageId`, `packageCustomerNo`, `packageCustomerName`) 
          VALUES (NULL, '$packageId', '$packageCustomerNo', '$packageCustomerName')";

$execute = mysqli_query($con, $query);

if ($execute) {
    $arr["Success"] = "true";
} else {
    $arr["Success"] = "false";
    $arr["Error"] = "Error executing query: " . mysqli_error($con);
}

echo json_encode($arr);
?>
