# How to Override Default POP3 Server Command Handlers

The program provides a Delphi tutorial that utilizes the Clever POP3 Server component together with the POP3 File Handler component to deliver Emails to clients from your own application.   

![Screenshot](pop3-server-cmd-ovr.jpg)

The [TclPop3Server](https://www.clevercomponents.com/products/inetsuite/popserver.asp) component represents a fully functional multithreaded server with the ability to customize the user and thread performance settings. The server supports all POP3 extensions, according to RFC 1939, RFC 1734, and RFC 2449 protocols.

The other component, TclPop3FileHandler, implements a file-based storage for the user mailboxes and message.   

The given program shows how to override the default POP3 command handlers and implement your own ones. Please check out the STAT and the LIST overrides. Comments within the source code will help you to understand how the code works.   

This program is mostly a simple demos, and by no means, a complete application. It has one predefined user, "CleverTester", with the password "clevertester". You are free to add any number of desired users using the TclPop3Server.UserAccounts property. The server supports both the POP and SASL authorization methods: LOGIN, CRAM-MD5, NTLM, Kerberos.    

See also: [Clever Mail Server](https://github.com/CleverComponents/Clever-Mail-Server)

How to compile:   
1. Please clone the [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository.
2. Download and install the [Clever Internet Suite](https://www.clevercomponents.com/downloads/inetsuite/suitedownload.asp) library.
3. Open and compile the Pop3ServerCmdOverride.dproj project in your Delphi IDE.
4. Enjoy.

Please feel free to [Contact Us](https://www.clevercomponents.com/support/) and ask any program related questions.   

Keep updated on [Facebook](http://www.facebook.com/clevercomponents)   [YouTube](https://www.youtube.com/channel/UC9Si4WNQVSeXQMjdEJ8j1fg)   [Twitter](https://twitter.com/CleverComponent)   [Telegram](https://t.me/clevercomponents)   [Newsletter](https://www.clevercomponents.com/home/maillist.asp)   
