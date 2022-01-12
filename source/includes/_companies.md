# Companies

Every action performed in a Booqable account is scoped to a company; A company holds information and configuration about an account.

## Endpoints
`GET /api/boomerang/companies/current`

`PUT /api/boomerang/companies/current`

## Fields
Every company has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Name of the company
`slug` | **String** `readonly`<br>Company's slug, used in urls
`email` | **String**<br>Used in customer communication, on documents and as the reply-to address for emails that are being sent
`billing_email` | **String**<br>Used to send billing emails to
`phone` | **String**<br>Phone number
`website` | **String**<br>Website
`address` | **String**<br>The full address
`address_line_1` | **String**<br>First address line
`address_line_2` | **String**<br>Second address line
`zipcode` | **String**<br>Zipcode
`city` | **String**<br>City
`region` | **String**<br>Region
`country` | **String**<br>Country
`use_billing_address` | **Boolean**<br>Whether to use billing address on invoices received from Booqable
`billing_company` | **String**<br>Company name (used for invoices received from Booqable)
`billing_address_line_1` | **String**<br>First address line (used for invoices received from Booqable)
`billing_address_line_2` | **String**<br>Second address line (used for invoices received from Booqable)
`billing_address_zipcode` | **String**<br>Zipcode (used for invoices received from Booqable)
`billing_address_city` | **String**<br>City (used for invoices received from Booqable)
`billing_address_region` | **String**<br>Region (used for invoices received from Booqable)
`billing_address_country` | **String**<br>Country (used for invoices received from Booqable)
`logo_url` | **String** `readonly`<br>Url of the uploaded logo
`logo_base64` | **String** `writeonly`<br>To update a logo send it as base64 encoded string
`remove_logo` | **Boolean** `writeonly`<br>Remove current logo
`default_timezone` | **String**<br>Company's default timezone
`currency` | **String**<br>Currency of the company
`financial_line_1` | **String**<br>First extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`financial_line_2` | **String**<br>Second extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`vat_number` | **String**<br>Company's vat number, used in customer communication and to define tax exempts
`custom_domain` | **String**<br>Custom domain to use for hosted store and checkout
`development` | **Boolean** `readonly`<br>Wheter this is a development account
`in_europe` | **Boolean** `extra` `readonly`<br>Whether company is situated in europe
`continent` | **String** `extra` `readonly`<br>Continent the company is situated
`subscription` | **Hash** `extra` `readonly`<br>Details about the subscription
`third_party_id` | **String** `extra` `readonly`<br>ID used for third party tools


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
    "id": "29ddcea8-2381-49f7-b6c4-c3629eeaefd2",
    "type": "companies",
    "attributes": {
      "created_at": "2022-01-12T14:02:36+00:00",
      "updated_at": "2022-01-12T14:02:36+00:00",
      "name": "iRent",
      "slug": "irent",
      "email": "mail49@company.com",
      "billing_email": null,
      "phone": "1-621-618-5549 x52431",
      "website": "http://miller.biz/hermina",
      "address": "Osinski Garden\n969 Dennis Terrace\n46310 Douglaston\nAntigua and Barbuda",
      "address_line_1": "Osinski Garden",
      "address_line_2": "969 Dennis Terrace",
      "zipcode": "46310",
      "city": "Douglaston",
      "region": null,
      "country": "Antigua and Barbuda",
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
      "financial_line_1": "297 Howe Drive",
      "financial_line_2": "64115-4175 Lake Lililand",
      "vat_number": null,
      "custom_domain": null,
      "development": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/companies/current`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[companies]=id,created_at,updated_at`


### Includes

This request does not accept any includes
## Fetching subscription details

The subscription has the following fields:

Name | Description
- | -
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
`amount_in_cents` | **Integer** `readonly`<br>Amount in cents
`discount_in_cents` | **Integer** `readonly`<br>Discount in cents
`balance_in_cents` | **Integer** `readonly`<br>Balance in cents, will be deducted from the next invoice(s)
`coupon` | **String** `readonly`<br>Coupon that's currently active
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
    "id": "4ced24f6-979d-4202-8ce5-59b9b1aa63fd",
    "type": "companies",
    "attributes": {
      "subscription": {
        "trial_ends_at": "2022-01-26T14:02:37.085Z",
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
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/companies/current`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[companies]=id,created_at,updated_at`


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
        "id": "d2f59c03-6577-49ae-b4fc-90794e5e3587",
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
    "id": "d2f59c03-6577-49ae-b4fc-90794e5e3587",
    "type": "companies",
    "attributes": {
      "created_at": "2022-01-12T14:02:37+00:00",
      "updated_at": "2022-01-12T14:02:37+00:00",
      "name": "iRent LLC",
      "slug": "irent",
      "email": "mail51@company.com",
      "billing_email": null,
      "phone": "(786) 681-6367",
      "website": "http://sawayn.co/clay",
      "address": "King Bridge\n631 Chauncey Radial\n95689 Parisianfort\nSyrian Arab Republic",
      "address_line_1": "King Bridge",
      "address_line_2": "631 Chauncey Radial",
      "zipcode": "95689",
      "city": "Parisianfort",
      "region": null,
      "country": "Syrian Arab Republic",
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
      "financial_line_1": "5671 Nolan Cliffs",
      "financial_line_2": "97765 New Randellport",
      "vat_number": null,
      "custom_domain": null,
      "development": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/companies/current`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[companies]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the company
`data[attributes][email]` | **String**<br>Used in customer communication, on documents and as the reply-to address for emails that are being sent
`data[attributes][billing_email]` | **String**<br>Used to send billing emails to
`data[attributes][phone]` | **String**<br>Phone number
`data[attributes][website]` | **String**<br>Website
`data[attributes][address]` | **String**<br>The full address
`data[attributes][address_line_1]` | **String**<br>First address line
`data[attributes][address_line_2]` | **String**<br>Second address line
`data[attributes][zipcode]` | **String**<br>Zipcode
`data[attributes][city]` | **String**<br>City
`data[attributes][region]` | **String**<br>Region
`data[attributes][country]` | **String**<br>Country
`data[attributes][use_billing_address]` | **Boolean**<br>Whether to use billing address on invoices received from Booqable
`data[attributes][billing_company]` | **String**<br>Company name (used for invoices received from Booqable)
`data[attributes][billing_address_line_1]` | **String**<br>First address line (used for invoices received from Booqable)
`data[attributes][billing_address_line_2]` | **String**<br>Second address line (used for invoices received from Booqable)
`data[attributes][billing_address_zipcode]` | **String**<br>Zipcode (used for invoices received from Booqable)
`data[attributes][billing_address_city]` | **String**<br>City (used for invoices received from Booqable)
`data[attributes][billing_address_region]` | **String**<br>Region (used for invoices received from Booqable)
`data[attributes][billing_address_country]` | **String**<br>Country (used for invoices received from Booqable)
`data[attributes][logo_base64]` | **String**<br>To update a logo send it as base64 encoded string
`data[attributes][remove_logo]` | **Boolean**<br>Remove current logo
`data[attributes][default_timezone]` | **String**<br>Company's default timezone
`data[attributes][currency]` | **String**<br>Currency of the company
`data[attributes][financial_line_1]` | **String**<br>First extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`data[attributes][financial_line_2]` | **String**<br>Second extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`data[attributes][vat_number]` | **String**<br>Company's vat number, used in customer communication and to define tax exempts
`data[attributes][custom_domain]` | **String**<br>Custom domain to use for hosted store and checkout


### Includes

This request does not accept any includes