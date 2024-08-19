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
      "id": "95c0f753-7e43-4f06-a584-6964f65afa7a",
      "type": "billing_invoices",
      "attributes": {
        "created_at": "2024-08-19T09:25:30.737523+00:00",
        "updated_at": "2024-08-19T09:25:30.737523+00:00",
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
        "url": "http://billing.lvh.me:/invoices/f1ca4b953c70e6e61728a70dc931307c/f228cb3a6423b35e1e5400baae49f52f"
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
    --url 'https://example.booqable.com/api/boomerang/billing_invoices/feb0a440-3acc-4e51-898f-25c664760024' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "feb0a440-3acc-4e51-898f-25c664760024",
    "type": "billing_invoices",
    "attributes": {
      "created_at": "2024-08-19T09:25:31.272123+00:00",
      "updated_at": "2024-08-19T09:25:31.272123+00:00",
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
      "url": "http://billing.lvh.me:/invoices/69354a6801da0beccdb4900f0b144c31/329987dafa0d4d577a88b5cd1947e290"
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