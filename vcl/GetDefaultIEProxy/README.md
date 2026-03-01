# Get IE Proxy Settings

The GetDefaultIEProxy project represents a code example for the [Get IE Proxy Settings](https://www.clevercomponents.com/portal/kb/a57/get-ie-proxy-settings.aspx) tutorial.   

Retrieves the default system proxy settings programmatically.   


## Overview

This project demonstrates how to programmatically retrieve system proxy settings on Windows using native Windows API functions through Clever Internet Suite.

The project was compiled with Clever Internet Suite version 12.  
Tutorials and project files for previous versions of Clever Internet Suite can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Modern Context

Although historically associated with Internet Explorer, system proxy settings remain relevant in modern Windows environments for:

1. **Backward Compatibility** with legacy applications using WinINET API
2. **Enterprise Management** through Active Directory Group Policies
3. **Fallback Configuration** for modern browsers (Edge, Chrome, Firefox)

Modern browsers primarily use their own proxy settings stored in user profiles, but they fall back to system settings when browser-specific configurations are not specified. For example, Firefox uses system proxy settings when configured to "Use system proxy".

### Key Technical Points:

- **System Settings Persistence**: Windows maintains system proxy settings in `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings` for compatibility
- **Browser Integration**: Modern browsers check their own settings first, then fall back to system settings
- **Non-Browser Applications**: Many corporate applications, utilities, and system components rely exclusively on system proxy settings
- **Group Policies**: Enterprise environments continue to manage proxy settings through Active Directory, which configures these system settings

### When to Use This Approach:

✅ **Use system proxy settings for:**
- Corporate applications requiring legacy compatibility
- Non-browser network utilities and tools
- Applications that must follow enterprise Group Policies
- Development tools interacting with multiple network clients
- Applications that need to respect user's system-wide proxy configuration

⚠️ **For browser-specific configurations:**
- Modern browsers store settings in their own profile directories
- Browser settings typically override system settings when specified
- Each browser has its own configuration format and location


## Features

- Retrieves default system proxy settings from Windows registry using WinINET API
- Displays proxy server address and port configuration
- Shows proxy bypass list for local addresses
- Supports detection of proxy auto-configuration (PAC) scripts
- Useful for network configuration diagnostics
- Essential for applications requiring system proxy awareness
- Compatible with legacy applications and enterprise environments


## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
