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
      "id": "db9d1602-91ea-419f-9202-7f7fcd62e356",
      "type": "price_structures",
      "attributes": {
        "created_at": "2023-05-15T13:51:08+00:00",
        "updated_at": "2023-05-15T13:51:08+00:00",
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
          "links": {
            "related": "api/boomerang/price_tiles?filter[price_structure_id]=db9d1602-91ea-419f-9202-7f7fcd62e356"
          }
        }
      }
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
    --url 'https://example.booqable.com/api/boomerang/price_structures/6b5710b9-12bf-4830-9ded-70e722d69fc2?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6b5710b9-12bf-4830-9ded-70e722d69fc2",
    "type": "price_structures",
    "attributes": {
      "created_at": "2023-05-15T13:51:09+00:00",
      "updated_at": "2023-05-15T13:51:09+00:00",
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
        "links": {
          "related": "api/boomerang/price_tiles?filter[price_structure_id]=6b5710b9-12bf-4830-9ded-70e722d69fc2"
        },
        "data": [
          {
            "type": "price_tiles",
            "id": "503b1204-0661-4017-bcbc-6d232d01d611"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "503b1204-0661-4017-bcbc-6d232d01d611",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2023-05-15T13:51:09+00:00",
        "updated_at": "2023-05-15T13:51:09+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 1.0,
        "period": "hours",
        "price_structure_id": "6b5710b9-12bf-4830-9ded-70e722d69fc2"
      },
      "relationships": {
        "price_structure": {
          "links": {
            "related": "api/boomerang/price_structures/6b5710b9-12bf-4830-9ded-70e722d69fc2"
          }
        }
      }
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
    "id": "4bb9144f-a8b3-4d0f-a68a-14f54b8fd78f",
    "type": "price_structures",
    "attributes": {
      "created_at": "2023-05-15T13:51:09+00:00",
      "updated_at": "2023-05-15T13:51:09+00:00",
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
            "id": "f8b22606-6236-4a21-b1e4-34111c521845"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f8b22606-6236-4a21-b1e4-34111c521845",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2023-05-15T13:51:09+00:00",
        "updated_at": "2023-05-15T13:51:09+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 1.0,
        "period": "hours",
        "price_structure_id": "4bb9144f-a8b3-4d0f-a68a-14f54b8fd78f"
      },
      "relationships": {
        "price_structure": {
          "meta": {
            "included": false
          }
        }
      }
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
    --url 'https://example.booqable.com/api/boomerang/price_structures/7ac6cf63-6c8d-450e-a69d-9fce0f5bdc07' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7ac6cf63-6c8d-450e-a69d-9fce0f5bdc07",
        "type": "price_structures",
        "attributes": {
          "name": "Charge per week (cut-rate > 3 weeks)",
          "price_tiles_attributes": [
            {
              "id": "9f0c3c2b-6a97-475a-b38b-3eb308b35bf9",
              "name": "1 semana"
            },
            {
              "id": "8dbe0876-1ac9-4ae2-9f90-9b1ac9caa847",
              "name": "2 semanas"
            },
            {
              "id": "d29ebfaf-8611-4a8b-9545-16a1bcc6d434",
              "name": "3 semanas"
            },
            {
              "id": "21b72887-2b63-4a11-9a76-45a0c7efaa60",
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
    "id": "7ac6cf63-6c8d-450e-a69d-9fce0f5bdc07",
    "type": "price_structures",
    "attributes": {
      "created_at": "2023-05-15T13:51:09+00:00",
      "updated_at": "2023-05-15T13:51:10+00:00",
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
            "id": "9f0c3c2b-6a97-475a-b38b-3eb308b35bf9"
          },
          {
            "type": "price_tiles",
            "id": "8dbe0876-1ac9-4ae2-9f90-9b1ac9caa847"
          },
          {
            "type": "price_tiles",
            "id": "d29ebfaf-8611-4a8b-9545-16a1bcc6d434"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9f0c3c2b-6a97-475a-b38b-3eb308b35bf9",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2023-05-15T13:51:09+00:00",
        "updated_at": "2023-05-15T13:51:10+00:00",
        "name": "1 semana",
        "quantity": 1,
        "length": 604800,
        "multiplier": 1.0,
        "period": "weeks",
        "price_structure_id": "7ac6cf63-6c8d-450e-a69d-9fce0f5bdc07"
      },
      "relationships": {
        "price_structure": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "8dbe0876-1ac9-4ae2-9f90-9b1ac9caa847",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2023-05-15T13:51:10+00:00",
        "updated_at": "2023-05-15T13:51:10+00:00",
        "name": "2 semanas",
        "quantity": 2,
        "length": 1209600,
        "multiplier": 2.0,
        "period": "weeks",
        "price_structure_id": "7ac6cf63-6c8d-450e-a69d-9fce0f5bdc07"
      },
      "relationships": {
        "price_structure": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "d29ebfaf-8611-4a8b-9545-16a1bcc6d434",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2023-05-15T13:51:10+00:00",
        "updated_at": "2023-05-15T13:51:10+00:00",
        "name": "3 semanas",
        "quantity": 3,
        "length": 1814400,
        "multiplier": 3.0,
        "period": "weeks",
        "price_structure_id": "7ac6cf63-6c8d-450e-a69d-9fce0f5bdc07"
      },
      "relationships": {
        "price_structure": {
          "meta": {
            "included": false
          }
        }
      }
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
    --url 'https://example.booqable.com/api/boomerang/price_structures/2188056c-9126-49be-865a-76219655f483' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
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