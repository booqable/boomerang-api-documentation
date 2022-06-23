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
`name` | **String**<br>The name of the tax rate
`value` | **Float**<br>The percentage value of the rate
`position` | **Integer** `readonly`<br>Position of the tax rate
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `tax_regions`, `tax_categories`


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
      "id": "2b3f49ba-785a-4601-8b5a-f5c1950cdc01",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-06-23T19:03:52+00:00",
        "updated_at": "2022-06-23T19:03:52+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "4fe488fd-3806-4855-9a45-c77fb125d43a",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/4fe488fd-3806-4855-9a45-c77fb125d43a"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-23T19:00:38Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c03cb733-f381-45bf-b5a5-6a2515a4ca28?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c03cb733-f381-45bf-b5a5-6a2515a4ca28",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-06-23T19:03:52+00:00",
      "updated_at": "2022-06-23T19:03:52+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "a6dad282-7522-4526-9ee4-ee0720ee526b",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/a6dad282-7522-4526-9ee4-ee0720ee526b"
        },
        "data": {
          "type": "tax_regions",
          "id": "a6dad282-7522-4526-9ee4-ee0720ee526b"
        }
      }
    }
  },
  "included": [
    {
      "id": "a6dad282-7522-4526-9ee4-ee0720ee526b",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2022-06-23T19:03:52+00:00",
        "updated_at": "2022-06-23T19:03:52+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=a6dad282-7522-4526-9ee4-ee0720ee526b&filter[owner_type]=tax_regions"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


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
          "owner_id": "cdd76e09-19b7-483f-8582-9c9fd5a54ddf",
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
    "id": "b7c0b4a5-3099-439c-bac4-86fcb8a96021",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-06-23T19:03:52+00:00",
      "updated_at": "2022-06-23T19:03:52+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "cdd76e09-19b7-483f-8582-9c9fd5a54ddf",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "cdd76e09-19b7-483f-8582-9c9fd5a54ddf"
        }
      }
    }
  },
  "included": [
    {
      "id": "cdd76e09-19b7-483f-8582-9c9fd5a54ddf",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2022-06-23T19:03:52+00:00",
        "updated_at": "2022-06-23T19:03:52+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>The name of the tax rate
`data[attributes][value]` | **Float**<br>The percentage value of the rate
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `tax_regions`, `tax_categories`


### Includes

This request accepts the following includes:

`owner`






## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c9634e6d-f4fa-43db-848e-a310740d7244' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c9634e6d-f4fa-43db-848e-a310740d7244",
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
    "id": "c9634e6d-f4fa-43db-848e-a310740d7244",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-06-23T19:03:53+00:00",
      "updated_at": "2022-06-23T19:03:53+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "722d3ff1-cbcc-49f7-89b9-ad6c860bbe76",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "722d3ff1-cbcc-49f7-89b9-ad6c860bbe76"
        }
      }
    }
  },
  "included": [
    {
      "id": "722d3ff1-cbcc-49f7-89b9-ad6c860bbe76",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2022-06-23T19:03:53+00:00",
        "updated_at": "2022-06-23T19:03:53+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>The name of the tax rate
`data[attributes][value]` | **Float**<br>The percentage value of the rate
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `tax_regions`, `tax_categories`


### Includes

This request accepts the following includes:

`owner`






## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/894d41c0-03b2-4f5d-99f8-42ea959b8b20' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Includes

This request does not accept any includes