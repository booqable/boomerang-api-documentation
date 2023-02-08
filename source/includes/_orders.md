# Orders

Orders are the heart of every rental operation. They hold configuration and information about:

- The customer
- Pricing and taxes
- Deposits
- Rental period and location
- Shortages
- (Payment) status
- Additional information

**An order can have multiple of the following statuses:**

- `new` Means it's in new state.
- `concept` Does not influence availability.
- `reserved` Items on the order will be reserved and not available for other orders.
- `started` Means that the rental has started. In most cases this means items are out with a customer.
- `stopped` Items are available for other rentals again.
- `canceled` The order is canceled. Items will be available for other rentals.
- `archived` The order won't show up in default search results.

To transition an Order to the next status, create an [OrderStatusTransition](#order-status-transition).

The actual status of items and stock items can be found in their respective resource (Planning, StockItemPlanning).

**When assigning a customer to an order the following settings will be persisted to the order:**

- `tax_region_id`
- `deposit_type`
- `deposit_value`

**Changing one of the following values can lead to shortages:**

- `starts_at`
- `stops_at`
- `start_location_id`
- `stop_location_id`

A shortage error can be confirmed by setting the `confirm_shortage` attribute to `true`. Only if the shortage is within the limit configured in the product group(s). See the Product group resource for more information.

## Endpoints
`GET api/boomerang/orders`

`POST api/boomerang/orders/search`

`GET api/boomerang/orders/new`

`GET api/boomerang/orders/{id}`

`POST /api/boomerang/orders`

`PUT api/boomerang/orders/{id}`

## Fields
Every order has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`number` | **Integer** `readonly`<br>The unique order number
`status` | **String** `readonly`<br>One of `new`, `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`
`statuses` | **Array** `readonly`<br>Status(es) of planned products
`status_counts` | **Hash** `readonly`<br>An object containing the status counts of planned products `{ "concept": 0, "reserved": 2, "started": 5, "stopped": 10 }`
`starts_at` | **Datetime** `nullable`<br>When the items on the order become unavailable
`stops_at` | **Datetime** `nullable`<br>When the items on the order become available again
`deposit_type` | **String** `nullable`<br>One of `none`, `percentage_total`, `percentage`, `fixed`
`deposit_value` | **Integer** <br>The value to use for `deposit_type`
`entirely_started` | **Boolean** `readonly`<br>Whether all items on the order are started
`entirely_stopped` | **Boolean** `readonly`<br>Whether all items on the order are stopped
`location_shortage` | **Boolean** `readonly`<br>Whether there is a shortage on the pickup location
`shortage` | **Boolean** `readonly`<br>Whether there is a shortage for this order
`payment_status` | **String** `readonly`<br>One of `paid`, `partially_paid`, `overpaid`, `payment_due`, `process_deposit`
`confirm_shortage` | **Boolean** `writeonly`<br>Confirm shortage on update
`tag_list` | **Array** <br>Case insensitive tag list
`properties` | **Hash** `readonly`<br>A hash containing all basic property values (include properties if you need more detailed information about properties)
`price_in_cents` | **Integer** `readonly`<br>Subtotal excl. taxes (excl. deposit)
`grand_total_in_cents` | **Integer** `readonly`<br>Total excl. taxes (excl. deposit)
`grand_total_with_tax_in_cents` | **Integer** `readonly`<br>Amount incl. taxes (excl. deposit)
`tax_in_cents` | **Integer** `readonly`<br>Total tax
`discount_in_cents` | **Integer** `readonly`<br>Discount (incl. or excl. taxes based on `tax_strategy`
`coupon_discount_in_cents` | **Integer** `readonly`<br>Coupon discount (incl. or excl. taxes based on `tax_strategy`
`total_discount_in_cents` | **Integer** `readonly`<br>Total discount (incl. or excl. taxes based on `tax_strategy`
`deposit_in_cents` | **Integer** `readonly`<br>Deposit
`deposit_paid_in_cents` | **Integer** `readonly`<br>How much of the deposit is paid
`deposit_refunded_in_cents` | **Integer** `readonly`<br>How much of the deposit is refunded
`deposit_held_in_cents` | **Integer** `readonly`<br>Amount of deposit held
`deposit_to_refund_in_cents` | **Integer** `readonly`<br>Amount of deposit (still) to be refunded
`to_be_paid_in_cents` | **Integer** `readonly`<br>Amount that (still) has to be paid
`paid_in_cents` | **Integer** `readonly`<br>How much was paid
`discount_percentage` | **Float** <br>The discount percentage applied to this order
`customer_id` | **Uuid** `nullable`<br>The associated Customer
`tax_region_id` | **Uuid** `nullable`<br>The associated Tax region
`coupon_id` | **Uuid** `nullable`<br>The associated Coupon
`start_location_id` | **Uuid** <br>The associated Start location
`stop_location_id` | **Uuid** <br>The associated Stop location


## Relationships
Orders have the following relationships:

Name | Description
- | -
`customer` | **Customers**<br>The associated customer
`tax_region` | **Tax regions**<br>Associated Tax region
`coupon` | **Coupons**<br>Associated Coupon
`barcode` | **Barcodes**<br>Associated Barcode
`properties` | **Properties** `readonly`<br>Associated Properties
`start_location` | **Locations** `readonly`<br>Associated Start location
`stop_location` | **Locations** `readonly`<br>Associated Stop location
`tax_values` | **Tax values** `readonly`<br>Associated Tax values
`lines` | **Lines** `readonly`<br>Associated Lines
`stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Stock item plannings


## Listing orders



> How to fetch a list of orders:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/orders' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b74af4c8-67b6-4f4b-869c-f68c0c57ec28",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T13:52:38+00:00",
        "updated_at": "2023-02-08T13:52:39+00:00",
        "number": 1,
        "status": "reserved",
        "statuses": [
          "reserved"
        ],
        "status_counts": {
          "concept": 0,
          "new": 0,
          "reserved": 1,
          "started": 0,
          "stopped": 0
        },
        "starts_at": "1980-04-01T12:00:00+00:00",
        "stops_at": "1980-05-01T12:00:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 10,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "payment_due",
        "tag_list": [
          "webshop"
        ],
        "properties": {},
        "price_in_cents": 80250,
        "grand_total_in_cents": 72225,
        "grand_total_with_tax_in_cents": 87392,
        "tax_in_cents": 15167,
        "discount_in_cents": 8025,
        "coupon_discount_in_cents": 0,
        "total_discount_in_cents": 8025,
        "deposit_in_cents": 10000,
        "deposit_paid_in_cents": 0,
        "deposit_refunded_in_cents": 0,
        "deposit_held_in_cents": 0,
        "deposit_to_refund_in_cents": 0,
        "to_be_paid_in_cents": 97392,
        "paid_in_cents": 0,
        "discount_percentage": 10.0,
        "customer_id": "7f9b3a91-9b61-4ca4-8168-f9480e06df52",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5df1fd7b-9a76-40ab-8010-3849d8871258",
        "stop_location_id": "5df1fd7b-9a76-40ab-8010-3849d8871258"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/7f9b3a91-9b61-4ca4-8168-f9480e06df52"
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "coupon": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b74af4c8-67b6-4f4b-869c-f68c0c57ec28&filter[owner_type]=orders"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=b74af4c8-67b6-4f4b-869c-f68c0c57ec28&filter[owner_type]=orders"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/5df1fd7b-9a76-40ab-8010-3849d8871258"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/5df1fd7b-9a76-40ab-8010-3849d8871258"
          }
        },
        "tax_values": {
          "links": {
            "related": "api/boomerang/tax_values?filter[owner_id]=b74af4c8-67b6-4f4b-869c-f68c0c57ec28"
          }
        },
        "lines": {
          "links": {
            "related": "api/boomerang/lines?filter[owner_id]=b74af4c8-67b6-4f4b-869c-f68c0c57ec28&filter[owner_type]=orders"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[order_id]=b74af4c8-67b6-4f4b-869c-f68c0c57ec28"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET api/boomerang/orders`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T13:50:28Z`
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
`number` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`statuses` | **Array** <br>`eq`
`status_counts` | **Hash** <br>`eq`
`starts_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_shortage` | **Boolean** <br>`eq`
`shortage` | **Boolean** <br>`eq`
`payment_status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String** <br>`eq`
`price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`coupon_discount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_discount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_paid_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_held_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`to_be_paid_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`paid_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **Uuid** <br>`eq`, `not_eq`
`tax_region_id` | **Uuid** <br>`eq`, `not_eq`
`coupon_id` | **Uuid** <br>`eq`, `not_eq`
`start_location_id` | **Uuid** <br>`eq`, `not_eq`
`stop_location_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`item_id` | **Uuid** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`
`conditions` | **Hash** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`
`payment_status` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`
`status` | **Array** <br>`count`
`statuses` | **Array** <br>`count`
`shortage` | **Array** <br>`count`
`location_shortage` | **Array** <br>`count`
`deposit_type` | **Array** <br>`count`
`price_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`tax_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`coupon_discount_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`total_discount_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_held_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`to_be_paid_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`paid_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **Array** <br>`maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`customer`


`start_location`


`stop_location`


`properties`


`coupon`






## Searching orders

Use advanced search to make logical filter groups with and/or operators.


> How to search for orders:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/orders/search' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "id"
      },
      "filter": {
        "conditions": {
          "operator": "and",
          "attributes": [
            {
              "operator": "or",
              "attributes": [
                {
                  "starts_at": {
                    "gte": "2023-02-09T13:52:42Z",
                    "lte": "2023-02-12T13:52:42Z"
                  }
                },
                {
                  "stops_at": {
                    "gte": "2023-02-09T13:52:42Z",
                    "lte": "2023-02-12T13:52:42Z"
                  }
                }
              ]
            },
            {
              "operator": "and",
              "attributes": [
                {
                  "deposit_type": "none"
                },
                {
                  "payment_status": "paid"
                }
              ]
            }
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ce0906f6-8031-41e0-abfc-b81c68c10edc"
    },
    {
      "id": "341dc0e1-5a28-4a18-84df-be75849551c7"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/orders/search`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T13:50:28Z`
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
`number` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`statuses` | **Array** <br>`eq`
`status_counts` | **Hash** <br>`eq`
`starts_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_shortage` | **Boolean** <br>`eq`
`shortage` | **Boolean** <br>`eq`
`payment_status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String** <br>`eq`
`price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`coupon_discount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_discount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_paid_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_held_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`to_be_paid_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`paid_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **Uuid** <br>`eq`, `not_eq`
`tax_region_id` | **Uuid** <br>`eq`, `not_eq`
`coupon_id` | **Uuid** <br>`eq`, `not_eq`
`start_location_id` | **Uuid** <br>`eq`, `not_eq`
`stop_location_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`item_id` | **Uuid** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`
`conditions` | **Hash** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`
`payment_status` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`
`status` | **Array** <br>`count`
`statuses` | **Array** <br>`count`
`shortage` | **Array** <br>`count`
`location_shortage` | **Array** <br>`count`
`deposit_type` | **Array** <br>`count`
`price_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`tax_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`coupon_discount_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`total_discount_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_held_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`to_be_paid_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`paid_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **Array** <br>`maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`customer`


`start_location`


`stop_location`


`properties`


`coupon`






## New order

Returns an existing or new order for the current employee.


> How to fetch a new order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/orders/new' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5a68f2b5-3b85-44f1-9900-c1fb671726aa",
    "type": "orders",
    "attributes": {
      "created_at": "2023-02-08T13:52:43+00:00",
      "updated_at": "2023-02-08T13:52:43+00:00",
      "number": null,
      "status": "new",
      "statuses": [
        "new"
      ],
      "status_counts": {},
      "starts_at": null,
      "stops_at": null,
      "deposit_type": "percentage",
      "deposit_value": 100,
      "entirely_started": false,
      "entirely_stopped": false,
      "location_shortage": false,
      "shortage": false,
      "payment_status": "paid",
      "tag_list": [],
      "properties": {},
      "price_in_cents": 0,
      "grand_total_in_cents": 0,
      "grand_total_with_tax_in_cents": 0,
      "tax_in_cents": 0,
      "discount_in_cents": 0,
      "coupon_discount_in_cents": 0,
      "total_discount_in_cents": 0,
      "deposit_in_cents": 0,
      "deposit_paid_in_cents": 0,
      "deposit_refunded_in_cents": 0,
      "deposit_held_in_cents": 0,
      "deposit_to_refund_in_cents": 0,
      "to_be_paid_in_cents": 0,
      "paid_in_cents": 0,
      "discount_percentage": 0.0,
      "customer_id": null,
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "7568205c-e73a-4db6-b122-2e0439526044",
      "stop_location_id": "7568205c-e73a-4db6-b122-2e0439526044"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": null
        }
      },
      "tax_region": {
        "links": {
          "related": null
        }
      },
      "coupon": {
        "links": {
          "related": null
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=5a68f2b5-3b85-44f1-9900-c1fb671726aa&filter[owner_type]=orders"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=5a68f2b5-3b85-44f1-9900-c1fb671726aa&filter[owner_type]=orders"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/7568205c-e73a-4db6-b122-2e0439526044"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/7568205c-e73a-4db6-b122-2e0439526044"
        }
      },
      "tax_values": {
        "links": {
          "related": "api/boomerang/tax_values?filter[owner_id]=5a68f2b5-3b85-44f1-9900-c1fb671726aa"
        }
      },
      "lines": {
        "links": {
          "related": "api/boomerang/lines?filter[owner_id]=5a68f2b5-3b85-44f1-9900-c1fb671726aa&filter[owner_type]=orders"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[order_id]=5a68f2b5-3b85-44f1-9900-c1fb671726aa"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET api/boomerang/orders/new`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`customer` => 
`merge_suggestion_customer`


`properties`




`coupon`


`barcode`


`tax_region`


`start_location`


`stop_location`


`lines`


`tax_values`


`properties`






## Fetching an order



> How to fetch an order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/orders/30b7cfe1-191c-4e86-a7bd-baf5b79a625c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "30b7cfe1-191c-4e86-a7bd-baf5b79a625c",
    "type": "orders",
    "attributes": {
      "created_at": "2023-02-08T13:52:44+00:00",
      "updated_at": "2023-02-08T13:52:45+00:00",
      "number": 1,
      "status": "reserved",
      "statuses": [
        "reserved"
      ],
      "status_counts": {
        "concept": 0,
        "new": 0,
        "reserved": 1,
        "started": 0,
        "stopped": 0
      },
      "starts_at": "1980-04-01T12:00:00+00:00",
      "stops_at": "1980-05-01T12:00:00+00:00",
      "deposit_type": "percentage",
      "deposit_value": 10,
      "entirely_started": false,
      "entirely_stopped": false,
      "location_shortage": false,
      "shortage": false,
      "payment_status": "payment_due",
      "tag_list": [
        "webshop"
      ],
      "properties": {},
      "price_in_cents": 80250,
      "grand_total_in_cents": 72225,
      "grand_total_with_tax_in_cents": 87392,
      "tax_in_cents": 15167,
      "discount_in_cents": 8025,
      "coupon_discount_in_cents": 0,
      "total_discount_in_cents": 8025,
      "deposit_in_cents": 10000,
      "deposit_paid_in_cents": 0,
      "deposit_refunded_in_cents": 0,
      "deposit_held_in_cents": 0,
      "deposit_to_refund_in_cents": 0,
      "to_be_paid_in_cents": 97392,
      "paid_in_cents": 0,
      "discount_percentage": 10.0,
      "customer_id": "b96bb7b3-c61c-414e-abd3-0d4477864fc6",
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "b1308d14-7084-4490-866d-e08912660400",
      "stop_location_id": "b1308d14-7084-4490-866d-e08912660400"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/b96bb7b3-c61c-414e-abd3-0d4477864fc6"
        }
      },
      "tax_region": {
        "links": {
          "related": null
        }
      },
      "coupon": {
        "links": {
          "related": null
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=30b7cfe1-191c-4e86-a7bd-baf5b79a625c&filter[owner_type]=orders"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=30b7cfe1-191c-4e86-a7bd-baf5b79a625c&filter[owner_type]=orders"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/b1308d14-7084-4490-866d-e08912660400"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/b1308d14-7084-4490-866d-e08912660400"
        }
      },
      "tax_values": {
        "links": {
          "related": "api/boomerang/tax_values?filter[owner_id]=30b7cfe1-191c-4e86-a7bd-baf5b79a625c"
        }
      },
      "lines": {
        "links": {
          "related": "api/boomerang/lines?filter[owner_id]=30b7cfe1-191c-4e86-a7bd-baf5b79a625c&filter[owner_type]=orders"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[order_id]=30b7cfe1-191c-4e86-a7bd-baf5b79a625c"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET api/boomerang/orders/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`customer` => 
`merge_suggestion_customer`


`properties`




`coupon`


`barcode`


`tax_region`


`start_location`


`stop_location`


`lines`


`tax_values`


`properties`






## Creating an order

When creating an order, and the following fields are left blank, a sensible default will be picked:

- `deposit_type` Default deposit type configured in settings.
- `deposit_value` Default deposit value configured in settings.
- `start_location_id` First location in account.
- `stop_location_id` First location in account.


> How to create an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/orders' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "customers",
        "attributes": {
          "starts_at": "2023-02-11T13:52:47.169Z",
          "stops_at": "2023-03-22T13:52:47.170Z"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "49bf4b61-108c-459b-970c-fb30cba9ebef",
    "type": "orders",
    "attributes": {
      "created_at": "2023-02-08T13:52:47+00:00",
      "updated_at": "2023-02-08T13:52:47+00:00",
      "number": null,
      "status": "new",
      "statuses": [
        "new"
      ],
      "status_counts": {},
      "starts_at": "2023-02-11T13:45:00+00:00",
      "stops_at": "2023-03-22T13:45:00+00:00",
      "deposit_type": "percentage",
      "deposit_value": 100,
      "entirely_started": false,
      "entirely_stopped": false,
      "location_shortage": false,
      "shortage": false,
      "payment_status": "paid",
      "tag_list": [],
      "properties": {},
      "price_in_cents": 0,
      "grand_total_in_cents": 0,
      "grand_total_with_tax_in_cents": 0,
      "tax_in_cents": 0,
      "discount_in_cents": 0,
      "coupon_discount_in_cents": 0,
      "total_discount_in_cents": 0,
      "deposit_in_cents": 0,
      "deposit_paid_in_cents": 0,
      "deposit_refunded_in_cents": 0,
      "deposit_held_in_cents": 0,
      "deposit_to_refund_in_cents": 0,
      "to_be_paid_in_cents": 0,
      "paid_in_cents": 0,
      "discount_percentage": 0.0,
      "customer_id": null,
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "863f7221-68da-4351-8788-fa8ded91e0a2",
      "stop_location_id": "863f7221-68da-4351-8788-fa8ded91e0a2"
    },
    "relationships": {
      "customer": {
        "meta": {
          "included": false
        }
      },
      "tax_region": {
        "meta": {
          "included": false
        }
      },
      "coupon": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "properties": {
        "meta": {
          "included": false
        }
      },
      "start_location": {
        "meta": {
          "included": false
        }
      },
      "stop_location": {
        "meta": {
          "included": false
        }
      },
      "tax_values": {
        "meta": {
          "included": false
        }
      },
      "lines": {
        "meta": {
          "included": false
        }
      },
      "stock_item_plannings": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/orders`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][starts_at]` | **Datetime** <br>When the items on the order become unavailable
`data[attributes][stops_at]` | **Datetime** <br>When the items on the order become available again
`data[attributes][deposit_type]` | **String** <br>One of `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Integer** <br>The value to use for `deposit_type`
`data[attributes][confirm_shortage]` | **Boolean** <br>Confirm shortage on update
`data[attributes][tag_list][]` | **Array** <br>Case insensitive tag list
`data[attributes][discount_percentage]` | **Float** <br>The discount percentage applied to this order
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer
`data[attributes][tax_region_id]` | **Uuid** <br>The associated Tax region
`data[attributes][coupon_id]` | **Uuid** <br>The associated Coupon
`data[attributes][start_location_id]` | **Uuid** <br>The associated Start location
`data[attributes][stop_location_id]` | **Uuid** <br>The associated Stop location


### Includes

This request accepts the following includes:

`customer` => 
`merge_suggestion_customer`


`properties`




`coupon`


`barcode`


`tax_region`


`start_location`


`stop_location`


`properties`






## Updating an order

When updating a customer on an order the following settings will be applied and prices will be calculated accordingly:

- `discount_percentage`
- `deposit_type`
- `deposit_value`
- `tax_region_id`


> How to assign a (new) customer to an order:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/orders/7333d81d-4854-40b5-be97-406f60f68b83' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "customer_id,tax_region_id,price_in_cents,grand_total_with_tax_in_cents,to_be_paid_in_cents"
      },
      "data": {
        "id": "7333d81d-4854-40b5-be97-406f60f68b83",
        "type": "orders",
        "attributes": {
          "customer_id": "828a8fbd-af24-4412-bfad-008c1181c11e"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7333d81d-4854-40b5-be97-406f60f68b83",
    "type": "orders",
    "attributes": {
      "price_in_cents": 80250,
      "grand_total_with_tax_in_cents": 97103,
      "to_be_paid_in_cents": 197103,
      "customer_id": "828a8fbd-af24-4412-bfad-008c1181c11e",
      "tax_region_id": null
    },
    "relationships": {
      "customer": {
        "meta": {
          "included": false
        }
      },
      "tax_region": {
        "meta": {
          "included": false
        }
      },
      "coupon": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "properties": {
        "meta": {
          "included": false
        }
      },
      "start_location": {
        "meta": {
          "included": false
        }
      },
      "stop_location": {
        "meta": {
          "included": false
        }
      },
      "tax_values": {
        "meta": {
          "included": false
        }
      },
      "lines": {
        "meta": {
          "included": false
        }
      },
      "stock_item_plannings": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> How to update the deposit_type:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/orders/3e749c65-e937-476b-8fa7-c1a27243b9cc' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "deposit_type,deposit_in_cents,to_be_paid_in_cents,deposit_paid_in_cents"
      },
      "data": {
        "id": "3e749c65-e937-476b-8fa7-c1a27243b9cc",
        "type": "orders",
        "attributes": {
          "deposit_type": "percentage"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3e749c65-e937-476b-8fa7-c1a27243b9cc",
    "type": "orders",
    "attributes": {
      "deposit_type": "percentage",
      "deposit_in_cents": 10000,
      "deposit_paid_in_cents": 0,
      "to_be_paid_in_cents": 97392
    },
    "relationships": {
      "customer": {
        "meta": {
          "included": false
        }
      },
      "tax_region": {
        "meta": {
          "included": false
        }
      },
      "coupon": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "properties": {
        "meta": {
          "included": false
        }
      },
      "start_location": {
        "meta": {
          "included": false
        }
      },
      "stop_location": {
        "meta": {
          "included": false
        }
      },
      "tax_values": {
        "meta": {
          "included": false
        }
      },
      "lines": {
        "meta": {
          "included": false
        }
      },
      "stock_item_plannings": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Updating stops_at resulting in a shortage:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/orders/eb670fa5-ded5-41a0-9831-91e274a7dd8b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "eb670fa5-ded5-41a0-9831-91e274a7dd8b",
        "type": "orders",
        "attributes": {
          "stops_at": "1980-05-04T12:00:00.000Z"
        }
      }
    }'
```

> A 422 status response looks like this:

```json
  {
  "errors": [
    {
      "code": "items_not_available",
      "status": "422",
      "title": "Items not available",
      "detail": "One or more items are not available",
      "meta": {
        "warning": [],
        "blocking": [
          {
            "reason": "stock_item_specified",
            "item_id": "44cfe905-a904-4357-b539-dce8795011ab",
            "unavailable": [
              "39329337-cd7c-404b-8d43-0bb52fc598af"
            ],
            "available": [
              "c6d0556d-2735-4f01-9bb4-dbb3bea23f03"
            ]
          }
        ]
      }
    }
  ]
}
```

### HTTP Request

`PUT api/boomerang/orders/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][starts_at]` | **Datetime** <br>When items become unavailable, changing this value may result in shortages
`data[attributes][stops_at]` | **Datetime** <br>When items become available, changing this value may result in shortages
`data[attributes][deposit_type]` | **String** <br>One of `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Integer** <br>The value to use for `deposit_type`
`data[attributes][confirm_shortage]` | **Boolean** <br>Confirm shortage on update
`data[attributes][tag_list][]` | **Array** <br>Case insensitive tag list
`data[attributes][discount_percentage]` | **Float** <br>The discount percentage applied to this order
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer
`data[attributes][tax_region_id]` | **Uuid** <br>The associated Tax region
`data[attributes][coupon_id]` | **Uuid** <br>The associated Coupon
`data[attributes][start_location_id]` | **Uuid** <br>The associated Start location
`data[attributes][stop_location_id]` | **Uuid** <br>The associated Stop location


### Includes

This request accepts the following includes:

`customer` => 
`merge_suggestion_customer`


`properties`




`coupon`


`barcode`


`tax_region`


`start_location`


`stop_location`


`lines`


`tax_values`


`properties`





