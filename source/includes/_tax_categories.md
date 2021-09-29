# Tax categories

You can create different tax categories and assign them according to the tax requirements of a product. The tax rates in the category are charged over a product when it's added to an order. An order's total tax rate is the sum of all product taxes on that order.

## Endpoints
`GET /api/boomerang/tax_categories`

`GET /api/boomerang/tax_categories/{id}`

`POST /api/boomerang/tax_categories`

`PUT /api/boomerang/tax_categories/{id}`

`DELETE /api/boomerang/tax_categories/{id}`

## Fields
Every tax category has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Name of the tax category
`default` | **Boolean**<br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`
`tax_rates_attributes` | **Array** `writeonly`<br>The tax rates to associate


## Relationships
A tax categories has the following relationships:

Name | Description
- | -
`tax_rates` | **Tax rates**<br>Associated Tax rates


## Listing tax categories

> How to fetch a list of tax categories:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_categories' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5abbc5eb-21b8-42b9-b6e1-12499dcb657b",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-09-29T09:38:29+00:00",
        "updated_at": "2021-09-29T09:38:29+00:00",
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=5abbc5eb-21b8-42b9-b6e1-12499dcb657b&filter[owner_type]=TaxCategory"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


### HTTP Request

`GET /api/boomerang/tax_categories`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-09-29T09:38:05Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`default` | **Boolean**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`tax_rates`






## Fetching a tax category

> How to fetch a tax categories with it's tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/f85e00d9-24bd-45fd-8d78-59d3172f78ba?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f85e00d9-24bd-45fd-8d78-59d3172f78ba",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-09-29T09:38:29+00:00",
      "updated_at": "2021-09-29T09:38:29+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=f85e00d9-24bd-45fd-8d78-59d3172f78ba&filter[owner_type]=TaxCategory"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "ea8804e0-8cb1-4b8b-8d09-30ae8ceda12d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ea8804e0-8cb1-4b8b-8d09-30ae8ceda12d",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-09-29T09:38:29+00:00",
        "updated_at": "2021-09-29T09:38:29+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "f85e00d9-24bd-45fd-8d78-59d3172f78ba",
        "owner_type": "TaxCategory"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/f85e00d9-24bd-45fd-8d78-59d3172f78ba"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


### HTTP Request

`GET /api/boomerang/tax_categories/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`tax_rates`






## Creating a tax category

> How to create a tax category with tax rates:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/tax_categories' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "tax_categories",
        "attributes": {
          "name": "Sales Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 21
            }
          ]
        }
      },
      "include": "tax_rates"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3f4ed13d-c107-4781-980e-0b889b430e6d",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-09-29T09:38:29+00:00",
      "updated_at": "2021-09-29T09:38:29+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "1f961cdd-76c4-4c13-afd1-5b53ae0a3399"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1f961cdd-76c4-4c13-afd1-5b53ae0a3399",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-09-29T09:38:29+00:00",
        "updated_at": "2021-09-29T09:38:29+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "3f4ed13d-c107-4781-980e-0b889b430e6d",
        "owner_type": "TaxCategory"
      },
      "relationships": {
        "owner": {
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

`POST /api/boomerang/tax_categories`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the tax category
`data[attributes][default]` | **Boolean**<br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`
`data[attributes][tax_rates_attributes][]` | **Array**<br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Updating a tax category

> How to update a tax category with tax rates:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/35088854-dd3d-4c47-9f0d-3324529557bb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "35088854-dd3d-4c47-9f0d-3324529557bb",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "e22f08a1-abe4-46fb-b6f4-c85bbd1a35d0",
              "_destroy": true
            }
          ]
        }
      },
      "include": "tax_rates"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "35088854-dd3d-4c47-9f0d-3324529557bb",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-09-29T09:38:30+00:00",
      "updated_at": "2021-09-29T09:38:30+00:00",
      "name": "State Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "7300b4c7-2ff8-48b4-8f3f-579ecd145b56"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7300b4c7-2ff8-48b4-8f3f-579ecd145b56",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-09-29T09:38:30+00:00",
        "updated_at": "2021-09-29T09:38:30+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "35088854-dd3d-4c47-9f0d-3324529557bb",
        "owner_type": "TaxCategory"
      },
      "relationships": {
        "owner": {
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

`PUT /api/boomerang/tax_categories/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the tax category
`data[attributes][default]` | **Boolean**<br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`
`data[attributes][tax_rates_attributes][]` | **Array**<br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Deleting a tax category

> How to delete a tax category with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/d1c4cc8d-e33c-43c0-ae66-a4fa8cc1ca3e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```


### HTTP Request

`DELETE /api/boomerang/tax_categories/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`


### Includes

This request does not accept any includes