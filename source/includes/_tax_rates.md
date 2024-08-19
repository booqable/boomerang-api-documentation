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
      "id": "202a3370-10fa-4117-93bb-4dfc6fb83232",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-08-19T09:24:50.076439+00:00",
        "updated_at": "2024-08-19T09:24:50.076439+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "dc33db8e-8819-469b-b523-3dbb42e1be6d",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/476c1430-0cbd-49cf-97cf-0af99964cc65?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "476c1430-0cbd-49cf-97cf-0af99964cc65",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-19T09:24:48.734207+00:00",
      "updated_at": "2024-08-19T09:24:48.734207+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "6f9a7878-4aa0-48d6-80eb-1800e68aacd9",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "6f9a7878-4aa0-48d6-80eb-1800e68aacd9"
        }
      }
    }
  },
  "included": [
    {
      "id": "6f9a7878-4aa0-48d6-80eb-1800e68aacd9",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-08-19T09:24:48.725878+00:00",
        "updated_at": "2024-08-19T09:24:48.735963+00:00",
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
          "owner_id": "467fbb3c-b05e-4276-9df2-513726e01469",
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
    "id": "f51a47a2-459b-420d-9507-d279afbe7b55",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-19T09:24:49.299386+00:00",
      "updated_at": "2024-08-19T09:24:49.299386+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "467fbb3c-b05e-4276-9df2-513726e01469",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "467fbb3c-b05e-4276-9df2-513726e01469"
        }
      }
    }
  },
  "included": [
    {
      "id": "467fbb3c-b05e-4276-9df2-513726e01469",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-08-19T09:24:49.276086+00:00",
        "updated_at": "2024-08-19T09:24:49.301332+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/f6f65510-796e-4bf6-8539-a7dbb85a04ee' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f6f65510-796e-4bf6-8539-a7dbb85a04ee",
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
    "id": "f6f65510-796e-4bf6-8539-a7dbb85a04ee",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-19T09:24:48.241458+00:00",
      "updated_at": "2024-08-19T09:24:48.276569+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "68058ee8-c2f2-4d28-ba8c-c81937c08851",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "68058ee8-c2f2-4d28-ba8c-c81937c08851"
        }
      }
    }
  },
  "included": [
    {
      "id": "68058ee8-c2f2-4d28-ba8c-c81937c08851",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-08-19T09:24:48.225905+00:00",
        "updated_at": "2024-08-19T09:24:48.278982+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/70605c65-d0a0-4786-9e23-6a4c7d5041b3' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "70605c65-d0a0-4786-9e23-6a4c7d5041b3",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-19T09:24:47.685673+00:00",
      "updated_at": "2024-08-19T09:24:47.685673+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "24c89962-33ac-45ae-b501-e48f79bdf529",
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