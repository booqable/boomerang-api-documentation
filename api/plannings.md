# Plannings

Plannings track the quantitative planned activities (order or downtime) of an item. Planned activities will make an item unavailable for other activities during a given period. Planning records are never directly created or updated.
The item can either be a [Product](#products) or a [Bundle](#bundles).

## Product Plannings vs Bundle Plannings

There are two types of Plannings:

1. **Product Plannings**: These represent the planning of a single [Product](#products).

2. **Bundle Plannings**: These represent the planning of a [Bundle](#bundles) (a group of [Products](#products)). Some attributes
   are omitted for Bundle Plannings because they don't apply at the [Bundle](#bundles) level.

## Nested Plannings

Nested Plannings contain information about individual [Products](#products) in a [Bundle](#bundles).
Note that nested Plannings cannot be deleted directly; the parent [Line](#lines)
should be deleted instead.

When a [Bundle](#bundles) is booked:
- A parent Planning is created for the [Bundle](#bundles) itself
- Nested Plannings are created for each [Product](#products) within the [Bundle](#bundles)
- The nested Plannings have their `parent_planning_id` set to the ID of the parent Planning

## Reservation vs Planning Dates

Plannings use two sets of dates that serve different purposes:

- `starts_at`/`stops_at`: When actions (pickup/return) are planned to occur. These are typically
  shown to customers and staff as the scheduled dates.

- `reserved_from`/`reserved_till`: When items are actually unavailable/available in the system.
  These may differ from the planned dates due to buffer times.

## Relationships
Name | Description
-- | --
`downtime` | **[Downtime](#downtimes)** `optional`<br>The [Downtime](#downtimes) this Planning belongs to. This association is present when `planning_type: "downtime"`. A downtime represents a period when items are unavailable for rental due to maintenance, repairs, or other operational reasons. It is not associated with a customer order. 
`item` | **[Item](#items)** `required`<br>The [Product](#products) or [Bundle](#bundles) that was booked. 
`nested_plannings` | **[Plannings](#plannings)** `hasmany`<br>When `item` is a [Bundle](#bundles), then there is a nested planning that corresponds for each [BundleItem](#bundle-items). 
`order` | **[Order](#orders)** `optional`<br>The [Order](#orders) this Planning belongs to. 
`order_line` | **[Line](#lines)** `optional`<br>The [Line](#lines) which holds financial information for this Planning. 
`parent_planning` | **[Planning](#plannings)** `required`<br>When present, this Planning is part of a [Bundle](#bundles) and corresponds to a [BundleItem](#bundle-items). Inverse of the `nested_plannings` relation. 
`start_location` | **[Location](#locations)** `required`<br>The [Location](#locations) where the planned activity begins. For order plannings, this is where the customer will pick up the item. 
`stock_item_plannings` | **[Stock item plannings](#stock-item-plannings)** `hasmany`<br>The [StockItems](#stock-items) specified for this Planning, and their current status. For trackable products, this association contains the specific inventory items assigned to this planning. <br/> The number of StockItemPlannings can be less than `planning.quantity`. This is because stock items may not yet be specified (assigned) for this planning.<br>For order plannings, stock items are typically specified through the [OrderFulfillments](#order-fulfillments) resource, which creates the corresponding StockItemPlannings linking specific inventory items to this planning. 
`stop_location` | **[Location](#locations)** `required`<br>The [Location](#locations) where the planned activity ends. For order plannings, this is where the customer will return the product. 


Check matching attributes under [Fields](#plannings-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether planning is archived.<br>Note that there are two concepts of "archiving". The `archived` attribute is set to true when a Planning is removed from an Order through the Lines resource. When an Order is archived, `status` of Plannings is set to `archived`, but the `archived` attribute remains false. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the planning was archived. Indicates when the `archived` attribute was set to true. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`downtime_id` | **uuid** `readonly` `nullable`<br>The [Downtime](#downtimes) this Planning belongs to. This association is present when `planning_type: "downtime"`. A downtime represents a period when items are unavailable for rental due to maintenance, repairs, or other operational reasons. It is not associated with a customer order. 
`fulfillment_type` | **string** `writeonly`<br>The type of fulfillment for this planning. 
`id` | **uuid** `readonly`<br>Primary key.
`item_id` | **uuid** `readonly`<br>The [Product](#products) or [Bundle](#bundles) that was booked. 
`item_name` | **string** `writeonly`<br>Allows sorting plannings by item name. 
`location_shortage_amount` | **integer** <br>Amount of items short at the specific location. This represents how many more items would be needed at the `start_location` to fully satisfy this planning. A value greater than zero indicates a location shortage. This attribute is omitted when this is a parent planning for a [Bundle](#bundles). 
`order_id` | **uuid** `readonly` `nullable`<br>The [Order](#orders) this Planning belongs to. 
`order_number` | **integer** `writeonly`<br>Allows sorting plannings by order number. 
`parent_planning_id` | **uuid** `readonly`<br>When present, this Planning is part of a [Bundle](#bundles) and corresponds to a [BundleItem](#bundle-items). Inverse of the `nested_plannings` relation. 
`planning_type` | **enum** `readonly`<br>Type of planning. Can be `order` for regular rental plannings created through [Orders](#orders), or `downtime` for operational periods when items are unavailable due to maintenance, repairs, or other reasons. Downtime plannings don't belong to an order and are managed separately.<br> One of: `order`, `downtime`.
`quantity` | **integer** `readonly`<br>Total planned quantity of items. This affects availability calculations and represents how many items are being booked/reserved. Changing this value may result in shortages if additional items are not available for the rental period. 
`reserved` | **boolean** `readonly`<br>Whether items are reserved. When `true`, this Planning affects availability calculations and the items are not available for other plannings during the reserved period. For order plannings, this is set to `true` when an Order transitions from `draft` to `reserved` status. 
`reserved_from` | **datetime** `readonly`<br>When the items actually become unavailable in the system. May differ from `starts_at` due to buffer time. This is the actual time used for availability calculations. 
`reserved_till` | **datetime** `readonly`<br>When the items actually become available again in the system. May differ from `stops_at` due to buffer time. This is the actual time used for availability calculations. 
`shortage_amount` | **integer** <br>Amount of items short across all locations in the same cluster. This represents how many more items would be needed in total to satisfy this planning. A value greater than zero indicates a system-wide shortage that can't be solved by transfers between locations. This attribute is omitted when this is a parent planning for a [Bundle](#bundles). 
`start_location_id` | **uuid** `readonly`<br>The [Location](#locations) where the planned activity begins. For order plannings, this is where the customer will pick up the item. 
`started` | **integer** <br>Amount of items that have begun their planned activity. For order plannings, this represents items picked up or delivered to the customer. This value increases when staff performs start actions. Cannot exceed `quantity`. When all items are started (`started` equals `quantity`), the Planning is considered fully started. This attribute is omitted when this is a parent planning for a Bundle. 
`starts_at` | **datetime** `readonly`<br>When the planned activity is scheduled to begin. For order plannings, this represents when pickup/delivery is planned to occur and is shown to staff and customers as the beginning of the rental. 
`status` | **enum** `readonly`<br>Status of this planning. A planning can become "stopped" before the order it belongs to is stopped. Otherwise, the status mostly follows the status of the order.<br>Note that there are two concepts of "archiving". The `archived` attribute is set to true when a Planning is removed from an Order through the Lines resource. When an Order is archived, `status` of Plannings is set to `archived`, but the `archived` attribute remains false.<br> One of: `new`, `draft`, `reserved`, `started`, `stopped`, `archived`, `canceled`.
`stop_location_id` | **uuid** `readonly`<br>The [Location](#locations) where the planned activity ends. For order plannings, this is where the customer will return the product. 
`stopped` | **integer** <br>Amount of items that have completed their planned activity. For order plannings, this represents items returned by the customer. This value increases when staff performs stop actions. Cannot exceed `quantity` and `started` (items must be started before they can be stopped). When all items are stopped (`stopped` equals `quantity`), the Planning is considered fully completed.<br>For order plannings with [Products](#products) that have `product_type == consumable`, items are never returned, and the `stopped` attribute will always remain zero.<br>This attribute is omitted when this is a parent planning for a [Bundle](#bundles). 
`stops_at` | **datetime** `readonly`<br>When the planned activity is scheduled to end. For order plannings, this represents when return is planned to occur and is shown to staff and customers as the end of the rental. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List plannings


> How to fetch a list of plannings:

```shell
  curl --get 'https://example.booqable.com/api/4/plannings'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "61b93896-5b57-455e-84fe-39f48ce6f4ab",
        "type": "plannings",
        "attributes": {
          "created_at": "2018-03-21T05:17:00.000000+00:00",
          "updated_at": "2018-03-21T05:17:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "planning_type": "order",
          "quantity": 1,
          "starts_at": "1972-06-11T06:13:00.000000+00:00",
          "stops_at": "1972-07-11T06:13:00.000000+00:00",
          "reserved_from": "1972-06-11T06:13:00.000000+00:00",
          "reserved_till": "1972-07-11T06:13:00.000000+00:00",
          "reserved": true,
          "status": "reserved",
          "started": 0,
          "stopped": 0,
          "location_shortage_amount": 0,
          "shortage_amount": 0,
          "order_id": "ead6ad3f-bdc9-47c1-86d3-7f825d8f0769",
          "downtime_id": null,
          "item_id": "bc366da1-7df4-4bc5-846b-8d94a52be19b",
          "start_location_id": "91d91031-83d2-483b-8d80-12ce62a11b4f",
          "stop_location_id": "91d91031-83d2-483b-8d80-12ce62a11b4f",
          "parent_planning_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/plannings`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[plannings]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,item,downtime`
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
`downtime_id` | **uuid** <br>`eq`, `not_eq`
`id` | **uuid** <br>`eq`, `not_eq`
`item_id` | **uuid** <br>`eq`, `not_eq`
`item_type` | **string** <br>`eq`, `not_eq`
`location_shortage_amount` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **uuid** <br>`eq`, `not_eq`
`parent_planning_id` | **uuid** <br>`eq`, `not_eq`
`planning_type` | **string** <br>`eq`, `not_eq`
`product_type` | **string** <br>`eq`, `not_eq`
`q` | **string** <br>`eq`
`quantity` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved` | **boolean** <br>`eq`
`reserved_from` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved_till` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`shortage_amount` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`start_location_id` | **uuid** <br>`eq`, `not_eq`
`started` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`starts_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **enum** <br>`eq`
`stop_location_id` | **uuid** <br>`eq`, `not_eq`
`stopped` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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

<ul>
  <li><code>downtime</code></li>
  <li>
    <code>item</code>
    <ul>
      <li><code>photo</code></li>
    </ul>
  </li>
  <li>
    <code>order</code>
    <ul>
      <li><code>customer</code></li>
    </ul>
  </li>
  <li><code>order_line</code></li>
  <li><code>start_location</code></li>
  <li><code>stop_location</code></li>
</ul>


## Search plannings

Use advanced search to make logical filter groups with and/or operators.

> How to search for plannings:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/plannings/search'
       --header 'content-type: application/json'
       --data '{
         "fields": {
           "plannings": "id"
         },
         "filter": {
           "conditions": {
             "operator": "or",
             "attributes": [
               {
                 "operator": "and",
                 "attributes": [
                   {
                     "starts_at": {
                       "gte": "2026-01-10T11:04:28Z"
                     }
                   },
                   {
                     "starts_at": {
                       "lte": "2026-01-13T11:04:28Z"
                     }
                   }
                 ]
               },
               {
                 "operator": "and",
                 "attributes": [
                   {
                     "stops_at": {
                       "gte": "2026-01-10T11:04:28Z"
                     }
                   },
                   {
                     "stops_at": {
                       "lte": "2026-01-13T11:04:28Z"
                     }
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
        "id": "b256e1d6-5a03-4c89-8561-d96d00867c8b"
      },
      {
        "id": "68589e0b-87d0-47f5-81fc-bc562e69965d"
      }
    ]
  }
```

### HTTP Request

`POST /api/4/plannings/search`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[plannings]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,item,downtime`
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
`downtime_id` | **uuid** <br>`eq`, `not_eq`
`id` | **uuid** <br>`eq`, `not_eq`
`item_id` | **uuid** <br>`eq`, `not_eq`
`item_type` | **string** <br>`eq`, `not_eq`
`location_shortage_amount` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **uuid** <br>`eq`, `not_eq`
`parent_planning_id` | **uuid** <br>`eq`, `not_eq`
`planning_type` | **string** <br>`eq`, `not_eq`
`product_type` | **string** <br>`eq`, `not_eq`
`q` | **string** <br>`eq`
`quantity` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved` | **boolean** <br>`eq`
`reserved_from` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved_till` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`shortage_amount` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`start_location_id` | **uuid** <br>`eq`, `not_eq`
`started` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`starts_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **enum** <br>`eq`
`stop_location_id` | **uuid** <br>`eq`, `not_eq`
`stopped` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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

<ul>
  <li><code>downtime</code></li>
  <li>
    <code>item</code>
    <ul>
      <li><code>photo</code></li>
    </ul>
  </li>
  <li>
    <code>order</code>
    <ul>
      <li><code>customer</code></li>
    </ul>
  </li>
  <li><code>order_line</code></li>
  <li><code>start_location</code></li>
  <li><code>stop_location</code></li>
</ul>


## Fetch a planning


> How to fetch a planning:

```shell
  curl --get 'https://example.booqable.com/api/4/plannings/7ab088ea-e88a-4452-8ab3-d8593ea31603'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "7ab088ea-e88a-4452-8ab3-d8593ea31603",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-04-14T01:42:01.000000+00:00",
        "updated_at": "2023-04-14T01:42:01.000000+00:00",
        "archived": false,
        "archived_at": null,
        "planning_type": "order",
        "quantity": 1,
        "starts_at": "1977-07-05T02:38:01.000000+00:00",
        "stops_at": "1977-08-04T02:38:01.000000+00:00",
        "reserved_from": "1977-07-05T02:38:01.000000+00:00",
        "reserved_till": "1977-08-04T02:38:01.000000+00:00",
        "reserved": true,
        "status": "reserved",
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "73a043aa-a655-48a0-8936-f1c8ded729d7",
        "downtime_id": null,
        "item_id": "ab4d2f98-31a4-4d84-8750-a8b3c4408a4a",
        "start_location_id": "090a3ed2-c86a-468d-8d55-d59c162f9276",
        "stop_location_id": "090a3ed2-c86a-468d-8d55-d59c162f9276",
        "parent_planning_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/plannings/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[plannings]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,item,downtime`


### Includes

This request accepts the following includes:

<ul>
  <li><code>downtime</code></li>
  <li>
    <code>item</code>
    <ul>
      <li><code>photo</code></li>
    </ul>
  </li>
  <li><code>nested_plannings</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>customer</code></li>
    </ul>
  </li>
  <li><code>order_line</code></li>
  <li><code>parent_planning</code></li>
  <li><code>start_location</code></li>
  <li><code>stop_location</code></li>
</ul>

