# Session

Session

## Fields
Every session has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`company_id` | **Uuid**<br>The associated Company
`employee_id` | **Uuid**<br>The associated Employee
`token` | **String**<br>
`currency` | **Hash**<br>
`features` | **Array**<br>
`enabled_features` | **Array**<br>
`restrictions` | **Hash**<br>
`settings` | **Hash**<br>
`subscription` | **Hash** `readonly`<br>
`counts` | **Hash** `readonly`<br>
`default_tax_category_id` | **Uuid** `readonly`<br>
`default_tax_region_id` | **Uuid** `readonly`<br>
`has_multiple_locations` | **Boolean** `readonly`<br>
`company_third_party_id` | **String** `readonly`<br>
`employee_third_party_id` | **String** `readonly`<br>


## Relationships
A session has the following relationships:

Name | Description
- | -
`company` | **Companies** `readonly`<br>Associated Company
`employee` | **Employees** `readonly`<br>Associated Employee


## Retreiving the session

> How to retreive the session:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/session' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-ee3f40a8-27ca-58f8-97d2-1dfb1ae18d4f",
      "created_at": null,
      "updated_at": "2021-10-08T11:32:52+00:00",
      "company_id": "264c3f5f-2694-46d7-9608-7b867a2e6fcc",
      "employee_id": "f46d9173-3587-43d7-9552-d56758952ee6",
      "token": "ee3f40a8-27ca-58f8-97d2-1dfb1ae18d4f",
      "currency": {
        "name": "USD",
        "decimal": ".",
        "thousand": ",",
        "symbol": "$",
        "precision": 2,
        "format": "%s%v"
      },
      "features": [
        "bundles",
        "advanced_pricing",
        "multiple_locations",
        "api",
        "custom_fields",
        "overbookings",
        "categories",
        "customer_auth",
        "barcodes",
        "reports",
        "permissions",
        "exports",
        "coupons",
        "remove_powered_by",
        "shop_tracking",
        "custom_domain",
        "sso",
        "iprestrictions"
      ],
      "enabled_features": [],
      "restrictions": {
        "employees": "15",
        "email_max_recipients": 500,
        "rate_limit_max": 250,
        "rate_limit_period": 60
      },
      "settings": {
        "documents.show_tax_column": true,
        "documents.scope_numbering_to_prefix": false,
        "invoices.show_stock_identifiers": false,
        "invoices.show_free_lines": true,
        "invoices.hide_section_lines": false,
        "quotes.show_stock_identifiers": false,
        "quotes.hide_section_lines": false,
        "contracts.show_stock_identifiers": false,
        "contracts.hide_section_lines": false,
        "pricing.enabled": true,
        "pricing.tax_strategy": "exclusive",
        "pricing.deposit_type": "percentage",
        "pricing.deposit_value": 100,
        "pricing.currency_format": "symbol",
        "pricing.currency_position": "left",
        "dashboard.orders.period": "all",
        "setup.completed": true,
        "quickstart.step": 1,
        "quickstart.completed": false,
        "dates.format": "DD-MM-YYYY",
        "dates.use_am_pm": false,
        "dates.first_day_of_week": 0,
        "orders.use_times": true,
        "orders.start_type": "fixed",
        "orders.start_relative_offset": 0,
        "orders.start_fixed_at": "09:00",
        "orders.stop_type": "fixed",
        "orders.stop_relative_offset": 48,
        "orders.stop_fixed_at": "15:00",
        "sso.forced": false,
        "iprestrictions.enabled": false,
        "store.enabled": true,
        "store.public": true,
        "store.send_order_confirmation": true,
        "store.brand_color": "#2B80FF",
        "store.use_availability": true,
        "store.use_prices": true,
        "store.display_price": "period",
        "store.show_powered_by": true,
        "store.payment_strategy": "none",
        "store.payment_strategy_value": 30,
        "store.payment_deposit": false,
        "store.payment_methods": [],
        "store.use_toc": false,
        "store.toc_label": "",
        "store.toc_content": "",
        "store.use_business_hours": false,
        "store.use_away_mode": false,
        "store.period_type": "freely",
        "store.use_times": true,
        "store.use_coupons_in_checkout": true,
        "store.default_sorting": null,
        "store.default_filtering": null,
        "store.time_increment": 60,
        "store.show_product_availability": true,
        "store.hide_product_availability_quantities": false,
        "store.show_cart_availability": true,
        "address.use_billing_address": false,
        "address.fields_order": [
          "zipcode",
          "city",
          "region"
        ],
        "user.auth_enabled": false,
        "user.allow_signup": true,
        "user.allow_guest_checkout": true,
        "user.require_verification": true
      }
    }
  ]
}
```


### HTTP Request

`GET /api/boomerang/sessions/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=company,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[session]=id,created_at,updated_at`


### Includes

This request does not accept any includes