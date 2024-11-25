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
      "id": "d34b693a-38d9-4ea7-8c54-259648acdbbe",
      "type": "billing_invoices",
      "attributes": {
        "created_at": "2024-11-25T09:27:07.701366+00:00",
        "updated_at": "2024-11-25T09:27:07.701366+00:00",
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
        "url": "http://billing.lvh.me:/invoices/c7140dfdb64f60055aafc77fdfe4c3d5/b0ed4cd45b0c769727c9bc765cd33a7f"
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
    --url 'https://example.booqable.com/api/boomerang/billing_invoices/0e3bfc18-09d5-41f1-b5ba-b58d08d587bb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0e3bfc18-09d5-41f1-b5ba-b58d08d587bb",
    "type": "billing_invoices",
    "attributes": {
      "created_at": "2024-11-25T09:27:08.538393+00:00",
      "updated_at": "2024-11-25T09:27:08.538393+00:00",
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
      "url": "http://billing.lvh.me:/invoices/73ec4fbb45efd9f01d6552d06b6ac99e/3ff60eb5834daf270037528085b6f282"
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