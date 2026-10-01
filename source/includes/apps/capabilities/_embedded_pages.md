## Embedded Pages

Embedded pages let your app present a full custom interface directly inside the Booqable UI, loaded in an iframe. This is the right choice when your app needs a dedicated page or dashboard of its own. For example:

* Custom control surfaces and dashboards.
* Complex configuration interfaces with custom validation.
* Interactive setup wizards and onboarding flows.
* Custom data visualization and monitoring.

### How embedded pages work

```jsonc
// booqable.json
{
  "main_page": {
    "iframe": { "url": "https://my-app.com/dashboard" }
  }
}
```

The `url` is either an absolute URL string, or a relative object like `{ "relative": "/dashboard" }` that is resolved against your manifest's `base_url` (required for relative URLs). Booqable embeds it in an iframe and communicates with it over a `postMessage` protocol described below.

The exact same mechanism is also available as a `configuration_page.iframe`, an alternative to declarative content blocks for your app's settings page. See [Configuration](#configuration) for that specific field; everything below (the auth token, the message protocol) applies identically to both.

### Authentication token

The iframe URL includes a `token` query parameter: a JWT signed with HS256 using your app's OAuth client secret. Its payload contains:

* **Company ID** and **Company Slug**
* **User Email** of the current employee
* **Currency settings**: `currency`, `currency_position`, `currency_format`
* **Distance Unit**: the company's preferred distance unit for deliveries

This token doesn't expire. Treat it as a long-lived credential: validate it on every request rather than assuming freshness.

### Message protocol

```javascript
{
  eventName: "MESSAGE_TYPE",
  payload: {
    // Message-specific data
  }
}
```

The iframe and Booqable communicate through a standardized postMessage protocol. All messages follow this structure and contain two fields: `eventName` and `payload`.

#### Messages from iframe to Booqable

**SET_IFRAME_HEIGHT**
Sets the iframe height in pixels.

```javascript
window.parent.postMessage({
  eventName: "SET_IFRAME_HEIGHT",
  payload: {
    height: 600
  }
}, "*")
```

**SET_FLASH_MESSAGE**
Displays a success or error message to the user.

```javascript
window.parent.postMessage({
  eventName: "SET_FLASH_MESSAGE",
  payload: {
    type: "success", // or "error"
    message: "Configuration saved"
  }
}, "*")
```

**REFRESH_SUBSCRIPTION**
Requests Booqable to refresh the app subscription data.

```javascript
window.parent.postMessage({
  eventName: "REFRESH_SUBSCRIPTION",
  payload: {}
}, "*")
```

**GET_AVATAR**
Requests user avatar information for display in the iframe.

```javascript
window.parent.postMessage({
  eventName: "GET_AVATAR",
  payload: {
    id: "user_id",
    name: "User Name"
  }
}, "*")
```

**NAVIGATE**
Requests Booqable to navigate to a different page.

The `url` must be a **same-origin internal path** (e.g. `/app-store/installed`). For security, Booqable resolves the URL against its own origin and ignores anything that points to a different origin, as well as `javascript:` and `data:` schemes. Use this to move the user between pages within the Booqable dashboard, not to redirect them to external sites.

The optional `reload` flag controls how the navigation happens:

* `false` (default): in-app navigation that keeps the single-page app loaded.
* `true`: a full-page reload. Use this when all data must be refetched and any stale state cleared (for example after your app uninstalls itself and its subscription no longer exists).

```javascript
window.parent.postMessage({
  eventName: "NAVIGATE",
  payload: {
    url: "/app-store/installed",
    reload: false
  }
}, "*")
```

#### Messages from Booqable to iframe

**SET_AVATAR**
Provides avatar information in response to a GET_AVATAR request.

```javascript
// Sent by Booqable to the iframe
{
  eventName: "SET_AVATAR",
  payload: {
    avatar: {
      id: "user_id",
      color: "#FF5733",
      initials: "UN",
      initialsColor: "#FFFFFF"
    }
  }
}
```

### Implementation example

To the right is an example of a configuration interface.

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>App Configuration</title>
</head>
<body>
  <h1>Configure Your App</h1>
  <form id="settings-form">
    <label for="api_key">API Key</label>
    <input type="password" id="api_key" name="api_key" required>
    <div id="api_key_error" style="display: none; color: red;"></div>

    <button type="submit">Save Configuration</button>
  </form>

  <script>
    // Security: validate message origin. Match the domain or a subdomain of
    // it, never just a string suffix: "evilbooqable.com".endsWith("booqable.com")
    // is true, so a plain endsWith check here would accept a look-alike domain.
    const ALLOWED_DOMAINS = ['booqable.com'];

    function isValidOrigin(origin) {
      try {
        const hostname = new URL(origin).hostname;
        return ALLOWED_DOMAINS.some(domain => hostname === domain || hostname.endsWith('.' + domain));
      } catch {
        return false;
      }
    }

    function showError(fieldId, message) {
      document.getElementById(fieldId + '_error').textContent = message;
      document.getElementById(fieldId + '_error').style.display = 'block';
    }

    function adjustHeight() {
      window.parent.postMessage({
        eventName: 'SET_IFRAME_HEIGHT',
        payload: { height: document.body.scrollHeight }
      }, '*');
    }

    // Listen for messages from Booqable
    window.addEventListener('message', function(event) {
      if (!isValidOrigin(event.origin)) {
        console.warn('Unauthorized origin:', event.origin);
        return;
      }

      if (event.data.eventName === 'SET_AVATAR') {
        console.log('Received avatar:', event.data.payload.avatar);
      }
    });

    // Handle form submission
    document.getElementById('settings-form').addEventListener('submit', function(e) {
      e.preventDefault();

      const apiKey = document.getElementById('api_key').value.trim();
      if (!apiKey) {
        showError('api_key', 'API key is required');
        return;
      }

      // Save configuration (replace with actual API call)
      setTimeout(() => {
        // Notify Booqable of success
        window.parent.postMessage({
          eventName: 'SET_FLASH_MESSAGE',
          payload: {
            type: 'success',
            message: 'Configuration saved'
          }
        }, '*');

        window.parent.postMessage({
          eventName: 'REFRESH_SUBSCRIPTION',
          payload: {}
        }, '*');
      }, 1000);
    });

    // Adjust height on load
    window.addEventListener('load', adjustHeight);
  </script>
</body>
</html>
```
