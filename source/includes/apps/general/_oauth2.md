## OAuth Authentication

Booqable apps can use OAuth authentication to securely connect with third-party services. This allows apps to access external APIs on behalf of the user without requiring them to share their credentials directly.

### How OAuth works in Booqable apps

When an app requires OAuth authentication, Booqable handles the OAuth flow on behalf of the app. The process works as follows:

1. The user clicks to connect their account with the third-party service.
2. Booqable redirects the user to the OAuth provider's authorization page.
3. The user grants permission to the app on the OAuth provider's site.
4. The OAuth provider redirects back to Booqable with an authorization code.
5. Booqable exchanges the authorization code for an access token.
6. The app receives the access token and can make API calls to the third-party service.

### Configuring OAuth in your app

To enable OAuth authentication for your app, you need to [configure the `oauth` object in your app's `meta.json`](#reference-oauthsettings) file.

#### Required OAuth configuration

```json
{
  "oauth": {
    "redirect_url": "/oauth/callback",
    "scopes": ["full_access"]
  }
}
```

The `oauth` object requires two properties:

- **`redirect_url`** (required): The URL path where the OAuth provider will redirect after authorization. This should be a relative path that will be prefixed with your app's base URL.
- **`scopes`** (required): An array of OAuth scopes that your app requires. These define what permissions your app needs from the third-party service. Currently the only scope available is `full_access`.

#### Optional OAuth configuration

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

For some OAuth providers, you may need to include additional configuration:

- **`client_id`** (optional): The OAuth client ID provided by the third-party service. If not specified, Booqable will use a default client ID.
- **`client_secret`** (optional): The OAuth client secret provided by the third-party service. If not specified, Booqable will use a default client secret.

### OAuth flow in the user interface

When a user installs an app that requires OAuth authentication, they will see an additional step in the installation process:

1. **App installation** - User installs the app from the app store.
2. **OAuth authorization** - User is redirected to the OAuth provider to grant permissions.
3. **Configuration** - User configures any additional app settings.
4. **App ready** - The app is now connected and ready to use.
