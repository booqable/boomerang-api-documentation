# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`GET /api/boomerang/tax_rates/{id}`

`GET api/boomerang/tax_rates`

`DELETE /api/boomerang/tax_rates/{id}`

`PUT /api/boomerang/tax_rates/{id}`

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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/a4a31009-fa82-4b6e-b6f3-997d1b29240b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a4a31009-fa82-4b6e-b6f3-997d1b29240b",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-01-01T09:18:29+00:00",
      "updated_at": "2024-01-01T09:18:29+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "12204d56-b634-4a60-b497-065b6be7967e",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/12204d56-b634-4a60-b497-065b6be7967e"
        },
        "data": {
          "type": "tax_regions",
          "id": "12204d56-b634-4a60-b497-065b6be7967e"
        }
      }
    }
  },
  "included": [
    {
      "id": "12204d56-b634-4a60-b497-065b6be7967e",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-01-01T09:18:29+00:00",
        "updated_at": "2024-01-01T09:18:29+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=12204d56-b634-4a60-b497-065b6be7967e&filter[owner_type]=tax_regions"
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
      "id": "532b6222-1e49-4016-af4b-b68768d2430d",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-01-01T09:18:29+00:00",
        "updated_at": "2024-01-01T09:18:29+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "94e7dca9-6d2b-4ce0-980a-7843cbd0ad8c",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/94e7dca9-6d2b-4ce0-980a-7843cbd0ad8c"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/4a66e8aa-1280-4c4c-9913-e6fb8f9ba1c8' \
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
## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/d6051f8d-dd06-4c7a-b818-64f8ac8b8fed' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d6051f8d-dd06-4c7a-b818-64f8ac8b8fed",
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
    "id": "d6051f8d-dd06-4c7a-b818-64f8ac8b8fed",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-01-01T09:18:30+00:00",
      "updated_at": "2024-01-01T09:18:30+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "c623a57a-c147-466b-8694-685e3bbf7350",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "c623a57a-c147-466b-8694-685e3bbf7350"
        }
      }
    }
  },
  "included": [
    {
      "id": "c623a57a-c147-466b-8694-685e3bbf7350",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-01-01T09:18:30+00:00",
        "updated_at": "2024-01-01T09:18:30+00:00",
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
          "owner_id": "0d01d819-87ff-43b6-9c8e-e699d3693cd1",
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
    "id": "b5746121-45a9-4945-b755-0355a70df59b",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-01-01T09:18:31+00:00",
      "updated_at": "2024-01-01T09:18:31+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "0d01d819-87ff-43b6-9c8e-e699d3693cd1",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "0d01d819-87ff-43b6-9c8e-e699d3693cd1"
        }
      }
    }
  },
  "included": [
    {
      "id": "0d01d819-87ff-43b6-9c8e-e699d3693cd1",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-01-01T09:18:31+00:00",
        "updated_at": "2024-01-01T09:18:31+00:00",
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





