# Decode IMAP UTF7 mailbox names in Delphi

The DecodeImapUtf7Names project is a code example for the [Decode IMAP UTF7 mailbox names in Delphi](https://www.clevercomponents.com/portal/kb/a102/decode-imap-utf7-mailbox-names-in-delphi.aspx) tutorial.

This Delphi example shows how to decode IMAP mailbox names that contain Unicode characters encoded using the modified UTF-7 format (see RFC 2060).

## Overview

This tutorial demonstrates how to handle IMAP UTF-7 encoded mailbox names by:
- **Decoding modified UTF-7** strings used in IMAP protocol for international mailbox names
- **Handling Unicode characters** in mailbox names across different languages
- **Supporting RFC 2060** IMAP4rev1 specification for UTF-7 encoding
- **Processing Base64 encoded segments** within UTF-7 strings
- **Validating decoding results** with comprehensive test cases

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Features

- **IMAP UTF-7 Decoding**: Converts IMAP-specific UTF-7 encoded strings to Unicode
- **Multi-language Support**: Handles mailbox names in German, Russian, Greek, and other languages
- **RFC Compliance**: Implements modified UTF-7 encoding as specified in RFC 2060
- **Error Handling**: Robust decoding with proper handling of edge cases
- **Test Suite**: Includes comprehensive test cases for various encoding scenarios
- **Console Application**: Simple command-line interface for testing and validation

## Usage

The example is a console application that demonstrates decoding of IMAP UTF-7 encoded mailbox names:

```delphi
// German mailbox name with special characters
Decode: 'Test &ANw-bung Stra&AN8-e'
Result: 'Test Übung Straße'

// Russian mailbox names
Decode: '[Gmail]/&BBIEMAQ2BD0EPgQ1-'
Result: '[Gmail]/Важное'

// Greek mailbox name
Decode: 'Test-&A5EDwAOsA70DxAO3A8MDtw-'
Result: 'Test-Απάντηση'
```

Run the application to see all test cases execute and validate the decoding functionality.

## Application Scenarios

- **IMAP Client Development**: Decode international mailbox names in IMAP clients
- **Email Migration Tools**: Handle mailbox names when migrating between email systems
- **Internationalization**: Support non-ASCII mailbox names in email applications
- **Debugging & Logging**: Decode UTF-7 encoded names in log files and debug output
- **Email Server Administration**: Manage international mailbox names in administrative tools
- **Email Backup Solutions**: Process mailbox names during backup and restore operations

## Implementation Details

The decoder follows the IMAP UTF-7 specification:
1. **Base64 Segments**: Text between `&` and `-` is Base64 encoded
2. **Direct Representation**: Characters outside the range 0x20-0x7E are encoded
3. **Ampersand Escaping**: Literal `&` is represented as `&-`
4. **Modified Base64**: Uses `,` instead of `/` in Base64 encoding

## Requirements

- **Delphi 2009 or later** (requires Unicode/UTF-8 support)
- **Clever Internet Suite version 10 or later**

**Note**: The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Compilation Instructions

This project uses two units from Clever Internet Suite:
- **clEncoder.pas**: For Base64 decoding operations
- **clTranslator.pas**: For character set conversion between UTF-7 and UTF-16BE

Both units are included in the standard Clever Internet Suite installation.

## Related Documents

- [RFC 2060](http://www.faqs.org/rfcs/rfc2060.html) - IMAP4rev1 protocol specification including UTF-7 encoding
- [Delphi and Unicode](https://www.embarcadero.com/images/dm/technical-papers/delphi-and-unicode-marco-cantu.pdf) - Marco Cantù, December 2008. Comprehensive guide to Unicode handling in Delphi

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
