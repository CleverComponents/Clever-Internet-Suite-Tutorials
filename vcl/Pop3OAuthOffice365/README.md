# Get Emails from Office365 via POP3 with OAuth 2.0

This project demonstrates how to retrieve emails from Office365 POP3 server using OAuth 2.0 authentication with the Clever Internet Suite library for Delphi. It provides a modern, secure approach to email access that complies with Microsoft's updated security requirements.

![Screenshot](pop3-oauth-office365-fb.png)

## Overview

The Pop3OAuthOffice365 project is a Delphi application that shows how to:
- Connect to Office365 POP3 server using OAuth 2.0 authentication
- Implement Microsoft Identity Platform authentication flow
- Use implicit TLS for secure POP3 communication
- Retrieve message list with unique identifiers
- Handle secure token acquisition and management

This example demonstrates the modern authentication approach for accessing Office365 email via POP3 protocol, which became mandatory after Microsoft deprecated Basic Authentication.

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Prerequisites

Before using this example, you need:

1. **A Microsoft Account**: Office365 subscription (personal or business)
2. **Internet Connection**: Required for authentication and email retrieval
3. **Web Browser**: Required for interactive authentication flow

## Usage

1. **Configure Connection Settings**:
   - Enter Office365 POP3 server address (typically `outlook.office365.com`)
   - Enter your Office365 email address as the username
   - Click "Get Message List"

2. **Authentication Process**:
   - On first run, the OAuth authentication flow will be initiated
   - A browser window will open for Microsoft authentication
   - Sign in with your Microsoft account credentials
   - Grant permissions to the application (POP.AccessAsUser.All)
   - You'll be automatically redirected back to the application

3. **Retrieve Messages**:
   - After successful authentication, the POP3 connection is established
   - The application retrieves the list of message unique identifiers (UIDL)
   - Message UIDs are displayed in the list box

4. **Subsequent Connections**:
   - Tokens are automatically cached by the Clever Internet Suite
   - Subsequent connections will use cached tokens until they expire
   - Access tokens typically expire after 1 hour

## Application Scenarios

This example can be used as a foundation for:

- **Email client applications** requiring modern POP3 authentication
- **Automated email processing systems** with Office365 integration
- **Learning OAuth 2.0 implementation** with POP3 protocol
- **Migration projects** from Basic Authentication to OAuth 2.0
- **Enterprise applications** with Office365 email integration
- **Backup solutions** for Office365 email accounts

## Requirements

- **Delphi Version**: Delphi 2009 or higher (for namespaces and modern string handling)
- **Clever Internet Suite**: Version 10.0 or higher (OAuth 2.0 support required)
- **Office365 Subscription**: Valid Microsoft 365/Office365 subscription with POP3 access enabled

**Note**: The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Configuration

### OAuth Configuration

The example uses Live.com authentication endpoint for Office365 accounts:

```pascal
clOAuth1.AuthUrl := 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize';
clOAuth1.TokenUrl := 'https://login.microsoftonline.com/common/oauth2/v2.0/token';
clOAuth1.RedirectUrl := 'http://localhost';
clOAuth1.ClientID := 'your-client-id-here';
clOAuth1.ClientSecret := 'your-client-secret-here';
clOAuth1.Scope := 'https://outlook.office.com/POP.AccessAsUser.All offline_access';
```

### POP3 Configuration

```pascal
clPop31.Server := 'outlook.office365.com';
clPop31.Port := 995;
clPop31.UseTLS := ctImplicit;
clPop31.UserName := 'your-email@office365.com';
clPop31.Authorization := clOAuth1.GetAuthorization();
```

**Important**: You need to obtain Client ID and Client Secret from Azure Active Directory by registering your application in the Azure portal.

## Azure AD App Registration

To use this example, you must register an application in Azure Active Directory:

1. Go to [Azure Portal](https://portal.azure.com)
2. Navigate to **Azure Active Directory** > **App registrations**
3. Click **New registration**
4. Enter application name and set redirect URI to `http://localhost`
5. After creation, note the **Application (client) ID**
6. Create a new client secret under **Certificates & secrets**
7. Add API permission: `POP.AccessAsUser.All` under **API permissions**

## Related Examples

- **[Send Email via Office365 with OAuth 2.0](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/SmtpOAuthOffice365)** - Example demonstrating SMTP email sending with Office365 using OAuth 2.0
- **[GMail SMTP Client](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/GMailSMTP)** - Example demonstrating SMTP email sending with GMail using OAuth 2.0 authentication

## Troubleshooting

### Common Issues:

1. **Authentication Failed**:
   - Verify your Azure AD application is correctly configured
   - Check if `POP.AccessAsUser.All` permission is granted
   - Ensure correct Client ID and Client Secret
   - Verify redirect URI matches Azure AD configuration

2. **POP3 Connection Failed**:
   - Ensure POP3 access is enabled in your Office365 account settings
   - Verify server address is correct (outlook.office365.com)
   - Check if port 995 is not blocked by firewall
   - Verify TLS settings (should be implicit for port 995)

3. **Browser Authentication Issues**:
   - Ensure `http://localhost` is accessible
   - Check firewall/antivirus isn't blocking localhost
   - Try using different browser if authentication window doesn't open

4. **Permission Errors**:
   - Ensure the signed-in user has appropriate Office365 license
   - Check if POP3 protocol is enabled for the user in Exchange Online
   - Verify application has required permissions in Azure AD

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.

---

**Note**: This example uses hardcoded Client ID and Client Secret for demonstration purposes. In production applications, you should:
1. Store credentials securely (encrypted or in configuration files)
2. Use environment variables or secure credential stores
3. Implement proper error handling and token refresh logic
4. Follow security best practices for OAuth 2.0 client applications

