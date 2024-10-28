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
      "id": "5764a7f8-a14c-496e-9172-d5586a0395a5",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-10-28T09:24:25.346852+00:00",
        "updated_at": "2024-10-28T09:24:25.346852+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "4edfce82-373f-44bf-8076-80715cef9e0f",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/d4ba50cd-4d0e-4e5b-b45c-1c8fa73e89ed?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d4ba50cd-4d0e-4e5b-b45c-1c8fa73e89ed",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-28T09:24:27.873427+00:00",
      "updated_at": "2024-10-28T09:24:27.873427+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "96c90d30-aafd-4f24-9232-f24d70cf92f5",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "96c90d30-aafd-4f24-9232-f24d70cf92f5"
        }
      }
    }
  },
  "included": [
    {
      "id": "96c90d30-aafd-4f24-9232-f24d70cf92f5",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-10-28T09:24:27.862304+00:00",
        "updated_at": "2024-10-28T09:24:27.875527+00:00",
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
          "owner_id": "50cbd0e0-9168-4554-a614-9ef6d0785716",
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
    "id": "1ca95583-b139-41d4-9d36-0106aca2cb4e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-28T09:24:24.567171+00:00",
      "updated_at": "2024-10-28T09:24:24.567171+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "50cbd0e0-9168-4554-a614-9ef6d0785716",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "50cbd0e0-9168-4554-a614-9ef6d0785716"
        }
      }
    }
  },
  "included": [
    {
      "id": "50cbd0e0-9168-4554-a614-9ef6d0785716",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-10-28T09:24:24.542795+00:00",
        "updated_at": "2024-10-28T09:24:24.568974+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/abce90ad-8eca-46f9-b898-abee6b9cc1fb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "abce90ad-8eca-46f9-b898-abee6b9cc1fb",
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
    "id": "abce90ad-8eca-46f9-b898-abee6b9cc1fb",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-28T09:24:26.922422+00:00",
      "updated_at": "2024-10-28T09:24:26.959301+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "554f2960-414c-4d95-abaa-9dd828570e83",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "554f2960-414c-4d95-abaa-9dd828570e83"
        }
      }
    }
  },
  "included": [
    {
      "id": "554f2960-414c-4d95-abaa-9dd828570e83",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-10-28T09:24:26.903268+00:00",
        "updated_at": "2024-10-28T09:24:26.961182+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/23354bcd-d246-4253-a8c9-ef8546dab2ea' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "23354bcd-d246-4253-a8c9-ef8546dab2ea",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-28T09:24:27.363500+00:00",
      "updated_at": "2024-10-28T09:24:27.363500+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "79c5af7f-44b3-41fc-ab16-0fb2c1cf2ea9",
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