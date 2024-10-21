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
      "id": "3df60dd5-a4c2-4c03-bca0-de7874414eb4",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-10-21T09:24:43.681789+00:00",
        "updated_at": "2024-10-21T09:24:43.681789+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "e4577ac5-b5ef-41b9-96d4-87786a571e54",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/bb03a90a-fd70-42fc-b8e6-852302d0d129?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bb03a90a-fd70-42fc-b8e6-852302d0d129",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-21T09:24:41.970521+00:00",
      "updated_at": "2024-10-21T09:24:41.970521+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "de72486b-58e1-4bf0-a07d-473ae10c3433",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "de72486b-58e1-4bf0-a07d-473ae10c3433"
        }
      }
    }
  },
  "included": [
    {
      "id": "de72486b-58e1-4bf0-a07d-473ae10c3433",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-10-21T09:24:41.963044+00:00",
        "updated_at": "2024-10-21T09:24:41.972022+00:00",
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
          "owner_id": "2dbdb532-04ac-4dd0-ac15-2fba87fa48e0",
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
    "id": "628fd5e1-1de2-48bf-bc48-a6f989f7413d",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-21T09:24:42.579719+00:00",
      "updated_at": "2024-10-21T09:24:42.579719+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "2dbdb532-04ac-4dd0-ac15-2fba87fa48e0",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "2dbdb532-04ac-4dd0-ac15-2fba87fa48e0"
        }
      }
    }
  },
  "included": [
    {
      "id": "2dbdb532-04ac-4dd0-ac15-2fba87fa48e0",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-10-21T09:24:42.561426+00:00",
        "updated_at": "2024-10-21T09:24:42.581295+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c77af8a1-63e5-4b84-99ab-b1cdf3960b71' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c77af8a1-63e5-4b84-99ab-b1cdf3960b71",
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
    "id": "c77af8a1-63e5-4b84-99ab-b1cdf3960b71",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-21T09:24:41.084084+00:00",
      "updated_at": "2024-10-21T09:24:41.109733+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "2e90e44a-b4e3-4d87-93b3-abfc53531969",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "2e90e44a-b4e3-4d87-93b3-abfc53531969"
        }
      }
    }
  },
  "included": [
    {
      "id": "2e90e44a-b4e3-4d87-93b3-abfc53531969",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-10-21T09:24:41.073677+00:00",
        "updated_at": "2024-10-21T09:24:41.112913+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c2fa213f-b45c-4da7-9c57-74c25d0375cd' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c2fa213f-b45c-4da7-9c57-74c25d0375cd",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-21T09:24:43.179464+00:00",
      "updated_at": "2024-10-21T09:24:43.179464+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "e929156c-fcde-4561-9e98-d9a3517632c0",
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