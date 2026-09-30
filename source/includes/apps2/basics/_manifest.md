## App Manifest

Every app ships a `booqable.json` manifest at its root — the one file Booqable requires. Alongside it, an app includes whatever templates, assets, and locale files it needs:

```
app-name/
├── booqable.json          # required, at the app's root
├── assets/                # convention
├── config/
│   └── locales/           # required: *.yaml, one per locale
└── templates/             # convention, only if you declare
                            # tracking_script or theme_blocks
```

Files are referenced from `booqable.json` by their exact relative path — organize them however makes sense for your app. Folders like `assets` or `templates` are common conventions, not requirements. The one structural rule besides `booqable.json` itself: locale files live under `config/locales/`, named `<locale>.yaml` (e.g. `en.yaml`, `pt_BR.yaml`).

`booqable.json` is validated against a versioned JSON Schema, declared by its own `$schema` field. The schema evolves — new fields are additive, existing ones aren't removed — see [Reference](#reference) for the exact current shape.

Settings UIs, plan pricing, and locale file content are covered in depth in [Configuration](#configuration).
