<?php
include("database.php");

$arr = [];

if (isset($_POST["email"]) && isset($_POST["password"])) {
    $email = $_POST["email"];
    $password = $_POST["password"];
    $con = dbconnection();
    $email = mysqli_real_escape_string($con, $email);
    $emailCheckQuery = "SELECT * FROM `users` WHERE `email` = '$email'";
    $emailCheckResult = mysqli_query($con, $emailCheckQuery);

    if ($emailCheckResult && $emailCheckResult->num_rows > 0) {
        $arr["duplicate"] = "true";
    } else {
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
        $insertQuery = "INSERT INTO `users` (`email`, `password`) VALUES ('$email', '$hashedPassword')";
        $insertResult = mysqli_query($con, $insertQuery);

        if ($insertResult) {
            $arr["duplicate"] = "false";
            $arr["Success"] = "true";
        } else {
            $arr["Success"] = "false";
        }
    }

    mysqli_close($con);
} else {
    $arr["duplicate"] = "false";
}

echo json_encode($arr);
?>
