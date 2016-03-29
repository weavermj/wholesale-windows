<?php

require("class.phpmailer.php");

$contact_title = $_POST['contact_title'];
$contact_firstname = $_POST['contact_firstname'];
$contact_familyname = $_POST['contact_familyname'];
$contact_street = $_POST['contact_street'];
$contact_postalcode = $_POST['contact_postalcode'];
$contact_city = $_POST['contact_city'];
$contact_county = $_POST['contact_county'];
$contact_phone = $_POST['contact_phone'];
$contact_email = $_POST['contact_email'];

$customer_fullname = $_POST['contact_firstname'] . ' ' .  $_POST['contact_familyname'];

$date_sent = date('l jS F Y h:i:s A');

$msg = "<h1>Brochure Enquiry </h1>";

$msg = $msg . "<h2>Customer Details </h2>";
$msg = $msg . "<p><big><strong>" . $contact_title . " " . $contact_firstname . " " . $contact_familyname . "</strong></big> </p>";
$msg = $msg . "<p>" . $contact_street . ", " . $contact_city . ", " . $contact_county . ". " . $contact_postalcode . " </p>";
$msg = $msg . "<p>Phone: " . $contact_phone . " <br />";
$msg = $msg . "<p>Email: " . $contact_email . " </p>";

$msg = $msg . "<strong>Please send the following brochures:</strong><br />";
$msg = $msg . "<p><ul>";
$msg = addBrochuresRequestedToMessage($msg);
$msg = $msg . "</ul></p>";

$msg = $msg . "<hr>";
$msg = $msg . "<h3>Original Form Information</h2>";

$msg = $msg . "<strong>Title:</strong> " . $contact_title . "<br />" ;
$msg = $msg . "<strong>First name:</strong> " . $contact_firstname . "<br />" ;
$msg = $msg . "<strong>Family name:</strong> " . $contact_familyname . "<br /><br />" ;
$msg = $msg . "<strong>Street:</strong> " . $contact_street . "<br />" ;
$msg = $msg . "<strong>City:</strong> " . $contact_city . "<br />" ;
$msg = $msg . "<strong>County:</strong> " . $contact_county . "<br />" ;
$msg = $msg . "<strong>Postcode:</strong> " . $contact_postalcode . "<br /><br />" ;
$msg = $msg . "<strong>Phone:</strong> " . $contact_phone . "<br />" ;
$msg = $msg . "<strong>Email Address:</strong> " . $contact_email . "<br /><br />" ;
$msg = $msg . "<strong>Date Submitted:</strong> " . $date_sent . "<br /><br />" ;

$msg = $msg . "<strong>Brochures requested:</strong><br />";

$msg = $msg . "<ul>";
$msg = addBrochuresRequestedToMessage($msg) . "</ul>";

function addBrochuresRequestedToMessage($msg) {
	if (isset($_POST['brochure_windows'])) {
		$msg = $msg . "<li>Windows</li>";
	}
	if (isset($_POST['brochure_doors'])) {
		$msg = $msg . "<li>Doors</li>";
	}
	if (isset($_POST['brochure_conservatories'])) {
		$msg = $msg . "<li>Conservatories</li>";
	}
	if (isset($_POST['brochure_bifoldingdoors'])) {
		$msg = $msg . "<li>Bi-Folding Doors</li>";
	}
	if (isset($_POST['brochure_porches'])) {
		$msg = $msg . "<li>Porches</li>";
	}
	if (isset($_POST['brochure_aluminium'])) {
		$msg = $msg . "<li>Aluminium</li>";
	}
	if (isset($_POST['brochure_pvc'])) {
		$msg = $msg . "<li>PVC</li>";
	}
	if (isset($_POST['brochure_rockdoor'])) {
		$msg = $msg . "<li>Rock Doors</li>";
	}
	if (isset($_POST['brochure_pvcdoor'])) {
		$msg = $msg . "<li>PVC Doors</li>";
	}
	return $msg;
}

$mail = new PHPMailer();

$mail->IsSMTP(); // telling the class to use SMTP
$mail->Host       = "mail.wholesale-windows.co.uk"; // SMTP server
$mail->SMTPDebug  = 1;                     // enables SMTP debug information (for testing)
                                           // 1 = errors and messages
                                           // 2 = messages only
$mail->SMTPAuth   = true;                  // enable SMTP authentication
$mail->Host       = "mail.wholesale-windows.co.uk"; // sets the SMTP server
$mail->Port       = 25;                    // set the SMTP port for the GMAIL server
$mail->Username   = "noreply@wholesale-windows.co.uk"; // SMTP account username
$mail->Password   = "XXXXXXX";        // SMTP account password
$mail->SetFrom('noreply@wholesale-windows.co.uk', 'Wholesale Windows Website', false);
$mail->AddReplyTo($contact_email, $customer_fullname);
$mail->Subject    = "Brochure Enquiry";
// $mail->AltBody    = "To view the message, please use an HTML compatible email viewer!"; // optional, comment out and test
$mail->AddAddress("donna@wholesale-windows.co.uk");
$mail->AddCC("kate@wholesale-windows.co.uk");
#$mail->AddBCC("weavermjw@googlemail.com");
$mail->Body     = $msg;
$mail->msgHTML($msg);
$mail->WordWrap = 50;
$mail->Send();

$customer_msg = "Dear " . $contact_title . " " . $contact_familyname . ", <br /><br />";
$customer_msg = $customer_msg . "Thank you for requesting a brochure from our team at Wholesale Windows. We have received your request and will post your selection of brochures out to you shortly at the following address:<br /><br />";
$customer_msg = $customer_msg . $contact_street . "<br />";
$customer_msg = $customer_msg . $contact_city . "<br />";
$customer_msg = $customer_msg . $contact_county . "<br />";
$customer_msg = $customer_msg . $contact_postalcode . "<br /><br />";

$customer_msg = $customer_msg . "Best regards,<br />";
$customer_msg = $customer_msg . "The Wholesale Windows Sales Team<br /><br />";
$customer_msg = $customer_msg . "Tel: 0151-334-4004<br />";
$customer_msg = $customer_msg . "E-mail: sales@wholesale-windows.co.uk";

$customer_mail = new PHPMailer();

$customer_mail->IsSMTP(); // telling the class to use SMTP
$customer_mail->Host       = "mail.wholesale-windows.co.uk"; // SMTP server
$customer_mail->SMTPDebug  = 0; 
$customer_mail->SMTPAuth   = true;                  // enable SMTP authentication
$customer_mail->Host       = "mail.wholesale-windows.co.uk"; // sets the SMTP server
$customer_mail->Port       = 25;                    // set the SMTP port for the GMAIL server
$customer_mail->Username   = "noreply@wholesale-windows.co.uk"; // SMTP account username
$customer_mail->Password   = "XXXXXXX";        // SMTP account password
$customer_mail->SetFrom('sales@wholesale-windows.co.uk', 'Wholesale Windows');
$customer_mail->Subject    = "Brochure Request";
$customer_mail->AddAddress($contact_email);
$customer_mail->Body     = $customer_msg;
$customer_mail->msgHTML($customer_msg);
$customer_mail->WordWrap = 50;

$customer_mail->Send();

header( 'Location: thankyou-brochure.html' ) ;
?>

