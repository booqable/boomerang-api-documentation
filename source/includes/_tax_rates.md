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
      "id": "eb0cea55-16ce-4ecf-962c-19f5f6ff2a7a",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-02-20T11:50:05+00:00",
        "updated_at": "2023-02-20T11:50:05+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "8d792c95-03a3-49d8-9e0e-7304ac4dce88",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/8d792c95-03a3-49d8-9e0e-7304ac4dce88"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-20T11:45:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/df3619e8-0586-4d7e-ae3a-f2b2527d6256?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "df3619e8-0586-4d7e-ae3a-f2b2527d6256",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-02-20T11:50:05+00:00",
      "updated_at": "2023-02-20T11:50:05+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "8a3d0891-570b-4051-a6dc-66ed2d3f3dd5",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/8a3d0891-570b-4051-a6dc-66ed2d3f3dd5"
        },
        "data": {
          "type": "tax_regions",
          "id": "8a3d0891-570b-4051-a6dc-66ed2d3f3dd5"
        }
      }
    }
  },
  "included": [
    {
      "id": "8a3d0891-570b-4051-a6dc-66ed2d3f3dd5",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-02-20T11:50:05+00:00",
        "updated_at": "2023-02-20T11:50:05+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=8a3d0891-570b-4051-a6dc-66ed2d3f3dd5&filter[owner_type]=tax_regions"
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
          "owner_id": "fdfd7790-98ee-4bef-b38e-6ace0f118f0a",
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
    "id": "8caa909b-3d48-44f0-913e-7ceffcfc4fa7",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-02-20T11:50:06+00:00",
      "updated_at": "2023-02-20T11:50:06+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "fdfd7790-98ee-4bef-b38e-6ace0f118f0a",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "fdfd7790-98ee-4bef-b38e-6ace0f118f0a"
        }
      }
    }
  },
  "included": [
    {
      "id": "fdfd7790-98ee-4bef-b38e-6ace0f118f0a",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-02-20T11:50:05+00:00",
        "updated_at": "2023-02-20T11:50:06+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/fe3d7a43-bc80-4608-a93d-f409f6093ac3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fe3d7a43-bc80-4608-a93d-f409f6093ac3",
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
    "id": "fe3d7a43-bc80-4608-a93d-f409f6093ac3",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2023-02-20T11:50:06+00:00",
      "updated_at": "2023-02-20T11:50:06+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "6b3851a2-3f0c-4bd2-bff2-507763e22e46",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "6b3851a2-3f0c-4bd2-bff2-507763e22e46"
        }
      }
    }
  },
  "included": [
    {
      "id": "6b3851a2-3f0c-4bd2-bff2-507763e22e46",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2023-02-20T11:50:06+00:00",
        "updated_at": "2023-02-20T11:50:06+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/9e7002fd-3952-46d4-a7b9-cf28105c8e3b' \
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