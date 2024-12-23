# Orders

Orders are the heart of every rental operation. They hold configuration and information about:

- The customer
  <br/>When assigning a customer to an order, the order will inherit the tax region and deposit from the customer.
- Pricing and taxes
- Deposits
- Rental period and location
  <br/>Changing these can lead to shortage, and the update will be blocked by a warning or error.
  A shortage warning can be confirmed by setting the `confirm_shortage` attribute to `true`.
- Shortages
- Payment status

## Statuses

- `new` Means the order is new, and invisible to anyone except the employee who created it.
- `concept` Does not influence availability.
- `reserved` Items on the order will be reserved and not available for other orders.
- `started` Means that the rental has started. In most cases this means items are out with a customer.
- `stopped` Items are available for other rentals again.
- `canceled` The order is canceled. Items will be available for other rentals.
- `archived` The order won't show up in default search results.

To transition an Order to the next status, create an [OrderStatusTransition](#order-status-transition).

## Relationships
Name | Description
-- | --
`barcode` | **[Barcode](#barcodes)** `optional`<br>The QR code automatically generated for this Order.
`coupon` | **[Coupon](#coupons)** `optional`<br>The Coupon added to this Order. 
`customer` | **[Customer](#customers)** `optional`<br>The Customer this Order is for. 
`documents` | **[Documents](#documents)** `hasmany`<br>Documents (quotes, contracts, invoices) related to this order. 
`lines` | **[Lines](#lines)** `hasmany`<br>All the Lines of this Order. There is an automatically generated line for every Planning. In addition there can be manually added lines for custom charges, deposit holds and sections. 
`notes` | **[Notes](#notes)** `hasmany`<br>Notes about this Order. 
`order_delivery_rate` | **[Order delivery rate](#order-delivery-rates)** `optional`<br>Information about the cost of delivery for this Order. 
`plannings` | **[Plannings](#plannings)** `hasmany`<br>The Plannings for this Order, containing the booked quantities and current status for all Products on this Order. 
`properties` | **[Properties](#properties)** `hasmany`<br>Custom but structured data added to this Order. Both Properties linked to [DefaultProperties](#default-properties), and one-off Properties can be added to orders. Properties of Orders can be updated in bulk by writing to the `properties_attributes` attribute. 
`start_location` | **[Location](#locations)** `required`<br>The Location where the Customer will pick up the items. 
`stock_item_plannings` | **[Stock item plannings](#stock-item-plannings)** `hasmany`<br>The StockItems planned on this Order, and their current status.
`stop_location` | **[Location](#locations)** `required`<br>The Location where the Customer will return the items. When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 
`tax_region` | **[Tax region](#tax-regions)** `optional`<br>TaxRegion applied to this Order. 
`tax_values` | **[Tax values](#tax-values)** `hasmany`<br>The taxes calculated for this order. There is one TaxValue for each applicable TaxRate.
`transfers` | **[Transfers](#transfers)** `hasmany`<br>Transfers that have been generated to solve shortages on this order.


Check matching attributes under [Fields](#orders-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`billing_address_property_id` | **uuid** <br>The property id of the billing address. 
`confirm_shortage` | **boolean** `writeonly`<br>Confirm shortage on update. 
`coupon_discount_in_cents` | **integer** `readonly`<br>Coupon discount (incl. or excl. taxes based on `tax_strategy`. 
`coupon_id` | **uuid** `nullable`<br>The Coupon added to this Order. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`customer_id` | **uuid** `nullable`<br>The Customer this Order is for. 
`delivery_address_property_id` | **uuid** <br>The property id of the delivery address. 
`deposit_held_in_cents` | **integer** `readonly`<br>Amount of deposit held. 
`deposit_in_cents` | **integer** `readonly`<br>Deposit. 
`deposit_paid_in_cents` | **integer** `readonly`<br>How much of the deposit is paid. 
`deposit_refunded_in_cents` | **integer** `readonly`<br>How much of the deposit is refunded. 
`deposit_to_refund_in_cents` | **integer** `readonly`<br>Amount of deposit (still) to be refunded. 
`deposit_type` | **enum** `nullable`<br>How deposit is calculated.<br> One of: `none`, `percentage_total`, `percentage`, `fixed`.
`deposit_value` | **float** <br>The value to use for `deposit_type`. 
`discount_in_cents` | **integer** `readonly`<br>Discount (incl. or excl. taxes based on `tax_strategy`). 
`discount_percentage` | **float** `readonly`<br>The discount percentage applied to this order. May update if order amount changes and type is `fixed`. 
`discount_type` | **string** <br>Type of discount. 
`discount_value` | **float** `writeonly`<br>The value to use for `discount_type`. 
`entirely_started` | **boolean** `readonly`<br>Whether all items on the order are started. 
`entirely_stopped` | **boolean** `readonly`<br>Whether all items on the order are stopped. 
`fulfillment_type` | **enum** <br>Indicates the process used to fulfill this order.<br> One of: `pickup`, `delivery`.
`grand_total_in_cents` | **integer** `readonly`<br>Total excl. taxes (excl. deposit). 
`grand_total_with_tax_in_cents` | **integer** `readonly`<br>Amount incl. taxes (excl. deposit). 
`has_signed_contract` | **boolean** `readonly`<br>Whether the order has a signed contract. 
`id` | **uuid** `readonly`<br>Primary key.
`location_shortage` | **boolean** `readonly`<br>Whether there is a shortage on the pickup location. 
`number` | **integer** `readonly`<br>The unique order number. 
`order_delivery_rate_attributes` | **hash** `writeonly`<br>Assign this attribute to create/update the order delivery rate as subresource of order in a single request. 
`override_period_restrictions` | **boolean** <br>Force free period selection when there are restrictions enabled for the order period picker. 
`paid_in_cents` | **integer** `readonly`<br>How much was paid. 
`payment_status` | **enum** `readonly`<br>Indicates next step to take wrt. payment for this order.<br> One of: `paid`, `partially_paid`, `overpaid`, `payment_due`, `process_deposit`.
`price_in_cents` | **integer** `readonly`<br>Subtotal excl. taxes (excl. deposit). 
`properties` | **hash** `readonly`<br>A hash containing all property identidiers and values (include the properties relation if you need more detailed information). Properties of orders can be updated in bulk by writing to the `properties_attributes` attribute. 
`properties_attributes` | **array** `writeonly`<br>Assign this attribute to create/update properties as subresource of order in a single request. 
`shortage` | **boolean** `readonly`<br>Whether there is a shortage for this order. 
`start_location_id` | **uuid** <br>The Location where the Customer will pick up the items. 
`starts_at` | **datetime** `nullable`<br>When the items on the order become unavailable. 
`status` | **enum** `readonly`<br>Simplified status of the order. An order can be in a mixed state. The `statuses` attribute contains the full list of current statuses, and `status_counts` specifies how many items are in each state.<br> One of: `new`, `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`.
`status_counts` | **hash** `readonly`<br>An object containing the status counts of planned products, like `{ "concept": 0, "reserved": 2, "started": 5, "stopped": 10 }`. 
`statuses` | **array** `readonly`<br>Status(es) of planned products. 
`stop_location_id` | **uuid** <br>The Location where the Customer will return the items. When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 
`stops_at` | **datetime** `nullable`<br>When the items on the order become available again. 
`tag_list` | **array[string]** <br>Case insensitive tag list. 
`tax_in_cents` | **integer** `readonly`<br>Total tax. 
`tax_region_id` | **uuid** `nullable`<br>TaxRegion applied to this Order. 
`to_be_paid_in_cents` | **integer** `readonly`<br>Amount that (still) has to be paid. 
`total_discount_in_cents` | **integer** `readonly`<br>Total discount (incl. or excl. taxes based on `tax_strategy`. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Listing orders


> How to fetch a list of orders:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/orders'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "3475c076-354c-4870-8326-459b23381f95",
        "type": "orders",
        "attributes": {
          "created_at": "2015-02-09T00:29:01.000000+00:00",
          "updated_at": "2015-02-09T00:29:01.000000+00:00",
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
          "starts_at": "1970-05-19T03:03:01.000000+00:00",
          "stops_at": "1970-06-18T03:03:01.000000+00:00",
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
          "customer_id": "5e7fb1d5-a69a-4dad-8f6c-0a321ec6da2c",
          "tax_region_id": null,
          "coupon_id": null,
          "start_location_id": "595f65d5-8218-4704-83ae-39aff6d1aeb4",
          "stop_location_id": "595f65d5-8218-4704-83ae-39aff6d1aeb4"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[orders]=created_at,updated_at,number`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=customer,coupon,start_location`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`any_shortage` | **boolean** <br>`eq`
`billing_address_property_id` | **uuid** <br>`eq`, `not_eq`
`conditions` | **hash** <br>`eq`
`coupon_discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`coupon_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **uuid** <br>`eq`, `not_eq`
`delivery_address_property_id` | **uuid** <br>`eq`, `not_eq`
`deposit_held_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **string_enum** <br>`eq`
`discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_value` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`fulfillment_type` | **string** <br>`eq`
`grand_total_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`has_signed_contract` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`, `gt`
`item_id` | **uuid** <br>`eq`
`location_shortage` | **boolean** <br>`eq`
`number` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`payment_status` | **string_enum** <br>`eq`
`price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **string** <br>`eq`
`shortage` | **boolean** <br>`eq`
`start_location_id` | **uuid** <br>`eq`, `not_eq`
`start_or_stop_time` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`, `between`
`starts_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **string_enum** <br>`eq`
`status_counts` | **hash** <br>`eq`
`statuses` | **array** <br>`eq`, `not_eq`
`stock_item_id` | **uuid** <br>`eq`
`stop_location_id` | **uuid** <br>`eq`, `not_eq`
`stops_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tag_list` | **string** <br>`eq`
`tax_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_region_id` | **uuid** <br>`eq`, `not_eq`
`to_be_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`coupon_discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_held_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_type` | **array** <br>`count`
`discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **array** <br>`maximum`, `minimum`, `average`
`grand_total_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`location_shortage` | **array** <br>`count`
`paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`payment_status` | **array** <br>`count`
`price_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`shortage` | **array** <br>`count`
`status` | **array** <br>`count`
`statuses` | **array** <br>`count`
`tag_list` | **array** <br>`count`
`tax_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`to_be_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`total` | **array** <br>`count`
`total_discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`


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
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/orders/search'
       --header 'content-type: application/json'
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
                       "gte": "2024-12-24T09:26:48Z",
                       "lte": "2024-12-27T09:26:48Z"
                     }
                   },
                   {
                     "stops_at": {
                       "gte": "2024-12-24T09:26:48Z",
                       "lte": "2024-12-27T09:26:48Z"
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
        "id": "b16cd617-07ab-4ca4-87d3-8868952b190e"
      },
      {
        "id": "6021cb4f-601d-47a1-8f99-610793da2ba1"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[orders]=created_at,updated_at,number`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=customer,coupon,start_location`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`any_shortage` | **boolean** <br>`eq`
`billing_address_property_id` | **uuid** <br>`eq`, `not_eq`
`conditions` | **hash** <br>`eq`
`coupon_discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`coupon_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **uuid** <br>`eq`, `not_eq`
`delivery_address_property_id` | **uuid** <br>`eq`, `not_eq`
`deposit_held_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **string_enum** <br>`eq`
`discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_value` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`fulfillment_type` | **string** <br>`eq`
`grand_total_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`has_signed_contract` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`, `gt`
`item_id` | **uuid** <br>`eq`
`location_shortage` | **boolean** <br>`eq`
`number` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`payment_status` | **string_enum** <br>`eq`
`price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **string** <br>`eq`
`shortage` | **boolean** <br>`eq`
`start_location_id` | **uuid** <br>`eq`, `not_eq`
`start_or_stop_time` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`, `between`
`starts_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **string_enum** <br>`eq`
`status_counts` | **hash** <br>`eq`
`statuses` | **array** <br>`eq`, `not_eq`
`stock_item_id` | **uuid** <br>`eq`
`stop_location_id` | **uuid** <br>`eq`, `not_eq`
`stops_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tag_list` | **string** <br>`eq`
`tax_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_region_id` | **uuid** <br>`eq`, `not_eq`
`to_be_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`coupon_discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_held_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_type` | **array** <br>`count`
`discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **array** <br>`maximum`, `minimum`, `average`
`grand_total_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`location_shortage` | **array** <br>`count`
`paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`payment_status` | **array** <br>`count`
`price_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`shortage` | **array** <br>`count`
`status` | **array** <br>`count`
`statuses` | **array** <br>`count`
`tag_list` | **array** <br>`count`
`tax_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`to_be_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`total` | **array** <br>`count`
`total_discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`


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
  curl --get 'https://example.booqable.com/api/boomerang/orders/new'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "952676bb-b830-4efa-8bd4-6b03b23fbe32",
      "type": "orders",
      "attributes": {
        "created_at": "2025-08-08T10:38:00.000000+00:00",
        "updated_at": "2025-08-08T10:38:00.000000+00:00",
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
        "start_location_id": "a1af9993-17e0-4410-8fd6-a096f9bcdd0d",
        "stop_location_id": "a1af9993-17e0-4410-8fd6-a096f9bcdd0d"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[orders]=created_at,updated_at,number`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,coupon,customer`


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
  curl --get 'https://example.booqable.com/api/boomerang/orders/620766b9-d5c5-4e8d-83cd-c106f1bb148e'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "620766b9-d5c5-4e8d-83cd-c106f1bb148e",
      "type": "orders",
      "attributes": {
        "created_at": "2015-07-07T09:48:01.000000+00:00",
        "updated_at": "2015-07-07T09:48:01.000000+00:00",
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
        "starts_at": "1970-10-14T12:22:01.000000+00:00",
        "stops_at": "1970-11-13T12:22:01.000000+00:00",
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
        "customer_id": "af4ff106-fdde-49e2-83ec-57302f00cd68",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "8a045d6d-cb6a-4ead-8c79-6e7bc659d7d4",
        "stop_location_id": "8a045d6d-cb6a-4ead-8c79-6e7bc659d7d4"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[orders]=created_at,updated_at,number`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,coupon,customer`


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
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/orders'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "orders",
           "attributes": {
             "starts_at": "2026-09-25T14:40:01.000000+00:00",
             "stops_at": "2026-11-03T14:40:01.000000+00:00"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "2ad70f42-1f86-4a2a-80fd-d3da815fcc0a",
      "type": "orders",
      "attributes": {
        "created_at": "2026-09-22T14:40:01.000000+00:00",
        "updated_at": "2026-09-22T14:40:01.000000+00:00",
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
        "starts_at": "2026-09-25T14:29:01.000000+00:00",
        "stops_at": "2026-11-03T14:29:01.000000+00:00",
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
        "start_location_id": "e425fa84-11b4-48c8-8c41-73bdfabc34d9",
        "stop_location_id": "e425fa84-11b4-48c8-8c41-73bdfabc34d9"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[orders]=created_at,updated_at,number`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,coupon,customer`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][billing_address_property_id]` | **uuid** <br>The property id of the billing address. 
`data[attributes][confirm_shortage]` | **boolean** <br>Confirm shortage on update. 
`data[attributes][coupon_id]` | **uuid** <br>The Coupon added to this Order. 
`data[attributes][customer_id]` | **uuid** <br>The Customer this Order is for. 
`data[attributes][delivery_address_property_id]` | **uuid** <br>The property id of the delivery address. 
`data[attributes][deposit_type]` | **enum** <br>How deposit is calculated.<br> One of: `none`, `percentage_total`, `percentage`, `fixed`.
`data[attributes][deposit_value]` | **float** <br>The value to use for `deposit_type`. 
`data[attributes][discount_type]` | **string** <br>Type of discount. 
`data[attributes][discount_value]` | **float** <br>The value to use for `discount_type`. 
`data[attributes][fulfillment_type]` | **enum** <br>Indicates the process used to fulfill this order.<br> One of: `pickup`, `delivery`.
`data[attributes][order_delivery_rate_attributes]` | **hash** <br>Assign this attribute to create/update the order delivery rate as subresource of order in a single request. 
`data[attributes][override_period_restrictions]` | **boolean** <br>Force free period selection when there are restrictions enabled for the order period picker. 
`data[attributes][properties_attributes][]` | **array** <br>Assign this attribute to create/update properties as subresource of order in a single request. 
`data[attributes][start_location_id]` | **uuid** <br>The Location where the Customer will pick up the items. 
`data[attributes][starts_at]` | **datetime** <br>When the items on the order become unavailable. 
`data[attributes][stop_location_id]` | **uuid** <br>The Location where the Customer will return the items. When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 
`data[attributes][stops_at]` | **datetime** <br>When the items on the order become available again. 
`data[attributes][tag_list]` | **array[string]** <br>Case insensitive tag list. 
`data[attributes][tax_region_id]` | **uuid** <br>TaxRegion applied to this Order. 


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
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/orders/b7fc4715-4681-4fbf-8786-f911532c94f1'
       --header 'content-type: application/json'
       --data '{
         "fields": {
           "orders": "customer_id,tax_region_id,price_in_cents,grand_total_with_tax_in_cents,to_be_paid_in_cents"
         },
         "data": {
           "id": "b7fc4715-4681-4fbf-8786-f911532c94f1",
           "type": "orders",
           "attributes": {
             "customer_id": "62778da7-58fa-4717-8474-a9bcd8c003b4"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "b7fc4715-4681-4fbf-8786-f911532c94f1",
      "type": "orders",
      "attributes": {
        "price_in_cents": 80250,
        "grand_total_with_tax_in_cents": 97103,
        "to_be_paid_in_cents": 197103,
        "customer_id": "62778da7-58fa-4717-8474-a9bcd8c003b4",
        "tax_region_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> How to update the deposit_type:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/orders/2508bac9-57f4-4320-8fe5-e3e30186754d'
       --header 'content-type: application/json'
       --data '{
         "fields": {
           "orders": "deposit_type,deposit_in_cents,to_be_paid_in_cents,deposit_paid_in_cents"
         },
         "data": {
           "id": "2508bac9-57f4-4320-8fe5-e3e30186754d",
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
      "id": "2508bac9-57f4-4320-8fe5-e3e30186754d",
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
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/orders/93a4240b-dabb-4402-8f6c-bc85a87f922c'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "93a4240b-dabb-4402-8f6c-bc85a87f922c",
           "type": "orders",
           "attributes": {
             "stops_at": "2024-06-14T15:18:00.000000+00:00"
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
              "item_id": "6b8dcfd1-8b08-4c90-8a27-22ad5a6a3ae9",
              "unavailable": [
                "e58fe3d1-2652-4c3c-8432-caf5b7148a09"
              ],
              "available": [
                "05f42f25-5487-40b6-8494-463dcf974a53"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[orders]=created_at,updated_at,number`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,coupon,customer`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][billing_address_property_id]` | **uuid** <br>The property id of the billing address. 
`data[attributes][confirm_shortage]` | **boolean** <br>Confirm shortage on update. 
`data[attributes][coupon_id]` | **uuid** <br>The Coupon added to this Order. 
`data[attributes][customer_id]` | **uuid** <br>The Customer this Order is for. 
`data[attributes][delivery_address_property_id]` | **uuid** <br>The property id of the delivery address. 
`data[attributes][deposit_type]` | **enum** <br>How deposit is calculated.<br> One of: `none`, `percentage_total`, `percentage`, `fixed`.
`data[attributes][deposit_value]` | **float** <br>The value to use for `deposit_type`. 
`data[attributes][discount_type]` | **string** <br>Type of discount. 
`data[attributes][discount_value]` | **float** <br>The value to use for `discount_type`. 
`data[attributes][fulfillment_type]` | **enum** <br>Indicates the process used to fulfill this order.<br> One of: `pickup`, `delivery`.
`data[attributes][order_delivery_rate_attributes]` | **hash** <br>Assign this attribute to create/update the order delivery rate as subresource of order in a single request. 
`data[attributes][override_period_restrictions]` | **boolean** <br>Force free period selection when there are restrictions enabled for the order period picker. 
`data[attributes][properties_attributes][]` | **array** <br>Assign this attribute to create/update properties as subresource of order in a single request. 
`data[attributes][start_location_id]` | **uuid** <br>The Location where the Customer will pick up the items. 
`data[attributes][starts_at]` | **datetime** <br>When items become unavailable, changing this value may result in shortages
`data[attributes][stop_location_id]` | **uuid** <br>The Location where the Customer will return the items. When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 
`data[attributes][stops_at]` | **datetime** <br>When items become available, changing this value may result in shortages
`data[attributes][tag_list]` | **array[string]** <br>Case insensitive tag list. 
`data[attributes][tax_region_id]` | **uuid** <br>TaxRegion applied to this Order. 


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







