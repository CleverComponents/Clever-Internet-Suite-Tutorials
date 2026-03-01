# Wake On LAN Sample

This Delphi example demonstrates how to send Wake-on-LAN (WOL) magic packets to remotely wake up computers on a local network using the Clever Internet Suite library. The application implements a simple WOL client that sends the standard magic packet format to broadcast addresses.

This project represents a code example for the [Wake up on LAN](https://www.clevercomponents.com/portal/kb/a54/wake-up-on-lan.aspx) tutorial.

## Overview

The Wake-on-LAN sample shows how to use the `TclUdpClientConnection` component to send UDP broadcast packets containing magic packets for waking up remote computers. The application:

- Converts MAC addresses from string format to binary representation
- Constructs the standard WOL magic packet (6 bytes of 0xFF + 16 repetitions of MAC address)
- Sends UDP packets to the broadcast address (255.255.255.255) on port 2110 (The packet is typically sent over UDP, with ports 7 and 9 being common defaults because they were historically unused, but any port can work)
- Implements proper socket initialization and cleanup using `StartupSocket()` and `CleanupSocket()`

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Features

- **MAC Address Parsing**: Supports MAC addresses in hyphen-separated format (12-34-56-78-9A-BC)
- **Magic Packet Construction**: Builds standard Wake-on-LAN packets according to industry specifications
- **UDP Broadcast**: Sends packets to network broadcast address for LAN-wide delivery
- **Error Handling**: Includes basic input validation and error reporting
- **Clean Socket Management**: Properly initializes and cleans up Winsock resources

## Usage

### Step-by-Step Operation

1. **Enter MAC Address**: Input the target computer's MAC address in the format: `12-34-56-78-9A-BC`
2. **Send Wake Packet**: Click "Wake Up" to send the magic packet to the network broadcast address
3. **Verification**: The target computer should power on or wake from sleep mode

### MAC Address Formats

The application accepts MAC addresses in the following format:
- Hyphen-separated: `12-34-56-78-9A-BC`
- Colon-separated (automatically converted): `12:34:56:78:9A:BC`

## Application Scenarios

- **Remote Computer Management**: Wake up office computers before working hours
- **Home Automation**: Integrate computer control with home automation systems
- **Server Administration**: Remotely start servers in data centers or remote locations
- **Energy Saving**: Keep computers in sleep mode when not in use, wake remotely when needed
- **IT Support**: Provide remote assistance by waking up client computers

## Compilation Instructions

1. Open the project in Delphi IDE (7 or newer)
2. Ensure Clever Internet Suite components are installed in the IDE
3. Add the Clever Internet Suite library path to your project search paths if needed
4. Build the project - no additional third-party libraries required

## Requirements

- **Delphi Version**: Delphi 7 or higher (Unicode support required)
- **Clever Internet Suite**: Version 10.0 or higher
- **Network Configuration**:
  - Target computer must have Wake-on-LAN enabled in BIOS/UEFI settings
  - Network adapter must be configured for Wake-on-LAN in device manager
  - Application must run on the same subnet as the target computer (broadcast packets don't cross routers by default)
  - Some networks may require specific firewall rules for UDP port 2110 (7, 9, or any)
  - Router configured to forward UDP port 2110 (7, 9, or any) to broadcast address (255.255.255.255)
    
**Note**: The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
