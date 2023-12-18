# Companies

Every action performed in a Booqable account is scoped to a company; A company holds information and configuration about an account.

## Endpoints
`GET /api/boomerang/companies/current`

`PUT /api/boomerang/companies/current`

## Fields
Every company has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the company
`slug` | **String** `readonly`<br>Company's slug, used in urls
`email` | **String** <br>Used in customer communication, on documents and as the reply-to address for emails that are being sent
`billing_email` | **String** <br>Used to send billing emails to
`phone` | **String** <br>Phone number
`website` | **String** <br>Website
`address` | **String** <br>The full address
`address_line_1` | **String** <br>First address line
`address_line_2` | **String** <br>Second address line
`zipcode` | **String** <br>Zipcode
`city` | **String** <br>City
`region` | **String** <br>Region
`country` | **String** <br>Country
`use_billing_address` | **Boolean** <br>Whether to use billing address on invoices received from Booqable
`billing_company` | **String** <br>Company name (used for invoices received from Booqable)
`billing_address_line_1` | **String** <br>First address line (used for invoices received from Booqable)
`billing_address_line_2` | **String** <br>Second address line (used for invoices received from Booqable)
`billing_address_zipcode` | **String** <br>Zipcode (used for invoices received from Booqable)
`billing_address_city` | **String** <br>City (used for invoices received from Booqable)
`billing_address_region` | **String** <br>Region (used for invoices received from Booqable)
`billing_address_country` | **String** <br>Country (used for invoices received from Booqable)
`logo_url` | **String** `readonly`<br>Url of the uploaded logo
`logo_base64` | **String** `writeonly`<br>To update a logo send it as base64 encoded string
`remove_logo` | **Boolean** `writeonly`<br>Remove current logo
`favicon_url` | **String** `readonly`<br>Company favicon url
`favicon_base64` | **String** `writeonly`<br>To upload a favicon send it as a base64 encoded string
`remove_favicon` | **Boolean** `writeonly`<br>Remove current favicon
`default_timezone` | **String** <br>Company's default timezone
`currency` | **String** <br>Currency of the company
`financial_line_1` | **String** <br>First extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`financial_line_2` | **String** <br>Second extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`vat_number` | **String** <br>Company's vat number, used in customer communication and to define tax exempts
`custom_domain` | **String** <br>Custom domain to use for hosted store and checkout
`development` | **Boolean** `readonly`<br>Whether this is a development account
`shop_theme_id` | **Uuid** <br>ID of installed shop theme
`years_active` | **String** `readonly`<br>The amount of active years, given during signup
`source` | **String** `readonly`<br>UTM source present during signup
`medium` | **String** `readonly`<br>UTM medium present during signup
`tenant_token` | **String** `readonly`<br>Token
`pending_subscription` | **Boolean** `readonly`<br>Whether the company has a pending subscription
`in_europe` | **Boolean** `readonly`<br>Whether company is situated in europe
`continent` | **String** `readonly`<br>Continent the company is situated
`subscription` | **Hash** `readonly`<br>Details about the subscription
`third_party_id` | **String** `readonly`<br>ID used for third party tools


## Fetching a company



