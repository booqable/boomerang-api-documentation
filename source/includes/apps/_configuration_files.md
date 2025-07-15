# Configuration files

## `/config/meta.json`

This is the main configuration file for Booqable apps. It follows a JSON schema:

[JSON Schema 0.1.0](/schemas/app-0-1-0.json)

### Minimum viable configuration

```json
{
  "$schema": "https://developers.booqable.com/schemas/app-0-1-0.json#",
  "id": "my_app",
  "name": "My App",
  "type": "pixel",
  "category": "tracking",
  "image": "https://acme-files.s3.amazonaws.com/app-my-app-visual.png",
  "icon": "https://acme-files.s3.amazonaws.com/app-my-app-logo.png",
  "author": "ACME Corp.",
  "version": "1.0.0",
  "support": {
    "email": "support@acme.example.com",
    "website": "https://help.acme.example.com"
  }
}
```

To the right is a minimum viable configuration for a Booqable app. You can copy this configuration as a starting point and adjust it to your needs.

## `/config/plans.json`

TODO

## `/config/settings.json`

TODO
