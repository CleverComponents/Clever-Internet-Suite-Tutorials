# Digital Signature Demo - Creating and Extracting P7M Files

The DigitalSignatureDemo project is a code example for the [Making and Extracting the content of a .p7m file](https://www.clevercomponents.com/portal/kb/a161/making-and-extracting-the-content-of-a-_p7m-file_.aspx) tutorial.

This tutorial demonstrates how to create and work with P7M digital signature files using Clever Internet Suite components. P7M is a standard format for digitally signed and encrypted data, commonly used for secure document exchange.

Watch on [YouTube](https://youtu.be/Xdma8xDW0mY).

![Screenshot](Image/MakingAndExtracting-Social.jpg)

## Overview

This tutorial shows how to:

- **Create P7M Files**: Digitally sign files and save them in P7M format
- **Extract P7M Contents**: Verify signatures and extract original data from P7M files
- **Manage Certificates**: Load certificates from PFX files or Windows certificate store
- **Verify Digital Signatures**: Validate the authenticity of signed documents
- **Extract Certificates**: Retrieve certificate information from signed P7M files
- **Handle Enveloped Data**: Work with PKCS#7 enveloped data format

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Features

- **Digital Signing**: Create digitally signed P7M files from any document
- **Signature Verification**: Verify digital signatures and extract signed content
- **Certificate Management**: Load certificates from multiple sources (PFX, Windows store)
- **Certificate Extraction**: Extract and display certificates from signed files
- **PKCS#7 Support**: Full support for PKCS#7 standards including P7M format
- **Multiple Hash Algorithms**: Support for SHA-1, SHA-256, SHA-384, SHA-512 algorithms
- **Chain Validation**: Validate certificate chains during signature verification
- **User-Friendly Interface**: Simple GUI for all operations

## Components Used

### Clever Internet Suite Components:
- **TclEncryptor**: Main component for digital signing and verification operations
- **TclCertificateStore**: Manages certificate storage and retrieval
- **TclCertificate**: Represents individual digital certificates

## Usage

1. **Sign a File**:
   - Select any source file to sign using "..." button (PDF, DOC, TXT, etc.)
   - Choose destination path for the P7M output file
   - Select certificate source (PFX file or Windows certificate store)
   - For PFX files: Browse to certificate file and enter password
   - For Windows store: Certificates are loaded from the "MY" store
   - Click "Load" to populate certificate list
   - Select certificate from the loaded list
   - Click "Sign" to create digitally signed P7M file

2. **Verify and Extract from P7M**:
   - Select a P7M file to verify using "..." button
   - Choose destination for extracted content
   - Click "Verify" to:
     - Extract and display certificates from the P7M file
     - Verify the digital signature
     - Extract the original file content

## Application Scenarios

- **Document Security**: Digitally sign important documents for authenticity
- **Secure File Exchange**: Exchange files with verified digital signatures
- **Compliance Requirements**: Meet regulatory requirements for digital signatures
- **Legal Documentation**: Sign legal documents electronically
- **Contract Management**: Digital signing of contracts and agreements
- **Audit Trails**: Create verifiable audit trails for document changes
- **Government Applications**: Work with government-standard P7M formats

## Prerequisites

Before running this tutorial, ensure you have:

1. **Clever Internet Suite** (version 12 or compatible) installed
2. **Delphi 7 or later** (compatible with wide range of Delphi versions)
3. **Windows** operating system with certificate services
4. **Valid digital certificates** (for testing, you can create self-signed certificates)

**Certificate Note**: For testing purposes, you can create self-signed certificates using Windows Certificate Services or OpenSSL. Production use requires certificates from trusted Certificate Authorities.

## Compilation Instructions

1. Clone the repository from [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials)
2. Download and install [Clever Internet Suite](https://www.clevercomponents.com/downloads/inetsuite/suitedownload.asp)
3. Open the DigitalSignatureDemo.dproj project in your Delphi IDE
4. Compile and run the application

## Key Features Demonstrated

1. **Digital Signature Creation**: Complete workflow for creating digitally signed P7M files
2. **Certificate Management**: Loading certificates from different sources
3. **Signature Verification**: Validating digital signatures and extracting content
4. **PKCS#7 Implementation**: Working with standard PKCS#7 enveloped data format
5. **Certificate Chain Validation**: Validating certificate authority chains
6. **Algorithm Flexibility**: Automatic algorithm selection based on certificate capabilities

## Digital Signature Process

The tutorial demonstrates the complete digital signature process:

1. **File Selection**: Choose any file type for digital signing
2. **Certificate Selection**: Choose appropriate signing certificate
3. **Algorithm Determination**: Automatically uses certificate's signature algorithm
4. **Signature Creation**: Creates digital signature using private key
5. **Enveloping**: Packages data and signature in P7M format
6. **Verification**: Validates signature using public key
7. **Extraction**: Recovers original data from signed envelope

## Security Considerations

- **Certificate Storage**: Private keys should be securely stored
- **Algorithm Selection**: Uses certificate's native algorithm for best compatibility
- **Chain Validation**: Verifies certificate authority chains when available
- **Windows Integration**: Leverages Windows CryptoAPI for cryptographic operations

## Related Examples

- [Certificate Store Management](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/CertMgr): Working with Windows certificate stores
- [Encryption and Decryption](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/EncryptDecrypt): File encryption using certificates

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
