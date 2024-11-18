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
      "id": "0883b333-57c5-4bfe-88ec-5c3ec45b520a",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-11-18T09:24:06.523068+00:00",
        "updated_at": "2024-11-18T09:24:06.523068+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "40aecc65-50b4-464c-922a-f0325590b137",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/59fe4a07-97e6-493a-a1bd-e048819417ef?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "59fe4a07-97e6-493a-a1bd-e048819417ef",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-18T09:24:05.624698+00:00",
      "updated_at": "2024-11-18T09:24:05.624698+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "b982f9e1-5f21-474b-be9d-3d31bf59d26b",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "b982f9e1-5f21-474b-be9d-3d31bf59d26b"
        }
      }
    }
  },
  "included": [
    {
      "id": "b982f9e1-5f21-474b-be9d-3d31bf59d26b",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-11-18T09:24:05.615797+00:00",
        "updated_at": "2024-11-18T09:24:05.626470+00:00",
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
          "owner_id": "8db3da14-c12f-4e41-8956-bc75f56caa31",
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
    "id": "045d17c5-27c1-457c-8262-e2d5c1c1e5a5",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-18T09:24:06.993735+00:00",
      "updated_at": "2024-11-18T09:24:06.993735+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "8db3da14-c12f-4e41-8956-bc75f56caa31",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "8db3da14-c12f-4e41-8956-bc75f56caa31"
        }
      }
    }
  },
  "included": [
    {
      "id": "8db3da14-c12f-4e41-8956-bc75f56caa31",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-11-18T09:24:06.975064+00:00",
        "updated_at": "2024-11-18T09:24:06.995196+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/2ce5eee8-98b6-45bd-a646-bc3f43cdb322' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2ce5eee8-98b6-45bd-a646-bc3f43cdb322",
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
    "id": "2ce5eee8-98b6-45bd-a646-bc3f43cdb322",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-18T09:24:06.073950+00:00",
      "updated_at": "2024-11-18T09:24:06.095465+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "90a0bd99-8928-4f22-ab38-163a219ac9f0",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "90a0bd99-8928-4f22-ab38-163a219ac9f0"
        }
      }
    }
  },
  "included": [
    {
      "id": "90a0bd99-8928-4f22-ab38-163a219ac9f0",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-11-18T09:24:06.061674+00:00",
        "updated_at": "2024-11-18T09:24:06.097071+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c91c91ae-a492-48e3-b1a6-89a1804c400b' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c91c91ae-a492-48e3-b1a6-89a1804c400b",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-18T09:24:07.402149+00:00",
      "updated_at": "2024-11-18T09:24:07.402149+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "32eb80c0-f05b-4812-8d53-830838af718d",
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