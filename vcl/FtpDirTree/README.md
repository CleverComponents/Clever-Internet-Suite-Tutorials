# FTP Directory Tree Viewer

Windows VCL application that visually displays the complete directory structure of an FTP server using Clever Internet Suite.

The FtpDirTree project is a code example for the [Get the complete FTP directory tree](https://www.clevercomponents.com/portal/kb/a72/get-the-complete-ftp-directory-tree_.aspx) tutorial.   


## Overview

This application connects to an FTP server and recursively scans its directory tree, displaying the structure in a text format with visual indentation. The tool uses tab characters to represent directory levels, creating a clear hierarchical view of the server's contents.


## Key Features

- Recursive FTP directory traversal
- Text-based tree display with tab indentation
- Support for configurable starting directory
- Simple and intuitive VCL interface


## Technical Implementation

- The application uses `TclFtp` component with event-driven directory listing.
- Directories and files listed with tab (#9) indentation
- Each nesting level adds another tab character
- Flat text output in TMemo for easy copying/saving
- TclFtp.OnDirectoryListing: Called for each item in directory, appends item name with current indentation level, and triggers recursive calls for subdirectories.


## Notes

The project was compiled with Clever Internet Suite version 12.  
Tutorials and project files for previous versions of Clever Internet Suite can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.


## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.

