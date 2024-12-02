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
`owner` | **[Tax category](#tax-categories), [Tax region](#tax-regions)** <br>Associated Owner


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
      "id": "08ef8cb4-b076-4788-ab31-54d8a6c2e51f",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-12-02T13:05:02.752639+00:00",
        "updated_at": "2024-12-02T13:05:02.752639+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "e0401e60-07ce-4eca-9d37-5e9529955b7c",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/8531c87a-8783-4d2d-b7da-49ccd616852e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8531c87a-8783-4d2d-b7da-49ccd616852e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-12-02T13:05:02.132373+00:00",
      "updated_at": "2024-12-02T13:05:02.132373+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "36809c76-a54c-4894-801b-26e8e18e632c",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "36809c76-a54c-4894-801b-26e8e18e632c"
        }
      }
    }
  },
  "included": [
    {
      "id": "36809c76-a54c-4894-801b-26e8e18e632c",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-12-02T13:05:02.125372+00:00",
        "updated_at": "2024-12-02T13:05:02.133783+00:00",
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
          "owner_id": "20aba03e-6b04-4826-a059-1919f37e8aea",
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
    "id": "c1b553b0-3530-4365-938e-7b09b59a68f7",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-12-02T13:05:01.001472+00:00",
      "updated_at": "2024-12-02T13:05:01.001472+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "20aba03e-6b04-4826-a059-1919f37e8aea",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "20aba03e-6b04-4826-a059-1919f37e8aea"
        }
      }
    }
  },
  "included": [
    {
      "id": "20aba03e-6b04-4826-a059-1919f37e8aea",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-12-02T13:05:00.981669+00:00",
        "updated_at": "2024-12-02T13:05:01.003096+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/d3833207-5ce2-4262-bf54-bb79d56e3611' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d3833207-5ce2-4262-bf54-bb79d56e3611",
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
    "id": "d3833207-5ce2-4262-bf54-bb79d56e3611",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-12-02T13:05:00.179567+00:00",
      "updated_at": "2024-12-02T13:05:00.201803+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "a2e589ba-fb59-47b4-83d3-d4731e8183c0",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "a2e589ba-fb59-47b4-83d3-d4731e8183c0"
        }
      }
    }
  },
  "included": [
    {
      "id": "a2e589ba-fb59-47b4-83d3-d4731e8183c0",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-12-02T13:05:00.168513+00:00",
        "updated_at": "2024-12-02T13:05:00.203376+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/b7009b50-7861-4285-b02e-30421d1c065a' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b7009b50-7861-4285-b02e-30421d1c065a",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-12-02T13:05:01.497036+00:00",
      "updated_at": "2024-12-02T13:05:01.497036+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "cb10273b-b58b-4463-b2a7-aa5269e2057b",
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