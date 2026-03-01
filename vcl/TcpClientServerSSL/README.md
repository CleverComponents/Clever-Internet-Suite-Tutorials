# TCP Client and Server with TLS

This project provides a code example for the [SSL client / server](https://www.clevercomponents.com/portal/kb/a65/ssl-client-server.aspx) tutorial. It implements both a simple TCP client and a multi-threaded TCP server with SSL/TLS encryption, demonstrating secure communication using the Clever Internet Suite components.

## Overview

The solution consists of two separate applications that work together to demonstrate secure TCP communication:

- **TLS Client Application**: A simple client that connects to a TLS-enabled server, sends data, and receives echo responses.
- **TLS Server Application**: A multi-threaded server that accepts secure connections, generates self-signed certificates, and implements echo functionality.

Both applications implement a custom protocol where data transmission is prefixed with a 4-byte DWORD size indicator for reliable communication.

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Features

### TLS Client Features
- Secure connection establishment using implicit TLS mode
- Support for self-signed certificates with configurable verification flags
- Modern TLS protocols (TLS 1.2 and TLS 1.3)
- Custom data exchange protocol with size prefix
- Connection state management and error handling
- Non-standard port usage (2110) to avoid conflicts with common services

### TLS Server Features
- Multi-threaded architecture for handling multiple concurrent connections
- Automatic generation of self-signed certificates
- Configurable TLS settings and protocols
- Connection logging with thread-safe synchronization
- Echo server functionality with proper protocol implementation
- Port 2110 to prevent conflicts with standard services

## Usage

### Running the Server
1. Launch the TLS Server application
2. Enter the port number (default: 2110)
3. Click "Start" to begin listening for connections
4. The server will automatically generate a self-signed certificate

### Running the Client
1. Launch the TLS Client application
2. Enter server address (default: localhost) and port (default: 2110)
3. Click "Connect" to establish a secure TLS connection
4. Enter data in the text field and click "Send" to transmit to server
5. View echo responses in the log area

### Protocol Details
Both client and server implement the same communication protocol:
1. Data size is transmitted as 4-byte DWORD prefix
2. Actual data follows the size indicator
3. Server echoes received data back to client using the same format

## Application Scenarios

- Secure internal tool communication requiring encrypted data transfer
- Educational projects demonstrating TLS/SSL implementation
- Development and testing of secure client-server applications
- Building blocks for custom secure messaging systems

## Requirements

### Delphi/C++Builder Versions
- **Minimum**: C++Builder 2009
- **Recommended**: C++Builder XE2 or later
- **Tested with**: C++Builder 13 Florence

### Clever Internet Suite
- **Version**: 10 or later
- **Required Components**: TclTcpClientTls, TclTcpServerTls, TclCertificateStore

The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Related Examples

- [Custom TCP client / server](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/CustomTcp) - Basic TCP communication without encryption
- [Asynchronous SSL client / server](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/AsyncClientServerSSL) - Asynchronous TLS implementation

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
