# HTML Parser for FireMonkey

The HtmlParserFireMonkey project represents a code example for the [HTML Parser for FireMonkey](https://www.clevercomponents.com/portal/kb/a52/html-parser-for-firemonkey.aspx) tutorial.   

This sample demonstrates HTML parsing using the TclHtmlParser component in FireMonkey applications.  

## Overview

This project demonstrates how to parse HTML content in FireMonkey (FMX) applications using the TclHtmlParser component from Clever Internet Suite. The example shows how to extract common HTML elements including page title, meta description, links, images, and other tags from HTML documents.

The project was compiled with Clever Internet Suite version 12.  
Tutorials and project files for previous versions of Clever Internet Suite can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Features

- Parse HTML files and extract structured content
- Retrieve page title and meta description
- Extract all hyperlinks from the document
- Collect image references and URLs
- Count HTML tags and elements
- FireMonkey-compatible UI with memo display
- File-based HTML input with path selection


## Usage

1. Enter the path to an HTML file in the text field
2. Click the "Parse" button to process the HTML document
3. View extracted information in the memo control:
   - Page title
   - Meta description
   - Number of HTML tags
   - Number of hyperlinks
   - Number of images

## Code Highlights

The main parsing functionality is implemented in the `Button1Click` event handler:

```pascal
parser := TclHtmlParser.Create(nil);
src := TStringList.Create();
src.LoadFromFile(Edit1.Text);
parser.Parse(src);

// Access parsed content
Memo1.Lines.Add(parser.Title);
Memo1.Lines.Add(parser.Description);
Memo1.Lines.Add('Tags: ' + IntToStr(parser.Tags.Count));
Memo1.Lines.Add('Links: ' + IntToStr(parser.Links.Count));
Memo1.Lines.Add('Images: ' + IntToStr(parser.Images.Count));
```

## Application Scenarios

- **Content Analysis**: Extract and analyze HTML structure
- **Link Validation**: Collect and verify hyperlinks in documents
- **SEO Tools**: Retrieve meta information for SEO analysis
- **Document Processing**: Parse HTML for content extraction
- **Web Scraping**: Foundation for web data extraction tools

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
