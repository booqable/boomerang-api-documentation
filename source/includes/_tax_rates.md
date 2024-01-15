# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`DELETE /api/boomerang/tax_rates/{id}`

`GET /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

`GET api/boomerang/tax_rates`

`PUT /api/boomerang/tax_rates/{id}`

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


## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/f3fe2719-92fd-40a5-a5fa-e6b17c33dfa2' \
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/ec9ac58c-b616-4ad7-b709-42c234af5b59?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ec9ac58c-b616-4ad7-b709-42c234af5b59",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-01-15T09:14:09+00:00",
      "updated_at": "2024-01-15T09:14:09+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "337dfe50-1043-46c3-8581-33c8585b78f6",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/337dfe50-1043-46c3-8581-33c8585b78f6"
        },
        "data": {
          "type": "tax_regions",
          "id": "337dfe50-1043-46c3-8581-33c8585b78f6"
        }
      }
    }
  },
  "included": [
    {
      "id": "337dfe50-1043-46c3-8581-33c8585b78f6",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-01-15T09:14:09+00:00",
        "updated_at": "2024-01-15T09:14:09+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=337dfe50-1043-46c3-8581-33c8585b78f6&filter[owner_type]=tax_regions"
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
          "owner_id": "7e472bb8-fc33-400d-b525-a0b8bdaecb59",
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
    "id": "e785d811-b620-4e37-bf06-50c96807ed82",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-01-15T09:14:10+00:00",
      "updated_at": "2024-01-15T09:14:10+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "7e472bb8-fc33-400d-b525-a0b8bdaecb59",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "7e472bb8-fc33-400d-b525-a0b8bdaecb59"
        }
      }
    }
  },
  "included": [
    {
      "id": "7e472bb8-fc33-400d-b525-a0b8bdaecb59",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-01-15T09:14:10+00:00",
        "updated_at": "2024-01-15T09:14:10+00:00",
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
      "id": "b6b9a66e-87b8-4b34-b12d-e37bce571c68",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-01-15T09:14:11+00:00",
        "updated_at": "2024-01-15T09:14:11+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "f02b28b7-fc21-46e5-8987-6acd9ff6cfbb",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/f02b28b7-fc21-46e5-8987-6acd9ff6cfbb"
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






## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/77734a01-d716-4972-a112-d6d6085d8e5d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "77734a01-d716-4972-a112-d6d6085d8e5d",
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
    "id": "77734a01-d716-4972-a112-d6d6085d8e5d",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-01-15T09:14:11+00:00",
      "updated_at": "2024-01-15T09:14:11+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "09917330-0ff8-44fb-8d5e-03b801fa8dbb",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "09917330-0ff8-44fb-8d5e-03b801fa8dbb"
        }
      }
    }
  },
  "included": [
    {
      "id": "09917330-0ff8-44fb-8d5e-03b801fa8dbb",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-01-15T09:14:11+00:00",
        "updated_at": "2024-01-15T09:14:11+00:00",
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





