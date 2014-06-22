<!-- ASP Code Section  --> 
 
<% 
 'initialise objects and variables 
 dim JMail, intComp, strReferer, strServer, strClientIP, strServerIP, blnSpam 
 Set JMail = Server.CreateObject("JMail.SMTPMail")  

 strReferer = request.servervariables("HTTP_REFERER") 
 strServer = Replace(request.servervariables("SERVER_NAME"),"www.", "") 
 strClientIP = request.servervariables("REMOTE_ADDR") 
 strServerIP = request.servervariables("LOCAL_ADDR") 
 intComp = inStr(strReferer, strServer) 
 If intComp > 0 Then  
  blnSpam = False 
 Else 
  ' Spam Attempt Block 
  blnSpam = True 
 End If 
 
 
 
 ' This is my local SMTP server 
 JMail.ServerAddress = "smtp." & strServer & ":25" 
  
 ' This is me....  
 JMail.Sender = "root@wholesale-windows.co.uk"
 JMail.Subject = "Brochure Request:" & " Sent @ " & now() 
  
 ' Get the recipients mailbox from a form 

 JMail.AddRecipient "donna@wholesale-windows.co.uk" 
' JMail.AddRecipient "tom.hebdige@sky.com"
  newbody = ""
 newbody = newbody & "Brochure Request: " &  vbcrlf
 newbody = newbody & request.form("contact_title") & " " & request.form("contact_firstname") & vbcrlf
 newbody = newbody & request.form("contact_familyname") &  vbcrlf
 newbody = newbody & request.form("contact_street") &  vbcrlf
 newbody = newbody & request.form("contact_postalcode") &  vbcrlf
 newbody = newbody & request.form("contact_city") &  vbcrlf
 newbody = newbody & request.form("contact_phone") &  vbcrlf
 newbody = newbody & request.form("email") &  vbcrlf
 newbody = newbody & request.form("message") &  vbcrlf

   
 JMail.Body =  newbody
 
 JMail.Priority = 3 
  
 JMail.AddHeader "Originating-IP", strClientIP 
 
 'send mail 
 
 If NOT blnSpam Then 
 JMail.Execute 
 strResult =  "Mail Sent." 
 response.redirect("thankyou.html")
 End If 
 
%> 
<!-- HTML Output Section  --> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 
Transitional//EN"> 
<html> 
 <head> 
  <title>Brochure Request</title> 
 </head> 
 <body topmargin="0" leftmargin="0" 
style="font-family: Verdana; font-size: 8pt"> 
  
 
 
 </body> 
</html> 

