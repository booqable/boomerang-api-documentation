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
`price_tiles` | **[Price tiles](#price-tiles)** <br>Associated Price tiles


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
      "id": "ca4fe61d-af49-46de-86b7-c0741ea8e3ae",
      "type": "price_structures",
      "attributes": {
        "created_at": "2024-12-02T13:01:59.001017+00:00",
        "updated_at": "2024-12-02T13:01:59.010417+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/price_structures/0f8445a1-a3f9-4ddb-adf7-0764e31741ee?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0f8445a1-a3f9-4ddb-adf7-0764e31741ee",
    "type": "price_structures",
    "attributes": {
      "created_at": "2024-12-02T13:01:57.849671+00:00",
      "updated_at": "2024-12-02T13:01:57.855055+00:00",
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
            "id": "7abbacbd-a9f7-4b94-b4b5-0fe77f5e98a7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7abbacbd-a9f7-4b94-b4b5-0fe77f5e98a7",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-12-02T13:01:57.852545+00:00",
        "updated_at": "2024-12-02T13:01:57.852545+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 1.0,
        "period": "hours",
        "price_structure_id": "0f8445a1-a3f9-4ddb-adf7-0764e31741ee"
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
    "id": "bd552364-0ca2-431f-b207-ba0a842ad0e4",
    "type": "price_structures",
    "attributes": {
      "created_at": "2024-12-02T13:02:00.914048+00:00",
      "updated_at": "2024-12-02T13:02:00.922805+00:00",
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
            "id": "e4f7daaf-1483-4962-a3c7-4d08bb98f07c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e4f7daaf-1483-4962-a3c7-4d08bb98f07c",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-12-02T13:02:00.918708+00:00",
        "updated_at": "2024-12-02T13:02:00.918708+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 1.0,
        "period": "hours",
        "price_structure_id": "bd552364-0ca2-431f-b207-ba0a842ad0e4"
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
    --url 'https://example.booqable.com/api/boomerang/price_structures/7dcaf096-985a-4c15-b30b-2b6d95dd3585' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7dcaf096-985a-4c15-b30b-2b6d95dd3585",
        "type": "price_structures",
        "attributes": {
          "name": "Charge per week (cut-rate > 3 weeks)",
          "price_tiles_attributes": [
            {
              "id": "bc4403f4-98a7-4e8f-aa91-eca3656b6feb",
              "name": "1 semana"
            },
            {
              "id": "68d7476f-53fc-4872-acaf-fbc6dcd82700",
              "name": "2 semanas"
            },
            {
              "id": "42127137-30d9-4866-a6ee-3d2cc4dff6c3",
              "name": "3 semanas"
            },
            {
              "id": "15346817-e8fc-4756-979a-40ecf28742db",
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
    "id": "7dcaf096-985a-4c15-b30b-2b6d95dd3585",
    "type": "price_structures",
    "attributes": {
      "created_at": "2024-12-02T13:02:00.367616+00:00",
      "updated_at": "2024-12-02T13:02:00.433065+00:00",
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
            "id": "bc4403f4-98a7-4e8f-aa91-eca3656b6feb"
          },
          {
            "type": "price_tiles",
            "id": "68d7476f-53fc-4872-acaf-fbc6dcd82700"
          },
          {
            "type": "price_tiles",
            "id": "42127137-30d9-4866-a6ee-3d2cc4dff6c3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bc4403f4-98a7-4e8f-aa91-eca3656b6feb",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-12-02T13:02:00.370126+00:00",
        "updated_at": "2024-12-02T13:02:00.426864+00:00",
        "name": "1 semana",
        "quantity": 1,
        "length": 604800,
        "multiplier": 1.0,
        "period": "weeks",
        "price_structure_id": "7dcaf096-985a-4c15-b30b-2b6d95dd3585"
      },
      "relationships": {}
    },
    {
      "id": "68d7476f-53fc-4872-acaf-fbc6dcd82700",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-12-02T13:02:00.374917+00:00",
        "updated_at": "2024-12-02T13:02:00.429231+00:00",
        "name": "2 semanas",
        "quantity": 2,
        "length": 1209600,
        "multiplier": 2.0,
        "period": "weeks",
        "price_structure_id": "7dcaf096-985a-4c15-b30b-2b6d95dd3585"
      },
      "relationships": {}
    },
    {
      "id": "42127137-30d9-4866-a6ee-3d2cc4dff6c3",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-12-02T13:02:00.378966+00:00",
        "updated_at": "2024-12-02T13:02:00.431311+00:00",
        "name": "3 semanas",
        "quantity": 3,
        "length": 1814400,
        "multiplier": 3.0,
        "period": "weeks",
        "price_structure_id": "7dcaf096-985a-4c15-b30b-2b6d95dd3585"
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
    --url 'https://example.booqable.com/api/boomerang/price_structures/cee69c43-7851-4254-be9b-2d07d314d54e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cee69c43-7851-4254-be9b-2d07d314d54e",
    "type": "price_structures",
    "attributes": {
      "created_at": "2024-12-02T13:01:58.412830+00:00",
      "updated_at": "2024-12-02T13:01:58.439902+00:00",
      "archived": true,
      "archived_at": "2024-12-02T13:01:58.439902+00:00",
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