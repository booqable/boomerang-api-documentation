## OAuth Authentication

Booqable apps can use OAuth authentication to securely connect with [Booqable's API](/v4.html) on behalf of the user without requiring them to share their credentials directly.

### How OAuth works in Booqable apps

When an app has OAuth authentication enabled, Booqable handles the OAuth flow on behalf of the app. The process works as follows:

1. The user clicks to install the app.
2. Booqable asks the user to grant the app permissions to use Booqable on user's behalf.
3. If the access is granted, Booqable redirects to app's `redirect_url` with the authorization code.
4. The app exchanges the authorization code for an access and refresh tokens and can then make API calls to Booqable's API.

### Configuring OAuth in your app

```json
{
  "oauth": {
    "client_id": "your-client-id.apps.service.com",
    "client_secret": "your-client-secret",
    "redirect_url": "/oauth/callback",
    "scopes": ["full_access"]
  }
}
```

To enable OAuth authentication for your app, you need to [configure the `oauth` object in your app's `meta.json`](#reference-oauthsettings) file.

- **`client_id`**: An OAuth client ID that identifies your app to Booqable's API endpoints. Must follow the format `{32-random-characters}.public.apps.{app_identifier}`.
- **`client_secret`**: An OAuth client secret that Booqable uses to authenticate your app. Must follow the format `{64-random-characters}.private.apps.{app_identifier}`.
- **`redirect_url`**: The URL path where Booqable will redirect to after authorization. This should be a relative path that will be prefixed with your app's base URL.
- **`scopes`**: An array of OAuth scopes that your app requires. These define what permissions your app needs from Booqable's API. Currently the only scope available is `full_access`.

### OAuth flow in the user interface

When a user installs an app that has OAuth authentication enabled, they will see an additional step in the installation process:

1. **App installation** - User installs the app from the app store.
2. **OAuth authorization** - User is redirected to the app to grant permissions.
3. **Configuration** - User configures any additional app settings.
4. **App ready** - The app is now connected and ready to use.
