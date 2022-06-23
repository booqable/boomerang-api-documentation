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
- `started` Meanse that the rental has started. In most cases this means items our out with a customer.
- `stopped` Items are available for other rentals again.
- `canceled` The order is canceled. Items will be available for other rentals.
- `archived` The order won't show up in default search results.

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
`deposit_value` | **Integer**<br>The value to use for `deposit_type`
`entirely_started` | **Boolean** `readonly`<br>Whether all items on the order are started
`entirely_stopped` | **Boolean** `readonly`<br>Whether all items on the order are stopped
`location_shortage` | **Boolean** `readonly`<br>Whether there is a shortage on the pickup location
`shortage` | **Boolean** `readonly`<br>Whether there is a shortage for this order
`payment_status` | **String** `readonly`<br>One of `paid`, `partially_paid`, `overpaid`, `payment_due`, `process_deposit`
`confirm_shortage` | **Boolean** `writeonly`<br>Confirm shortage on update
`tag_list` | **Array**<br>Case insensitive tag list
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
`discount_percentage` | **Float**<br>The discount percentage applied to this order
`customer_id` | **Uuid** `nullable`<br>The associated Customer
`tax_region_id` | **Uuid** `nullable`<br>The associated Tax region
`coupon_id` | **Uuid** `nullable`<br>The associated Coupon
`start_location_id` | **Uuid**<br>The associated Start location
`stop_location_id` | **Uuid**<br>The associated Stop location


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
      "id": "0cad6ea6-1169-4840-a391-9dfb035b3a96",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-23T19:02:37+00:00",
        "updated_at": "2022-06-23T19:02:38+00:00",
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
        "customer_id": "a1f5dc12-6177-4377-909b-bc29a401e4b5",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "150d0a29-b4bf-4cc8-a16c-c71498d2ba89",
        "stop_location_id": "150d0a29-b4bf-4cc8-a16c-c71498d2ba89"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/a1f5dc12-6177-4377-909b-bc29a401e4b5"
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
            "related": "api/boomerang/barcodes?filter[owner_id]=0cad6ea6-1169-4840-a391-9dfb035b3a96&filter[owner_type]=orders"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=0cad6ea6-1169-4840-a391-9dfb035b3a96&filter[owner_type]=orders"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/150d0a29-b4bf-4cc8-a16c-c71498d2ba89"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/150d0a29-b4bf-4cc8-a16c-c71498d2ba89"
          }
        },
        "tax_values": {
          "links": {
            "related": "api/boomerang/tax_values?filter[owner_id]=0cad6ea6-1169-4840-a391-9dfb035b3a96"
          }
        },
        "lines": {
          "links": {
            "related": "api/boomerang/lines?filter[owner_id]=0cad6ea6-1169-4840-a391-9dfb035b3a96&filter[owner_type]=orders"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[order_id]=0cad6ea6-1169-4840-a391-9dfb035b3a96"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-23T19:00:38Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`statuses` | **Array**<br>`eq`
`status_counts` | **Hash**<br>`eq`
`starts_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_shortage` | **Boolean**<br>`eq`
`shortage` | **Boolean**<br>`eq`
`payment_status` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String**<br>`eq`
`price_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`coupon_discount_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_discount_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_paid_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_held_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`to_be_paid_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`paid_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **Uuid**<br>`eq`, `not_eq`
`tax_region_id` | **Uuid**<br>`eq`, `not_eq`
`coupon_id` | **Uuid**<br>`eq`, `not_eq`
`start_location_id` | **Uuid**<br>`eq`, `not_eq`
`stop_location_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`
`item_id` | **Uuid**<br>`eq`
`stock_item_id` | **Uuid**<br>`eq`
`conditions` | **Hash**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`
`payment_status` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`status` | **Array**<br>`count`
`statuses` | **Array**<br>`count`
`shortage` | **Array**<br>`count`
`location_shortage` | **Array**<br>`count`
`deposit_type` | **Array**<br>`count`
`price_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`grand_total_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`tax_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`discount_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`coupon_discount_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`total_discount_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_held_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`to_be_paid_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`paid_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **Array**<br>`maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`customer`


`start_location`


`stop_location`


`properties`






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
                    "gte": "2022-06-24T19:02:42Z",
                    "lte": "2022-06-27T19:02:42Z"
                  }
                },
                {
                  "stops_at": {
                    "gte": "2022-06-24T19:02:42Z",
                    "lte": "2022-06-27T19:02:42Z"
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
      "id": "556253e5-4627-498a-bfdf-9ec7fed95cae"
    },
    {
      "id": "9a0876e5-0789-435e-b1e7-d0ddcdcb4403"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/orders/search`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-23T19:00:38Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`statuses` | **Array**<br>`eq`
`status_counts` | **Hash**<br>`eq`
`starts_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_shortage` | **Boolean**<br>`eq`
`shortage` | **Boolean**<br>`eq`
`payment_status` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String**<br>`eq`
`price_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`coupon_discount_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_discount_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_paid_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_held_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`to_be_paid_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`paid_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **Uuid**<br>`eq`, `not_eq`
`tax_region_id` | **Uuid**<br>`eq`, `not_eq`
`coupon_id` | **Uuid**<br>`eq`, `not_eq`
`start_location_id` | **Uuid**<br>`eq`, `not_eq`
`stop_location_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`
`item_id` | **Uuid**<br>`eq`
`stock_item_id` | **Uuid**<br>`eq`
`conditions` | **Hash**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`
`payment_status` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`status` | **Array**<br>`count`
`statuses` | **Array**<br>`count`
`shortage` | **Array**<br>`count`
`location_shortage` | **Array**<br>`count`
`deposit_type` | **Array**<br>`count`
`price_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`grand_total_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`tax_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`discount_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`coupon_discount_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`total_discount_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_held_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`to_be_paid_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`paid_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **Array**<br>`maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`customer`


`start_location`


`stop_location`


`properties`






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
    "id": "eb7b716a-a6c6-4465-bdd0-ebbdda00a2bf",
    "type": "orders",
    "attributes": {
      "created_at": "2022-06-23T19:02:44+00:00",
      "updated_at": "2022-06-23T19:02:44+00:00",
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
      "start_location_id": "6688ddda-e93c-422a-b756-50d67a718cdc",
      "stop_location_id": "6688ddda-e93c-422a-b756-50d67a718cdc"
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
          "related": "api/boomerang/barcodes?filter[owner_id]=eb7b716a-a6c6-4465-bdd0-ebbdda00a2bf&filter[owner_type]=orders"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=eb7b716a-a6c6-4465-bdd0-ebbdda00a2bf&filter[owner_type]=orders"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/6688ddda-e93c-422a-b756-50d67a718cdc"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/6688ddda-e93c-422a-b756-50d67a718cdc"
        }
      },
      "tax_values": {
        "links": {
          "related": "api/boomerang/tax_values?filter[owner_id]=eb7b716a-a6c6-4465-bdd0-ebbdda00a2bf"
        }
      },
      "lines": {
        "links": {
          "related": "api/boomerang/lines?filter[owner_id]=eb7b716a-a6c6-4465-bdd0-ebbdda00a2bf&filter[owner_type]=orders"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[order_id]=eb7b716a-a6c6-4465-bdd0-ebbdda00a2bf"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`customer`


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
    --url 'https://example.booqable.com/api/boomerang/orders/799997b6-8351-44f1-95b5-a03578413b2e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "799997b6-8351-44f1-95b5-a03578413b2e",
    "type": "orders",
    "attributes": {
      "created_at": "2022-06-23T19:02:45+00:00",
      "updated_at": "2022-06-23T19:02:46+00:00",
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
      "customer_id": "3176bebd-0ab7-44a1-bc70-7e6a3e5a8317",
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "717c5dfd-5fc2-412d-be32-e1ab47e89f25",
      "stop_location_id": "717c5dfd-5fc2-412d-be32-e1ab47e89f25"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/3176bebd-0ab7-44a1-bc70-7e6a3e5a8317"
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
          "related": "api/boomerang/barcodes?filter[owner_id]=799997b6-8351-44f1-95b5-a03578413b2e&filter[owner_type]=orders"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=799997b6-8351-44f1-95b5-a03578413b2e&filter[owner_type]=orders"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/717c5dfd-5fc2-412d-be32-e1ab47e89f25"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/717c5dfd-5fc2-412d-be32-e1ab47e89f25"
        }
      },
      "tax_values": {
        "links": {
          "related": "api/boomerang/tax_values?filter[owner_id]=799997b6-8351-44f1-95b5-a03578413b2e"
        }
      },
      "lines": {
        "links": {
          "related": "api/boomerang/lines?filter[owner_id]=799997b6-8351-44f1-95b5-a03578413b2e&filter[owner_type]=orders"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[order_id]=799997b6-8351-44f1-95b5-a03578413b2e"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`customer`


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
          "starts_at": "2022-06-26T19:02:48.462Z",
          "stops_at": "2022-08-04T19:02:48.462Z"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d12bad20-5446-42e1-9de4-d635e0e3411a",
    "type": "orders",
    "attributes": {
      "created_at": "2022-06-23T19:02:48+00:00",
      "updated_at": "2022-06-23T19:02:48+00:00",
      "number": null,
      "status": "new",
      "statuses": [
        "new"
      ],
      "status_counts": {},
      "starts_at": "2022-06-26T19:00:00+00:00",
      "stops_at": "2022-08-04T19:00:00+00:00",
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
      "start_location_id": "0ab34c17-cb81-4113-b98b-bf75938b48c8",
      "stop_location_id": "0ab34c17-cb81-4113-b98b-bf75938b48c8"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][starts_at]` | **Datetime**<br>When the items on the order become unavailable
`data[attributes][stops_at]` | **Datetime**<br>When the items on the order become available again
`data[attributes][deposit_type]` | **String**<br>One of `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Integer**<br>The value to use for `deposit_type`
`data[attributes][confirm_shortage]` | **Boolean**<br>Confirm shortage on update
`data[attributes][tag_list][]` | **Array**<br>Case insensitive tag list
`data[attributes][discount_percentage]` | **Float**<br>The discount percentage applied to this order
`data[attributes][customer_id]` | **Uuid**<br>The associated Customer
`data[attributes][tax_region_id]` | **Uuid**<br>The associated Tax region
`data[attributes][coupon_id]` | **Uuid**<br>The associated Coupon
`data[attributes][start_location_id]` | **Uuid**<br>The associated Start location
`data[attributes][stop_location_id]` | **Uuid**<br>The associated Stop location


### Includes

This request accepts the following includes:

`customer`


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
    --url 'https://example.booqable.com/api/boomerang/orders/c213b0a9-28b9-454d-9b51-0199a252dd12' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "customer_id,tax_region_id,price_in_cents,grand_total_with_tax_in_cents,to_be_paid_in_cents"
      },
      "data": {
        "id": "c213b0a9-28b9-454d-9b51-0199a252dd12",
        "type": "orders",
        "attributes": {
          "customer_id": "fbd013ff-2a4a-465b-8190-88f03a391a84"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c213b0a9-28b9-454d-9b51-0199a252dd12",
    "type": "orders",
    "attributes": {
      "price_in_cents": 80250,
      "grand_total_with_tax_in_cents": 97103,
      "to_be_paid_in_cents": 197103,
      "customer_id": "fbd013ff-2a4a-465b-8190-88f03a391a84",
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
    --url 'https://example.booqable.com/api/boomerang/orders/1857ffd4-924d-47f1-9a0a-ec6825d0ee88' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "deposit_type,deposit_in_cents,to_be_paid_in_cents,deposit_paid_in_cents"
      },
      "data": {
        "id": "1857ffd4-924d-47f1-9a0a-ec6825d0ee88",
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
    "id": "1857ffd4-924d-47f1-9a0a-ec6825d0ee88",
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
    --url 'https://example.booqable.com/api/boomerang/orders/28f86e2e-d47b-4d7f-a1a9-5e2a54a6c89a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "28f86e2e-d47b-4d7f-a1a9-5e2a54a6c89a",
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
            "item_id": "9463477a-7c2e-438f-90dc-7fd719848099",
            "unavailable": [
              "7fbb3c9c-fff2-4a6f-b922-8fb3dc2641d8"
            ],
            "available": [
              "4a2307c8-9f0a-479d-87c0-cb1f6258111e"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][starts_at]` | **Datetime**<br>When items become unavailable, changing this value may result in shortages
`data[attributes][stops_at]` | **Datetime**<br>When items become available, changing this value may result in shortages
`data[attributes][deposit_type]` | **String**<br>One of `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Integer**<br>The value to use for `deposit_type`
`data[attributes][confirm_shortage]` | **Boolean**<br>Confirm shortage on update
`data[attributes][tag_list][]` | **Array**<br>Case insensitive tag list
`data[attributes][discount_percentage]` | **Float**<br>The discount percentage applied to this order
`data[attributes][customer_id]` | **Uuid**<br>The associated Customer
`data[attributes][tax_region_id]` | **Uuid**<br>The associated Tax region
`data[attributes][coupon_id]` | **Uuid**<br>The associated Coupon
`data[attributes][start_location_id]` | **Uuid**<br>The associated Start location
`data[attributes][stop_location_id]` | **Uuid**<br>The associated Stop location


### Includes

This request accepts the following includes:

`customer`


`coupon`


`barcode`


`tax_region`


`start_location`


`stop_location`


`lines`


`tax_values`


`properties`





