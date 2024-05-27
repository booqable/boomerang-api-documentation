# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`DELETE /api/boomerang/tax_rates/{id}`

`GET api/boomerang/tax_rates`

`PUT /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/4b031033-e4c2-4915-9f31-5b81474e6cd5' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4b031033-e4c2-4915-9f31-5b81474e6cd5",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-05-27T09:24:46.133711+00:00",
      "updated_at": "2024-05-27T09:24:46.133711+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "235d5ecb-be03-4bb9-a9cf-3bec140a2802",
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
      "id": "144bed16-cc00-47cb-856b-a0807c6327c4",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-05-27T09:24:46.792781+00:00",
        "updated_at": "2024-05-27T09:24:46.792781+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "3186c516-be09-405c-89cb-f12a77f28a44",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/3186c516-be09-405c-89cb-f12a77f28a44"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/159c7ca1-488e-4c63-a2fb-f332ddeb18e3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "159c7ca1-488e-4c63-a2fb-f332ddeb18e3",
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
    "id": "159c7ca1-488e-4c63-a2fb-f332ddeb18e3",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-05-27T09:24:47.575896+00:00",
      "updated_at": "2024-05-27T09:24:47.619565+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "7690a14b-e5fc-4949-97cc-88a21f496c34",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "7690a14b-e5fc-4949-97cc-88a21f496c34"
        }
      }
    }
  },
  "included": [
    {
      "id": "7690a14b-e5fc-4949-97cc-88a21f496c34",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-05-27T09:24:47.551332+00:00",
        "updated_at": "2024-05-27T09:24:47.623130+00:00",
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
          "owner_id": "578408f6-a28f-40f0-a56b-70a408ac4979",
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
    "id": "4c108a9b-b9c0-465c-8c44-18f5baf9ad64",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-05-27T09:24:48.302015+00:00",
      "updated_at": "2024-05-27T09:24:48.302015+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "578408f6-a28f-40f0-a56b-70a408ac4979",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "578408f6-a28f-40f0-a56b-70a408ac4979"
        }
      }
    }
  },
  "included": [
    {
      "id": "578408f6-a28f-40f0-a56b-70a408ac4979",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-05-27T09:24:48.266793+00:00",
        "updated_at": "2024-05-27T09:24:48.305734+00:00",
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






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/0c9fc3a6-9f7b-403a-a7d3-8d8a5bef55da?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0c9fc3a6-9f7b-403a-a7d3-8d8a5bef55da",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-05-27T09:24:48.897354+00:00",
      "updated_at": "2024-05-27T09:24:48.897354+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "062c9300-5b24-450b-83d5-77b74a5d589a",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/062c9300-5b24-450b-83d5-77b74a5d589a"
        },
        "data": {
          "type": "tax_regions",
          "id": "062c9300-5b24-450b-83d5-77b74a5d589a"
        }
      }
    }
  },
  "included": [
    {
      "id": "062c9300-5b24-450b-83d5-77b74a5d589a",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-05-27T09:24:48.885303+00:00",
        "updated_at": "2024-05-27T09:24:48.900188+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=062c9300-5b24-450b-83d5-77b74a5d589a&filter[owner_type]=tax_regions"
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





