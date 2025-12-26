# Asynchronous SSL client / server

This project provides a code example for the [Asynchronous SSL client / server](https://www.clevercomponents.com/portal/kb/a71/asynchronous-ssl-client-server.aspx) tutorial. It demonstrates how to implement asynchronous SSL/TLS communication between a client and server using the Clever Internet Suite components, featuring non-blocking operations and server-initiated data push capabilities.

## Overview

The solution implements a complete asynchronous client-server system with SSL/TLS encryption:

- **Asynchronous SSL Client**: Uses `TclAsyncClient` for non-blocking operations with automatic certificate handling
- **SSL Server**: Multi-threaded server with self-signed certificate generation and client connection management
- **Bidirectional Communication**: Both client-initiated requests and server-initiated data push
- **UTF-8 Support**: Full Unicode string handling with proper encoding/decoding

## Features

### Asynchronous Client Features
- Non-blocking SSL/TLS connection using `TclAsyncClient`
- Automatic certificate validation with self-signed certificate support
- Asynchronous read/write operations with event-driven architecture
- UTF-8 encoded string transmission and reception
- Custom protocol with 4-byte integer size prefix
- Error handling through async error events

### SSL Server Features
- Multi-threaded architecture for concurrent client handling
- Automatic self-signed certificate generation on startup
- Server-initiated data push to all connected clients
- Connection logging with thread synchronization
- Implicit SSL mode for immediate encryption negotiation
- Comprehensive event handling for connection management

### Protocol Implementation
- 4-byte integer prefix indicating data size
- UTF-8 encoded string data
- Server echo functionality with logging
- Server broadcast capability to all connected clients

## Usage

### Starting the Server
1. Launch the server application
2. Enter the desired port number
3. Click "Start" to begin listening for SSL connections
4. Server automatically generates a self-signed certificate

### Connecting the Client
1. Launch the client application
2. Enter server address and port (must match server configuration)
3. Click "Connect" to establish an asynchronous SSL connection
4. The connection status updates in the window title

### Sending Data
- **Client to Server**: Enter text in the client's data field and click "Send"
- **Server to Client**: Enter text in the server's data field and click "Send" to broadcast to all clients
- **Protocol**: Data is automatically prefixed with size information and UTF-8 encoded

### Monitoring Activity
- Server log displays connection events and received data sizes
- Client log shows received data from server
- Both applications handle errors through async error events

## Application Scenarios

- Real-time messaging systems requiring server push capabilities
- Monitoring applications with continuous data streaming
- Dashboard systems where servers push updates to multiple clients
- Applications requiring non-blocking network operations
- Educational demonstrations of asynchronous SSL programming

## Requirements

### Delphi/C++Builder Versions
- **Minimum**: Delphi 2007 / C++Builder 2007
- **Recommended**: Delphi XE2 / C++Builder XE2 or later
- **Tested with**: RAD Studio 13 Florence (Delphi / C++Builder)

### Project Structure
- **Delphi**: contains source code for Delphi (versions 13–10, all XE, 2010–2007).
- **CBuilder:** contains source code for C++Builder XE. Before compiling with newer versions of C++Builder, open the \*.cbproj files and replace clinetsuite\_xe.lib with clinetsuite\_XXX.lib, where XXX is 13 for C++Builder 13, xe8 for C++Builder XE8, etc.

### Clever Internet Suite
- **Version**: 10 or later
- **Required Components**: `TclAsyncClient`, `TclTcpServerTls`, `TclCertificateStore`
- **Required Units**: `clSspiTls`, `clTranslator`, `clWUtils`

The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Related Examples

- [Custom TCP client / server](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/CustomTcp) - Basic TCP communication without encryption
- [TLS client / server](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/TcpClientServerSSL) - Synchronous TLS implementation

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.