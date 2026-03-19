# API Integration
> Calling REST APIs from Tasker, handling JSON responses, and authentication patterns.

## Key Facts
- The **HTTP Request** action is the primary method for API calls (Net > HTTP Request)
- Supports methods: GET, POST, PUT, DELETE, HEAD, PATCH
- Replaces the deprecated **HTTP Get** and **HTTP Post** actions
- Response body stored in `%http_data`, status code in `%http_response_code`, headers in `%http_headers()` array
- JSON responses can be parsed with JavaScriptlet, structured variables (v5.12+), or plugins

## Details

### HTTP Request Action
The HTTP Request action (Net > HTTP Request) provides these configuration fields:

- **Method**: GET, POST, PUT, DELETE, HEAD, or PATCH
- **URL**: The full endpoint URL (variables supported, e.g., `https://api.example.com/%endpoint`)
- **Headers**: Key:Value pairs, one per line (e.g., `Authorization:Bearer %token`, `Content-Type:application/json`)
- **Query Parameters**: Key:Value pairs appended to the URL as query string parameters
- **Body**: Raw text body for POST/PUT/PATCH requests (typically JSON)
- **File To Send**: For multipart/form-data uploads, format is `name:filepath` (e.g., `photo:/sdcard/image.jpg`)
- **File To Save With Output**: Saves the response body directly to a file instead of `%http_data` -- useful for downloading files
- **Trust Any Certificate**: Bypasses SSL certificate validation -- use only for self-signed certificates during development
- **Timeout**: Connection and read timeout in seconds

### Response Variables
After an HTTP Request completes:
- `%http_data` -- the response body (text content)
- `%http_response_code` -- the HTTP status code (200, 404, 500, etc.)
- `%http_headers()` -- array of response headers
- `%http_cookies()` -- array of cookies from the response

### JSON Parsing

#### JavaScriptlet Method
```
var data = JSON.parse(http_data);
setLocal("name", data.user.name);
setLocal("email", data.user.email);
setLocal("count", data.items.length.toString());
```
- Use `setLocal()` to push parsed values back into Tasker local variables
- Best for complex parsing, nested objects, and data transformation
- Numbers must be converted to strings with `.toString()` before passing to Tasker

#### Structured Variables (v5.12+)
- Access JSON fields directly: `%http_data.user.name`, `%http_data.items(1).id`
- Array indexing starts at 1 in Tasker (not 0)
- Works without any additional parsing step
- Best for simple, direct field access

#### AutoTools JSON Read Plugin
- Plugin action that parses JSON and creates named variables
- Useful for users who prefer a no-code approach
- Supports JSONPath-style field selection

### Authentication Patterns

#### API Key in Header
- Add to Headers field: `Authorization:Bearer YOUR_API_KEY` or `X-API-Key:YOUR_KEY`
- Store the key in a global variable for reuse: `Authorization:Bearer %API_KEY`

#### API Key in Query Parameter
- Add to Query Parameters: `api_key:YOUR_KEY`

#### OAuth 2.0 Flow
1. Use **Send Intent** or **Browse URL** to open the authorization URL in a browser
2. Set up a Tasker profile to capture the redirect callback (via Intent Received or AutoShare)
3. Extract the authorization code from the callback
4. Make an HTTP Request POST to the token endpoint with the code
5. Store the access token and refresh token in global variables
6. Include the access token in subsequent API requests
7. Implement token refresh logic when receiving 401 responses

### Rate Limiting and Retries

#### Simple Retry Pattern
```
Task: API Call With Retry
A1: Variable Set %retry_count to 0
A2: HTTP Request [Method:GET URL:https://api.example.com/data]
A3: Variable Set %local_err to %err
A4: If %local_err Is Set AND %retry_count < 3
A5:   Variable Add %retry_count Value 1
A6:   Wait 2 seconds
A7:   Goto A2
A8: End If
```

#### Rate Limit Handling
- Check `%http_response_code` for 429 (Too Many Requests)
- Parse `Retry-After` header if present
- Implement exponential backoff: wait 1s, 2s, 4s, 8s between retries

## Gotchas
- The deprecated HTTP Get/HTTP Post actions are still present in older projects but should be migrated to HTTP Request
- `%http_data` can be very large for big responses -- use File To Save With Output for large downloads to avoid memory issues
- JSON parsing with structured variables uses 1-based indexing, not 0-based
- Headers must be `Key:Value` format with a colon separator -- no spaces around the colon
- Trust Any Certificate should NEVER be used in production -- it disables SSL security entirely
- `%http_response_code` is set even when the request "fails" (e.g., 404, 500) -- check the status code, not just `%err`
- Large JSON responses in `%http_data` may be truncated if they exceed Tasker's variable size limit
- When sending JSON in the body, set the `Content-Type:application/json` header explicitly

## Related
- [[javascript.md]] -- JS can also make HTTP requests via XMLHttpRequest
- [[error-handling.md]] -- handling API failures
- [[variables.md]] -- storing API responses
