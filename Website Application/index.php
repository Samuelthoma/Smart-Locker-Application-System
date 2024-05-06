<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/3.3.3/adapter.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.1.10/vue.min.js"></script>
    <script type="text/javascript" src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
    <link rel="stylesheet" href="./style.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
    />
    <title>Easy Locker | Locker</title>
  </head>
  <body>
    <div class="container">
      <div class="btn-box">
        <button class="tab active">
          <i class="fa-solid fa-truck-fast"></i>Drop Package
        </button>
        <button class="tab">
          <i class="fa-solid fa-boxes-stacked"></i>Pick-Up Package
        </button>
      </div>
      <div class="content-box">
        <div class="content active">
          <div class="form-container">
            <form method="POST" id="form">
              <label for="shippingId">Shipping Id : </label><br /><br />
              <input
                id="shippingId"
                type="text"
                name="shippingId"
                placeholder="Please Input The Shipping ID"
                required
              />
              <br /><br />
              <button name="submit" type="submit" class="button">
                Drop Package
              </button>
            </form>
          </div>
        </div>

        <div class="content" style="height: 470px;">
          <div class="reader" id="qr-reader">
            <video id="preview" width="auto" height="275px"></video>
          </div><br>

          <form method="post" class="form-horizontal">
            <center>
              <label style="font-size: 20px; font-weight: bold;">Please Scan Your QR-Code
              </label>
            </center>
          
            <center>
              <input type="text" name="shipping-Id" id="shipping-Id" readonly 
              class="form-control" placeholder="Your Shipping ID" 
              style="width: 325px;">
            </center><br>
            <center>
              <button name="submitQr" type="submit" class="button" style="width: 325px;">
                Take Package
              </button>
            </center>

          </form>
        </div>
      </div>
    </div>

    <script>
      const tabs = document.querySelectorAll(".tab");
      const content = document.querySelectorAll(".content");
      tabs.forEach((tab, index) => {
        tab.addEventListener("click", () => {
          tabs.forEach((tab) => {
            tab.classList.remove("active");
          });
          tab.classList.add("active");
          content.forEach((content) => {
            content.classList.remove("active");
          });
          content[index].classList.add("active");
        });
      });

      let scanner = new Instascan.Scanner({ video: document.getElementById('preview')});
      Instascan.Camera.getCameras().then(function(cameras) {
          if(cameras.length > 0){
            scanner.start(cameras[0]);
          }else{
            alert('No Camera Found');
          }
      }).catch(function(e){
        console.error(e);
      });

      scanner.addListener('scan', function(c){
        document.getElementById('shipping-Id').value=c;
        document.forms[0].submit();
      });

    </script>
  </body>
</html>

<?php
  include("./config.php");

  if(isset($_POST["submit"])){
    $submittedId = $_POST["shippingId"];

    $query = "SELECT * FROM packages WHERE packageId = ?";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "s", $submittedId);
    mysqli_stmt_execute($stmt);
    
    $result = mysqli_stmt_get_result($stmt);
    
    if(mysqli_num_rows($result) > 0){
        $insertQuery = "INSERT INTO dropoff (packageId) VALUES (?)";
        $insertStmt = mysqli_prepare($conn, $insertQuery);
        mysqli_stmt_bind_param($insertStmt, "s", $submittedId);
        mysqli_stmt_execute($insertStmt);

        $deleteQuery = "DELETE FROM packages WHERE packageId = ?";
        $deleteStmt = mysqli_prepare($conn, $deleteQuery);
        mysqli_stmt_bind_param($deleteStmt, "s", $submittedId);
        mysqli_stmt_execute($deleteStmt);

        echo '<script>';
        echo 'swal({';
        echo 'title: "Success",';
        echo 'text: "Thank you for your great service, we hope to see you again anytime soon. Have a nice day",';
        echo 'icon: "success",';
        echo 'button: "Okay",';
        echo '});';
        echo '</script>';
    } else{
        echo '<script>';
        echo 'swal({';
        echo 'title: "Error",';
        echo 'text: "Sorry, There Was Not Any Recipient For That Package In Our System",';
        echo 'icon: "error",';
        echo 'button: "Okay",';
        echo '});';
        echo '</script>';
    }
    mysqli_free_result($result);
  }
?>

<?php
    if(isset($_POST['submitQr'])){
        $shippingId = $_POST['shipping-Id'];
        $query = "SELECT * FROM dropoff WHERE packageId = ?";
        $stmt = mysqli_prepare($conn, $query);
        mysqli_stmt_bind_param($stmt, "s", $shippingId);
        mysqli_stmt_execute($stmt);

        $resultQR = mysqli_stmt_get_result($stmt);

        if(mysqli_num_rows($resultQR) > 0){
          $deleteQuery = "DELETE FROM dropoff WHERE packageId = ?";
          $deleteStmt = mysqli_prepare($conn, $deleteQuery);
          mysqli_stmt_bind_param($deleteStmt, "s", $shippingId);
          mysqli_stmt_execute($deleteStmt);

            echo '<script>';
            echo 'swal({';
            echo 'title: "Success",';
            echo 'text: "Thank you for using our service, we hope to see you again anytime soon. Have a wonderful day ^^",';
            echo 'icon: "success",';
            echo 'button: "Okay",';
            echo '});';
            echo '</script>';
        } else{
            echo '<script>';
            echo 'swal({';
            echo 'title: "Error",';
            echo 'text: "Sorry, The QR-Code Is Invalid",';
            echo 'icon: "error",';
            echo 'button: "Okay",';
            echo '});';
            echo '</script>';
        } 
        mysqli_free_result($resultQR);
    }
?>