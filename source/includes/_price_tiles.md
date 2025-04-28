# Price tiles

Price tiles hold information on how to calculate a price for a specific period.
According to the `charge_length`, a tile will be picked in price calculations.
Note that Booqable always rounds up to the highest tile it can find.
The base price of a product is multiplied by the `multiplier`.

## Relationships
Name | Description
-- | --
`price_structure` | **[Price structure](#price-structures)** `required`<br>[PriceStructure](#price-structure) this price tile is part of. 


Check matching attributes under [Fields](#price-tiles-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`length` | **integer** `readonly`<br>Length in seconds (is computed based on `quantity` and `period`).
`multiplier` | **float** <br>The amount to multiply a product's base price with (e.g. `2.8` for three days).
`name` | **string** <br>Name of the tile, which will be used as charge label in the store and on lines.
`period` | **enum** <br>Period.<br>One of: `hours`, `days`, `weeks`, `months`, `years`.
`price_structure_id` | **uuid** `readonly-after-create`<br>[PriceStructure](#price-structure) this price tile is part of. 
`quantity` | **integer** <br>Used in combination with period (e.g. `3` with period `days`).
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List price tiles


> How to fetch a list of price tiles:

```shell
  curl --get 'https://example.booqable.com/api/4/price_tiles'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "0d6f13f8-3b9b-4c22-8b76-818cde33de51",
        "type": "price_tiles",
        "attributes": {
          "created_at": "2024-06-11T13:44:00.000000+00:00",
          "updated_at": "2024-06-11T13:44:00.000000+00:00",
          "name": "3 hours",
          "quantity": 3,
          "length": 10800,
          "multiplier": 3.0,
          "period": "hours",
          "price_structure_id": "206c8e98-0263-4e64-8a9a-6dee477153a3"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/price_tiles`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_tiles]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`price_structure_id` | **uuid** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch a price tile


> How to fetch a price tile:

```shell
  curl --get 'https://example.booqable.com/api/4/price_tiles/f87df772-a192-4033-84c5-daf41c699939'
       --header 'content-type: application/json'
       --data-urlencode 'include=price_tiles'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "f87df772-a192-4033-84c5-daf41c699939",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-10-25T02:33:08.000000+00:00",
        "updated_at": "2024-10-25T02:33:08.000000+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 3.0,
        "period": "hours",
        "price_structure_id": "a945c0c5-af5b-404b-87fd-9096543d28f9"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/price_tiles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_tiles]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_structure`


### Includes

This request accepts the following includes:

<ul>
  <li><code>price_structure</code></li>
</ul>


## Create a price tile


> How to create a price tile:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/price_tiles'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "price_tiles",
           "attributes": {
             "price_structure_id": "8f39c1c4-b736-4059-8db2-de921565f8e7",
             "name": "3 hours",
             "quantity": 3,
             "period": "hours",
             "multiplier": 3
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "9adeb1b0-13d6-4add-8865-6795db1fd6f0",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2023-05-15T06:12:04.000000+00:00",
        "updated_at": "2023-05-15T06:12:04.000000+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 3.0,
        "period": "hours",
        "price_structure_id": "8f39c1c4-b736-4059-8db2-de921565f8e7"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/price_tiles`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_tiles]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_structure`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][multiplier]` | **float** <br>The amount to multiply a product's base price with (e.g. `2.8` for three days).
`data[attributes][name]` | **string** <br>Name of the tile, which will be used as charge label in the store and on lines.
`data[attributes][period]` | **enum** <br>Period.<br>One of: `hours`, `days`, `weeks`, `months`, `years`.
`data[attributes][price_structure_id]` | **uuid** <br>[PriceStructure](#price-structure) this price tile is part of. 
`data[attributes][quantity]` | **integer** <br>Used in combination with period (e.g. `3` with period `days`).


### Includes

This request accepts the following includes:

<ul>
  <li><code>price_structure</code></li>
</ul>


## Update a price tile


> How to update a price tile:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/price_tiles/37e5319a-6e66-49a9-8d18-9d98fef25147'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "37e5319a-6e66-49a9-8d18-9d98fef25147",
           "type": "price_tiles",
           "attributes": {
             "name": "4 days",
             "quantity": 4,
             "period": "days",
             "multiplier": 4
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "37e5319a-6e66-49a9-8d18-9d98fef25147",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2027-02-09T08:16:02.000000+00:00",
        "updated_at": "2027-02-09T08:16:02.000000+00:00",
        "name": "4 days",
        "quantity": 4,
        "length": 345600,
        "multiplier": 4.0,
        "period": "days",
        "price_structure_id": "754fab8c-2d27-4abc-8d24-c5b673ca95f6"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/boomerang/price_tiles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_tiles]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_structure`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][multiplier]` | **float** <br>The amount to multiply a product's base price with (e.g. `2.8` for three days).
`data[attributes][name]` | **string** <br>Name of the tile, which will be used as charge label in the store and on lines.
`data[attributes][period]` | **enum** <br>Period.<br>One of: `hours`, `days`, `weeks`, `months`, `years`.
`data[attributes][price_structure_id]` | **uuid** <br>[PriceStructure](#price-structure) this price tile is part of. 
`data[attributes][quantity]` | **integer** <br>Used in combination with period (e.g. `3` with period `days`).


### Includes

This request accepts the following includes:

<ul>
  <li><code>price_structure</code></li>
</ul>


## Delete a price tile


> How to delete a price tile:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/price_tiles/46af1ccd-943e-408c-8de5-d7b51faf300b'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "46af1ccd-943e-408c-8de5-d7b51faf300b",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2021-11-04T04:21:00.000000+00:00",
        "updated_at": "2021-11-04T04:21:00.000000+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 3.0,
        "period": "hours",
        "price_structure_id": "b51ac374-2b75-4abf-8c3c-6691345dda34"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/boomerang/price_tiles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_tiles]=created_at,updated_at,name`


### Includes

This request does not accept any includes