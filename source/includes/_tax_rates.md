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
      "id": "feb815d4-222f-4917-9446-ee8eb451e3d0",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-09-16T09:27:12.986878+00:00",
        "updated_at": "2024-09-16T09:27:12.986878+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "fda054fd-7d06-4f71-8477-d98df8ee0b70",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/cdcc35b3-8a38-4b09-baa9-741e3ded4f52?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cdcc35b3-8a38-4b09-baa9-741e3ded4f52",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-16T09:27:13.778091+00:00",
      "updated_at": "2024-09-16T09:27:13.778091+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "3a8c75de-0253-4228-81e9-5cba34c88888",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "3a8c75de-0253-4228-81e9-5cba34c88888"
        }
      }
    }
  },
  "included": [
    {
      "id": "3a8c75de-0253-4228-81e9-5cba34c88888",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-09-16T09:27:13.770340+00:00",
        "updated_at": "2024-09-16T09:27:13.779521+00:00",
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
          "owner_id": "4d4a81c7-8b97-482e-be08-a6bd9969669c",
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
    "id": "1e932d17-3a3a-42f4-b778-ed2ab521f035",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-16T09:27:14.248777+00:00",
      "updated_at": "2024-09-16T09:27:14.248777+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "4d4a81c7-8b97-482e-be08-a6bd9969669c",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "4d4a81c7-8b97-482e-be08-a6bd9969669c"
        }
      }
    }
  },
  "included": [
    {
      "id": "4d4a81c7-8b97-482e-be08-a6bd9969669c",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-09-16T09:27:14.228054+00:00",
        "updated_at": "2024-09-16T09:27:14.250346+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/fa8254a0-c9df-4c4e-95da-a24d7c400dcd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fa8254a0-c9df-4c4e-95da-a24d7c400dcd",
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
    "id": "fa8254a0-c9df-4c4e-95da-a24d7c400dcd",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-16T09:27:12.404374+00:00",
      "updated_at": "2024-09-16T09:27:12.429389+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "6f6a8fd7-bd98-4387-b950-d279c084020c",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "6f6a8fd7-bd98-4387-b950-d279c084020c"
        }
      }
    }
  },
  "included": [
    {
      "id": "6f6a8fd7-bd98-4387-b950-d279c084020c",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-09-16T09:27:12.392388+00:00",
        "updated_at": "2024-09-16T09:27:12.430994+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/1834b568-4663-4163-bb01-da12020009d9' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1834b568-4663-4163-bb01-da12020009d9",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-16T09:27:14.637263+00:00",
      "updated_at": "2024-09-16T09:27:14.637263+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "7919d9f2-9665-4838-8797-10c498a6637f",
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