> How to fetch a companies:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/companies/current' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4662597e-c0bc-4293-b61a-171d314cd3ac",
    "type": "companies",
    "attributes": {
      "created_at": "2023-12-18T09:17:56+00:00",
      "updated_at": "2023-12-18T09:17:56+00:00",
      "name": "iRent",
      "slug": "irent",
      "email": "mail146@company.com",
      "billing_email": null,
      "phone": "0581234567",
      "website": "www.booqable.com",
      "address": "Blokhuispoort\nLeeuwarden\n8900AB Leeuwarden\nthe Netherlands",
      "address_line_1": "Blokhuispoort",
      "address_line_2": "Leeuwarden",
      "zipcode": "8900AB",
      "city": "Leeuwarden",
      "region": null,
      "country": "the Netherlands",
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
      "years_active": null,
      "source": null,
      "medium": null,
      "tenant_token": "e0d159744ae1d963c814e623924be0aa",
      "pending_subscription": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/companies/current`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[companies]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Updating a company



> How to update a company:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/companies/current' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "def4b3c6-78f7-4bce-82ee-bccc830292e3",
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
    "id": "def4b3c6-78f7-4bce-82ee-bccc830292e3",
    "type": "companies",
    "attributes": {
      "created_at": "2023-12-18T09:17:57+00:00",
      "updated_at": "2023-12-18T09:17:57+00:00",
      "name": "iRent LLC",
      "slug": "irent",
      "email": "mail147@company.com",
      "billing_email": null,
      "phone": "0581234567",
      "website": "www.booqable.com",
      "address": "Blokhuispoort\nLeeuwarden\n8900AB Leeuwarden\nthe Netherlands",
      "address_line_1": "Blokhuispoort",
      "address_line_2": "Leeuwarden",
      "zipcode": "8900AB",
      "city": "Leeuwarden",
      "region": null,
      "country": "the Netherlands",
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
      "years_active": null,
      "source": null,
      "medium": null,
      "tenant_token": "24a88b135ae11d7afd0d459baf9c7e43",
      "pending_subscription": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/companies/current`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[companies]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the company
`data[attributes][email]` | **String** <br>Used in customer communication, on documents and as the reply-to address for emails that are being sent
`data[attributes][billing_email]` | **String** <br>Used to send billing emails to
`data[attributes][phone]` | **String** <br>Phone number
`data[attributes][website]` | **String** <br>Website
`data[attributes][address]` | **String** <br>The full address
`data[attributes][address_line_1]` | **String** <br>First address line
`data[attributes][address_line_2]` | **String** <br>Second address line
`data[attributes][zipcode]` | **String** <br>Zipcode
`data[attributes][city]` | **String** <br>City
`data[attributes][region]` | **String** <br>Region
`data[attributes][country]` | **String** <br>Country
`data[attributes][use_billing_address]` | **Boolean** <br>Whether to use billing address on invoices received from Booqable
`data[attributes][billing_company]` | **String** <br>Company name (used for invoices received from Booqable)
`data[attributes][billing_address_line_1]` | **String** <br>First address line (used for invoices received from Booqable)
`data[attributes][billing_address_line_2]` | **String** <br>Second address line (used for invoices received from Booqable)
`data[attributes][billing_address_zipcode]` | **String** <br>Zipcode (used for invoices received from Booqable)
`data[attributes][billing_address_city]` | **String** <br>City (used for invoices received from Booqable)
`data[attributes][billing_address_region]` | **String** <br>Region (used for invoices received from Booqable)
`data[attributes][billing_address_country]` | **String** <br>Country (used for invoices received from Booqable)
`data[attributes][logo_base64]` | **String** <br>To update a logo send it as base64 encoded string
`data[attributes][remove_logo]` | **Boolean** <br>Remove current logo
`data[attributes][favicon_base64]` | **String** <br>To upload a favicon send it as a base64 encoded string
`data[attributes][remove_favicon]` | **Boolean** <br>Remove current favicon
`data[attributes][default_timezone]` | **String** <br>Company's default timezone
`data[attributes][currency]` | **String** <br>Currency of the company
`data[attributes][financial_line_1]` | **String** <br>First extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`data[attributes][financial_line_2]` | **String** <br>Second extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`data[attributes][vat_number]` | **String** <br>Company's vat number, used in customer communication and to define tax exempts
`data[attributes][custom_domain]` | **String** <br>Custom domain to use for hosted store and checkout
`data[attributes][shop_theme_id]` | **Uuid** <br>ID of installed shop theme


### Includes

This request does not accept any includes
## Fetching subscription details

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
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/companies/current?extra_fields%5Bcompanies%5D=subscription&fields%5Bcompanies%5D=subscription' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "07a43376-f8f5-4428-8e71-830459f2249f",
    "type": "companies",
    "attributes": {
      "subscription": {
        "trial_ends_at": "2024-01-01T09:17:59.117Z",
        "activated": false,
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
          "email_max_recipients": 1000,
          "rate_limit_max": 250,
          "rate_limit_period": 60,
          "locations": 3
        },
        "can_try_plan": true
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/companies/current`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[companies]=created_at,updated_at,name`


### Includes

This request does not accept any includes