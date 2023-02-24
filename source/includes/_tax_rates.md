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
- | -
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
- | -
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
      "id": "d6b9e03d-6264-4852-b573-7a67b9d2a4c4",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-02-24T09:51:20+00:00",
        "updated_at": "2023-02-24T09:51:20+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "c7622baf-0396-4208-a790-67bb21a74dbc",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/c7622baf-0396-4208-a790-67bb21a74dbc"
          }
        }
      }
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:46:21Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/aeae3c5e-ad2b-45e4-92df-8e5dc4d748d4?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "aeae3c5e-ad2b-45e4-92df-8e5dc4d748d4",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-02-24T09:51:20+00:00",
      "updated_at": "2023-02-24T09:51:20+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "ffcc1fe4-8793-4f42-804d-f559b9582f56",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/ffcc1fe4-8793-4f42-804d-f559b9582f56"
        },
        "data": {
          "type": "tax_regions",
          "id": "ffcc1fe4-8793-4f42-804d-f559b9582f56"
        }
      }
    }
  },
  "included": [
    {
      "id": "ffcc1fe4-8793-4f42-804d-f559b9582f56",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-02-24T09:51:20+00:00",
        "updated_at": "2023-02-24T09:51:20+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=ffcc1fe4-8793-4f42-804d-f559b9582f56&filter[owner_type]=tax_regions"
          }
        }
      }
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


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
          "owner_id": "cac65dce-06e4-4897-ba89-b3ecbbb6d91f",
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
    "id": "a0248142-4def-41c8-ab5e-29d4cbf348d8",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-02-24T09:51:20+00:00",
      "updated_at": "2023-02-24T09:51:20+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "cac65dce-06e4-4897-ba89-b3ecbbb6d91f",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "cac65dce-06e4-4897-ba89-b3ecbbb6d91f"
        }
      }
    }
  },
  "included": [
    {
      "id": "cac65dce-06e4-4897-ba89-b3ecbbb6d91f",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-02-24T09:51:20+00:00",
        "updated_at": "2023-02-24T09:51:20+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "meta": {
            "included": false
          }
        }
      }
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/0a88a443-5239-4f0d-95b0-cebf46538e28' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0a88a443-5239-4f0d-95b0-cebf46538e28",
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
    "id": "0a88a443-5239-4f0d-95b0-cebf46538e28",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-02-24T09:51:21+00:00",
      "updated_at": "2023-02-24T09:51:21+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "f2df9cc5-5d50-4b50-b6db-50cf23129c86",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "f2df9cc5-5d50-4b50-b6db-50cf23129c86"
        }
      }
    }
  },
  "included": [
    {
      "id": "f2df9cc5-5d50-4b50-b6db-50cf23129c86",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2023-02-24T09:51:21+00:00",
        "updated_at": "2023-02-24T09:51:21+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "meta": {
            "included": false
          }
        }
      }
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/8da02eb6-dba1-406d-b9ed-addf96d3c57e' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Includes

This request does not accept any includes