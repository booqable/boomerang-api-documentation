# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`PUT /api/boomerang/tax_rates/{id}`

`GET api/boomerang/tax_rates`

`DELETE /api/boomerang/tax_rates/{id}`

`GET /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

## Fields
Every tax rate has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>The name of the tax rate
`value` | **Float** <br>The percentage value of the rate
`position` | **Integer** `readonly`<br>Position of the tax rate
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `tax_regions`, `tax_categories`


## Relationships
Tax rates have the following relationships:

Name | Description
-- | --
`owner` | **Tax category, Tax region**<br>Associated Owner


## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/36c81cf2-749c-418d-aa3b-08563b32359c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "36c81cf2-749c-418d-aa3b-08563b32359c",
        "type": "tax_rates",
        "attributes": {
          "value": 9
        }
      },
      "include": "owner"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "36c81cf2-749c-418d-aa3b-08563b32359c",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-02-19T09:22:28+00:00",
      "updated_at": "2024-02-19T09:22:28+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "199457e5-a2f1-4339-9c6f-fb9d2271afe1",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "199457e5-a2f1-4339-9c6f-fb9d2271afe1"
        }
      }
    }
  },
  "included": [
    {
      "id": "199457e5-a2f1-4339-9c6f-fb9d2271afe1",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-02-19T09:22:28+00:00",
        "updated_at": "2024-02-19T09:22:28+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
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

`PUT /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>The name of the tax rate
`data[attributes][value]` | **Float** <br>The percentage value of the rate
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `tax_regions`, `tax_categories`


### Includes

This request accepts the following includes:

`owner`






## Listing tax rates



> How to fetch a list of tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a729ad45-9051-456b-b9da-0dc557c422e9",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-02-19T09:22:30+00:00",
        "updated_at": "2024-02-19T09:22:30+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "bf774e47-4aaa-411b-9de6-1238587bcd0f",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/bf774e47-4aaa-411b-9de6-1238587bcd0f"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET api/boomerang/tax_rates`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`
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
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/e5942bb0-b59b-4427-b059-16beb29d7b63' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/670d0f91-449e-4233-a67c-08c16ee6ba0b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "670d0f91-449e-4233-a67c-08c16ee6ba0b",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-02-19T09:22:33+00:00",
      "updated_at": "2024-02-19T09:22:33+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "9702ba19-83a1-4b71-9e04-a649115ee75b",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/9702ba19-83a1-4b71-9e04-a649115ee75b"
        },
        "data": {
          "type": "tax_regions",
          "id": "9702ba19-83a1-4b71-9e04-a649115ee75b"
        }
      }
    }
  },
  "included": [
    {
      "id": "9702ba19-83a1-4b71-9e04-a649115ee75b",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-02-19T09:22:33+00:00",
        "updated_at": "2024-02-19T09:22:33+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=9702ba19-83a1-4b71-9e04-a649115ee75b&filter[owner_type]=tax_regions"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Includes

This request accepts the following includes:

`owner`






## Creating a tax rate



> How to create a tax rate and associate it with an owner:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/tax_rates' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "tax_rates",
        "attributes": {
          "name": "VAT",
          "value": 21,
          "owner_id": "9e18243f-1ff8-4a39-9790-0d0706d8ca6e",
          "owner_type": "tax_regions"
        }
      },
      "include": "owner"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "161f151a-d8d5-4025-8587-f9b3ae504898",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-02-19T09:22:33+00:00",
      "updated_at": "2024-02-19T09:22:33+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "9e18243f-1ff8-4a39-9790-0d0706d8ca6e",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "9e18243f-1ff8-4a39-9790-0d0706d8ca6e"
        }
      }
    }
  },
  "included": [
    {
      "id": "9e18243f-1ff8-4a39-9790-0d0706d8ca6e",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-02-19T09:22:33+00:00",
        "updated_at": "2024-02-19T09:22:33+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
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

`POST /api/boomerang/tax_rates`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>The name of the tax rate
`data[attributes][value]` | **Float** <br>The percentage value of the rate
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `tax_regions`, `tax_categories`


### Includes

This request accepts the following includes:

`owner`





