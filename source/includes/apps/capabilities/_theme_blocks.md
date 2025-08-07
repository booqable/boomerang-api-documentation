## Theme Blocks

Theme blocks allow your app to inject custom HTML content into the customer websites. These blocks can be added to different sections of the website (header, footer, or body sections) and provide a way to extend the website's functionality with custom widgets, forms, or other integrations.


### Configuration

```json
{
  "ui_extension": {
    "themes": {
      "blocks": [
        {
          "name": "Newsletter Signup",
          "template": "templates/newsletter-signup.liquid",
          "allowed_sections": ["app"],
          "settings": {
            "title": {
              "type": "text",
              "label": "Title",
              "default": "Subscribe to our newsletter"
            },
            "placeholder": {
              "type": "text",
              "label": "Email placeholder",
              "default": "Enter your email"
            }
          }
        }
      ]
    }
  }
}
```

To enable theme blocks in your app you need to configure the [`themes`](#reference-themesettings) settings in your `meta.json` file. The `blocks` property specifies an array of theme blocks that can be added to the customer's website. Each theme block must specify a [Liquid](https://shopify.github.io/liquid/) template file that will be rendered as HTML in the customer's website. You can constrain which sections of the customer's website the block is meant to be rendered in — header, footer, or body (app) — and optionally specify a set of user-configurable settings that will be available during rendering.


### Block configuration

Each [`theme block`](#reference-themeblocksettings) requires the following configuration:

- **`name`** - Display name shown to users in the theme editor.
- **`template`** - Path to the Liquid template file for the block.
- **`allowed_sections`** - Array of sections where the block can be placed: `header`, `footer`, or `app` (body).


### Block settings

```json
{
  "settings": {
    "title": {
      "type": "text",
      "label": "Title",
      "default": "Default Title"
    },
    "_display_settings_": {
      "type": "header",
      "content": "Display Settings"
    },
    "height": {
      "type": "number",
      "label": "Height",
      "default": "400"
    },
    "position": {
      "type": "select",
      "label": "Position",
      "options": [
        { "value": "left", "label": "Left" },
        { "value": "center", "label": "Center" },
        { "value": "right", "label": "Right" }
      ]
    }
  }
}
```

Theme blocks can have [configurable settings](#reference-themeblocksetting) that users can modify via Booqable's website builder. See the example on the right.

**Available setting types:**

- **`text`** - Single line text input.
- **`number`** - Numeric input.
- **`select`** - Dropdown with predefined options.
- **`header`** - Section divider in the settings panel.

<figure>
  <img src="/images/apps/theme-block-settings-example.png" alt="Theme block settings example" style="max-width: 100%; max-height: 400px;">
  <figcaption>
    Example of a theme block settings as viewed in the website builder.
  </figcaption>
</figure>



### Global settings integration

```jsonc
// meta.json
{
  // ...
  "global_settings": {
    "api_key": {
      "type": "text",
      "required": true
    },
    "domain": {
      "type": "text",
      "required": true
    }
  }
}
```

```liquid
<!-- templates/widget.liquid -->
<div>
  <script>
    const apiKey = '{{ api_key }}'
    const domain = '{{ domain }}'
    // Use global settings in your template
  </script>
</div>
```

You can also access your app's global settings in the theme block templates using Liquid syntax. When rendering templates all global settings defined in your `meta.json` are available as template variables.


### App ID

Each theme block has access to a unique `app_id` attribute during rendering. This `app_id` is guaranteed to be unique for each block instance. It's often useful to add CSS styles scoped to the block's element by using the `app_id` as a selector.

```liquid
<div id="{{ app_id }}">
  <style>
    #{{ app_id }} .widget {
      /* Your styles here */
    }
  </style>

  <div class="widget">
    <!-- Your widget content here -->
  </div>
</div>
```


### User framework

Inside your theme block templates you can write JavaScript code that uses the Booqable User Framework to load custom scripts and respond to events like `viewProduct`, `addToCart` and more. See the [User framework documentation](#how-apps-work-user-framework) for more details.


### Consent management

If your theme block installs cookies in the user's browser (for example, for analytics, marketing, or personalization), you **must** integrate with Booqable's consent management framework. This is done via the User Framework by using [`Booqable.registerApp`](#how-apps-work-user-framework-app-registration).

When you register your app using `registerApp`, Booqable will automatically manage when your theme blocks are allowed to set cookies, based on the user's consent preferences.


### Example implementation

```jsonc
// meta.json
{
  // ...
  "ui_extension": {
    "themes": {
      "blocks": [
        {
          "name": "Newsletter Signup",
          "template": "templates/newsletter-signup.liquid",
          "allowed_sections": ["app"],
          "settings": {
            "title": {
              "type": "text",
              "label": "Title",
              "default": "Subscribe to our newsletter"
            },
            "button_text": {
              "type": "text",
              "label": "Button text",
              "default": "Subscribe"
            },
            "_desktop_settings_header_": {
              "type": "header",
              "content": "Desktop Settings"
            },
            "height_desktop": {
              "type": "number",
              "label": "Height",
              "default": "500"
            },
            "_mobile_settings_header_": {
              "type": "header",
              "content": "Mobile Settings"
            },
            "height_mobile": {
              "type": "number",
              "label": "Height",
              "default": "300"
            }
          }
        }
      ]
    }
  }
}
```

```liquid
<!-- templates/newsletter-signup.liquid -->
<div id="{{ app_id }}">
  <style>
    #{{ app_id }} {
      text-align: left;
      user-select: none;
    }

    #{{ app_id }} .newsletter-form {
      width: 100%;
      border: 0;
    }

    @media (max-width: 650px) {
      #{{ app_id }} .newsletter-form {
        height: {{ height_mobile }}px;
      }
    }
  </style>

  <script>
    window.addEventListener('load', function() {
      Booqable.registerApp('marketing', {
        name: "Newsletter Signup",
        domain: "newsletter.example.com",
        description: "Collect email addresses for your newsletter. <a href=\"https://example.com/privacy\" target=\"_blank\">Learn more</a>",

        onConsent: function() {
          const template = document.querySelector('#{{ app_id }} template')
          template.insertAdjacentElement('afterend', template.content.cloneNode(true).firstElementChild)
        }
      })
    })
  </script>

  <template>
    {% if title %}
      <div class="newsletter-widget">
        <h3>{{ title }}</h3>
        <iframe
          src="https://newsletter.example.com/form?api_key={{ api_key }}"
          height="{{ height_desktop }}"
          allowtransparency="true"
          class="newsletter-form">
        </iframe>
      </div>
    {% endif %}
  </template>
</div>
```

The example on the right shows a newsletter signup widget that:

- Uses global settings for the API key
- Has configurable title and button text
- Renders HTML content only after consent
- Supports responsive design
- Scopes CSS styles to the block using `app_id`
