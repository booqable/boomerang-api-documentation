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
      "id": "271714d7-6d7d-4015-afe0-47e293e81b31",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-07-29T09:26:14.654988+00:00",
        "updated_at": "2024-07-29T09:26:14.654988+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "73cad55c-86c8-42f2-bde5-0aa68336dc32",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/fd3272a5-19c3-4a14-a834-bc2a2309a71e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fd3272a5-19c3-4a14-a834-bc2a2309a71e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-29T09:26:15.202527+00:00",
      "updated_at": "2024-07-29T09:26:15.202527+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "0810d134-41e7-441e-8b2f-0e265b9d33bc",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "0810d134-41e7-441e-8b2f-0e265b9d33bc"
        }
      }
    }
  },
  "included": [
    {
      "id": "0810d134-41e7-441e-8b2f-0e265b9d33bc",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-07-29T09:26:15.191166+00:00",
        "updated_at": "2024-07-29T09:26:15.204979+00:00",
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
          "owner_id": "6d96c2fa-12c6-4467-ac09-c951934e401c",
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
    "id": "524c598e-2071-47da-905a-6cfcc35b9c19",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-29T09:26:12.782138+00:00",
      "updated_at": "2024-07-29T09:26:12.782138+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "6d96c2fa-12c6-4467-ac09-c951934e401c",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "6d96c2fa-12c6-4467-ac09-c951934e401c"
        }
      }
    }
  },
  "included": [
    {
      "id": "6d96c2fa-12c6-4467-ac09-c951934e401c",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-07-29T09:26:12.758861+00:00",
        "updated_at": "2024-07-29T09:26:12.783832+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/5a835754-a262-45dc-a17c-aec16b7dfbe6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5a835754-a262-45dc-a17c-aec16b7dfbe6",
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
    "id": "5a835754-a262-45dc-a17c-aec16b7dfbe6",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-29T09:26:14.158386+00:00",
      "updated_at": "2024-07-29T09:26:14.181671+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "67627d5b-52b8-495e-a25d-41e4a476d0d3",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "67627d5b-52b8-495e-a25d-41e4a476d0d3"
        }
      }
    }
  },
  "included": [
    {
      "id": "67627d5b-52b8-495e-a25d-41e4a476d0d3",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-07-29T09:26:14.148043+00:00",
        "updated_at": "2024-07-29T09:26:14.183177+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/e0ee13d4-1cb7-4c6d-9acf-701c16a0b442' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e0ee13d4-1cb7-4c6d-9acf-701c16a0b442",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-29T09:26:13.681723+00:00",
      "updated_at": "2024-07-29T09:26:13.681723+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "178e4925-97cf-459a-a61e-18027cb36961",
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