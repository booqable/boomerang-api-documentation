# Sessions

The session tells you whether settings are changed since the last time they were being requested. Every response includes a `Session-Id` header which contains a session ID. If that ID does not match with the ID of the last session that was fetched, this indicates that the following information may have been changed:

- Employee's permissions
- Company's subscription
- Settings
- Default properties
- Clusters and Locations
- Employee's notification subscriptions

When there's an ID mismatch, it's advised to fetch the session again and include `employee`, `company`, and `settings`. Default properties, clusters, and locations should be requested separately as they can be paginated.

## Endpoints
`GET /api/boomerang/sessions/{id}`

`GET /api/boomerang/sessions/current`

## Fields
Every session has the following fields:

Name | Description
-- | --
`id` | **Uuid** <br>
`company_id` | **Uuid** <br>The associated Company
`employee_id` | **Uuid** <br>The associated Employee
`locations_updated_at` | **Datetime** <br>When locations were last updated
`clusters_updated_at` | **Datetime** <br>When the clusters were last updated
`default_properties_updated_at` | **Datetime** <br>When the default properties were last updated
`notification_subscriptions_updated_at` | **Datetime** <br>When the employee last made a change to their notification subscriptions
`countries_updated_at` | **Datetime** <br>When the countries were last updated


## Relationships
Sessions have the following relationships:

Name | Description
-- | --
`company` | **Companies** `readonly`<br>Associated Company
`employee` | **Employees** `readonly`<br>Associated Employee
`settings` | **Settings** `readonly`<br>Associated Settings


## Retreiving the session



> How to retreive the session:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/sessions/current' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d4056823-87f9-5f65-b375-029fdb7faef6",
    "type": "sessions",
    "attributes": {
      "updated_at": "2024-08-05T09:26:45.351107+00:00",
      "company_id": "8ed36d43-9e4e-4b13-8e3e-9ec7edde204a",
      "employee_id": "a6f27b0e-4874-41ea-a09e-27ddb8e4e140",
      "locations_updated_at": "2024-08-05T09:26:45.369255+00:00",
      "clusters_updated_at": "2024-08-05T09:26:45.375990+00:00",
      "default_properties_updated_at": "2024-08-05T09:26:45.384849+00:00",
      "notification_subscriptions_updated_at": "2024-08-05T09:26:45.357926+00:00",
      "countries_updated_at": null
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/sessions/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee,company,settings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[sessions]=company_id,employee_id,locations_updated_at`


### Includes

This request accepts the following includes:

`employee`


`company`


`settings`






## Fetching the session



> How to fetch the session:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/sessions/current?extra_fields%5Bcompanies%5D=subscription&include=company%2Cemployee%2Csettings' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dc24aae8-e89a-51aa-b549-162863c9218a",
    "type": "sessions",
    "attributes": {
      "updated_at": "2024-08-05T09:24:48.119726+00:00",
      "company_id": "876a1daf-9331-4968-bf67-6d2ca4786666",
      "employee_id": "d376a424-ac19-4e20-8a22-306d78570a67",
      "locations_updated_at": null,
      "clusters_updated_at": null,
      "default_properties_updated_at": null,
      "notification_subscriptions_updated_at": "2024-08-05T09:24:48.126549+00:00",
      "countries_updated_at": null
    },
    "relationships": {
      "company": {
        "data": {
          "type": "companies",
          "id": "876a1daf-9331-4968-bf67-6d2ca4786666"
        }
      },
      "employee": {
        "data": {
          "type": "employees",
          "id": "d376a424-ac19-4e20-8a22-306d78570a67"
        }
      },
      "settings": {
        "data": {
          "type": "settings",
          "id": "4ebd0208-8328-5d69-8c44-ec50939c0967"
        }
      }
    }
  },
  "included": [
    {
      "id": "876a1daf-9331-4968-bf67-6d2ca4786666",
      "type": "companies",
      "attributes": {
        "created_at": "2024-08-05T09:24:48.082426+00:00",
        "updated_at": "2024-08-05T09:24:48.096196+00:00",
        "name": "Company name 134",
        "slug": "company-name-134",
        "email": "mail134@company.com",
        "billing_email": null,
        "phone": "0581234567",
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
        "custom_domain": null,
        "development": false,
        "shop_theme_id": null,
        "installed_online_store": false,
        "source": null,
        "medium": null,
        "tenant_token": "40c860f686f844adff8385e49fedd862",
        "pending_subscription": false,
        "team_size": null,
        "projected_revenue": null,
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
          "trial_ends_at": "2024-08-19T09:24:48.066Z",
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
            "categories",
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
        }
      }
    },
    {
      "id": "d376a424-ac19-4e20-8a22-306d78570a67",
      "type": "employees",
      "attributes": {
        "created_at": "2024-08-05T09:24:48.119726+00:00",
        "updated_at": "2024-08-05T09:24:48.119726+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "locale": null,
        "email": "john@doe.com",
        "unconfirmed_email": null,
        "viewed_whats_new_at": null,
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
        "avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=404",
        "large_avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=mm&size=200"
      }
    },
    {
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
          "custom_scripts": "",
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
        "deliveries": {}
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
`include` | **String** <br>List of comma seperated relationships `?include=employee,company,settings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[sessions]=company_id,employee_id,locations_updated_at`


### Includes

This request accepts the following includes:

`employee`


`company`


`settings`





