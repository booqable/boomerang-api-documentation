# Companies

The company

## Endpoints
`GET /api/boomerang/companies/{id}`

`PUT /api/boomerang/companies/{id}`

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
`billing_company` | **String**<br>Company name (used for invoices received from Booqable)
`billing_address_line_1` | **String**<br>First address line (used for invoices received from Booqable)
`billing_address_line_2` | **String**<br>Second address line (used for invoices received from Booqable)
`billing_address_zipcode` | **String**<br>Zipcode (used for invoices received from Booqable)
`billing_address_city` | **String**<br>City (used for invoices received from Booqable)
`billing_address_region` | **String**<br>Region (used for invoices received from Booqable)
`billing_address_country` | **String**<br>Country (used for invoices received from Booqable)
`logo_url` | **String** `readonly`<br>Url of the uploaded logo
`logo_base64` | **String** `writeonly`<br>To update a logo send it as base64 encoded string
`timezone` | **String**<br>Company's timezone
`timezone_offset` | **String** `readonly`<br>The timezone offset in seconds
`currency` | **String**<br>Currency of the company
`financial_line_1` | **String**<br>First extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`financial_line_2` | **String**<br>Second extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`vat_number` | **String**<br>Company's vat number, used in customer communication and to define tax exempts
`continent` | **String** `readonly`<br>Continent the company is situated
`trial_ends_at` | **Datetime** `readonly`<br>When the trial ends
`activated` | **Boolean** `readonly`<br>Whether company has an active subscription
`suspended` | **Boolean** `readonly`<br>Whether company is suspended
`canceled` | **Boolean** `readonly`<br>Whether subscription is canceled
`canceled_at` | **Datetime** `readonly`<br>When the subscription will be or was canceled
`on_hold` | **Boolean** `readonly`<br>Whether account is on-hold
`needs_activation` | **Boolean** `readonly`<br>Whether account needs to activate a subscription
`market` | **String** `readonly`<br>The market the company operates in
`custom_domain` | **String**<br>Custom domain to use for hosted store and checkout
`development` | **Boolean** `readonly`<br>Wheter this is a development account
`tenant_token` | **String** `readonly`<br>Token
`in_europe` | **Boolean** `readonly`<br>Whether company is situated in europe
`trial_extension_count` | **Integer** `readonly`<br>Amount of times the trial was extended


## Fetching a company

> How to fetch a companies:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/companies/eba61369-f9ee-4911-b7b5-3a473f94c34d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eba61369-f9ee-4911-b7b5-3a473f94c34d",
    "created_at": "2021-10-08T11:26:49+00:00",
    "updated_at": "2021-10-08T11:26:49+00:00",
    "name": "iRent",
    "slug": "irent",
    "email": "mail1@company.com",
    "billing_email": null,
    "phone": "779.445.7519",
    "website": "http://hintz.name/fausto.wehner",
    "address": "Braun Mall\n9999 Thompson Brook\n06748-4911 Rexfort\nTanzania",
    "address_line_1": "Braun Mall",
    "address_line_2": "9999 Thompson Brook",
    "zipcode": "06748-4911",
    "city": "Rexfort",
    "region": null,
    "country": "Tanzania",
    "billing_company": null,
    "billing_address_line_1": null,
    "billing_address_line_2": null,
    "billing_address_zipcode": null,
    "billing_address_city": null,
    "billing_address_region": null,
    "billing_address_country": null,
    "logo_url": null,
    "timezone": "UTC",
    "timezone_offset": "0",
    "currency": "usd",
    "financial_line_1": "585 Kling Keys",
    "financial_line_2": "23041 Raymundofort",
    "vat_number": null,
    "continent": "Africa",
    "trial_ends_at": "2021-10-22T11:26:48+00:00",
    "activated": false,
    "suspended": false,
    "canceled": false,
    "canceled_at": null,
    "on_hold": false,
    "needs_activation": false,
    "market": null,
    "custom_domain": null,
    "development": false
  }
}
```


### HTTP Request

`GET /api/boomerang/companies/{id}`

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
    --url 'https://example.booqable.com/api/boomerang/companies/785c59c2-f922-4aa0-ba3c-5e104008af5e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "785c59c2-f922-4aa0-ba3c-5e104008af5e",
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
    "id": "785c59c2-f922-4aa0-ba3c-5e104008af5e",
    "type": "companies",
    "attributes": {
      "created_at": "2021-10-08T11:26:50+00:00",
      "updated_at": "2021-10-08T11:26:51+00:00",
      "name": "iRent LLC",
      "slug": "irent",
      "email": "mail2@company.com",
      "billing_email": null,
      "phone": "714.839.1379 x47085",
      "website": "http://lockman-oconner.org/kandis.wuckert",
      "address": "Despina Course\n4716 Latina Corners\n60528-8760 Langoshland\nCosta Rica",
      "address_line_1": "Despina Course",
      "address_line_2": "4716 Latina Corners",
      "zipcode": "60528-8760",
      "city": "Langoshland",
      "region": null,
      "country": "Costa Rica",
      "billing_company": null,
      "billing_address_line_1": null,
      "billing_address_line_2": null,
      "billing_address_zipcode": null,
      "billing_address_city": null,
      "billing_address_region": null,
      "billing_address_country": null,
      "logo_url": null,
      "timezone": "UTC",
      "timezone_offset": "0",
      "currency": "usd",
      "financial_line_1": "2393 Walter Roads",
      "financial_line_2": "77477 Lake Kelvinberg",
      "vat_number": null,
      "continent": "Americas",
      "trial_ends_at": "2021-10-22T11:26:50+00:00",
      "activated": false,
      "suspended": false,
      "canceled": false,
      "canceled_at": null,
      "on_hold": false,
      "needs_activation": false,
      "market": null,
      "custom_domain": null,
      "development": false
    }
  },
  "meta": {}
}
```


### HTTP Request

`PUT /api/boomerang/companies/{id}`

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
`data[attributes][billing_company]` | **String**<br>Company name (used for invoices received from Booqable)
`data[attributes][billing_address_line_1]` | **String**<br>First address line (used for invoices received from Booqable)
`data[attributes][billing_address_line_2]` | **String**<br>Second address line (used for invoices received from Booqable)
`data[attributes][billing_address_zipcode]` | **String**<br>Zipcode (used for invoices received from Booqable)
`data[attributes][billing_address_city]` | **String**<br>City (used for invoices received from Booqable)
`data[attributes][billing_address_region]` | **String**<br>Region (used for invoices received from Booqable)
`data[attributes][billing_address_country]` | **String**<br>Country (used for invoices received from Booqable)
`data[attributes][logo_base64]` | **String**<br>To update a logo send it as base64 encoded string
`data[attributes][timezone]` | **String**<br>Company's timezone
`data[attributes][currency]` | **String**<br>Currency of the company
`data[attributes][financial_line_1]` | **String**<br>First extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`data[attributes][financial_line_2]` | **String**<br>Second extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`data[attributes][vat_number]` | **String**<br>Company's vat number, used in customer communication and to define tax exempts
`data[attributes][custom_domain]` | **String**<br>Custom domain to use for hosted store and checkout


### Includes

This request does not accept any includes