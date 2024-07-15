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
      "id": "22f98ef5-4685-43c7-a2a4-9ade41860eea",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-07-15T09:25:41.176772+00:00",
        "updated_at": "2024-07-15T09:25:41.176772+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "e639321c-59f8-4a92-bc7e-b7a5d251dbbb",
        "owner_type": "tax_regions"
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/5fb67f70-5049-4ff8-8fa2-afd94cc80f65?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5fb67f70-5049-4ff8-8fa2-afd94cc80f65",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-15T09:25:43.517477+00:00",
      "updated_at": "2024-07-15T09:25:43.517477+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "5e79dcaa-13f6-4075-9b87-aff7b6f288d7",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "5e79dcaa-13f6-4075-9b87-aff7b6f288d7"
        }
      }
    }
  },
  "included": [
    {
      "id": "5e79dcaa-13f6-4075-9b87-aff7b6f288d7",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-07-15T09:25:43.504501+00:00",
        "updated_at": "2024-07-15T09:25:43.520469+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {}
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
          "owner_id": "9854640c-d095-442a-89ed-db920506a111",
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
    "id": "12e6711b-28af-4b1f-9197-d680ad2238d6",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-15T09:25:42.953418+00:00",
      "updated_at": "2024-07-15T09:25:42.953418+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "9854640c-d095-442a-89ed-db920506a111",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "9854640c-d095-442a-89ed-db920506a111"
        }
      }
    }
  },
  "included": [
    {
      "id": "9854640c-d095-442a-89ed-db920506a111",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-07-15T09:25:42.901792+00:00",
        "updated_at": "2024-07-15T09:25:42.957692+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/8db6f5ed-9c4e-40af-8924-82ccd49438b2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8db6f5ed-9c4e-40af-8924-82ccd49438b2",
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
    "id": "8db6f5ed-9c4e-40af-8924-82ccd49438b2",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-15T09:25:42.377518+00:00",
      "updated_at": "2024-07-15T09:25:42.439814+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "23e0bd5c-8b95-4bd4-b7ff-9b59ad1dd54a",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "23e0bd5c-8b95-4bd4-b7ff-9b59ad1dd54a"
        }
      }
    }
  },
  "included": [
    {
      "id": "23e0bd5c-8b95-4bd4-b7ff-9b59ad1dd54a",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-07-15T09:25:42.362434+00:00",
        "updated_at": "2024-07-15T09:25:42.443710+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/1f6598a7-0ee2-4556-955b-92f983912a53' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1f6598a7-0ee2-4556-955b-92f983912a53",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-15T09:25:41.771667+00:00",
      "updated_at": "2024-07-15T09:25:41.771667+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "d84b0401-bb41-48eb-96b4-f4c46859f11c",
      "owner_type": "tax_regions"
    },
    "relationships": {}
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