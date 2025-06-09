# Payments

The Payment resource makes it possible to fetch the following resources in a single request:

- [Payment Charges](#payment-charges)
- [Payment Authorizations](#payment-authorizations)
- [Payment Refunds](#payment-refunds)

The description of the relationships and attributes of these resources can be found in their respective sections

## List payments


> How to fetch a list of payments:

```shell
  curl --get 'https://example.booqable.com/api/4/payments'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "d7796fe0-99e9-4f00-858b-eb3f1e28fd8f",
        "type": "payment_refunds",
        "attributes": {
          "created_at": "2028-11-19T02:39:01.000000+00:00",
          "updated_at": "2028-11-19T02:39:01.000000+00:00",
          "type": "payment_refunds",
          "provider": "none",
          "provider_id": null,
          "provider_method": null,
          "provider_secret": null,
          "provider_link": null,
          "amount_in_cents": 5000,
          "deposit_in_cents": 0,
          "total_in_cents": 5000,
          "currency": "usd",
          "succeeded_at": null,
          "failed_at": null,
          "canceled_at": null,
          "expired_at": null,
          "cart_id": null,
          "order_id": null,
          "employee_id": null,
          "customer_id": null,
          "status": "created",
          "description": null,
          "failure_reason": null,
          "reason": null,
          "payment_charge_id": null
        },
        "relationships": {}
      },
      {
        "id": "d7d97872-e34d-4c76-8452-be23af13a699",
        "type": "payment_authorizations",
        "attributes": {
          "created_at": "2028-11-19T02:39:01.000000+00:00",
          "updated_at": "2028-11-19T02:39:01.000000+00:00",
          "type": "payment_authorizations",
          "provider": "stripe",
          "provider_id": null,
          "provider_method": null,
          "provider_secret": null,
          "provider_link": null,
          "amount_in_cents": 5000,
          "deposit_in_cents": 0,
          "total_in_cents": 5000,
          "currency": "usd",
          "succeeded_at": null,
          "failed_at": null,
          "canceled_at": null,
          "expired_at": null,
          "cart_id": null,
          "order_id": null,
          "employee_id": null,
          "customer_id": null,
          "status": "created",
          "mode": "request",
          "description": null,
          "redirect_url": null,
          "capturable": true,
          "amount_capturable_in_cents": 5000,
          "deposit_capturable_in_cents": 0,
          "total_capturable_in_cents": 5000,
          "amount_captured_in_cents": 0,
          "deposit_captured_in_cents": 0,
          "total_captured_in_cents": 0,
          "captured_at": null,
          "capture_before": null,
          "payment_method_id": null
        },
        "relationships": {}
      },
      {
        "id": "829cbadd-91ff-44e3-850b-28fb5b5dd16f",
        "type": "payment_charges",
        "attributes": {
          "created_at": "2028-11-19T02:39:01.000000+00:00",
          "updated_at": "2028-11-19T02:39:01.000000+00:00",
          "type": "payment_charges",
          "provider": "stripe",
          "provider_id": null,
          "provider_method": null,
          "provider_secret": null,
          "provider_link": null,
          "amount_in_cents": 5000,
          "deposit_in_cents": 0,
          "total_in_cents": 5000,
          "currency": "usd",
          "succeeded_at": null,
          "failed_at": null,
          "canceled_at": null,
          "expired_at": null,
          "cart_id": null,
          "order_id": null,
          "employee_id": null,
          "customer_id": null,
          "status": "created",
          "mode": "request",
          "description": null,
          "redirect_url": null,
          "refundable": true,
          "amount_refundable_in_cents": 5000,
          "amount_refunded_in_cents": 0,
          "deposit_refundable_in_cents": 0,
          "deposit_refunded_in_cents": 0,
          "total_refundable_in_cents": 5000,
          "total_refunded_in_cents": 0,
          "payment_method_id": null,
          "payment_authorization_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/payments`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payments]=created_at,updated_at,type`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,cart,payment_method`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`amount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`canceled_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`cart_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`currency` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`customer_id` | **uuid** <br>`eq`, `not_eq`
`deposit_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`employee_id` | **uuid** <br>`eq`, `not_eq`
`expired_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`failed_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`order_id` | **uuid** <br>`eq`, `not_eq`
`provider` | **enum** <br>`eq`
`provider_id` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_link` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_method` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_secret` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`succeeded_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`type` | **string** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`amount_in_cents` | **array** <br>`sum`
`deposit_in_cents` | **array** <br>`sum`
`total` | **array** <br>`count`
`total_in_cents` | **array** <br>`sum`


### Includes

This request accepts the following includes:

<ul>
  <li><code>cart</code></li>
  <li><code>order</code></li>
  <li><code>payment_method</code></li>
</ul>


## Fetch a payment


> How to fetch a payment:

```shell
  curl --get 'https://example.booqable.com/api/4/payments/bf92b7a9-88e9-43e2-85c0-49ff1418a448'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "bf92b7a9-88e9-43e2-85c0-49ff1418a448",
      "type": "payment_charges",
      "attributes": {
        "created_at": "2016-06-23T23:18:00.000000+00:00",
        "updated_at": "2016-06-23T23:18:00.000000+00:00",
        "type": "payment_charges",
        "provider": "stripe",
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
        "provider_link": null,
        "amount_in_cents": 5000,
        "deposit_in_cents": 0,
        "total_in_cents": 5000,
        "currency": "usd",
        "succeeded_at": null,
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "cart_id": null,
        "order_id": null,
        "employee_id": null,
        "customer_id": null,
        "status": "created",
        "mode": "request",
        "description": null,
        "redirect_url": null,
        "refundable": true,
        "amount_refundable_in_cents": 5000,
        "amount_refunded_in_cents": 0,
        "deposit_refundable_in_cents": 0,
        "deposit_refunded_in_cents": 0,
        "total_refundable_in_cents": 5000,
        "total_refunded_in_cents": 0,
        "payment_method_id": null,
        "payment_authorization_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/payments/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payments]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,cart,payment_method`


### Includes

This request accepts the following includes:

<ul>
  <li><code>cart</code></li>
  <li><code>order</code></li>
  <li><code>payment_method</code></li>
</ul>

