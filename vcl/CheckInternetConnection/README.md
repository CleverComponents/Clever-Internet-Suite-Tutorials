# Check if PC is connected to the Internet

The CheckInternetConnection project is a code example for the [Check if PC is connected to the Internet](https://www.clevercomponents.com/portal/kb/a83/check-if-pc-is-connected-to-the-internet.aspx) tutorial.

This example verifies whether the PC is connected to the Internet and attempts to access a specified web resource using the system's connection settings (proxy, SOCKS, etc.).

## Overview

This tutorial demonstrates a comprehensive approach to Internet connectivity checking by:
- Using Windows API to check the basic Internet connection state
- Attempting to access a specific web resource to validate actual connectivity
- Respecting system-wide connection settings (proxy, SOCKS servers)
- Providing a more reliable check than basic API calls alone

## Features

- **Two-Stage Verification**: Combines system API checks with actual resource access
- **Proxy Awareness**: Automatically uses system proxy settings for connection attempts
- **Configurable URL**: Allows testing connectivity to any web resource
- **Error Handling**: Properly handles connection timeouts and failures
- **Simple Interface**: User-friendly form with URL input and status display

## Usage

1. **Enter Target URL**: Type or paste the URL you want to test in the input field
2. **Check Connection**: Click the "Check Connection" button
3. **View Results**: The application will display either "Connected" or "Not connected" status

The application first checks the system's Internet connection state, then attempts to access the specified URL using the same connection settings (including proxy) that other applications on your system would use.

## Application Scenarios

- **Application Startup Validation**: Ensure Internet is accessible before starting network-dependent operations
- **Service Monitoring**: Periodically verify that specific web services are reachable
- **Proxy Configuration Testing**: Validate that system proxy settings are working correctly
- **Network Troubleshooting**: Diagnose connectivity issues beyond basic network detection
- **Quality of Service Monitoring**: Check actual accessibility of critical web resources

## Requirements

- **Delphi 7 or later** (compatible with wide range of Delphi versions)
- **Clever Internet Suite version 10**. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.
- **Windows** operating system

## Related Examples

- [Check Internet Connected State](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/InternetConnectedState) - a simple implementation using only Windows API functions to check basic connection state and type.

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.