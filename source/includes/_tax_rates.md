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
      "id": "977f16c6-ab2e-4028-bd77-b06a91663971",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-07-22T09:31:57.212746+00:00",
        "updated_at": "2024-07-22T09:31:57.212746+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "aef6b6fd-c9c5-46a3-b69a-4d325552eb6f",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/ab1e6edf-4c22-48e1-a14f-77242eae2271?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ab1e6edf-4c22-48e1-a14f-77242eae2271",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-22T09:31:56.163729+00:00",
      "updated_at": "2024-07-22T09:31:56.163729+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "7a8f7dab-309e-4b61-8a05-a32a939f0edf",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "7a8f7dab-309e-4b61-8a05-a32a939f0edf"
        }
      }
    }
  },
  "included": [
    {
      "id": "7a8f7dab-309e-4b61-8a05-a32a939f0edf",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-07-22T09:31:56.140209+00:00",
        "updated_at": "2024-07-22T09:31:56.169915+00:00",
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
          "owner_id": "abb043e5-f16f-4341-b2de-b4a663cee9a1",
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
    "id": "465d0bd8-3a30-417a-99f5-e5dd25108eaf",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-22T09:31:54.713984+00:00",
      "updated_at": "2024-07-22T09:31:54.713984+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "abb043e5-f16f-4341-b2de-b4a663cee9a1",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "abb043e5-f16f-4341-b2de-b4a663cee9a1"
        }
      }
    }
  },
  "included": [
    {
      "id": "abb043e5-f16f-4341-b2de-b4a663cee9a1",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-07-22T09:31:54.660508+00:00",
        "updated_at": "2024-07-22T09:31:54.720237+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/9c7b2547-e08a-4abc-ac80-afc4b7682e61' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9c7b2547-e08a-4abc-ac80-afc4b7682e61",
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
    "id": "9c7b2547-e08a-4abc-ac80-afc4b7682e61",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-22T09:31:53.705375+00:00",
      "updated_at": "2024-07-22T09:31:53.753984+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "11674a74-e676-4bd7-9934-64e3dcfbf157",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "11674a74-e676-4bd7-9934-64e3dcfbf157"
        }
      }
    }
  },
  "included": [
    {
      "id": "11674a74-e676-4bd7-9934-64e3dcfbf157",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-07-22T09:31:53.680026+00:00",
        "updated_at": "2024-07-22T09:31:53.757808+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/a6c2b1fa-ae7f-4e2b-b557-6fa8e015f491' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a6c2b1fa-ae7f-4e2b-b557-6fa8e015f491",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-22T09:31:55.494868+00:00",
      "updated_at": "2024-07-22T09:31:55.494868+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "53fd94b7-ee0e-4eca-b2da-b6659aa4222d",
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