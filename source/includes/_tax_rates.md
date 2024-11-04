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
      "id": "71056679-64cd-428a-a93e-0c2e10398979",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-11-04T09:26:05.922970+00:00",
        "updated_at": "2024-11-04T09:26:05.922970+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "4113269c-8999-4407-b2f5-aab75a89f4ed",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/46b45f29-d963-405f-aecb-24b4059dc39b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "46b45f29-d963-405f-aecb-24b4059dc39b",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-04T09:26:07.399111+00:00",
      "updated_at": "2024-11-04T09:26:07.399111+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "bc3e1961-1429-4c73-aacc-be04cb03b263",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "bc3e1961-1429-4c73-aacc-be04cb03b263"
        }
      }
    }
  },
  "included": [
    {
      "id": "bc3e1961-1429-4c73-aacc-be04cb03b263",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-11-04T09:26:07.390822+00:00",
        "updated_at": "2024-11-04T09:26:07.400753+00:00",
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
          "owner_id": "1782fd48-a7d5-415c-ae78-b05e5d7badbd",
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
    "id": "0a134d0f-103e-4c3b-b5c1-4a092153a49d",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-04T09:26:06.915122+00:00",
      "updated_at": "2024-11-04T09:26:06.915122+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "1782fd48-a7d5-415c-ae78-b05e5d7badbd",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "1782fd48-a7d5-415c-ae78-b05e5d7badbd"
        }
      }
    }
  },
  "included": [
    {
      "id": "1782fd48-a7d5-415c-ae78-b05e5d7badbd",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-11-04T09:26:06.882150+00:00",
        "updated_at": "2024-11-04T09:26:06.916823+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/95139851-0cc2-423a-abaa-1b8036030467' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "95139851-0cc2-423a-abaa-1b8036030467",
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
    "id": "95139851-0cc2-423a-abaa-1b8036030467",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-04T09:26:05.435475+00:00",
      "updated_at": "2024-11-04T09:26:05.458736+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "f820746b-c564-42d7-833b-3d593d34c929",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "f820746b-c564-42d7-833b-3d593d34c929"
        }
      }
    }
  },
  "included": [
    {
      "id": "f820746b-c564-42d7-833b-3d593d34c929",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-11-04T09:26:05.419607+00:00",
        "updated_at": "2024-11-04T09:26:05.460307+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/4b2e3b0a-8c69-42ce-8bf8-ff5a4453d851' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4b2e3b0a-8c69-42ce-8bf8-ff5a4453d851",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-04T09:26:06.390988+00:00",
      "updated_at": "2024-11-04T09:26:06.390988+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "934837a5-d7b9-4247-8f43-6f10a9db3a3c",
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