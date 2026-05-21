# Billing plans

The billing plan resource provides information about available billing plans, extra charges,
and pricing strategies. This data is used by the backoffice to display plan options and pricing.

## Fields

 Name | Description
-- | --
`billing_plans` | **array** <br>The available billing plans with their pricing, features, and restrictions.
`extra_charges` | **array** <br>The available extra charges for billing plans (like addons and extra employees/locations).
`id` | **uuid** `readonly`<br>Primary key.
`pricing_strategies` | **hash** <br>The available pricing strategies and their configuration.


## Fetch billing plans


> How to fetch billing plans:

```shell
  curl --get 'https://example.booqable.com/api/4/billing_plans'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "67ceb69f-43b2-48fc-8e4f-50f4f40f0cb9",
        "type": "billing_plans",
        "attributes": {
          "billing_plans": [
            {
              "name": "essential",
              "month_price": 35,
              "year_price": 348,
              "restrictions": {
                "employees": 2,
                "email_max_recipients": 100,
                "rate_limit_max": 50,
                "rate_limit_period": 60,
                "locations": 1,
                "allow_extra_locations": true,
                "allow_extra_employees": true,
                "manual_email_templates": -1,
                "custom_fields": -1,
                "tags": -1
              },
              "features": [
                "product_history",
                "website_builder",
                "zapier",
                "website_integration",
                "invoice_due_dates",
                "mobile_app",
                "product_security_deposit",
                "api",
                "customer_discount_percentage",
                "advanced_pricing",
                "custom_domain",
                "sales_items",
                "destroy_bundles",
                "bundles",
                "buffer_times",
                "prevent_last_minute_reservations",
                "packing_slips",
                "notes",
                "manual_email_templates",
                "product_shortage_limits",
                "away_mode"
              ],
              "pricing_strategy": "essential_pro_premium"
            },
            {
              "name": "pro",
              "month_price": 95,
              "year_price": 948,
              "restrictions": {
                "employees": 5,
                "email_max_recipients": 200,
                "rate_limit_max": 100,
                "rate_limit_period": 60,
                "locations": 1,
                "allow_extra_locations": true,
                "allow_extra_employees": true,
                "manual_email_templates": -1,
                "custom_fields": -1,
                "tags": -1
              },
              "features": [
                "product_history",
                "website_builder",
                "zapier",
                "website_integration",
                "invoice_due_dates",
                "mobile_app",
                "product_security_deposit",
                "api",
                "customer_discount_percentage",
                "advanced_pricing",
                "custom_domain",
                "sales_items",
                "destroy_bundles",
                "bundles",
                "buffer_times",
                "prevent_last_minute_reservations",
                "packing_slips",
                "notes",
                "manual_email_templates",
                "product_shortage_limits",
                "away_mode",
                "barcodes",
                "reports",
                "availability_reports",
                "fulfillment_reports",
                "permissions",
                "exports",
                "coupons",
                "downtimes",
                "custom_scripts",
                "roi_reports",
                "customer_report"
              ],
              "pricing_strategy": "essential_pro_premium"
            },
            {
              "name": "premium",
              "month_price": 299,
              "year_price": 2988,
              "restrictions": {
                "employees": 15,
                "email_max_recipients": 500,
                "rate_limit_max": 250,
                "rate_limit_period": 60,
                "locations": 3,
                "allow_extra_locations": true,
                "allow_extra_employees": true,
                "manual_email_templates": -1,
                "custom_fields": -1,
                "tags": -1
              },
              "features": [
                "product_history",
                "website_builder",
                "zapier",
                "website_integration",
                "invoice_due_dates",
                "mobile_app",
                "product_security_deposit",
                "api",
                "customer_discount_percentage",
                "advanced_pricing",
                "custom_domain",
                "sales_items",
                "destroy_bundles",
                "bundles",
                "buffer_times",
                "prevent_last_minute_reservations",
                "packing_slips",
                "notes",
                "manual_email_templates",
                "product_shortage_limits",
                "away_mode",
                "barcodes",
                "reports",
                "availability_reports",
                "fulfillment_reports",
                "permissions",
                "exports",
                "coupons",
                "downtimes",
                "custom_scripts",
                "roi_reports",
                "customer_report",
                "sso",
                "iprestrictions",
                "2fa_enforcing",
                "remove_powered_by"
              ],
              "pricing_strategy": "essential_pro_premium"
            },
            {
              "name": "small",
              "month_price": 34,
              "year_price": 324,
              "restrictions": {
                "employees": 1,
                "email_max_recipients": 100,
                "rate_limit_max": 50,
                "rate_limit_period": 60,
                "locations": 1,
                "allow_extra_locations": false,
                "allow_extra_employees": false,
                "manual_email_templates": 0,
                "custom_fields": 3,
                "tags": 5,
                "away_modes": 0
              },
              "features": [
                "destroy_bundles",
                "mobile_app",
                "zapier"
              ],
              "pricing_strategy": "small_medium_large_scale"
            },
            {
              "name": "medium",
              "month_price": 87,
              "year_price": 828,
              "restrictions": {
                "employees": 2,
                "email_max_recipients": 200,
                "rate_limit_max": 100,
                "rate_limit_period": 60,
                "locations": 1,
                "allow_extra_locations": false,
                "allow_extra_employees": false,
                "manual_email_templates": 3,
                "custom_fields": -1,
                "tags": -1,
                "away_modes": 2
              },
              "features": [
                "destroy_bundles",
                "mobile_app",
                "zapier",
                "advanced_pricing",
                "sales_items",
                "bundles",
                "buffer_times",
                "prevent_last_minute_reservations",
                "packing_slips",
                "notes",
                "manual_email_templates",
                "away_mode",
                "customer_discount_percentage",
                "product_security_deposit",
                "coupons",
                "invoice_due_dates",
                "reports",
                "availability_reports",
                "fulfillment_reports",
                "product_history",
                "downtimes",
                "roi_reports",
                "customer_report"
              ],
              "pricing_strategy": "small_medium_large_scale"
            },
            {
              "name": "large",
              "month_price": 189,
              "year_price": 1788,
              "restrictions": {
                "employees": 5,
                "email_max_recipients": 500,
                "rate_limit_max": 250,
                "rate_limit_period": 60,
                "locations": 1,
                "allow_extra_locations": true,
                "allow_extra_employees": true,
                "manual_email_templates": -1,
                "custom_fields": -1,
                "tags": -1,
                "away_modes": -1
              },
              "features": [
                "destroy_bundles",
                "mobile_app",
                "zapier",
                "advanced_pricing",
                "sales_items",
                "bundles",
                "buffer_times",
                "prevent_last_minute_reservations",
                "packing_slips",
                "notes",
                "manual_email_templates",
                "away_mode",
                "customer_discount_percentage",
                "product_security_deposit",
                "coupons",
                "invoice_due_dates",
                "reports",
                "availability_reports",
                "fulfillment_reports",
                "product_history",
                "downtimes",
                "roi_reports",
                "customer_report",
                "api",
                "permissions",
                "product_shortage_limits",
                "exports",
                "remove_powered_by"
              ],
              "pricing_strategy": "small_medium_large_scale"
            },
            {
              "name": "scale",
              "month_price": 499,
              "year_price": 4788,
              "restrictions": {
                "employees": 15,
                "email_max_recipients": 2000,
                "rate_limit_max": 250,
                "rate_limit_period": 60,
                "locations": 1,
                "allow_extra_locations": true,
                "allow_extra_employees": true,
                "manual_email_templates": -1,
                "custom_fields": -1,
                "tags": -1,
                "away_modes": -1
              },
              "features": [
                "destroy_bundles",
                "mobile_app",
                "zapier",
                "advanced_pricing",
                "sales_items",
                "bundles",
                "buffer_times",
                "prevent_last_minute_reservations",
                "packing_slips",
                "notes",
                "manual_email_templates",
                "away_mode",
                "customer_discount_percentage",
                "product_security_deposit",
                "coupons",
                "invoice_due_dates",
                "reports",
                "availability_reports",
                "fulfillment_reports",
                "product_history",
                "downtimes",
                "roi_reports",
                "customer_report",
                "api",
                "permissions",
                "product_shortage_limits",
                "exports",
                "remove_powered_by"
              ],
              "pricing_strategy": "small_medium_large_scale"
            },
            {
              "name": "start",
              "month_price": 35,
              "year_price": 348,
              "restrictions": {
                "employees": 1,
                "email_max_recipients": 100,
                "rate_limit_max": 50,
                "rate_limit_period": 60,
                "locations": 1,
                "allow_extra_locations": false,
                "allow_extra_employees": false,
                "manual_email_templates": 0,
                "custom_fields": 3,
                "tags": -1,
                "away_modes": 2
              },
              "features": [
                "destroy_bundles",
                "sales_items",
                "buffer_times",
                "notes",
                "packing_slips",
                "away_mode",
                "custom_domain",
                "availability_reports",
                "fulfillment_reports"
              ],
              "pricing_strategy": "start_grow_scale_custom"
            },
            {
              "name": "grow",
              "month_price": 87,
              "year_price": 828,
              "restrictions": {
                "employees": 6,
                "email_max_recipients": 200,
                "rate_limit_max": 100,
                "rate_limit_period": 60,
                "locations": 1,
                "allow_extra_locations": false,
                "allow_extra_employees": false,
                "manual_email_templates": -1,
                "custom_fields": -1,
                "tags": -1,
                "away_modes": -1
              },
              "features": [
                "destroy_bundles",
                "sales_items",
                "buffer_times",
                "notes",
                "packing_slips",
                "away_mode",
                "custom_domain",
                "availability_reports",
                "fulfillment_reports",
                "advanced_pricing",
                "bundles",
                "prevent_last_minute_reservations",
                "manual_email_templates",
                "customer_discount_percentage",
                "product_security_deposit",
                "coupons",
                "coupons_advanced",
                "invoice_due_dates",
                "reports",
                "product_history",
                "downtimes",
                "permissions",
                "exports",
                "zapier",
                "website_integration",
                "custom_scripts",
                "customer_report",
                "roi_reports",
                "company_performance_report",
                "esignatures"
              ],
              "pricing_strategy": "start_grow_scale_custom"
            },
            {
              "name": "scale_v2",
              "month_price": 187,
              "year_price": 1788,
              "restrictions": {
                "employees": 11,
                "email_max_recipients": 500,
                "rate_limit_max": 250,
                "rate_limit_period": 60,
                "locations": 1,
                "allow_extra_locations": true,
                "allow_extra_employees": true,
                "manual_email_templates": -1,
                "custom_fields": -1,
                "tags": -1,
                "away_modes": -1
              },
              "features": [
                "destroy_bundles",
                "sales_items",
                "buffer_times",
                "notes",
                "packing_slips",
                "away_mode",
                "custom_domain",
                "availability_reports",
                "fulfillment_reports",
                "advanced_pricing",
                "bundles",
                "prevent_last_minute_reservations",
                "manual_email_templates",
                "customer_discount_percentage",
                "product_security_deposit",
                "coupons",
                "coupons_advanced",
                "invoice_due_dates",
                "reports",
                "product_history",
                "downtimes",
                "permissions",
                "exports",
                "zapier",
                "website_integration",
                "custom_scripts",
                "customer_report",
                "roi_reports",
                "company_performance_report",
                "esignatures",
                "api",
                "product_shortage_limits",
                "remove_powered_by",
                "activity_logs"
              ],
              "pricing_strategy": "start_grow_scale_custom"
            },
            {
              "name": "custom",
              "month_price": 419,
              "year_price": 4188,
              "restrictions": {
                "employees": 20,
                "email_max_recipients": 2000,
                "rate_limit_max": 250,
                "rate_limit_period": 60,
                "locations": 1,
                "allow_extra_locations": true,
                "allow_extra_employees": true,
                "manual_email_templates": -1,
                "custom_fields": -1,
                "tags": -1,
                "away_modes": -1
              },
              "features": [
                "destroy_bundles",
                "sales_items",
                "buffer_times",
                "notes",
                "packing_slips",
                "away_mode",
                "custom_domain",
                "availability_reports",
                "fulfillment_reports",
                "advanced_pricing",
                "bundles",
                "prevent_last_minute_reservations",
                "manual_email_templates",
                "customer_discount_percentage",
                "product_security_deposit",
                "coupons",
                "coupons_advanced",
                "invoice_due_dates",
                "reports",
                "product_history",
                "downtimes",
                "permissions",
                "exports",
                "zapier",
                "website_integration",
                "custom_scripts",
                "customer_report",
                "roi_reports",
                "company_performance_report",
                "esignatures",
                "api",
                "product_shortage_limits",
                "remove_powered_by",
                "activity_logs"
              ],
              "pricing_strategy": "start_grow_scale_custom"
            }
          ],
          "extra_charges": [
            {
              "name": "extra_employee_expiring",
              "month_price": 20,
              "year_price": 200,
              "per_employee": null,
              "features": null,
              "default": null,
              "available_on": null
            },
            {
              "name": "extra_location_expiring",
              "month_price": 25,
              "year_price": 240,
              "per_employee": null,
              "features": null,
              "default": null,
              "available_on": null
            },
            {
              "name": "extra_employee",
              "month_price": 37,
              "year_price": 348,
              "per_employee": null,
              "features": null,
              "default": null,
              "available_on": null
            },
            {
              "name": "extra_location",
              "month_price": 37,
              "year_price": 348,
              "per_employee": null,
              "features": null,
              "default": null,
              "available_on": null
            },
            {
              "name": "online_bookings",
              "month_price": 24,
              "year_price": 228,
              "per_employee": false,
              "features": [
                "custom_domain",
                "custom_scripts",
                "website_integration",
                "website_builder"
              ],
              "default": true,
              "available_on": [
                "small",
                "medium",
                "large",
                "scale"
              ]
            },
            {
              "name": "website_builder",
              "month_price": 24,
              "year_price": 228,
              "per_employee": false,
              "features": [
                "website_builder"
              ],
              "default": true,
              "available_on": [
                "start",
                "grow",
                "scale_v2",
                "custom"
              ]
            },
            {
              "name": "mobile_app",
              "month_price": 12,
              "year_price": 108,
              "per_employee": true,
              "features": [
                "mobile_app",
                "tap_to_pay"
              ],
              "default": true,
              "available_on": [
                "start",
                "grow",
                "scale_v2",
                "custom"
              ]
            },
            {
              "name": "sso",
              "month_price": 7,
              "year_price": 60,
              "per_employee": true,
              "features": [
                "sso"
              ],
              "default": null,
              "available_on": [
                "scale",
                "custom"
              ]
            },
            {
              "name": "ip_restrictions",
              "month_price": 7,
              "year_price": 60,
              "per_employee": true,
              "features": [
                "iprestrictions"
              ],
              "default": null,
              "available_on": [
                "scale",
                "custom"
              ]
            },
            {
              "name": "2fa_enforcing",
              "month_price": 7,
              "year_price": 60,
              "per_employee": true,
              "features": [
                "2fa_enforcing"
              ],
              "default": null,
              "available_on": [
                "scale",
                "custom"
              ]
            },
            {
              "name": "barcodes",
              "month_price": 12,
              "year_price": 108,
              "per_employee": true,
              "features": [
                "barcodes"
              ],
              "default": true,
              "available_on": [
                "large",
                "scale",
                "grow",
                "scale_v2",
                "custom"
              ]
            }
          ],
          "pricing_strategies": {
            "essential_pro_premium": {
              "allows_custom_checkout_settings": false,
              "allows_addons": false,
              "base_plans": [
                "essential",
                "pro",
                "premium"
              ],
              "default_plan": "essential",
              "trial_plan": "premium",
              "highest_plan": "premium",
              "uses_expiring_extra_charges": true,
              "available_versions": [
                "initial",
                "october_2025"
              ],
              "available_currencies": [
                "usd"
              ]
            },
            "small_medium_large_scale": {
              "allows_custom_checkout_settings": true,
              "allows_addons": true,
              "base_plans": [
                "small",
                "medium",
                "large"
              ],
              "default_plan": "medium",
              "trial_plan": "large",
              "highest_plan": "scale",
              "uses_expiring_extra_charges": false,
              "available_versions": [
                "initial"
              ],
              "available_currencies": [
                "usd"
              ]
            },
            "start_grow_scale_custom": {
              "allows_custom_checkout_settings": true,
              "allows_addons": true,
              "base_plans": [
                "start",
                "grow",
                "scale_v2"
              ],
              "default_plan": "grow",
              "trial_plan": "scale_v2",
              "highest_plan": "custom",
              "uses_expiring_extra_charges": false,
              "available_versions": [
                "initial",
                "usd_eur"
              ],
              "available_currencies": [
                "usd",
                "eur"
              ]
            }
          }
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/billing_plans`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[billing_plans]=billing_plans,extra_charges,pricing_strategies`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`billing_plans` | **array** <br>`eq`
`extra_charges` | **array** <br>`eq`
`pricing_strategies` | **hash** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes