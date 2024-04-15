# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`GET api/boomerang/tax_rates`

`GET /api/boomerang/tax_rates/{id}`

`PUT /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

`DELETE /api/boomerang/tax_rates/{id}`

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
      "id": "683b8d4b-e5d7-49f5-92fc-23c7e75a916d",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-04-15T09:24:41+00:00",
        "updated_at": "2024-04-15T09:24:41+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "96f0f417-74ec-4914-8208-3d3de1482c17",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/96f0f417-74ec-4914-8208-3d3de1482c17"
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






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/544ec031-f7e9-4582-bbde-b0c51d879104?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "544ec031-f7e9-4582-bbde-b0c51d879104",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-15T09:24:42+00:00",
      "updated_at": "2024-04-15T09:24:42+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "8f544a74-fa7e-4c4e-92fc-eb9e27f54fb4",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/8f544a74-fa7e-4c4e-92fc-eb9e27f54fb4"
        },
        "data": {
          "type": "tax_regions",
          "id": "8f544a74-fa7e-4c4e-92fc-eb9e27f54fb4"
        }
      }
    }
  },
  "included": [
    {
      "id": "8f544a74-fa7e-4c4e-92fc-eb9e27f54fb4",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-04-15T09:24:42+00:00",
        "updated_at": "2024-04-15T09:24:42+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=8f544a74-fa7e-4c4e-92fc-eb9e27f54fb4&filter[owner_type]=tax_regions"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/d954ec6b-a9f3-4ebb-9e38-1ce77a2b1d80' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d954ec6b-a9f3-4ebb-9e38-1ce77a2b1d80",
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
    "id": "d954ec6b-a9f3-4ebb-9e38-1ce77a2b1d80",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-15T09:24:42+00:00",
      "updated_at": "2024-04-15T09:24:42+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "99e1e158-654f-4d4c-9e62-ed558e96f3d8",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "99e1e158-654f-4d4c-9e62-ed558e96f3d8"
        }
      }
    }
  },
  "included": [
    {
      "id": "99e1e158-654f-4d4c-9e62-ed558e96f3d8",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-04-15T09:24:42+00:00",
        "updated_at": "2024-04-15T09:24:42+00:00",
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
          "owner_id": "0e60265f-bb58-470f-a507-1812af483e85",
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
    "id": "3e3db2f8-bfc7-4d96-9bf1-a9d3eb4fe93b",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-15T09:24:43+00:00",
      "updated_at": "2024-04-15T09:24:43+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "0e60265f-bb58-470f-a507-1812af483e85",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "0e60265f-bb58-470f-a507-1812af483e85"
        }
      }
    }
  },
  "included": [
    {
      "id": "0e60265f-bb58-470f-a507-1812af483e85",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-04-15T09:24:43+00:00",
        "updated_at": "2024-04-15T09:24:43+00:00",
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






## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/e7c4cbfe-138a-432c-9699-0eecfaa26793' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e7c4cbfe-138a-432c-9699-0eecfaa26793",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-15T09:24:44+00:00",
      "updated_at": "2024-04-15T09:24:44+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "8a7e04be-2dbf-48f9-914b-74d0ddf1a343",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "meta": {
          "included": false
        }
      }
    }
  },
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