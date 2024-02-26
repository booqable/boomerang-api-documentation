# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`GET api/boomerang/tax_rates`

`POST /api/boomerang/tax_rates`

`DELETE /api/boomerang/tax_rates/{id}`

`GET /api/boomerang/tax_rates/{id}`

`PUT /api/boomerang/tax_rates/{id}`

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
      "id": "c292129f-d846-4d92-8b8f-9b83089fca8e",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-02-26T09:20:27+00:00",
        "updated_at": "2024-02-26T09:20:27+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "6a38d30f-7d96-4094-b072-1bd8c2143a82",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/6a38d30f-7d96-4094-b072-1bd8c2143a82"
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
          "owner_id": "0223e244-baf2-41cb-aecf-96cb1da66e5f",
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
    "id": "f758357a-139d-4469-8cb6-891df13969e9",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-02-26T09:20:28+00:00",
      "updated_at": "2024-02-26T09:20:28+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "0223e244-baf2-41cb-aecf-96cb1da66e5f",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "0223e244-baf2-41cb-aecf-96cb1da66e5f"
        }
      }
    }
  },
  "included": [
    {
      "id": "0223e244-baf2-41cb-aecf-96cb1da66e5f",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-02-26T09:20:28+00:00",
        "updated_at": "2024-02-26T09:20:28+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/ce2e794e-4980-4217-aac4-2674fc30d34b' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/b81737df-1214-4d1b-a338-0640f511d766?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b81737df-1214-4d1b-a338-0640f511d766",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-02-26T09:20:29+00:00",
      "updated_at": "2024-02-26T09:20:29+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "36c6ede0-238e-4db4-9a8a-4fee2ba6fc4f",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/36c6ede0-238e-4db4-9a8a-4fee2ba6fc4f"
        },
        "data": {
          "type": "tax_regions",
          "id": "36c6ede0-238e-4db4-9a8a-4fee2ba6fc4f"
        }
      }
    }
  },
  "included": [
    {
      "id": "36c6ede0-238e-4db4-9a8a-4fee2ba6fc4f",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-02-26T09:20:29+00:00",
        "updated_at": "2024-02-26T09:20:29+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=36c6ede0-238e-4db4-9a8a-4fee2ba6fc4f&filter[owner_type]=tax_regions"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Includes

This request accepts the following includes:

`owner`






## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/e12f03fa-853c-4d51-97aa-4416b6df1490' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e12f03fa-853c-4d51-97aa-4416b6df1490",
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
    "id": "e12f03fa-853c-4d51-97aa-4416b6df1490",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-02-26T09:20:30+00:00",
      "updated_at": "2024-02-26T09:20:30+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "503fd46f-d417-4d4f-bb4a-6bcacd52ae91",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "503fd46f-d417-4d4f-bb4a-6bcacd52ae91"
        }
      }
    }
  },
  "included": [
    {
      "id": "503fd46f-d417-4d4f-bb4a-6bcacd52ae91",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-02-26T09:20:30+00:00",
        "updated_at": "2024-02-26T09:20:30+00:00",
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





