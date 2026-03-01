# HTTP Get using TTask

This tutorial shows how to use the parallel threads provided by the TTask class in the Http.Get example. [HTTP Get using TTask](https://www.clevercomponents.com/portal/kb/a160/http-get-using-ttask.aspx) 

The sample demonstrates asynchronous HTTP GET operations using TTask for background processing with thread-safe UI updates.

<img src="Image\GetURL-Social.jpg"/>

<br clear="both">

## Overview

This project demonstrates how to perform asynchronous HTTP requests using the TTask class from Delphi's Parallel Programming Library (PPL) in combination with the TclHttp component from Clever Internet Suite. The example shows practical implementation of background web content downloading while maintaining responsive UI and proper thread synchronization.

**Compatibility Note**: This demo requires **Delphi XE7 or later** due to its use of TTask and TCriticalSection classes from the Parallel Programming Library. For older Delphi versions, alternative threading approaches would be needed.

The project was compiled with Clever Internet Suite version 12.  
Tutorials and project files for previous versions of Clever Internet Suite can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Features

- Asynchronous HTTP GET operations using TTask
- Thread-safe UI updates with TCriticalSection protection
- Dual display modes: raw HTML or parsed text content
- Non-blocking background downloads
- Safe application termination during active operations
- Integration of Clever Internet Suite's HTTP and HTML parsing components


## Usage

1. **Enter a URL** in the address field (e.g., `https://example.com`)
2. **Select display mode**:
   - Unchecked "Show Text": Displays raw HTML content
   - Checked "Show Text": Displays only text content (HTML tags removed)
3. **Click "Get"** to initiate the asynchronous download
4. **View results** in the memo control as they are processed

**Safety Feature**: The application prevents closing while downloads are in progress to avoid thread synchronization issues.


## Code Implementation

The core functionality is implemented in the `Button1Click` method which creates an asynchronous task:

```pascal
procedure TForm1.Button1Click(Sender: TObject);
var
  task: ITask;
begin
  FAccessor.Enter();
  try
    if (FWorkInProgress) then Exit;
    FWorkInProgress := true;
  finally
    FAccessor.Leave();
  end;

  FNeedShowText := cbShowText.Checked;
  task := TTask.Create(procedure()
    var
      html: TStrings;
    begin
      html := TStringList.Create();
      try
        TThread.Synchronize(nil, procedure()
        begin
          Memo1.Lines.Clear();
        end);
        clHttp1.Get(edtUrl.Text, html);

        if FNeedShowText then
        begin
          clHtmlParser1.Parse(html);
        end else
        begin
          TThread.Synchronize(nil, procedure()
          begin
            Memo1.Lines.Assign(html);
          end);
        end;

      finally
        FAccessor.Enter();
        try
          FWorkInProgress := False;
        finally
          FAccessor.Leave();
        end;
        html.Free();
      end;
    end);
  task.Start();
end;
```

Key aspects of this implementation:
- **Critical Section Protection**: `FAccessor` protects the `FWorkInProgress` flag
- **Background Processing**: HTTP request executes in a TTask thread
- **UI Thread Safety**: All UI updates use `TThread.Synchronize`
- **Resource Management**: Proper cleanup in `finally` blocks


## Key Concepts Demonstrated

1. **Asynchronous Task Execution**: Using TTask for background operations
2. **Thread Synchronization**: TCriticalSection for shared resource protection
3. **Safe UI Updates**: TThread.Synchronize for thread-safe interface modifications
4. **HTTP Integration**: TclHttp component usage in multithreaded context
5. **HTML Content Processing**: Optional text extraction via TclHtmlParser
6. **Application State Management**: Preventing unsafe operations during processing


## Application Scenarios

- **Background Web Content Retrieval**: Download data without blocking user interface
- **Progressive Content Display**: Show results as they become available
- **Web Scraping Applications**: Extract text content from multiple pages
- **API Client Implementations**: Asynchronous REST API calls
- **Responsive Network Applications**: Maintain UI responsiveness during network operations


## Requirements

- **Delphi XE7 or later** (required for TTask/TCriticalSection support)
- **Windows 7 or later** operating system

**Note for Older Delphi Versions**: Applications targeting Delphi versions prior to XE7 should use TThread directly or alternative threading solutions.


## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
