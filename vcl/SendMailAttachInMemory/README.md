# Sending Email with Attachments from Memory Streams

The SendMailAttachInMemory project represents a code example for the [Sending Mail with Attachments from Memory Stream](https://www.clevercomponents.com/portal/kb/a121/sending-mail-with-attachments-from-memory-stream.aspx) tutorial.

This tutorial demonstrates how to send email messages with attachments loaded directly from memory streams rather than from files on disk.

## Overview

This tutorial demonstrates how to:

- Compose email messages with text content and attachments
- Load attachment data from memory streams instead of files
- Integrate database BLOB fields as email attachments
- Handle the OnLoadAttachment event to provide attachment data dynamically

## Features

- **In-Memory Attachments**: Load attachment content directly from memory streams
- **Database Integration**: Attach BLOB fields from databases to emails
- **Dynamic Content**: Provide attachment data at runtime via event handlers
- **Stream Management**: Proper memory stream creation and cleanup

## Usage

1. **Compose Message**:
   - Build message with text content and attachment filenames
   - Set subject, sender, and recipient addresses

2. **Provide Attachment Data**:
   - Handle the `OnLoadAttachment` event
   - Create memory stream and load data from database BLOB field
   - Set `Handled` to `True` when data is provided

3. **Send Message**:
   - Configure SMTP settings
   - Send the composed message

## Application Scenarios

- **Database Integration**: Send emails with database content as attachments
- **Dynamic Content**: Generate attachment content at runtime
- **Memory Efficiency**: Avoid temporary files when sending attachments
- **Document Generation**: Attach generated reports/documents to emails

## Requirements

- **Delphi 7** or later
- **Clever Internet Suite 12** or compatible version
- **Windows** operating system

The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.