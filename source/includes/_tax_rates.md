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
`owner` | **[Tax category](#tax-categories), [Tax region](#tax-regions)** <br>Associated Owner


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
      "id": "52b8ace1-fd19-4c8f-9fd6-8fa16e00b750",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-12-02T09:23:13.293739+00:00",
        "updated_at": "2024-12-02T09:23:13.293739+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "7003c00c-9c85-4d20-9fef-a705b72fed10",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/cecf5088-a763-4aeb-93f3-eab00c67114c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cecf5088-a763-4aeb-93f3-eab00c67114c",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-12-02T09:23:11.829162+00:00",
      "updated_at": "2024-12-02T09:23:11.829162+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "e288861b-ca58-4042-857a-cb8c26957c3b",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "e288861b-ca58-4042-857a-cb8c26957c3b"
        }
      }
    }
  },
  "included": [
    {
      "id": "e288861b-ca58-4042-857a-cb8c26957c3b",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-12-02T09:23:11.822061+00:00",
        "updated_at": "2024-12-02T09:23:11.830600+00:00",
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
          "owner_id": "4f6c55c3-086d-470b-82af-7b7e67e05647",
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
    "id": "8e08d66d-19b6-4f21-8ef8-ad1d822c73ad",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-12-02T09:23:12.848584+00:00",
      "updated_at": "2024-12-02T09:23:12.848584+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "4f6c55c3-086d-470b-82af-7b7e67e05647",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "4f6c55c3-086d-470b-82af-7b7e67e05647"
        }
      }
    }
  },
  "included": [
    {
      "id": "4f6c55c3-086d-470b-82af-7b7e67e05647",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-12-02T09:23:12.828765+00:00",
        "updated_at": "2024-12-02T09:23:12.850104+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/68f31682-72d6-460a-93d4-a42995137fe8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "68f31682-72d6-460a-93d4-a42995137fe8",
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
    "id": "68f31682-72d6-460a-93d4-a42995137fe8",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-12-02T09:23:11.390545+00:00",
      "updated_at": "2024-12-02T09:23:11.411090+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "26df097f-2c2b-486b-a9b0-f61a814643fd",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "26df097f-2c2b-486b-a9b0-f61a814643fd"
        }
      }
    }
  },
  "included": [
    {
      "id": "26df097f-2c2b-486b-a9b0-f61a814643fd",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-12-02T09:23:11.380670+00:00",
        "updated_at": "2024-12-02T09:23:11.412540+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c21e68c7-949b-4a78-b074-9f5b54212de3' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c21e68c7-949b-4a78-b074-9f5b54212de3",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-12-02T09:23:12.364874+00:00",
      "updated_at": "2024-12-02T09:23:12.364874+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "8eb5e4c6-dd79-4cd3-a524-e03731c1117c",
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