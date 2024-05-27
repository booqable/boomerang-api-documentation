# Tax categories

You can create different tax categories and assign them according to the tax requirements of a product. The tax rates in the category are charged over a product when it's added to an order. An order's total tax rate is the sum of all product taxes on that order.

## Endpoints
`DELETE /api/boomerang/tax_categories/{id}`

`POST /api/boomerang/tax_categories`

`GET /api/boomerang/tax_categories/{id}`

`GET /api/boomerang/tax_categories`

`PUT /api/boomerang/tax_categories/{id}`

## Fields
Every tax category has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether tax category is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the tax category was archived
`name` | **String** <br>Name of the tax category
`default` | **Boolean** <br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`
`tax_rates_attributes` | **Array** `writeonly`<br>The tax rates to associate


## Relationships
Tax categories have the following relationships:

Name | Description
-- | --
`tax_rates` | **Tax rates** `readonly`<br>Associated Tax rates


## Deleting a tax category



> How to delete a tax category with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/624e60d8-e157-43b1-86c3-7c3cd1806d1b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "624e60d8-e157-43b1-86c3-7c3cd1806d1b",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-05-27T09:30:03.619672+00:00",
      "updated_at": "2024-05-27T09:30:03.670276+00:00",
      "archived": true,
      "archived_at": "2024-05-27T09:30:03.670276+00:00",
      "name": "Sales Tax (Deleted)",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=624e60d8-e157-43b1-86c3-7c3cd1806d1b&filter[owner_type]=tax_categories"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/tax_categories/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_categories]=created_at,updated_at,archived`


### Includes

This request does not accept any includes
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
    "id": "33482b70-7b9b-4164-b5dd-46227b5c2ad4",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-05-27T09:30:04.411357+00:00",
      "updated_at": "2024-05-27T09:30:04.421253+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "28bb77a5-3173-439e-bbec-f4c57aef7aab"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "28bb77a5-3173-439e-bbec-f4c57aef7aab",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-05-27T09:30:04.416061+00:00",
        "updated_at": "2024-05-27T09:30:04.416061+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "33482b70-7b9b-4164-b5dd-46227b5c2ad4",
        "owner_type": "tax_categories"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_categories]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the tax category
`data[attributes][default]` | **Boolean** <br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`
`data[attributes][tax_rates_attributes][]` | **Array** <br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Fetching a tax category



> How to fetch a tax categories with it's tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/497124bc-4031-407d-b8a2-299897b5d0ae?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "497124bc-4031-407d-b8a2-299897b5d0ae",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-05-27T09:30:05.139600+00:00",
      "updated_at": "2024-05-27T09:30:05.150062+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=497124bc-4031-407d-b8a2-299897b5d0ae&filter[owner_type]=tax_categories"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "34be84cb-f596-44d5-b211-dcc8e305a73c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "34be84cb-f596-44d5-b211-dcc8e305a73c",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-05-27T09:30:05.144147+00:00",
        "updated_at": "2024-05-27T09:30:05.144147+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "497124bc-4031-407d-b8a2-299897b5d0ae",
        "owner_type": "tax_categories"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/497124bc-4031-407d-b8a2-299897b5d0ae"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_categories]=created_at,updated_at,archived`


### Includes

This request accepts the following includes:

`tax_rates`






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
      "id": "2d7ecce6-38b4-4e66-8c1b-230e7571ac7d",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-05-27T09:30:05.904322+00:00",
        "updated_at": "2024-05-27T09:30:05.916112+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=2d7ecce6-38b4-4e66-8c1b-230e7571ac7d&filter[owner_type]=tax_categories"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_categories]=created_at,updated_at,archived`
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
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`default` | **Boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`tax_rates`






## Updating a tax category



> How to update a tax category with tax rates:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/eca83720-fe9e-4455-9b97-11acd037d159' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "eca83720-fe9e-4455-9b97-11acd037d159",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "83a6ad52-b62c-4572-ae6c-cf5d4f5fa4bb",
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
    "id": "eca83720-fe9e-4455-9b97-11acd037d159",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-05-27T09:30:06.592302+00:00",
      "updated_at": "2024-05-27T09:30:06.688160+00:00",
      "archived": false,
      "archived_at": null,
      "name": "State Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "97dab323-1b15-4b5b-8f95-1b77dbef18cf"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "97dab323-1b15-4b5b-8f95-1b77dbef18cf",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-05-27T09:30:06.681555+00:00",
        "updated_at": "2024-05-27T09:30:06.681555+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "eca83720-fe9e-4455-9b97-11acd037d159",
        "owner_type": "tax_categories"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_categories]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the tax category
`data[attributes][default]` | **Boolean** <br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`
`data[attributes][tax_rates_attributes][]` | **Array** <br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`





