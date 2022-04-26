# SFTP Client with Host-key Repository

This Delphi app implements a simple host key repository that keeps all known and verified by user SFTP host-keys and automatically accepts connections to these hosts.   

![Screenshot](sftp-hostkey-repo.jpg)

The [SFTP Component](https://www.clevercomponents.com/products/inetsuite/sftpclient.asp) provides all necessary remote host information through the OnVerifyServer event: host name, key type, finger-print, and host-key bytes. You can save this information, e.g. as a string to the TStringList object in your program. This allows you to easily save the string list content to the disk, and load the list next time you run the app.   

The program connects to an SFTP host via the Secure Shell protocol (SSH), authorizes with the user/password or the Public Key algorithms, lists, downloads, and uploads files.   

This program is mostly a simple demos, and by no means, a complete application. You are free to use it as a starting point to develop your own functionality.   

See also: [SFTP Client](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/SFtpClient)

How to compile:   
1. Please clone the [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository.
2. Download and install the [Clever Internet Suite](https://www.clevercomponents.com/downloads/inetsuite/suitedownload.asp) library.
3. Open and compile the SFtpClientHostKey.dproj project in your Delphi IDE.
4. Enjoy.

Please feel free to [Contact Us](https://www.clevercomponents.com/support/) and ask any program related questions.   

Keep updated on [Facebook](http://www.facebook.com/clevercomponents)   [YouTube](https://www.youtube.com/channel/UC9Si4WNQVSeXQMjdEJ8j1fg)   [Twitter](https://twitter.com/CleverComponent)   [Telegram](https://t.me/clevercomponents)   [Newsletter](https://www.clevercomponents.com/home/maillist.asp)   
