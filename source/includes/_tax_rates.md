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
      "id": "0bda74eb-826a-47eb-9a08-fa3a70e53ca5",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-11-04T15:26:56+00:00",
        "updated_at": "2022-11-04T15:26:56+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "0c9cd127-ebad-48f2-b8fc-dcbd0fb4befa",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/0c9cd127-ebad-48f2-b8fc-dcbd0fb4befa"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-04T15:22:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/e47e9153-5454-4138-8363-c08713915d32?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e47e9153-5454-4138-8363-c08713915d32",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-11-04T15:26:57+00:00",
      "updated_at": "2022-11-04T15:26:57+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "b3fd7ea3-e3f9-4203-ab1a-faebf1ba40b3",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/b3fd7ea3-e3f9-4203-ab1a-faebf1ba40b3"
        },
        "data": {
          "type": "tax_regions",
          "id": "b3fd7ea3-e3f9-4203-ab1a-faebf1ba40b3"
        }
      }
    }
  },
  "included": [
    {
      "id": "b3fd7ea3-e3f9-4203-ab1a-faebf1ba40b3",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2022-11-04T15:26:57+00:00",
        "updated_at": "2022-11-04T15:26:57+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=b3fd7ea3-e3f9-4203-ab1a-faebf1ba40b3&filter[owner_type]=tax_regions"
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
          "owner_id": "cf30483e-fa88-4a86-a9cf-a0ec6ba1cfbb",
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
    "id": "6475d23d-cf6e-4dd8-9cc1-169b302bffb7",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-11-04T15:26:57+00:00",
      "updated_at": "2022-11-04T15:26:57+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "cf30483e-fa88-4a86-a9cf-a0ec6ba1cfbb",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "cf30483e-fa88-4a86-a9cf-a0ec6ba1cfbb"
        }
      }
    }
  },
  "included": [
    {
      "id": "cf30483e-fa88-4a86-a9cf-a0ec6ba1cfbb",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2022-11-04T15:26:57+00:00",
        "updated_at": "2022-11-04T15:26:57+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/ea03783f-0760-4e77-8d6b-7c5f8b6f02e1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ea03783f-0760-4e77-8d6b-7c5f8b6f02e1",
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
    "id": "ea03783f-0760-4e77-8d6b-7c5f8b6f02e1",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-11-04T15:26:57+00:00",
      "updated_at": "2022-11-04T15:26:57+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "04377810-eec8-4f93-9d3c-d17fb34034f6",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "04377810-eec8-4f93-9d3c-d17fb34034f6"
        }
      }
    }
  },
  "included": [
    {
      "id": "04377810-eec8-4f93-9d3c-d17fb34034f6",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2022-11-04T15:26:57+00:00",
        "updated_at": "2022-11-04T15:26:57+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/17d94888-acfd-44e0-9777-b201cb3aa8eb' \
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