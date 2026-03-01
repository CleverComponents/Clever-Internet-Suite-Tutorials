# Setting Up HTTP Proxy Parameters in TCP-based Client Components

The SettingUpHttpProxy project represents a code example for the [Setting Up HTTP Proxy Parameters in TCP-based Client Components](https://www.clevercomponents.com/portal/kb/a21/setting-up-http-proxy-parameters-in-tcp-based-client-components.aspx) tutorial. This tutorial shows how to set up proxy parameters in the TclDownloader, TclUploader, TclHttp, TclFtp, TclSmtp, and other TCP-based client components.

## Overview
This example demonstrates the configuration of HTTP proxy server settings for various client components from the Clever Internet Suite library. Each button in the application configures and uses a different component through a proxy.

*   **Downloader Button**: Configures proxy for `TclDownLoader`, `TclUploader`, `TclMultiDownLoader`, and `TclMultiUploader` components.
*   **HTTP Client Button**: Configures proxy for the `TclHttp` component and performs a GET request.
*   **FTP Client Button**: Configures HTTP CONNECT proxy for the `TclFtp` component and opens a connection.
*   **SMTP Client Button**: Configures a standalone `TclHttpProxy` component and assigns it to the `TclSmtp` component's `Proxy` property, then opens a connection.

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Features
*   Proxy configuration (`Server`, `Port`, `UserName`, `Password`) for downloader/uploader components (`TclDownLoader`, `TclUploader`, `TclMultiDownLoader`, `TclMultiUploader`).
*   Proxy configuration for the HTTP client component (`TclHttp`).
*   HTTP CONNECT proxy setup for the FTP client component (`TclFtp`).
*   Using a dedicated proxy component (`TclHttpProxy`) with the SMTP client (`TclSmtp`).
*   Demonstrates the common `HttpProxySettings` (or `ProxySettings`) property pattern across the library.
*   Complete component documentation is available at [Clever Internet Suite Components](https://www.clevercomponents.com/products/inetsuite/components.asp)

## Application Scenarios
*   Enabling internet access for applications deployed in corporate environments where all traffic must pass through an HTTP proxy.
*   Developing network clients that need to work seamlessly from behind proxy servers.
*   Understanding the unified approach to proxy configuration across different protocols (HTTP, FTP, SMTP) within the Clever Internet Suite.

## Requirements
*   **Delphi**: Delphi 7 or newer.
*   **Clever Internet Suite**: Version 10.0 or newer.
*   The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
