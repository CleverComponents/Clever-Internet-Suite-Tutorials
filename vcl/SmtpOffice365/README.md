# SmtpOffice365

This project demonstrates how to send emails through Office365 SMTP server using SSL/TLS encryption with the Clever Internet Suite library for Delphi. It provides a simple GUI application to send emails with authentication support.

## ⚠️ Important Note

**This tutorial is deprecated** because the authentication method used in the code (Basic Authentication with username/password) is no longer supported by Microsoft Office365. Starting from October 2025, Office365 requires OAuth 2.0 authentication for SMTP access.

For working with Office365 using OAuth 2.0, please refer to the updated tutorial: **[Send Email via Office365 with OAuth 2.0](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/SmtpOAuthOffice365)**

This example is retained for educational purposes and compatibility with other SMTP providers that still support Basic Authentication.

## Overview

The SmtpOffice365 project is a Delphi application that shows how to:
- Connect to Office365 SMTP server (smtp.office365.com)
- Authenticate using username and password (deprecated for Office365)
- Use STARTTLS for secure communication
- Compose and send email messages
- Handle SSL/TLS certificate verification

This example is part of the [Send SMTP email with Office365 account](https://www.clevercomponents.com/portal/kb/a87/send-smtp-email-with-office365-account.aspx) tutorial.

## Features

- **Office365 SMTP Integration**: Connect to Microsoft Office365 email services
- **SSL/TLS Support**: Secure email transmission using STARTTLS
- **Certificate Verification**: Customizable server certificate validation
- **Simple GUI**: User-friendly interface for entering email details
- **Error Handling**: Robust exception handling for network operations
- **Password Security**: Password field with hidden input

## Usage

1. **Configure Connection**:
   - Enter the SMTP server (default: smtp.office365.com)
   - Specify the port (default: 587 for STARTTLS)
   - Enter your Office365 email address as username
   - Provide your password

2. **Compose Message**:
   - Enter recipient's email address
   - Specify email subject
   - Write the message body

3. **Send Email**:
   - Click the "Send" button
   - If the server certificate is not trusted, you'll be prompted to accept it
   - A success message appears when the email is sent

## Application Scenarios

This example can be used as a foundation for:

- **Email notification systems** in business applications
- **Automated reporting tools** that send emails
- **Customer communication systems**
- **Email client prototypes**
- **Testing SMTP connectivity** to Office365 servers
- **Learning SMTP protocol** implementation with SSL/TLS

## Requirements

- **Delphi Version**: Delphi 7 or higher
- **Clever Internet Suite**: Version 7.0 or higher
- **Office365 Account**: Valid Microsoft Office365 subscription with SMTP access enabled (Note: Basic Authentication no longer works after October 2025)
- **Internet Connection**: Required for connecting to Office365 servers

**Note**: The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
