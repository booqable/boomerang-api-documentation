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
      "id": "456d3a02-933f-4d48-bc23-e9d013512893",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-09-09T09:26:21.111783+00:00",
        "updated_at": "2024-09-09T09:26:21.111783+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "d54a9b3b-b25d-4b68-ad6c-210e87d8ed05",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/1f9b11b9-272b-4d13-a9af-33fed1be82a3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1f9b11b9-272b-4d13-a9af-33fed1be82a3",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-09T09:26:19.464832+00:00",
      "updated_at": "2024-09-09T09:26:19.464832+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "1b2e0fc3-6252-40b2-9f62-f4fdae6db2f8",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "1b2e0fc3-6252-40b2-9f62-f4fdae6db2f8"
        }
      }
    }
  },
  "included": [
    {
      "id": "1b2e0fc3-6252-40b2-9f62-f4fdae6db2f8",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-09-09T09:26:19.458535+00:00",
        "updated_at": "2024-09-09T09:26:19.466127+00:00",
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
          "owner_id": "0e368d02-fa38-42ad-a86b-2ce6f7b6ca24",
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
    "id": "7690dc8d-e3f0-4f0b-99ed-929b82b08b96",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-09T09:26:18.783848+00:00",
      "updated_at": "2024-09-09T09:26:18.783848+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "0e368d02-fa38-42ad-a86b-2ce6f7b6ca24",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "0e368d02-fa38-42ad-a86b-2ce6f7b6ca24"
        }
      }
    }
  },
  "included": [
    {
      "id": "0e368d02-fa38-42ad-a86b-2ce6f7b6ca24",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-09-09T09:26:18.766918+00:00",
        "updated_at": "2024-09-09T09:26:18.785077+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/66c19e39-0c39-4795-b0fc-f432a9885ade' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "66c19e39-0c39-4795-b0fc-f432a9885ade",
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
    "id": "66c19e39-0c39-4795-b0fc-f432a9885ade",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-09T09:26:20.312992+00:00",
      "updated_at": "2024-09-09T09:26:20.331808+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "2bc8cbbe-20c2-4ee4-b154-ac85067b10b2",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "2bc8cbbe-20c2-4ee4-b154-ac85067b10b2"
        }
      }
    }
  },
  "included": [
    {
      "id": "2bc8cbbe-20c2-4ee4-b154-ac85067b10b2",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-09-09T09:26:20.303787+00:00",
        "updated_at": "2024-09-09T09:26:20.333045+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/d522dbf8-a05b-4b7d-9fab-fe0db886ae10' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d522dbf8-a05b-4b7d-9fab-fe0db886ae10",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-09-09T09:26:18.202071+00:00",
      "updated_at": "2024-09-09T09:26:18.202071+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "be406226-3b54-46fb-9d84-321fc559c281",
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