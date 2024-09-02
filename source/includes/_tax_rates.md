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
      "id": "9f18797f-c3ec-478f-b8c4-38237f26b200",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-09-02T09:22:40.408595+00:00",
        "updated_at": "2024-09-02T09:22:40.408595+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "ec222d9b-a6b4-4127-8d6d-3ba9500b4023",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/16c385dd-3e1b-4179-bd3e-3c4691753b88?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "16c385dd-3e1b-4179-bd3e-3c4691753b88",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-02T09:22:37.632161+00:00",
      "updated_at": "2024-09-02T09:22:37.632161+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "558de990-46af-4bb8-87be-4bc502183690",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "558de990-46af-4bb8-87be-4bc502183690"
        }
      }
    }
  },
  "included": [
    {
      "id": "558de990-46af-4bb8-87be-4bc502183690",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-09-02T09:22:37.615867+00:00",
        "updated_at": "2024-09-02T09:22:37.634759+00:00",
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
          "owner_id": "ce38180c-efb6-4b14-b181-15f0a4b6a3d1",
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
    "id": "c45230c3-4cf4-42db-9e6a-6975a04d18d6",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-02T09:22:38.364910+00:00",
      "updated_at": "2024-09-02T09:22:38.364910+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "ce38180c-efb6-4b14-b181-15f0a4b6a3d1",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "ce38180c-efb6-4b14-b181-15f0a4b6a3d1"
        }
      }
    }
  },
  "included": [
    {
      "id": "ce38180c-efb6-4b14-b181-15f0a4b6a3d1",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-09-02T09:22:38.316877+00:00",
        "updated_at": "2024-09-02T09:22:38.369521+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/0a88b560-90ae-4272-a78c-58b432fd776a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0a88b560-90ae-4272-a78c-58b432fd776a",
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
    "id": "0a88b560-90ae-4272-a78c-58b432fd776a",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-02T09:22:39.297746+00:00",
      "updated_at": "2024-09-02T09:22:39.368780+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "914fdcf2-3620-407f-a2b7-157c18cce70b",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "914fdcf2-3620-407f-a2b7-157c18cce70b"
        }
      }
    }
  },
  "included": [
    {
      "id": "914fdcf2-3620-407f-a2b7-157c18cce70b",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-09-02T09:22:39.270627+00:00",
        "updated_at": "2024-09-02T09:22:39.371864+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/70f8ee32-4169-4a9f-bf7b-87810a83b9a5' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "70f8ee32-4169-4a9f-bf7b-87810a83b9a5",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-02T09:22:39.936256+00:00",
      "updated_at": "2024-09-02T09:22:39.936256+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "0768f03e-d2e9-46db-8ce7-2dccadd811ac",
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