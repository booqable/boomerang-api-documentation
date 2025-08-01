## Configuration

Booqable apps are simply a folder with a few files in it. Some files are configuration files, some are templates, and some are static assets.

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



### `/config/meta.json`

This is the main configuration file for the app. It defines the app's metadata, capabilities, and plans. It is required for every app and is validated against a JSON schema.

Latest: [0.1.0 JSON Schema](/schemas/app-0-1-0.json) / [0.1.0 Reference](#reference)


#### Capabilities

In your app's `meta.json` file, you can define the capabilities of your app. These are the main tasks your app can perform inside Booqable, such as:

* **Tracking scripts:** Let users add analytics scripts to their website to track user behavior.
* **Theme blocks:** Allow users to install new content blocks in their website.
* **Delivery carriers:** Define new carriers that can be used to ship orders.
* **Payment options:** Define new payment methods that can be used to pay for orders.

For more information see the [Capabilities section](/apps.html#capabilities).



### `/config/plans.json`

This file is where you define the plans your app offers. Each plan has a title, description, and a list of features presented to the user when they are installing the app.

TODO



### Locale files

Locale files contain the localized strings used throughout the Booqable UI such as the app title and descriptions as well forms for user settings and post-installation guides.

They must be in YAML format and are stored in the `locales` folder. The file name must be the locale language code, such as `en.yaml` or `pt-BR.yaml`. The top-level of the file should contain only a single key which matches the locale's code, so `en` or `pt_BR`.


#### App metadata

```yaml
en:
  title: "Gizmo App"
  description:
    short: "A simple app to manage your gizmos."
    long: "This app allows you to manage your gizmos. You can add, edit, and delete gizmos. Delight your customers with new gizmos every month!"
```

The app's title and descriptions are configurable through the locale files. The short description is mainly used in the app store listings page, while the long description is used in the app store detail page.


#### App Plans

```yaml
en:
  plans:
    free:
      title: Gizmo Free
      description: A free plan to get you started with the Gizmo App.
      features:
      - 10 gizmos
      - 100 notifications per month
      - 100 API requests per month
    pro:
      title: Gizmo Pro
      description: 10x the fun with the Gizmo Pro plan.
      features:
      - 100 gizmos
      - 1000 notifications per month
      - 1000 API requests per month
```

The title, description and features of each plan are configurable through the locale files. These are shown to users in the app's store detail page and as part of the [installation flow](#how-apps-work-app-store). Each plan must have a unique key under the `<locale>.plans` key, such as `free`, `basic`, `pro`, etc.


#### Forms

```yaml
en:
  form:
    title: Configure your Weglot widget
    description:
      - To get started, enter your Weglot API key below. If you don't have an API key
        yet, you can get one by creating an account on the Weglot website.
    api_key:
      label: Api Key
    dropdown_direction:
      label: Dropdown Direction
```

Apps can define [global settings](#how-apps-work-user-settings) that Booqable renders as a form where users can provide information to the app. The forms are shown to users after installation or when they visit the app's settings page. You can provide localized strings for the form's title, description and fields.

If you're [using theme blocks](#capabilities-theme-blocks) and those blocks have their own settings, you can also define localized labels for them here.


#### Guides

You can configure your app to show a post-installation guide to users. This is a good way to help users get started with your app or ask for additional information required to operate the app, such as API keys.

```yaml
en:
  unconfigured:
    description: |
      To get started, you need to configure your Weglot widget.
      You can do this by entering your Weglot API key below.
      If you don't have an API key yet, you can get one by creating an account on the Weglot website.
    link:
      text: Weglot dashboard
      url: 'https://dashboard.weglot.com/register?fp_ref=booqable'
```

If you require some global settings to be present you show a simple instruction box using the `unconfigured.description` and `unconfigured.link` keys.

<figure>
  <img src="/images/apps/unconfigured-app-instruction-box.png" alt="Example of an instruction box shown to users when the app is not yet configured" style="max-width: 100%;">
  <figcaption>
    Example of the instruction box shown to users when required global settings are missing.
  </figcaption>
</figure>

```yaml
en:
  unconfigured:
    guide:
      - title: 1. Create a Weglot account
        description: Go to the Weglot website and sign up for a new account.
        asset: step_1.png
      - title: 2. Select Booqable as your website technology
        description: In the setup process, choose "Booqable" when asked for your website technology.
        asset: step_2.png
      - title: 3. Set the original language and add translated languages
        description: Set "English" as your original language and add any additional languages you want to offer to your visitors.
        asset: step_3.png
      - title: 4. Add your website details and connect Weglot
        description: In the "Add your website details" section, click on "Connect Weglot to your website without it."
        asset: step_4.png
      - title: 5. Copy the API key from the Weglot snippet
        description: Copy the API key provided in the Weglot snippet. You will need this to configure the app in Booqable.
        asset: step_5.png
```

Additionaly, you can define a step by step guide for users to follow after installation. This is a good way to instruct users on how to get required API keys from third-party services, for example. The guide must be specified under the `unconfigured.guide` key and consists of a list of steps, each with a title, description and an image.

<figure>
  <img src="/images/apps/unconfigured-app-guide.png" alt="Example of a step by step guide" style="max-width: 100%;">
  <figcaption>
    Example of a step by step guide.
  </figcaption>
</figure>

