<?php
    include("database.php");

    $arr = [];

    if(isset($_POST["email"]) && isset($_POST["password"])){
        $email = $_POST["email"];
        $password = $_POST["password"];
        $con = dbconnection();
        $email = mysqli_real_escape_string($con, $email);
        $getUserQuery = "SELECT * FROM `users` WHERE `email` = '$email'";
        $userResult = mysqli_query($con, $getUserQuery);

        if ($userResult && $userResult->num_rows > 0) {
            $userRow = $userResult->fetch_assoc();
        
            if (password_verify($password, $userRow['password'])) {
                $arr["Success"] = "true";
            }else{
                $arr["Success"] = "false";
            }
        }else{
            $arr["Success"] = "false";
        }
        mysqli_close($con);
    }else{
        $arr["Success"] = "false";
    }
    echo json_encode($arr);
?>