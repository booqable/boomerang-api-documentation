## The Manifest & Provisioning

Every app ships a `booqable.json` manifest at its root — the one file Booqable requires. Alongside it, an app includes whatever templates, assets, and locale files it needs:

```
app-name/
├── booqable.json          # required, at the app's root
├── assets/
├── locales/
│   └── en.yaml
└── templates/
```

Files are referenced from `booqable.json` by their exact relative path — everything except `booqable.json` itself is convention, not a requirement. `assets/`, `locales/`, and `templates/` above are common, but organize them however makes sense for your app. The one rule that always applies: locale content is one YAML file per locale (e.g. `en.yaml`, `pt_BR.yaml`).

`booqable.json` is validated against a versioned JSON Schema, declared by its own `$schema` field. The schema evolves — new fields are additive, existing ones aren't removed — see [Reference](#reference) for the exact current shape.

Settings UIs, plan pricing, and locale file content are covered in depth in [Configuration](#configuration).
