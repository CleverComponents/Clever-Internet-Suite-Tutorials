# Custom TCP Client / Server

This project provides code examples for the [Custom TCP client / server](https://www.clevercomponents.com/portal/kb/a69/custom-tcp-client-server.aspx) tutorial. It demonstrates how to implement custom TCP communication protocols using Clever Internet Suite components, featuring both binary data and text line exchange capabilities.

## Overview

The solution includes four separate applications organized into two distinct projects, each showcasing different aspects of custom TCP protocol implementation:

- **ExchangeBinaryData**: Demonstrates binary data exchange using Delphi `TStream` objects
- **ExchangeTextLines**: Shows how to send and receive multiple text lines using Delphi `TStrings` objects

Both projects implement a custom command-based protocol with session management, error handling, and proper connection lifecycle.

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Features

### Custom Protocol Implementation
- **Command-based architecture** with `TclTcpCommandClient` and `TclTcpCommandServer`
- **Session management** with LOGIN and CLOSE commands
- **Custom response codes** (100=OK, 101=Unknown Command, 102=Unhandled Error)
- **Port 2110** usage to avoid conflicts with standard services

### ExchangeBinaryData Project
- **Binary data transmission** using Delphi `TStream` objects
- **Size-prefixed protocol** with 8-byte Int64 size indicator
- **Stream copying and reassembly** on both client and server
- **Custom command handlers** for DATA command processing

### ExchangeTextLines Project
- **Text line exchange** using Delphi `TStrings` objects
- **Multiple lines transmission** with dot-terminator protocol
- **GETLINES and SENDLINES commands** for bidirectional text exchange
- **XML/structured data** transmission examples

### Server Features
- **Multi-threaded architecture** for concurrent client handling
- **Custom command registration** with handler methods
- **Thread-safe logging** with critical section synchronization
- **Connection event handling** for monitoring and debugging

### Client Features
- **Synchronous command execution** with timeout support
- **Response code validation** and error handling
- **Stream and string list integration** for easy data manipulation
- **Session lifecycle management** from connection to disconnection

## Usage

### Building and Running
1. Open either `ExchangeBinaryData` or `ExchangeTextLines` project in Delphi
2. Compile and run the server application first
3. Compile and run the client application
4. Both applications default to `localhost:2110`

### ExchangeBinaryData Project
1. **Server**: Starts listening on port 2110, logs connections and data sizes
2. **Client**: 
   - Connects to server with test credentials
   - Sends binary data stream
   - Receives echoed data with size prefix
   - Displays received data in memo

### ExchangeTextLines Project
1. **Server**: Starts listening, provides sample lines on request, logs received lines
2. **Client**:
   - Connects and logs in
   - Requests and receives sample text lines
   - Sends XML-structured data back to server
   - Closes session cleanly

### Protocol Commands
- **LOGIN** - Authenticate session with username
- **DATA** - Initiate binary data exchange (ExchangeBinaryData only)
- **GETLINES** - Request text lines from server (ExchangeTextLines only)
- **SENDLINES** - Send text lines to server (ExchangeTextLines only)
- **CLOSE** - Terminate session gracefully

## Application Scenarios

- Custom protocol development for specialized applications
- File transfer systems with progress tracking
- Configuration management tools with structured data exchange
- Remote command execution interfaces
- Educational demonstrations of TCP protocol design
- Legacy system integration with custom communication protocols
- Data synchronization between heterogeneous systems

## Requirements

### Delphi/C++Builder Versions
- **Minimum**: Delphi 7
- **Recommended**: Delphi XE2 or later
- **Tested with**: Delphi 13 Florence

### Project Structure
- **ExchangeBinaryData**: Client and server applications for binary data exchange
- **ExchangeTextLines**: Client and server applications for text line exchange

### Clever Internet Suite
- **Version**: 10 or later
- **Required Components**: `TclTcpCommandClient`, `TclTcpCommandServer`, `TclCommandConnection`
- **Required Units**: `clSocketUtils`, `clTcpClient`, `clTcpServer`

The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Related Examples

- [TLS client / server](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/TcpClientServerSSL) - Secure TLS communication
- [Asynchronous SSL client / server](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/AsyncClientServerSSL) - Asynchronous TLS implementation

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
