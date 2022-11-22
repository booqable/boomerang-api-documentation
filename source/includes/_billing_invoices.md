# Billing invoices

Invoices received from Booqable

## Endpoints
`GET /api/boomerang/billing_invoices`

`GET /api/boomerang/billing_invoices/{id}`

## Fields
Every billing invoice has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`number` | **Integer** `readonly`<br>Unique number
`status` | **String** `readonly`<br>One of `refunded`, `credit`, `paid`, `forgiven`, `voided`, `overdue`, `open`
`billing_reason` | **String** `readonly`<br>One of `subscription`, `manual`, `subscription_cycle`, `refund`, `uncollectible`, `subscription_update`, `subscription_create`
`strategy` | **String** `readonly`<br>One of `send_invoice`, `charge_automatically`
`date` | **Date** `readonly`<br>Invoice date
`period_start_at` | **Date** `readonly`<br>Period start date
`period_end_at` | **Date** `readonly`<br>Period end date
`subtotal_in_cents` | **Integer** `readonly`<br>Subtotal in cents (without discount and taxes)
`total_in_cents` | **Integer** `readonly`<br>Total in cents
`vat_in_cents` | **Integer** `readonly`<br>Tax in cents
`amount_due_in_cents` | **Integer** `readonly`<br>Amount that still needs to be paid
`attempted` | **Boolean** `readonly`<br>Whether automatic collection was attempted
`attempt_count` | **Integer** `readonly`<br>Amount of attempts for auto collection
`currency` | **String** `readonly`<br>Currency
`starting_balance_in_cents` | **Integer** `readonly`<br>Starting balance in cents (if credit was used)
`ending_balance_in_cents` | **Integer** `readonly`<br>Ending balance in cents (if credit was used)
`next_payment_attempt_at` | **Datetime** `readonly`<br>When the next charge will be attempted to charge
`coupon` | **String** `readonly`<br>Applied coupon
`url` | **String** `readonly`<br>Url to view the invoice


## Listing billing invoices



> How to fetch a list of billing invoices:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/billing_invoices' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8254d951-7761-4052-9085-013589647198",
      "type": "billing_invoices",
      "attributes": {
        "created_at": "2022-11-22T16:33:34+00:00",
        "updated_at": "2022-11-22T16:33:34+00:00",
        "number": 10001,
        "status": "open",
        "billing_reason": "subscription_cycle",
        "strategy": "charge_automatically",
        "date": null,
        "period_start_at": null,
        "period_end_at": null,
        "subtotal_in_cents": 10000,
        "total_in_cents": 10000,
        "vat_in_cents": null,
        "amount_due_in_cents": null,
        "attempted": null,
        "attempt_count": null,
        "currency": null,
        "starting_balance_in_cents": null,
        "ending_balance_in_cents": null,
        "next_payment_attempt_at": null,
        "coupon": null,
        "url": "http://billing.lvh.me:/invoices/fccbc5cf9c9db5364471fb9687758b33/4cf556c262896e732beda26be38a8fa1"
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/billing_invoices`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[billing_invoices]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:33:11Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **String** <br>`eq`
`billing_reason` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`strategy` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`date` | **Date** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`
`total_in_cents` | **Array** <br>`sum`
`vat_in_cents` | **Array** <br>`sum`
`amount_due_in_cents` | **Array** <br>`sum`


### Includes

This request does not accept any includes
## Fetching billing invoice



> How to fetch a billing invoice:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/billing_invoices/0c21e098-679b-42d3-b8a8-3a6eb5b3a79e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0c21e098-679b-42d3-b8a8-3a6eb5b3a79e",
    "type": "billing_invoices",
    "attributes": {
      "created_at": "2022-11-22T16:33:35+00:00",
      "updated_at": "2022-11-22T16:33:35+00:00",
      "number": 10001,
      "status": "open",
      "billing_reason": "subscription_cycle",
      "strategy": "charge_automatically",
      "date": null,
      "period_start_at": null,
      "period_end_at": null,
      "subtotal_in_cents": 10000,
      "total_in_cents": 10000,
      "vat_in_cents": null,
      "amount_due_in_cents": null,
      "attempted": null,
      "attempt_count": null,
      "currency": null,
      "starting_balance_in_cents": null,
      "ending_balance_in_cents": null,
      "next_payment_attempt_at": null,
      "coupon": null,
      "url": "http://billing.lvh.me:/invoices/b78ee09f5c86aae4749a92a9212b9c9e/ee8daba9308c927d9aa74b557d121d6e"
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/billing_invoices/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[billing_invoices]=id,created_at,updated_at`


### Includes

This request does not accept any includes