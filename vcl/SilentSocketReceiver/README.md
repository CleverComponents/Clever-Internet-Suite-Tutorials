# Silent Socket Receiver in Delphi

This project represents a code example for the [Silent Socket Receiver in Delphi](https://www.clevercomponents.com/portal/kb/a180/silent-socket-receiver-in-delphi.aspx) tutorial. It demonstrates how to create a TCP server that listens for incoming connections, receives data, and sends no responses back to the client.

![Screenshot](silent-socket.jpg)

## Overview
This Delphi application implements a silent TCP socket receiver using the `TclTcpServerConnection` class from the Clever Internet Suite library. The server accepts connections on a specified port and logs all incoming data without sending any response. This functionality is particularly useful for network debugging and protocol analysis when used alongside tools like [Wireshark](https://www.wireshark.org/download.html). The functionality can be easily extended to implement echo servers or other custom response logic as needed.

*   **Passive Listening**: Listens on a configurable port for incoming TCP connections.
*   **Data Reception**: Receives and logs all incoming data from connected clients.
*   **Silent Operation**: Does not send any responses back to clients.
*   **Connection Management**: Provides start/stop control for the server.
*   **Debugging Utility**: Useful for capturing and analyzing TCP traffic between client and server applications.

## Features
*   Low-level TCP server implementation using `TclTcpServerConnection` from the Clever Internet Suite socket classes.
*   Configurable listening port (default: 2110).
*   Real-time logging of received data size.
*   Proper socket initialization and cleanup with `StartupSocket()` and `CleanupSocket()`.
*   Graceful connection termination and error handling.
*   Complete component documentation is available at [Clever Internet Suite Components](https://www.clevercomponents.com/products/inetsuite/components.asp)

## Usage
1.  Open the `SilentSocketReceiver` project in your Delphi IDE.
2.  Ensure the Clever Internet Suite components are installed and accessible.
3.  Build and run the application.
4.  Enter the port number to listen on (default is 2110).
5.  Click **Listen** to start the server and begin accepting connections.
6.  Connect to the server from a client application to send data.
7.  The application will log the size of received data packets in the memo control.
8.  Click **Stop** to terminate the server and close all connections.

## Application Scenarios
*   Network protocol debugging and analysis.
*   Capturing and inspecting TCP traffic between client and server applications using tools like Wireshark.
*   Testing client applications that send data to TCP servers.
*   Educational purposes to understand low-level TCP socket programming in Delphi.
*   As a foundation for building custom TCP servers with response capabilities.

## Requirements
*   **Delphi**: Delphi 7 or newer.
*   **Clever Internet Suite**: Version 10.0 or newer.
*   The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Related Examples
*   [TCP client / server connection](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/CustomSocket)
*   [Read a fixed number of bytes from the socket using TcpClientConnection](https://www.clevercomponents.com/portal/kb/a96/read-a-fixed-number-of-bytes-from-the-socket-using-tcpclientconnection.aspx)

## Repository
The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.