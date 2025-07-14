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

To transition an Order to the next status, create an [OrderStatusTransition](#order-status-transitions).

<aside class="warning">
  The <code>concept</code> status will be renamed to <code>draft</code> in the near future.
</aside>

## Status Transitions and Workflow

Orders typically follow this workflow:

1. `new` → `concept` through [OrderStatusTransition](#order-status-transitions)
2. `concept` → `reserved` through [OrderStatusTransition](#order-status-transitions)
3. `reserved` → `started` (pickup/delivery) through [OrderFulfillment](#order-fulfillments)
4. `started` → `stopped` (return/completion) through [OrderFulfillment](#order-fulfillments)
5. `stopped` → `archived` through [OrderStatusTransition](#order-status-transitions)

Note that `concept` and `reserved` states can be skipped.
An order can go from `new` to `started` directly when items are picked up.

## Shortage Handling

There are two types of shortage indicators:
- `shortage`: Indicates there's a shortage anywhere in the system
- `location_shortage`: Indicates there's a shortage specifically at the pickup location

When updating an order causes a shortage, you'll receive an error response with details about the shortage. To confirm and proceed despite the shortage, include `confirm_shortage: true` in your update request.

## Fulfillment Types

Orders can have different fulfillment types that define how items are provided to customers:
- `pickup`: Customer collects items from a location
- `delivery`: Items are delivered to the customer

The fulfillment type affects address requirements, delivery costs, and order processing.

## Payment Statuses

The `payment_status` field indicates the current payment state:
- `paid`: All order amounts have been paid
- `partially_paid`: Some payments have been made but the full amount is not yet paid
- `overpaid`: More has been paid than required
- `payment_due`: Payment is still required
- `process_deposit`: A deposit needs to be processed

## Deposit Handling

Deposits can be calculated and applied in different ways:
- `none`: No deposit is required
- `percentage`: Deposit is a percentage of the item prices
- `percentage_total`: Deposit is a percentage of the total order amount
- `fixed`: Deposit is a fixed amount

The `deposit_value` field determines the percentage or fixed amount, and various deposit-related fields track payment and refund status.

## Relationships
Name | Description
-- | --
`barcode` | **[Barcode](#barcodes)** `optional`<br>The QR code automatically generated for this Order. 
`coupon` | **[Coupon](#coupons)** `optional`<br>The [Coupon](#coupons) added to this Order. 
`customer` | **[Customer](#customers)** `optional`<br>The [Customer](#customers) this Order is for. 
`documents` | **[Documents](#documents)** `hasmany`<br>[Documents](#documents) (quotes, contracts, invoices) related to this order. 
`lines` | **[Lines](#lines)** `hasmany`<br>All the [Lines](#lines) of this Order. There is an automatically generated line for every Planning. In addition there can be manually added lines for custom charges, deposit holds and sections. 
`notes` | **[Notes](#notes)** `hasmany`<br>[Notes](#notes) about this Order. 
`order_delivery_rate` | **[Order delivery rate](#order-delivery-rates)** `optional`<br>Information about the cost of delivery for this Order. 
`payments` | **[Payments](#payments)** `hasmany`<br>[Payments](#payments) (charges, authorizations, refunds) related to this order. 
`plannings` | **[Plannings](#plannings)** `hasmany`<br>The [Plannings](#plannings) for this Order, containing the booked quantities and current status for all Products on this Order. 
`properties` | **[Properties](#properties)** `hasmany`<br>Custom but structured data added to this Order. Both Properties linked to [DefaultProperties](#default-properties), and one-off Properties can be added to orders. Properties of Orders can be updated in bulk by writing to the `properties_attributes` attribute. 
`start_location` | **[Location](#locations)** `required`<br>The [Location](#locations) where the customer will pick up the items. 
`stock_item_plannings` | **[Stock item plannings](#stock-item-plannings)** `hasmany`<br>The [StockItemPlannings](#stock-item-plannings) planned on this Order, and their current status. 
`stop_location` | **[Location](#locations)** `required`<br>The [Location](#locations) where the customer will return the items. When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 
`tax_region` | **[Tax region](#tax-regions)** `optional`<br>[TaxRegion](#tax-regions) applied to this Order. 
`tax_values` | **[Tax values](#tax-values)** `hasmany`<br>The taxes calculated for this order. There is one [TaxValue](#tax-values) for each applicable [TaxRate](#tax-rates). 
`transfers` | **[Transfers](#transfers)** `hasmany`<br>[Transfers](#transfers) that have been generated to solve shortages on this order. 


Check matching attributes under [Fields](#orders-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`amount_in_cents` | **integer** `readonly`<br>The rental amount excluding taxes. 
`amount_paid_in_cents` | **integer** `readonly`<br>The portion of the rental amount that has been paid. 
`amount_to_be_paid_in_cents` | **integer** `readonly`<br>The portion of the rental amount that still needs to be paid. 
`billing_address_property_id` | **uuid** <br>The property id of the billing address. 
`confirm_shortage` | **boolean** `writeonly`<br>When set to `true`, this confirms a shortage warning during an update operation. Use this parameter when you receive a shortage warning but want to proceed with the update despite the shortage. Overriding shortage is only possible when the affected [ProductGroup](#product-groups) is configured to allow shortage. 
`coupon_discount_in_cents` | **integer** `readonly`<br>Coupon discount (incl. or excl. taxes based on `tax_strategy`). 
`coupon_id` | **uuid** `nullable`<br>The [Coupon](#coupons) added to this Order. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`customer_id` | **uuid** `nullable`<br>The [Customer](#customers) this Order is for. 
`delivery_address` | **string** <br>The delivery address. 
`delivery_address_property_id` | **uuid** <br>The property id of the delivery address. 
`deposit_held_in_cents` | **integer** `readonly`<br>Amount of deposit held. 
`deposit_in_cents` | **integer** `readonly`<br>Deposit. 
`deposit_paid_in_cents` | **integer** `readonly`<br>How much of the deposit is paid. 
`deposit_refunded_in_cents` | **integer** `readonly`<br>How much of the deposit is refunded. 
`deposit_to_be_paid_in_cents` | **integer** `readonly`<br>The portion of the deposit that still needs to be paid. 
`deposit_to_refund_in_cents` | **integer** `readonly`<br>Amount of deposit (still) to be refunded. 
`deposit_type` | **enum** `nullable`<br>How deposit is calculated.<br> One of: `none`, `percentage_total`, `percentage`, `fixed`.
`deposit_value` | **float** <br>The value to use for `deposit_type`. 
`discount_in_cents` | **integer** `readonly`<br>Discount (incl. or excl. taxes based on `tax_strategy`). 
`discount_percentage` | **float** `readonly`<br>The discount percentage applied to this order. May update if order amount changes and type is `fixed`. 
`discount_type` | **enum** <br>Type of discount.<br> One of: `percentage`, `fixed`.
`discount_value` | **float** `writeonly`<br>The value to use for `discount_type`. 
`entirely_started` | **boolean** `readonly`<br>Whether all items on the order are started. 
`entirely_stopped` | **boolean** `readonly`<br>Whether all items on the order are stopped. 
`fulfillment_type` | **enum** <br>Indicates the process used to fulfill this order. Values can be `pickup` (customer collects items from a location) or `delivery` (items are delivered to the customer's address). This affects which address fields are required and whether delivery charges apply.<br> One of: `pickup`, `delivery`.
`grand_total_in_cents` | **integer** `readonly`<br>Total excl. taxes (excl. deposit). 
`grand_total_with_tax_in_cents` | **integer** `readonly`<br>Amount incl. taxes (excl. deposit). 
`has_signed_contract` | **boolean** `readonly`<br>Whether the order has a signed contract. 
`id` | **uuid** `readonly`<br>Primary key.
`item_count` | **integer** `readonly`<br>The number of items on the order. 
`location_shortage` | **boolean** `readonly`<br>Whether there is a shortage on the pickup location. This is `true` when the requested items are not available at the specific `start_location` selected for the order, even if they might be available at other locations in the same cluster. 
`number` | **integer** `readonly`<br>The unique order number. 
`order_delivery_rate_attributes` | **hash** `writeonly`<br>Assign this attribute to create/update the order delivery rate as subresource of order in a single request. 
`order_delivery_rate_id` | **uuid** `nullable`<br>The id of the order delivery rate. 
`override_period_restrictions` | **boolean** <br>Force free period selection when there are restrictions enabled for the order period picker. 
`paid_in_cents` | **integer** `readonly`<br>How much was paid. 
`payment_status` | **enum** `readonly`<br>Indicates next step to take with respect to payment for this order. Values include `paid` (fully paid), `partially_paid` (some payments made), `overpaid` (more paid than required), `payment_due` (balance still due), or `process_deposit` (deposit needs processing).<br> One of: `paid`, `partially_paid`, `overpaid`, `payment_due`, `process_deposit`.
`price_in_cents` | **integer** `readonly`<br>Subtotal excl. taxes (excl. deposit). 
`properties` | **hash** `readonly`<br>A hash containing all property identifiers and values (include the properties relation if you need more detailed information). Properties of orders can be updated in bulk by writing to the `properties_attributes` attribute. 
`properties_attributes` | **array** `writeonly`<br>Assign this attribute to create/update properties as subresource of order in a single request. 
`shortage` | **boolean** `readonly`<br>Whether there is a shortage for this order. This indicates that the requested quantity of one or more items cannot be fulfilled during the specified rental period. 
`start_location_id` | **uuid** <br>The [Location](#locations) where the customer will pick up the items. 
`starts_at` | **datetime** `nullable`<br>When the items on the order become unavailable. This is the date/time when the rental period officially begins. Changing this date may result in shortages if the items are no longer available for the new time period. 
`status` | **enum** `readonly-after-create`<br>Simplified status of the order. An order can be in a mixed state (i.e. partially started or stopped).<br>The `statuses` attribute contains the full list of current statuses, and `status_counts` specifies how many items are in each state.<br>This attribute can only be written when creating an order. Accepted statuses are `new`, `concept`, `draft` and `reserved`.<br><aside class="warning inline">   The <code>concept</code> status will be renamed to <code>draft</code> in the near future.   For a short while both values will be accepted when using this API to create a new Order,   but the new value <code>draft</code> should be used as soon as possible. </aside><br> One of: `new`, `concept`, `draft`, `reserved`, `started`, `stopped`, `archived`, `canceled`.
`status_counts` | **hash** `readonly`<br>An object containing the status counts of planned products, like `{ "concept": 0, "reserved": 2, "started": 5, "stopped": 10 }`.<br><aside class="warning inline">   The <code>concept</code> status will be renamed to <code>draft</code> in the near future. </aside> 
`statuses` | **array** `readonly`<br>Status(es) of planned products.<br><aside class="warning inline">   The <code>concept</code> status will be renamed to <code>draft</code> in the near future. </aside> 
`stop_location_id` | **uuid** <br>The [Location](#locations) where the customer will return the items. When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 
`stops_at` | **datetime** `nullable`<br>When the items on the order become available again. This is the date/time when the rental period officially ends, and inventory becomes available for other orders after this point. Extending this date may result in shortages if the items are already booked for other orders. 
`tag_list` | **array[string]** <br>Case insensitive tag list. 
`tax_in_cents` | **integer** `readonly`<br>Total tax. 
`tax_region_id` | **uuid** `nullable`<br>[TaxRegion](#tax-regions) applied to this Order. 
`to_be_paid_in_cents` | **integer** `readonly`<br>Amount that (still) has to be paid. 
`total_discount_in_cents` | **integer** `readonly`<br>Total discount (incl. or excl. taxes based on `tax_strategy`). 
`total_in_cents` | **integer** `readonly`<br>The total order amount including rental amount, taxes, and deposit. 
`total_paid_in_cents` | **integer** `readonly`<br>The total amount that has been paid for this order. 
`total_to_be_paid_in_cents` | **integer** `readonly`<br>The total amount remaining to be paid for this order. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List orders


> How to fetch a list of orders:

```shell
  curl --get 'https://example.booqable.com/api/4/orders'
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
          "starts_at": "1969-11-04T03:03:01.000000+00:00",
          "stops_at": "1969-12-04T03:03:01.000000+00:00",
          "deposit_type": "percentage",
          "deposit_value": 10.0,
          "entirely_started": false,
          "entirely_stopped": false,
          "location_shortage": false,
          "shortage": false,
          "payment_status": "payment_due",
          "override_period_restrictions": false,
          "has_signed_contract": false,
          "item_count": 1,
          "tag_list": [
            "webshop"
          ],
          "properties": {
            "delivery_address": null,
            "billing_address": null
          },
          "amount_in_cents": 87392,
          "amount_paid_in_cents": 0,
          "amount_to_be_paid_in_cents": 87392,
          "deposit_in_cents": 10000,
          "deposit_held_in_cents": 0,
          "deposit_paid_in_cents": 0,
          "deposit_to_be_paid_in_cents": 10000,
          "deposit_refunded_in_cents": 0,
          "deposit_to_refund_in_cents": 0,
          "total_in_cents": 97392,
          "total_paid_in_cents": 0,
          "total_to_be_paid_in_cents": 97392,
          "total_discount_in_cents": 8025,
          "coupon_discount_in_cents": 0,
          "discount_in_cents": 8025,
          "grand_total_in_cents": 72225,
          "grand_total_with_tax_in_cents": 87392,
          "paid_in_cents": 0,
          "price_in_cents": 80250,
          "tax_in_cents": 15167,
          "to_be_paid_in_cents": 97392,
          "discount_type": "percentage",
          "discount_percentage": 10.0,
          "billing_address_property_id": null,
          "delivery_address_property_id": null,
          "fulfillment_type": "pickup",
          "delivery_address": null,
          "customer_id": "5e7fb1d5-a69a-4dad-8f6c-0a321ec6da2c",
          "tax_region_id": null,
          "coupon_id": null,
          "start_location_id": "595f65d5-8218-4704-83ae-39aff6d1aeb4",
          "stop_location_id": "595f65d5-8218-4704-83ae-39aff6d1aeb4",
          "order_delivery_rate_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/orders`

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
`amount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`amount_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`amount_to_be_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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
`deposit_to_be_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **enum** <br>`eq`
`discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_type` | **enum** <br>`eq`
`discount_value` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`fulfillment_type` | **string** <br>`eq`
`grand_total_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`has_signed_contract` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`, `gt`
`item_count` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`item_id` | **uuid** <br>`eq`
`location_shortage` | **boolean** <br>`eq`
`number` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_delivery_rate_id` | **uuid** <br>`eq`, `not_eq`
`paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`payment_status` | **enum** <br>`eq`
`price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **string** <br>`eq`
`shortage` | **boolean** <br>`eq`
`start_location_id` | **uuid** <br>`eq`, `not_eq`
`start_or_stop_time` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`, `between`
`starts_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **enum** <br>`eq`
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
`total_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_to_be_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`amount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`amount_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`amount_to_be_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`coupon_discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_held_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_be_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_type` | **array** <br>`count`
`discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **array** <br>`maximum`, `minimum`, `average`
`fulfillment_type` | **array** <br>`count`
`grand_total_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`item_count` | **array** <br>`sum`, `maximum`, `minimum`, `average`
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
`total_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`total_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`total_to_be_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

<ul>
  <li><code>coupon</code></li>
  <li><code>customer</code></li>
  <li><code>properties</code></li>
  <li><code>start_location</code></li>
  <li><code>stop_location</code></li>
</ul>


## Search orders

Use advanced search to make logical filter groups with and/or operators.

> How to search for orders:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/orders/search'
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
                       "gte": "2025-07-08T09:26:45Z",
                       "lte": "2025-07-11T09:26:45Z"
                     }
                   },
                   {
                     "stops_at": {
                       "gte": "2025-07-08T09:26:45Z",
                       "lte": "2025-07-11T09:26:45Z"
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

`POST /api/4/orders/search`

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
`amount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`amount_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`amount_to_be_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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
`deposit_to_be_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **enum** <br>`eq`
`discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_type` | **enum** <br>`eq`
`discount_value` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`fulfillment_type` | **string** <br>`eq`
`grand_total_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`has_signed_contract` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`, `gt`
`item_count` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`item_id` | **uuid** <br>`eq`
`location_shortage` | **boolean** <br>`eq`
`number` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_delivery_rate_id` | **uuid** <br>`eq`, `not_eq`
`paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`payment_status` | **enum** <br>`eq`
`price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **string** <br>`eq`
`shortage` | **boolean** <br>`eq`
`start_location_id` | **uuid** <br>`eq`, `not_eq`
`start_or_stop_time` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`, `between`
`starts_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **enum** <br>`eq`
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
`total_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_to_be_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`amount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`amount_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`amount_to_be_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`coupon_discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_held_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_be_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_type` | **array** <br>`count`
`discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **array** <br>`maximum`, `minimum`, `average`
`fulfillment_type` | **array** <br>`count`
`grand_total_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`item_count` | **array** <br>`sum`, `maximum`, `minimum`, `average`
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
`total_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`total_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`total_to_be_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

<ul>
  <li><code>coupon</code></li>
  <li><code>customer</code></li>
  <li><code>properties</code></li>
  <li><code>start_location</code></li>
  <li><code>stop_location</code></li>
</ul>


## New order

Returns an existing or new order for the current employee.

> How to fetch a new order:

```shell
  curl --get 'https://example.booqable.com/api/4/orders/new'
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
        "start_location_id": "a1af9993-17e0-4410-8fd6-a096f9bcdd0d",
        "stop_location_id": "a1af9993-17e0-4410-8fd6-a096f9bcdd0d",
        "order_delivery_rate_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/orders/new`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[orders]=created_at,updated_at,number`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,coupon,customer`


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>coupon</code></li>
  <li>
    <code>customer</code>
    <ul>
      <li><code>merge_suggestion_customer</code></li>
      <li><code>payment_methods</code></li>
      <li><code>properties</code></li>
    </ul>
  </li>
  <li><code>documents</code></li>
  <li>
    <code>lines</code>
    <ul>
      <li>
          <code>item</code>
          <ul>
            <li><code>barcode</code></li>
            <li><code>photo</code></li>
            <li><code>properties</code></li>
          </ul>
      </li>
      <li>
          <code>planning</code>
          <ul>
            <li>
                  <code>stock_item_plannings</code>
                  <ul>
                    <li>
                            <code>stock_item</code>
                            <ul>
                              <li><code>barcode</code></li>
                            </ul>
                    </li>
                  </ul>
            </li>
          </ul>
      </li>
      <li><code>tax_category</code></li>
    </ul>
  </li>
  <li><code>notes</code></li>
  <li><code>order_delivery_rate</code></li>
  <li>
    <code>payments</code>
    <ul>
      <li><code>payment_method</code></li>
    </ul>
  </li>
  <li><code>properties</code></li>
  <li><code>start_location</code></li>
  <li><code>stop_location</code></li>
  <li><code>tax_region</code></li>
  <li><code>tax_values</code></li>
  <li><code>transfers</code></li>
</ul>


## Fetch an order


> How to fetch an order:

```shell
  curl --get 'https://example.booqable.com/api/4/orders/620766b9-d5c5-4e8d-83cd-c106f1bb148e'
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
        "starts_at": "1970-04-01T12:22:01.000000+00:00",
        "stops_at": "1970-05-01T12:22:01.000000+00:00",
        "deposit_type": "percentage",
        "deposit_value": 10.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "payment_due",
        "override_period_restrictions": false,
        "has_signed_contract": false,
        "item_count": 1,
        "tag_list": [
          "webshop"
        ],
        "properties": {
          "delivery_address": null,
          "billing_address": null
        },
        "amount_in_cents": 87392,
        "amount_paid_in_cents": 0,
        "amount_to_be_paid_in_cents": 87392,
        "deposit_in_cents": 10000,
        "deposit_held_in_cents": 0,
        "deposit_paid_in_cents": 0,
        "deposit_to_be_paid_in_cents": 10000,
        "deposit_refunded_in_cents": 0,
        "deposit_to_refund_in_cents": 0,
        "total_in_cents": 97392,
        "total_paid_in_cents": 0,
        "total_to_be_paid_in_cents": 97392,
        "total_discount_in_cents": 8025,
        "coupon_discount_in_cents": 0,
        "discount_in_cents": 8025,
        "grand_total_in_cents": 72225,
        "grand_total_with_tax_in_cents": 87392,
        "paid_in_cents": 0,
        "price_in_cents": 80250,
        "tax_in_cents": 15167,
        "to_be_paid_in_cents": 97392,
        "discount_type": "percentage",
        "discount_percentage": 10.0,
        "billing_address_property_id": null,
        "delivery_address_property_id": null,
        "fulfillment_type": "pickup",
        "delivery_address": null,
        "customer_id": "af4ff106-fdde-49e2-83ec-57302f00cd68",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "8a045d6d-cb6a-4ead-8c79-6e7bc659d7d4",
        "stop_location_id": "8a045d6d-cb6a-4ead-8c79-6e7bc659d7d4",
        "order_delivery_rate_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/orders/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[orders]=created_at,updated_at,number`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,coupon,customer`


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>coupon</code></li>
  <li>
    <code>customer</code>
    <ul>
      <li><code>merge_suggestion_customer</code></li>
      <li><code>payment_methods</code></li>
      <li><code>properties</code></li>
    </ul>
  </li>
  <li><code>documents</code></li>
  <li>
    <code>lines</code>
    <ul>
      <li>
          <code>item</code>
          <ul>
            <li><code>barcode</code></li>
            <li><code>photo</code></li>
            <li><code>properties</code></li>
          </ul>
      </li>
      <li>
          <code>planning</code>
          <ul>
            <li>
                  <code>stock_item_plannings</code>
                  <ul>
                    <li>
                            <code>stock_item</code>
                            <ul>
                              <li><code>barcode</code></li>
                            </ul>
                    </li>
                  </ul>
            </li>
          </ul>
      </li>
      <li><code>tax_category</code></li>
    </ul>
  </li>
  <li><code>notes</code></li>
  <li><code>order_delivery_rate</code></li>
  <li>
    <code>payments</code>
    <ul>
      <li><code>payment_method</code></li>
    </ul>
  </li>
  <li><code>properties</code></li>
  <li><code>start_location</code></li>
  <li><code>stop_location</code></li>
  <li><code>tax_region</code></li>
  <li><code>tax_values</code></li>
  <li><code>transfers</code></li>
</ul>


## Create an order

When creating an order it is possible to choose the initial status. Accepted statuses
are `new`, `concept`, `draft` and `reserved`.

<aside class="warning">
  The <code>concept</code> status will be renamed to <code>draft</code> in the near future.
  For a short while both values will be accepted when using this API to create a new Order,
  but the new value <code>draft</code> should be used as soon as possible.
</aside>

When the following attributes are not specified, a sensible default will be picked:

- `deposit_type` - From customer settings, or global default deposit type.
- `deposit_value` - From customer settings, or global default deposit type.
- `discount_type` - From customer settings.
- `tax_region_id` - From customer settings.
- `start_location_id` - First created active location.
- `stop_location_id` - First created active location.

> How to create an order:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/orders'
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
        "start_location_id": "e425fa84-11b4-48c8-8c41-73bdfabc34d9",
        "stop_location_id": "e425fa84-11b4-48c8-8c41-73bdfabc34d9",
        "order_delivery_rate_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/orders`

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
`data[attributes][confirm_shortage]` | **boolean** <br>When set to `true`, this confirms a shortage warning during an update operation. Use this parameter when you receive a shortage warning but want to proceed with the update despite the shortage. Overriding shortage is only possible when the affected [ProductGroup](#product-groups) is configured to allow shortage. 
`data[attributes][coupon_id]` | **uuid** <br>The [Coupon](#coupons) added to this Order. 
`data[attributes][customer_id]` | **uuid** <br>The [Customer](#customers) this Order is for. 
`data[attributes][delivery_address]` | **string** <br>The delivery address. 
`data[attributes][delivery_address_property_id]` | **uuid** <br>The property id of the delivery address. 
`data[attributes][deposit_type]` | **enum** <br>How deposit is calculated.<br> One of: `none`, `percentage_total`, `percentage`, `fixed`.
`data[attributes][deposit_value]` | **float** <br>The value to use for `deposit_type`. 
`data[attributes][discount_type]` | **enum** <br>Type of discount.<br> One of: `percentage`, `fixed`.
`data[attributes][discount_value]` | **float** <br>The value to use for `discount_type`. 
`data[attributes][fulfillment_type]` | **enum** <br>Indicates the process used to fulfill this order. Values can be `pickup` (customer collects items from a location) or `delivery` (items are delivered to the customer's address). This affects which address fields are required and whether delivery charges apply.<br> One of: `pickup`, `delivery`.
`data[attributes][order_delivery_rate_attributes]` | **hash** <br>Assign this attribute to create/update the order delivery rate as subresource of order in a single request. 
`data[attributes][order_delivery_rate_id]` | **uuid** <br>The id of the order delivery rate. 
`data[attributes][override_period_restrictions]` | **boolean** <br>Force free period selection when there are restrictions enabled for the order period picker. 
`data[attributes][properties_attributes][]` | **array** <br>Assign this attribute to create/update properties as subresource of order in a single request. 
`data[attributes][start_location_id]` | **uuid** <br>The [Location](#locations) where the customer will pick up the items. 
`data[attributes][starts_at]` | **datetime** <br>When the items on the order become unavailable. This is the date/time when the rental period officially begins. Changing this date may result in shortages if the items are no longer available for the new time period. 
`data[attributes][status]` | **enum** <br>Simplified status of the order. An order can be in a mixed state (i.e. partially started or stopped).<br>The `statuses` attribute contains the full list of current statuses, and `status_counts` specifies how many items are in each state.<br>This attribute can only be written when creating an order. Accepted statuses are `new`, `concept`, `draft` and `reserved`.<br><aside class="warning inline">   The <code>concept</code> status will be renamed to <code>draft</code> in the near future.   For a short while both values will be accepted when using this API to create a new Order,   but the new value <code>draft</code> should be used as soon as possible. </aside><br> One of: `new`, `concept`, `draft`, `reserved`, `started`, `stopped`, `archived`, `canceled`.
`data[attributes][stop_location_id]` | **uuid** <br>The [Location](#locations) where the customer will return the items. When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 
`data[attributes][stops_at]` | **datetime** <br>When the items on the order become available again. This is the date/time when the rental period officially ends, and inventory becomes available for other orders after this point. Extending this date may result in shortages if the items are already booked for other orders. 
`data[attributes][tag_list]` | **array[string]** <br>Case insensitive tag list. 
`data[attributes][tax_region_id]` | **uuid** <br>[TaxRegion](#tax-regions) applied to this Order. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>coupon</code></li>
  <li>
    <code>customer</code>
    <ul>
      <li><code>merge_suggestion_customer</code></li>
      <li><code>payment_methods</code></li>
      <li><code>properties</code></li>
    </ul>
  </li>
  <li><code>documents</code></li>
  <li>
    <code>lines</code>
    <ul>
      <li>
          <code>item</code>
          <ul>
            <li><code>barcode</code></li>
            <li><code>photo</code></li>
            <li><code>properties</code></li>
          </ul>
      </li>
      <li>
          <code>planning</code>
          <ul>
            <li>
                  <code>stock_item_plannings</code>
                  <ul>
                    <li>
                            <code>stock_item</code>
                            <ul>
                              <li><code>barcode</code></li>
                            </ul>
                    </li>
                  </ul>
            </li>
          </ul>
      </li>
      <li><code>tax_category</code></li>
    </ul>
  </li>
  <li><code>notes</code></li>
  <li><code>order_delivery_rate</code></li>
  <li>
    <code>payments</code>
    <ul>
      <li><code>payment_method</code></li>
    </ul>
  </li>
  <li><code>properties</code></li>
  <li><code>start_location</code></li>
  <li><code>stop_location</code></li>
  <li><code>tax_region</code></li>
  <li><code>tax_values</code></li>
  <li><code>transfers</code></li>
</ul>


## Update an order

When updating a customer on an order the following settings will be applied and prices will be calculated accordingly:

- `discount_percentage`
- `deposit_type`
- `deposit_value`
- `tax_region_id`

> How to assign a (new) customer to an order:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/orders/b7fc4715-4681-4fbf-8786-f911532c94f1'
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
        "grand_total_with_tax_in_cents": 97103,
        "price_in_cents": 80250,
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
       --url 'https://example.booqable.com/api/4/orders/2508bac9-57f4-4320-8fe5-e3e30186754d'
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
       --url 'https://example.booqable.com/api/4/orders/93a4240b-dabb-4402-8f6c-bc85a87f922c'
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

`PUT /api/4/orders/{id}`

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
`data[attributes][confirm_shortage]` | **boolean** <br>When set to `true`, this confirms a shortage warning during an update operation. Use this parameter when you receive a shortage warning but want to proceed with the update despite the shortage. Overriding shortage is only possible when the affected [ProductGroup](#product-groups) is configured to allow shortage. 
`data[attributes][coupon_id]` | **uuid** <br>The [Coupon](#coupons) added to this Order. 
`data[attributes][customer_id]` | **uuid** <br>The [Customer](#customers) this Order is for. 
`data[attributes][delivery_address]` | **string** <br>The delivery address. 
`data[attributes][delivery_address_property_id]` | **uuid** <br>The property id of the delivery address. 
`data[attributes][deposit_type]` | **enum** <br>How deposit is calculated.<br> One of: `none`, `percentage_total`, `percentage`, `fixed`.
`data[attributes][deposit_value]` | **float** <br>The value to use for `deposit_type`. 
`data[attributes][discount_type]` | **enum** <br>Type of discount.<br> One of: `percentage`, `fixed`.
`data[attributes][discount_value]` | **float** <br>The value to use for `discount_type`. 
`data[attributes][fulfillment_type]` | **enum** <br>Indicates the process used to fulfill this order. Values can be `pickup` (customer collects items from a location) or `delivery` (items are delivered to the customer's address). This affects which address fields are required and whether delivery charges apply.<br> One of: `pickup`, `delivery`.
`data[attributes][order_delivery_rate_attributes]` | **hash** <br>Assign this attribute to create/update the order delivery rate as subresource of order in a single request. 
`data[attributes][order_delivery_rate_id]` | **uuid** <br>The id of the order delivery rate. 
`data[attributes][override_period_restrictions]` | **boolean** <br>Force free period selection when there are restrictions enabled for the order period picker. 
`data[attributes][properties_attributes][]` | **array** <br>Assign this attribute to create/update properties as subresource of order in a single request. 
`data[attributes][start_location_id]` | **uuid** <br>The [Location](#locations) where the customer will pick up the items. 
`data[attributes][starts_at]` | **datetime** <br>When items become unavailable, changing this value may result in shortages
`data[attributes][status]` | **enum** <br>Simplified status of the order. An order can be in a mixed state (i.e. partially started or stopped).<br>The `statuses` attribute contains the full list of current statuses, and `status_counts` specifies how many items are in each state.<br>This attribute can only be written when creating an order. Accepted statuses are `new`, `concept`, `draft` and `reserved`.<br><aside class="warning inline">   The <code>concept</code> status will be renamed to <code>draft</code> in the near future.   For a short while both values will be accepted when using this API to create a new Order,   but the new value <code>draft</code> should be used as soon as possible. </aside><br> One of: `new`, `concept`, `draft`, `reserved`, `started`, `stopped`, `archived`, `canceled`.
`data[attributes][stop_location_id]` | **uuid** <br>The [Location](#locations) where the customer will return the items. When the clusters feature is in use, the stop location needs to be in the same cluster as the start location. 
`data[attributes][stops_at]` | **datetime** <br>When items become available, changing this value may result in shortages
`data[attributes][tag_list]` | **array[string]** <br>Case insensitive tag list. 
`data[attributes][tax_region_id]` | **uuid** <br>[TaxRegion](#tax-regions) applied to this Order. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>coupon</code></li>
  <li>
    <code>customer</code>
    <ul>
      <li><code>merge_suggestion_customer</code></li>
      <li><code>payment_methods</code></li>
      <li><code>properties</code></li>
    </ul>
  </li>
  <li><code>documents</code></li>
  <li>
    <code>lines</code>
    <ul>
      <li>
          <code>item</code>
          <ul>
            <li><code>barcode</code></li>
            <li><code>photo</code></li>
            <li><code>properties</code></li>
          </ul>
      </li>
      <li>
          <code>planning</code>
          <ul>
            <li>
                  <code>stock_item_plannings</code>
                  <ul>
                    <li>
                            <code>stock_item</code>
                            <ul>
                              <li><code>barcode</code></li>
                            </ul>
                    </li>
                  </ul>
            </li>
          </ul>
      </li>
      <li><code>tax_category</code></li>
    </ul>
  </li>
  <li><code>notes</code></li>
  <li><code>order_delivery_rate</code></li>
  <li>
    <code>payments</code>
    <ul>
      <li><code>payment_method</code></li>
    </ul>
  </li>
  <li><code>properties</code></li>
  <li><code>start_location</code></li>
  <li><code>stop_location</code></li>
  <li><code>tax_region</code></li>
  <li><code>tax_values</code></li>
  <li><code>transfers</code></li>
</ul>

