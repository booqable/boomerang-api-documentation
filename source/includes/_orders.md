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
`properties_attributes` | **Array** `writeonly`<br>The properties of the order
`order_delivery_rate_attributes` | **Hash** `writeonly`<br>The delivery rate of the order
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
`billing_address_property_id` | **Uuid** <br>The property id of the billing address
`delivery_address_property_id` | **Uuid** <br>The property id of the delivery address
`fulfillment_type` | **String** <br>One of `pickup`, `delivery`
`customer_id` | **Uuid** `nullable`<br>The associated customer
`tax_region_id` | **Uuid** `nullable`<br>Associated Tax region
`coupon_id` | **Uuid** `nullable`<br>Associated Coupon
`start_location_id` | **Uuid** <br>The location where the customer will pick up the items. 
`stop_location_id` | **Uuid** <br>The location where the customer will return the items.<br>When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 


## Relationships
Orders have the following relationships:

Name | Description
-- | --
`barcode` | **[Barcode](#barcodes)** <br>Associated Barcode
`coupon` | **[Coupon](#coupons)** <br>Associated Coupon
`customer` | **[Customer](#customers)** <br>The associated customer
`documents` | **[Documents](#documents)** <br>Associated Documents
`lines` | **[Lines](#lines)** <br>Associated Lines
`notes` | **[Notes](#notes)** <br>Associated Notes
`order_delivery_rate` | **[Order delivery rate](#order-delivery-rates)** <br>Associated Order delivery rate
`plannings` | **[Plannings](#plannings)** <br>Associated Plannings
`properties` | **[Properties](#properties)** <br>Associated Properties
`start_location` | **[Location](#locations)** <br>The location where the customer will pick up the items. 
`stock_item_plannings` | **[Stock item plannings](#stock-item-plannings)** <br>Associated Stock item plannings
`stop_location` | **[Location](#locations)** <br>The location where the customer will return the items.<br>When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 
`tax_region` | **[Tax region](#tax-regions)** <br>Associated Tax region
`tax_values` | **[Tax values](#tax-values)** <br>Associated Tax values
`transfers` | **[Transfers](#transfers)** <br>Associated Transfers


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
      "id": "c7b3b63d-192f-45ee-bd21-12ca8b216185",
      "type": "orders",
      "attributes": {
        "created_at": "2024-12-02T13:05:33.206312+00:00",
        "updated_at": "2024-12-02T13:05:34.754662+00:00",
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
        "billing_address_property_id": null,
        "delivery_address_property_id": null,
        "fulfillment_type": "pickup",
        "customer_id": "4604f80e-c8ef-4709-9536-c0efcab9d654",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "dd58140f-82a0-4526-99be-c68fec8895d8",
        "stop_location_id": "dd58140f-82a0-4526-99be-c68fec8895d8"
      },
      "relationships": {}
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
`billing_address_property_id` | **Uuid** <br>`eq`, `not_eq`
`delivery_address_property_id` | **Uuid** <br>`eq`, `not_eq`
`fulfillment_type` | **String** <br>`eq`
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
                    "gte": "2024-12-03T13:05:30Z",
                    "lte": "2024-12-06T13:05:30Z"
                  }
                },
                {
                  "stops_at": {
                    "gte": "2024-12-03T13:05:30Z",
                    "lte": "2024-12-06T13:05:30Z"
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
      "id": "873b0561-0b39-4dbc-ace6-190be94dbb54"
    },
    {
      "id": "fccf674a-8432-43dd-b722-ad1edec74ceb"
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
`billing_address_property_id` | **Uuid** <br>`eq`, `not_eq`
`delivery_address_property_id` | **Uuid** <br>`eq`, `not_eq`
`fulfillment_type` | **String** <br>`eq`
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
    "id": "dc42b5b3-5cbc-4952-8599-d999c2c066ba",
    "type": "orders",
    "attributes": {
      "created_at": "2024-12-02T13:05:32.633338+00:00",
      "updated_at": "2024-12-02T13:05:32.642847+00:00",
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
      "billing_address_property_id": null,
      "delivery_address_property_id": null,
      "fulfillment_type": "pickup",
      "customer_id": null,
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "217a2668-3f8d-4c5a-b59a-14fbd1cd778a",
      "stop_location_id": "217a2668-3f8d-4c5a-b59a-14fbd1cd778a"
    },
    "relationships": {}
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
`include` | **String** <br>List of comma seperated relationships `?include=barcode,coupon,customer`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`barcode`


`coupon`


`customer` => 
`merge_suggestion_customer`


`properties`




`documents`


`lines` => 
`item` => 
`barcode`


`photo`


`properties`




`planning` => 
`stock_item_plannings` => 
`stock_item` => 
`barcode`








`tax_category`




`notes`


`properties`


`start_location`


`stop_location`


`tax_region`


`tax_values`


`transfers`


`order_delivery_rate` => 
`delivery_address`








## Fetching an order



> How to fetch an order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/orders/2c978883-0c2c-479a-8c7a-1c7532d1f6af' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2c978883-0c2c-479a-8c7a-1c7532d1f6af",
    "type": "orders",
    "attributes": {
      "created_at": "2024-12-02T13:05:35.499987+00:00",
      "updated_at": "2024-12-02T13:05:37.341136+00:00",
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
      "billing_address_property_id": null,
      "delivery_address_property_id": null,
      "fulfillment_type": "pickup",
      "customer_id": "a9767f36-bc38-4496-ae14-060cb9b1f109",
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "60dd6e05-1c30-4701-b087-823e79a1f026",
      "stop_location_id": "60dd6e05-1c30-4701-b087-823e79a1f026"
    },
    "relationships": {}
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
`include` | **String** <br>List of comma seperated relationships `?include=barcode,coupon,customer`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[orders]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`barcode`


`coupon`


`customer` => 
`merge_suggestion_customer`


`properties`




`documents`


`lines` => 
`item` => 
`barcode`


`photo`


`properties`




`planning` => 
`stock_item_plannings` => 
`stock_item` => 
`barcode`








`tax_category`




`notes`


`properties`


`start_location`


`stop_location`


`tax_region`


`tax_values`


`transfers`


`order_delivery_rate` => 
`delivery_address`








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
          "starts_at": "2024-12-05T13:05:39.975Z",
          "stops_at": "2025-01-13T13:05:39.975Z"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c04f17d5-3627-49fc-b7cf-b022d05bf8c3",
    "type": "orders",
    "attributes": {
      "created_at": "2024-12-02T13:05:39.993888+00:00",
      "updated_at": "2024-12-02T13:05:40.003975+00:00",
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
      "starts_at": "2024-12-05T13:00:00.000000+00:00",
      "stops_at": "2025-01-13T13:00:00.000000+00:00",
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
      "billing_address_property_id": null,
      "delivery_address_property_id": null,
      "fulfillment_type": "pickup",
      "customer_id": null,
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "66e6e73d-3958-496f-9598-0461eee4a105",
      "stop_location_id": "66e6e73d-3958-496f-9598-0461eee4a105"
    },
    "relationships": {}
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
`include` | **String** <br>List of comma seperated relationships `?include=barcode,coupon,customer`
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
`data[attributes][properties_attributes][]` | **Array** <br>The properties of the order
`data[attributes][order_delivery_rate_attributes]` | **Hash** <br>The delivery rate of the order
`data[attributes][discount_value]` | **Float** <br>The value to use for `discount_type`
`data[attributes][discount_type]` | **String** <br>One of `percentage`, `fixed`
`data[attributes][billing_address_property_id]` | **Uuid** <br>The property id of the billing address
`data[attributes][delivery_address_property_id]` | **Uuid** <br>The property id of the delivery address
`data[attributes][fulfillment_type]` | **String** <br>One of `pickup`, `delivery`
`data[attributes][customer_id]` | **Uuid** <br>The associated customer
`data[attributes][tax_region_id]` | **Uuid** <br>Associated Tax region
`data[attributes][coupon_id]` | **Uuid** <br>Associated Coupon
`data[attributes][start_location_id]` | **Uuid** <br>The location where the customer will pick up the items. 
`data[attributes][stop_location_id]` | **Uuid** <br>The location where the customer will return the items.<br>When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 


### Includes

This request accepts the following includes:

`barcode`


`coupon`


`customer` => 
`merge_suggestion_customer`


`properties`




`documents`


`lines` => 
`item` => 
`barcode`


`photo`


`properties`




`planning` => 
`stock_item_plannings` => 
`stock_item` => 
`barcode`








`tax_category`




`notes`


`properties`


`start_location`


`stop_location`


`tax_region`


`tax_values`


`transfers`


`order_delivery_rate` => 
`delivery_address`








## Updating an order

When updating a customer on an order the following settings will be applied and prices will be calculated accordingly:

- `discount_percentage`
- `deposit_type`
- `deposit_value`
- `tax_region_id`


> How to assign a (new) customer to an order:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/orders/c76a339b-2c68-4c11-b206-0c7011db4202' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "customer_id,tax_region_id,price_in_cents,grand_total_with_tax_in_cents,to_be_paid_in_cents"
      },
      "data": {
        "id": "c76a339b-2c68-4c11-b206-0c7011db4202",
        "type": "orders",
        "attributes": {
          "customer_id": "7cd490b3-21b3-4650-9167-1c9aa4815b4a"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c76a339b-2c68-4c11-b206-0c7011db4202",
    "type": "orders",
    "attributes": {
      "price_in_cents": 80250,
      "grand_total_with_tax_in_cents": 97103,
      "to_be_paid_in_cents": 197103,
      "customer_id": "7cd490b3-21b3-4650-9167-1c9aa4815b4a",
      "tax_region_id": null
    },
    "relationships": {}
  },
  "meta": {}
}
```


> How to update the deposit_type:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/orders/80e7780f-e9af-445a-8dc6-7f1e580a7eab' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "deposit_type,deposit_in_cents,to_be_paid_in_cents,deposit_paid_in_cents"
      },
      "data": {
        "id": "80e7780f-e9af-445a-8dc6-7f1e580a7eab",
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
    "id": "80e7780f-e9af-445a-8dc6-7f1e580a7eab",
    "type": "orders",
    "attributes": {
      "deposit_type": "percentage",
      "deposit_in_cents": 10000,
      "deposit_paid_in_cents": 0,
      "to_be_paid_in_cents": 97392
    },
    "relationships": {}
  },
  "meta": {}
}
```


> Updating stops_at resulting in a shortage:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/orders/1eb39c96-2050-46c1-8927-a945c91cd247' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1eb39c96-2050-46c1-8927-a945c91cd247",
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
            "item_id": "9c576c9d-c1eb-4e24-b91d-feb3b46e176c",
            "unavailable": [
              "6b83a1c1-24cb-4da5-8832-2336f4aa9a69"
            ],
            "available": [
              "1affb8c2-854f-4d64-803a-ce286ec3abce"
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
`include` | **String** <br>List of comma seperated relationships `?include=barcode,coupon,customer`
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
`data[attributes][properties_attributes][]` | **Array** <br>The properties of the order
`data[attributes][order_delivery_rate_attributes]` | **Hash** <br>The delivery rate of the order
`data[attributes][discount_value]` | **Float** <br>The value to use for `discount_type`
`data[attributes][discount_type]` | **String** <br>One of `percentage`, `fixed`
`data[attributes][billing_address_property_id]` | **Uuid** <br>The property id of the billing address
`data[attributes][delivery_address_property_id]` | **Uuid** <br>The property id of the delivery address
`data[attributes][fulfillment_type]` | **String** <br>One of `pickup`, `delivery`
`data[attributes][customer_id]` | **Uuid** <br>The associated customer
`data[attributes][tax_region_id]` | **Uuid** <br>Associated Tax region
`data[attributes][coupon_id]` | **Uuid** <br>Associated Coupon
`data[attributes][start_location_id]` | **Uuid** <br>The location where the customer will pick up the items. 
`data[attributes][stop_location_id]` | **Uuid** <br>The location where the customer will return the items.<br>When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 


### Includes

This request accepts the following includes:

`barcode`


`coupon`


`customer` => 
`merge_suggestion_customer`


`properties`




`documents`


`lines` => 
`item` => 
`barcode`


`photo`


`properties`




`planning` => 
`stock_item_plannings` => 
`stock_item` => 
`barcode`








`tax_category`




`notes`


`properties`


`start_location`


`stop_location`


`tax_region`


`tax_values`


`transfers`


`order_delivery_rate` => 
`delivery_address`







