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
      "id": "d100ae6a-00ed-4bf5-9695-4fcdbf3e6124",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-15T11:22:39+00:00",
        "updated_at": "2022-07-15T11:22:40+00:00",
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
        "customer_id": "50db8e8e-61ae-41b5-bcfa-634f3e20f6f9",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "697d5cc8-ed49-4a70-9be6-3a1380adf1b5",
        "stop_location_id": "697d5cc8-ed49-4a70-9be6-3a1380adf1b5"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/50db8e8e-61ae-41b5-bcfa-634f3e20f6f9"
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
            "related": "api/boomerang/barcodes?filter[owner_id]=d100ae6a-00ed-4bf5-9695-4fcdbf3e6124&filter[owner_type]=orders"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=d100ae6a-00ed-4bf5-9695-4fcdbf3e6124&filter[owner_type]=orders"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/697d5cc8-ed49-4a70-9be6-3a1380adf1b5"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/697d5cc8-ed49-4a70-9be6-3a1380adf1b5"
          }
        },
        "tax_values": {
          "links": {
            "related": "api/boomerang/tax_values?filter[owner_id]=d100ae6a-00ed-4bf5-9695-4fcdbf3e6124"
          }
        },
        "lines": {
          "links": {
            "related": "api/boomerang/lines?filter[owner_id]=d100ae6a-00ed-4bf5-9695-4fcdbf3e6124&filter[owner_type]=orders"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[order_id]=d100ae6a-00ed-4bf5-9695-4fcdbf3e6124"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T11:20:14Z`
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
                    "gte": "2022-07-16T11:22:44Z",
                    "lte": "2022-07-19T11:22:44Z"
                  }
                },
                {
                  "stops_at": {
                    "gte": "2022-07-16T11:22:44Z",
                    "lte": "2022-07-19T11:22:44Z"
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
      "id": "c444a3eb-984a-4033-a942-41f20a380efe"
    },
    {
      "id": "ebd61d4d-d15c-494d-ad31-02b270a3aa82"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T11:20:14Z`
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
    "id": "3f266a69-ad09-4ab5-9eb0-2bf6a86eb951",
    "type": "orders",
    "attributes": {
      "created_at": "2022-07-15T11:22:46+00:00",
      "updated_at": "2022-07-15T11:22:46+00:00",
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
      "start_location_id": "9317ea84-088c-4c18-96cd-02aa160fc278",
      "stop_location_id": "9317ea84-088c-4c18-96cd-02aa160fc278"
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
          "related": "api/boomerang/barcodes?filter[owner_id]=3f266a69-ad09-4ab5-9eb0-2bf6a86eb951&filter[owner_type]=orders"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=3f266a69-ad09-4ab5-9eb0-2bf6a86eb951&filter[owner_type]=orders"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/9317ea84-088c-4c18-96cd-02aa160fc278"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/9317ea84-088c-4c18-96cd-02aa160fc278"
        }
      },
      "tax_values": {
        "links": {
          "related": "api/boomerang/tax_values?filter[owner_id]=3f266a69-ad09-4ab5-9eb0-2bf6a86eb951"
        }
      },
      "lines": {
        "links": {
          "related": "api/boomerang/lines?filter[owner_id]=3f266a69-ad09-4ab5-9eb0-2bf6a86eb951&filter[owner_type]=orders"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[order_id]=3f266a69-ad09-4ab5-9eb0-2bf6a86eb951"
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
    --url 'https://example.booqable.com/api/boomerang/orders/5f802f71-a260-4894-b1ca-758942124870' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5f802f71-a260-4894-b1ca-758942124870",
    "type": "orders",
    "attributes": {
      "created_at": "2022-07-15T11:22:47+00:00",
      "updated_at": "2022-07-15T11:22:49+00:00",
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
      "customer_id": "7afce571-8bda-4918-82bc-494a63426d5a",
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "76db4a3a-8b39-4828-a4e2-7b7a3f83e071",
      "stop_location_id": "76db4a3a-8b39-4828-a4e2-7b7a3f83e071"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/7afce571-8bda-4918-82bc-494a63426d5a"
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
          "related": "api/boomerang/barcodes?filter[owner_id]=5f802f71-a260-4894-b1ca-758942124870&filter[owner_type]=orders"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=5f802f71-a260-4894-b1ca-758942124870&filter[owner_type]=orders"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/76db4a3a-8b39-4828-a4e2-7b7a3f83e071"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/76db4a3a-8b39-4828-a4e2-7b7a3f83e071"
        }
      },
      "tax_values": {
        "links": {
          "related": "api/boomerang/tax_values?filter[owner_id]=5f802f71-a260-4894-b1ca-758942124870"
        }
      },
      "lines": {
        "links": {
          "related": "api/boomerang/lines?filter[owner_id]=5f802f71-a260-4894-b1ca-758942124870&filter[owner_type]=orders"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[order_id]=5f802f71-a260-4894-b1ca-758942124870"
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
          "starts_at": "2022-07-18T11:22:51.124Z",
          "stops_at": "2022-08-26T11:22:51.124Z"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0ad1f006-4171-405b-a565-117e3a0a9eac",
    "type": "orders",
    "attributes": {
      "created_at": "2022-07-15T11:22:51+00:00",
      "updated_at": "2022-07-15T11:22:51+00:00",
      "number": null,
      "status": "new",
      "statuses": [
        "new"
      ],
      "status_counts": {},
      "starts_at": "2022-07-18T11:15:00+00:00",
      "stops_at": "2022-08-26T11:15:00+00:00",
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
      "start_location_id": "8bbaebef-2dec-4937-902b-adb4253df380",
      "stop_location_id": "8bbaebef-2dec-4937-902b-adb4253df380"
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
    --url 'https://example.booqable.com/api/boomerang/orders/9e802f8a-1fc3-4542-ba78-e0b59e93d41f' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "customer_id,tax_region_id,price_in_cents,grand_total_with_tax_in_cents,to_be_paid_in_cents"
      },
      "data": {
        "id": "9e802f8a-1fc3-4542-ba78-e0b59e93d41f",
        "type": "orders",
        "attributes": {
          "customer_id": "ee01e6da-509f-450c-aa89-f67f4b68ab6a"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9e802f8a-1fc3-4542-ba78-e0b59e93d41f",
    "type": "orders",
    "attributes": {
      "price_in_cents": 80250,
      "grand_total_with_tax_in_cents": 97103,
      "to_be_paid_in_cents": 197103,
      "customer_id": "ee01e6da-509f-450c-aa89-f67f4b68ab6a",
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
    --url 'https://example.booqable.com/api/boomerang/orders/dc0e8740-5c8e-4721-8ad2-72cace77d579' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "deposit_type,deposit_in_cents,to_be_paid_in_cents,deposit_paid_in_cents"
      },
      "data": {
        "id": "dc0e8740-5c8e-4721-8ad2-72cace77d579",
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
    "id": "dc0e8740-5c8e-4721-8ad2-72cace77d579",
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
    --url 'https://example.booqable.com/api/boomerang/orders/c3bf3734-290d-4094-b9b3-0cc26ef643d3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c3bf3734-290d-4094-b9b3-0cc26ef643d3",
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
            "item_id": "706abd3d-b509-459f-aae2-30bc24004e04",
            "unavailable": [
              "b4d567f2-9d83-4036-a8bb-1599729ed622"
            ],
            "available": [
              "fb6363d3-562d-4375-8e02-f307c9dbf1de"
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





