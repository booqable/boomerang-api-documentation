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
`owner` | **Tax category, Tax region** <br>Associated Owner


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
      "id": "0782311b-cc9a-4b66-9582-f158e5e9fb63",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-09-23T09:24:15.275956+00:00",
        "updated_at": "2024-09-23T09:24:15.275956+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "d857b6de-498a-4a0d-b8bf-fcb5b798b47f",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/02fc313e-5b6c-47e8-a660-40e59a2d9a2a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "02fc313e-5b6c-47e8-a660-40e59a2d9a2a",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-23T09:24:13.908653+00:00",
      "updated_at": "2024-09-23T09:24:13.908653+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "ee4f10ef-b267-409e-803d-1af2bce30860",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "ee4f10ef-b267-409e-803d-1af2bce30860"
        }
      }
    }
  },
  "included": [
    {
      "id": "ee4f10ef-b267-409e-803d-1af2bce30860",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-09-23T09:24:13.901357+00:00",
        "updated_at": "2024-09-23T09:24:13.910204+00:00",
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
          "owner_id": "cb0ff1e6-c94c-4141-b2c5-ed631d10ddb7",
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
    "id": "106aa4fc-2562-41f8-8fb0-cc28fe153b21",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-23T09:24:14.385381+00:00",
      "updated_at": "2024-09-23T09:24:14.385381+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "cb0ff1e6-c94c-4141-b2c5-ed631d10ddb7",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "cb0ff1e6-c94c-4141-b2c5-ed631d10ddb7"
        }
      }
    }
  },
  "included": [
    {
      "id": "cb0ff1e6-c94c-4141-b2c5-ed631d10ddb7",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-09-23T09:24:14.367150+00:00",
        "updated_at": "2024-09-23T09:24:14.386998+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/9db7e8a1-bcb3-47c7-aca9-4a4d3e51445e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9db7e8a1-bcb3-47c7-aca9-4a4d3e51445e",
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
    "id": "9db7e8a1-bcb3-47c7-aca9-4a4d3e51445e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-23T09:24:14.817095+00:00",
      "updated_at": "2024-09-23T09:24:14.836788+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "8ebe9715-eaf6-4142-81f3-b0aa56067d93",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "8ebe9715-eaf6-4142-81f3-b0aa56067d93"
        }
      }
    }
  },
  "included": [
    {
      "id": "8ebe9715-eaf6-4142-81f3-b0aa56067d93",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-09-23T09:24:14.806762+00:00",
        "updated_at": "2024-09-23T09:24:14.838205+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/db4b726c-d4bf-4b67-a6c9-a2ac7e92650f' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "db4b726c-d4bf-4b67-a6c9-a2ac7e92650f",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-23T09:24:13.465259+00:00",
      "updated_at": "2024-09-23T09:24:13.465259+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "e93c11f3-0749-4256-9dca-279676d84573",
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