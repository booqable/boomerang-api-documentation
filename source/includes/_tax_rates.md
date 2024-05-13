# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`DELETE /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

`GET api/boomerang/tax_rates`

`PUT /api/boomerang/tax_rates/{id}`

`GET /api/boomerang/tax_rates/{id}`

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


## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/b8739de0-7458-4bc3-878a-e1264a5f3023' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b8739de0-7458-4bc3-878a-e1264a5f3023",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-05-13T09:28:51+00:00",
      "updated_at": "2024-05-13T09:28:51+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "1fd0c066-9a50-49b8-b7c5-675a6bbfdc6b",
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
          "owner_id": "3f1ead7d-f869-46de-9292-e3f26ba5be36",
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
    "id": "e6850969-464a-492f-ac3b-58350c7746ba",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-05-13T09:28:53+00:00",
      "updated_at": "2024-05-13T09:28:53+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "3f1ead7d-f869-46de-9292-e3f26ba5be36",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "3f1ead7d-f869-46de-9292-e3f26ba5be36"
        }
      }
    }
  },
  "included": [
    {
      "id": "3f1ead7d-f869-46de-9292-e3f26ba5be36",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-05-13T09:28:52+00:00",
        "updated_at": "2024-05-13T09:28:53+00:00",
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
      "id": "56718250-3335-47f7-8f45-a1f5615053fb",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-05-13T09:28:54+00:00",
        "updated_at": "2024-05-13T09:28:54+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "4f948bea-5f9b-48f2-9da4-79e53cb6cbf6",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/4f948bea-5f9b-48f2-9da4-79e53cb6cbf6"
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






## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/1c389853-ca45-45ee-ad48-3f489150e875' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1c389853-ca45-45ee-ad48-3f489150e875",
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
    "id": "1c389853-ca45-45ee-ad48-3f489150e875",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-05-13T09:28:55+00:00",
      "updated_at": "2024-05-13T09:28:55+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "e9b606e3-c10e-41e4-ab71-0fa5d40ab77b",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "e9b606e3-c10e-41e4-ab71-0fa5d40ab77b"
        }
      }
    }
  },
  "included": [
    {
      "id": "e9b606e3-c10e-41e4-ab71-0fa5d40ab77b",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-05-13T09:28:55+00:00",
        "updated_at": "2024-05-13T09:28:55+00:00",
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






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/e8f0ee88-2022-43bc-af3f-543d17604b8c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e8f0ee88-2022-43bc-af3f-543d17604b8c",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-05-13T09:28:56+00:00",
      "updated_at": "2024-05-13T09:28:56+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "3fa8afa1-3750-44d9-8dd8-50a178ea3ea9",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/3fa8afa1-3750-44d9-8dd8-50a178ea3ea9"
        },
        "data": {
          "type": "tax_regions",
          "id": "3fa8afa1-3750-44d9-8dd8-50a178ea3ea9"
        }
      }
    }
  },
  "included": [
    {
      "id": "3fa8afa1-3750-44d9-8dd8-50a178ea3ea9",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-05-13T09:28:56+00:00",
        "updated_at": "2024-05-13T09:28:56+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=3fa8afa1-3750-44d9-8dd8-50a178ea3ea9&filter[owner_type]=tax_regions"
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





