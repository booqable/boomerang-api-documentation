# Billing invoices

Invoices received from Booqable

## Endpoints
`GET /api/boomerang/billing_invoices`

`GET /api/boomerang/billing_invoices/{id}`

## Fields
Every billing invoice has the following fields:

Name | Description
-- | --
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
      "id": "7b991928-bc21-4449-80ea-9d3d22ede8a2",
      "type": "billing_invoices",
      "attributes": {
        "created_at": "2024-10-07T09:27:12.663589+00:00",
        "updated_at": "2024-10-07T09:27:12.663589+00:00",
        "number": 10002,
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
        "url": "http://billing.lvh.me:/invoices/7e5e7c2e229187b19e3332a5bd8b72c8/c81b3bc6c5ca91f60025dd5aefec364b"
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[billing_invoices]=created_at,updated_at,number`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
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
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/billing_invoices/d5bc4010-984f-4a15-ad56-2b85c38e8fbb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d5bc4010-984f-4a15-ad56-2b85c38e8fbb",
    "type": "billing_invoices",
    "attributes": {
      "created_at": "2024-10-07T09:27:12.052868+00:00",
      "updated_at": "2024-10-07T09:27:12.052868+00:00",
      "number": 10002,
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
      "url": "http://billing.lvh.me:/invoices/4f3803b31188479e28834c8c58ec0650/9d1d85a2f3e527a8f5bc05a6e70194ad"
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[billing_invoices]=created_at,updated_at,number`


### Includes

This request does not accept any includes