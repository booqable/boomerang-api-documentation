# Sessions

The session tells you whether settings are changed since the last time they were being requested.
Every response includes a `Session-Id` header which contains a session ID. If that ID does not
match with the ID of the last session that was fetched, this indicates that the following information
may have been changed:

- Employee's permissions
- Company's subscription
- Settings
- Default properties
- Locations
- Operating rules
- Employee's notification subscriptions

When there's an ID mismatch, it's advised to fetch the session again to reload these resources.

## Relationships
Name | Description
-- | --
`app_payment_options` | **[App payment options](#app-payment-options)** `hasmany`<br>All app payment options of the company.
`app_subscriptions` | **[App subscriptions](#app-subscriptions)** `hasmany`<br>All app subscriptions of the company.
`company` | **[Company](#companies)** `required`<br>The [Company](#companies).
`default_properties` | **[Default properties](#default-properties)** `hasmany`<br>All [DefaultProperties](#default-properties) of the company.
`employee` | **[Employee](#employees)** `required`<br>The current [Employee](#employees).
`locations` | **[Locations](#locations)** `hasmany`<br>All [Locations](#locations) of the company.
`operating_rules` | **[Operating rules](#operating-rules)** `hasmany`<br>All [OperatingRules](#operating-rules) of the company.
`payment_profiles` | **[Payment profiles](#payment-profiles)** `hasmany`<br>All [PaymentProfiles](#payment-profiles) of the company.
`settings` | **[Setting](#settings)** `required`<br>All [Settings](#settings) of the company.


Check matching attributes under [Fields](#sessions-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`app_payment_options_available` | **boolean** <br>Whether the app payment options are available in the checkout.
`company_id` | **uuid** <br>The [Company](#companies).
`countries_updated_at` | **datetime** <br>When the countries were last updated.
`default_properties_updated_at` | **datetime** <br>When the default properties were last updated.
`employee_id` | **uuid** <br>The current [Employee](#employees).
`id` | **uuid** <br>Primary key.
`locations_updated_at` | **datetime** <br>When locations were last updated.
`notification_subscriptions_updated_at` | **datetime** <br>When the employee last made a change to their notification subscriptions.
`operating_rules_updated_at` | **datetime** <br>When the operating rules were last updated.
`supported_fulfillment_types` | **array[string]** <br>Currently supported fulfillment types by the company's locations.


## Fetch the session


> How to fetch the session:

```shell
  curl --get 'https://example.booqable.com/api/4/sessions/current'
       --header 'content-type: application/json'
       --data-urlencode 'extra_fields[companies]=subscription'
       --data-urlencode 'include=company,employee,settings'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "2bcd1f98-a7bd-4474-8e72-4e3e23c17069",
      "type": "sessions",
      "attributes": {
        "updated_at": "2022-08-21T05:03:01.000000+00:00",
        "company_id": "59b0823e-3949-4963-8088-2c23b460c183",
        "employee_id": "88189003-4480-4a2a-89b0-a54b3dbb89fe",
        "locations_updated_at": null,
        "default_properties_updated_at": null,
        "notification_subscriptions_updated_at": "2022-08-21T05:03:01.000000+00:00",
        "countries_updated_at": null,
        "operating_rules_updated_at": null,
        "supported_fulfillment_types": [],
        "app_payment_options_available": false
      },
      "relationships": {
        "company": {
          "data": {
            "type": "companies",
            "id": "59b0823e-3949-4963-8088-2c23b460c183"
          }
        },
        "employee": {
          "data": {
            "type": "employees",
            "id": "88189003-4480-4a2a-89b0-a54b3dbb89fe"
          }
        },
        "settings": {
          "data": {
            "type": "settings",
            "id": "96849184-8628-4aba-83ed-1108234938b3"
          }
        }
      }
    },
    "included": [
      {
        "id": "59b0823e-3949-4963-8088-2c23b460c183",
        "type": "companies",
        "attributes": {
          "created_at": "2022-08-21T05:03:01.000000+00:00",
          "updated_at": "2022-08-21T05:03:01.000000+00:00",
          "name": "Company name 317",
          "slug": "company-name-317",
          "email": "mail320@company.com",
          "billing_email": null,
          "phone": null,
          "website": null,
          "address_line_1": null,
          "address_line_2": null,
          "zipcode": null,
          "city": null,
          "region": null,
          "country": "Netherlands",
          "country_code": null,
          "market": "AV / Camera",
          "use_billing_address": false,
          "billing_company": null,
          "billing_address_line_1": null,
          "billing_address_line_2": null,
          "billing_address_zipcode": null,
          "billing_address_city": null,
          "billing_address_region": null,
          "billing_address_country": null,
          "logo_url": null,
          "favicon_url": null,
          "default_timezone": "UTC",
          "currency": "usd",
          "financial_line_1": null,
          "financial_line_2": null,
          "vat_number": null,
          "in_eur_country": false,
          "euvat_member": false,
          "has_to_pay_vat": false,
          "vat_reverse_charge_applicable": false,
          "vat_validation_status": "pending",
          "continent": null,
          "custom_domain": null,
          "custom_domain_validation": null,
          "development": false,
          "shop_theme_id": null,
          "shop_theme_published": false,
          "installed_online_store": false,
          "tenant_token": "32af84390e700e5f1863434446a4a235",
          "pending_subscription": false,
          "address": "Netherlands",
          "main_address": null,
          "billing_address": null,
          "subscription": {
            "trial_ends_at": "2022-08-20T05:03:01.000000+00:00",
            "activated": true,
            "active_subscription": true,
            "suspended": false,
            "canceled": false,
            "canceled_at": null,
            "on_hold": false,
            "plan_identifier": "custom",
            "plan_pricing_strategy": "start_grow_scale_custom",
            "active_subscription_plan_and_interval": "custom_month",
            "interval": "month",
            "current_period_end": null,
            "extra_employees": 0,
            "extra_employees_left": 19,
            "extra_locations": 0,
            "addons": [
              "online_bookings",
              "website_builder",
              "mobile_app",
              "sso",
              "ip_restrictions",
              "2fa_enforcing",
              "barcodes"
            ],
            "checkout_settings": {},
            "amount_in_cents": 51200,
            "discount_in_cents": 0,
            "balance_in_cents": 0,
            "coupon": null,
            "coupon_intervals": null,
            "coupon_plans": null,
            "coupon_percent_off": null,
            "coupon_duration": null,
            "coupon_duration_in_months": null,
            "strategy": "charge_automatically",
            "source": null,
            "pricing_strategy": null,
            "enabled_features": [],
            "allowed_features": [
              "destroy_bundles",
              "sales_items",
              "buffer_times",
              "notes",
              "packing_slips",
              "away_mode",
              "custom_domain",
              "availability_reports",
              "fulfillment_reports",
              "cross_sell",
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
              "activity_logs",
              "website_builder",
              "mobile_app",
              "tap_to_pay",
              "sso",
              "iprestrictions",
              "2fa_enforcing",
              "barcodes"
            ],
            "restrictions": {
              "employees": 20,
              "email_max_recipients": 2000,
              "rate_limit_max": 250,
              "rate_limit_period": 60,
              "locations": 1,
              "allow_extra_locations": true,
              "allow_extra_employees": true,
              "manual_email_templates": null,
              "custom_fields": null,
              "tags": null,
              "away_modes": null
            },
            "currency": "usd",
            "current_currency": "usd"
          },
          "third_party_id": "59b0823e-3949-4963-8088-2c23b460c183"
        }
      },
      {
        "id": "88189003-4480-4a2a-89b0-a54b3dbb89fe",
        "type": "employees",
        "attributes": {
          "created_at": "2022-08-21T05:03:01.000000+00:00",
          "updated_at": "2022-08-21T05:03:01.000000+00:00",
          "name": "John Doe",
          "firstname": "John",
          "lastname": "Doe",
          "locale": null,
          "email": "john@doe.com",
          "unconfirmed_email": null,
          "viewed_whats_new_at": "2022-08-21T05:03:01.000000+00:00",
          "active": true,
          "owner": true,
          "confirmed": true,
          "time_to_confirm": 0,
          "permissions": [
            "reports",
            "products",
            "settings",
            "security_settings",
            "account",
            "exports",
            "cancel_orders",
            "revert_orders",
            "delete_invoices",
            "make_invoice_revisions",
            "override_rental_period",
            "activity_logs",
            "ai_assistant"
          ],
          "has_two_factor_autentication": false,
          "avatar_url": "https://gravatar.com/avatar/7bd9d8bc934d602725599b5ee37929d6.png?d=404",
          "large_avatar_url": "https://gravatar.com/avatar/7bd9d8bc934d602725599b5ee37929d6.png?d=mm&size=200",
          "third_party_id": "88189003-4480-4a2a-89b0-a54b3dbb89fe-1781532800"
        }
      },
      {
        "id": "96849184-8628-4aba-83ed-1108234938b3",
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
            "timezone_offset": 0,
            "tax_category_id": null,
            "tax_region_id": null,
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
            "start_fixed_at": "09:00",
            "stop_fixed_at": "15:00"
          },
          "security": {
            "sso_forced": false,
            "2fa_forced": false,
            "iprestrictions_enabled": false
          },
          "address": {},
          "store": {
            "enabled": true,
            "public": true,
            "send_order_confirmation": true,
            "brand_color": "#136DEB",
            "use_availability": true,
            "use_prices": true,
            "display_price": "period",
            "show_powered_by": true,
            "default_collection_sort": "name",
            "cross_sell.enabled": false,
            "cross_sell.title": "Recommended products",
            "cross_sell.subtitle": "Add matching items to make sure you have everything you need",
            "cross_sell.layout": "list",
            "cross_sell.show_only_available": true,
            "cross_sell.maximum_products": 4,
            "use_order_lag_time": false,
            "order_lag_time_value": null,
            "order_lag_time_interval": null,
            "behaviors.add_button": "show_cart",
            "behaviors.location_picker": "start",
            "payment_strategy": "none",
            "payment_strategy_value": 30,
            "payment_deposit": false,
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
            "captcha_enabled": false,
            "allow_guest_checkout": true,
            "require_login_to_browse": false,
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
            "prefix": null,
            "default_due_period": null
          },
          "quotes": {
            "footer": "",
            "body": "",
            "show_product_photos": true,
            "show_stock_identifiers": false,
            "show_free_lines": true,
            "hide_section_lines": false,
            "prefix": null
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
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/sessions/current`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[sessions]=company_id,employee_id,locations_updated_at`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=app_subscriptions,app_payment_options,company`


### Includes

This request accepts the following includes:

<ul>
  <li><code>app_payment_options</code></li>
  <li><code>app_subscriptions</code></li>
  <li><code>company</code></li>
  <li><code>default_properties</code></li>
  <li><code>employee</code></li>
  <li><code>locations</code></li>
  <li><code>operating_rules</code></li>
  <li><code>payment_profiles</code></li>
  <li><code>settings</code></li>
</ul>

