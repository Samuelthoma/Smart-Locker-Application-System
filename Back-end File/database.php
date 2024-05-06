<?php
    function dbconnection(){
        $con = mysqli_connect("localhost", "root", "", "economic");
        return $con;
    }
?>