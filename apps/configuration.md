# Configuration

Every app's settings page is built one of two ways: declarative content blocks, or an embedded iframe. Plan pricing and locale files are also covered here.

## Content blocks

```jsonc
// booqable.json
{
  "configuration_page": {
    "content": [
      {
        "type": "Form",
        "title": { "localization_key": "form.title" },
        "fields": [
          { "name": "api_key", "type": "text", "label": { "localization_key": "form.api_key.label" }, "required": true }
        ]
      }
    ]
  }
}
```

Content blocks let you declaratively define the content of your settings page. If your app only needs a few simple fields, this is the way to go.

### Block types

- **`Banner`**: a heading, body text, and an optional link (rendered as a button with `display_as_button: true`). A `nature` style: `neutral` (default), `info`, or `warning`.
- **`Form`**: renders a settings form, saved to `App::Subscription#settings_values`. The saved values are also available in your template as variables named after the field, e.g. `const apiKey = '{{ api_key }}'`. The form has a `title` and `preamble` (body text above the fields). Each field has a `name`, `type`, `label`, and optionally `required`, `description`, `placeholder`, `min`/`max`/`step` (for `number`/`range`), or `options`/`multi` (for `select`).
- **`Guide`**: ordered steps, each with a `title`, optional `text`, and optional `image`. Used for step-by-step onboarding.

Field types for `Form`: `text`, `textarea`, `password`, `email`, `phone`, `number`, `range`, `color`, `code`, `contentEditor`, `datepicker`, `select`, `checkbox`, `checkboxGroup`, `radioGroup`, `buttonGroup`.

Any block can be shown conditionally with `if`: `configured` (only once the app is configured), `unconfigured` (only until then). An app counts as configured once all of its required form fields have a value, which is immediately if it has none. If omitted the block is always shown.

## Embedded settings page

`configuration_page.iframe` replaces content blocks with a full embedded page, using the exact same mechanism (manifest shape, auth token, `postMessage` protocol) as [Embedded Pages](https://developers.booqable.com/apps.html#capabilities-embedded-pages). See that section for the details.

## Plans

Plan pricing and store-facing copy are declared directly in `booqable.json`'s `plans` array. See [App Store Listing](https://developers.booqable.com/apps.html#the-basics-app-store-listing) for the field reference. There's no separate plans file.

## Locale files

```jsonc
// hardcoded
{ "title": "Gizmo App" }
```
```jsonc
// localized
{ "title": { "localization_key": "app.title" } }
```

A lot of the strings in `booqable.json` (titles, descriptions, labels, banner text, and so on) accept either a hardcoded value, or a reference to a translated string.

Once you reference a `localization_key`, the actual string lives in a locale file instead: one YAML file per locale (see [App Manifest](https://developers.booqable.com/apps.html#the-basics-app-manifest)).

```yaml
# config/locales/en.yaml
en:
  app:
    title: "Gizmo App"
    description:
      short: "A simple app to manage your gizmos."
      long: "Manage your gizmos, and delight your customers with new ones every month."
  form:
    api_key:
      label: "API Key"
```
```jsonc
// booqable.json
{
  "app_store": {
    "title": { "localization_key": "app.title" }
  }
}
```

There's no fixed schema inside, as long as the root key matches the locale code (e.g. `en`, `pt_BR`). The nested key path below that is entirely up to you: whatever `localization_key` you reference must resolve to a matching key in your locale file. A common convention, matching the schema's own examples, is to namespace by section.

If a locale is missing a key your manifest references, provisioning fails with a validation error.
