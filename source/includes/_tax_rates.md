# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`GET /api/boomerang/tax_rates/{id}`

`PUT /api/boomerang/tax_rates/{id}`

`GET api/boomerang/tax_rates`

`DELETE /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

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


## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/746a1284-5e81-458b-9a71-b25ed5d211ad?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "746a1284-5e81-458b-9a71-b25ed5d211ad",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-12-18T09:13:00+00:00",
      "updated_at": "2023-12-18T09:13:00+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "2c90ec8c-f7bf-4930-959f-97518d5ec0f5",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/2c90ec8c-f7bf-4930-959f-97518d5ec0f5"
        },
        "data": {
          "type": "tax_regions",
          "id": "2c90ec8c-f7bf-4930-959f-97518d5ec0f5"
        }
      }
    }
  },
  "included": [
    {
      "id": "2c90ec8c-f7bf-4930-959f-97518d5ec0f5",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-12-18T09:13:00+00:00",
        "updated_at": "2023-12-18T09:13:00+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=2c90ec8c-f7bf-4930-959f-97518d5ec0f5&filter[owner_type]=tax_regions"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/1ee0c30b-fefe-4fef-9d9b-a231dc92cb86' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1ee0c30b-fefe-4fef-9d9b-a231dc92cb86",
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
    "id": "1ee0c30b-fefe-4fef-9d9b-a231dc92cb86",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-12-18T09:13:02+00:00",
      "updated_at": "2023-12-18T09:13:02+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "f21ac8e5-99c4-4195-8693-27c0d4a70117",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "f21ac8e5-99c4-4195-8693-27c0d4a70117"
        }
      }
    }
  },
  "included": [
    {
      "id": "f21ac8e5-99c4-4195-8693-27c0d4a70117",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2023-12-18T09:13:02+00:00",
        "updated_at": "2023-12-18T09:13:02+00:00",
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
      "id": "3518a761-222a-409f-af98-4f193d277786",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-12-18T09:13:02+00:00",
        "updated_at": "2023-12-18T09:13:02+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "22f9eae9-9866-4e32-b7e7-b7249318cd61",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/22f9eae9-9866-4e32-b7e7-b7249318cd61"
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






## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/b8132612-f57b-436e-87ce-413c03b5c6db' \
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
          "owner_id": "f71c6b91-21c3-4377-a2b9-cb459e4bd300",
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
    "id": "7a8d33d1-80fc-4684-85a2-8170dd3fd4f6",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-12-18T09:13:04+00:00",
      "updated_at": "2023-12-18T09:13:04+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "f71c6b91-21c3-4377-a2b9-cb459e4bd300",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "f71c6b91-21c3-4377-a2b9-cb459e4bd300"
        }
      }
    }
  },
  "included": [
    {
      "id": "f71c6b91-21c3-4377-a2b9-cb459e4bd300",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-12-18T09:13:04+00:00",
        "updated_at": "2023-12-18T09:13:04+00:00",
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





