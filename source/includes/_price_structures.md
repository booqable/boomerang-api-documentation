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
      "id": "5f13d089-5a2e-43c5-8544-9e575a0053c4",
      "type": "price_structures",
      "attributes": {
        "created_at": "2023-07-10T09:19:37+00:00",
        "updated_at": "2023-07-10T09:19:37+00:00",
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
            "related": "api/boomerang/price_tiles?filter[price_structure_id]=5f13d089-5a2e-43c5-8544-9e575a0053c4"
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
    --url 'https://example.booqable.com/api/boomerang/price_structures/1c9ccfd1-97dd-43d1-b78a-1b0d5808f498?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1c9ccfd1-97dd-43d1-b78a-1b0d5808f498",
    "type": "price_structures",
    "attributes": {
      "created_at": "2023-07-10T09:19:38+00:00",
      "updated_at": "2023-07-10T09:19:38+00:00",
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
          "related": "api/boomerang/price_tiles?filter[price_structure_id]=1c9ccfd1-97dd-43d1-b78a-1b0d5808f498"
        },
        "data": [
          {
            "type": "price_tiles",
            "id": "299e9e53-2bbf-4e16-902f-7ffb5ac4eea5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "299e9e53-2bbf-4e16-902f-7ffb5ac4eea5",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2023-07-10T09:19:38+00:00",
        "updated_at": "2023-07-10T09:19:38+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 1.0,
        "period": "hours",
        "price_structure_id": "1c9ccfd1-97dd-43d1-b78a-1b0d5808f498"
      },
      "relationships": {
        "price_structure": {
          "links": {
            "related": "api/boomerang/price_structures/1c9ccfd1-97dd-43d1-b78a-1b0d5808f498"
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
    "id": "df707152-a73f-4695-9b1b-69f66698123c",
    "type": "price_structures",
    "attributes": {
      "created_at": "2023-07-10T09:19:39+00:00",
      "updated_at": "2023-07-10T09:19:39+00:00",
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
            "id": "01b8e3d2-3917-4af5-8432-abb7c8d3b760"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "01b8e3d2-3917-4af5-8432-abb7c8d3b760",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2023-07-10T09:19:39+00:00",
        "updated_at": "2023-07-10T09:19:39+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 1.0,
        "period": "hours",
        "price_structure_id": "df707152-a73f-4695-9b1b-69f66698123c"
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
    --url 'https://example.booqable.com/api/boomerang/price_structures/448235f0-a250-490c-a537-139a8cc62240' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "448235f0-a250-490c-a537-139a8cc62240",
        "type": "price_structures",
        "attributes": {
          "name": "Charge per week (cut-rate > 3 weeks)",
          "price_tiles_attributes": [
            {
              "id": "dfb0d645-23d6-4382-922f-ebf421b57f58",
              "name": "1 semana"
            },
            {
              "id": "6130b481-5208-44d4-9b08-4e6273ae81ef",
              "name": "2 semanas"
            },
            {
              "id": "ff2a53a5-0e98-471d-b7e3-f4a7624552ed",
              "name": "3 semanas"
            },
            {
              "id": "77975dde-4516-46c9-a404-ecac70274e5c",
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
    "id": "448235f0-a250-490c-a537-139a8cc62240",
    "type": "price_structures",
    "attributes": {
      "created_at": "2023-07-10T09:19:40+00:00",
      "updated_at": "2023-07-10T09:19:40+00:00",
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
            "id": "dfb0d645-23d6-4382-922f-ebf421b57f58"
          },
          {
            "type": "price_tiles",
            "id": "6130b481-5208-44d4-9b08-4e6273ae81ef"
          },
          {
            "type": "price_tiles",
            "id": "ff2a53a5-0e98-471d-b7e3-f4a7624552ed"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dfb0d645-23d6-4382-922f-ebf421b57f58",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2023-07-10T09:19:40+00:00",
        "updated_at": "2023-07-10T09:19:40+00:00",
        "name": "1 semana",
        "quantity": 1,
        "length": 604800,
        "multiplier": 1.0,
        "period": "weeks",
        "price_structure_id": "448235f0-a250-490c-a537-139a8cc62240"
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
      "id": "6130b481-5208-44d4-9b08-4e6273ae81ef",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2023-07-10T09:19:40+00:00",
        "updated_at": "2023-07-10T09:19:40+00:00",
        "name": "2 semanas",
        "quantity": 2,
        "length": 1209600,
        "multiplier": 2.0,
        "period": "weeks",
        "price_structure_id": "448235f0-a250-490c-a537-139a8cc62240"
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
      "id": "ff2a53a5-0e98-471d-b7e3-f4a7624552ed",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2023-07-10T09:19:40+00:00",
        "updated_at": "2023-07-10T09:19:40+00:00",
        "name": "3 semanas",
        "quantity": 3,
        "length": 1814400,
        "multiplier": 3.0,
        "period": "weeks",
        "price_structure_id": "448235f0-a250-490c-a537-139a8cc62240"
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
    --url 'https://example.booqable.com/api/boomerang/price_structures/c404a354-f505-4083-968c-62c2fea44009' \
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