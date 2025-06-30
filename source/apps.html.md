---
title: Documentation for Booqable 3rd Party Apps

includes:
  - schemas/app-0-1-0.md

search: true

code_clipboard: true

meta:
  - name: description
    content: Documentation for Booqable 3rd Party Apps
---

# Introduction

TODO

# Folder structure

```
app-name/
├── assets/              # Static assets (images, icons, etc.)
├── config/              # Configuration files
│   └── locales/         # Localization files
└── templates/           # HTML or JS templates
```

There are 4 main folders in a Booqable app:

- `assets/` — For static assets like images, icons, etc., used in the app's UI.
- `config/` — Configuration files that control various aspects of the app.
- `config/locales/` — Files containing localized strings used in the app.
- `templates/` — Template files rendered as part of the app's UI.

# `/config/meta.json`

This is the main configuration file for Booqable apps. It follows a JSON schema:

[JSON Schema 0.1.0](/schemas/app-0-1-0.json)

## Minimum viable configuration

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

# `/config/plans.json`

TODO

# `/config/settings.json`

TODO

# Guides

These are pulled from the localization files. Depends on whether certain keys are present or not.

TODO

# Form field translations

Also pulled from the localization files, using implicit keys.

TODO
