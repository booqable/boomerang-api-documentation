# Settings

Settings

**Currency**

Name | Description
- | -
`name` | **String** `readonly`<br>Currency code
`decimal` | **String** `readonly`<br>Decimal seperator
`thousand` | **String** `readonly`<br>Thousand seperator
`symbol` | **String** `readonly`<br>Currency symbol
`precision` | **String** `readonly`<br>Precision
`format` | **String** `readonly`<br>The format

**Defaults**

Name | Description
- | -
`timezone` | **String** `readonly`<br>The default timezone (managed on the company resource)
`tax_category_id` | **Uuid** `readonly`<br>ID the default tax category
`tax_region_id` | **Uuid** `readonly`<br>ID the default tax region

**pricing**

Name | Description
- | -
`enabled` | **Boolean** `readonly`<br>Whether pricing is enabled
`tax_strategy` | **Uuid** `readonly`<br>How taxes should be calcualted, one of `exclusive`, `inclusive`
`deposit_type` | **String** `readonly`<br>Default deposit type (applied to orders if customer deposit type is `default`)
`deposit_value` | **Integer** `readonly`<br>Default deposit value (applied to orders if customer deposit type is `default`)
`currency_format` | **String** `readonly`<br>Currency format
`currency_position` | **String** `readonly`<br>Where to place the currency symbol, one of `left`, `right`

## Fields
Every setting has the following fields:

Name | Description
- | -
`id` | **Uuid**<br>
`currency` | **Hash** `readonly`<br>Information about the currency (managed on Company resource)
`defaults` | **Hash** `readonly`<br>Information about defaults
`pricing` | **Hash**<br>Pricing settings
`dates` | **Hash**<br>Date settings
`orders` | **Hash**<br>Order settings
`security` | **Hash**<br>Security settings
`address` | **Hash**<br>Address settings
`store` | **Hash**<br>Store settings
`user` | **Hash**<br>User settings
`documents` | **Hash**<br>Document settings (applies to all document types)
`invoices` | **Hash**<br>Invoice settings
`quotes` | **Hash**<br>Quote settings
`contracts` | **Hash**<br>Contract settings
`dashboard` | **Hash** `extra`<br>Dashboard settings (Used internally by Booqable)
`setup` | **Hash** `extra`<br>Setup settings (Used internally by Booqable)
`quickstart` | **Hash** `extra`<br>Quickstart settings (Used internally by Booqable)


## Fetching settings



> How to fetch settings:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/settings/current' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4ebd0208-8328-5d69-8c44-ec50939c0967",
    "type": "settings",
    "attributes": {
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
        "tax_category_id": null,
        "tax_region_id": null
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
        "secuity.sso_forced": false,
        "secuity.iprestrictions_enabled": false
      },
      "address": {
        "use_billing_address": false,
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
        "send_orders_to_email": null,
        "brand_color": "#2B80FF",
        "use_availability": true,
        "use_prices": true,
        "display_price": "period",
        "show_powered_by": true,
        "use_order_lag_time": false,
        "order_lag_time_value": null,
        "order_lag_time_interval": null,
        "payment_strategy": "none",
        "payment_strategy_value": 30,
        "payment_deposit": false,
        "payment_methods": [],
        "use_toc": false,
        "toc_label": "",
        "toc_content": "",
        "use_business_hours": false,
        "use_away_mode": false,
        "period_type": "freely",
        "use_times": true,
        "use_coupons_in_checkout": true,
        "default_sorting": null,
        "default_filtering": null,
        "time_increment": 60,
        "show_product_availability": true,
        "hide_product_availability_quantities": false,
        "show_cart_availability": true,
        "website": null,
        "custom_scripts": null,
        "google_analytics_id": null,
        "facebook_pixel_id": null
      },
      "user": {
        "auth_enabled": false,
        "allow_signup": true,
        "allow_guest_checkout": true,
        "require_verification": true
      },
      "documents": {
        "show_tax_column": true,
        "css": null,
        "scss": null,
        "scope_numbering_to_prefix": false,
        "page_size": "a4"
      },
      "invoices": {
        "footer": null,
        "show_product_photos": true,
        "show_stock_identifiers": false,
        "show_free_lines": true,
        "hide_section_lines": false,
        "prefix": null
      },
      "quotes": {
        "footer": null,
        "body": null,
        "show_product_photos": true,
        "show_stock_identifiers": false,
        "hide_section_lines": false,
        "prefix": null
      },
      "contracts": {
        "footer": null,
        "body": null,
        "show_product_photos": true,
        "show_stock_identifiers": false,
        "hide_section_lines": false,
        "prefix": null
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/settings/current`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[settings]=id,created_at,updated_at`


### Includes

This request does not accept any includes