# Console FTP Client

A command-line FTP client implementation using Clever Internet Suite, supporting both active and passive modes with TLS encryption.

The FtpConsole project is a code example for the [Console FTP client](https://www.clevercomponents.com/portal/kb/a73/console-ftp-client.aspx) tutorial.   

## Overview

Console-based FTP client that demonstrates core FTP operations through a simple command interface. Built with `TclFtp` component from Clever Internet Suite, featuring TLS support, progress reporting, and certificate verification.  


## Key Features

- File upload/download with progress indication
- Directory listing and navigation  
- Active/passive mode switching
- TLS/SSL encryption support
- Certificate validation with user prompts
- Console-optimized password input (masked)


## Technical Implementation

- Uses `TclFtp` component for all FTP operations
- Implements console progress bar for file transfers
- Handles TLS certificate verification interactively
- Supports explicit and implicit TLS modes
- Provides masked password input in console

## Usage

Run the executable and enter commands interactively:

```bash
# Connect to FTP server
open ftp.example.com 21

# List directory contents  
list

# Download file with progress display
get remote_file.txt local_file.txt

# Upload file
put local_file.txt remote_file.txt

# Navigate directories
chdir /public
cdup

# Enable TLS encryption
tls explicit

# View available commands
help

# Exit the program
quit
```

## Notes

The project was compiled with Clever Internet Suite version 12.  
Tutorials and project files for previous versions of Clever Internet Suite can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.

