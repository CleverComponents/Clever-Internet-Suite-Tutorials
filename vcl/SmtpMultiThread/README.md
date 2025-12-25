# Bulk Email Sending from a Database Using Thread Pool

The SmtpMultiThread project represents a code example for the [Multithreaded Mail Sender](https://www.clevercomponents.com/portal/kb/a62/multithreaded-mail-sender.aspx) tutorial. This tutorial demonstrates how to load emails from a database and send them asynchronously using a thread pool.

## Overview
This Delphi application demonstrates a multithreaded approach to email sending using the Clever Internet Suite library. The application uses `TclThreadPool` to manage worker threads that concurrently process email sending tasks, loading email content from a database and sending via SMTP. This architecture is suitable for bulk email operations where performance and parallelism are important.

*   **Thread Pool Management**: Utilizes `TclThreadPool` for efficient thread management and workload distribution.
*   **Database Integration**: Loads email content from a database (implementation left as an exercise).
*   **Asynchronous Processing**: Sends emails concurrently across multiple threads.
*   **Connection Resilience**: Automatically reconnects on socket errors.
*   **Progress Tracking**: Monitors active thread count and logs operations.

## Features
*   Multithreaded email sending using `TclThreadPool` and `TclWorkItem` descendants.
*   Thread-safe logging with `TclThreadSynchronizer`.
*   Configurable SMTP connection parameters.
*   Database-driven email content loading (template implementation provided).
*   Graceful thread termination and connection management.
*   Error handling with automatic reconnection on socket errors.
*   Real-time thread count monitoring and activity logging.
*   Complete component documentation is available at [Clever Internet Suite Components](https://www.clevercomponents.com/products/inetsuite/components.asp)

## Project folders

* Delphi — contains source code for Delphi (XE, and newer).
* CBuilder — contains source code for C++Builder XE. Before compiling with newer versions of C++Builder, open the *.cbproj files and replace clinetsuite_xe.lib (and .bpi) with clinetsuite_XXX.lib (.bpi), where XXX is 13 for C++Builder 13, xe8 for C++Builder XE8, etc.

## Usage
1.  Open the `SmtpMultiThread` project in your Delphi (C++Builder) IDE.
2.  Ensure the Clever Internet Suite components are installed and accessible.
3.  **Important**: Implement the database integration:
    *   Complete the `CreateDataSet` method in `TSmtpWorkItem` class to connect to your database.
    *   Adjust the `ComposeEmail` method to match your database schema.
    *   Configure the connection string in the application interface.
4.  Configure SMTP server settings (Server, User Name, Password).
5.  Build and run the application.
6.  Click **Start Thread** to begin sending emails. Multiple threads can be started concurrently.
7.  Monitor the thread count and log messages in the application interface.
8.  Click **Stop All** to gracefully stop all active threads.

## Database Integration Example

Here's an example implementation of the `CreateDataSet` method using FireDAC with SQLite database:

### Delphi:

```pascal
uses
  FireDAC.Comp.Client, FireDAC.Phys.SQLite;

function TSmtpWorkItem.CreateDataSet: TDataSet;
var
  connection: TFDConnection;
  query: TFDQuery;
begin
  connection := TFDConnection.Create(nil);
  try
    connection.DriverName := 'SQLite';
    connection.Params.Values['Database'] := 'c:\database\emails.db';
    connection.Open();

    query := TFDQuery.Create(nil);
    query.Connection := connection;
    query.SQL.Text := 'SELECT * FROM emails WHERE sent = 0';
    query.Open();

    Result := query;
  except
    connection.Free();
    raise;
  end;
end;
```

### C++Builder:

```cpp
#include <FireDAC.Comp.Client.hpp>
#include <FireDAC.Phys.SQLite.hpp>

TDataSet* __fastcall TSmtpWorkItem::CreateDataSet()
{
    TFDConnection* connection = new TFDConnection(NULL);
    try
    {
        connection->DriverName = "SQLite";
        connection->Params->Values["Database"] = "c:\\database\\emails.db";
        connection->Open();

        TFDQuery* query = new TFDQuery(NULL);
        query->Connection = connection;
        query->SQL->Text = "SELECT * FROM emails WHERE sent = 0";
        query->Open();

        return query;
    }
    catch(...)
    {
        delete connection;
        throw;
    }
}
```

### Database Schema Example (SQLite):

```sql
CREATE TABLE emails (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    subject TEXT,
    from_address TEXT,
    tolist TEXT,
    text_content TEXT,
    html_content TEXT,
    sent INTEGER DEFAULT 0
);
```

## Application Scenarios
*   Bulk email sending for marketing campaigns.
*   Transactional email systems requiring high throughput.
*   Email notification systems that process large mailing lists.
*   Applications that need to send emails asynchronously without blocking the user interface.
*   Systems that load email templates from databases or other data sources.

## Requirements
*   **Delphi**: Delphi XE or newer.
*   **Clever Internet Suite**: Version 10.0 or newer.
*   **Database**: Access to a database for loading email content (implementation required).
*   **SMTP Server**: Access to an SMTP server for sending messages.
*   The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

**Note:** You can use [Clever SMTP Server](https://github.com/CleverComponents/Clever-Internet-Suite-Examples/tree/master/Delphi/SmtpServer) example for local testing.  

**Note on FireDAC:** If you plan to use the provided FireDAC database examples, note that FireDAC is fully integrated starting from Delphi XE6 (2014). For earlier versions (XE-XE5), you may need to use alternative database access technologies such as dbExpress, ADO, or BDE.

## Repository
The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects for the [Clever Internet Suite Tutorials](https://www.clevercomponents.com/articles/article035/). It will be updated periodically with new projects.

Stay tuned for new examples and use cases of the [Clever Internet Suite](https://www.clevercomponents.com/products/inetsuite/) library.