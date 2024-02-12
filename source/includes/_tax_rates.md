# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`DELETE /api/boomerang/tax_rates/{id}`

`PUT /api/boomerang/tax_rates/{id}`

`GET /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/e3fd8b7c-feb0-4f89-80dd-067027629a03' \
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
## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/a0256b41-524e-47db-a208-c211b79e5d16' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a0256b41-524e-47db-a208-c211b79e5d16",
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
    "id": "a0256b41-524e-47db-a208-c211b79e5d16",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-02-12T09:18:27+00:00",
      "updated_at": "2024-02-12T09:18:27+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "3317508f-85e3-42d0-8c59-c79ef3283426",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "3317508f-85e3-42d0-8c59-c79ef3283426"
        }
      }
    }
  },
  "included": [
    {
      "id": "3317508f-85e3-42d0-8c59-c79ef3283426",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-02-12T09:18:27+00:00",
        "updated_at": "2024-02-12T09:18:27+00:00",
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






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/31a1200e-84bc-4834-bb71-9656f17f6202?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "31a1200e-84bc-4834-bb71-9656f17f6202",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-02-12T09:18:28+00:00",
      "updated_at": "2024-02-12T09:18:28+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "1bda5a3e-c167-49a8-a315-20e5ac420b6e",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/1bda5a3e-c167-49a8-a315-20e5ac420b6e"
        },
        "data": {
          "type": "tax_regions",
          "id": "1bda5a3e-c167-49a8-a315-20e5ac420b6e"
        }
      }
    }
  },
  "included": [
    {
      "id": "1bda5a3e-c167-49a8-a315-20e5ac420b6e",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-02-12T09:18:28+00:00",
        "updated_at": "2024-02-12T09:18:28+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=1bda5a3e-c167-49a8-a315-20e5ac420b6e&filter[owner_type]=tax_regions"
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
          "owner_id": "bdcbdac1-a0d5-40c3-a12e-d7994ee8d093",
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
    "id": "5cb5d656-7155-4c2b-bb5b-aa0d35d0e85c",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-02-12T09:18:28+00:00",
      "updated_at": "2024-02-12T09:18:28+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "bdcbdac1-a0d5-40c3-a12e-d7994ee8d093",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "bdcbdac1-a0d5-40c3-a12e-d7994ee8d093"
        }
      }
    }
  },
  "included": [
    {
      "id": "bdcbdac1-a0d5-40c3-a12e-d7994ee8d093",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-02-12T09:18:28+00:00",
        "updated_at": "2024-02-12T09:18:28+00:00",
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
      "id": "be749bb9-b64d-4bc5-b4f1-4f32acadb00f",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-02-12T09:18:29+00:00",
        "updated_at": "2024-02-12T09:18:29+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "61e08b03-4685-4c89-9701-150785765f50",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/61e08b03-4685-4c89-9701-150785765f50"
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





