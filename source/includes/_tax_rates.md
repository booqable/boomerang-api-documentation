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
- | -
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
- | -
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
      "id": "eaebede6-d0e0-4021-b8cb-fef16770dc88",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-03-02T09:27:55+00:00",
        "updated_at": "2023-03-02T09:27:55+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "16e33d0e-99dd-4c5c-a1a9-be97953a9a93",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/16e33d0e-99dd-4c5c-a1a9-be97953a9a93"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T09:22:42Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/b32a123e-8ecd-4e0d-a906-07f455027980?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b32a123e-8ecd-4e0d-a906-07f455027980",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-03-02T09:27:55+00:00",
      "updated_at": "2023-03-02T09:27:55+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "b11edb2d-f50c-40b0-8b71-b8d21b5b6320",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/b11edb2d-f50c-40b0-8b71-b8d21b5b6320"
        },
        "data": {
          "type": "tax_regions",
          "id": "b11edb2d-f50c-40b0-8b71-b8d21b5b6320"
        }
      }
    }
  },
  "included": [
    {
      "id": "b11edb2d-f50c-40b0-8b71-b8d21b5b6320",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-03-02T09:27:55+00:00",
        "updated_at": "2023-03-02T09:27:55+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=b11edb2d-f50c-40b0-8b71-b8d21b5b6320&filter[owner_type]=tax_regions"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


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
          "owner_id": "81553bb4-cf77-4aa7-a442-4583ab91b9fe",
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
    "id": "2e5bcee2-1b01-4cfd-a5b5-a7f3f9e003f6",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-03-02T09:27:55+00:00",
      "updated_at": "2023-03-02T09:27:55+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "81553bb4-cf77-4aa7-a442-4583ab91b9fe",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "81553bb4-cf77-4aa7-a442-4583ab91b9fe"
        }
      }
    }
  },
  "included": [
    {
      "id": "81553bb4-cf77-4aa7-a442-4583ab91b9fe",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-03-02T09:27:55+00:00",
        "updated_at": "2023-03-02T09:27:55+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c0f13dad-46a4-407f-8793-26bb317eda85' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c0f13dad-46a4-407f-8793-26bb317eda85",
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
    "id": "c0f13dad-46a4-407f-8793-26bb317eda85",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-03-02T09:27:56+00:00",
      "updated_at": "2023-03-02T09:27:56+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "7ef1cdd1-9bd6-4547-a5c5-474f9fc646d8",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "7ef1cdd1-9bd6-4547-a5c5-474f9fc646d8"
        }
      }
    }
  },
  "included": [
    {
      "id": "7ef1cdd1-9bd6-4547-a5c5-474f9fc646d8",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2023-03-02T09:27:56+00:00",
        "updated_at": "2023-03-02T09:27:56+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/816fac55-a617-4c91-a41b-137dbb41dba7' \
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Includes

This request does not accept any includes