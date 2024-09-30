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
      "id": "00769c55-daf9-429f-b399-c5a882738f52",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-09-30T09:22:36.536651+00:00",
        "updated_at": "2024-09-30T09:22:36.536651+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "92133074-6cdb-4958-9925-e47dc162ba81",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/92e47cd0-2c6d-474d-b006-73d784cd4a9d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "92e47cd0-2c6d-474d-b006-73d784cd4a9d",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-30T09:22:35.705846+00:00",
      "updated_at": "2024-09-30T09:22:35.705846+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "ec3911d2-9ecd-4286-bc46-a45f26964d50",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "ec3911d2-9ecd-4286-bc46-a45f26964d50"
        }
      }
    }
  },
  "included": [
    {
      "id": "ec3911d2-9ecd-4286-bc46-a45f26964d50",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-09-30T09:22:35.696151+00:00",
        "updated_at": "2024-09-30T09:22:35.707711+00:00",
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
          "owner_id": "b17aada9-d325-49d3-ad7d-d235283a44d9",
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
    "id": "7531c47a-2788-47c1-b481-7e27204dc990",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-30T09:22:35.048925+00:00",
      "updated_at": "2024-09-30T09:22:35.048925+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "b17aada9-d325-49d3-ad7d-d235283a44d9",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "b17aada9-d325-49d3-ad7d-d235283a44d9"
        }
      }
    }
  },
  "included": [
    {
      "id": "b17aada9-d325-49d3-ad7d-d235283a44d9",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-09-30T09:22:35.024595+00:00",
        "updated_at": "2024-09-30T09:22:35.051144+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/7eb3f4d7-4708-4d7b-b08e-ab838378da17' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7eb3f4d7-4708-4d7b-b08e-ab838378da17",
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
    "id": "7eb3f4d7-4708-4d7b-b08e-ab838378da17",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-30T09:22:34.266795+00:00",
      "updated_at": "2024-09-30T09:22:34.294193+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "b4119de1-dcc1-4c24-a7c5-4214c8a1e34f",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "b4119de1-dcc1-4c24-a7c5-4214c8a1e34f"
        }
      }
    }
  },
  "included": [
    {
      "id": "b4119de1-dcc1-4c24-a7c5-4214c8a1e34f",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-09-30T09:22:34.252680+00:00",
        "updated_at": "2024-09-30T09:22:34.296504+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c5e8e436-cc2e-4518-aa3f-637682c84ca4' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c5e8e436-cc2e-4518-aa3f-637682c84ca4",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-30T09:22:33.795481+00:00",
      "updated_at": "2024-09-30T09:22:33.795481+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "89e1e089-374b-4676-97e5-24f0c7d06d83",
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