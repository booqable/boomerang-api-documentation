# Price structures

Price structures enable you to control what is being priced for a specific period. Price structures consist of tiles that represent a period. The actual charge that is being calculated will always round up to the nearest tile it can find. You can also set up a flat-fee structure after you've run out of tiles by setting one of the following values: `hour`, `day`, `week`, `month`, `year`.

**There are two kinds of price structures:**

1. `reusable`: Structures that are reusable and that can be assigned to multiple product groups.
2. `private`: Structure for a specific product group. These are automatically created when a product group its `price_type` is set to `private_structure`.

## Endpoints
`GET /api/boomerang/price_structures`

`GET /api/boomerang/price_structures/{id}`

`POST /api/boomerang/price_structures`

`PUT /api/boomerang/price_structures/{id}`

`DELETE /api/boomerang/price_structures/{id}`

## Fields
Every price structure has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether price structure is archived
`archived_at` | **Datetime** `readonly`<br>When the price structure was archived
`name` | **String** <br>Name of the structure
`price_structure_type` | **String** `readonly`<br>One of `reusable`, `private`
`price_tiles_attributes` | **Array** `writeonly`<br>The price tiles to associate
`product_group_id` | **Uuid** `readonly`<br>The associated product group for `private` price structure type
`hour` | **Float** <br>Multiplier for every hour outside of its tiles
`day` | **Float** <br>Multiplier for every day outside of its tiles
`week` | **Float** <br>Multiplier for every week outside of its tiles
`month` | **Float** <br>Multiplier for every month outside of its tiles
`year` | **Float** <br>Multiplier for every year outside of its tiles


## Relationships
Price structures have the following relationships:

Name | Description
-- | --
`price_tiles` | **Price tiles** `readonly`<br>Associated Price tiles


## Listing price structures



