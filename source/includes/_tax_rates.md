# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`GET /api/boomerang/tax_rates/{id}`

`DELETE /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

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


## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/058a176d-57c2-4d65-9bf6-2f7632fa6f85?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "058a176d-57c2-4d65-9bf6-2f7632fa6f85",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-01-08T09:18:03+00:00",
      "updated_at": "2024-01-08T09:18:03+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "18d463fd-0af2-4e7b-8782-0c03d178b11a",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/18d463fd-0af2-4e7b-8782-0c03d178b11a"
        },
        "data": {
          "type": "tax_regions",
          "id": "18d463fd-0af2-4e7b-8782-0c03d178b11a"
        }
      }
    }
  },
  "included": [
    {
      "id": "18d463fd-0af2-4e7b-8782-0c03d178b11a",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-01-08T09:18:03+00:00",
        "updated_at": "2024-01-08T09:18:03+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=18d463fd-0af2-4e7b-8782-0c03d178b11a&filter[owner_type]=tax_regions"
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






## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/398abf48-969f-46f3-95f8-4a00a05991d5' \
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
          "owner_id": "4319e4c1-fca5-4e1b-9790-90605c8ec87b",
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
    "id": "0b794628-72d0-4d6c-b185-80637484e660",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-01-08T09:18:05+00:00",
      "updated_at": "2024-01-08T09:18:05+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "4319e4c1-fca5-4e1b-9790-90605c8ec87b",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "4319e4c1-fca5-4e1b-9790-90605c8ec87b"
        }
      }
    }
  },
  "included": [
    {
      "id": "4319e4c1-fca5-4e1b-9790-90605c8ec87b",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-01-08T09:18:05+00:00",
        "updated_at": "2024-01-08T09:18:05+00:00",
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
      "id": "84bf9a5d-a017-484b-aba6-9c5aba71abe7",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-01-08T09:18:05+00:00",
        "updated_at": "2024-01-08T09:18:05+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "895a41ad-6f96-4d0d-837f-5427cf8cf9c3",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/895a41ad-6f96-4d0d-837f-5427cf8cf9c3"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/32d7372a-d4f0-4ff9-a878-3874a6842402' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "32d7372a-d4f0-4ff9-a878-3874a6842402",
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
    "id": "32d7372a-d4f0-4ff9-a878-3874a6842402",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-01-08T09:18:06+00:00",
      "updated_at": "2024-01-08T09:18:06+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "5a44c89d-4ec5-42f7-aca2-491315845047",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "5a44c89d-4ec5-42f7-aca2-491315845047"
        }
      }
    }
  },
  "included": [
    {
      "id": "5a44c89d-4ec5-42f7-aca2-491315845047",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-01-08T09:18:06+00:00",
        "updated_at": "2024-01-08T09:18:06+00:00",
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





