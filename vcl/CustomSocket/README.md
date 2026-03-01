# TCP Client/Server Connection using Clever Internet Suite

This project provides code examples for the [TCP client / server connection](https://www.clevercomponents.com/portal/kb/a68/tcp-client-server-connection.aspx) tutorial. It demonstrates basic TCP socket communication using the low-level components of the Clever Internet Suite library, featuring implementations in both Delphi and C++Builder.

## Overview

The solution includes simple client and server applications that demonstrate fundamental TCP communication principles. Unlike more complex examples, this tutorial focuses on the core socket operations without multi-threading or advanced protocol layers, making it an ideal starting point for understanding network programming basics.

The project provides implementations in both Delphi and C++Builder, showcasing how to use the Clever Internet Suite components in different development environments.

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Features

### Core TCP Communication
- **Basic socket operations** using `TclTcpClientConnection` and `TclTcpServerConnection`
- **Direct Winsock API integration** with proper initialization and cleanup
- **Simple echo protocol** where server reflects received data back to client
- **Single-threaded architecture** for clarity and simplicity

### Connection Management
- **Manual socket lifecycle control** with explicit `WSAStartup` and `WSACleanup`
- **Connection timeout configuration** for reliable network operations
- **Stream-based data exchange** using `TStringStream` for text communication
- **Port 2110 usage** to avoid conflicts with standard services
- **Read-until-close mode** for complete data reception

## Usage

### Building and Running
1. Choose either Delphi or C++Builder project files
2. Compile and run the server application first (`ServerSocket`)
3. Compile and run the client application (`ClientSocket`)
4. Both applications default to `127.0.0.1:2110`

### Server Operation
1. Click "Start" to begin listening on port 2110
2. Server displays "Listening..." status
3. When client connects, server accepts the connection
4. Server receives data, logs it, and echoes it back
5. Connection closes after echo completion

### Client Operation
1. Click "Connect" to establish connection to server
2. Client sends "Data from client" message
3. Client waits for echo response with `IsReadUntilClose = true`
4. Received data displayed in UI
5. Connection closes cleanly

## Application Scenarios

- Educational demonstrations of TCP socket programming fundamentals
- Starting point for custom protocol development
- Testing network connectivity and basic communication
- Foundation for more complex client/server applications
- Understanding Winsock integration with Delphi/C++Builder
- Learning resource management in network applications
- Debugging and troubleshooting network communication basics

## Requirements

### Development Environments
- **Delphi**: Version 2009 or later
- **C++Builder**: Version 2009 or later
- **Tested with**: RAD Studio 13 Florence (Delphi and C++Builder)

### Project Structure
- **Delphi**: Client and server applications using Pascal syntax
- **CBuilder**: Client and server applications using C++ syntax

### Clever Internet Suite
- **Version**: 10 or later
- **Required Components**: `TclTcpClientConnection`, `TclTcpServerConnection`, `TclNetworkStream`

The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

### System Requirements
- Windows operating system (Winsock dependency)
- TCP/IP networking capabilities
- Development environment with VCL support

## Related Examples

- [Custom TCP client / server](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/CustomTcp) - Advanced command-based protocol with binary and text data exchange
- [TLS client / server](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/TcpClientServerSSL) - Secure TLS communication with encryption
- [Asynchronous SSL client / server](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/AsyncClientServerSSL) - Non-blocking asynchronous TLS implementation

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
