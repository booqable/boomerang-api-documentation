# Price structures

Price structures enable you to control what is being priced for a specific period.
Price structures consist of tiles that represent a period. The actual charge that
is being calculated will always round up to the nearest tile it can find.

You can also set up a flat-fee structure after you've run out of tiles by setting
one of the following values: `hour`, `day`, `week`, `month`, `year`.

**There are two kinds of price structures:**

1. `reusable`: Structures that are reusable and that
    can be assigned to multiple product groups.
2. `private`: Structure for a specific product group.
    These are automatically created when the price type
    of a product group is set to `private_structure`.

## Relationships
Name | Description
-- | --
`price_tiles` | **[Price tiles](#price-tiles)** `hasmany`<br>The tiles (or tiers) within this price structure. <br/> Tiles can be created/updated through the PriceStructure resource by writing the `price_tiles_attributes` attribute. 
`product_group` | **[Product group](#product-groups)** `required`<br>The product group for `private` price structures. 


Check matching attributes under [Fields](#price-structures-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether the price structure is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the price structure was archived. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`day` | **float** <br>Multiplier for every day outside of its tiles. 
`hour` | **float** <br>Multiplier for every hour outside of its tiles. 
`id` | **uuid** `readonly`<br>Primary key.
`month` | **float** <br>Multiplier for every month outside of its tiles. 
`name` | **string** <br>Name of the structure. 
`price_structure_type` | **enum** `readonly`<br>Type.<br> One of: `reusable`, `private`.
`price_tiles_attributes` | **array** `writeonly`<br>The price tiles to associate. 
`product_group_id` | **uuid** `readonly`<br>The product group for `private` price structures. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`week` | **float** <br>Multiplier for every week outside of its tiles. 
`year` | **float** <br>Multiplier for every year outside of its tiles. 


## List price structures


> How to fetch a list of price structures:

```shell
  curl --get 'https://example.booqable.com/api/4/price_structures'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "ec8cd116-78dd-4aa2-8794-723225fb7f27",
        "type": "price_structures",
        "attributes": {
          "created_at": "2027-12-25T18:39:02.000000+00:00",
          "updated_at": "2027-12-25T18:39:02.000000+00:00",
          "archived": false,
          "archived_at": null,
          "name": "Price per hour (3 hours minimum)",
          "price_structure_type": "reusable",
          "hour": 1.0,
          "day": 0.0,
          "week": 0.0,
          "month": 0.0,
          "year": 0.0,
          "product_group_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/price_structures`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_structures]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`archived` | **boolean** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`price_structure_type` | **enum** <br>`eq`, `not_eq`
`product_group_id` | **uuid** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch a price structure


> How to fetch a price structure with it's tiles:

```shell
  curl --get 'https://example.booqable.com/api/4/price_structures/1eefd0fa-08d5-4e02-8267-c2db07cb35a0'
       --header 'content-type: application/json'
       --data-urlencode 'include=price_tiles'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "1eefd0fa-08d5-4e02-8267-c2db07cb35a0",
      "type": "price_structures",
      "attributes": {
        "created_at": "2021-07-22T04:14:00.000000+00:00",
        "updated_at": "2021-07-22T04:14:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Price per hour (3 hours minimum)",
        "price_structure_type": "reusable",
        "hour": 1.0,
        "day": 0.0,
        "week": 0.0,
        "month": 0.0,
        "year": 0.0,
        "product_group_id": null
      },
      "relationships": {
        "price_tiles": {
          "data": [
            {
              "type": "price_tiles",
              "id": "f4b52aba-05ab-4ad3-8b2f-814b68c688cd"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "f4b52aba-05ab-4ad3-8b2f-814b68c688cd",
        "type": "price_tiles",
        "attributes": {
          "created_at": "2021-07-22T04:14:00.000000+00:00",
          "updated_at": "2021-07-22T04:14:00.000000+00:00",
          "name": "3 hours",
          "quantity": 3,
          "length": 10800,
          "multiplier": 1.0,
          "period": "hours",
          "price_structure_id": "1eefd0fa-08d5-4e02-8267-c2db07cb35a0"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/price_structures/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_structures]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_tiles`


### Includes

This request accepts the following includes:

<ul>
  <li><code>price_tiles</code></li>
</ul>


## Create a price structure


> How to create a price structure with price tiles:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/price_structures'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "price_structures",
           "attributes": {
             "name": "Price per hour (3 hours minimum)",
             "hour": 1,
             "price_tiles_attributes": [
               {
                 "name": "3 hours",
                 "quantity": 3,
                 "period": "hours",
                 "multiplier": 1
               }
             ]
           }
         },
         "include": "price_tiles"
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "135630ff-fb4a-4bbb-8e04-85d256658648",
      "type": "price_structures",
      "attributes": {
        "created_at": "2017-09-22T05:03:01.000000+00:00",
        "updated_at": "2017-09-22T05:03:01.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Price per hour (3 hours minimum)",
        "price_structure_type": "reusable",
        "hour": 1.0,
        "day": 0.0,
        "week": 0.0,
        "month": 0.0,
        "year": 0.0,
        "product_group_id": null
      },
      "relationships": {
        "price_tiles": {
          "data": [
            {
              "type": "price_tiles",
              "id": "c49c9747-d7b5-4faf-8042-f0fc3dcd5706"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "c49c9747-d7b5-4faf-8042-f0fc3dcd5706",
        "type": "price_tiles",
        "attributes": {
          "created_at": "2017-09-22T05:03:01.000000+00:00",
          "updated_at": "2017-09-22T05:03:01.000000+00:00",
          "name": "3 hours",
          "quantity": 3,
          "length": 10800,
          "multiplier": 1.0,
          "period": "hours",
          "price_structure_id": "135630ff-fb4a-4bbb-8e04-85d256658648"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/price_structures`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_structures]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_tiles`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][day]` | **float** <br>Multiplier for every day outside of its tiles. 
`data[attributes][hour]` | **float** <br>Multiplier for every hour outside of its tiles. 
`data[attributes][month]` | **float** <br>Multiplier for every month outside of its tiles. 
`data[attributes][name]` | **string** <br>Name of the structure. 
`data[attributes][price_tiles_attributes][]` | **array** <br>The price tiles to associate. 
`data[attributes][week]` | **float** <br>Multiplier for every week outside of its tiles. 
`data[attributes][year]` | **float** <br>Multiplier for every year outside of its tiles. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>price_tiles</code></li>
</ul>


## Update a price structure


> How to update a price structure with price tiles:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/price_structures/bbc6913e-a6dd-4ab4-8c78-a004643a9cad'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "bbc6913e-a6dd-4ab4-8c78-a004643a9cad",
           "type": "price_structures",
           "attributes": {
             "name": "Charge per week (cut-rate > 3 weeks)",
             "price_tiles_attributes": [
               {
                 "id": "514b2a51-5961-411f-8000-e4712f4024df",
                 "name": "1 semana"
               },
               {
                 "id": "9d9034c8-9bcf-4c35-831c-93c082af2305",
                 "name": "2 semanas"
               },
               {
                 "id": "c08789b9-93ca-475f-83d1-6868f2d3602f",
                 "name": "3 semanas"
               },
               {
                 "id": "69e2abc5-8433-4b13-871c-1141dd30c453",
                 "_destroy": true
               }
             ]
           }
         },
         "include": "price_tiles"
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "bbc6913e-a6dd-4ab4-8c78-a004643a9cad",
      "type": "price_structures",
      "attributes": {
        "created_at": "2026-07-21T11:43:00.000000+00:00",
        "updated_at": "2026-07-21T11:43:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Charge per week (cut-rate > 3 weeks)",
        "price_structure_type": "reusable",
        "hour": 0.0,
        "day": 0.0,
        "week": 0.8,
        "month": 0.0,
        "year": 0.0,
        "product_group_id": null
      },
      "relationships": {
        "price_tiles": {
          "data": [
            {
              "type": "price_tiles",
              "id": "514b2a51-5961-411f-8000-e4712f4024df"
            },
            {
              "type": "price_tiles",
              "id": "9d9034c8-9bcf-4c35-831c-93c082af2305"
            },
            {
              "type": "price_tiles",
              "id": "c08789b9-93ca-475f-83d1-6868f2d3602f"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "514b2a51-5961-411f-8000-e4712f4024df",
        "type": "price_tiles",
        "attributes": {
          "created_at": "2026-07-21T11:43:00.000000+00:00",
          "updated_at": "2026-07-21T11:43:00.000000+00:00",
          "name": "1 semana",
          "quantity": 1,
          "length": 604800,
          "multiplier": 1.0,
          "period": "weeks",
          "price_structure_id": "bbc6913e-a6dd-4ab4-8c78-a004643a9cad"
        },
        "relationships": {}
      },
      {
        "id": "9d9034c8-9bcf-4c35-831c-93c082af2305",
        "type": "price_tiles",
        "attributes": {
          "created_at": "2026-07-21T11:43:00.000000+00:00",
          "updated_at": "2026-07-21T11:43:00.000000+00:00",
          "name": "2 semanas",
          "quantity": 2,
          "length": 1209600,
          "multiplier": 2.0,
          "period": "weeks",
          "price_structure_id": "bbc6913e-a6dd-4ab4-8c78-a004643a9cad"
        },
        "relationships": {}
      },
      {
        "id": "c08789b9-93ca-475f-83d1-6868f2d3602f",
        "type": "price_tiles",
        "attributes": {
          "created_at": "2026-07-21T11:43:00.000000+00:00",
          "updated_at": "2026-07-21T11:43:00.000000+00:00",
          "name": "3 semanas",
          "quantity": 3,
          "length": 1814400,
          "multiplier": 3.0,
          "period": "weeks",
          "price_structure_id": "bbc6913e-a6dd-4ab4-8c78-a004643a9cad"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`PUT /api/boomerang/price_structures/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_structures]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_tiles`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][day]` | **float** <br>Multiplier for every day outside of its tiles. 
`data[attributes][hour]` | **float** <br>Multiplier for every hour outside of its tiles. 
`data[attributes][month]` | **float** <br>Multiplier for every month outside of its tiles. 
`data[attributes][name]` | **string** <br>Name of the structure. 
`data[attributes][price_tiles_attributes][]` | **array** <br>The price tiles to associate. 
`data[attributes][week]` | **float** <br>Multiplier for every week outside of its tiles. 
`data[attributes][year]` | **float** <br>Multiplier for every year outside of its tiles. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>price_tiles</code></li>
</ul>


## Delete a price structure


> How to delete a price structure with tax rates:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/price_structures/787c6191-4590-4d80-8b25-2675dd775bb1'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "787c6191-4590-4d80-8b25-2675dd775bb1",
      "type": "price_structures",
      "attributes": {
        "created_at": "2023-08-07T17:52:01.000000+00:00",
        "updated_at": "2023-08-07T17:52:01.000000+00:00",
        "archived": true,
        "archived_at": "2023-08-07T17:52:01.000000+00:00",
        "name": "Price per hour (3 hours minimum) (Deleted)",
        "price_structure_type": "reusable",
        "hour": 1.0,
        "day": 0.0,
        "week": 0.0,
        "month": 0.0,
        "year": 0.0,
        "product_group_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/boomerang/price_structures/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_structures]=created_at,updated_at,archived`


### Includes

This request does not accept any includes