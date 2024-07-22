# Plannings

Plannings contain information about the quantitative planning of an item.
An item can either be a product or a bundle. Planning (in combination with
[Stock counts](#stock-counts)) define when an item is available during a
given period. Plannings are never directly created or updated through their
resource; instead, they are always managed by booking items to an order,
updating or deleting its associated line, or transitioning status.

Nested plannings contain information about individual items in a bundle.
Note that nested plannings can not be deleted directly, the parent line
should be deleted instead.

## Endpoints
`GET /api/boomerang/plannings`

`POST api/boomerang/plannings/search`

`GET /api/boomerang/plannings/{id}`

## Fields
Every planning has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether planning is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the planning was archived
`quantity` | **Integer** `readonly`<br>Total planned
`starts_at` | **Datetime** `readonly`<br>When the start action is planned
`stops_at` | **Datetime** `readonly`<br>When the stop action is planned
`reserved_from` | **Datetime** `readonly`<br>When the items become unavailable
`reserved_till` | **Datetime** `readonly`<br>When the items become available again
`reserved` | **Boolean** `readonly`<br>Wheter items are reserved
`started` | **Integer** `readonly`<br>Amount of items started. Cannot exceed `quantity`. This attribute is omitted when this is a parent planning for a Bundle. 
`stopped` | **Integer** `readonly`<br>Amount of items stopped. Cannot exceed `quantity` and `started`. This attribute is omitted when this is a parent planning for a Bundle. 
`location_shortage_amount` | **Integer** `readonly`<br>Amount of items short. This attribute is omitted when this is a parent planning for a Bundle. 
`shortage_amount` | **Integer** `readonly`<br>Amount of items short on location (could be there are still available on other locations in the same cluster). This attribute is omitted when this is a parent planning for a Bundle. 
`order_id` | **Uuid** `readonly`<br>The associated Order
`item_id` | **Uuid** `readonly`<br>The associated Item
`start_location_id` | **Uuid** `readonly`<br>The associated Start location
`stop_location_id` | **Uuid** `readonly`<br>The associated Stop location
`parent_planning_id` | **Uuid** `readonly`<br>The associated Parent planning


## Relationships
Plannings have the following relationships:

Name | Description
-- | --
`order` | **Orders** `readonly`<br>Associated Order
`item` | **Items** `readonly`<br>Associated Item
`order_line` | **Lines** `readonly`<br>Associated Order line
`start_location` | **Locations** `readonly`<br>Associated Start location
`stop_location` | **Locations** `readonly`<br>Associated Stop location
`parent_planning` | **Plannings** `readonly`<br>Associated Parent planning
`nested_plannings` | **Plannings** `readonly`<br>Associated Nested plannings
`stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Stock item plannings


## Listing plannings



> How to fetch a list of plannings:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/plannings' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "16c7c6c8-132e-444d-8ad2-71709a436635",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-07-22T09:31:40.893381+00:00",
        "updated_at": "2024-07-22T09:31:41.859504+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "1980-04-01T12:00:00.000000+00:00",
        "stops_at": "1980-05-01T12:00:00.000000+00:00",
        "reserved_from": "1980-04-01T12:00:00.000000+00:00",
        "reserved_till": "1980-05-01T12:00:00.000000+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "536e98a9-a804-441e-b9f8-afa8ab53a9b7",
        "item_id": "b16d4790-bb17-4807-bc90-7704ed4fac92",
        "start_location_id": "6abdb9be-a07a-42a4-b052-c74fc644d131",
        "stop_location_id": "6abdb9be-a07a-42a4-b052-c74fc644d131",
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
`include` | **String** <br>List of comma seperated relationships `?include=order,item,order_line`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[plannings]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`quantity` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`starts_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved_from` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved_till` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved` | **Boolean** <br>`eq`
`started` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stopped` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`location_shortage_amount` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`shortage_amount` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **Uuid** <br>`eq`, `not_eq`
`item_id` | **Uuid** <br>`eq`, `not_eq`
`start_location_id` | **Uuid** <br>`eq`, `not_eq`
`stop_location_id` | **Uuid** <br>`eq`, `not_eq`
`parent_planning_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`item_type` | **String** <br>`eq`, `not_eq`
`product_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`order_line`


`start_location`


`stop_location`






## Searching plannings

Use advanced search to make logical filter groups with and/or operators.


> How to search for plannings:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/plannings/search' \
    --header 'content-type: application/json' \
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
                    "gte": "2024-07-23T09:31:37Z"
                  }
                },
                {
                  "starts_at": {
                    "lte": "2024-07-26T09:31:37Z"
                  }
                }
              ]
            },
            {
              "operator": "and",
              "attributes": [
                {
                  "stops_at": {
                    "gte": "2024-07-23T09:31:37Z"
                  }
                },
                {
                  "stops_at": {
                    "lte": "2024-07-26T09:31:37Z"
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
      "id": "efdbde02-7f3f-4bd5-b548-8cdd02976225"
    },
    {
      "id": "8fd12dfd-a926-4bb0-ae03-a9a14d3bd7fd"
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
`include` | **String** <br>List of comma seperated relationships `?include=order,item,order_line`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[plannings]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`quantity` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`starts_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved_from` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved_till` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`reserved` | **Boolean** <br>`eq`
`started` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stopped` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`location_shortage_amount` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`shortage_amount` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **Uuid** <br>`eq`, `not_eq`
`item_id` | **Uuid** <br>`eq`, `not_eq`
`start_location_id` | **Uuid** <br>`eq`, `not_eq`
`stop_location_id` | **Uuid** <br>`eq`, `not_eq`
`parent_planning_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`item_type` | **String** <br>`eq`, `not_eq`
`product_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`order_line`


`start_location`


`stop_location`






## Fetching a planning



> How to fetch a planning:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/plannings/4ec06b8b-d703-4a36-b0fc-3ac7f0028778' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4ec06b8b-d703-4a36-b0fc-3ac7f0028778",
    "type": "plannings",
    "attributes": {
      "created_at": "2024-07-22T09:31:46.079667+00:00",
      "updated_at": "2024-07-22T09:31:46.883150+00:00",
      "archived": false,
      "archived_at": null,
      "quantity": 1,
      "starts_at": "1980-04-01T12:00:00.000000+00:00",
      "stops_at": "1980-05-01T12:00:00.000000+00:00",
      "reserved_from": "1980-04-01T12:00:00.000000+00:00",
      "reserved_till": "1980-05-01T12:00:00.000000+00:00",
      "reserved": true,
      "started": 0,
      "stopped": 0,
      "location_shortage_amount": 0,
      "shortage_amount": 0,
      "order_id": "cdb25f2e-b7ed-4dc4-b075-4b6def338955",
      "item_id": "bbf8e1ea-c7e2-41d7-855c-a0e1b9903ab3",
      "start_location_id": "24ff5d9b-7a50-4919-aec8-10c35665f7de",
      "stop_location_id": "24ff5d9b-7a50-4919-aec8-10c35665f7de",
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
`include` | **String** <br>List of comma seperated relationships `?include=order,item,order_line`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[plannings]=created_at,updated_at,archived`


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





