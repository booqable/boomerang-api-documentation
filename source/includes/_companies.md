# Companies

Every action performed in a Booqable account is scoped to a company.
A company holds information and configuration about an account.

## Fields

 Name | Description
-- | --
`address` | **string** `readonly`<br>The full address. 
`address_line_1` | **string** <br>First address line. 
`address_line_2` | **string** <br>Second address line. 
`billing_address` | **hash** `readonly`<br>A hash with the company billing address fields. Use it when fetching the company. See `address` property type for more information. 
`billing_address_attributes` | **hash** `writeonly`<br>A hash with the company billing address fields. Use it when updating the company billing address. See `address` property type for more information. 
`billing_address_city` | **string** <br>City (used for invoices received from Booqable). 
`billing_address_country` | **string** <br>Country (used for invoices received from Booqable). 
`billing_address_line_1` | **string** <br>First address line (used for invoices received from Booqable). 
`billing_address_line_2` | **string** <br>Second address line (used for invoices received from Booqable). 
`billing_address_region` | **string** <br>Region (used for invoices received from Booqable). 
`billing_address_zipcode` | **string** <br>Zipcode (used for invoices received from Booqable). 
`billing_company` | **string** <br>Company name (used for invoices received from Booqable). 
`billing_email` | **string** <br>Used to send billing emails to. 
`city` | **string** <br>City. 
`continent` | **string** `readonly`<br>Continent the company is situated. 
`country` | **string** <br>Country. 
`country_code` | **string** <br>Two-letter country code (ISO 3166-1 alpha-2). 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`currency` | **string** <br>Currency of the company. 
`custom_domain` | **string** <br>Custom domain to use for hosted store and checkout. 
`custom_domain_validation` | **hash** <br>Validation details for the custom domain. 
`default_timezone` | **string** <br>Company's default timezone. 
`development` | **boolean** `readonly`<br>Whether this is a development account. 
`email` | **string** <br>Used in customer communication, on documents and as the reply-to address for emails that are being sent. 
`favicon_base64` | **string** `writeonly`<br>To upload a favicon send it as a base64 encoded string. 
`favicon_url` | **string** `readonly`<br>Company favicon URL. 
`financial_line_1` | **string** <br>First extra financial information line (like bank account) used in customer communication, on documents, and as the reply-to address for emails that are being sent. 
`financial_line_2` | **string** <br>Second extra financial information line (like bank account) used in customer communication, on documents, and as the reply-to address for emails that are being sent. 
`id` | **uuid** `readonly`<br>Primary key.
`in_europe` | **boolean** `readonly`<br>Whether company is situated in Europe. 
`installed_online_store` | **boolean** `readonly`<br>If the online store is installed, this boolean will return true. 
`logo_base64` | **string** `writeonly`<br>To update a logo send it as base64 encoded string. 
`logo_url` | **string** `readonly`<br>URL of the uploaded logo. 
`main_address` | **hash** `readonly`<br>A hash with the company main address fields. Use it when fetching the company. See `address` property type for more information. 
`main_address_attributes` | **hash** `writeonly`<br>A hash with the company main address fields. Use it when updating the company main address. See `address` property type for more information. 
`market` | **string** <br>The market the company operates in. 
`medium` | **string** `readonly`<br>UTM medium present during signup. 
`name` | **string** <br>Name of the company. 
`pending_subscription` | **boolean** `readonly`<br>Whether the company has a pending subscription. 
`phone` | **string** <br>Phone number. 
`region` | **string** <br>Region. 
`remove_favicon` | **boolean** `writeonly`<br>Remove current favicon. 
`remove_logo` | **boolean** `writeonly`<br>Remove current logo. 
`revenue_last_year` | **string** `readonly`<br>Revenue last year given during signup. 
`shop_theme_id` | **uuid** <br>ID of installed shop theme. 
`slug` | **string** `readonly`<br>Company's slug, the part of the domain name before `booqable.com`. 
`source` | **string** `readonly`<br>UTM source present during signup. 
`subscription` | **hash** `readonly` `extra`<br>Details about the subscription. 
`team_size` | **string** `readonly`<br>Team size given during signup. 
`tenant_token` | **string** `readonly`<br>Token. 
`third_party_id` | **string** <br>ID used for third party tools. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`use_billing_address` | **boolean** <br>Whether to use billing address on invoices received from Booqable. 
`vat_number` | **string** <br>Company's VAT number, used in customer communication and to define tax exempts. 
`website` | **string** <br>Website. 
`year_business_start` | **string** `readonly`<br>Year when company started, given during signup. 
`zipcode` | **string** <br>Zipcode. 


