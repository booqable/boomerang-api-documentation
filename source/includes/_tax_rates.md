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
      "id": "0d03960f-8991-454e-8128-e17d4481d951",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-08-26T09:27:00.194522+00:00",
        "updated_at": "2024-08-26T09:27:00.194522+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "f5ba4ca3-91ac-4d55-bb85-a41dd9194c8c",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/fc68ec5d-ed20-4737-98cf-ce2b42df9e09?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fc68ec5d-ed20-4737-98cf-ce2b42df9e09",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-26T09:26:59.601129+00:00",
      "updated_at": "2024-08-26T09:26:59.601129+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "8241cf9d-bd9b-46dc-aaef-9b8e782a4f81",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "8241cf9d-bd9b-46dc-aaef-9b8e782a4f81"
        }
      }
    }
  },
  "included": [
    {
      "id": "8241cf9d-bd9b-46dc-aaef-9b8e782a4f81",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-08-26T09:26:59.587211+00:00",
        "updated_at": "2024-08-26T09:26:59.603749+00:00",
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
          "owner_id": "77c8e955-40c7-43c3-a42d-eb23a2354782",
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
    "id": "a0e19146-bedb-4b18-9e65-3cb9bbbadae5",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-26T09:27:01.304603+00:00",
      "updated_at": "2024-08-26T09:27:01.304603+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "77c8e955-40c7-43c3-a42d-eb23a2354782",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "77c8e955-40c7-43c3-a42d-eb23a2354782"
        }
      }
    }
  },
  "included": [
    {
      "id": "77c8e955-40c7-43c3-a42d-eb23a2354782",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-08-26T09:27:01.280282+00:00",
        "updated_at": "2024-08-26T09:27:01.306407+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/7a60d0e5-c709-475f-bfed-1eecbc62d7a4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7a60d0e5-c709-475f-bfed-1eecbc62d7a4",
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
    "id": "7a60d0e5-c709-475f-bfed-1eecbc62d7a4",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-26T09:27:01.907490+00:00",
      "updated_at": "2024-08-26T09:27:01.950288+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "09dc4ca8-2664-4caa-be60-3ff35756b292",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "09dc4ca8-2664-4caa-be60-3ff35756b292"
        }
      }
    }
  },
  "included": [
    {
      "id": "09dc4ca8-2664-4caa-be60-3ff35756b292",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-08-26T09:27:01.887394+00:00",
        "updated_at": "2024-08-26T09:27:01.952817+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/06dfaae2-7e0c-4e63-b0be-493dd6bba11e' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "06dfaae2-7e0c-4e63-b0be-493dd6bba11e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-26T09:27:00.713389+00:00",
      "updated_at": "2024-08-26T09:27:00.713389+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "754cb250-c21e-4768-b835-0f82a66f1bbd",
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