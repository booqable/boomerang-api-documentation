# Downtimes

Downtimes represent periods when products are unavailable for rental due to maintenance,
repairs, or other operational reasons. This allows you to block product availability outside of regular
rental bookings, ensuring accurate inventory management and scheduling.

Downtimes can be used to schedule maintenance periods for equipment, mark products as temporarily unavailable
due to repairs, handle missing or misplaced products, or block availability for operational reasons.

## Relationships
Name | Description
-- | --
`location` | **[Location](#locations)** `required`<br>The location where the downtime occurs. This helps track where maintenance or repairs are taking place. 
`product` | **[Product](#products)** `required`<br>The product that is affected by the downtime. 
`stock_item` | **[Stock item](#stock-items)** `optional`<br>The specific stock item that is unavailable during the downtime period. Only applicable for tracked products. 


Check matching attributes under [Fields](#downtimes-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`location_id` | **uuid** <br>The location where the downtime occurs. This helps track where maintenance or repairs are taking place. 
`product_id` | **uuid** <br>The product that is affected by the downtime. 
`quantity` | **integer** <br>The number of products affected by this downtime. Defaults to 1. For bulk products, you can specify higher quantities to indicate how many products are unavailable. 
`reason` | **enum** <br>The reason why the product is unavailable.<br> One of: `maintenance`, `repair`, `missing`.
`starts_at` | **datetime** <br>When the downtime period begins. The product becomes unavailable for rental from this date/time. 
`status` | **enum** <br>The current status of the downtime period. Can be scheduled, started, stopped, or canceled. Defaults to scheduled when created.<br> One of: `reserved`, `started`, `stopped`, `canceled`.
`stock_item_id` | **uuid** `nullable`<br>The specific stock item that is unavailable during the downtime period. Only applicable for tracked products. 
`stops_at` | **datetime** <br>When the downtime period ends. The product becomes available for rental again after this date/time. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List downtimes


> How to fetch a list of downtimes:

```shell
  curl --get 'https://example.booqable.com/api/4/downtimes'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "f1f5276f-fc8b-4fc0-880b-6d7e0c715f2b",
        "type": "downtimes",
        "attributes": {
          "created_at": "2020-11-22T16:53:01.000000+00:00",
          "updated_at": "2020-11-22T16:53:01.000000+00:00",
          "reason": "maintenance",
          "status": "reserved",
          "quantity": 1,
          "starts_at": "2020-11-24T16:53:01.000000+00:00",
          "stops_at": "2020-11-27T16:53:01.000000+00:00",
          "location_id": "f10a87a6-8788-42b0-88db-615bf92db1f2",
          "product_id": "7deebeb2-e361-43f5-8209-64fb69710a8a",
          "stock_item_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/downtimes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[downtimes]=created_at,updated_at,reason`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=location,product,stock_item`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`attention_required` | **array** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`item_type` | **enum** <br>`eq`
`location_id` | **uuid** <br>`eq`, `not_eq`
`product_id` | **uuid** <br>`eq`, `not_eq`
`quantity` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`range` | **hash** <br>`eq`
`reason` | **enum** <br>`eq`, `not_eq`
`reasons` | **array** <br>`eq`, `not_eq`
`start_or_stop_time` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`, `between`
`starts_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`, `between`, `compare`
`status` | **enum** <br>`eq`, `not_eq`
`statuses` | **array** <br>`eq`, `not_eq`
`stock_item_id` | **uuid** <br>`eq`, `not_eq`
`stops_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`, `between`, `compare`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`attention_required` | **array** <br>`count`
`item_type` | **array** <br>`count`
`reason` | **array** <br>`count`
`status` | **array** <br>`count`
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>location</code></li>
  <li><code>product</code></li>
  <li><code>stock_item</code></li>
</ul>


## Create a downtime


> How to create a downtime:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/downtimes'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "downtimes",
           "attributes": {
             "reason": "maintenance",
             "quantity": 2,
             "starts_at": "2025-03-04T00:50:00.000000+00:00",
             "stops_at": "2025-03-07T00:50:00.000000+00:00",
             "location_id": "b6dd4e89-cdf4-4fce-8f25-c5250d0d3abf",
             "product_id": "fede9ba2-69e2-4bca-8507-1b90260ccadc"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "f6e632f2-c8ab-4755-8331-04c9b1a082a9",
      "type": "downtimes",
      "attributes": {
        "created_at": "2025-03-02T00:50:00.000000+00:00",
        "updated_at": "2025-03-02T00:50:00.000000+00:00",
        "reason": "maintenance",
        "status": "reserved",
        "quantity": 2,
        "starts_at": "2025-03-04T00:50:00.000000+00:00",
        "stops_at": "2025-03-07T00:50:00.000000+00:00",
        "location_id": "b6dd4e89-cdf4-4fce-8f25-c5250d0d3abf",
        "product_id": "fede9ba2-69e2-4bca-8507-1b90260ccadc",
        "stock_item_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/downtimes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[downtimes]=created_at,updated_at,reason`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=location,product,stock_item`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][location_id]` | **uuid** <br>The location where the downtime occurs. This helps track where maintenance or repairs are taking place. 
`data[attributes][product_id]` | **uuid** <br>The product that is affected by the downtime. 
`data[attributes][quantity]` | **integer** <br>The number of products affected by this downtime. Defaults to 1. For bulk products, you can specify higher quantities to indicate how many products are unavailable. 
`data[attributes][reason]` | **enum** <br>The reason why the product is unavailable.<br> One of: `maintenance`, `repair`, `missing`.
`data[attributes][starts_at]` | **datetime** <br>When the downtime period begins. The product becomes unavailable for rental from this date/time. 
`data[attributes][status]` | **enum** <br>The current status of the downtime period. Can be scheduled, started, stopped, or canceled. Defaults to scheduled when created.<br> One of: `reserved`, `started`, `stopped`, `canceled`.
`data[attributes][stock_item_id]` | **uuid** <br>The specific stock item that is unavailable during the downtime period. Only applicable for tracked products. 
`data[attributes][stops_at]` | **datetime** <br>When the downtime period ends. The product becomes available for rental again after this date/time. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>location</code></li>
  <li><code>product</code></li>
  <li><code>stock_item</code></li>
</ul>


## Update a downtime


> How to update a downtime:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/downtimes/ba7609ab-6b5d-46ef-84c8-2f55f2cff204'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "downtimes",
           "id": "ba7609ab-6b5d-46ef-84c8-2f55f2cff204",
           "attributes": {
             "status": "started"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "ba7609ab-6b5d-46ef-84c8-2f55f2cff204",
      "type": "downtimes",
      "attributes": {
        "created_at": "2024-09-06T18:37:01.000000+00:00",
        "updated_at": "2024-09-06T18:37:01.000000+00:00",
        "reason": "maintenance",
        "status": "started",
        "quantity": 1,
        "starts_at": "2024-09-06T18:37:01.000000+00:00",
        "stops_at": "2024-09-11T18:37:01.000000+00:00",
        "location_id": "5ca11407-358f-410f-83d0-4f3b4fb235b1",
        "product_id": "59f0c994-63f5-4e25-878d-ced2a7e51ab9",
        "stock_item_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/downtimes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[downtimes]=created_at,updated_at,reason`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][location_id]` | **uuid** <br>The location where the downtime occurs. This helps track where maintenance or repairs are taking place. 
`data[attributes][product_id]` | **uuid** <br>The product that is affected by the downtime. 
`data[attributes][quantity]` | **integer** <br>The number of products affected by this downtime. Defaults to 1. For bulk products, you can specify higher quantities to indicate how many products are unavailable. 
`data[attributes][reason]` | **enum** <br>The reason why the product is unavailable.<br> One of: `maintenance`, `repair`, `missing`.
`data[attributes][starts_at]` | **datetime** <br>When the downtime period begins. The product becomes unavailable for rental from this date/time. 
`data[attributes][status]` | **enum** <br>The current status of the downtime period. Can be scheduled, started, stopped, or canceled. Defaults to scheduled when created.<br> One of: `reserved`, `started`, `stopped`, `canceled`.
`data[attributes][stock_item_id]` | **uuid** <br>The specific stock item that is unavailable during the downtime period. Only applicable for tracked products. 
`data[attributes][stops_at]` | **datetime** <br>When the downtime period ends. The product becomes available for rental again after this date/time. 


### Includes

This request does not accept any includes