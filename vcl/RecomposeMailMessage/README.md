# How to Recompose Received MailMessage with Attachments

The program represents a Delphi tutorial that utilizes the Clever Mail Message and S/MIME Message components to parse / compose E-mail messages in MIME format, with file or image attachments.   

When using the MailMessage component together with the POP3 or IMAP4 clients, the message parts are extracted and saved to the MailMessage members.
If you save the message source with the TclMailMessage.SaveMessage method or access the message source via the TclMailMessage.MessageSource property, the message is recomposed.
Since the attachmets are not stored in memory, the component raises the OnLoadAttachment event in order to get a stream with the attachment content.
As a result, you will not get the original message content. If you want to get the origital source of the received message, please use the TclPop3.Response (TclImap4.Response) property instead.
Otherwise, you will have to implement both the TclMailMessage.OnSaveAttachment and TclMailMessage.OnLoadAttachment event handers.
This is necessary to save emails with attachments, and the given program shows you how to do this.    

The other component, TclSMimeMessage, represents the TclMailMessage descendant and provides an additional functionality to encrypt/decrypt and sign/verify the message using the S/MIME standard.   

The given program utilizes both these components and additionally allows saving digitally verified message source. Comments within the source code will help you to understand how the code works.   

Using this tutorial as a starting point, you can implement your own storage for the attached files and images, including database tables and in-memory streams.   

See also:   
* [Saving mail attachments](https://www.clevercomponents.com/portal/kb/a33/saving-mail-attachments.aspx)
* [Sending Mail with Attachments from Memory Stream](https://www.clevercomponents.com/portal/kb/a121/sending-mail-with-attachments-from-memory-stream.aspx)
* [Adding text and attachments to the E-mail message](https://www.clevercomponents.com/portal/kb/a124/adding-text-and-attachments-to-the-e-mail-message.aspx)

![Screenshot](recompose-mail-message.jpg)

How to compile:   
1. Please clone the [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository.
2. Download and install the [Clever Internet Suite](https://www.clevercomponents.com/downloads/inetsuite/suitedownload.asp) library.
3. Open and compile the RecomposeMailMessage.dproj project in your Delphi IDE.
4. Enjoy.

Please feel free to [Contact Us](https://www.clevercomponents.com/support/) and ask any program related questions.   

Keep updated on [Facebook](http://www.facebook.com/clevercomponents)   [YouTube](https://www.youtube.com/channel/UC9Si4WNQVSeXQMjdEJ8j1fg)   [Twitter](https://twitter.com/CleverComponent)   [Telegram](https://t.me/clevercomponents)   [Newsletter](https://www.clevercomponents.com/home/maillist.asp)   
