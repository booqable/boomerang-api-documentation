## OAuth

Booqable apps can use OAuth authentication to securely connect with [Booqable's API](/v4.html) on behalf of the user, without requiring them to share their credentials directly.

### How OAuth works in Booqable apps

When an app has OAuth authentication enabled, Booqable handles the OAuth flow on behalf of the app:

1. The user clicks to install the app.
2. Booqable shows the user an in-app dialog listing the permissions (scopes) your app is requesting, and asks them to grant access.
3. If access is granted, Booqable redirects the user's browser to your app's `redirect_url` with an authorization code.
4. Your app exchanges the authorization code for an access and refresh token, and can then make API calls to Booqable's API.

### Configuring OAuth in your app

```jsonc
// booqable.json
{
  "base_url": "https://my-app.com",
  "oauth": {
    "redirect_url": "/oauth/callback",
    "scopes": ["full_access"]
  }
}
```

To enable OAuth for your app, configure the [`oauth` object](#reference-oauthconfig) in your `booqable.json` file.

- **`redirect_url`**: the path Booqable redirects to after authorization. A relative path, prefixed with your app's `base_url`.
- **`scopes`**: the OAuth scopes your app requests. Currently the only scope available is `full_access`.
