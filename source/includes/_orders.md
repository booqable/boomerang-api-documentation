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
`delivery_address_property_id` | **Uuid** <br>The property id of the delivery address
`delivery_billing_address_property_id` | **Uuid** <br>The property id of the delivery billing address
`fulfillment_type` | **String** <br>One of `pickup`, `delivery`
`customer_id` | **Uuid** `nullable`<br>The associated Customer
`tax_region_id` | **Uuid** `nullable`<br>The associated Tax region
`coupon_id` | **Uuid** `nullable`<br>The associated Coupon
`start_location_id` | **Uuid** <br>The associated Start location
`stop_location_id` | **Uuid** <br>The associated Stop location


## Relationships
Orders have the following relationships:

Name | Description
-- | --
`barcode` | **Barcodes** <br>Associated Barcode
`coupon` | **Coupons** <br>Associated Coupon
`customer` | **Customers** <br>The associated customer
`documents` | **Documents** `readonly`<br>Associated Documents
`lines` | **Lines** `readonly`<br>Associated Lines
`notes` | **Notes** `readonly`<br>Associated Notes
`order_delivery_rate` | **Order delivery rates** <br>Associated Order delivery rate
`plannings` | **Plannings** `readonly`<br>Associated Plannings
`properties` | **Properties** `readonly`<br>Associated Properties
`start_location` | **Locations** `readonly`<br>The location where the customer will pick up the items. 
`stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Stock item plannings
`stop_location` | **Locations** `readonly`<br>The location where the customer will return the items.<br>When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 
`tax_region` | **Tax regions** <br>Associated Tax region
`tax_values` | **Tax values** `readonly`<br>Associated Tax values
`transfers` | **Transfers** `readonly`<br>Associated Transfers


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
      "id": "caa65efd-8dcc-4a5e-98a7-910d08b38ee4",
      "type": "orders",
      "attributes": {
        "created_at": "2024-09-16T09:25:36.754581+00:00",
        "updated_at": "2024-09-16T09:25:37.989127+00:00",
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
        "delivery_address_property_id": null,
        "delivery_billing_address_property_id": null,
        "fulfillment_type": "pickup",
        "customer_id": "41788841-6166-4797-9b9a-5ce0fde56651",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "76048c88-a5c7-4bd2-bea1-d4239c4cb14d",
        "stop_location_id": "76048c88-a5c7-4bd2-bea1-d4239c4cb14d"
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
`delivery_address_property_id` | **Uuid** <br>`eq`, `not_eq`
`delivery_billing_address_property_id` | **Uuid** <br>`eq`, `not_eq`
`fulfillment_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
                    "gte": "2024-09-17T09:25:26Z",
                    "lte": "2024-09-20T09:25:26Z"
                  }
                },
                {
                  "stops_at": {
                    "gte": "2024-09-17T09:25:26Z",
                    "lte": "2024-09-20T09:25:26Z"
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
      "id": "c9d70d44-b9a1-4f01-97bd-94fa7595a7fe"
    },
    {
      "id": "48de8f8a-90e7-4949-b7a0-872fb12526ab"
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
`delivery_address_property_id` | **Uuid** <br>`eq`, `not_eq`
`delivery_billing_address_property_id` | **Uuid** <br>`eq`, `not_eq`
`fulfillment_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    "id": "786bedf8-fe36-462a-a3dd-097856d5fde9",
    "type": "orders",
    "attributes": {
      "created_at": "2024-09-16T09:25:28.257396+00:00",
      "updated_at": "2024-09-16T09:25:28.268598+00:00",
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
      "delivery_address_property_id": null,
      "delivery_billing_address_property_id": null,
      "fulfillment_type": "pickup",
      "customer_id": null,
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "5bc3c21e-7d8b-4db9-829d-3c1557c53469",
      "stop_location_id": "5bc3c21e-7d8b-4db9-829d-3c1557c53469"
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
`photo`




`planning` => 
`stock_item_plannings` => 
`stock_item`






`tax_category`




`notes`


`properties`


`start_location`


`stop_location`


`tax_region`


`tax_values`


`transfers`


`order_delivery_rate`






## Fetching an order



> How to fetch an order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/orders/799c1c8d-f403-49eb-9e8a-112f5db35f5b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "799c1c8d-f403-49eb-9e8a-112f5db35f5b",
    "type": "orders",
    "attributes": {
      "created_at": "2024-09-16T09:25:40.695679+00:00",
      "updated_at": "2024-09-16T09:25:41.847415+00:00",
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
      "delivery_address_property_id": null,
      "delivery_billing_address_property_id": null,
      "fulfillment_type": "pickup",
      "customer_id": "10d1c996-fbf5-4a92-bf40-e604ae207b22",
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "43fc7c90-589a-4cd6-af95-13e6ea94a0a9",
      "stop_location_id": "43fc7c90-589a-4cd6-af95-13e6ea94a0a9"
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
`photo`




`planning` => 
`stock_item_plannings` => 
`stock_item`






`tax_category`




`notes`


`properties`


`start_location`


`stop_location`


`tax_region`


`tax_values`


`transfers`


`order_delivery_rate`






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
          "starts_at": "2024-09-19T09:25:40.097Z",
          "stops_at": "2024-10-28T09:25:40.097Z"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ecf8d24e-1250-4d6a-a0be-ea04172219aa",
    "type": "orders",
    "attributes": {
      "created_at": "2024-09-16T09:25:40.115879+00:00",
      "updated_at": "2024-09-16T09:25:40.125086+00:00",
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
      "starts_at": "2024-09-19T09:15:00.000000+00:00",
      "stops_at": "2024-10-28T09:15:00.000000+00:00",
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
      "delivery_address_property_id": null,
      "delivery_billing_address_property_id": null,
      "fulfillment_type": "pickup",
      "customer_id": null,
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "8b453a52-3376-42e3-a6bf-1a62c9be12e6",
      "stop_location_id": "8b453a52-3376-42e3-a6bf-1a62c9be12e6"
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
`data[attributes][discount_value]` | **Float** <br>The value to use for `discount_type`
`data[attributes][discount_type]` | **String** <br>One of `percentage`, `fixed`
`data[attributes][delivery_address_property_id]` | **Uuid** <br>The property id of the delivery address
`data[attributes][delivery_billing_address_property_id]` | **Uuid** <br>The property id of the delivery billing address
`data[attributes][fulfillment_type]` | **String** <br>One of `pickup`, `delivery`
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer
`data[attributes][tax_region_id]` | **Uuid** <br>The associated Tax region
`data[attributes][coupon_id]` | **Uuid** <br>The associated Coupon
`data[attributes][start_location_id]` | **Uuid** <br>The associated Start location
`data[attributes][stop_location_id]` | **Uuid** <br>The associated Stop location


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
`photo`




`planning` => 
`stock_item_plannings` => 
`stock_item`






`tax_category`




`notes`


`properties`


`start_location`


`stop_location`


`tax_region`


`tax_values`


`transfers`


`order_delivery_rate`






## Updating an order

When updating a customer on an order the following settings will be applied and prices will be calculated accordingly:

- `discount_percentage`
- `deposit_type`
- `deposit_value`
- `tax_region_id`


> How to assign a (new) customer to an order:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/orders/5d10de7b-0ebd-4be3-8a9d-aec5744ec16a' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "customer_id,tax_region_id,price_in_cents,grand_total_with_tax_in_cents,to_be_paid_in_cents"
      },
      "data": {
        "id": "5d10de7b-0ebd-4be3-8a9d-aec5744ec16a",
        "type": "orders",
        "attributes": {
          "customer_id": "58586f72-775f-463f-8dea-95a88fd47547"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5d10de7b-0ebd-4be3-8a9d-aec5744ec16a",
    "type": "orders",
    "attributes": {
      "price_in_cents": 80250,
      "grand_total_with_tax_in_cents": 97103,
      "to_be_paid_in_cents": 197103,
      "customer_id": "58586f72-775f-463f-8dea-95a88fd47547",
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
    --url 'https://example.booqable.com/api/boomerang/orders/87aab4a1-8f0e-4164-a833-d288cf35edae' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "deposit_type,deposit_in_cents,to_be_paid_in_cents,deposit_paid_in_cents"
      },
      "data": {
        "id": "87aab4a1-8f0e-4164-a833-d288cf35edae",
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
    "id": "87aab4a1-8f0e-4164-a833-d288cf35edae",
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
    --url 'https://example.booqable.com/api/boomerang/orders/b6f8bbf4-00f0-4165-bb4f-d31d18d7165c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b6f8bbf4-00f0-4165-bb4f-d31d18d7165c",
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
            "item_id": "10e689d5-c93e-488e-8325-31a4933e52cd",
            "unavailable": [
              "9367a569-69cf-41f2-9647-ea9331f67f4f"
            ],
            "available": [
              "bfd043aa-753b-469c-926e-6f01c8031233"
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
`data[attributes][discount_value]` | **Float** <br>The value to use for `discount_type`
`data[attributes][discount_type]` | **String** <br>One of `percentage`, `fixed`
`data[attributes][delivery_address_property_id]` | **Uuid** <br>The property id of the delivery address
`data[attributes][delivery_billing_address_property_id]` | **Uuid** <br>The property id of the delivery billing address
`data[attributes][fulfillment_type]` | **String** <br>One of `pickup`, `delivery`
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer
`data[attributes][tax_region_id]` | **Uuid** <br>The associated Tax region
`data[attributes][coupon_id]` | **Uuid** <br>The associated Coupon
`data[attributes][start_location_id]` | **Uuid** <br>The associated Start location
`data[attributes][stop_location_id]` | **Uuid** <br>The associated Stop location


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
`photo`




`planning` => 
`stock_item_plannings` => 
`stock_item`






`tax_category`




`notes`


`properties`


`start_location`


`stop_location`


`tax_region`


`tax_values`


`transfers`


`order_delivery_rate`





