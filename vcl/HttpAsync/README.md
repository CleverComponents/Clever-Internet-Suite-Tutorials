# Asynchronous HTTP Download

The HttpAsync project represents a code example for the [Asynchronous HTTP download](https://www.clevercomponents.com/portal/kb/a63/asynchronous-http-download.aspx) tutorial.   

Download URLs asynchronously in multiple threads from thread pool.   


## Overview

This project demonstrates how to implement asynchronous HTTP downloads using TclThreadPool and TclHttp components from Clever Internet Suite. The example shows a multi-threaded download manager that can download multiple files simultaneously while maintaining thread safety, proper synchronization, and cookie management.

This implementation uses Clever Internet Suite's own threading components (TclThreadPool, TclThreadSynchronizer), making it compatible with a wide range of Delphi versions. For an alternative approach using Delphi's TTask class, see the [HTTP Get using TTask](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/Http-Get-Using-TTask) demo.

The project was compiled with Clever Internet Suite version 12.  
Tutorials and project files for previous versions of Clever Internet Suite can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.


## Features

- Asynchronous HTTP downloads using TclThreadPool
- Multiple simultaneous downloads in background threads
- Thread-safe UI updates with TclThreadSynchronizer
- Download progress monitoring and cancellation support
- Cookie management with TclCookieManager
- Visual download queue with status indicators
- Safe application termination during active downloads


## Usage

1. **Add downloads to queue**:
   - Enter URL in "URL" field
   - Enter local filename in "File" field  
   - Click "Add" to add to download list

2. **Manage downloads**:
   - Click "Start" to begin all queued downloads
   - Click "Stop" to cancel all active downloads
   - View download status in the list (Ready, Process, Success, Error, Stop)

3. **Monitor cookies**:
   - View cookies received during downloads in the cookies memo

4. **Application safety**:
   - The application prevents closing while downloads are active
   - Proper thread synchronization ensures stable operation


## Clever Internet Suite Components Used

### TclHttp
Performs HTTP GET requests to download files from URLs. Configured with cookie management and progress monitoring.

### TclThreadPool
Manages a pool of worker threads for executing download tasks. Queues work items and efficiently reuses thread resources.

### TclCookieManager
Manages HTTP cookies shared across all download threads. Provides thread-safe cookie storage and synchronization.


## Application Scenarios

- **Batch File Downloads**: Download multiple files simultaneously
- **Download Managers**: Build custom download management applications
- **Content Mirrors**: Mirror web content with parallel downloads
- **Media Downloaders**: Download videos, images, or documents in bulk
- **Software Updaters**: Download multiple update files concurrently
- **Data Synchronization**: Sync files from multiple sources simultaneously


## Advantages of TclThreadPool Approach

1. **Wide Delphi Compatibility**: Works with Delphi 7 and later versions
2. **Fine-grained Control**: More control over thread management
3. **Resource Management**: Efficient reuse of thread resources
4. **Queue Management**: Built-in work item queuing
5. **Native Integration**: Tight integration with other Clever Internet Suite components


## Safety and Synchronization

- **Thread-Safe UI**: All UI updates use TclThreadSynchronizer.Synchronize()
- **Resource Protection**: Critical sections protect shared resources
- **Graceful Shutdown**: Prevents application close during active operations
- **Cookie Safety**: Thread-safe cookie management
- **Cleanup**: Proper resource release in exception scenarios


## Requirements

- **Delphi 7 or later** (compatible with wide range of Delphi versions)
- **Clever Internet Suite 12** or compatible version
- **Windows** compatible operating system

**Note**: This implementation is specifically designed for broad Delphi compatibility and does not require modern Delphi features like TTask.


## Comparison with TTask Approach

For developers choosing between threading approaches, consider:

| Aspect | TclThreadPool (This Demo) | [TTask Demo](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/Http-Get-Using-TTask) |
|--------|---------------------------|----------------------|
| **Delphi Compatibility** | Delphi 7+ | Delphi XE7+ |
| **Thread Management** | Pool-based, reusable threads | One-time task threads |
| **Integration** | Native Clever Suite components | Delphi RTL components |
| **Control Level** | Fine-grained thread control | Higher-level abstraction |
| **Resource Usage** | Efficient thread reuse | New thread per task |
| **Best For** | High-performance, batch operations | Simple async operations |


## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.