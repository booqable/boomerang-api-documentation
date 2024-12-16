# Inventory levels

Inventory levels provide information on item availability.
It describes availability, stock counts, and planned quantities for given items.

## Relationships
Name | Description
-- | --
`item` | **[Item](#items)** `required`<br>The item to return data for, this can be a single ID or an array of multiple IDs. 
`location` | **[Location](#locations)** `required`<br>The location to filter on. 
`order` | **[Order](#orders)** `required`<br>The order to filter on. 


Check matching attributes under [Fields](#inventory-levels-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`cluster_available` | **integer** `readonly`<br>The available quantity for the cluster the given location is part of. 
`cluster_needed` | **integer** `readonly`<br>The needed quantity for the cluster the given location is part of. This quantity does not contain what has already been returned for an order (`planned - stopped`). 
`cluster_plannable` | **integer** `readonly`<br>The planned quantity for the cluster the given location is part of. 
`cluster_planned` | **integer** `readonly`<br>The planned quantity for the cluster the given location is part of. 
`cluster_stock_count` | **integer** `readonly`<br>The stock count for the cluster the given location is part of. 
`id` | **uuid** `readonly`<br>Primary key.
`item_id` | **uuid** `readonly`<br>The item to return data for, this can be a single ID or an array of multiple IDs. 
`location_available` | **integer** `readonly`<br>The available quantity for the given location. 
`location_id` | **uuid** `readonly`<br>The location to filter on. 
`location_needed` | **integer** `readonly`<br>The needed quantity for the given location. This quantity does not contain what has already been returned for an order (`planned - stopped`). 
`location_plannable` | **integer** `readonly`<br>The number of products that can be planned for the given location. 
`location_planned` | **integer** `readonly`<br>The planned quantity for the given location. 
`location_stock_count` | **integer** `readonly`<br>The quantity of stock present for the given the location. 
`order_id` | **uuid** `readonly`<br>The order to filter on. 


## Obtaining inventory levels for a product


> How to fetch inventory levels for a product:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/inventory_levels'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2022-01-01 09:00:00'
       --data-urlencode 'filter[item_id]=d4ef30b8-8959-4262-8dcd-d90c23a4ee8a'
       --data-urlencode 'filter[till]=2022-01-02 09:00:00'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "72684141-dea4-42b5-8c69-080d056a0e8c",
        "type": "inventory_levels",
        "attributes": {
          "location_available": 0,
          "location_stock_count": 0,
          "location_plannable": 0,
          "location_planned": 0,
          "location_needed": 0,
          "cluster_available": 0,
          "cluster_stock_count": 0,
          "cluster_plannable": 0,
          "cluster_planned": 0,
          "cluster_needed": 0,
          "item_id": "d4ef30b8-8959-4262-8dcd-d90c23a4ee8a",
          "location_id": "95c73381-5770-48e8-8a43-af7513a32ed9",
          "order_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/inventory_levels`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[inventory_levels]=location_available,location_stock_count,location_plannable`
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
`item_id` | **uuid** <br>`eq`
`location_id` | **uuid** <br>`eq`
`order_id` | **uuid** <br>`eq`
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






## Obtaining inventory levels for a product for a specific location


> How to fetch inventory levels for a product for a specific location:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/inventory_levels'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2022-01-01 09:00:00'
       --data-urlencode 'filter[item_id]=f13f0c48-b1bd-48ef-81be-94aba9cee2fc'
       --data-urlencode 'filter[location_id]=fcf25ba2-1c63-4cf3-842b-be17908108c4'
       --data-urlencode 'filter[till]=2022-01-02 09:00:00'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "7f66e4b6-37f8-4f22-8c62-e35634c5ebb5",
        "type": "inventory_levels",
        "attributes": {
          "location_available": 0,
          "location_stock_count": 0,
          "location_plannable": 0,
          "location_planned": 0,
          "location_needed": 0,
          "cluster_available": 0,
          "cluster_stock_count": 0,
          "cluster_plannable": 0,
          "cluster_planned": 0,
          "cluster_needed": 0,
          "item_id": "f13f0c48-b1bd-48ef-81be-94aba9cee2fc",
          "location_id": "fcf25ba2-1c63-4cf3-842b-be17908108c4",
          "order_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/inventory_levels`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[inventory_levels]=location_available,location_stock_count,location_plannable`
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
`item_id` | **uuid** <br>`eq`
`location_id` | **uuid** <br>`eq`
`order_id` | **uuid** <br>`eq`
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





