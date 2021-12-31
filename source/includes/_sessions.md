# Sessions

The session tells you whether settings are changed since the last time they were being requested. Every response includes a `Session-Id` header which contains a session ID. If that ID does not match with the ID of the last session that was fetched, this indicates that the following information may have been changed:

- Employee's permissions
- Company's subscription
- Settings
- Default properties
- Clusters and Locations

When there's an ID mismatch, it's advised to fetch the session again and include `employee`, `company`, and `settings`. Default properties, clusters, and locations should be requested separately as they can be paginated.

## Endpoints
`GET /api/boomerang/sessions/{id}`

`GET /api/boomerang/sessions/current`

## Fields
Every session has the following fields:

Name | Description
- | -
`id` | **Uuid**<br>
`company_id` | **Uuid**<br>The associated Company
`employee_id` | **Uuid**<br>The associated Employee
`locations_updated_at` | **Datetime**<br>When locations were last updated
`clusters_updated_at` | **Datetime**<br>When the clusters were last updated
`default_properties_updated_at` | **Datetime**<br>When the default properties were last updated


## Relationships
Sessions have the following relationships:

Name | Description
- | -
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
    "id": "c9eacc91-ba7b-55dd-87c1-3ed67b96eeee",
    "type": "sessions",
    "attributes": {
      "updated_at": "2021-12-30T11:22:59+00:00",
      "company_id": "e2c70c67-c546-418b-a272-e2a2949bd0b3",
      "employee_id": "ad6a593d-3b33-4486-9056-fa9c940a55a7",
      "locations_updated_at": "2021-12-30T11:22:59+00:00",
      "clusters_updated_at": "2021-12-30T11:22:59+00:00",
      "default_properties_updated_at": "2021-12-30T11:22:59+00:00"
    },
    "relationships": {
      "company": {
        "links": {
          "related": "/api/boomerang/companies/current"
        }
      },
      "employee": {
        "links": {
          "related": "/api/boomerang/employees/current"
        }
      },
      "settings": {
        "links": {
          "related": "/api/boomerang/settings/current"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/sessions/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=company,employee,settings`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[sessions]=id,created_at,updated_at`


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
    "id": "c9eacc91-ba7b-55dd-87c1-3ed67b96eeee",
    "type": "sessions",
    "attributes": {
      "updated_at": "2021-12-30T11:22:59+00:00",
      "company_id": "bd80f4e7-0b34-42ed-a34e-f32ca5cbfc7a",
      "employee_id": "997b3d87-1daa-4c23-83e5-f4dedc22cd7d",
      "locations_updated_at": null,
      "clusters_updated_at": null,
      "default_properties_updated_at": null
    },
    "relationships": {
      "company": {
        "links": {
          "related": "/api/boomerang/companies/current"
        },
        "data": {
          "type": "companies",
          "id": "bd80f4e7-0b34-42ed-a34e-f32ca5cbfc7a"
        }
      },
      "employee": {
        "links": {
          "related": "/api/boomerang/employees/current"
        },
        "data": {
          "type": "employees",
          "id": "997b3d87-1daa-4c23-83e5-f4dedc22cd7d"
        }
      },
      "settings": {
        "links": {
          "related": "/api/boomerang/settings/current"
        },
        "data": {
          "type": "settings",
          "id": "4ebd0208-8328-5d69-8c44-ec50939c0967"
        }
      }
    }
  },
  "included": [
    {
      "id": "bd80f4e7-0b34-42ed-a34e-f32ca5cbfc7a",
      "type": "companies",
      "attributes": {
        "created_at": "2021-12-30T11:22:59+00:00",
        "updated_at": "2021-12-30T11:22:59+00:00",
        "name": "Company name 184",
        "slug": "company-name-184",
        "email": "mail187@company.com",
        "billing_email": null,
        "phone": "1-441-998-3504",
        "website": "http://beier-altenwerth.org/deann",
        "address": "Gleichner River\n825 Leannon Road\n94217-2477 New Justinberg\nVirgin Islands, U.S.",
        "address_line_1": "Gleichner River",
        "address_line_2": "825 Leannon Road",
        "zipcode": "94217-2477",
        "city": "New Justinberg",
        "region": null,
        "country": "Virgin Islands, U.S.",
        "use_billing_address": false,
        "billing_company": null,
        "billing_address_line_1": null,
        "billing_address_line_2": null,
        "billing_address_zipcode": null,
        "billing_address_city": null,
        "billing_address_region": null,
        "billing_address_country": null,
        "logo_url": null,
        "default_timezone": "UTC",
        "currency": "usd",
        "financial_line_1": "466 Lin Lodge",
        "financial_line_2": "92373 Walshfurt",
        "vat_number": null,
        "custom_domain": null,
        "development": false,
        "subscription": {
          "trial_ends_at": "2022-01-13T11:22:59.677Z",
          "activated": false,
          "suspended": false,
          "canceled": false,
          "canceled_at": null,
          "on_hold": false,
          "needs_activation": false,
          "legacy": false,
          "product": "Premium",
          "plan_id": "pro_monthly",
          "interval": "month",
          "current_period_end": null,
          "quantity": 1,
          "extra_employees": 0,
          "amount_in_cents": 29900,
          "discount_in_cents": 0,
          "balance_in_cents": 0,
          "coupon": null,
          "strategy": "charge_automatically",
          "source": null,
          "enabled_features": [],
          "allowed_features": [
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
          "restrictions": {
            "employees": 15,
            "email_max_recipients": 500,
            "rate_limit_max": 250,
            "rate_limit_period": 60
          }
        }
      }
    },
    {
      "id": "997b3d87-1daa-4c23-83e5-f4dedc22cd7d",
      "type": "employees",
      "attributes": {
        "created_at": "2021-12-30T11:22:59+00:00",
        "updated_at": "2021-12-30T11:22:59+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "email": "john@doe.com",
        "unconfirmed_email": null,
        "active": true,
        "owner": true,
        "confirmed": true,
        "time_to_confirm": 0,
        "permissions": [
          "reports",
          "products",
          "settings",
          "account",
          "cancel_orders",
          "revert_orders",
          "delete_invoices",
          "make_invoice_revisions"
        ],
        "avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=blank",
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
          "sso_forced": false,
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
          "time_increment": 60,
          "show_product_availability": true,
          "hide_product_availability_quantities": false,
          "show_cart_availability": true,
          "website": null,
          "custom_scripts": "",
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
          "prefix": null
        },
        "quotes": {
          "footer": "",
          "body": "",
          "show_product_photos": true,
          "show_stock_identifiers": false,
          "hide_section_lines": false,
          "prefix": null
        },
        "contracts": {
          "footer": "",
          "body": "",
          "show_product_photos": true,
          "show_stock_identifiers": false,
          "hide_section_lines": false,
          "prefix": null
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=company,employee,settings`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[sessions]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`employee`


`company`


`settings`





