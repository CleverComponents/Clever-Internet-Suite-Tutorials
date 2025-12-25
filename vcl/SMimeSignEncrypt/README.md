# Signing and Encrypting Mail via S/MIME

The SMimeSignEncrypt project represents a code example for the [Signing and Encrypting Mail via S/MIME](https://www.clevercomponents.com/portal/kb/a112/signing-and-encrypting-mail-via-s-mime.aspx) tutorial. This tutorial demonstrates how to sign and encrypt email messages using digital signatures and encryption via the S/MIME standard.

## Overview
This Delphi application demonstrates the use of S/MIME (Secure/Multipurpose Internet Mail Extensions) for securing email communications. Using the `TclSMimeMessage` component from the Clever Internet Suite library, the example shows how to digitally sign messages to ensure authenticity and integrity, as well as encrypt messages to protect confidentiality.

*   **Digital Signatures**: Signs email messages to verify sender identity and ensure message integrity.
*   **Message Encryption**: Encrypts email content to protect sensitive information from unauthorized access.
*   **Certificate Management**: Uses Windows Certificate Store for certificate retrieval.
*   **Dual Operations**: Demonstrates both signing and encryption separately.

## Features
*   S/MIME message signing using `TclSMimeMessage.Sign()` method.
*   S/MIME message encryption using `TclSMimeMessage.Encrypt()` method.
*   Integration with Windows Certificate Store via `TclCertificateStore`.
*   Configurable signing algorithms (e.g., SHA-512) and encryption algorithms (e.g., AES-128).
*   Event-driven certificate selection through `OnGetSigningCertificate` and `OnGetEncryptionCertificate` events.
*   SMTP integration for sending secured messages via `TclSmtp`.
*   Complete component documentation is available at [Clever Internet Suite Components](https://www.clevercomponents.com/products/inetsuite/components.asp)

## Usage
1.  Open the `SMimeSignEncrypt` project in your Delphi IDE.
2.  Ensure the Clever Internet Suite components are installed and accessible.
3.  Build and run the application.
4.  **Important**: Before testing, you must configure the following:
    *   Replace placeholder email addresses (`sender@domain.com`, `recipient@another.com`) with real email addresses.
    *   Configure valid SMTP server settings (`smtp.mailhost.com`, username, password).
    *   Load or create appropriate certificates for signing and encryption.
5.  For testing purposes, you can use:
    *   Self-signed certificates created with [Clever Certificate Manager](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/CertMgr)
    *   Local SMTP server: [Clever SMTP Server](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/SmtpServer)
6.  Ensure certificates are properly installed in the Windows Certificate Store or accessible via `TclCertificateStore`.
7.  Click **Send Signed** to send a digitally signed message.
8.  Click **Send Encrypted** to send an encrypted message.
9.  The application will establish an SMTP connection and send the secured message.

## Application Scenarios
*   Secure email communications in corporate environments.
*   Compliance with data protection regulations requiring message encryption.
*   Verification of email sender authenticity in sensitive communications.
*   Protection of confidential information in email transmissions.
*   Integration with existing email infrastructure using S/MIME standards.

## Requirements
*   **Delphi**: Delphi 7 or newer.
*   **Clever Internet Suite**: Version 10.0 or newer.
*   **Certificates**: Valid X.509 certificates for signing and/or encryption (can be self-signed for testing).
*   **SMTP Server**: Access to an SMTP server for sending messages.
*   The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Related Examples
*   [S/MIME Example](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/SMime) - for protecting email messages using S/MIME protocol.

## Repository
The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.