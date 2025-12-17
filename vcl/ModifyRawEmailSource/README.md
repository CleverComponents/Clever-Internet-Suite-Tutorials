# Modify a Subject Line of an Email within the Raw EML Source

The ModifyRawEmailSource project is a code example for the [How to modify a subject line of the email within the raw source](https://www.clevercomponents.com/portal/kb/a169/how-to-modify-a-subject-line-of-the-email-within-the-raw-_eml-source.aspx) tutorial.

This tutorial demonstrates how to load an email message from a raw `.eml` file, programmatically parse its MIME headers, modify the subject line while preserving the correct character encoding, and send the updated message using the SMTP protocol.

![Screenshot](ModifyRawEmailSource.jpg)

## Overview

This tutorial shows how to:

- **Load Raw Email Messages**: Read a complete email from a standard `.eml` file.
- **Parse MIME Headers**: Use the `TclMailHeaderFieldList` component to parse and manipulate email headers.
- **Modify Specific Headers**: Extract, decode, modify, and re-encode the `Subject` header field.
- **Maintain Character Encoding**: Ensure proper handling of character sets (like UTF-8) and MIME encodings (like Quoted-Printable) during modification.
- **Send Updated Emails**: Transmit the modified message via an SMTP server.

This approach is not limited to the `Subject` field; it can be applied to modify any header field in a raw email source.

## Features

- **Raw Email Manipulation**: Directly work with `.eml` file contents without losing formatting or attachments.
- **Header Field Parsing**: Robust parsing of complex MIME headers with multiple lines and encoded words.
- **Character Set Awareness**: Automatic handling of different character sets and transfer encodings.
- **Non-Destructive Updates**: Modify specific headers while leaving the rest of the message (body, attachments, other headers) intact.
- **SMTP Integration**: Seamlessly send the modified message using the `TclSmtp` component.
- **Reusable Pattern**: The demonstrated pattern can be used to modify any header (From, To, Date, etc.).

## Components Used

### Clever Internet Suite Components:
- **`TclSmtp`**: SMTP client component for sending the email message.
- **`TclMailHeaderFieldList`**: Core component for parsing, decoding, and re-encoding MIME header fields.
- **`TclEncoder`**: Provides underlying encoding/decoding support (used by `TclMailHeaderFieldList`).

## Usage

1.  **Prepare the Source File**: Place a valid `.eml` file (named `mailmessage.eml`) in the application directory or specify its full path in the code.
2.  **Configure SMTP Settings**:
    *   Update the `clSmtp1.Server`, `clSmtp1.UserName`, and `clSmtp1.Password` properties in the code to match your SMTP server credentials.
3.  **Run the Application**:
    *   Click the "Send" button (`btnSend`).
    *   The application loads the `.eml` file, parses its headers, appends " modified..." to the original subject, and sends the updated message via SMTP.

## Application Scenarios

- **Email Campaign Management**: Batch updating subject lines or other headers before sending templated emails.
- **Email Gateway/Proxy Systems**: Intercepting and modifying email headers in transit for logging, routing, or compliance.
- **Automated Email Processing**: Programmatically altering emails received from external sources before forwarding or archiving.
- **Testing and Debugging**: Creating test suites that verify email header manipulation logic.
- **Localization Systems**: Dynamically updating subject lines or sender names based on recipient locale.

## Requirements

- **Delphi Version**: Delphi 2009 or later (requires Unicode support for proper string handling).
- **Clever Internet Suite**: Version 12.0 or compatible.
- **Prerequisites**:
    *   A valid `.eml` source file.
    *   Access to an SMTP server for the sending functionality.

## Key Implementation Details

1.  **Header Field List Creation**: The `TclMailHeaderFieldList` is instantiated with the target character set (`'utf-8'`) and encoding (`cmQuotedPrintable`), defining how new fields will be encoded.
2.  **Parsing**: The `Parse` method reads the raw email data and builds an internal list of header fields.
3.  **Field Manipulation**:
    *   `GetFieldIndex('Subject')` finds the specific header.
    *   `GetDecodedFieldValue` retrieves the human-readable subject string.
    *   `RemoveField` deletes the old header line from the source data.
    *   `AddEncodedField` inserts the new, properly encoded subject line.
4.  **Data Integrity**: The modification happens directly on the `clSmtp1.MailData` string list, ensuring the body and other parts remain unchanged.

## Related Resources

- [How to extract/add MIME headers in E-mail messages and HTTP requests](https://www.clevercomponents.com/portal/kb/a126/how-to-extract-add-mime-headers-in-e-mail-messages-and-http-requests.aspx) - A foundational tutorial on general MIME header manipulation.

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.