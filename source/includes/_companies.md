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
`currency` | **String**<br>Currency of the company
`financial_line_1` | **String**<br>First extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`financial_line_2` | **String**<br>Second extra financial information line (line bank account) used in customer communication, on documents and as the reply-to address for emails that are being sent
`vat_number` | **String**<br>Company's vat number, used in customer communication and to define tax exempts
`continent` | **String** `readonly`<br>Continent the company is situated
`custom_domain` | **String**<br>Custom domain to use for hosted store and checkout
`development` | **Boolean** `readonly`<br>Wheter this is a development account
`in_europe` | **Boolean** `extra` `readonly`<br>Whether company is situated in europe
`trial_ends_at` | **Datetime** `extra` `readonly`<br>When the trial ends
`activated` | **Boolean** `extra` `readonly`<br>Whether company has an active subscription
`suspended` | **Boolean** `extra` `readonly`<br>Whether company is suspended
`canceled` | **Boolean** `extra` `readonly`<br>Whether subscription is canceled
`canceled_at` | **Datetime** `extra` `readonly`<br>When the subscription will be or was canceled
`on_hold` | **Boolean** `extra` `readonly`<br>Whether account is on-hold
`needs_activation` | **Boolean** `extra` `readonly`<br>Whether account needs to activate a subscription


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
    "id": "d793de09-f90a-4ef8-aa64-d1c1f3d5e4d1",
    "type": "companies",
    "attributes": {
      "created_at": "2021-11-23T12:47:59+00:00",
      "updated_at": "2021-11-23T12:47:59+00:00",
      "name": "iRent",
      "slug": "irent",
      "email": "mail46@company.com",
      "billing_email": null,
      "phone": "366.056.4016 x43627",
      "website": "http://ryan-hills.info/demetria",
      "address": "Kuhic Freeway\n602 Legros Vista\n86448-0998 Goldnerville\nBarbados",
      "address_line_1": "Kuhic Freeway",
      "address_line_2": "602 Legros Vista",
      "zipcode": "86448-0998",
      "city": "Goldnerville",
      "region": null,
      "country": "Barbados",
      "billing_company": null,
      "billing_address_line_1": null,
      "billing_address_line_2": null,
      "billing_address_zipcode": null,
      "billing_address_city": null,
      "billing_address_region": null,
      "billing_address_country": null,
      "logo_url": null,
      "timezone": "UTC",
      "currency": "usd",
      "financial_line_1": "8213 Artie Trafficway",
      "financial_line_2": "19173 Kilbackmouth",
      "vat_number": null,
      "continent": "Americas",
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
## Updating a company



> How to update a company:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/companies/current' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "73de6b8a-aff9-4091-8654-8715a70f3705",
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
    "id": "73de6b8a-aff9-4091-8654-8715a70f3705",
    "type": "companies",
    "attributes": {
      "created_at": "2021-11-23T12:47:59+00:00",
      "updated_at": "2021-11-23T12:47:59+00:00",
      "name": "iRent LLC",
      "slug": "irent",
      "email": "mail47@company.com",
      "billing_email": null,
      "phone": "274.465.7513",
      "website": "http://kertzmann.org/gregory",
      "address": "Roob Walks\n2082 Aufderhar Station\n14687 New Marget\nTimor-Leste",
      "address_line_1": "Roob Walks",
      "address_line_2": "2082 Aufderhar Station",
      "zipcode": "14687",
      "city": "New Marget",
      "region": null,
      "country": "Timor-Leste",
      "billing_company": null,
      "billing_address_line_1": null,
      "billing_address_line_2": null,
      "billing_address_zipcode": null,
      "billing_address_city": null,
      "billing_address_region": null,
      "billing_address_country": null,
      "logo_url": null,
      "timezone": "UTC",
      "currency": "usd",
      "financial_line_1": "6392 Duncan Tunnel",
      "financial_line_2": "31151 Linoview",
      "vat_number": null,
      "continent": "Asia",
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