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
      "id": "9f60f853-8ba2-486d-a152-016b2dbe842d",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-06-03T09:27:23.222263+00:00",
        "updated_at": "2024-06-03T09:27:23.222263+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "eb66bde1-5484-4b3d-b16b-7493b90b1613",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/eb66bde1-5484-4b3d-b16b-7493b90b1613"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/1dbd0380-b2c6-4f0a-acf5-d40896b77f0b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1dbd0380-b2c6-4f0a-acf5-d40896b77f0b",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-03T09:27:23.898291+00:00",
      "updated_at": "2024-06-03T09:27:23.898291+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "99c0c6e8-73b9-4103-8d2a-c9ca9584c765",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/99c0c6e8-73b9-4103-8d2a-c9ca9584c765"
        },
        "data": {
          "type": "tax_regions",
          "id": "99c0c6e8-73b9-4103-8d2a-c9ca9584c765"
        }
      }
    }
  },
  "included": [
    {
      "id": "99c0c6e8-73b9-4103-8d2a-c9ca9584c765",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-06-03T09:27:23.883642+00:00",
        "updated_at": "2024-06-03T09:27:23.902349+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=99c0c6e8-73b9-4103-8d2a-c9ca9584c765&filter[owner_type]=tax_regions"
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
          "owner_id": "9354fda5-5730-4457-9498-9c00c61cb42b",
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
    "id": "ecaabba5-0c91-496c-8431-8e2e77030324",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-03T09:27:24.586410+00:00",
      "updated_at": "2024-06-03T09:27:24.586410+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "9354fda5-5730-4457-9498-9c00c61cb42b",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "9354fda5-5730-4457-9498-9c00c61cb42b"
        }
      }
    }
  },
  "included": [
    {
      "id": "9354fda5-5730-4457-9498-9c00c61cb42b",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-06-03T09:27:24.539736+00:00",
        "updated_at": "2024-06-03T09:27:24.589590+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/80a5ac32-8fd7-4861-942a-0249338ed487' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "80a5ac32-8fd7-4861-942a-0249338ed487",
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
    "id": "80a5ac32-8fd7-4861-942a-0249338ed487",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-03T09:27:25.207717+00:00",
      "updated_at": "2024-06-03T09:27:25.256155+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "906d15a5-3a61-446d-9f99-0f00a27eeec8",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "906d15a5-3a61-446d-9f99-0f00a27eeec8"
        }
      }
    }
  },
  "included": [
    {
      "id": "906d15a5-3a61-446d-9f99-0f00a27eeec8",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-06-03T09:27:25.188630+00:00",
        "updated_at": "2024-06-03T09:27:25.259935+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c0b3d372-c4c3-4a60-a2a3-1f2d1bec26bb' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c0b3d372-c4c3-4a60-a2a3-1f2d1bec26bb",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-03T09:27:25.908366+00:00",
      "updated_at": "2024-06-03T09:27:25.908366+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "956d5480-c0fd-411c-a93a-f68a71414c8f",
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