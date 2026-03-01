# Send Photo using Telegram API

This tutorial demonstrates how to send photos to Telegram channels using the Telegram Bot API with Delphi and Clever Internet Suite components.

<img src="send-tel-photo.jpg"/>

## Overview

This tutorial demonstrates how to:

- Configure and use `TclHttp` and `TclHttpRequest` components for HTTP communication
- Upload images to Telegram channels via Bot API
- Handle multipart/form-data submissions with file attachments
- Provide file data from memory streams using the `OnLoadData` event
- Parse and display JSON responses from Telegram API

---

## 🔔 Get Updates

We publish practical integration examples and technical guides for Clever Components products.

If you'd like to receive updates when new tutorials and component examples are released, you can subscribe here:

👉 https://www.clevercomponents.com/home/maillist.asp

---

## Features

- **Telegram Bot API Integration**: Complete support for Telegram Bot API methods
- **Memory Stream Handling**: Upload images directly from memory without temporary files
- **Multipart Form Submission**: Proper handling of file uploads with form fields
- **SSL/TLS Support**: Secure communication with Telegram servers
- **Response Parsing**: Display JSON responses for debugging and verification

## Usage

1. **Load an Image**:
   - Click "Load Image" button
   - Select a JPEG or PNG file from your computer

2. **Configure Channel**:
   - Enter Telegram channel username (e.g., @channel_name)

3. **Send Photo**:
   - Click "Send" button to upload the image
   - Response from Telegram API displays in the memo control

## Testing Instructions

### Step 1: Get Telegram Bot Token

1. Open Telegram and search for **@BotFather**
2. Start a conversation with @BotFather
3. Send `/newbot` command
4. Follow the instructions:
   - Enter bot name (e.g., `MyTestBot`)
   - Enter bot username (must end with `bot`, e.g., `MyTestPhotoBot`)
5. **Copy the token** provided by @BotFather
   - Format: `1234567890:ABCdefGHIjklMNOpqrSTUvwxYZ`

### Step 2: Create/Find a Channel

#### Option A: Create New Channel
1. In Telegram, tap menu → **New Channel**
2. Enter channel name (e.g., `Test Photo Channel`)
3. Add description (optional)
4. Set privacy (Public/Private)
5. **Remember channel username** (e.g., `@test_photo_channel`)

#### Option B: Use Existing Channel
- Ensure you know channel username (starts with `@`)
- OR know numeric chat_id

### Step 3: Add Bot as Channel Administrator

1. Open your channel
2. Tap channel name → **Administrators**
3. Tap **Add Admin**
4. Find your bot by username
5. Set permissions:
   - ✓ **Post Messages** (REQUIRED!)
   - ✓ **Edit Messages** (optional)
6. Save changes

### Step 4: Configure the Project Code

1. **Open `Unit1.pas` file**
2. **Find `GetBotToken` function** (around line 170-190)
3. **Replace the empty string** with your actual token:

```delphi
function TForm1.GetBotToken: string;
begin
  // Replace with your actual bot token
  Result := '1234567890:ABCdefGHIjklMNOpqrSTUvwxYZ';
end;
```

**IMPORTANT**: Never commit real tokens to public repositories!

### Step 5: Set Channel Name

1. Run the application
2. In **Channel Name** field enter:
   - Channel username: `@test_photo_channel`
   - OR numeric chat_id for private channels

**How to get chat_id for private channels**:
1. Add bot @userinfobot to your channel
2. Send any message in the channel
3. The bot will reply with the chat_id

### Step 6: Test the Application

1. **Load Image**: Click "Load Image" button and select a photo
2. **Send Photo**: Click "Send" button to upload
3. **Verify Result**:
   - Success: `✅ Photo sent successfully!` appears in the response memo
   - Error: `❌ Error: [error description]` shows the specific issue
4. **Check Telegram Channel**: Open your channel to confirm the photo was posted

### Step 7: Verify Success in Telegram

1. Open your Telegram channel
2. Look for the uploaded photo
3. The photo should appear with optional caption (if added)

## Common Issues and Solutions

### Error 1: "Invalid bot token format"
**Cause**: Wrong token format or missing colon
**Solution**: Ensure token contains colon (`:`) in format `1234567890:ABCdefGHIjklMNOpqrSTUvwxYZ`

