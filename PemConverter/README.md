# RSA Public Key to X509 Subject Key Info Converter

This project demonstrates how to convert RSA public keys into the X509 Subject Public Key Info format using the Clever Internet Suite library. This conversion is essential for certificate operations, security contexts, and interoperability between different cryptographic systems.

## Overview

This Delphi application provides a simple GUI tool that demonstrates two conversion scenarios:
- Convert a raw base64-encoded RSA public key to X509 Subject Key Info format
- Convert an RSA public key in PEM format to X509 Subject Key Info format
- Support for output in both base64 and PEM formats

## Features

- **Dual Conversion Methods**: Convert both raw base64 and PEM-formatted RSA public keys
- **Flexible Output Format**: Generate output in either base64 or PEM format using a simple checkbox
- **Pre-loaded Examples**: Comes with sample keys for immediate testing
- **Simple GUI Interface**: User-friendly form with clear input/output sections
- **Educational Design**: Demonstrates proper use of `TclRsaKey`, `TclEncoder`, and `TclCryptEncoder` components

## Usage

1. **Launch the application** - You'll see two input sections for RSA public keys
2. **Choose input method**:
   - Left section: Enter a raw base64-encoded RSA public key
   - Right section: Enter an RSA public key in PEM format (with BEGIN/END headers)
3. **Select output format** - Check "Use PEM Format" for PEM output, uncheck for base64 output
4. **Click Convert** - Press the corresponding Convert button for your input type
5. **View results** - The converted X509 Subject Key Info appears in the bottom memo

## Application Scenarios

- **Certificate Generation**: Converting RSA keys for X.509 certificate creation
- **Security Integration**: Preparing keys for use with SSL/TLS implementations
- **System Integration**: Converting between different key formats for interoperability
- **Development Testing**: Verifying key format conversions during development
- **Educational Purposes**: Understanding the differences between RSA and X509 key formats

## Requirements

- **Delphi Version**: Delphi 7 or higher
- **Clever Internet Suite**: Version 10.0 or higher
- **Note**: The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.