## Fetch a company


> How to fetch a company:

```shell
  curl --get 'https://example.booqable.com/api/4/companies/current'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "9391cc27-0209-4fb5-8077-0e7af94f571d",
      "type": "companies",
      "attributes": {
        "created_at": "2025-12-03T02:00:00.000000+00:00",
        "updated_at": "2025-12-03T02:00:00.000000+00:00",
        "name": "iRent",
        "slug": "irent",
        "email": "mail60@company.com",
        "billing_email": null,
        "phone": null,
        "website": "www.booqable.com",
        "address_line_1": "Blokhuispoort",
        "address_line_2": "Leeuwarden",
        "zipcode": "8900AB",
        "city": "Leeuwarden",
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
        "tenant_token": "e08844f444c33fcafbe78fef211e194c",
        "pending_subscription": false,
        "team_size": null,
        "revenue_last_year": null,
        "year_business_start": null,
        "address": "Blokhuispoort\nLeeuwarden\n8900AB Leeuwarden\nNetherlands",
        "main_address": {
          "meets_validation_requirements": false,
          "first_name": null,
          "last_name": null,
          "address1": "Blokhuispoort",
          "address2": "Leeuwarden",
          "city": "Leeuwarden",
          "region": null,
          "zipcode": "8900AB",
          "country": "Netherlands",
          "country_id": null,
          "province_id": null,
          "latitude": "52.521918",
          "longitude": "13.413215",
          "value": "Blokhuispoort\nLeeuwarden\n8900AB Leeuwarden\nNetherlands"
        },
        "billing_address": null,
        "third_party_id": "9391cc27-0209-4fb5-8077-0e7af94f571d"
      }
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/companies/current`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[companies]=subscription`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[companies]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Fetch subscription details

The subscription has the following fields:

Name | Description
-- | --
`trial_ends_at` | **Datetime** `readonly`<br>When the trial ends
`activated` | **Boolean** `readonly`<br>Whether subscription is active
`suspended` | **Boolean** `readonly`<br>Whether account is suspended
`canceled` | **Boolean** `readonly`<br>Whether subscription is canceled
`canceled_at` | **Datetime** `readonly`<br>When the subscription is canceled (can also be in the future)
`on_hold` | **Boolean** `readonly`<br>Whether account is on-hold
`needs_activation` | **Boolean** `readonly`<br>Whether account needs to activate a subscription
`legacy` | **Datetime** `readonly`<br>Whether it's a legacy subscription
`product` | **String** `readonly`<br>Which product is active, one of `Essential`, `Pro`, `Premium`, `Legacy`
`plan_id` | **String** `readonly`<br>ID of the product (used internally by Booqable)
`interval` | **String** `readonly`<br>Billing interval, one of `month`, `year`
`current_period_end` | **Datetime** `readonly`<br>When the current billing period ends
`quantity` | **Integer** `readonly`<br>Quantity of the subscription (used for legacy subscriptions to buy seats)
`extra_employees` | **Integer** `readonly`<br>Extra employees billed for
`extra_locations` | **Integer** `readonly`<br>Extra locations billed for
`amount_in_cents` | **Integer** `readonly`<br>Amount in cents
`discount_in_cents` | **Integer** `readonly`<br>Discount in cents
`balance_in_cents` | **Integer** `readonly`<br>Balance in cents, will be deducted from the next invoice(s)
`coupon` | **String** `readonly`<br>Coupon that's currently active
`coupon_percent_off` | **String*** readonly <br/>Percentage of discount on the current active coupon
`coupon_duration` | **String*** readonly <br/>Duration type of the current active coupon, one of `forever`, `once`, `repeating`
`coupon_duration_in_months` | **String*** readonly <br/>Amount of months the coupon is active. Only present when coupon duration is `repeating`.
`strategy` | **String** `readonly`<br>Billing strategy, one of `send_invoice`, `charge_automatically`
`source` | **Hash** `readonly`<br>Information about the payment source
`enabled_features` | **Hash** `readonly`<br>Beta features that are currently enabled
`allowed_features` | **Hash** `readonly`<br>List of allowed features for plan
`restrictions` | **Hash** `readonly`<br>Restrictions applied to this account

> How to fetch details about the company its subscription:

```shell
  curl --get 'https://example.booqable.com/api/4/companies/current'
       --header 'content-type: application/json'
       --data-urlencode 'extra_fields[companies]=subscription'
       --data-urlencode 'fields[companies]=subscription'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "b962f1eb-9fbc-42f9-81ac-a12d0b5a2174",
      "type": "companies",
      "attributes": {
        "subscription": {
          "trial_ends_at": "2019-05-03T10:16:00.000000+00:00",
          "activated": false,
          "active_subscription": false,
          "suspended": false,
          "canceled": false,
          "canceled_at": null,
          "on_hold": false,
          "product": "Premium",
          "expiring": false,
          "plan_id": null,
          "interval": "month",
          "current_period_end": null,
          "extra_employees": 0,
          "extra_employees_left": 4,
          "extra_locations": 0,
          "addons": [],
          "checkout_settings": {},
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
            "online_bookings",
            "advanced_pricing",
            "api",
            "custom_domain",
            "sales_items",
            "bundles",
            "buffer_times",
            "prevent_last_minute_reservations",
            "packing_slips",
            "notes",
            "revenue_report",
            "manual_email_templates",
            "product_shortage_limits",
            "product_history",
            "away_mode",
            "customer_discount_percentage",
            "mobile_app",
            "product_security_deposit",
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
            "employees": 5,
            "email_max_recipients": 20,
            "rate_limit_max": 50,
            "rate_limit_period": 60,
            "locations": 1,
            "allow_extra_locations": true,
            "allow_extra_employees": false,
            "manual_email_templates": null,
            "custom_fields": null,
            "tags": null
          }
        }
      }
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/companies/current`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[companies]=subscription`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[companies]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Update a company


