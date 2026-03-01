# SFTP Client with User and Public Key Authorization

<img src="SftpClient.jpg"/>

The SFTP Client project demonstrates how to implement a secure SFTP (SSH File Transfer Protocol) client application using the Clever Internet Suite library. This example provides a user interface for connecting to SFTP servers with different authentication methods, browsing directories, and transferring files securely.

The complete tutorial and detailed step-by-step instructions can be found at [SFTP Client with User and Public Key Authorization](https://www.clevercomponents.com/portal/kb/a136/sftp-client-with-public-key-authorization.aspx)

## Overview

This Delphi SFTP client application demonstrates:

* How to connect to SFTP servers using SSH protocol
* How to implement two authentication methods: username/password and public key (private key file)
* How to browse server directories and navigate through folder structures
* How to upload files from local machine to SFTP server
* How to download files from SFTP server to local machine
* How to implement server fingerprint verification for enhanced security
* How to display directory listings with folder/file differentiation
* How to show upload/download progress

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Features

* **Dual Authentication**: Support for both username/password and public key authentication methods
* **Secure File Transfer**: Encrypted file transfers using SSH protocol
* **Directory Navigation**: Browse server directories with "Open Directory" and "Go Up" functionality
* **File Management**: Upload and download files with progress indication
* **Server Verification**: Interactive server fingerprint verification to prevent man-in-the-middle attacks
* **Connection Management**: Login/Logout functionality with connection state management
* **Cross-platform Support**: Works with any SFTP server implementation

## Usage

### Prerequisites
1. Access to an SFTP server with valid credentials
2. For public key authentication: private key file (e.g., RSA private key in PEM format)
3. For testing, you can use our [SFTP Server Example](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/SFtpServer) to create a local test environment

### Step-by-Step

1. **Configure Connection Settings**:
   - Enter SFTP server hostname or IP address
   - Specify port (default is 22 for SSH/SFTP)
   - Enter username for authentication

2. **Select Authentication Method**:
   - Choose "User/Password" for password-based authentication and enter password
   - Choose "Private Key" for public key authentication and specify private key file and passphrase (if required)

3. **Connect to Server**:
   - Click "Login" to establish connection
   - Review and verify server fingerprint when prompted (for security)

4. **Browse Directories**:
   - Navigate using directory listing (folders start with "/")
   - Click "OpenDir" to enter a directory
   - Click "GoUp" to move to parent directory
   - Set "Start Dir" for initial directory upon connection

5. **Transfer Files**:
   - **Upload**: Click "Upload" to select and upload local files to server
   - **Download**: Select a file in the list and click "Download" to save it locally

### Authentication Methods

**Username/Password Authentication**:
- Enter username and password in corresponding fields
- Simple and commonly used method

**Public Key Authentication**:
- Provide private key file path (e.g., .pem file)
- Enter passphrase if private key is encrypted
- More secure method, widely used in server environments

## Application Scenarios

* **Web Deployment**: Upload website files to hosting servers securely
* **Backup Systems**: Automated backup transfers to remote SFTP servers
* **File Sharing**: Secure file exchange between business partners
* **DevOps Operations**: Deploy applications and configurations to servers
* **Data Migration**: Transfer large datasets between systems securely
* **Remote Access**: Access and manage files on remote servers

## Requirements

* **Delphi Version**: Delphi 7 or later
* **Clever Internet Suite**: Version 12 or later
* **Operating System**: Windows with network connectivity
* **Network**: Access to SFTP server (port 22 typically)
* **Certificates**: For public key authentication, valid SSH key pair

The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Related Examples

* [SFTP Server Example](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/SFtpServer) - Complete SFTP server implementation for testing
* [SFTP Client with Host Key Repository](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/SFtpClientWithHostKeyRepository) - SFTP client with persistent server key storage

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
