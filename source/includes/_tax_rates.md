# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`POST /api/boomerang/tax_rates`

`DELETE /api/boomerang/tax_rates/{id}`

`GET /api/boomerang/tax_rates/{id}`

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
          "owner_id": "8af3bdc4-6696-44cf-8653-b650eec111d3",
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
    "id": "1b13ddc5-229b-4e96-bb02-1a688340404f",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-22T09:24:32+00:00",
      "updated_at": "2024-04-22T09:24:32+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "8af3bdc4-6696-44cf-8653-b650eec111d3",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "8af3bdc4-6696-44cf-8653-b650eec111d3"
        }
      }
    }
  },
  "included": [
    {
      "id": "8af3bdc4-6696-44cf-8653-b650eec111d3",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-04-22T09:24:32+00:00",
        "updated_at": "2024-04-22T09:24:32+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/4c57588f-dc9a-4605-bf13-99e5c73f7a71' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4c57588f-dc9a-4605-bf13-99e5c73f7a71",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-22T09:24:32+00:00",
      "updated_at": "2024-04-22T09:24:32+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "045cc861-dc17-4c00-90d3-509b25ae2dfd",
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
## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/ad026b37-ef60-428e-b35b-ee2203d2df4e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ad026b37-ef60-428e-b35b-ee2203d2df4e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-22T09:24:33+00:00",
      "updated_at": "2024-04-22T09:24:33+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "9067a3a8-ea23-4a45-9e40-ab6b65047883",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/9067a3a8-ea23-4a45-9e40-ab6b65047883"
        },
        "data": {
          "type": "tax_regions",
          "id": "9067a3a8-ea23-4a45-9e40-ab6b65047883"
        }
      }
    }
  },
  "included": [
    {
      "id": "9067a3a8-ea23-4a45-9e40-ab6b65047883",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-04-22T09:24:33+00:00",
        "updated_at": "2024-04-22T09:24:33+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=9067a3a8-ea23-4a45-9e40-ab6b65047883&filter[owner_type]=tax_regions"
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
      "id": "615aed22-e849-4b59-bd09-441636e44fa2",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-04-22T09:24:34+00:00",
        "updated_at": "2024-04-22T09:24:34+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "5bb626fd-aa93-4fc3-afb3-7622e9bc0b56",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/5bb626fd-aa93-4fc3-afb3-7622e9bc0b56"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/6515e7e5-7818-43d5-853a-d926cd809896' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6515e7e5-7818-43d5-853a-d926cd809896",
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
    "id": "6515e7e5-7818-43d5-853a-d926cd809896",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-22T09:24:35+00:00",
      "updated_at": "2024-04-22T09:24:35+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "7c881d29-bcd1-431c-8d0e-1b6feabf8532",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "7c881d29-bcd1-431c-8d0e-1b6feabf8532"
        }
      }
    }
  },
  "included": [
    {
      "id": "7c881d29-bcd1-431c-8d0e-1b6feabf8532",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-04-22T09:24:35+00:00",
        "updated_at": "2024-04-22T09:24:35+00:00",
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





