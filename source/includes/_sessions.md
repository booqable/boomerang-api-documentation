# Sessions

The session tells you whether settings are changed since the last time they were being requested.
Every response includes a `Session-Id` header which contains a session ID. If that ID does not
match with the ID of the last session that was fetched, this indicates that the following information
may have been changed:

- Employee's permissions
- Company's subscription
- Settings
- Default properties
- Clusters and Locations
- Operating rules
- Employee's notification subscriptions

When there's an ID mismatch, it's advised to fetch the session again to reload these resources.

## Relationships
Name | Description
-- | --
`app_subscriptions` | **[App subscriptions](#app-subscriptions)** `hasmany`<br>All app subscriptions of the company.
`clusters` | **[Clusters](#clusters)** `hasmany`<br>All clusters of the company.
`company` | **[Company](#companies)** `required`<br>The company.
`default_properties` | **[Default properties](#default-properties)** `hasmany`<br>All default properties of the company.
`employee` | **[Employee](#employees)** `required`<br>The current employee.
`locations` | **[Locations](#locations)** `hasmany`<br>All locations of the company.
`operating_rules` | **[Operating rules](#operating-rules)** `hasmany`<br>All operating rules of the company.
`settings` | **[Setting](#settings)** `required`<br>All settings of the company.


Check matching attributes under [Fields](#sessions-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`clusters_updated_at` | **datetime** <br>When the clusters were last updated.
`company_id` | **uuid** <br>The company.
`countries_updated_at` | **datetime** <br>When the countries were last updated.
`default_properties_updated_at` | **datetime** <br>When the default properties were last updated.
`employee_id` | **uuid** <br>The current employee.
`id` | **uuid** <br>Primary key.
`locations_updated_at` | **datetime** <br>When locations were last updated.
`notification_subscriptions_updated_at` | **datetime** <br>When the employee last made a change to their notification subscriptions.
`operating_rules_updated_at` | **datetime** <br>When the operating rules were last updated.


## Fetch the session


> How to fetch the session:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/sessions/current'
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
        "clusters_updated_at": null,
        "default_properties_updated_at": null,
        "notification_subscriptions_updated_at": "2022-08-21T05:03:01.000000+00:00",
        "countries_updated_at": null,
        "operating_rules_updated_at": null
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
          "name": "Company name 277",
          "slug": "company-name-277",
          "email": "mail280@company.com",
          "billing_email": null,
          "phone": null,
          "website": "www.booqable.com",
          "address_line_1": "Blokhuispoort",
          "address_line_2": "Leeuwarden",
          "zipcode": "8900AB",
          "city": "Leeuwarden",
          "region": null,
          "country": "the Netherlands",
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
          "financial_line_1": "Blokhuispoort",
          "financial_line_2": "Leeuwarden",
          "vat_number": null,
          "in_europe": null,
          "continent": null,
          "custom_domain": null,
          "custom_domain_validation": null,
          "development": false,
          "shop_theme_id": null,
          "installed_online_store": false,
          "source": null,
          "medium": null,
          "tenant_token": "32af84390e700e5f1863434446a4a235",
          "pending_subscription": false,
          "team_size": null,
          "revenue_last_year": null,
          "year_business_start": null,
          "address": "Blokhuispoort\nLeeuwarden\n8900AB Leeuwarden\nthe Netherlands",
          "main_address": {
            "meets_validation_requirements": false,
            "first_name": null,
            "last_name": null,
            "address1": "Blokhuispoort",
            "address2": "Leeuwarden",
            "city": "Leeuwarden",
            "region": null,
            "zipcode": "8900AB",
            "country": "the Netherlands",
            "country_id": null,
            "province_id": null,
            "latitude": null,
            "longitude": null,
            "value": "Blokhuispoort\nLeeuwarden\n8900AB Leeuwarden\nthe Netherlands"
          },
          "billing_address": null,
          "subscription": {
            "trial_ends_at": "2022-09-04T05:03:01.000000+00:00",
            "activated": false,
            "active_subscription": false,
            "suspended": false,
            "canceled": false,
            "canceled_at": null,
            "on_hold": false,
            "needs_activation": false,
            "product": "Premium",
            "plan_id": "premium_monthly",
            "interval": "month",
            "current_period_end": null,
            "extra_employees": 0,
            "extra_locations": 0,
            "amount_in_cents": 29900,
            "discount_in_cents": 0,
            "balance_in_cents": 0,
            "coupon": null,
            "coupon_percent_off": null,
            "coupon_duration": null,
            "coupon_duration_in_months": null,
            "strategy": "charge_automatically",
            "source": null,
            "enabled_features": [],
            "allowed_features": [
              "bundles",
              "multiple_locations",
              "advanced_pricing",
              "api",
              "custom_fields",
              "overbookings",
              "customer_auth",
              "custom_domain",
              "barcodes",
              "reports",
              "permissions",
              "exports",
              "coupons",
              "shop_tracking",
              "sso",
              "iprestrictions",
              "2fa_enforcing",
              "remove_powered_by"
            ],
            "restrictions": {
              "employees": 15,
              "email_max_recipients": 2000,
              "rate_limit_max": 250,
              "rate_limit_period": 60,
              "locations": 3
            },
            "can_try_plan": true
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
            "override_rental_period"
          ],
          "has_two_factor_autentication": false,
          "allowed_session_id": null,
          "avatar_url": "https://gravatar.com/avatar/7bd9d8bc934d602725599b5ee37929d6.png?d=404",
          "large_avatar_url": "https://gravatar.com/avatar/7bd9d8bc934d602725599b5ee37929d6.png?d=mm&size=200",
          "third_party_id": "88189003-4480-4a2a-89b0-a54b3dbb89fe-1736155719"
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
          "emails": {},
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

`GET /api/boomerang/sessions/current`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[sessions]=company_id,employee_id,locations_updated_at`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=app_subscriptions,clusters,company`


### Includes

This request accepts the following includes:

`app_subscriptions`


`clusters`


`company`


`default_properties`


`employee`


`locations`


`operating_rules`


`settings`





