# How to send a GET request with JSON data

The SendJSONGetRequest project represents a code example for the [How to send a GET request with JSON data](https://www.clevercomponents.com/portal/kb/a125/how-to-send-a-get-request-with-json-data.aspx) tutorial.

This tutorial demonstrates three different approaches to create and send JSON requests using Clever Internet Suite. Each method shows a unique way to construct JSON payloads for HTTP requests, providing flexibility for different development scenarios.

## Overview

This tutorial demonstrates three distinct methods for creating and sending JSON requests:

1. **Raw JSON Strings**: Constructing JSON manually as string literals
2. **Object Serialization**: Using RTTI-based object serialization with TclJsonSerializer
3. **TclJSONObject API**: Programmatic JSON construction using TclJSONObject class methods

Each method has its own advantages and is suitable for different use cases, from simple requests to complex object hierarchies.

## Features

- **Three JSON Creation Methods**: Learn multiple approaches to JSON construction
- **HTTP Communication with JSON**: Send JSON payloads via HTTP requests
- **JSON Serialization/Deserialization**: Convert Delphi objects to/from JSON
- **RTTI-Based Mapping**: Attribute-driven object serialization
- **Flexible JSON Manipulation**: Direct API access for programmatic JSON building
- **Response Handling**: Parse and display server responses
- **Error Management**: Comprehensive HTTP error handling

## The Three JSON Creation Methods

### 1. Raw JSON Strings
The simplest approach using string literals. Ideal for:
- Quick prototyping
- Simple, static JSON structures
- Testing and debugging
- Minimal dependencies

This method involves manually creating JSON as a string literal and passing it to the HTTP request builder.

### 2. Object Serialization with TclJsonSerializer
Type-safe approach using Delphi classes with custom attributes. Ideal for:
- Complex object hierarchies
- Type safety and compile-time checking
- Code maintainability
- Automatic serialization/deserialization
- Production-grade applications

This method uses the [JSON object serializer for Delphi](https://github.com/CleverComponents/Json-Serializer) library, which provides RTTI-based JSON serialization capabilities. Classes are decorated with attributes like `TclJsonString` and `TclJsonProperty` to define JSON field mappings.

### 3. TclJSONObject API
Programmatic approach with full control over JSON construction. Ideal for:
- Dynamic JSON construction
- Conditional field inclusion
- Complex JSON manipulation
- Situations where object structure is not known at compile time

This method uses the TclJSONObject class from Clever Internet Suite to programmatically build JSON structures. It provides methods for adding strings, values, and boolean fields directly.

## Usage

1. **Run the Demo Application**:
   - Click "Raw JSON String" to send a manually constructed JSON request
   - Click "Object Serialization" to use RTTI-based object serialization
   - Click "TclJSONObject API" to use programmatic JSON construction

2. **View Results**:
   - Each method displays the created JSON payload in the memo control
   - Server responses show the JSON returned from the API
   - Deserialized objects display their property values for the serialization method

3. **Method Comparison**:
   - Compare JSON output from all three methods
   - Observe different approaches to the same task
   - Understand trade-offs between simplicity, type safety, and flexibility

## Application Scenarios

- **API Integration**: Different approaches for different API complexity levels
- **Configuration Management**: Store and transmit settings as JSON
- **Data Exchange**: Structured data transfer between systems
- **Microservices Communication**: JSON-based service interactions
- **Mobile Backends**: REST API communication from desktop clients
- **Third-Party Services**: Integration with external JSON-based APIs

## Implementation Details

### JSON Serialization Library
The object serialization method uses the open-source [JSON object serializer for Delphi](https://github.com/CleverComponents/Json-Serializer) library, which provides:
- Attribute-based JSON mapping
- Support for complex types (arrays, objects, maps)
- Bidirectional serialization (object to JSON and back)
- Type-safe data conversion

### HTTP Communication
All methods use TclHttp.SendRequest for HTTP communication with:
- JSON payload construction via TclHttpRequest.BuildJSONRequest
- Unified interface for different HTTP methods
- Stream-based response handling
- Error status code management

### Error Handling
The example includes comprehensive error handling:
- HTTP status code checking
- SilentHTTP property set to True for manual error handling
- Descriptive error messages for troubleshooting
- Graceful failure recovery

## Method Comparison Table

| Method | Pros | Cons | Best For |
|--------|------|------|----------|
| **Raw JSON Strings** | Simple, no dependencies, easy to debug | No type safety, manual escaping, error-prone | Simple requests, quick tests |
| **Object Serialization** | Type-safe, maintainable, automatic conversion | Requires extra library, class definitions | Complex objects, production code |
| **TclJSONObject API** | Flexible, dynamic, full control | Verbose, manual field management | Dynamic JSON, conditional fields |

**Note**: The TclJSONObject class provides AddString, AddValue, and AddBoolean methods. For numeric values, use AddValue with string representation.

## Important Configuration Notes

**This example is pre-configured to work with JSONPlaceholder**, a free fake online REST API for testing.

**To use with your own API**:
1. Update the base URL in the FormCreate method to your API endpoint
2. Adjust JSON structures to match your API specifications
3. Modify HTTP methods if needed (GET/POST/PUT/DELETE)
4. Configure authentication headers if required
5. Update class definitions for object serialization to match your data model

## Requirements

- **Delphi XE2 or later** (RTTI support required for serialization)
- **Clever Internet Suite 12** or compatible version
- **JSON Serializer Library** (included in project or from [GitHub](https://github.com/CleverComponents/Json-Serializer))
- **Internet connection** for API communication

The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.