### Error 2: "Forbidden: bot can't send messages to bots"
**Cause**: Trying to send to bot instead of channel
**Solution**: Use channel username (starts with `@`) or chat_id, not bot username

### Error 3: "Bad Request: chat not found"
**Cause**: 
- Channel doesn't exist
- Bot not added to channel
- Wrong username/chat_id

**Solution**: 
1. Verify channel username is correct
2. Ensure bot is added as administrator (Step 3)
3. For private channels, use numeric chat_id instead of username

### Error 4: "Forbidden: bot is not a member of the channel chat"
**Cause**: Bot not added to channel or lacks admin permissions
**Solution**: Add bot as administrator with "Post Messages" permission (Step 3)

### Error 5: Network/Connection Issues
**Cause**: Firewall blocking, no internet, or SSL/TLS issues
**Solution**:
1. Check internet connection
2. Verify firewall allows the application
3. Ensure SSL/TLS is properly configured in Clever Internet Suite

## Safety and Security Guidelines

**IMPORTANT SECURITY RULES**:
1. Store tokens only locally in source code or configuration files
2. Never commit real tokens to Git repositories
3. Use `.gitignore` to exclude configuration files with tokens
4. Consider using environment variables or encrypted storage for production
5. Regularly rotate/update tokens for security

## Testing Tips

1. **Start with Public Channels**: Public channels are easier to test initially
2. **Use Test Bot**: Create a separate bot specifically for testing
3. **Small Images First**: Test with small JPEG files (under 1MB) initially
4. **Check Response Format**: The response memo shows raw JSON from Telegram API for debugging
5. **Enable SSL/TLS**: Ensure SSL/TLS is enabled in `TclHttp` component for secure communication

## Troubleshooting Checklist

If the photo doesn't appear in your channel:
- Bot token correctly set in `GetBotToken()` function
- Channel name entered correctly in the application
- Bot added as administrator to the channel
- Bot has "Post Messages" permission
- Internet connection is working
- Image is properly loaded before sending
- No error messages in response memo

## Additional Testing Scenarios

1. **Different Image Formats**: Test with JPG, PNG, BMP formats
2. **Image Sizes**: Test with various image sizes (small to large)
3. **Add Captions**: Uncomment caption line in code to add text to photos
4. **Multiple Sends**: Test sending multiple photos in sequence
5. **Error Handling**: Test with invalid tokens or channel names to verify error messages

## Application Scenarios

- **Automated Image Sharing**: Schedule or automate image posting to Telegram channels
- **Bot Development**: Create Telegram bots that handle media content
- **Content Management**: Integrate Telegram photo sharing into existing applications
- **Monitoring Systems**: Send screenshot alerts or reports via Telegram
- **Social Media Tools**: Build tools for cross-platform media distribution

## Implementation Details

### Telegram API Integration
Uses the Telegram Bot API `/sendPhoto` endpoint with bot authentication and channel targeting.

### Stream-Based Upload
The `OnLoadData` event provides image data directly from `TImage.Picture` as a memory stream, eliminating need for temporary files.

### HTTP Components
`TclHttp` handles the HTTP POST request with SSL/TLS support, while `TclHttpRequest` manages multipart form data with file attachment.

### JSON Response Parsing
Telegram API responses are parsed using `TclJsonParser` and `TclJsonObject` from Clever Internet Suite for compatibility across Delphi versions.

## See Also

- [How to write a REST client with JSON in Delphi](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/RestClientSendReceiveJson) - A comprehensive example demonstrating JSON-based REST API communication

## Requirements

- **Delphi 2009** or later (Unicode support required)
- **Clever Internet Suite 12** or compatible version
- **Windows** operating system
- **Telegram Bot Token** (obtain from @BotFather)
- **Telegram Channel** (with bot added as administrator)

The project was compiled with Clever Internet Suite version 12. Tutorials and project files for previous versions can be found in the [Releases](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/releases) section.

## Repository

The [GitHub/CleverComponents/Clever-Internet-Suite-Tutorials](https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials) repository contains a collection of examples, code snippets, and demo projects.

It is updated periodically with new integration scenarios and component examples.
