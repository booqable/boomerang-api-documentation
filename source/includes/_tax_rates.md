# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`DELETE /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

`GET /api/boomerang/tax_rates/{id}`

`PUT /api/boomerang/tax_rates/{id}`

`GET api/boomerang/tax_rates`

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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/3b9cfb05-bc6d-482b-a8a5-3ba40dc09e81' \
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
          "owner_id": "fd76b6b2-0afb-4ccc-b036-88f6ce9b5e77",
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
    "id": "78250d6a-b96b-42b4-82ff-8ded05c948f3",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-03-11T09:18:16+00:00",
      "updated_at": "2024-03-11T09:18:16+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "fd76b6b2-0afb-4ccc-b036-88f6ce9b5e77",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "fd76b6b2-0afb-4ccc-b036-88f6ce9b5e77"
        }
      }
    }
  },
  "included": [
    {
      "id": "fd76b6b2-0afb-4ccc-b036-88f6ce9b5e77",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-03-11T09:18:16+00:00",
        "updated_at": "2024-03-11T09:18:16+00:00",
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






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/15530ebe-ed93-4f6e-96c9-e1dcf448e4ed?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "15530ebe-ed93-4f6e-96c9-e1dcf448e4ed",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-03-11T09:18:16+00:00",
      "updated_at": "2024-03-11T09:18:16+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "62c77f1c-0d37-4d5f-9e14-62deb3f77417",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/62c77f1c-0d37-4d5f-9e14-62deb3f77417"
        },
        "data": {
          "type": "tax_regions",
          "id": "62c77f1c-0d37-4d5f-9e14-62deb3f77417"
        }
      }
    }
  },
  "included": [
    {
      "id": "62c77f1c-0d37-4d5f-9e14-62deb3f77417",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-03-11T09:18:16+00:00",
        "updated_at": "2024-03-11T09:18:16+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=62c77f1c-0d37-4d5f-9e14-62deb3f77417&filter[owner_type]=tax_regions"
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






## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/5d42afc5-bf41-47fa-b423-cb0f7d51bac5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5d42afc5-bf41-47fa-b423-cb0f7d51bac5",
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
    "id": "5d42afc5-bf41-47fa-b423-cb0f7d51bac5",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-03-11T09:18:17+00:00",
      "updated_at": "2024-03-11T09:18:17+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "c96c0ed1-2599-4371-98b6-ee0fd851444c",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "c96c0ed1-2599-4371-98b6-ee0fd851444c"
        }
      }
    }
  },
  "included": [
    {
      "id": "c96c0ed1-2599-4371-98b6-ee0fd851444c",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-03-11T09:18:17+00:00",
        "updated_at": "2024-03-11T09:18:17+00:00",
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
      "id": "3a430181-3cb6-4070-a1a5-8d32a8fc62d3",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-03-11T09:18:18+00:00",
        "updated_at": "2024-03-11T09:18:18+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "8c33331a-1506-4701-8e86-2fcea6c8a4c9",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/8c33331a-1506-4701-8e86-2fcea6c8a4c9"
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





