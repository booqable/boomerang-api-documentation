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
      "id": "34421b23-ede4-4b2f-8c81-94ddc63d00d6",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-05-15T13:52:21+00:00",
        "updated_at": "2023-05-15T13:52:21+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "3e5d2217-060b-4ed3-8502-0c30cd65e71d",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/3e5d2217-060b-4ed3-8502-0c30cd65e71d"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/68994639-679f-4da7-8c0c-fc586478b422?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "68994639-679f-4da7-8c0c-fc586478b422",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-05-15T13:52:22+00:00",
      "updated_at": "2023-05-15T13:52:22+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "8c66ac81-4b52-48c7-ae6a-36bcc3d5c0c3",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/8c66ac81-4b52-48c7-ae6a-36bcc3d5c0c3"
        },
        "data": {
          "type": "tax_regions",
          "id": "8c66ac81-4b52-48c7-ae6a-36bcc3d5c0c3"
        }
      }
    }
  },
  "included": [
    {
      "id": "8c66ac81-4b52-48c7-ae6a-36bcc3d5c0c3",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-05-15T13:52:22+00:00",
        "updated_at": "2023-05-15T13:52:22+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=8c66ac81-4b52-48c7-ae6a-36bcc3d5c0c3&filter[owner_type]=tax_regions"
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
          "owner_id": "dea9b4e0-d5e7-4aee-8f64-481ba9ad805a",
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
    "id": "4fe4ee23-4908-47ac-ade8-084572904958",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-05-15T13:52:23+00:00",
      "updated_at": "2023-05-15T13:52:23+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "dea9b4e0-d5e7-4aee-8f64-481ba9ad805a",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "dea9b4e0-d5e7-4aee-8f64-481ba9ad805a"
        }
      }
    }
  },
  "included": [
    {
      "id": "dea9b4e0-d5e7-4aee-8f64-481ba9ad805a",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-05-15T13:52:23+00:00",
        "updated_at": "2023-05-15T13:52:23+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/5b219ba5-d975-4cdc-84e1-ba7b0cb93e96' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5b219ba5-d975-4cdc-84e1-ba7b0cb93e96",
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
    "id": "5b219ba5-d975-4cdc-84e1-ba7b0cb93e96",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-05-15T13:52:23+00:00",
      "updated_at": "2023-05-15T13:52:23+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "9ff667b3-a4d6-42f5-87b6-84abc417f0ff",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "9ff667b3-a4d6-42f5-87b6-84abc417f0ff"
        }
      }
    }
  },
  "included": [
    {
      "id": "9ff667b3-a4d6-42f5-87b6-84abc417f0ff",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2023-05-15T13:52:23+00:00",
        "updated_at": "2023-05-15T13:52:23+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/20bb10ef-c40d-4e89-8688-9167580e1952' \
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