# MailSend with TMS FNC RichEditor

The program represents a Delphi tutorial that utilizes the TMS FNC UI RichEditor and Clever SMTP components to compose and send HTML E-mails.   

This Delphi program represents a mostly simple demos and by no means, a complete application. It's intended to demonstrate how to use the [SMTP](https://www.clevercomponents.com/products/inetsuite/smtp.asp) component together with the [TMS FNC UI RichEditor](https://www.tmssoftware.com/site/tmsfncuipack.asp?s=fncricheditor#features) in your Delphi application. Additionally, the program uses the [MailMessage](https://www.clevercomponents.com/products/inetsuite/messageparser.asp) component, which allows you to create E-mails in the MIME format, including message headers, text- and HTML bodies, file attachments, and embedded images. The [HtmlParser](https://www.clevercomponents.com/products/inetsuite/htmlparser.asp) component parses the HTML content, extracts embedded images, and produces a text-plain representation of the HTML message body.  

The program allows you to authenticate using the username/password information. Also the SMTP component supports the OAUTH2.0, Digest, NTLM, and other SASL authentication methods. Please check out the following example to learn how to use the OAUTH2.0 protocol together with this components: [GMail SMTP Client](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/GMailSMTP)   

The SMTP client component completely supports the SSL/TLS mode, including the client certificate authorization and the server validation process. The following example shows how to connect to a mail server via TLS: [SMTP Client SSL](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/SmtpClientSSL)   

![Screenshot](mailsend-tms-richedit.jpg)

How to compile:   
1. Please clone the [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository.
2. Download and install the [Clever Internet Suite](https://www.clevercomponents.com/downloads/inetsuite/suitedownload.asp) library.
3. Download and install the [TMS FNC UI Pack](https://www.tmssoftware.com/site/tmsfncuipack.asp) library.
4. Open and compile the MailSendTMSRichEditor project in your Delphi IDE.
5. Enjoy.

Please feel free to [Contact Us](https://www.clevercomponents.com/support/) and ask any program related questions.   

Keep updated on [Facebook](http://www.facebook.com/clevercomponents)   [YouTube](https://www.youtube.com/channel/UC9Si4WNQVSeXQMjdEJ8j1fg)   [Twitter](https://twitter.com/CleverComponent)   [Telegram](https://t.me/clevercomponents)   [Newsletter](https://www.clevercomponents.com/home/maillist.asp)   
