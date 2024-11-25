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
      "id": "e8695554-0fae-4417-86a2-6021d3dad0c8",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-11-25T09:31:33.844465+00:00",
        "updated_at": "2024-11-25T09:31:33.844465+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "a70abdc0-9d17-4a57-a434-a2e6bfdf6a61",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/2c82fe01-97b0-49b8-be64-85be71ff35d6?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2c82fe01-97b0-49b8-be64-85be71ff35d6",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-25T09:31:32.000982+00:00",
      "updated_at": "2024-11-25T09:31:32.000982+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "2c20fa81-7914-445f-8345-9d3b448d9c4a",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "2c20fa81-7914-445f-8345-9d3b448d9c4a"
        }
      }
    }
  },
  "included": [
    {
      "id": "2c20fa81-7914-445f-8345-9d3b448d9c4a",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-11-25T09:31:31.990138+00:00",
        "updated_at": "2024-11-25T09:31:32.003075+00:00",
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
          "owner_id": "07ccb607-3ce6-465b-abdf-1c49b6cbf55d",
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
    "id": "07f3de13-0e85-41fb-a488-8933d6c99992",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-25T09:31:35.644173+00:00",
      "updated_at": "2024-11-25T09:31:35.644173+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "07ccb607-3ce6-465b-abdf-1c49b6cbf55d",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "07ccb607-3ce6-465b-abdf-1c49b6cbf55d"
        }
      }
    }
  },
  "included": [
    {
      "id": "07ccb607-3ce6-465b-abdf-1c49b6cbf55d",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-11-25T09:31:35.615421+00:00",
        "updated_at": "2024-11-25T09:31:35.646457+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/6ea0a743-5d90-4c53-83fc-4baffa12164b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6ea0a743-5d90-4c53-83fc-4baffa12164b",
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
    "id": "6ea0a743-5d90-4c53-83fc-4baffa12164b",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-25T09:31:36.989427+00:00",
      "updated_at": "2024-11-25T09:31:37.026675+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "a9968ab1-114b-41a3-8873-515687fc468d",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "a9968ab1-114b-41a3-8873-515687fc468d"
        }
      }
    }
  },
  "included": [
    {
      "id": "a9968ab1-114b-41a3-8873-515687fc468d",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-11-25T09:31:36.972055+00:00",
        "updated_at": "2024-11-25T09:31:37.028813+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/d140bdc5-6d46-4338-b885-4a6f0176bdce' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d140bdc5-6d46-4338-b885-4a6f0176bdce",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-25T09:31:36.376982+00:00",
      "updated_at": "2024-11-25T09:31:36.376982+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "0b13be47-57fb-4e03-9ad7-3c30774fd051",
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