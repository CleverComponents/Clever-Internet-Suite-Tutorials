# Check Internet Connected State

The InternetConnectedState project represents a code example for the [Check Internet connected state](https://www.clevercomponents.com/portal/kb/a53/check-internet-connected-state.aspx) tutorial.

This tutorial demonstrates how to check the Internet connection status of the local system using Windows API functions. It retrieves the current connection state and provides detailed information about the connection type (modem, LAN, proxy, etc.).

## Overview

This tutorial demonstrates how to use Windows API functions to:

- Check if the local system has an active Internet connection
- Determine the type of Internet connection (modem, LAN, proxy)
- Detect if the system is in offline mode
- Identify RAS (Remote Access Service) installation
- Verify Internet connection configuration status

The implementation uses the `InternetGetConnectedState` Windows API function through the Clever Internet Suite library, which provides Delphi-friendly wrappers for Windows Internet connectivity functions.

See also:  
[Check if PC is connected to the Internet](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/CheckInternetConnection) - A more advanced implementation that not only checks connection state but also attempts to access a specified web resource using system proxy settings.

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Features

- **Connection Status Detection**: Determine if the system has active Internet connectivity
- **Connection Type Identification**: Differentiate between modem, LAN, and proxy connections
- **Offline Mode Detection**: Check if the system is operating in offline mode
- **Configuration Verification**: Validate Internet connection configuration
- **RAS Installation Check**: Detect Remote Access Service presence
- **Simple Interface**: Clean UI with clear status display

## Usage

1. **Check Connection Status**:
   - Click the "Check Internet Connection" button
   - The application will query the current Internet connection state
   - Results will display in the memo control

2. **Interpret Results**:
   - The first line indicates overall connection status (connected or not connected)
   - Subsequent lines provide details about connection type and configuration
   - Multiple connection types may be reported simultaneously

## Application Scenarios

- **Application Startup Checks**: Verify Internet connectivity before attempting network operations
- **Connection Monitoring**: Periodically check connection status in background services
- **Offline Mode Detection**: Determine when to enable/disable online features
- **Network Diagnostics**: Troubleshoot connectivity issues in applications
- **Auto-Configuration**: Adjust application behavior based on available connection types
- **Status Reporting**: Display current connection status to users

## Implementation Details

### Connection State Checking
The core functionality uses the `InternetGetConnectedState` Windows API function, which returns both a boolean connection status and detailed flags about the connection type.

### Connection Type Flags
The tutorial demonstrates checking for various connection types:
- **Modem Connections**: Dial-up or modem-based Internet access
- **LAN Connections**: Local area network connectivity
- **Proxy Connections**: Internet access through proxy servers
- **Offline Mode**: System configured for offline operation
- **RAS Installation**: Remote Access Service availability

## Advantages of Using Clever Internet Suite

1. **Simplified API Access**: Clean Delphi interfaces for Windows Internet functions
2. **Cross-Version Compatibility**: Works consistently across Delphi versions
3. **Error Handling**: Built-in exception handling for API calls
4. **Type Safety**: Strongly typed parameters and return values
5. **Documentation**: Well-documented components and functions

## Requirements

- **Delphi 7 or later** (compatible with wide range of Delphi versions)
- **Clever Internet Suite 12** or compatible version
- **Windows** operating system (Windows API dependency)

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
