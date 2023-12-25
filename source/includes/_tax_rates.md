# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`DELETE /api/boomerang/tax_rates/{id}`

`PUT /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

`GET api/boomerang/tax_rates`

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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/1f8321ae-077a-44e8-8c66-7bf59de565ee' \
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/0d3b62c5-b967-49bf-9e92-6bdbc06e7bed' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0d3b62c5-b967-49bf-9e92-6bdbc06e7bed",
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
    "id": "0d3b62c5-b967-49bf-9e92-6bdbc06e7bed",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-12-25T09:17:44+00:00",
      "updated_at": "2023-12-25T09:17:44+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "73511dd3-a09a-4f8d-9983-35f931f40938",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "73511dd3-a09a-4f8d-9983-35f931f40938"
        }
      }
    }
  },
  "included": [
    {
      "id": "73511dd3-a09a-4f8d-9983-35f931f40938",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2023-12-25T09:17:44+00:00",
        "updated_at": "2023-12-25T09:17:44+00:00",
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
          "owner_id": "5927d388-95d1-46ea-9b5c-5cef510f810a",
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
    "id": "dc8a1df4-87ba-4df1-bb66-b8290a5fe704",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-12-25T09:17:44+00:00",
      "updated_at": "2023-12-25T09:17:44+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "5927d388-95d1-46ea-9b5c-5cef510f810a",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "5927d388-95d1-46ea-9b5c-5cef510f810a"
        }
      }
    }
  },
  "included": [
    {
      "id": "5927d388-95d1-46ea-9b5c-5cef510f810a",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-12-25T09:17:44+00:00",
        "updated_at": "2023-12-25T09:17:44+00:00",
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
      "id": "f25e9c79-c7dc-447f-babd-4457bfcea434",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-12-25T09:17:45+00:00",
        "updated_at": "2023-12-25T09:17:45+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "32452b4a-c496-437c-a190-8938afac499d",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/32452b4a-c496-437c-a190-8938afac499d"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/375e8580-5107-4901-8b8f-befb47cc99f7?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "375e8580-5107-4901-8b8f-befb47cc99f7",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-12-25T09:17:46+00:00",
      "updated_at": "2023-12-25T09:17:46+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "ad312b13-46e8-4f72-b570-16287eac6067",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/ad312b13-46e8-4f72-b570-16287eac6067"
        },
        "data": {
          "type": "tax_regions",
          "id": "ad312b13-46e8-4f72-b570-16287eac6067"
        }
      }
    }
  },
  "included": [
    {
      "id": "ad312b13-46e8-4f72-b570-16287eac6067",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-12-25T09:17:46+00:00",
        "updated_at": "2023-12-25T09:17:46+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=ad312b13-46e8-4f72-b570-16287eac6067&filter[owner_type]=tax_regions"
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





