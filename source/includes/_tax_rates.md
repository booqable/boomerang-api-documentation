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
      "id": "c20e01d5-bf36-4dd7-a216-b5c0f4e5caa0",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-06-24T09:50:04.016204+00:00",
        "updated_at": "2024-06-24T09:50:04.016204+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "2d2ff009-460b-4a0b-a21b-2b585027c91d",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/2d2ff009-460b-4a0b-a21b-2b585027c91d"
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






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/42bc841a-95a7-48b7-b330-da688898e319?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "42bc841a-95a7-48b7-b330-da688898e319",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-24T09:50:05.690488+00:00",
      "updated_at": "2024-06-24T09:50:05.690488+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "95f55322-b828-4264-affc-9fc9dc7a25d1",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/95f55322-b828-4264-affc-9fc9dc7a25d1"
        },
        "data": {
          "type": "tax_regions",
          "id": "95f55322-b828-4264-affc-9fc9dc7a25d1"
        }
      }
    }
  },
  "included": [
    {
      "id": "95f55322-b828-4264-affc-9fc9dc7a25d1",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-06-24T09:50:05.672208+00:00",
        "updated_at": "2024-06-24T09:50:05.695755+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=95f55322-b828-4264-affc-9fc9dc7a25d1&filter[owner_type]=tax_regions"
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
          "owner_id": "8e1f32e0-8e7e-48e8-b220-2c3438985230",
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
    "id": "ec214970-817c-4392-a9d4-9eb64f29c7b7",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-24T09:50:08.352933+00:00",
      "updated_at": "2024-06-24T09:50:08.352933+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "8e1f32e0-8e7e-48e8-b220-2c3438985230",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "8e1f32e0-8e7e-48e8-b220-2c3438985230"
        }
      }
    }
  },
  "included": [
    {
      "id": "8e1f32e0-8e7e-48e8-b220-2c3438985230",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-06-24T09:50:08.312864+00:00",
        "updated_at": "2024-06-24T09:50:08.356748+00:00",
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






## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/aac5389a-ff7c-49d2-b0fa-ed1f82a7849e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "aac5389a-ff7c-49d2-b0fa-ed1f82a7849e",
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
    "id": "aac5389a-ff7c-49d2-b0fa-ed1f82a7849e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-24T09:50:07.171238+00:00",
      "updated_at": "2024-06-24T09:50:07.219726+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "59455e01-071f-46f2-ad2a-bb71a311c36e",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "59455e01-071f-46f2-ad2a-bb71a311c36e"
        }
      }
    }
  },
  "included": [
    {
      "id": "59455e01-071f-46f2-ad2a-bb71a311c36e",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-06-24T09:50:07.151041+00:00",
        "updated_at": "2024-06-24T09:50:07.223246+00:00",
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






## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/077ad806-1681-46d6-a142-97548bf35aa5' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "077ad806-1681-46d6-a142-97548bf35aa5",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-06-24T09:50:04.937360+00:00",
      "updated_at": "2024-06-24T09:50:04.937360+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "424f1664-e4e4-4c0c-8203-4be93d3b6f6c",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "meta": {
          "included": false
        }
      }
    }
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