# Parse XML, Extract All Elements, Attributes and Included Data

The ParseXmlHtmlParser project is a code example for the [Parse XML, extract all elements, attributes and included data.](https://www.clevercomponents.com/portal/kb/a86/parse-xml-extract-all-elements-attributes-and-included-data_.aspx) tutorial.

This tutorial demonstrates how to use the `TclHtmlParser` component from Clever Internet Suite to parse XML documents, extract all elements, their attributes, and text data, providing a structured view of the XML document hierarchy.

## Overview

This tutorial shows how to:

- **Parse XML Documents**: Load and parse XML content using the versatile `TclHtmlParser` component.
- **Extract XML Elements**: Iterate through all tags in the parsed document, identifying XML elements.
- **Retrieve Element Attributes**: Access and display all attributes associated with each XML element.
- **Extract Text Data**: Capture text content contained within XML elements, filtering out comments and whitespace.
- **Navigate Document Structure**: Traverse the parsed document while maintaining element relationships.

This example highlights the dual capability of the `TclHtmlParser` component to handle both HTML and XML parsing with consistent API.

## Features

- **XML Parsing**: Parse well-formed XML documents using the HTML parser component.
- **Complete Element Extraction**: Access all XML elements, attributes, and text nodes.
- **Attribute Enumeration**: Retrieve and display all attribute name-value pairs for each element.
- **Text Data Extraction**: Capture and display text content within XML elements.
- **Comment Filtering**: Automatically exclude XML comments (`<!-- -->`) from the parsing results.
- **Structured Output**: Display parsed data in a hierarchical, readable format with proper indentation.
- **Relationship Navigation**: Utilize tag properties like `NextTag` and `Owner` to understand document structure.

## Components Used

### Clever Internet Suite Components:
- **`TclHtmlParser`**: Core component used for parsing both HTML and XML documents.

## Usage

1. **Prepare XML Content**:
   - Enter or paste valid XML content into the left memo (`Memo1`).
   - Ensure the XML is well-formed with proper opening and closing tags.

2. **Parse and Extract**:
   - Click the "Parse" button (`Button1`).
   - The application parses the XML content and extracts all elements, attributes, and data.

3. **View Results**:
   - The right memo (`Memo2`) displays the extracted content:
     - Each XML element name is displayed on its own line.
     - Element attributes are listed indented below their parent element with name:value format.
     - Text data contained within elements is displayed as "Data:" followed by the text content.

## Application Scenarios

- **XML Data Processing**: Extract and process data from XML files for integration with other systems.
- **Configuration File Parsing**: Read and interpret XML-based configuration files in applications.
- **Web Service Integration**: Parse XML responses from REST or SOAP web services.
- **Data Transformation**: Extract specific data from XML for conversion to other formats (CSV, JSON, database).
- **XML Validation Tools**: Analyze XML structure and content for validation purposes.
- **Document Analysis**: Examine XML document structures for debugging or documentation.
- **Content Extraction**: Pull specific information from XML feeds or documents.

## Requirements

- **Delphi Version**: Delphi 7 or later (code is compatible with both non-Unicode and Unicode versions).
- **Clever Internet Suite**: Version 12.0 or compatible.
- **Prerequisites**: Basic understanding of XML structure, elements, and attributes.

## Key Implementation Details

1. **Parsing Initialization**: The parser automatically processes the XML content without requiring specific XML parsing mode configuration.
2. **Tag Iteration**: The code iterates through all tags in `clHtmlParser1.Tags` collection.
3. **Filtering Logic**:
   - Skips text nodes (`IsText` property).
   - Excludes XML comments (tags with name `'!--'`).
4. **Attribute Extraction**: For each element, all attributes are accessed via `AttributeCount` and `Attributes` array.
5. **Text Data Extraction**: Text content is retrieved by checking:
   - If the next tag is a text node (`NextTag.IsText`).
   - If the text tag belongs to the same owner hierarchy.
   - If the trimmed text is not empty.
6. **Output Formatting**: Uses tab characters (`#9`) for indentation to create a clear hierarchical display.

## Code Structure

- `Button1Click`: Main procedure that triggers XML parsing and data extraction.
- The parsing process automatically handles XML document structure without additional configuration.
- Text extraction logic ensures only relevant text data is captured, avoiding whitespace and unrelated text nodes.

## XML Parsing Notes

- The `TclHtmlParser` component is designed to handle both HTML and XML parsing, making it versatile for various markup languages.
- XML comments (`<!-- comment -->`) are automatically filtered out during parsing.
- The parser preserves the document structure, allowing navigation through tag relationships.
- Attribute values are automatically decoded and available as strings.

## Related Resources

- [HTML Parsing Examples](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/HtmlParser) - Additional examples of HTML/XML parsing capabilities.
- [Clever Internet Suite Documentation](https://www.clevercomponents.com/products/inetsuite/) - Complete product information and support.

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.