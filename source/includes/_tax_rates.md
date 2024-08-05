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
      "id": "53abf86f-b55f-470a-92b4-b987c330f86e",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-08-05T09:26:05.880183+00:00",
        "updated_at": "2024-08-05T09:26:05.880183+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "bad81498-80ee-4f95-a05e-f80dfc7ee1d8",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/71561b01-663e-47eb-8536-f4f6571470ea?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "71561b01-663e-47eb-8536-f4f6571470ea",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-05T09:26:06.522814+00:00",
      "updated_at": "2024-08-05T09:26:06.522814+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "2f2bbe9c-7951-4d33-bfe9-7452fdecf385",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "2f2bbe9c-7951-4d33-bfe9-7452fdecf385"
        }
      }
    }
  },
  "included": [
    {
      "id": "2f2bbe9c-7951-4d33-bfe9-7452fdecf385",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-08-05T09:26:06.507593+00:00",
        "updated_at": "2024-08-05T09:26:06.525954+00:00",
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
          "owner_id": "d1b46f3f-14ee-481d-99b9-7f8c274c22b3",
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
    "id": "f17a90d6-0525-4a21-bd0b-a8c3f13f6085",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-05T09:26:04.774224+00:00",
      "updated_at": "2024-08-05T09:26:04.774224+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "d1b46f3f-14ee-481d-99b9-7f8c274c22b3",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "d1b46f3f-14ee-481d-99b9-7f8c274c22b3"
        }
      }
    }
  },
  "included": [
    {
      "id": "d1b46f3f-14ee-481d-99b9-7f8c274c22b3",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-08-05T09:26:04.733593+00:00",
        "updated_at": "2024-08-05T09:26:04.777550+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/994b2f61-74c1-493a-8757-e26b1fd1248e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "994b2f61-74c1-493a-8757-e26b1fd1248e",
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
    "id": "994b2f61-74c1-493a-8757-e26b1fd1248e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-05T09:26:05.288752+00:00",
      "updated_at": "2024-08-05T09:26:05.326490+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "f18da00f-92b6-4125-9e40-fa16d880be77",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "f18da00f-92b6-4125-9e40-fa16d880be77"
        }
      }
    }
  },
  "included": [
    {
      "id": "f18da00f-92b6-4125-9e40-fa16d880be77",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-08-05T09:26:05.267840+00:00",
        "updated_at": "2024-08-05T09:26:05.328664+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/04c5a3b2-7589-4b2b-b16b-30b89c90040c' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "04c5a3b2-7589-4b2b-b16b-30b89c90040c",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-08-05T09:26:07.197499+00:00",
      "updated_at": "2024-08-05T09:26:07.197499+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "865fbe5a-39c1-42ee-b8c4-6e39f132a4ef",
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