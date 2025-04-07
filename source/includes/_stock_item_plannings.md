# Stock item plannings

StockItemPlannings hold information about the planning of individual StockItems (for trackable products).
They make it possible to know precisely which StockItems have been where and define when an item is available
during a given period.

StockItemPlannings are never directly created or updated through their resource;
instead they are created by booking or specifying StockItems; they are updated by
starting or stopping them. See the [OrderFulfillments](#order-fulfillments) resource
for examples.

## Purpose and Relationship to Plannings

While a [Planning](#plannings) represents the quantitative planning of items (how many), a StockItemPlanning
represents the specific trackable StockItem assigned to fulfill that Planning. The relationship is:

- A Planning may have multiple StockItemPlannings (one for each trackable StockItem)
- The number of StockItemPlannings may be less than `Planning.quantity` when not all StockItems have been specified yet.

## Lifecycle Management

StockItemPlannings follow a specific lifecycle:

1. **Creation**: They are created when StockItems are booked or specified on a Planning via [OrderFulfillments](#order-fulfillments)
2. **Reservation**: When reserved, the specific StockItem becomes unavailable for other orders
3. **Start**: When the StockItem is marked as started (picked up or delivered)
4. **Stop**: When the StockItem is marked as stopped (returned)

The status of each StockItem is tracked independently, allowing partial pickups and returns.

## Tracking Benefits

StockItemPlannings provide several key benefits:

- Precise inventory tracking for each individual StockItem
- Ability to track StockItem history (which customers used which specific items)
- Support for partial pickups and returns
- Detailed audit trail of StockItem movements

## Relationships
Name | Description
-- | --
`order` | **[Order](#orders)** `required`<br>The Order this StockItemPlanning is part of. 
`planning` | **[Planning](#plannings)** `required`<br>The Planning for which this StockItemPlanning specifies a StockItem. 
`stock_item` | **[Stock item](#stock-items)** `required`<br>The StockItem being specified, and whose status through the fulfillment process is tracked by this StockItemPlanning. 


Check matching attributes under [Fields](#stock-item-plannings-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether this StockItemPlanning has been archived. There are two distinct archiving mechanisms:<br>1. **Unspecifying (Unassigning) a StockItem**: When a StockItem is "unspecified" from an Order through the OrderFulfillment API,    the `archived` attribute is set to `true`. This indicates that the StockItem is no longer assigned to this Planning.    The `archived_at` timestamp is updated to record when this occurred. This mechanism allows users to change the StockItems    assigned to a Planning without losing the historical record of which StockItems were assigned.<br>2. **Archive an Order**: When an Order is archived, the `status` of its StockItemPlannings is set to `archived`,    but the `archived` attribute remains `false`. This preserves the historical record of which StockItems were    assigned to the Order while marking the entire Order as archived. This mechanism allows users to archive Orders    to have a clear overview of current and future Orders without cluttering the UI with historical Orders. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the StockItemPlanning was archived through StockItem unspecified archiving. This timestamp records when the StockItem was unassigned from the Planning. This field is only updated when the `archived` attribute is set to `true` through the StockItem unspecified archiving mechanism. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly`<br>The Order this StockItemPlanning is part of. 
`planning_id` | **uuid** `readonly`<br>The Planning for which this StockItemPlanning specifies a StockItem. 
`reserved` | **boolean** <br>Whether StockItem is reserved, meaning it's unavailable for other orders. This is set to `true` when the order status is changed to "reserved" or when the StockItem is specifically assigned to the planning. When reserved, the item cannot be booked for other orders during the same period. 
`started` | **boolean** <br>Whether the StockItem is started, meaning it has been picked up by the customer or delivered. This is set to `true` when staff performs a "Start" action through the [OrderFulfillments](#order-fulfillments) resource. Once started, the item is physically out with the customer and its status can be tracked independently of other items on the same order. 
`starts_at` | **datetime** <br>When the StockItem is scheduled to be picked up or delivered. This date/time indicates when the specific StockItem will begin its rental period, aligning with the planning's start date. This date/time is not updated when a StockItem is picked up earlier or later than originally scheduled. 
`status` | **enum** `readonly`<br>Status of this StockItemPlanning. A StockItemPlanning becomes "stopped" when the StockItem is returned. The Order it belongs to might not be completely stopped (partial return). Otherwise, the status mostly follows the status of the Order.<br>Note that there are two concepts of "archiving". The `archived` attribute is set to true when a StockItem is "unspecified" from an Order through the OrderFulfillment API. When an Order is archived, `status` of StockItemPlannings is set to `archived`, but the `archived` attribute remains false.<br>Possible status values: - `new`: When the order is in new state. - `concept`: When the order is in concept state. - `reserved`: When the StockItem is reserved for this order. The parent Order can already be `started` due to partial pickups. - `started`: When the StockItem has been picked up or delivered. - `stopped`: When the StockItem has been returned. The parent Order can still be `started` due to partial returns. - `archived`: When the parent Order has been archived. - `canceled`: When the parent Order has been canceled.<br> One of: `new`, `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`.
`stock_item_id` | **uuid** `readonly`<br>The StockItem being specified, and whose status through the fulfillment process is tracked by this StockItemPlanning. 
`stopped` | **boolean** <br>Whether the StockItem is stopped, meaning it has been returned by the customer and is available again for other rentals. This is set to `true` when staff performs a "Stop" action through the [OrderFulfillments](#order-fulfillments) resource. A StockItem must be started before it can be stopped. Once stopped, the item becomes available for other bookings. 
`stops_at` | **datetime** <br>When the StockItem is scheduled to be returned. This date/time indicates when the specific StockItem will end its rental period, aligning with the planning's stop date. This date/time is not updated when a StockItem is returned earlier or later than originally scheduled. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List stock item plannings


> How to fetch a list of stock item plannings:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/stock_item_plannings'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "76e3b6a9-a2ef-48f7-813b-a183307e38ce",
        "type": "stock_item_plannings",
        "attributes": {
          "created_at": "2021-11-26T13:55:00.000000+00:00",
          "updated_at": "2021-11-26T13:55:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "starts_at": null,
          "stops_at": null,
          "reserved": false,
          "started": false,
          "stopped": false,
          "status": "concept",
          "stock_item_id": "cb6d24a2-3cdf-47ad-8b45-e484a3447f07",
          "planning_id": "a0d6b272-7ad6-4a19-8c78-7a77546685b6",
          "order_id": "a7840ea8-9a1c-473b-8218-df29c7e23ae3"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/stock_item_plannings`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stock_item_plannings]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=stock_item,planning,order`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`order_id` | **uuid** <br>`eq`, `not_eq`
`planning_id` | **uuid** <br>`eq`, `not_eq`
`reserved` | **boolean** <br>`eq`
`started` | **boolean** <br>`eq`
`starts_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **enum** <br>`eq`
`stock_item_id` | **uuid** <br>`eq`, `not_eq`
`stopped` | **boolean** <br>`eq`
`stops_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`status` | **array** <br>`count`
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`stock_item` => 
`product` => 
`photo`






`planning`


`order`






## Archive a stock_item planning


> How to archive a stock item planning:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/stock_item_plannings/68bb0a74-3b6a-479a-8db0-851ae0d77511'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "68bb0a74-3b6a-479a-8db0-851ae0d77511",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2020-03-22T01:19:28.000000+00:00",
        "updated_at": "2020-03-22T01:19:28.000000+00:00",
        "archived": false,
        "archived_at": null,
        "starts_at": null,
        "stops_at": null,
        "reserved": false,
        "started": false,
        "stopped": false,
        "status": "concept",
        "stock_item_id": "c0063ec0-3366-4182-8cd6-209e7aa5f8df",
        "planning_id": "2e914ecb-75f6-445d-8016-d168dd39ae4a",
        "order_id": "88e2c331-8b9c-4d53-8297-c0bdab76db52"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/boomerang/stock_item_plannings/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stock_item_plannings]=created_at,updated_at,archived`


### Includes

This request does not accept any includes