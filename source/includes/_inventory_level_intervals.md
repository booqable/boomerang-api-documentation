# Inventory level intervals

Inventory level intervals provide a breakdown of stock quantity information by an interval.
It returns data about availability, stock counts, and what is planned on orders.

## Relationships
Name | Description
-- | --
`item` | **[Item](#items)** `required`<br>The [Item](#items) whose availability this record describes. 
`location` | **[Location](#locations)** `required`<br>The [Location](#locations) to which this record applies. 


Check matching attributes under [Fields](#inventory-level-intervals-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`cluster_available` | **integer** `readonly`<br>The minimum available quantity for the cluster within the interval. 
`cluster_max_available` | **integer** `readonly`<br>The maximum available quantity for the cluster within the interval. 
`cluster_max_needed` | **integer** `readonly`<br>The maximum needed quantity for the cluster within the interval. This quantity does not contain what has already been returned for an order (`planned - stopped`). 
`cluster_max_planned` | **integer** `readonly`<br>The maximum planned quantity for the cluster within the interval. 
`cluster_max_stock_count` | **integer** `readonly`<br>The maximum stock count for the cluster within the interval. 
`cluster_needed` | **integer** `readonly`<br>The minimum needed quantity for the cluster within the interval. This quantity does not contain what has already been returned for an order (`planned - stopped`). 
`cluster_planned` | **integer** `readonly`<br>The minimum planned quantity for the cluster within the interval. 
`cluster_stock_count` | **integer** `readonly`<br>The minimum stock count for the cluster within the interval. 
`from` | **datetime** `readonly`<br>Start of the period to list inventory levels for. 
`id` | **uuid** `readonly`<br>Primary key.
`item_id` | **uuid** `readonly`<br>ID of the item to return data for, this can be a single ID or an array of multiple IDs. 
`location_available` | **integer** `readonly`<br>The minimum available quantity for the location within the interval. 
`location_id` | **uuid** `readonly`<br>ID of the location to filter for. 
`location_max_available` | **integer** `readonly`<br>The maximum available quantity for the location within the interval. 
`location_max_needed` | **integer** `readonly`<br>The maximum needed quantity for the location within the interval. This quantity does not contain what has already been returned for an order (`planned - stopped`). 
`location_max_planned` | **integer** `readonly`<br>The maximum planned quantity for the location within the interval. 
`location_max_stock_count` | **integer** `readonly`<br>The maximum stock count for the location within the interval. 
`location_needed` | **integer** `readonly`<br>The minimum needed quantity for the location within the interval. This quantity does not contain what has already been returned for an order (`planned - stopped`). 
`location_planned` | **integer** `readonly`<br>The minimum planned quantity for the location within the interval. 
`location_stock_count` | **integer** `readonly`<br>The minimum stock count for the location within the interval. 
`till` | **datetime** `readonly`<br>End of the period to list inventory levels for. 


## List inventory level intervals


> How to fetch a list of inventory level intervals:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/inventory_level_intervals'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2022-01-01'
       --data-urlencode 'filter[interval]=day'
       --data-urlencode 'filter[item_id]=377e5447-a6f0-491b-89bb-b3428eb323af'
       --data-urlencode 'filter[till]=2022-01-07'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "8d917e60-d956-41ae-8117-14fd16ece9aa",
        "type": "inventory_level_intervals",
        "attributes": {
          "item_id": "377e5447-a6f0-491b-89bb-b3428eb323af",
          "location_id": "b95feae5-5e74-4779-8708-c552608324bf",
          "from": "2024-05-10T06:35:03.000000+00:00",
          "till": "2024-05-11T06:35:03.000000+00:00",
          "location_available": 4,
          "location_max_available": 4,
          "location_stock_count": 4,
          "location_max_stock_count": 4,
          "location_planned": 0,
          "location_max_planned": 0,
          "location_needed": 0,
          "location_max_needed": 0,
          "cluster_available": 4,
          "cluster_max_available": 4,
          "cluster_stock_count": 4,
          "cluster_max_stock_count": 4,
          "cluster_planned": 0,
          "cluster_max_planned": 0,
          "cluster_needed": 0,
          "cluster_max_needed": 0
        },
        "relationships": {}
      },
      {
        "id": "55f26b8a-edee-438d-84a7-176bed911a6f",
        "type": "inventory_level_intervals",
        "attributes": {
          "item_id": "377e5447-a6f0-491b-89bb-b3428eb323af",
          "location_id": "b95feae5-5e74-4779-8708-c552608324bf",
          "from": "2024-05-11T06:35:03.000000+00:00",
          "till": "2024-05-12T06:35:03.000000+00:00",
          "location_available": 4,
          "location_max_available": 4,
          "location_stock_count": 4,
          "location_max_stock_count": 4,
          "location_planned": 0,
          "location_max_planned": 0,
          "location_needed": 0,
          "location_max_needed": 0,
          "cluster_available": 4,
          "cluster_max_available": 4,
          "cluster_stock_count": 4,
          "cluster_max_stock_count": 4,
          "cluster_planned": 0,
          "cluster_max_planned": 0,
          "cluster_needed": 0,
          "cluster_max_needed": 0
        },
        "relationships": {}
      },
      {
        "id": "f39124ac-dca3-4c8b-8197-94fb9f156e26",
        "type": "inventory_level_intervals",
        "attributes": {
          "item_id": "377e5447-a6f0-491b-89bb-b3428eb323af",
          "location_id": "b95feae5-5e74-4779-8708-c552608324bf",
          "from": "2024-05-12T06:35:03.000000+00:00",
          "till": "2024-05-13T06:35:03.000000+00:00",
          "location_available": 4,
          "location_max_available": 4,
          "location_stock_count": 4,
          "location_max_stock_count": 4,
          "location_planned": 0,
          "location_max_planned": 0,
          "location_needed": 0,
          "location_max_needed": 0,
          "cluster_available": 4,
          "cluster_max_available": 4,
          "cluster_stock_count": 4,
          "cluster_max_stock_count": 4,
          "cluster_planned": 0,
          "cluster_max_planned": 0,
          "cluster_needed": 0,
          "cluster_max_needed": 0
        },
        "relationships": {}
      },
      {
        "id": "246cbccf-4830-4816-85ee-b4fb3f2e0819",
        "type": "inventory_level_intervals",
        "attributes": {
          "item_id": "377e5447-a6f0-491b-89bb-b3428eb323af",
          "location_id": "b95feae5-5e74-4779-8708-c552608324bf",
          "from": "2024-05-13T06:35:03.000000+00:00",
          "till": "2024-05-14T06:35:03.000000+00:00",
          "location_available": 4,
          "location_max_available": 4,
          "location_stock_count": 4,
          "location_max_stock_count": 4,
          "location_planned": 0,
          "location_max_planned": 0,
          "location_needed": 0,
          "location_max_needed": 0,
          "cluster_available": 4,
          "cluster_max_available": 4,
          "cluster_stock_count": 4,
          "cluster_max_stock_count": 4,
          "cluster_planned": 0,
          "cluster_max_planned": 0,
          "cluster_needed": 0,
          "cluster_max_needed": 0
        },
        "relationships": {}
      },
      {
        "id": "10de1a0c-a48a-4397-8745-6bf79145cbf2",
        "type": "inventory_level_intervals",
        "attributes": {
          "item_id": "377e5447-a6f0-491b-89bb-b3428eb323af",
          "location_id": "b95feae5-5e74-4779-8708-c552608324bf",
          "from": "2024-05-14T06:35:03.000000+00:00",
          "till": "2024-05-15T06:35:03.000000+00:00",
          "location_available": 4,
          "location_max_available": 4,
          "location_stock_count": 4,
          "location_max_stock_count": 4,
          "location_planned": 0,
          "location_max_planned": 0,
          "location_needed": 0,
          "location_max_needed": 0,
          "cluster_available": 4,
          "cluster_max_available": 4,
          "cluster_stock_count": 4,
          "cluster_max_stock_count": 4,
          "cluster_planned": 0,
          "cluster_max_planned": 0,
          "cluster_needed": 0,
          "cluster_max_needed": 0
        },
        "relationships": {}
      },
      {
        "id": "af963cf9-b28a-4f13-8ed3-bb92a38fb66d",
        "type": "inventory_level_intervals",
        "attributes": {
          "item_id": "377e5447-a6f0-491b-89bb-b3428eb323af",
          "location_id": "b95feae5-5e74-4779-8708-c552608324bf",
          "from": "2024-05-15T06:35:03.000000+00:00",
          "till": "2024-05-16T06:35:03.000000+00:00",
          "location_available": 4,
          "location_max_available": 4,
          "location_stock_count": 4,
          "location_max_stock_count": 4,
          "location_planned": 0,
          "location_max_planned": 0,
          "location_needed": 0,
          "location_max_needed": 0,
          "cluster_available": 4,
          "cluster_max_available": 4,
          "cluster_stock_count": 4,
          "cluster_max_stock_count": 4,
          "cluster_planned": 0,
          "cluster_max_planned": 0,
          "cluster_needed": 0,
          "cluster_max_needed": 0
        },
        "relationships": {}
      },
      {
        "id": "b017932e-30aa-437b-8edb-44eeff15b643",
        "type": "inventory_level_intervals",
        "attributes": {
          "item_id": "377e5447-a6f0-491b-89bb-b3428eb323af",
          "location_id": "b95feae5-5e74-4779-8708-c552608324bf",
          "from": "2024-05-16T06:35:03.000000+00:00",
          "till": "2024-05-17T06:35:03.000000+00:00",
          "location_available": 4,
          "location_max_available": 4,
          "location_stock_count": 4,
          "location_max_stock_count": 4,
          "location_planned": 0,
          "location_max_planned": 0,
          "location_needed": 0,
          "location_max_needed": 0,
          "cluster_available": 4,
          "cluster_max_available": 4,
          "cluster_stock_count": 4,
          "cluster_max_stock_count": 4,
          "cluster_planned": 0,
          "cluster_max_planned": 0,
          "cluster_needed": 0,
          "cluster_max_needed": 0
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/inventory_level_intervals`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[inventory_level_intervals]=item_id,location_id,from`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=item,location`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`from` | **datetime** `required`<br>`eq`
`interval` | **enum** `required`<br>`eq`
`item_id` | **uuid** <br>`eq`
`location_id` | **uuid** <br>`eq`
`till` | **datetime** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`item`


`location`





