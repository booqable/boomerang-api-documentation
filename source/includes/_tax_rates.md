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
      "id": "50b8df16-b38d-417f-b04d-a6f3f0d118e6",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-05-06T09:22:40+00:00",
        "updated_at": "2024-05-06T09:22:40+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "4223b03b-db62-4e11-b414-e8a2da0ae03b",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/4223b03b-db62-4e11-b414-e8a2da0ae03b"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/854782c4-200b-4405-95fb-7e1369785157?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "854782c4-200b-4405-95fb-7e1369785157",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-05-06T09:22:40+00:00",
      "updated_at": "2024-05-06T09:22:40+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "142c3257-1d89-4b7e-b0dc-5ef7c9d8c4d4",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/142c3257-1d89-4b7e-b0dc-5ef7c9d8c4d4"
        },
        "data": {
          "type": "tax_regions",
          "id": "142c3257-1d89-4b7e-b0dc-5ef7c9d8c4d4"
        }
      }
    }
  },
  "included": [
    {
      "id": "142c3257-1d89-4b7e-b0dc-5ef7c9d8c4d4",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-05-06T09:22:40+00:00",
        "updated_at": "2024-05-06T09:22:40+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=142c3257-1d89-4b7e-b0dc-5ef7c9d8c4d4&filter[owner_type]=tax_regions"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/30a090ff-b6ea-4711-a8cb-9c60b579da01' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "30a090ff-b6ea-4711-a8cb-9c60b579da01",
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
    "id": "30a090ff-b6ea-4711-a8cb-9c60b579da01",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-05-06T09:22:41+00:00",
      "updated_at": "2024-05-06T09:22:41+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "5574b367-16f8-4761-8b65-6f6da1489a13",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "5574b367-16f8-4761-8b65-6f6da1489a13"
        }
      }
    }
  },
  "included": [
    {
      "id": "5574b367-16f8-4761-8b65-6f6da1489a13",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-05-06T09:22:41+00:00",
        "updated_at": "2024-05-06T09:22:41+00:00",
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
          "owner_id": "9106a7ab-b868-46d3-a0c0-4d19c9b87cc6",
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
    "id": "87509123-628d-4659-8b4a-58376b73b948",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-05-06T09:22:41+00:00",
      "updated_at": "2024-05-06T09:22:41+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "9106a7ab-b868-46d3-a0c0-4d19c9b87cc6",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "9106a7ab-b868-46d3-a0c0-4d19c9b87cc6"
        }
      }
    }
  },
  "included": [
    {
      "id": "9106a7ab-b868-46d3-a0c0-4d19c9b87cc6",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-05-06T09:22:41+00:00",
        "updated_at": "2024-05-06T09:22:41+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/fce4d2d3-ef5a-49d4-a59f-ec9d6d5595e0' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fce4d2d3-ef5a-49d4-a59f-ec9d6d5595e0",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-05-06T09:22:42+00:00",
      "updated_at": "2024-05-06T09:22:42+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "6b8482b4-14b0-490f-9267-71cf7066639f",
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