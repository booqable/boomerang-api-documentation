# Tax values

Tax values are generated automatically by price calculations for Orders and Carts.
They hold information about the amount taxed for a specific rate.

## Relationships
Name | Description
-- | --
`owner` | **[Order](#orders), [Document](#documents)** `required`<br>The order or cart.
`tax_rate` | **[Tax rate](#tax-rates)** `required`<br>The rate used to calculated this tax.


Check matching attributes under [Fields](#tax-values-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** `readonly`<br>Name of the tax rate.
`owner_id` | **uuid** `readonly`<br>The order or cart.
`owner_type` | **enum** `readonly`<br>The resource type of the owner.<br>One of: `orders`, `documents`.
`percentage` | **float** `readonly`<br>The percentage taxed.
`tax_rate_id` | **uuid** `readonly`<br>The rate used to calculated this tax.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`value_in_cents` | **integer** `readonly`<br>Amount of tax in cents.


## List tax values


> How to fetch a list of tax values:

```shell
  curl --get 'https://example.booqable.com/api/4/tax_values'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "806d7c35-3f4c-4c1b-8766-11c9f012e6f2",
        "type": "tax_values",
        "attributes": {
          "created_at": "2018-04-23T02:36:00.000000+00:00",
          "updated_at": "2018-04-23T02:36:00.000000+00:00",
          "name": "VAT 19%",
          "percentage": 19.0,
          "value_in_cents": 13800,
          "tax_rate_id": "67d4d696-b147-4a30-8f26-413641077ca6",
          "owner_id": "bc39e751-ea2e-4f5c-879d-4bc23d403698",
          "owner_type": "orders"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/tax_values`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tax_values]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **uuid** <br>`eq`, `not_eq`
`owner_type` | **enum** <br>`eq`, `not_eq`
`percentage` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_rate_id` | **uuid** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`value_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`
`value_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request does not accept any includes
## Fetch a tax value


> How to fetch a tax value:

```shell
  curl --get 'https://example.booqable.com/api/4/tax_values/af3a48e5-050f-4556-89e6-e863b75c268a'
       --header 'content-type: application/json'
       --data-urlencode 'include=owner'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "af3a48e5-050f-4556-89e6-e863b75c268a",
      "type": "tax_values",
      "attributes": {
        "created_at": "2018-02-01T17:33:00.000000+00:00",
        "updated_at": "2018-02-01T17:33:00.000000+00:00",
        "name": "VAT 19%",
        "percentage": 19.0,
        "value_in_cents": 13800,
        "tax_rate_id": "badc9624-dce0-4222-87c1-62dd12ef84f4",
        "owner_id": "fb0af3c4-01e8-4dce-8fa4-b5e184c08a33",
        "owner_type": "orders"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "orders",
            "id": "fb0af3c4-01e8-4dce-8fa4-b5e184c08a33"
          }
        }
      }
    },
    "included": [
      {
        "id": "fb0af3c4-01e8-4dce-8fa4-b5e184c08a33",
        "type": "orders",
        "attributes": {
          "created_at": "2018-02-01T17:33:00.000000+00:00",
          "updated_at": "2018-02-01T17:33:00.000000+00:00",
          "number": null,
          "status": "new",
          "statuses": [
            "new"
          ],
          "status_counts": {
            "new": 0,
            "draft": 0,
            "reserved": 0,
            "started": 0,
            "stopped": 0
          },
          "starts_at": "2018-01-30T17:33:00.000000+00:00",
          "stops_at": "2018-02-03T17:33:00.000000+00:00",
          "deposit_type": "percentage",
          "deposit_value": 100.0,
          "entirely_started": true,
          "entirely_stopped": false,
          "location_shortage": false,
          "shortage": false,
          "payment_status": "paid",
          "override_period_restrictions": false,
          "has_signed_contract": false,
          "item_count": 0,
          "tag_list": [],
          "properties": {
            "delivery_address": null,
            "billing_address": null
          },
          "amount_in_cents": 0,
          "amount_paid_in_cents": 0,
          "amount_to_be_paid_in_cents": null,
          "deposit_in_cents": 0,
          "deposit_held_in_cents": 0,
          "deposit_paid_in_cents": 0,
          "deposit_to_be_paid_in_cents": null,
          "deposit_refunded_in_cents": 0,
          "deposit_to_refund_in_cents": 0,
          "total_in_cents": 0,
          "total_paid_in_cents": 0,
          "total_to_be_paid_in_cents": 0,
          "total_discount_in_cents": 0,
          "coupon_discount_in_cents": 0,
          "discount_in_cents": 0,
          "grand_total_in_cents": 0,
          "grand_total_with_tax_in_cents": 0,
          "paid_in_cents": 0,
          "price_in_cents": 0,
          "tax_in_cents": 0,
          "to_be_paid_in_cents": 0,
          "discount_type": "percentage",
          "discount_percentage": 0.0,
          "billing_address_property_id": null,
          "delivery_address_property_id": null,
          "fulfillment_type": "pickup",
          "delivery_address": null,
          "customer_id": null,
          "tax_region_id": null,
          "coupon_id": null,
          "start_location_id": "85f56930-46f4-40f6-8df3-e14cb405b347",
          "stop_location_id": "85f56930-46f4-40f6-8df3-e14cb405b347",
          "order_delivery_rate_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/tax_values/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tax_values]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Includes

This request accepts the following includes:

<ul>
  <li><code>owner</code></li>
</ul>

