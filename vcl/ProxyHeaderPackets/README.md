# Get Host IP Address Behind Load Balancer Using Proxy Protocol

This Delphi VCL example demonstrates how to extract client IP addresses from PROXY protocol headers when using Clever Internet Suite server components behind load balancers. Complete tutorial is available at [Get host ip address behind load balancer using proxy protocol](https://www.clevercomponents.com/portal/kb/a84/get-host-ip-address-behind-load-balancer-using-proxy-protocol_.aspx)

## Overview
This example shows:
- How to parse PROXY protocol headers using TProxyHeaderParser
- How to integrate PROXY protocol support with TclImap4Server component
- How to extract client connection information (source IP, port) from proxy headers
- How to handle load balancer scenarios with Clever Internet Suite server components

## About the PROXY Protocol
The [PROXY protocol](http://www.haproxy.org/download/1.5/doc/proxy-protocol.txt) is an open standard developed by HAProxy to preserve a client's original connection information (such as IP address and port) when the connection passes through a TCP proxy or load balancer. Unlike HTTP-specific headers (e.g., `X-Forwarded-For`), it operates at the TCP layer (Layer 4), making it suitable for any TCP-based protocol like IMAP, SMTP, or FTP. The protocol works by prepending a small header containing the client's connection details to the data stream right after the TCP handshake.

## Features
- Uses TclImap4Server component for IMAP protocol implementation
- Uses TclImap4FileHandler for mailbox storage
- Implements TProxyHeaderParser for PROXY protocol parsing
- Demonstrates custom connection class (TProxiedConnection)
- Shows integration with load balancers using PROXY protocol

## Usage
1. Open the project in Delphi IDE
2. Ensure Clever Internet Suite is installed
3. Set the mailbox directory path
4. Configure server port (default: 143)
5. Start the server
6. Connect using any IMAP client with credentials:
   - Username: CleverTester
   - Password: clevertester
7. Click "Test Proxy Header" to see PROXY protocol parsing demonstration

## Application Scenarios
This example is useful for:
- Building mail servers behind load balancers or reverse proxies
- Extracting real client IP addresses in cloud environments (e.g., AWS ELB)
- Implementing PROXY protocol support for any Clever Internet Suite server component
- Deploying applications in AWS, Google Cloud, or other cloud platforms with load balancing

## Requirements
- **Delphi:** 7 or higher
- **Clever Internet Suite:** version 12 or higher

The project was compiled with Clever Internet Suite version 12.  
Tutorials and project files for previous versions of Clever Internet Suite can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Compilation Instructions
1. Clone the [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository
2. Download and install [Clever Internet Suite](https://www.clevercomponents.com/downloads/inetsuite/suitedownload.asp)
3. Open the ProxyHeaderPackets.dproj project in Delphi IDE
4. Compile and run the application

## Related Examples
- [How to Override Default POP3 Server Command Handlers](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/Pop3ServerCmdOverride): POP3 server customization example
- [Clever Mail Server](https://github.com/CleverComponents/Clever-Mail-Server): Complete mail server implementation

## Repository
The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.
