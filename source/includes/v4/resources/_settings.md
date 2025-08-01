# Settings

Settings are configured globally for a company account. They are divided in the following sections:

#### Currency

Information on how to display and handle the currency.

Name | Description
-- | --
`name` | **String** `readonly`<br>Currency code
`decimal` | **String** `readonly`<br>Decimal separator
`thousand` | **String** `readonly`<br>Thousand separator
`symbol` | **String** `readonly`<br>Currency symbol
`precision` | **String** `readonly`<br>Precision
`format` | **String** `readonly`<br>The format

#### Defaults

Defaults derived from other resources.

Name | Description
-- | --
`timezone` | **String** `readonly`<br>The default timezone (managed on the company resource)
`timezone_offset` | **Integer** `readonly`<br>The UTC offset of the default timezone, in minutes
`tax_category_id` | **Uuid** `readonly`<br>ID the default tax category
`tax_region_id` | **Uuid** `readonly`<br>ID the default tax region

#### Pricing

Configuration on how to handle and display pricing

Name | Description
-- | --
`enabled` | **Boolean**<br>Whether pricing is enabled
`tax_strategy` | **Uuid**<br>How taxes should be calculated, one of `exclusive`, `inclusive`
`deposit_type` | **String**<br>Default deposit type (applied to orders if customer deposit type is `default`, one of `none`, `percentage_total`, `percentage`, `fixed`)
`deposit_value` | **Integer**<br>Default deposit value (applied to orders if customer deposit type is `default`)
`currency_format` | **String**<br>Currency format
`currency_position` | **String**<br>Where to place the currency symbol, one of `left`, `right`

#### Dates

Information on how to display dates. The settings below should be used (and combined)
to select the format string for the date library being used.

Name | Description
-- | --
`format` | **String**<br>How dates should be formatted. Supported formats are `DD-MM-YYYY`, `MM-DD-YYYY` and `YYYY-MM-DD`.
`use_am_pm` | **Boolean**<br>Whether to use 24h clock or AM/PM
`first_day_of_week` | **Integer**<br>Which day to display as first day of the week (`0` for Sunday)

#### Orders

