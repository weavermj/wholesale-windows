<?php

include("./_credentials/smtp.php");
require("class.phpmailer.php");

$contact_title = $_POST['contact_title'];
$contact_firstname = $_POST['contact_firstname'];
$contact_familyname = $_POST['contact_familyname'];
$contact_street = $_POST['contact_street'];
$contact_postalcode = $_POST['contact_postalcode'];
$contact_city = $_POST['contact_city'];
$daytime_phone = $_POST['daytime_phone'];
$mobile_phone = $_POST['mobile_phone'];
$contact_email = $_POST['contact_email'];
$contact_message = $_POST['contact_message'];

$customer_fullname = $_POST['contact_firstname'] . ' ' .  $_POST['contact_familyname'];
$date_sent = date('l jS F Y h:i:s A');

$contact_message = nl2br($contact_message);

$msg = "<h1>Website Enquiry </h1>";

$msg = $msg . "<h2>Customer Details </h2>";
$msg = $msg . "<p><big><strong>" . $contact_title . " " . $contact_firstname . " " . $contact_familyname . "</strong></big> </p>";
$msg = $msg . "<p>" . $contact_street . ", " . $contact_city . ". " . $contact_postalcode . " </p>";
$msg = $msg . "<p>Daytime: " . $daytime_phone . " <br />";
$msg = $msg . "<p>Mobile: " . $mobile_phone . " </p>";
$msg = $msg . "<p>Email: " . $contact_email . " </p>";

$msg = $msg . "<h2>Message </h2>";
$msg = $msg . "<p>". $contact_message . "</p>";

$msg = $msg . "<hr>";

$msg = $msg . "<h3>Original Form Information</h2>";

$msg = $msg . "<strong>Title:</strong> " . $contact_title . "<br />" ;
$msg = $msg . "<strong>First name:</strong> " . $contact_firstname . "<br />" ;
$msg = $msg . "<strong>Family name:</strong> " . $contact_familyname . "<br /><br />" ;
$msg = $msg . "<strong>Street:</strong> " . $contact_street . "<br />" ;
$msg = $msg . "<strong>City:</strong> " . $contact_city . "<br />" ;
$msg = $msg . "<strong>Postcode:</strong> " . $contact_postalcode . "<br /><br />" ;
$msg = $msg . "<strong>Daytime Phone:</strong> " . $daytime_phone . "<br />" ;
$msg = $msg . "<strong>Mobile Phone:</strong> " . $mobile_phone . "<br />" ;
$msg = $msg . "<strong>Email Address:</strong> " . $contact_email . "<br /><br />" ;
$msg = $msg . "<strong>Date Submitted:</strong> " . $date_sent . "<br /><br />" ;


$mail = new PHPMailer();

$mail->IsSMTP(); // telling the class to use SMTP
$mail->Host       = "mail.wholesale-windows.co.uk"; // SMTP server
$mail->SMTPDebug  = 1;                     // enables SMTP debug information (for testing)
                                           // 1 = errors and messages
                                           // 2 = messages only
$mail->SMTPAuth   = true;                  // enable SMTP authentication
$mail->Host       = "mail.wholesale-windows.co.uk"; // sets the SMTP server
$mail->Port       = 25;                    // set the SMTP port for the GMAIL server
$mail->Username   = $smtp_user; // SMTP account username
$mail->Password   = $smtp_password;        // SMTP account password
$mail->SetFrom('noreply@wholesale-windows.co.uk', 'Wholesale Windows Website', false);
$mail->AddReplyTo($contact_email, $customer_fullname);
$mail->Subject    = "Website Enquiry";
// $mail->AltBody    = "To view the message, please use an HTML compatible email viewer!"; // optional, comment out and test
$mail->AddAddress("donna@wholesale-windows.co.uk");
$mail->AddCC("sales@wholesale-windows.co.uk");
$mail->AddCC("mike@wholesale-windows.co.uk");
$mail->AddCC("cheyenne@wholesale-windows.co.uk");
$mail->AddCC("michaela@wholesale-windows.co.uk");
$mail->AddCC("enquiries@wholesale-window.co.uk");
#$mail->AddBCC("weavermjw@googlemail.com");
$mail->Body     = $msg;
$mail->msgHTML($msg);
$mail->WordWrap = 50;

$mail->Send();


$customer_msg = "Dear " . $contact_title . " " . $contact_familyname . ", <br /><br />";
$customer_msg = $customer_msg . "Thank you for contacting our team at Wholesale Windows. We have received your enquiry and will respond to you shortly.<br /><br />";
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
$customer_mail->Username   = $smtp_user; // SMTP account username
$customer_mail->Password   = $smtp_password;        // SMTP account password
$customer_mail->SetFrom('enquiries@wholesale-window.co.uk', 'Wholesale Windows');
$customer_mail->Subject    = "Website Enquiry";
$customer_mail->AddAddress($contact_email);
$customer_mail->Body     = $customer_msg;
$customer_mail->msgHTML($customer_msg);
$customer_mail->WordWrap = 50;

$customer_mail->Send();

header( 'Location: thankyou-contact.html' ) ;
?>

