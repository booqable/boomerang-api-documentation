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
-- | --
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
`deposit_value` | **Float** <br>The value to use for `deposit_type`
`entirely_started` | **Boolean** `readonly`<br>Whether all items on the order are started
`entirely_stopped` | **Boolean** `readonly`<br>Whether all items on the order are stopped
`location_shortage` | **Boolean** `readonly`<br>Whether there is a shortage on the pickup location
`shortage` | **Boolean** `readonly`<br>Whether there is a shortage for this order
`payment_status` | **String** `readonly`<br>One of `paid`, `partially_paid`, `overpaid`, `payment_due`, `process_deposit`
`override_period_restrictions` | **Boolean** <br>Force free period selection when there are restrictions enabled for the order period picker
`confirm_shortage` | **Boolean** `writeonly`<br>Confirm shortage on update
`has_signed_contract` | **Boolean** `readonly`<br>Whether the order has a signed contract
`tag_list` | **Array** <br>Case insensitive tag list
`properties` | **Hash** `readonly`<br>A hash containing all basic property values (include properties if you need more detailed information about properties)
`price_in_cents` | **Integer** `readonly`<br>Subtotal excl. taxes (excl. deposit)
`grand_total_in_cents` | **Integer** `readonly`<br>Total excl. taxes (excl. deposit)
`grand_total_with_tax_in_cents` | **Integer** `readonly`<br>Amount incl. taxes (excl. deposit)
`tax_in_cents` | **Integer** `readonly`<br>Total tax
`discount_in_cents` | **Integer** `readonly`<br>Discount (incl. or excl. taxes based on `tax_strategy`)
`coupon_discount_in_cents` | **Integer** `readonly`<br>Coupon discount (incl. or excl. taxes based on `tax_strategy`
`total_discount_in_cents` | **Integer** `readonly`<br>Total discount (incl. or excl. taxes based on `tax_strategy`
`deposit_in_cents` | **Integer** `readonly`<br>Deposit
`deposit_paid_in_cents` | **Integer** `readonly`<br>How much of the deposit is paid
`deposit_refunded_in_cents` | **Integer** `readonly`<br>How much of the deposit is refunded
`deposit_held_in_cents` | **Integer** `readonly`<br>Amount of deposit held
`deposit_to_refund_in_cents` | **Integer** `readonly`<br>Amount of deposit (still) to be refunded
`to_be_paid_in_cents` | **Integer** `readonly`<br>Amount that (still) has to be paid
`paid_in_cents` | **Integer** `readonly`<br>How much was paid
`discount_value` | **Float** `writeonly`<br>The value to use for `discount_type`
`discount_type` | **String** <br>One of `percentage`, `fixed`
`discount_percentage` | **Float** `readonly`<br>The discount percentage applied to this order. May update if order amount changes and type is `fixed`
`customer_id` | **Uuid** `nullable`<br>The associated Customer
`tax_region_id` | **Uuid** `nullable`<br>The associated Tax region
`coupon_id` | **Uuid** `nullable`<br>The associated Coupon
`start_location_id` | **Uuid** <br>The associated Start location
`stop_location_id` | **Uuid** <br>The associated Stop location


## Relationships
Orders have the following relationships:

Name | Description
-- | --
`customer` | **Customers**<br>The associated customer
`tax_region` | **Tax regions**<br>Associated Tax region
`coupon` | **Coupons**<br>Associated Coupon
`barcode` | **Barcodes**<br>Associated Barcode
`properties` | **Properties** `readonly`<br>Associated Properties
`start_location` | **Locations** `readonly`<br>The location where the customer will pick up the items.

`stop_location` | **Locations** `readonly`<br>The location where the customer will return the items.
When the clusters feature is in use, the stop location needs
to be in the same cluster as the start location.

`documents` | **Documents** `readonly`<br>Associated Documents
`transfers` | **Transfers** `readonly`<br>Associated Transfers
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
      "id": "07143c68-f149-4f0f-92f4-dc2bfe853908",
      "type": "orders",
      "attributes": {
        "created_at": "2024-06-10T09:23:26.096132+00:00",
        "updated_at": "2024-06-10T09:23:27.918593+00:00",
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
        "starts_at": "1980-04-01T12:00:00.000000+00:00",
        "stops_at": "1980-05-01T12:00:00.000000+00:00",
        "deposit_type": "percentage",
        "deposit_value": 10.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "payment_due",
        "override_period_restrictions": false,
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 10.0,
        "customer_id": "96eeb829-cc72-4e75-a135-775855d18d94",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "3521205c-d490-4165-a4ae-c940eec7d9e7",
        "stop_location_id": "3521205c-d490-4165-a4ae-c940eec7d9e7"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/96eeb829-cc72-4e75-a135-775855d18d94"
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
            "related": "api/boomerang/barcodes?filter[owner_id]=07143c68-f149-4f0f-92f4-dc2bfe853908&filter[owner_type]=orders"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=07143c68-f149-4f0f-92f4-dc2bfe853908&filter[owner_type]=orders"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/3521205c-d490-4165-a4ae-c940eec7d9e7"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/3521205c-d490-4165-a4ae-c940eec7d9e7"
          }
        },
        "documents": {
          "links": {
            "related": "api/boomerang/documents?filter[order_id]=07143c68-f149-4f0f-92f4-dc2bfe853908"
          }
        },
        "transfers": {
          "links": {
            "related": "api/boomerang/transfers?filter[order_id]=07143c68-f149-4f0f-92f4-dc2bfe853908"
          }
        },
        "tax_values": {
          "links": {
            "related": "api/boomerang/tax_values?filter[owner_id]=07143c68-f149-4f0f-92f4-dc2bfe853908&filter[owner_type]=orders"
          }
        },
        "lines": {
          "links": {
            "related": "api/boomerang/lines?filter[owner_id]=07143c68-f149-4f0f-92f4-dc2bfe853908&filter[owner_type]=orders"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[order_id]=07143c68-f149-4f0f-92f4-dc2bfe853908"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=customer,coupon,start_location`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=created_at,updated_at,number`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`, `gt`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`statuses` | **Array** <br>`eq`, `not_eq`
`status_counts` | **Hash** <br>`eq`
`starts_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_shortage` | **Boolean** <br>`eq`
`shortage` | **Boolean** <br>`eq`
`payment_status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`has_signed_contract` | **Boolean** <br>`eq`
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
`discount_value` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **Uuid** <br>`eq`, `not_eq`
`tax_region_id` | **Uuid** <br>`eq`, `not_eq`
`coupon_id` | **Uuid** <br>`eq`, `not_eq`
`start_location_id` | **Uuid** <br>`eq`, `not_eq`
`stop_location_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`item_id` | **Uuid** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`
`start_or_stop_time` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`, `between`
`any_shortage` | **Boolean** <br>`eq`
`conditions` | **Hash** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
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


`coupon`


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
                    "gte": "2024-06-11T09:23:07Z",
                    "lte": "2024-06-14T09:23:07Z"
                  }
                },
                {
                  "stops_at": {
                    "gte": "2024-06-11T09:23:07Z",
                    "lte": "2024-06-14T09:23:07Z"
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
      "id": "0756f30d-daf2-4f9b-bf3b-18b3e24f9b85"
    },
    {
      "id": "deb13c17-27e1-4160-b36a-011c8d7f8c3d"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/orders/search`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=customer,coupon,start_location`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=created_at,updated_at,number`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`, `gt`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`statuses` | **Array** <br>`eq`, `not_eq`
`status_counts` | **Hash** <br>`eq`
`starts_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_shortage` | **Boolean** <br>`eq`
`shortage` | **Boolean** <br>`eq`
`payment_status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`has_signed_contract` | **Boolean** <br>`eq`
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
`discount_value` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **Uuid** <br>`eq`, `not_eq`
`tax_region_id` | **Uuid** <br>`eq`, `not_eq`
`coupon_id` | **Uuid** <br>`eq`, `not_eq`
`start_location_id` | **Uuid** <br>`eq`, `not_eq`
`stop_location_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`item_id` | **Uuid** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`
`start_or_stop_time` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`, `between`
`any_shortage` | **Boolean** <br>`eq`
`conditions` | **Hash** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
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


`coupon`


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
    "id": "96c808f9-fab3-450b-81c4-0386972731ba",
    "type": "orders",
    "attributes": {
      "created_at": "2024-06-10T09:23:03.016516+00:00",
      "updated_at": "2024-06-10T09:23:03.041193+00:00",
      "number": null,
      "status": "new",
      "statuses": [
        "new"
      ],
      "status_counts": {
        "new": 0,
        "concept": 0,
        "reserved": 0,
        "started": 0,
        "stopped": 0
      },
      "starts_at": null,
      "stops_at": null,
      "deposit_type": "percentage",
      "deposit_value": 100.0,
      "entirely_started": true,
      "entirely_stopped": false,
      "location_shortage": false,
      "shortage": false,
      "payment_status": "paid",
      "override_period_restrictions": false,
      "has_signed_contract": false,
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
      "discount_type": "percentage",
      "discount_percentage": 0.0,
      "customer_id": null,
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "60d6ecd5-28da-4488-b308-a67f5c8d43a7",
      "stop_location_id": "60d6ecd5-28da-4488-b308-a67f5c8d43a7"
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
          "related": "api/boomerang/barcodes?filter[owner_id]=96c808f9-fab3-450b-81c4-0386972731ba&filter[owner_type]=orders"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=96c808f9-fab3-450b-81c4-0386972731ba&filter[owner_type]=orders"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/60d6ecd5-28da-4488-b308-a67f5c8d43a7"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/60d6ecd5-28da-4488-b308-a67f5c8d43a7"
        }
      },
      "documents": {
        "links": {
          "related": "api/boomerang/documents?filter[order_id]=96c808f9-fab3-450b-81c4-0386972731ba"
        }
      },
      "transfers": {
        "links": {
          "related": "api/boomerang/transfers?filter[order_id]=96c808f9-fab3-450b-81c4-0386972731ba"
        }
      },
      "tax_values": {
        "links": {
          "related": "api/boomerang/tax_values?filter[owner_id]=96c808f9-fab3-450b-81c4-0386972731ba&filter[owner_type]=orders"
        }
      },
      "lines": {
        "links": {
          "related": "api/boomerang/lines?filter[owner_id]=96c808f9-fab3-450b-81c4-0386972731ba&filter[owner_type]=orders"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[order_id]=96c808f9-fab3-450b-81c4-0386972731ba"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,customer,coupon`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`barcode`


`customer` => 
`merge_suggestion_customer`


`properties`




`coupon`


`lines`


`properties`


`start_location`


`stop_location`


`tax_region`


`tax_values`


`transfers`






## Fetching an order



> How to fetch an order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/orders/6676768c-4367-4e69-a721-53f143c6751f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6676768c-4367-4e69-a721-53f143c6751f",
    "type": "orders",
    "attributes": {
      "created_at": "2024-06-10T09:23:23.135156+00:00",
      "updated_at": "2024-06-10T09:23:24.994461+00:00",
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
      "starts_at": "1980-04-01T12:00:00.000000+00:00",
      "stops_at": "1980-05-01T12:00:00.000000+00:00",
      "deposit_type": "percentage",
      "deposit_value": 10.0,
      "entirely_started": false,
      "entirely_stopped": false,
      "location_shortage": false,
      "shortage": false,
      "payment_status": "payment_due",
      "override_period_restrictions": false,
      "has_signed_contract": false,
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
      "discount_type": "percentage",
      "discount_percentage": 10.0,
      "customer_id": "cae4abba-6acd-48a9-a5aa-bc508faf9975",
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "63952ff6-9c38-4c46-8ade-c0fac27570fd",
      "stop_location_id": "63952ff6-9c38-4c46-8ade-c0fac27570fd"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/cae4abba-6acd-48a9-a5aa-bc508faf9975"
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
          "related": "api/boomerang/barcodes?filter[owner_id]=6676768c-4367-4e69-a721-53f143c6751f&filter[owner_type]=orders"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=6676768c-4367-4e69-a721-53f143c6751f&filter[owner_type]=orders"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/63952ff6-9c38-4c46-8ade-c0fac27570fd"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/63952ff6-9c38-4c46-8ade-c0fac27570fd"
        }
      },
      "documents": {
        "links": {
          "related": "api/boomerang/documents?filter[order_id]=6676768c-4367-4e69-a721-53f143c6751f"
        }
      },
      "transfers": {
        "links": {
          "related": "api/boomerang/transfers?filter[order_id]=6676768c-4367-4e69-a721-53f143c6751f"
        }
      },
      "tax_values": {
        "links": {
          "related": "api/boomerang/tax_values?filter[owner_id]=6676768c-4367-4e69-a721-53f143c6751f&filter[owner_type]=orders"
        }
      },
      "lines": {
        "links": {
          "related": "api/boomerang/lines?filter[owner_id]=6676768c-4367-4e69-a721-53f143c6751f&filter[owner_type]=orders"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[order_id]=6676768c-4367-4e69-a721-53f143c6751f"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,customer,coupon`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`barcode`


`customer` => 
`merge_suggestion_customer`


`properties`




`coupon`


`lines`


`properties`


`start_location`


`stop_location`


`tax_region`


`tax_values`


`transfers`






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
        "type": "orders",
        "attributes": {
          "starts_at": "2024-06-13T09:23:10.667Z",
          "stops_at": "2024-07-22T09:23:10.668Z"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "547aeec3-c8fb-46d4-bdbf-cf8b9a5ca88f",
    "type": "orders",
    "attributes": {
      "created_at": "2024-06-10T09:23:10.712677+00:00",
      "updated_at": "2024-06-10T09:23:10.740456+00:00",
      "number": null,
      "status": "new",
      "statuses": [
        "new"
      ],
      "status_counts": {
        "new": 0,
        "concept": 0,
        "reserved": 0,
        "started": 0,
        "stopped": 0
      },
      "starts_at": "2024-06-13T09:15:00.000000+00:00",
      "stops_at": "2024-07-22T09:15:00.000000+00:00",
      "deposit_type": "percentage",
      "deposit_value": 100.0,
      "entirely_started": true,
      "entirely_stopped": false,
      "location_shortage": false,
      "shortage": false,
      "payment_status": "paid",
      "override_period_restrictions": false,
      "has_signed_contract": false,
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
      "discount_type": "percentage",
      "discount_percentage": 0.0,
      "customer_id": null,
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "d75395ec-47fa-4def-af13-1e206e4f33cd",
      "stop_location_id": "d75395ec-47fa-4def-af13-1e206e4f33cd"
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
      "documents": {
        "meta": {
          "included": false
        }
      },
      "transfers": {
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,customer,coupon`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][starts_at]` | **Datetime** <br>When the items on the order become unavailable
`data[attributes][stops_at]` | **Datetime** <br>When the items on the order become available again
`data[attributes][deposit_type]` | **String** <br>One of `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Float** <br>The value to use for `deposit_type`
`data[attributes][override_period_restrictions]` | **Boolean** <br>Force free period selection when there are restrictions enabled for the order period picker
`data[attributes][confirm_shortage]` | **Boolean** <br>Confirm shortage on update
`data[attributes][tag_list][]` | **Array** <br>Case insensitive tag list
`data[attributes][discount_value]` | **Float** <br>The value to use for `discount_type`
`data[attributes][discount_type]` | **String** <br>One of `percentage`, `fixed`
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer
`data[attributes][tax_region_id]` | **Uuid** <br>The associated Tax region
`data[attributes][coupon_id]` | **Uuid** <br>The associated Coupon
`data[attributes][start_location_id]` | **Uuid** <br>The associated Start location
`data[attributes][stop_location_id]` | **Uuid** <br>The associated Stop location


### Includes

This request accepts the following includes:

`barcode`


`customer` => 
`merge_suggestion_customer`


`properties`




`coupon`


`lines`


`properties`


`start_location`


`stop_location`


`tax_region`


`tax_values`


`transfers`






## Updating an order

When updating a customer on an order the following settings will be applied and prices will be calculated accordingly:

- `discount_percentage`
- `deposit_type`
- `deposit_value`
- `tax_region_id`


> How to assign a (new) customer to an order:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/orders/4f21cb4b-1e47-45c9-96ff-1132f8af4538' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "customer_id,tax_region_id,price_in_cents,grand_total_with_tax_in_cents,to_be_paid_in_cents"
      },
      "data": {
        "id": "4f21cb4b-1e47-45c9-96ff-1132f8af4538",
        "type": "orders",
        "attributes": {
          "customer_id": "a97e0233-e55e-418f-a743-fd2292ec70d8"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4f21cb4b-1e47-45c9-96ff-1132f8af4538",
    "type": "orders",
    "attributes": {
      "price_in_cents": 80250,
      "grand_total_with_tax_in_cents": 97103,
      "to_be_paid_in_cents": 197103,
      "customer_id": "a97e0233-e55e-418f-a743-fd2292ec70d8",
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
      "documents": {
        "meta": {
          "included": false
        }
      },
      "transfers": {
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
    --url 'https://example.booqable.com/api/boomerang/orders/edf999a2-ce93-4a72-9185-500abcc785f4' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "deposit_type,deposit_in_cents,to_be_paid_in_cents,deposit_paid_in_cents"
      },
      "data": {
        "id": "edf999a2-ce93-4a72-9185-500abcc785f4",
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
    "id": "edf999a2-ce93-4a72-9185-500abcc785f4",
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
      "documents": {
        "meta": {
          "included": false
        }
      },
      "transfers": {
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
    --url 'https://example.booqable.com/api/boomerang/orders/8881142d-d0a3-4c6e-bc6f-2bce0911ebb5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8881142d-d0a3-4c6e-bc6f-2bce0911ebb5",
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
      "code": "stock_item_specified",
      "status": "422",
      "title": "Stock item specified",
      "detail": "One or more items are not available",
      "meta": {
        "warning": [],
        "blocking": [
          {
            "reason": "stock_item_specified",
            "item_id": "3bba0ebb-4656-4b6c-80c5-8c81e8771e2a",
            "unavailable": [
              "593c21dc-e9f0-47c6-8f75-45e679924a50"
            ],
            "available": [
              "1a4846eb-3f8e-4d3f-a6cf-b3f3e4b037b4"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,customer,coupon`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][starts_at]` | **Datetime** <br>When items become unavailable, changing this value may result in shortages
`data[attributes][stops_at]` | **Datetime** <br>When items become available, changing this value may result in shortages
`data[attributes][deposit_type]` | **String** <br>One of `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Float** <br>The value to use for `deposit_type`
`data[attributes][override_period_restrictions]` | **Boolean** <br>Force free period selection when there are restrictions enabled for the order period picker
`data[attributes][confirm_shortage]` | **Boolean** <br>Confirm shortage on update
`data[attributes][tag_list][]` | **Array** <br>Case insensitive tag list
`data[attributes][discount_value]` | **Float** <br>The value to use for `discount_type`
`data[attributes][discount_type]` | **String** <br>One of `percentage`, `fixed`
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer
`data[attributes][tax_region_id]` | **Uuid** <br>The associated Tax region
`data[attributes][coupon_id]` | **Uuid** <br>The associated Coupon
`data[attributes][start_location_id]` | **Uuid** <br>The associated Start location
`data[attributes][stop_location_id]` | **Uuid** <br>The associated Stop location


### Includes

This request accepts the following includes:

`barcode`


`customer` => 
`merge_suggestion_customer`


`properties`




`coupon`


`lines`


`properties`


`start_location`


`stop_location`


`tax_region`


`tax_values`


`transfers`