> How to update a company:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/companies/current'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "39b6d9bd-03cc-4869-8a7a-9e3ca8f59712",
           "type": "companies",
           "attributes": {
             "name": "iRent LLC"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "39b6d9bd-03cc-4869-8a7a-9e3ca8f59712",
      "type": "companies",
      "attributes": {
        "created_at": "2020-02-19T10:28:01.000000+00:00",
        "updated_at": "2020-02-19T10:28:01.000000+00:00",
        "name": "iRent LLC",
        "slug": "irent",
        "email": "mail62@company.com",
        "billing_email": null,
        "phone": null,
        "website": "www.booqable.com",
        "address_line_1": "Blokhuispoort",
        "address_line_2": "Leeuwarden",
        "zipcode": "8900AB",
        "city": "Leeuwarden",
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
        "tenant_token": "7a1067c6345a05d4627e8ec7bdeadbe6",
        "pending_subscription": false,
        "team_size": null,
        "revenue_last_year": null,
        "year_business_start": null,
        "address": "Blokhuispoort\nLeeuwarden\n8900AB Leeuwarden\nNetherlands",
        "main_address": {
          "meets_validation_requirements": false,
          "first_name": null,
          "last_name": null,
          "address1": "Blokhuispoort",
          "address2": "Leeuwarden",
          "city": "Leeuwarden",
          "region": null,
          "zipcode": "8900AB",
          "country": "Netherlands",
          "country_id": null,
          "province_id": null,
          "latitude": "52.521918",
          "longitude": "13.413215",
          "value": "Blokhuispoort\nLeeuwarden\n8900AB Leeuwarden\nNetherlands"
        },
        "billing_address": null,
        "third_party_id": "39b6d9bd-03cc-4869-8a7a-9e3ca8f59712"
      }
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/companies/current`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[companies]=subscription`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[companies]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][address_line_1]` | **string** <br>First address line. 
`data[attributes][address_line_2]` | **string** <br>Second address line. 
`data[attributes][billing_address_attributes]` | **hash** <br>A hash with the company billing address fields. Use it when updating the company billing address. See `address` property type for more information. 
`data[attributes][billing_address_city]` | **string** <br>City (used for invoices received from Booqable). 
`data[attributes][billing_address_country]` | **string** <br>Country (used for invoices received from Booqable). 
`data[attributes][billing_address_line_1]` | **string** <br>First address line (used for invoices received from Booqable). 
`data[attributes][billing_address_line_2]` | **string** <br>Second address line (used for invoices received from Booqable). 
`data[attributes][billing_address_region]` | **string** <br>Region (used for invoices received from Booqable). 
`data[attributes][billing_address_zipcode]` | **string** <br>Zipcode (used for invoices received from Booqable). 
`data[attributes][billing_company]` | **string** <br>Company name (used for invoices received from Booqable). 
`data[attributes][billing_email]` | **string** <br>Used to send billing emails to. 
`data[attributes][city]` | **string** <br>City. 
`data[attributes][country]` | **string** <br>Country. 
`data[attributes][country_code]` | **string** <br>Two-letter country code (ISO 3166-1 alpha-2). 
`data[attributes][currency]` | **string** <br>Currency of the company. 
`data[attributes][custom_domain]` | **string** <br>Custom domain to use for hosted store and checkout. 
`data[attributes][custom_domain_validation]` | **hash** <br>Validation details for the custom domain. 
`data[attributes][default_timezone]` | **string** <br>Company's default timezone. 
`data[attributes][email]` | **string** <br>Used in customer communication, on documents and as the reply-to address for emails that are being sent. 
`data[attributes][favicon_base64]` | **string** <br>To upload a favicon send it as a base64 encoded string. 
`data[attributes][financial_line_1]` | **string** <br>First extra financial information line (like bank account) used in customer communication, on documents, and as the reply-to address for emails that are being sent. 
`data[attributes][financial_line_2]` | **string** <br>Second extra financial information line (like bank account) used in customer communication, on documents, and as the reply-to address for emails that are being sent. 
`data[attributes][logo_base64]` | **string** <br>To update a logo send it as base64 encoded string. 
`data[attributes][main_address_attributes]` | **hash** <br>A hash with the company main address fields. Use it when updating the company main address. See `address` property type for more information. 
`data[attributes][market]` | **string** <br>The market the company operates in. 
`data[attributes][name]` | **string** <br>Name of the company. 
`data[attributes][phone]` | **string** <br>Phone number. 
`data[attributes][region]` | **string** <br>Region. 
`data[attributes][remove_favicon]` | **boolean** <br>Remove current favicon. 
`data[attributes][remove_logo]` | **boolean** <br>Remove current logo. 
`data[attributes][shop_theme_id]` | **uuid** <br>ID of installed shop theme. 
`data[attributes][third_party_id]` | **string** <br>ID used for third party tools. 
`data[attributes][use_billing_address]` | **boolean** <br>Whether to use billing address on invoices received from Booqable. 
`data[attributes][vat_number]` | **string** <br>Company's VAT number, used in customer communication and to define tax exempts. 
`data[attributes][website]` | **string** <br>Website. 
`data[attributes][zipcode]` | **string** <br>Zipcode. 


### Includes

This request does not accept any includes