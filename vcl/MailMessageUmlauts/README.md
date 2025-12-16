# Sending Email with German Umlauts and UTF-8 Characters

The MailMessageUmlauts project provides a code example for the [Send mail with German Umlauts and other UTF-8 characters](https://www.clevercomponents.com/portal/kb/a88/send-mail-with-german-umlauts-and-other-utf-8-characters.aspx) tutorial.

This example shows how to properly configure the TclMailMessage component to handle German umlauts (Ä, Ö, Ü, ß) and other UTF-8 characters, demonstrating different encoding approaches for international email content.

## Overview

This tutorial shows how to:

- Create emails with international characters using different character sets
- Configure proper encoding for German umlauts and special symbols
- Use UTF-8 and Latin-1 (cp1252) character encodings
- Apply different content transfer encodings (auto-detect, 8-bit)
- Save properly encoded email messages to files
- Prepare for SMTP sending with correct character handling

The implementation uses TclMailMessage from Clever Internet Suite to create email messages with proper character encoding, ensuring special characters display correctly across different email clients and systems.

## Features

- **Character Encoding Support**: Handle UTF-8 and Latin-1 character sets
- **Multiple Encoding Methods**: Support for auto-detection and 8-bit encoding
- **Special Character Preservation**: Proper handling of German umlauts and international symbols
- **File Export**: Save encoded messages to .eml files
- **SMTP Integration Ready**: Prepared for email sending via TclSmtp component
- **Visual Component Design**: Use Delphi form components for easy configuration

## Usage

1. **Create Encoded Messages**:
   - Click the "Generate Test Messages" button
   - Three different email messages will be created with various encodings
   - Messages are saved as .eml files in the application directory

2. **Message Types Generated**:
   - **UTF-8 Auto-detect**: Uses automatic encoding detection
   - **UTF-8 8-bit**: Explicit 8-bit encoding for UTF-8 content
   - **Latin-1 8-bit**: Windows-1252 encoding for compatibility

3. **Configure SMTP Sending** (Optional):
   - Uncomment the SMTP sending code in the Button1Click procedure
   - Configure clSmtp1 component properties via Object Inspector
   - Set Server, Port, UserName, Password, and UseTLS properties
   - Recompile and run to send actual emails

## Clever Internet Suite Components Used

### TclMailMessage
The core email message component that handles message creation, character encoding, and proper formatting for international characters.

### TclSmtp
SMTP client component for sending email messages (configured for optional use).

## Character Encoding Examples

The tutorial demonstrates three approaches to handling special characters:

1. **UTF-8 with Auto-detection**: Let the system determine the optimal encoding
2. **UTF-8 with 8-bit Encoding**: Explicit 8-bit transfer encoding for UTF-8 content
3. **Latin-1 (cp1252)**: Windows-1252 encoding for European language support

## Application Scenarios

- **International Email Systems**: Send emails with non-ASCII characters
- **Multi-language Applications**: Support emails in different languages
- **German/French/Spanish Content**: Handle language-specific characters
- **Technical Documentation**: Email technical content with special symbols
- **Customer Communication**: Professional emails with proper encoding
- **Automated Email Systems**: Generate encoded emails programmatically

## Proper Character Handling

Correct character encoding is essential for:
- Displaying German umlauts (Ä, Ö, Ü, ß) properly
- Showing copyright (©), registered (®), and euro (€) symbols
- Supporting international character sets in email subjects and bodies
- Ensuring compatibility across different email clients and servers

## Requirements

- **Delphi 2009 or later** (compatible with wide range of Delphi versions)
- **Clever Internet Suite 12** or compatible version
- **Windows** operating system

**Encoding Note:** This example contains German umlauts (Ä, Ö, Ü, ß) and special characters in the source code. For best compatibility across different systems:
- German Windows users: Save files with ANSI encoding (Windows-1252)
- Other European Windows users: Save files with appropriate ANSI encoding for your locale
- All users: Consider upgrading to Delphi 11+ for native UTF-8 file support

## File Output

The application generates three .eml files:
- `mail-utf8-autodetect.eml` - UTF-8 with auto encoding
- `mail-utf8-8bit.eml` - UTF-8 with 8-bit encoding  
- `mail-latin1-8bit.eml` - Latin-1 (cp1252) encoding

These files can be opened in any email client or text editor to inspect the proper encoding.

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.