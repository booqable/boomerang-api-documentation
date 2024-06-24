# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`GET api/boomerang/tax_rates`

`GET /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

`PUT /api/boomerang/tax_rates/{id}`

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
      "id": "dbfefa46-2c3c-449b-8c21-b3c4d555fc76",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-06-24T09:24:25.387762+00:00",
        "updated_at": "2024-06-24T09:24:25.387762+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "a8071efd-4d21-479c-bf84-6b918af341f5",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/a8071efd-4d21-479c-bf84-6b918af341f5"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/1ab0ffd8-c43f-4107-bb70-5263016c588d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1ab0ffd8-c43f-4107-bb70-5263016c588d",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-24T09:24:27.055496+00:00",
      "updated_at": "2024-06-24T09:24:27.055496+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "f006a0de-9e61-4566-9d3e-ed97235723b7",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/f006a0de-9e61-4566-9d3e-ed97235723b7"
        },
        "data": {
          "type": "tax_regions",
          "id": "f006a0de-9e61-4566-9d3e-ed97235723b7"
        }
      }
    }
  },
  "included": [
    {
      "id": "f006a0de-9e61-4566-9d3e-ed97235723b7",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-06-24T09:24:27.039091+00:00",
        "updated_at": "2024-06-24T09:24:27.059508+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=f006a0de-9e61-4566-9d3e-ed97235723b7&filter[owner_type]=tax_regions"
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
          "owner_id": "b46c874a-f7a5-45c1-a1f1-7833a5f28dc7",
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
    "id": "d0c5b935-54eb-41f8-8d76-c599c4a2a5d1",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-24T09:24:24.023461+00:00",
      "updated_at": "2024-06-24T09:24:24.023461+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "b46c874a-f7a5-45c1-a1f1-7833a5f28dc7",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "b46c874a-f7a5-45c1-a1f1-7833a5f28dc7"
        }
      }
    }
  },
  "included": [
    {
      "id": "b46c874a-f7a5-45c1-a1f1-7833a5f28dc7",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-06-24T09:24:23.984186+00:00",
        "updated_at": "2024-06-24T09:24:24.027387+00:00",
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






## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/78dace4a-8cfd-4d2b-98f5-f5b0dad7ef1b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "78dace4a-8cfd-4d2b-98f5-f5b0dad7ef1b",
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
    "id": "78dace4a-8cfd-4d2b-98f5-f5b0dad7ef1b",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-24T09:24:26.286036+00:00",
      "updated_at": "2024-06-24T09:24:26.343918+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "53d088c9-d7b0-443d-81d5-632470573a8a",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "53d088c9-d7b0-443d-81d5-632470573a8a"
        }
      }
    }
  },
  "included": [
    {
      "id": "53d088c9-d7b0-443d-81d5-632470573a8a",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-06-24T09:24:26.261906+00:00",
        "updated_at": "2024-06-24T09:24:26.348206+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/a8779cdf-0291-4da9-a661-104057f55c7e' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a8779cdf-0291-4da9-a661-104057f55c7e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-24T09:24:24.620290+00:00",
      "updated_at": "2024-06-24T09:24:24.620290+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "501a33b8-672e-4bbc-bdbe-048149a6b12c",
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