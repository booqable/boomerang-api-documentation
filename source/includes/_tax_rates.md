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
      "id": "03900649-29a0-4a4f-a364-0c884c710c6d",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-06-17T09:29:10.900717+00:00",
        "updated_at": "2024-06-17T09:29:10.900717+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "47df9232-c710-4f70-9e7b-7ba1a8dcd434",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/47df9232-c710-4f70-9e7b-7ba1a8dcd434"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c41c429c-01ce-46a3-ac5d-9bfe3471743e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c41c429c-01ce-46a3-ac5d-9bfe3471743e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-17T09:29:11.440540+00:00",
      "updated_at": "2024-06-17T09:29:11.440540+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "d16ed3c3-7680-4c66-98ec-10323df4bdea",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/d16ed3c3-7680-4c66-98ec-10323df4bdea"
        },
        "data": {
          "type": "tax_regions",
          "id": "d16ed3c3-7680-4c66-98ec-10323df4bdea"
        }
      }
    }
  },
  "included": [
    {
      "id": "d16ed3c3-7680-4c66-98ec-10323df4bdea",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-06-17T09:29:11.431710+00:00",
        "updated_at": "2024-06-17T09:29:11.442847+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=d16ed3c3-7680-4c66-98ec-10323df4bdea&filter[owner_type]=tax_regions"
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
          "owner_id": "f9cdcaf4-980e-4dde-962a-73100f98b619",
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
    "id": "a4035e34-9ebb-4097-a61e-3c90d67df30d",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-17T09:29:12.506252+00:00",
      "updated_at": "2024-06-17T09:29:12.506252+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "f9cdcaf4-980e-4dde-962a-73100f98b619",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "f9cdcaf4-980e-4dde-962a-73100f98b619"
        }
      }
    }
  },
  "included": [
    {
      "id": "f9cdcaf4-980e-4dde-962a-73100f98b619",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-06-17T09:29:12.481299+00:00",
        "updated_at": "2024-06-17T09:29:12.508642+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/d407f0cb-2237-4d25-a222-82f66db7d39f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d407f0cb-2237-4d25-a222-82f66db7d39f",
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
    "id": "d407f0cb-2237-4d25-a222-82f66db7d39f",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-17T09:29:10.347317+00:00",
      "updated_at": "2024-06-17T09:29:10.380369+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "419f693d-9fde-4381-a7a7-4250d43e47c6",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "419f693d-9fde-4381-a7a7-4250d43e47c6"
        }
      }
    }
  },
  "included": [
    {
      "id": "419f693d-9fde-4381-a7a7-4250d43e47c6",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-06-17T09:29:10.334204+00:00",
        "updated_at": "2024-06-17T09:29:10.382960+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/ac590c81-5519-48cc-9814-ec3f4ead40b9' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ac590c81-5519-48cc-9814-ec3f4ead40b9",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-17T09:29:11.943870+00:00",
      "updated_at": "2024-06-17T09:29:11.943870+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "cf9a2929-ab60-4690-aff0-c804c82b0f8c",
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