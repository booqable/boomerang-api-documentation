# Plannings

Plannings contain information about the quantitative planning of an Item.
The Item can either be a Product or a Bundle. Plannings define when an item
is available during a given period. Plannings are never directly created or
updated through their resource; instead, they are always managed by booking
Items to an Order, updating or deleting its associated Line, or transitioning status.

Nested Plannings contain information about individual Items in a Bundle.
Note that nested Plannings can not be deleted directly, the parent Line
should be deleted instead.

## Relationships
Name | Description
-- | --
`item` | **[Item](#items)** `required`<br>The product or Bundle that was booked. 
`nested_plannings` | **[Plannings](#plannings)** `hasmany`<br>When `item` is a Bundle, then there is a `nested_planning` that corresponds for each BundleItem. 
`order` | **[Order](#orders)** `required`<br>The Order this planning belongs to. 
`order_line` | **[Line](#lines)** `optional`<br>The Line which holds financial information for this planning. 
`parent_planning` | **[Planning](#plannings)** `required`<br>When present, then this Planning is part of a Bundle, and corresponds to a BundleItem. Inverse of `nested_plannings` relation. 
`start_location` | **[Location](#locations)** `required`<br>The Location where the Customer will pick up the Item. 
`stock_item_plannings` | **[Stock item plannings](#stock-item-plannings)** `hasmany`<br>The StockItems specified for this Planning, and their current status. <br/> The number ot StockItemPlannings can be less than `planning.quantity`. 
`stop_location` | **[Location](#locations)** `required`<br>The Location where the Customer will return the Item. 


Check matching attributes under [Fields](#plannings-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether planning is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the planning was archived. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`item_id` | **uuid** `readonly`<br>The product or Bundle that was booked. 
`item_name` | **string** `writeonly`<br>Allows sorting plannings by item name. 
`location_shortage_amount` | **integer** <br>Amount of items short. This attribute is omitted when this is a parent planning for a Bundle. 
`order_id` | **uuid** `readonly`<br>The Order this planning belongs to. 
`order_number` | **integer** `writeonly`<br>Allows sorting plannings by order number. 
`parent_planning_id` | **uuid** `readonly`<br>When present, then this Planning is part of a Bundle, and corresponds to a BundleItem. Inverse of `nested_plannings` relation. 
`quantity` | **integer** <br>Total planned. 
`reserved` | **boolean** <br>Wheter items are reserved.
`reserved_from` | **datetime** <br>When the items become unavailable. 
`reserved_till` | **datetime** <br>When the items become available again. 
`shortage_amount` | **integer** <br>Amount of items short on location (could be there are still available on other locations in the same cluster). This attribute is omitted when this is a parent planning for a Bundle. 
`start_location_id` | **uuid** `readonly`<br>The Location where the Customer will pick up the Item. 
`started` | **integer** <br>Amount of items started. Cannot exceed `quantity`. This attribute is omitted when this is a parent planning for a Bundle. 
`starts_at` | **datetime** <br>When the start action is planned. 
`stop_location_id` | **uuid** `readonly`<br>The Location where the Customer will return the Item. 
`stopped` | **integer** <br>Amount of items stopped. Cannot exceed `quantity` and `started`. This attribute is omitted when this is a parent planning for a Bundle. 
`stops_at` | **datetime** <br>When the stop action is planned. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List plannings


> How to fetch a list of plannings:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/plannings'
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
          "quantity": 1,
          "starts_at": "1973-04-05T07:50:00.000000+00:00",
          "stops_at": "1973-05-05T07:50:00.000000+00:00",
          "reserved_from": "1973-04-05T07:50:00.000000+00:00",
          "reserved_till": "1973-05-05T07:50:00.000000+00:00",
          "reserved": true,
          "started": 0,
          "stopped": 0,
          "location_shortage_amount": 0,
          "shortage_amount": 0,
          "order_id": "ead6ad3f-bdc9-47c1-86d3-7f825d8f0769",
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

`GET /api/boomerang/plannings`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[plannings]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,item,order_line`
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
`item_id` | **uuid** <br>`eq`, `not_eq`
`item_type` | **string** <br>`eq`, `not_eq`
`location_shortage_amount` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **uuid** <br>`eq`, `not_eq`
`parent_planning_id` | **uuid** <br>`eq`, `not_eq`
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
`stop_location_id` | **uuid** <br>`eq`, `not_eq`
`stopped` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`order_line`


`start_location`


`stop_location`






## Search plannings

Use advanced search to make logical filter groups with and/or operators.

> How to search for plannings:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/plannings/search'
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
                       "gte": "2025-03-18T09:27:51Z"
                     }
                   },
                   {
                     "starts_at": {
                       "lte": "2025-03-21T09:27:51Z"
                     }
                   }
                 ]
               },
               {
                 "operator": "and",
                 "attributes": [
                   {
                     "stops_at": {
                       "gte": "2025-03-18T09:27:51Z"
                     }
                   },
                   {
                     "stops_at": {
                       "lte": "2025-03-21T09:27:51Z"
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

`POST api/boomerang/plannings/search`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[plannings]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,item,order_line`
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
`item_id` | **uuid** <br>`eq`, `not_eq`
`item_type` | **string** <br>`eq`, `not_eq`
`location_shortage_amount` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **uuid** <br>`eq`, `not_eq`
`parent_planning_id` | **uuid** <br>`eq`, `not_eq`
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
`stop_location_id` | **uuid** <br>`eq`, `not_eq`
`stopped` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`order_line`


`start_location`


`stop_location`






## Fetch a planning


> How to fetch a planning:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/plannings/7ab088ea-e88a-4452-8ab3-d8593ea31603'
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
        "quantity": 1,
        "starts_at": "1978-04-29T04:15:01.000000+00:00",
        "stops_at": "1978-05-29T04:15:01.000000+00:00",
        "reserved_from": "1978-04-29T04:15:01.000000+00:00",
        "reserved_till": "1978-05-29T04:15:01.000000+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "73a043aa-a655-48a0-8936-f1c8ded729d7",
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

`GET /api/boomerang/plannings/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[plannings]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,item,order_line`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`order_line`


`start_location`


`stop_location`


`parent_planning`


`nested_plannings`





