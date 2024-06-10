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
      "id": "ee20ae6d-aaab-4464-9d79-5adbe00b4084",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-06-10T09:28:14.447240+00:00",
        "updated_at": "2024-06-10T09:28:14.447240+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "31fcf983-df2b-4eb7-9f45-98c98b1e07f9",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/31fcf983-df2b-4eb7-9f45-98c98b1e07f9"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/e77b96d9-b84b-4fae-ba6e-b9443dd5a87f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e77b96d9-b84b-4fae-ba6e-b9443dd5a87f",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-10T09:28:12.539713+00:00",
      "updated_at": "2024-06-10T09:28:12.539713+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "9463c613-35f7-4214-9a08-ced6cc245679",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/9463c613-35f7-4214-9a08-ced6cc245679"
        },
        "data": {
          "type": "tax_regions",
          "id": "9463c613-35f7-4214-9a08-ced6cc245679"
        }
      }
    }
  },
  "included": [
    {
      "id": "9463c613-35f7-4214-9a08-ced6cc245679",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-06-10T09:28:12.529197+00:00",
        "updated_at": "2024-06-10T09:28:12.542306+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=9463c613-35f7-4214-9a08-ced6cc245679&filter[owner_type]=tax_regions"
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
          "owner_id": "71fd3de7-f310-430f-9bd0-03b4268e4ec5",
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
    "id": "e6fdebe1-a416-44cf-b076-6302236ab658",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-10T09:28:13.871091+00:00",
      "updated_at": "2024-06-10T09:28:13.871091+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "71fd3de7-f310-430f-9bd0-03b4268e4ec5",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "71fd3de7-f310-430f-9bd0-03b4268e4ec5"
        }
      }
    }
  },
  "included": [
    {
      "id": "71fd3de7-f310-430f-9bd0-03b4268e4ec5",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-06-10T09:28:13.824250+00:00",
        "updated_at": "2024-06-10T09:28:13.880071+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/03b0308d-a295-4724-a84e-ceee11137ace' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "03b0308d-a295-4724-a84e-ceee11137ace",
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
    "id": "03b0308d-a295-4724-a84e-ceee11137ace",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-10T09:28:13.160837+00:00",
      "updated_at": "2024-06-10T09:28:13.213401+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "3c2e0543-c15c-4e91-8bd9-972d2b0a7137",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "3c2e0543-c15c-4e91-8bd9-972d2b0a7137"
        }
      }
    }
  },
  "included": [
    {
      "id": "3c2e0543-c15c-4e91-8bd9-972d2b0a7137",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-06-10T09:28:13.140401+00:00",
        "updated_at": "2024-06-10T09:28:13.217791+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/e7dab68c-98cb-4c22-ad03-9b24d1269a3f' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e7dab68c-98cb-4c22-ad03-9b24d1269a3f",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-10T09:28:11.926895+00:00",
      "updated_at": "2024-06-10T09:28:11.926895+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "65d4bd9a-aee8-4ea1-a4f1-c0035feec904",
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