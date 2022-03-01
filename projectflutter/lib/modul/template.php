<?php
include 'koneksi.php';

$email = $_POST['email'];
$complaint_detail = $_POST['complaint_detail'];

$cek_id_user = mysqli_query($konek, "SELECT customer.id_cust FROM customer INNER JOIN user on customer.id_user = user.id_user WHERE user.email = '" . $email . "'");
$id_cust = mysqli_fetch_assoc($cek_id_user);
$id_cust_final = $id_cust['id_cust'];


$create_data = mysqli_query($konek, "INSERT INTO complaint(id_cust, complaint_detail,handle_by_cs_id,handle_by_tek_id,date_receive,date_est,date_finish,status) VALUES ('" . $id_cust_final . "','" . $complaint_detail . "',null,null,CURRENT_DATE,null,null,'Submit')") or die(mysqli_error($konek));
if ($create_data) {
    echo json_encode(array("massage" => "Upload Success Complaint Data"));
} else {
    echo json_encode(array("massage" => "Upload Complaint Data Failed" . mysqli_error($konek)));
}

$check_last_complaint = mysqli_query($konek, "SELECT * FROM complaint WHERE id_cust = '$id_cust_final' ORDER BY id_complaint DESC LIMIT 1");

$last_complaint_id = mysqli_fetch_assoc($check_last_complaint);
$get_id_complaint = $last_complaint_id['id_complaint'];
$image[] = $_FILES['image']['name'];
$tmpImage[] = $_FILES['image']['tmp_name'];

foreach ($image as $key => $value) {
    foreach ($tmpImage as $key => $temp_value) {
        if (move_uploaded_file($temp_value, 'images/' . $value)) {
            $saveImage = mysqli_query($konek, ("INSERT INTO complaint_image(id_complaint,image) value ('" . $get_id_complaint . "', '" . $value . "')"));
            if ($saveImage) {
                echo json_encode(array("massage" => "Upload Success"));
            } else {
                echo json_encode(array("massage" => "Upload Failed" . mysqli_error($konek)));
            }
        }
    }
}
