<?php
    include("database.php");
    $arr = [];
    $con = dbconnection();

    if (!$con) {
        die("Connection Failed : " . mysqli_connect_error());
    }

    if(isset($_GET["search"])){
        $searchTerm = $_GET["search"];
        $searchTerm = mysqli_real_escape_string($con, $searchTerm);
        $query = "SELECT * FROM `lockers` WHERE `locker_name` LIKE '%" . $searchTerm . "%' ";
        $result = mysqli_query($con, $query);

        if($result){
            $searchResults = [];
            while ($row = mysqli_fetch_assoc($result)){
                $searchResults[] = $row;
            }
            $arr = $searchResults;
        }else{
            $arr["error"] = "Failed to execute search query";
        }
    }else{
        $arr["error"] = "Search term not provided";
    }

    mysqli_close($con);

    echo json_encode($arr);
?>  