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
Tax categories have the following relationships:

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
      "id": "4a5c3579-f337-4174-867f-f7da321a11ba",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-10-08T10:53:41+00:00",
        "updated_at": "2021-10-08T10:53:41+00:00",
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=4a5c3579-f337-4174-867f-f7da321a11ba&filter[owner_type]=TaxCategory"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-08T10:53:39Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/99a7dbcb-ea5f-43ee-a8c5-a28a145e0302?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "99a7dbcb-ea5f-43ee-a8c5-a28a145e0302",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-10-08T10:53:42+00:00",
      "updated_at": "2021-10-08T10:53:42+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=99a7dbcb-ea5f-43ee-a8c5-a28a145e0302&filter[owner_type]=TaxCategory"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "9e01149e-3042-46e5-91ef-196381b34738"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9e01149e-3042-46e5-91ef-196381b34738",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-10-08T10:53:42+00:00",
        "updated_at": "2021-10-08T10:53:42+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "99a7dbcb-ea5f-43ee-a8c5-a28a145e0302",
        "owner_type": "TaxCategory"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/99a7dbcb-ea5f-43ee-a8c5-a28a145e0302"
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
    "id": "05692c6d-3a8d-4ac8-b879-aaf1e89b604e",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-10-08T10:53:43+00:00",
      "updated_at": "2021-10-08T10:53:43+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "b8c166cc-d49e-47b8-b19f-f91410373d74"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b8c166cc-d49e-47b8-b19f-f91410373d74",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-10-08T10:53:43+00:00",
        "updated_at": "2021-10-08T10:53:43+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "05692c6d-3a8d-4ac8-b879-aaf1e89b604e",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/516eb10f-b493-4136-ae49-b26b326bb753' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "516eb10f-b493-4136-ae49-b26b326bb753",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "86262d12-f5c2-4026-91a6-d02160d7492c",
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
    "id": "516eb10f-b493-4136-ae49-b26b326bb753",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-10-08T10:53:44+00:00",
      "updated_at": "2021-10-08T10:53:44+00:00",
      "name": "State Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "dcd24e69-6056-433f-b8db-4afb18d929e5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dcd24e69-6056-433f-b8db-4afb18d929e5",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-10-08T10:53:44+00:00",
        "updated_at": "2021-10-08T10:53:44+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "516eb10f-b493-4136-ae49-b26b326bb753",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/4c5106a0-5c20-4dbb-a2cc-4d2c71a88f5b' \
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