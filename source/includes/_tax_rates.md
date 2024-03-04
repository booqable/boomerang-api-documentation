# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`GET api/boomerang/tax_rates`

`POST /api/boomerang/tax_rates`

`DELETE /api/boomerang/tax_rates/{id}`

`PUT /api/boomerang/tax_rates/{id}`

`GET /api/boomerang/tax_rates/{id}`

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
      "id": "63376258-62b0-4e17-9089-686c1a50799d",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-03-04T09:15:49+00:00",
        "updated_at": "2024-03-04T09:15:49+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "1a34e687-4a75-4fa1-b3ec-6a7d521b9c31",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/1a34e687-4a75-4fa1-b3ec-6a7d521b9c31"
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
          "owner_id": "29a013bd-8474-4354-ba18-471ad7798791",
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
    "id": "c47f501d-5f63-4678-9d8b-2a7ed86b345a",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-03-04T09:15:49+00:00",
      "updated_at": "2024-03-04T09:15:49+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "29a013bd-8474-4354-ba18-471ad7798791",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "29a013bd-8474-4354-ba18-471ad7798791"
        }
      }
    }
  },
  "included": [
    {
      "id": "29a013bd-8474-4354-ba18-471ad7798791",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-03-04T09:15:49+00:00",
        "updated_at": "2024-03-04T09:15:49+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/3356bb3c-e9ab-4cb1-933a-b614b2b8e6f9' \
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/fdb26461-c201-449d-9fa1-43eb91a0dd63' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fdb26461-c201-449d-9fa1-43eb91a0dd63",
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
    "id": "fdb26461-c201-449d-9fa1-43eb91a0dd63",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-03-04T09:15:51+00:00",
      "updated_at": "2024-03-04T09:15:51+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "e12b3ed8-e650-4a8f-92f4-b60e259199c3",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "e12b3ed8-e650-4a8f-92f4-b60e259199c3"
        }
      }
    }
  },
  "included": [
    {
      "id": "e12b3ed8-e650-4a8f-92f4-b60e259199c3",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-03-04T09:15:51+00:00",
        "updated_at": "2024-03-04T09:15:51+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/5b8b92e7-1ae3-4042-8411-a5cdc3f44fe3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5b8b92e7-1ae3-4042-8411-a5cdc3f44fe3",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-03-04T09:15:51+00:00",
      "updated_at": "2024-03-04T09:15:51+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "809031c5-5e34-4f3d-9b29-f14128617dcc",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/809031c5-5e34-4f3d-9b29-f14128617dcc"
        },
        "data": {
          "type": "tax_regions",
          "id": "809031c5-5e34-4f3d-9b29-f14128617dcc"
        }
      }
    }
  },
  "included": [
    {
      "id": "809031c5-5e34-4f3d-9b29-f14128617dcc",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-03-04T09:15:51+00:00",
        "updated_at": "2024-03-04T09:15:51+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=809031c5-5e34-4f3d-9b29-f14128617dcc&filter[owner_type]=tax_regions"
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





