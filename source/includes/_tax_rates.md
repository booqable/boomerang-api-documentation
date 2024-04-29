# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`GET /api/boomerang/tax_rates/{id}`

`GET api/boomerang/tax_rates`

`PUT /api/boomerang/tax_rates/{id}`

`DELETE /api/boomerang/tax_rates/{id}`

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


## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/5bf82591-5c8a-4503-b65a-29469b860f4d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5bf82591-5c8a-4503-b65a-29469b860f4d",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-29T09:26:56+00:00",
      "updated_at": "2024-04-29T09:26:56+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "d80b878e-6889-46d9-acc8-980e36395497",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/d80b878e-6889-46d9-acc8-980e36395497"
        },
        "data": {
          "type": "tax_regions",
          "id": "d80b878e-6889-46d9-acc8-980e36395497"
        }
      }
    }
  },
  "included": [
    {
      "id": "d80b878e-6889-46d9-acc8-980e36395497",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-04-29T09:26:56+00:00",
        "updated_at": "2024-04-29T09:26:56+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=d80b878e-6889-46d9-acc8-980e36395497&filter[owner_type]=tax_regions"
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
      "id": "d9116e2f-0d50-44c0-985b-bfaec06b784b",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-04-29T09:26:57+00:00",
        "updated_at": "2024-04-29T09:26:57+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "d2079099-7c5e-4d20-89ec-ab001f7c3740",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/d2079099-7c5e-4d20-89ec-ab001f7c3740"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c5754227-4b77-4db4-acca-7ddaa0714a71' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c5754227-4b77-4db4-acca-7ddaa0714a71",
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
    "id": "c5754227-4b77-4db4-acca-7ddaa0714a71",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-29T09:26:58+00:00",
      "updated_at": "2024-04-29T09:26:58+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "63ca9027-b9c4-4a7e-a6ec-d7e4aac9f80b",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "63ca9027-b9c4-4a7e-a6ec-d7e4aac9f80b"
        }
      }
    }
  },
  "included": [
    {
      "id": "63ca9027-b9c4-4a7e-a6ec-d7e4aac9f80b",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-04-29T09:26:58+00:00",
        "updated_at": "2024-04-29T09:26:58+00:00",
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






## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/812605be-d025-4b3f-a858-276505cbad53' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "812605be-d025-4b3f-a858-276505cbad53",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-29T09:26:58+00:00",
      "updated_at": "2024-04-29T09:26:58+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "4a1abb5d-4f46-491d-bcf5-389ca00fe733",
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
          "owner_id": "b99fd6fb-d8d5-48d4-9b02-d97ae6c14f2c",
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
    "id": "862db6a3-90af-42c4-aeeb-4db80499b636",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-29T09:26:59+00:00",
      "updated_at": "2024-04-29T09:26:59+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "b99fd6fb-d8d5-48d4-9b02-d97ae6c14f2c",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "b99fd6fb-d8d5-48d4-9b02-d97ae6c14f2c"
        }
      }
    }
  },
  "included": [
    {
      "id": "b99fd6fb-d8d5-48d4-9b02-d97ae6c14f2c",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-04-29T09:26:59+00:00",
        "updated_at": "2024-04-29T09:26:59+00:00",
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





