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
      "id": "9411d1d2-32db-471b-8fd7-f2c85a89fd0d",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-08-12T09:24:20.287464+00:00",
        "updated_at": "2024-08-12T09:24:20.287464+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "c1f2040b-73e3-474d-ac4c-d3a286248841",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c64d1419-799e-4c56-8526-58134f7e632b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c64d1419-799e-4c56-8526-58134f7e632b",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-12T09:24:21.587725+00:00",
      "updated_at": "2024-08-12T09:24:21.587725+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "b2523b7c-4ee0-4669-b76c-8081242bd763",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "b2523b7c-4ee0-4669-b76c-8081242bd763"
        }
      }
    }
  },
  "included": [
    {
      "id": "b2523b7c-4ee0-4669-b76c-8081242bd763",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-08-12T09:24:21.576425+00:00",
        "updated_at": "2024-08-12T09:24:21.589801+00:00",
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
          "owner_id": "42b1a68e-2cb9-4c97-b964-f31eb94586a9",
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
    "id": "cf09bcdf-68dd-40cf-8f6d-64f632fb87d0",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-12T09:24:22.850492+00:00",
      "updated_at": "2024-08-12T09:24:22.850492+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "42b1a68e-2cb9-4c97-b964-f31eb94586a9",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "42b1a68e-2cb9-4c97-b964-f31eb94586a9"
        }
      }
    }
  },
  "included": [
    {
      "id": "42b1a68e-2cb9-4c97-b964-f31eb94586a9",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-08-12T09:24:22.814638+00:00",
        "updated_at": "2024-08-12T09:24:22.852106+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/3224c0dc-857f-47b5-9b90-8e550e7a6b96' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3224c0dc-857f-47b5-9b90-8e550e7a6b96",
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
    "id": "3224c0dc-857f-47b5-9b90-8e550e7a6b96",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-12T09:24:22.182358+00:00",
      "updated_at": "2024-08-12T09:24:22.218968+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "0e69b681-52a0-4bda-b52f-798e74ce16d9",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "0e69b681-52a0-4bda-b52f-798e74ce16d9"
        }
      }
    }
  },
  "included": [
    {
      "id": "0e69b681-52a0-4bda-b52f-798e74ce16d9",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-08-12T09:24:22.165981+00:00",
        "updated_at": "2024-08-12T09:24:22.221987+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/029a6a47-8ffc-4053-8514-544eeb62dfe3' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "029a6a47-8ffc-4053-8514-544eeb62dfe3",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-12T09:24:20.972909+00:00",
      "updated_at": "2024-08-12T09:24:20.972909+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "831815f0-746e-40cf-9604-942543450122",
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