<?php
include 'koneksi.php';

$email = $_POST['email'];

$cek_id_user = mysqli_query($konek, "SELECT customer.id_cust FROM customer INNER join user on customer.id_user = user.id_user WHERE user.email = 'cust@test.com'");
$id_cust_data = mysqli_fetch_assoc($cek_id_user);
$id_cust = $id_cust_data['id_cust'];

$get_complaint_list = mysqli_query($konek, "SELECT * from complaint where id_cust = '" . $id_cust . "'");
$complaint_list = mysqli_fetch_assoc($get_complaint_list);
$response = array();
while ($complaint_list) {
    $response[] = $complaint_list;
}

echo json_encode($response);
