# Send Email via Office365 with OAuth 2.0

This project demonstrates how to send emails through Office365 SMTP server using OAuth 2.0 authentication with the Clever Internet Suite library for Delphi. It provides a modern, secure approach to email sending that complies with Microsoft's updated security requirements.

## Overview

The SmtpOAuthOffice365 project is a Delphi application that shows how to:
- Connect to Office365 SMTP server using OAuth 2.0 authentication
- Implement Microsoft Identity Platform authentication flow
- Use STARTTLS for secure SMTP communication
- Compose and send email messages with OAuth tokens
- Handle secure token acquisition and management

This example demonstrates the modern authentication approach that became mandatory for Office365.

## Features

- **OAuth 2.0 Authentication**: Secure token-based authentication compliant with Microsoft requirements
- **Microsoft Identity Platform**: Integration with Azure AD v2.0 authentication endpoints
- **Office365 SMTP Integration**: Connect to Microsoft Office365 email services securely
- **SSL/TLS Support**: Secure email transmission using STARTTLS
- **Token Management**: Automatic token acquisition and caching
- **Simple GUI**: User-friendly interface for entering email details
- **Unicode Support**: Full UTF-8 encoding for international characters
- **Security Compliance**: Meets Microsoft's security requirements for email access

## Prerequisites

Before using this example, you need:

1. **A Microsoft Account**: Office365 subscription (personal or business)
2. **Internet Connection**: Required for authentication and email sending
3. **Web Browser**: Required for interactive authentication flow

## Usage

1. **Configure the Application**:
   - Enter the sender's Office365 email address
   - Specify the recipient's email address
   - Enter email subject and message body
   - Click "Send"

2. **First-time Authentication**:
   - On first run, a browser window will open for Microsoft authentication
   - Sign in with your Microsoft account credentials
   - Grant permissions to the application
   - You'll be redirected back to the application

3. **Token Caching**:
   - Tokens are automatically cached by the Clever Internet Suite
   - Subsequent email sends will use cached tokens until they expire
   - Access tokens typically expire after 1 hour

## Application Scenarios

This example can be used as a foundation for:

- **Email applications** requiring modern authentication
- **Automated notification systems** with Office365 integration
- **Learning OAuth 2.0 implementation** with SMTP
- **Migration projects** from Basic Authentication to OAuth 2.0
- **Enterprise applications** with Office365 integration

## Requirements

- **Delphi Version**: Delphi 2009 or higher (for modern string handling and Unicode support)
- **Clever Internet Suite**: Version 10.0 or higher (OAuth 2.0 support required)
- **Office365 Subscription**: Valid Microsoft 365/Office365 subscription
- **Internet Connection**: Required for authentication and email sending
- **Web Browser**: Required for interactive authentication flow

**Note**: The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Configuration

### OAuth Configuration

This example uses the `common` endpoint which supports both personal Microsoft accounts and business/enterprise Office365 accounts from any Azure AD organization. Microsoft also provides the option to use organization-specific endpoints for dedicated enterprise applications.  

For more details about tenant configuration and endpoint selection, refer to the [Microsoft Identity Platform documentation](https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-protocols-oidc)


```pascal
clOAuth1.AuthUrl := 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize';
clOAuth1.TokenUrl := 'https://login.microsoftonline.com/common/oauth2/v2.0/token';
clOAuth1.RedirectUrl := 'http://localhost';
clOAuth1.Scope := 'https://outlook.office.com/SMTP.Send';
```

### SMTP Configuration


```pascal
clSmtp1.Server := 'smtp.office365.com';
clSmtp1.Port := 587;
clSmtp1.UseTLS := ctExplicit;
```

## Related Examples

- **[Send SMTP email with Office365 account (Deprecated)](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/SmtpOffice365)** - Legacy Basic Authentication example (no longer works with Office365)
- **[GMail SMTP Client](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/GMailSMTP)** - Example demonstrating SMTP email sending with GMail using OAuth 2.0 authentication

## Troubleshooting

### Common Issues:

1. **Authentication Failed**:
   - Verify your Azure AD application is correctly configured
   - Check if `SMTP.Send` permission is granted
   - Ensure correct Client ID and Client Secret

2. **Browser Authentication Issues**:
   - Ensure `http://localhost` is accessible
   - Check firewall/antivirus isn't blocking localhost
   - Try using different browser

3. **SMTP Send Errors**:
   - Verify Office365 subscription is active
   - Check if SMTP sending is enabled for the account
   - Ensure correct port (587) and TLS settings

4. **Token Acquisition Failed**:
   - Check internet connectivity
   - Verify Azure AD application configuration

### Getting Help:

If you encounter issues not covered here:
- Check the [Clever Internet Suite documentation](https://www.clevercomponents.com/products/inetsuite/components.asp)
- Visit [Microsoft OAuth documentation](https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-auth-code-flow)
- Contact support through official channels

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.