Configuration for [orders](#orders) (these settings also apply to the online store)

Name | Description
-- | --
`use_times` | **Boolean**<br>Whether time selection is enabled, if not, full days are always planned and calculated
`start_type` | **String**<br>Behavior of default start time, one of `fixed`, `relative`
`start_relative_offset` | **Integer**<br>Offset in seconds from now, used when `start_type` is `relative`
`start_fixed_at` | **String**<br>Fixed time of day, e.g. `14:00`, used when `start_type` is `fixed`
`stop_type` | **String**<br>Behavior of default stop time, one of `fixed`, `relative`
`stop_relative_offset` | **Integer**<br>Offset in seconds from now, used when `stop_type` is `relative`
`stop_fixed_at` | **String**<br>Fixed time of day, e.g. `14:00`, used when `stop_type` is `fixed`

#### Security

Global security settings

Name | Description
-- | --
`sso_forced` | **Boolean**<br>Whether to force SSO
`iprestrictions_enabled` | **Boolean**<br>Whether IP restrictions are enabled

#### Address

Settings on how to display addresses

Name | Description
-- | --
`fields_order` | **Array**<br>Order of how the fields are displayed, e.g. `["zipcode", "city", "region"]`

#### Store

Settings for the online store

Name | Description
-- | --
`enabled` | **Boolean**<br>Whether to accept online reservations
`public` | **Boolean**<br>Whether to hosted online store is public
`send_order_confirmation` | **Boolean**<br>Whether to send order confirmations automatically after checkout
`brand_color` | **String**<br>Brand color as HEX code
`use_availability` | **Boolean**<br>Whether to show availability and block checkouts when items are unavailable
`use_prices` | **Boolean**<br>Whether to show prices
`display_price` | **String**<br>One of `period` (label will be populated with actual period), `charge` (label will be populated with the name of the price tile), `cheapest` (show "starting from" as label)
`show_powered_by` | **Boolean**<br>Whether to display "Powered by" in the cart
`use_order_lag_time` | **Boolean**<br>Whether to prevent last-minute reservations
`order_lag_time_interval` | **String**<br>One of `minutes`, `hours`, `days`, `weeks`, `months`
`order_lag_time_value` | **Integer**<br>The value applied for `order_lag_time_interval`
`payment_strategy` | **String**<br>One of `none` (no payment required at checkout), `full` (full payment required at checkout), `partial` (partial payment required at checkout)
`payment_strategy_value` | **Integer**<br>Percentage to be paid at checkout (for payment_strategy `partial`)
`payment_deposit` | **Boolean**<br>Whether deposit should be paid during checkout
`payment_methods` | **Array**<br>List of enabled payment methods, any of `ideal`, `bancontact`, `eps`, `alipay`, `p24`, `creditcard`, `paypal`
`use_toc` | **Boolean**<br>Whether the agreement should be accepted during checkout
`toc_label` | **String**<br>The label of the agreement checkbox
`toc_content` | **String**<br>The contents of the actual agreement
`use_business_hours` | **Boolean**<br>Whether to take opening hours into account while selecting a period (see [operating rules](#operating-rules) for more information)
`use_away_mode` | **Boolean**<br>Whether away mode is enabled (see [operating rules](#operating-rules) for more information)
`period_type` | **String**<br>How the period picker is setup, one of `freely` (free selection), `timeslot_duration` (select a day, time and duration), `timeslot_fixed` (fixed timeslots for days). See [operating rules](#operating-rules) for more information
`use_times` | **Boolean**<br>Whether to use time selection in the online store
`use_coupons_in_checkout` | **Boolean**<br>Whether supplying coupons during checkout is enabled
`time_increment` | **Integer**<br>Time increments for time selection (e.g. `15`, `30`, `60`)
`show_product_availability` | **Boolean**<br>Whether to show detailed product availability for products
`hide_product_availability_quantities` | **Boolean**<br>Whether hide quantities in the product availability calendar
`show_cart_availability` | **Boolean**<br>Whether to show on which dates the products in a cart are available during the period selection
`website` | **String**<br>Website to use to redirect back to from the checkout
`checkout_scripts` | **String**<br>Custom scripts to execute during checkout
`google_analytics_id` | **String**<br>Google analytics ID to use for tracking
`facebook_pixel_id` | **String**<br>Facebook pixel ID to use for tracking
`facebook_domain_verification` | **String**<br>Content for the `facebook-domain-verification` meta tag

#### User

Settings that apply to [user](#users) accounts

Name | Description
-- | --
`auth_enabled` | **Boolean**<br>Whether user accounts are enabled
`allow_signup` | **Boolean**<br>Whether signup during checkout is allowed
`allow_guest_checkout` | **Boolean**<br>Whether to allow guest checkouts
`require_verification` | **Boolean**<br>Whether email addresses need to be verified

#### Documents

Settings that apply to all [document](#documents) types

Name | Description
-- | --
`show_tax_column` | **Boolean**<br>Whether to show the tax column on lines
`css` | **String**<br>Custom css used for documents
`scss` | **String**<br>Custom scss used for documents
`scope_numbering_to_prefix` | **Boolean**<br>Whether to scope numbering to prefix, e.g. `1980-1`, `1980-2`, `1981-1` or `1980-1`, `1980-2`, `1981-3`
`page_size` | **String**<br>The page size to use for pdf downloads, one of `a4`, `letter`

#### Invoices

Settings that apply to invoices

Name | Description
-- | --
`footer` | **String**<br>HTML formatted footer to display on invoices
`show_product_photos` | **Boolean**<br>Whether to show product photos
`show_stock_identifiers` | **Boolean**<br>Whether to show identifiers of the stock items that are booked
`show_free_lines` | **Boolean**<br>Whether to display lines that don't have price
`hide_section_lines` | **Boolean**<br>Whether to hide lines within a section, if enabled to total price of all lines in a section is summed and displayed next to the section
`prefix` | **String**<br>Prefix to use for document numbering, e.g. `{{year}}` or `{{customer_number}}`, combinations are also possible `{{year}}-{{order_number}}`
`default_due_period` | **Integer**<br>A period of time during which invoices can await payment, in seconds

#### Quotes

Settings that apply to quotes

Name | Description
-- | --
`footer` | **String**<br>HTML formatted footer to display on quotes
`body` | **String**<br>HTML formatted body to display on quotes
`show_product_photos` | **Boolean**<br>Whether to show product photos
`show_stock_identifiers` | **Boolean**<br>Whether to show identifiers of the stock items that are booked
`show_free_lines` | **Boolean**<br>Whether to display lines that don't have price
`hide_section_lines` | **Boolean**<br>Whether to hide lines within a section, if enabled to total price of all lines in a section is summed and displayed next to the section
`prefix` | **String**<br>Prefix to use for document numbering, e.g. `{{year}}` or `{{customer_number}}`, combinations are also possible `{{year}}-{{order_number}}`

#### Contracts

Settings that apply to contracts

Name | Description
-- | --
`footer` | **String**<br>HTML formatted footer to display on contracts
`body` | **String**<br>HTML formatted body to display on contracts
`show_product_photos` | **Boolean**<br>Whether to show product photos
`show_stock_identifiers` | **Boolean**<br>Whether to show identifiers of the stock items that are booked
`show_free_lines` | **Boolean**<br>Whether to display lines that don't have price
`hide_section_lines` | **Boolean**<br>Whether to hide lines within a section, if enabled to total price of all lines in a section is summed and displayed next to the section
`prefix` | **String**<br>Prefix to use for document numbering, e.g. `{{year}}` or `{{customer_number}}`, combinations are also possible `{{year}}-{{order_number}}`

#### Labels

Customization settings for labels

Name | Description
-- | --
`customer` | **String**<br>What to call a customer (one of `customer`, `client`, `student``)
`order` | **String**<br>What to call an order (one of `order`, `booking`, `project``)
`quote` | **String**<br>What to call a quote (one of `quote`, `proposal`)
`contract` | **String**<br>What to call a contract (one of `contract`, `waiver`)
`packing_slip` | **String**<br>What to call a packing slip (one of `packing_slip`, `pull_sheet`)

#### Labels

Settings for emails

Name | Description
-- | --
`bcc` | **String**<br>BCC addresses to use for all emails

## Fields

 Name | Description
-- | --
`address` | **hash** <br>Settings on how to display addresses.
`contracts` | **hash** <br>Settings that apply to contracts.
`currency` | **hash** `readonly`<br>Information on how to display and handle the currency (managed on Company resource).
`dashboard` | **hash** `extra`<br>Dashboard settings (Used internally by Booqable).
`dates` | **hash** <br>Information on how to display dates.
`defaults` | **hash** `readonly`<br>Defaults derived from other resources.
`deliveries` | **hash** <br>Settings for deliveries.
`documents` | **hash** <br>Settings that apply to all [document](#documents) types.
`emails` | **hash** <br>Settings for emails.
`feature_enrollments` | **hash** `extra`<br>Feature enrollments settings (Used internally by Booqable).
`id` | **uuid** <br>Primary key.
`instructions` | **hash** `extra`<br>Settings for in app instructions (Used internally by Booqable).
`invoices` | **hash** <br>Settings that apply to invoices.
`labels` | **hash** <br>Customization settings for labels.
`onboarding` | **hash** `extra`<br>Onboarding settings (Used internally by Booqable).
`orders` | **hash** <br>Configuration for [orders](#orders) (these settings also apply to the online store).
`pricing` | **hash** <br>Configuration on how to handle and display pricing.
`quotes` | **hash** <br>Settings that apply to quotes.
`security` | **hash** <br>Global security settings.
`setup_checklist` | **hash** `extra`<br>Setup checklist settings (Used internally by Booqable).
`store` | **hash** <br>Settings for the online store.
`tracking` | **hash** `extra`<br>Tracking settings (Used internally by Booqable).
`user` | **hash** <br>Settings that apply to [user](#users) accounts.


## Fetch settings


> How to fetch settings:

```shell
  curl --get 'https://example.booqable.com/api/4/settings/current'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "7ed00443-a502-4b1a-88ae-d8b726190682",
      "type": "settings",
      "attributes": {
        "updated_at": "2017-11-19T10:18:02.000000+00:00",
        "currency": {
          "name": "USD",
          "decimal": ".",
          "thousand": ",",
          "symbol": "$",
          "precision": 2,
          "format": "%s%v"
        },
        "defaults": {
          "timezone": "UTC",
          "timezone_offset": 0,
          "tax_category_id": "7d25ac45-0c83-4217-8fbd-76ec66f71228",
          "tax_region_id": "7ab2a037-7829-4476-8a65-17b89e83a6f5",
          "shop_start_location_id": null,
          "shop_stop_location_id": null
        },
        "pricing": {
          "enabled": true,
          "tax_strategy": "exclusive",
          "deposit_type": "percentage",
          "deposit_value": 100,
          "currency_format": "symbol",
          "currency_position": "left"
        },
        "dates": {
          "format": "DD-MM-YYYY",
          "use_am_pm": false,
          "first_day_of_week": 0
        },
        "orders": {
          "use_times": true,
          "start_type": "fixed",
          "start_relative_offset": 0,
          "start_fixed_at": "09:00",
          "stop_type": "fixed",
          "stop_relative_offset": 48,
          "stop_fixed_at": "15:00"
        },
        "security": {
          "sso_forced": false,
          "2fa_forced": false,
          "iprestrictions_enabled": false
        },
        "address": {
          "fields_order": [
            "zipcode",
            "city",
            "region"
          ]
        },
        "store": {
          "enabled": true,
          "public": true,
          "send_order_confirmation": true,
          "brand_color": "#136DEB",
          "use_availability": true,
          "use_prices": true,
          "display_price": "period",
          "show_powered_by": true,
          "use_order_lag_time": false,
          "order_lag_time_value": null,
          "order_lag_time_interval": null,
          "behaviors.add_button": "show_cart",
          "behaviors.location_picker": "start_stop",
          "payment_strategy": "none",
          "payment_strategy_value": 30,
          "payment_deposit": false,
          "payment_methods": [],
          "security_deposit_explanation": "",
          "pay_later": false,
          "pay_later_title": "Pay later",
          "pay_later_terms": "",
          "use_toc": false,
          "toc_label": "",
          "toc_content": "",
          "use_business_hours": false,
          "use_away_mode": false,
          "period_type": "freely",
          "use_times": true,
          "use_coupons_in_checkout": true,
          "time_increment": 60,
          "show_product_availability": true,
          "hide_product_availability_quantities": false,
          "show_cart_availability": true,
          "require_delivery_address_when_selecting_rental_period": true,
          "delivery_country_names": [],
          "website": null,
          "checkout_scripts": "",
          "google_analytics_id": null,
          "google_anlaytics_options": "{}",
          "facebook_pixel_id": null,
          "facebook_domain_verification": null
        },
        "user": {
          "auth_enabled": false,
          "allow_signup": true,
          "allow_guest_checkout": true,
          "require_verification": true
        },
        "documents": {
          "show_tax_column": true,
          "css": "",
          "scss": "",
          "scope_numbering_to_prefix": false,
          "page_size": "a4"
        },
        "invoices": {
          "footer": "",
          "show_product_photos": true,
          "show_stock_identifiers": false,
          "show_free_lines": true,
          "hide_section_lines": false,
          "prefix": "{{year}}-{{order_number}}",
          "default_due_period": null
        },
        "quotes": {
          "footer": "",
          "body": "",
          "show_product_photos": true,
          "show_stock_identifiers": false,
          "show_free_lines": true,
          "hide_section_lines": false,
          "prefix": "{{year}}-{{customer_number}}"
        },
        "contracts": {
          "footer": "",
          "body": "",
          "show_product_photos": true,
          "show_stock_identifiers": false,
          "show_free_lines": true,
          "hide_section_lines": false,
          "prefix": null
        },
        "labels": {
          "customer": "customer",
          "order": "order",
          "quote": "quote",
          "contract": "contract",
          "packing_slip": "packing_slip",
          "start": "pick_up",
          "stop": "return"
        },
        "emails": {
          "header_content": "{{#company.logo_url}}\n![{{company.name}}]({{company.logo_url}} =x80)\n{{/company.logo_url}}\n{{^company.logo_url}}\n# {{company.name}}\n{{/company.logo_url}}\n",
          "footer_content": "### {{company.name}}\n{{#company.email}}[{{company.email}}](mailto:{{company.email}}){{/company.email}}\n{{#company.phone}}[{{company.phone}}](tel:{{company.phone}}){{/company.phone}}\n{{#company.website}}[{{company.website}}]({{company.website}}){{/company.website}}\n{{#company.financialLine1}}{{company.financialLine1}}{{/company.financialLine1}}\n{{#company.financialLine2}}{{company.financialLine2}}{{/company.financialLine2}}\n{{company.address}}\n"
        },
        "deliveries": {
          "distance_unit": "metric"
        }
      }
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/settings/current`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[settings]=dashboard,setup_checklist,onboarding`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[settings]=currency,defaults,pricing`


### Includes

This request does not accept any includes