> How to fetch a list of price structures:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_structures' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "20794849-b733-4e88-bb09-461b19a6448f",
      "type": "price_structures",
      "attributes": {
        "created_at": "2024-08-05T09:26:31.741893+00:00",
        "updated_at": "2024-08-05T09:26:31.747312+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Price per hour (3 hours minimum)",
        "price_structure_type": "reusable",
        "product_group_id": null,
        "hour": 1.0,
        "day": 0.0,
        "week": 0.0,
        "month": 0.0,
        "year": 0.0
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_structures]=created_at,updated_at,archived`
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
`price_structure_type` | **String** <br>`eq`, `not_eq`
`product_group_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a price structure with it's tiles:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_structures/c24b891c-98fc-40a4-a0f4-c5ad9657e9ab?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c24b891c-98fc-40a4-a0f4-c5ad9657e9ab",
    "type": "price_structures",
    "attributes": {
      "created_at": "2024-08-05T09:26:35.117610+00:00",
      "updated_at": "2024-08-05T09:26:35.124271+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Price per hour (3 hours minimum)",
      "price_structure_type": "reusable",
      "product_group_id": null,
      "hour": 1.0,
      "day": 0.0,
      "week": 0.0,
      "month": 0.0,
      "year": 0.0
    },
    "relationships": {
      "price_tiles": {
        "data": [
          {
            "type": "price_tiles",
            "id": "e3c0384c-02ba-4f16-815a-18b638248cc3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e3c0384c-02ba-4f16-815a-18b638248cc3",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-08-05T09:26:35.120929+00:00",
        "updated_at": "2024-08-05T09:26:35.120929+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 1.0,
        "period": "hours",
        "price_structure_id": "c24b891c-98fc-40a4-a0f4-c5ad9657e9ab"
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
`include` | **String** <br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_structures]=created_at,updated_at,archived`


### Includes

This request accepts the following includes:

`price_tiles`






## Creating a price structure



> How to create a price structure with price tiles:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/price_structures' \
    --header 'content-type: application/json' \
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
    "id": "d443507e-10b4-4073-8b65-4a0a0e3f7807",
    "type": "price_structures",
    "attributes": {
      "created_at": "2024-08-05T09:26:33.571202+00:00",
      "updated_at": "2024-08-05T09:26:33.577744+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Price per hour (3 hours minimum)",
      "price_structure_type": "reusable",
      "product_group_id": null,
      "hour": 1.0,
      "day": 0.0,
      "week": 0.0,
      "month": 0.0,
      "year": 0.0
    },
    "relationships": {
      "price_tiles": {
        "data": [
          {
            "type": "price_tiles",
            "id": "46da72f3-b6ed-4b60-9248-a55cce6f3d69"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "46da72f3-b6ed-4b60-9248-a55cce6f3d69",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-08-05T09:26:33.574547+00:00",
        "updated_at": "2024-08-05T09:26:33.574547+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 1.0,
        "period": "hours",
        "price_structure_id": "d443507e-10b4-4073-8b65-4a0a0e3f7807"
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
`include` | **String** <br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_structures]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the structure
`data[attributes][price_tiles_attributes][]` | **Array** <br>The price tiles to associate
`data[attributes][hour]` | **Float** <br>Multiplier for every hour outside of its tiles
`data[attributes][day]` | **Float** <br>Multiplier for every day outside of its tiles
`data[attributes][week]` | **Float** <br>Multiplier for every week outside of its tiles
`data[attributes][month]` | **Float** <br>Multiplier for every month outside of its tiles
`data[attributes][year]` | **Float** <br>Multiplier for every year outside of its tiles


### Includes

This request accepts the following includes:

`price_tiles`






## Updating a price structure



> How to update a price structure with price tiles:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_structures/d97ddaeb-491d-4bf7-bb18-1158320f4d71' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d97ddaeb-491d-4bf7-bb18-1158320f4d71",
        "type": "price_structures",
        "attributes": {
          "name": "Charge per week (cut-rate > 3 weeks)",
          "price_tiles_attributes": [
            {
              "id": "49b9d6fb-8438-4441-8b91-d5b09cd8a712",
              "name": "1 semana"
            },
            {
              "id": "c8c3a382-1d63-4b29-b1f3-51b11132d8bb",
              "name": "2 semanas"
            },
            {
              "id": "779ea2d9-1a8a-4e48-816e-b5eb98e3ec44",
              "name": "3 semanas"
            },
            {
              "id": "b39bdc64-d580-412e-a56d-27e7d143a1fc",
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
    "id": "d97ddaeb-491d-4bf7-bb18-1158320f4d71",
    "type": "price_structures",
    "attributes": {
      "created_at": "2024-08-05T09:26:34.242746+00:00",
      "updated_at": "2024-08-05T09:26:34.316386+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Charge per week (cut-rate > 3 weeks)",
      "price_structure_type": "reusable",
      "product_group_id": null,
      "hour": 0.0,
      "day": 0.0,
      "week": 0.8,
      "month": 0.0,
      "year": 0.0
    },
    "relationships": {
      "price_tiles": {
        "data": [
          {
            "type": "price_tiles",
            "id": "49b9d6fb-8438-4441-8b91-d5b09cd8a712"
          },
          {
            "type": "price_tiles",
            "id": "c8c3a382-1d63-4b29-b1f3-51b11132d8bb"
          },
          {
            "type": "price_tiles",
            "id": "779ea2d9-1a8a-4e48-816e-b5eb98e3ec44"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "49b9d6fb-8438-4441-8b91-d5b09cd8a712",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-08-05T09:26:34.246492+00:00",
        "updated_at": "2024-08-05T09:26:34.310542+00:00",
        "name": "1 semana",
        "quantity": 1,
        "length": 604800,
        "multiplier": 1.0,
        "period": "weeks",
        "price_structure_id": "d97ddaeb-491d-4bf7-bb18-1158320f4d71"
      },
      "relationships": {}
    },
    {
      "id": "c8c3a382-1d63-4b29-b1f3-51b11132d8bb",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-08-05T09:26:34.250272+00:00",
        "updated_at": "2024-08-05T09:26:34.312741+00:00",
        "name": "2 semanas",
        "quantity": 2,
        "length": 1209600,
        "multiplier": 2.0,
        "period": "weeks",
        "price_structure_id": "d97ddaeb-491d-4bf7-bb18-1158320f4d71"
      },
      "relationships": {}
    },
    {
      "id": "779ea2d9-1a8a-4e48-816e-b5eb98e3ec44",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-08-05T09:26:34.253203+00:00",
        "updated_at": "2024-08-05T09:26:34.314803+00:00",
        "name": "3 semanas",
        "quantity": 3,
        "length": 1814400,
        "multiplier": 3.0,
        "period": "weeks",
        "price_structure_id": "d97ddaeb-491d-4bf7-bb18-1158320f4d71"
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
`include` | **String** <br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_structures]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the structure
`data[attributes][price_tiles_attributes][]` | **Array** <br>The price tiles to associate
`data[attributes][hour]` | **Float** <br>Multiplier for every hour outside of its tiles
`data[attributes][day]` | **Float** <br>Multiplier for every day outside of its tiles
`data[attributes][week]` | **Float** <br>Multiplier for every week outside of its tiles
`data[attributes][month]` | **Float** <br>Multiplier for every month outside of its tiles
`data[attributes][year]` | **Float** <br>Multiplier for every year outside of its tiles


### Includes

This request accepts the following includes:

`price_tiles`






## Deleting a price structure



> How to delete a price structure with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_structures/72832688-e0d5-44b0-bb57-ddeb94c5d588' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "72832688-e0d5-44b0-bb57-ddeb94c5d588",
    "type": "price_structures",
    "attributes": {
      "created_at": "2024-08-05T09:26:32.463702+00:00",
      "updated_at": "2024-08-05T09:26:32.498389+00:00",
      "archived": true,
      "archived_at": "2024-08-05T09:26:32.498389+00:00",
      "name": "Price per hour (3 hours minimum) (Deleted)",
      "price_structure_type": "reusable",
      "product_group_id": null,
      "hour": 1.0,
      "day": 0.0,
      "week": 0.0,
      "month": 0.0,
      "year": 0.0
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_structures]=created_at,updated_at,archived`


### Includes

This request does not accept any includes