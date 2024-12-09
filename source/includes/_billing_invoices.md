# Billing invoices

Invoices received from Booqable

## Fields

 Name | Description
-- | --
`amount_due_in_cents` | **integer** `readonly`<br>Amount that still needs to be paid.
`attempt_count` | **integer** `readonly`<br>Amount of attempts for auto collection.
`attempted` | **boolean** `readonly`<br>Whether automatic collection was attempted.
`billing_reason` | **enum** `readonly`<br>Why the invoice is billed.<br>One of: `subscription`, `manual`, `subscription_cycle`, `refund`, `uncollectible`, `subscription_update`, `subscription_create`.
`coupon` | **string** `readonly`<br>Applied coupon.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`currency` | **string** `readonly`<br>Currency.
`date` | **date** `readonly`<br>Invoice date.
`ending_balance_in_cents` | **integer** `readonly`<br>Ending balance in cents (if credit was used).
`id` | **uuid** `readonly`<br>Primary key.
`next_payment_attempt_at` | **datetime** `readonly`<br>When the next charge will be attempted to charge.
`number` | **integer** `readonly`<br>Unique number.
`period_end_at` | **date** `readonly`<br>Period end date.
`period_start_at` | **date** `readonly`<br>Period start date.
`starting_balance_in_cents` | **integer** `readonly`<br>Starting balance in cents (if credit was used).
`status` | **enum** `readonly`<br>Status of the invoice.<br>One of: `refunded`, `credit`, `paid`, `forgiven`, `voided`, `overdue`, `open`.
`strategy` | **enum** `readonly`<br>How the invoice is billed.<br>One of: `send_invoice`, `charge_automatically`.
`subtotal_in_cents` | **integer** `readonly`<br>Subtotal in cents (without discount and taxes).
`total_in_cents` | **integer** `readonly`<br>Total in cents.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`url` | **string** `readonly`<br>Url to view the invoice.
`vat_in_cents` | **integer** `readonly`<br>Tax in cents.


## Listing billing invoices


> How to fetch a list of billing invoices:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/billing_invoices'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "f6485fec-5ad9-41ac-8b86-ff0edf25bd45",
        "type": "billing_invoices",
        "attributes": {
          "created_at": "2025-09-24T14:18:02.000000+00:00",
          "updated_at": "2025-09-24T14:18:02.000000+00:00",
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
          "url": "http://billing.lvh.me:/invoices/049bbf8ad539cb3878a3c466452f6c80/47ff2e96d1b7485024f8648305842440"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[billing_invoices]=created_at,updated_at,number`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`billing_reason` | **string_enum** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`date` | **date** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`status` | **string_enum** <br>`eq`
`strategy` | **string_enum** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`amount_due_in_cents` | **array** <br>`sum`
`total` | **array** <br>`count`
`total_in_cents` | **array** <br>`sum`
`vat_in_cents` | **array** <br>`sum`


### Includes

This request does not accept any includes
## Fetching billing invoice


> How to fetch a billing invoice:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/billing_invoices/7fbd37a3-96ff-4e1d-8651-1480d51594c0'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "7fbd37a3-96ff-4e1d-8651-1480d51594c0",
      "type": "billing_invoices",
      "attributes": {
        "created_at": "2025-12-25T08:20:01.000000+00:00",
        "updated_at": "2025-12-25T08:20:01.000000+00:00",
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
        "url": "http://billing.lvh.me:/invoices/0d2204c48e0f4bc2b9592a88250001ee/831d93c203c1037c20fe70b532fe491b"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[billing_invoices]=created_at,updated_at,number`


### Includes

This request does not accept any includes