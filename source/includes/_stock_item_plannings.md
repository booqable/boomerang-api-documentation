# Stock item plannings

Stock item plannings hold information about the planning of individual stock items (for trackable products).
They make it possible to know precisely which stock items have been where and define when an item is available
during a given period.

Stock item plannings are never directly created or updated through their resource;
instead they are created by booking or specifying stock items; they are updated by
starting or stopping them. See the [OrderFulfillments](#order-fulfillments) resource
for examples.

## Purpose and Relationship to Plannings

While a [Planning](#plannings) represents the quantitative planning of items (how many), a StockItemPlanning
represents the specific trackable items assigned to fulfill that planning. The relationship is:

- A Planning may have multiple StockItemPlannings (one for each trackable item)
- The number of StockItemPlannings may be less than `Planning.quantity` when not all StockItems have been specified yet.

## Lifecycle Management

StockItemPlannings follow a specific lifecycle:

1. **Creation**: They are created when stock items are specified for a planning via [OrderFulfillments](#order-fulfillments)
2. **Reservation**: When reserved, the specific stock item becomes unavailable for other orders
3. **Start**: When the stock item is marked as started (picked up or delivered)
4. **Stop**: When the stock item is marked as stopped (returned)

The status of each stock item is tracked independently, allowing partial pickups and returns.

## Tracking Benefits

Stock item plannings provide several key benefits:

- Precise inventory tracking for each individual item
- Ability to track item history (which customers used which specific items)
- Support for partial pickups and returns
- Detailed audit trail of item movements

## Relationships
Name | Description
-- | --
`order` | **[Order](#orders)** `required`<br>The [Order](#orders) this StockItemPlanning is part of. 
`planning` | **[Planning](#plannings)** `required`<br>The [Planning](#plannings) for which this StockItemPlanning specifies a StockItem. 
`stock_item` | **[Stock item](#stock-items)** `required`<br>The [StockItem](#stock-items) being specified, and whose status through the fulfillment process is tracked by this StockItemPlanning. 


Check matching attributes under [Fields](#stock-item-plannings-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether stock item planning is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the stock item planning was archived. This timestamp records when the stock item was unassigned from the planning. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly`<br>The [Order](#orders) this StockItemPlanning is part of. 
`planning_id` | **uuid** `readonly`<br>The [Planning](#plannings) for which this StockItemPlanning specifies a StockItem. 
`reserved` | **boolean** <br>Whether stock item is reserved, meaning it's unavailable for other orders. This is set to `true` when the order status is changed to "reserved" or when the stock item is specifically assigned to the planning. When reserved, the item cannot be booked for other orders during the same period. 
`started` | **boolean** <br>Whether the stock item is started, meaning it has been picked up by the customer or delivered. This is set to `true` when staff performs a "Start" action through the [OrderFulfillments](#order-fulfillments) resource. Once started, the item is physically out with the customer and its status can be tracked independently of other items on the same order. 
`stock_item_id` | **uuid** `readonly`<br>The [StockItem](#stock-items) being specified, and whose status through the fulfillment process is tracked by this StockItemPlanning. 
`stopped` | **boolean** <br>Whether the stock item is stopped, meaning it has been returned by the customer and is available again for other rentals. This is set to `true` when staff performs a "Stop" action through the [OrderFulfillments](#order-fulfillments) resource. A stock item must be started before it can be stopped. Once stopped, the item becomes available for other bookings. 
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
          "reserved": false,
          "started": false,
          "stopped": false,
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
`stock_item_id` | **uuid** <br>`eq`, `not_eq`
`stopped` | **boolean** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
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
        "reserved": false,
        "started": false,
        "stopped": false,
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