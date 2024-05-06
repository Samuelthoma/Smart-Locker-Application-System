<?php

$host = 'localhost';
$username = 'root';
$password = '';
$database = 'economic';

$connection = new mysqli($host, $username, $password, $database);

if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}

$shippingId = $_POST['shippingId'] ?? '';
$recipient = $_POST['recipient'] ?? '';

$sqlSelect = "SELECT * FROM packages WHERE packageId = ? AND packageCustomerName = ?";
$stmtSelect = $connection->prepare($sqlSelect);
$stmtSelect->bind_param("ss", $shippingId, $recipient);

$stmtSelect->execute();
$result = $stmtSelect->get_result();

$response = [];

if ($result->num_rows > 0) {
    // Data exists, insert into new table
    $sqlInsert = "INSERT INTO dropoff (packageId, packageCustomerName) VALUES (?, ?)";
    $stmtInsert = $connection->prepare($sqlInsert);
    $stmtInsert->bind_param("ss", $shippingId, $recipient);
    $stmtInsert->execute();

    $response['message'] = 'Thank You';
} else {
    $response['message'] = 'Invalid Inputed Data';
}

header('Content-Type: application/json');
echo json_encode($response);

$stmtSelect->close();
$connection->close();
?>
