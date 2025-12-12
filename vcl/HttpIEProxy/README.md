# Get IE Proxy Settings for the HTTP Client Component

The HttpClientProxy project represents a code example for the [Get IE proxy settings for the HTTP client component](https://www.clevercomponents.com/portal/kb/a82/get-ie-proxy-settings-for-the-http-client-component.aspx) tutorial.

This tutorial demonstrates how to automatically retrieve and apply Internet Explorer proxy settings in the HTTP client component. The supported proxy types include HTTP, HTTPS, and SOCKS protocols.

## Overview

This Delphi application shows how to:
- Retrieve system proxy settings configured in Internet Explorer
- Parse proxy information for different protocols (HTTP, HTTPS, SOCKS)
- Apply proxy settings to the `TclHttp` component from Clever Internet Suite
- Handle both HTTP and SOCKS proxy configurations
- Extract proxy server addresses and ports from system settings

The implementation uses Windows API calls to query system proxy settings and applies them to the Clever Internet Suite HTTP client component.

## Features

- **Automatic Proxy Detection**: Retrieves proxy settings from Internet Explorer/Windows system configuration
- **Multi-Protocol Support**: Handles HTTP, HTTPS, and SOCKS proxy types
- **URL-Aware Proxy Selection**: Automatically selects the appropriate proxy based on URL protocol
- **Manual Configuration**: Allows manual proxy server and port specification
- **Proxy Type Switching**: Supports switching between HTTP, SOCKS4, and SOCKS5 proxy types
- **Authentication Support**: Includes proxy username and password fields
- **Visual Feedback**: Displays downloaded content with optional HTML text parsing

## Components Used

### `TclHttp`
The main HTTP client component that performs HTTP/HTTPS requests with configurable proxy settings.

### `TclHtmlParser`
Optional component for parsing HTML content and extracting text when the "Show Text Only" option is enabled.

### `TclUrlParser`
Utility class for parsing URLs to determine the appropriate proxy type based on the URL protocol.

## Usage

1. **Configure Proxy Settings**:
   - Select proxy type from the dropdown (HTTP Proxy, SOCKS4, SOCKS5)
   - Click "Get IE Proxy" to automatically retrieve system proxy settings
   - Manually enter proxy server, port, and authentication if needed

2. **Configure Authentication**:
   - Enter username and password for the target server (if required)
   - Enter proxy username and password (if proxy requires authentication)

3. **Perform HTTP Request**:
   - Enter the target URL in the URL field
   - Check "Show Text Only" to display parsed text instead of raw HTML
   - Click "Get" to execute the HTTP request

4. **View Results**:
   - The response content appears in the memo control
   - HTML content is parsed if "Show Text Only" is checked

## Proxy Type Handling

The application supports three proxy types:
- **HTTP Proxy**: Standard HTTP proxy (port 8080 default)
- **SOCKS4**: SOCKS version 4 proxy (port 1080 default)
- **SOCKS5**: SOCKS version 5 proxy (port 1080 default)

## URL-Based Proxy Selection
When retrieving IE proxy settings, the application automatically selects the appropriate proxy based on the URL protocol:
- HTTPS URLs use the `https` proxy setting
- HTTP URLs use the `http` proxy setting
- SOCKS URLs use the `socks` proxy setting

## Application Scenarios

- **Enterprise Environments**: Automatically use corporate proxy settings
- **Proxy-Aware Applications**: Build applications that respect system proxy configuration
- **Network Diagnostics**: Test proxy configurations and connectivity
- **Web Scraping Tools**: Configure proxy settings for web data extraction
- **API Clients**: Handle proxy configurations in API-consuming applications

## Requirements
- **Delphi 7 or later** (compatible with a wide range of Delphi versions)
- **Clever Internet Suite** (version compatible with the project)
- **Windows 7 or later** operating system (for IE proxy API access)

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.