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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether price structure is archived
`archived_at` | **Datetime** `readonly`<br>When the price structure was archived
`name` | **String**<br>Name of the structure
`price_structure_type` | **String** `readonly`<br>One of `reusable`, `private`
`price_tiles_attributes` | **Array** `writeonly`<br>The price tiles to associate
`hour` | **Float**<br>Multiplier for every hour outside of its tiles
`day` | **Float**<br>Multiplier for every day outside of its tiles
`week` | **Float**<br>Multiplier for every week outside of its tiles
`month` | **Float**<br>Multiplier for every month outside of its tiles
`year` | **Float**<br>Multiplier for every year outside of its tiles


## Relationships
Price structures have the following relationships:

Name | Description
- | -
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
      "id": "419dd47d-6de3-4476-aaf8-d5b4ba9c3632",
      "type": "price_structures",
      "attributes": {
        "created_at": "2022-03-04T10:47:39+00:00",
        "updated_at": "2022-03-04T10:47:39+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Price per hour (3 hours minimum)",
        "price_structure_type": "reusable",
        "hour": 1.0,
        "day": 0.0,
        "week": 0.0,
        "month": 0.0,
        "year": 0.0
      },
      "relationships": {
        "price_tiles": {
          "links": {
            "related": "api/boomerang/price_tiles?filter[price_structure_id]=419dd47d-6de3-4476-aaf8-d5b4ba9c3632"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_structures]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-04T10:45:33Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean**<br>`eq`
`price_structure_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a price structure with it's tiles:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_structures/c844246a-8e60-48ee-a466-7d40c1649a03?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c844246a-8e60-48ee-a466-7d40c1649a03",
    "type": "price_structures",
    "attributes": {
      "created_at": "2022-03-04T10:47:39+00:00",
      "updated_at": "2022-03-04T10:47:39+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Price per hour (3 hours minimum)",
      "price_structure_type": "reusable",
      "hour": 1.0,
      "day": 0.0,
      "week": 0.0,
      "month": 0.0,
      "year": 0.0
    },
    "relationships": {
      "price_tiles": {
        "links": {
          "related": "api/boomerang/price_tiles?filter[price_structure_id]=c844246a-8e60-48ee-a466-7d40c1649a03"
        },
        "data": [
          {
            "type": "price_tiles",
            "id": "1b06236d-9bf0-4123-b899-8c6e03bba3d5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1b06236d-9bf0-4123-b899-8c6e03bba3d5",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2022-03-04T10:47:39+00:00",
        "updated_at": "2022-03-04T10:47:39+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 1.0,
        "period": "hours",
        "price_structure_id": "c844246a-8e60-48ee-a466-7d40c1649a03"
      },
      "relationships": {
        "price_structure": {
          "links": {
            "related": "api/boomerang/price_structures/c844246a-8e60-48ee-a466-7d40c1649a03"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_structures]=id,created_at,updated_at`


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
    "id": "c5687ada-266b-4400-a866-b446759183bb",
    "type": "price_structures",
    "attributes": {
      "created_at": "2022-03-04T10:47:39+00:00",
      "updated_at": "2022-03-04T10:47:39+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Price per hour (3 hours minimum)",
      "price_structure_type": "reusable",
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
            "id": "b6da1e87-b0b1-4dde-be67-c6600f7baaaf"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b6da1e87-b0b1-4dde-be67-c6600f7baaaf",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2022-03-04T10:47:39+00:00",
        "updated_at": "2022-03-04T10:47:39+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 1.0,
        "period": "hours",
        "price_structure_id": "c5687ada-266b-4400-a866-b446759183bb"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_structures]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the structure
`data[attributes][price_tiles_attributes][]` | **Array**<br>The price tiles to associate
`data[attributes][hour]` | **Float**<br>Multiplier for every hour outside of its tiles
`data[attributes][day]` | **Float**<br>Multiplier for every day outside of its tiles
`data[attributes][week]` | **Float**<br>Multiplier for every week outside of its tiles
`data[attributes][month]` | **Float**<br>Multiplier for every month outside of its tiles
`data[attributes][year]` | **Float**<br>Multiplier for every year outside of its tiles


### Includes

This request accepts the following includes:

`price_tiles`






## Updating a price structure



> How to update a price structure with price tiles:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_structures/e1921d16-815b-4c56-9e22-c5f4555e1317' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e1921d16-815b-4c56-9e22-c5f4555e1317",
        "type": "price_structures",
        "attributes": {
          "name": "Charge per week (cut-rate > 3 weeks)",
          "price_tiles_attributes": [
            {
              "id": "10444b62-2b0f-4ed2-9f1d-6e6dd21918b0",
              "name": "1 semana"
            },
            {
              "id": "4fc27ce9-9b1d-45e5-98c0-a81de5022157",
              "name": "2 semanas"
            },
            {
              "id": "f1e6c163-e90e-4743-9a47-40d1cfc431fd",
              "name": "3 semanas"
            },
            {
              "id": "b848f6e6-47a0-4120-b8b1-e61a1754b3de",
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
    "id": "e1921d16-815b-4c56-9e22-c5f4555e1317",
    "type": "price_structures",
    "attributes": {
      "created_at": "2022-03-04T10:47:39+00:00",
      "updated_at": "2022-03-04T10:47:39+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Charge per week (cut-rate > 3 weeks)",
      "price_structure_type": "reusable",
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
            "id": "10444b62-2b0f-4ed2-9f1d-6e6dd21918b0"
          },
          {
            "type": "price_tiles",
            "id": "4fc27ce9-9b1d-45e5-98c0-a81de5022157"
          },
          {
            "type": "price_tiles",
            "id": "f1e6c163-e90e-4743-9a47-40d1cfc431fd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "10444b62-2b0f-4ed2-9f1d-6e6dd21918b0",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2022-03-04T10:47:39+00:00",
        "updated_at": "2022-03-04T10:47:39+00:00",
        "name": "1 semana",
        "quantity": 1,
        "length": 604800,
        "multiplier": 1.0,
        "period": "weeks",
        "price_structure_id": "e1921d16-815b-4c56-9e22-c5f4555e1317"
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
      "id": "4fc27ce9-9b1d-45e5-98c0-a81de5022157",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2022-03-04T10:47:39+00:00",
        "updated_at": "2022-03-04T10:47:39+00:00",
        "name": "2 semanas",
        "quantity": 2,
        "length": 1209600,
        "multiplier": 2.0,
        "period": "weeks",
        "price_structure_id": "e1921d16-815b-4c56-9e22-c5f4555e1317"
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
      "id": "f1e6c163-e90e-4743-9a47-40d1cfc431fd",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2022-03-04T10:47:39+00:00",
        "updated_at": "2022-03-04T10:47:39+00:00",
        "name": "3 semanas",
        "quantity": 3,
        "length": 1814400,
        "multiplier": 3.0,
        "period": "weeks",
        "price_structure_id": "e1921d16-815b-4c56-9e22-c5f4555e1317"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_structures]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the structure
`data[attributes][price_tiles_attributes][]` | **Array**<br>The price tiles to associate
`data[attributes][hour]` | **Float**<br>Multiplier for every hour outside of its tiles
`data[attributes][day]` | **Float**<br>Multiplier for every day outside of its tiles
`data[attributes][week]` | **Float**<br>Multiplier for every week outside of its tiles
`data[attributes][month]` | **Float**<br>Multiplier for every month outside of its tiles
`data[attributes][year]` | **Float**<br>Multiplier for every year outside of its tiles


### Includes

This request accepts the following includes:

`price_tiles`






## Deleting a price structure



> How to delete a price structure with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_structures/69515a59-d6d2-4fb7-9f4d-94b40779465a' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_structures]=id,created_at,updated_at`


### Includes

This request does not accept any includes