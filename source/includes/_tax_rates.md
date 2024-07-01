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
      "id": "b6ec5242-3bf8-4c17-a794-2e9c7e15539f",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-07-01T09:27:50.999529+00:00",
        "updated_at": "2024-07-01T09:27:50.999529+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "f499aa2f-4735-43ee-ae5b-77044e15a317",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/a22f242a-9f7d-410d-997b-429f934db9a7?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a22f242a-9f7d-410d-997b-429f934db9a7",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-01T09:27:53.475235+00:00",
      "updated_at": "2024-07-01T09:27:53.475235+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "2c7f0ae3-a9cd-4659-8282-86ba2bd612d3",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "2c7f0ae3-a9cd-4659-8282-86ba2bd612d3"
        }
      }
    }
  },
  "included": [
    {
      "id": "2c7f0ae3-a9cd-4659-8282-86ba2bd612d3",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-07-01T09:27:53.449499+00:00",
        "updated_at": "2024-07-01T09:27:53.481259+00:00",
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
          "owner_id": "f46737dd-d8c7-4411-889b-93c4fd373215",
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
    "id": "11726f35-fcbb-48ae-8459-76857a0fdeba",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-01T09:27:51.829052+00:00",
      "updated_at": "2024-07-01T09:27:51.829052+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "f46737dd-d8c7-4411-889b-93c4fd373215",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "f46737dd-d8c7-4411-889b-93c4fd373215"
        }
      }
    }
  },
  "included": [
    {
      "id": "f46737dd-d8c7-4411-889b-93c4fd373215",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-07-01T09:27:51.788032+00:00",
        "updated_at": "2024-07-01T09:27:51.833578+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/406b7059-fc62-4ecd-a7e0-667ce092c0bf' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "406b7059-fc62-4ecd-a7e0-667ce092c0bf",
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
    "id": "406b7059-fc62-4ecd-a7e0-667ce092c0bf",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-01T09:27:52.581468+00:00",
      "updated_at": "2024-07-01T09:27:52.642766+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "3a7831db-df8d-49e1-8e45-b32a7d34a030",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "3a7831db-df8d-49e1-8e45-b32a7d34a030"
        }
      }
    }
  },
  "included": [
    {
      "id": "3a7831db-df8d-49e1-8e45-b32a7d34a030",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-07-01T09:27:52.554951+00:00",
        "updated_at": "2024-07-01T09:27:52.647899+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/413c0671-49a2-4e73-ba28-b2b7f9bc8fa1' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "413c0671-49a2-4e73-ba28-b2b7f9bc8fa1",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-01T09:27:54.227461+00:00",
      "updated_at": "2024-07-01T09:27:54.227461+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "cd459aa8-704f-4716-9ad0-1c280ee21edb",
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