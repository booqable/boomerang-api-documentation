## Theme Blocks

Theme blocks let your app add custom content (widgets, forms, embeds) that merchants place into their website via the theme editor.

```jsonc
// booqable.json
{
  "theme_blocks": [
    {
      "name": "Newsletter Signup",
      "template": { "asset": "templates/newsletter-signup.liquid" },
      "allowed_sections": ["app"],
      "settings": {
        "title": { "type": "text", "label": "Title", "default": "Subscribe to our newsletter" }
      }
    }
  ]
}
```

- **`name`**: display name shown in the theme editor.
- **`template`**: a Liquid template, rendered as HTML wherever the merchant places the block.
- **`allowed_sections`**: where the block can be placed. `header`, `footer`, or `app` (body sections).
- **`cookies_required`**: flags in the theme editor that this block won't render until the visitor has given cookie consent.
- **`settings_iframe_url`**: embeds a full iframe in the website editor's sidebar for this block's settings, instead of the declarative `settings` below.
- **`settings`**: declarative sidebar controls, keyed by name (see below).

### Settings types

- **`text`** / **`textarea`**: single- or multi-line text input.
- **`number`**: numeric input (`min`/`max`/`step`).
- **`color`**: color picker.
- **`checkbox`**: boolean toggle.
- **`header`**: a section-divider label in the sidebar (uses `content`).
- **`divider`**: a plain visual divider, no label.

Each setting's value is available in your template as a Liquid variable named after the setting key (e.g. a `height` setting renders as `{{ height }}`).

Merchant-entered *global* values (like an API key shared across every block instance) come from a `configuration_page` form field, not a manifest key — see [Configuration](#configuration). Whatever the merchant enters is available in your template as a variable named after the field, e.g. `const apiKey = '{{ api_key }}'`.

If your block sets cookies, register it with `Booqable.registerApp` (see [User Framework](#capabilities-user-framework)) so Booqable can gate it behind visitor consent. Same real caveat as tracking scripts: this only gates anything if the merchant has enabled the cookie notice in their theme. If they haven't, `onConsent` fires automatically with no visitor interaction. Design your integration to tolerate either case.

Each block instance gets a unique `app_id` variable during rendering, useful for scoping CSS or JS to that specific instance:

```liquid
<div id="{{ app_id }}">
  <style>#{{ app_id }} .widget { /* ... */ }</style>
</div>
```
