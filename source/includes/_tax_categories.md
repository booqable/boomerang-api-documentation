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
      "id": "24e2d304-5301-4879-aef4-5123c5925557",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2023-07-10T09:20:47+00:00",
        "updated_at": "2023-07-10T09:20:47+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=24e2d304-5301-4879-aef4-5123c5925557&filter[owner_type]=tax_categories"
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






## Fetching a tax category



> How to fetch a tax categories with it's tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/47940552-1d69-46ee-b148-acfc998d14b3?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "47940552-1d69-46ee-b148-acfc998d14b3",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2023-07-10T09:20:48+00:00",
      "updated_at": "2023-07-10T09:20:48+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=47940552-1d69-46ee-b148-acfc998d14b3&filter[owner_type]=tax_categories"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "70e30af0-df21-4670-ae36-1ca762fb39a4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "70e30af0-df21-4670-ae36-1ca762fb39a4",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-07-10T09:20:48+00:00",
        "updated_at": "2023-07-10T09:20:48+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "47940552-1d69-46ee-b148-acfc998d14b3",
        "owner_type": "tax_categories"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/47940552-1d69-46ee-b148-acfc998d14b3"
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
    "id": "f2b7fd97-237c-4d71-a71b-c78811c54672",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2023-07-10T09:20:48+00:00",
      "updated_at": "2023-07-10T09:20:48+00:00",
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
            "id": "d6edf734-88e5-4824-9040-ba7bece42fa6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d6edf734-88e5-4824-9040-ba7bece42fa6",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-07-10T09:20:48+00:00",
        "updated_at": "2023-07-10T09:20:48+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "f2b7fd97-237c-4d71-a71b-c78811c54672",
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






## Updating a tax category



> How to update a tax category with tax rates:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/a6777ee9-1cba-4d18-80a3-f6e95c0234ea' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a6777ee9-1cba-4d18-80a3-f6e95c0234ea",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "73ede777-50bc-4cf7-8b7a-e6e1cc038dcc",
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
    "id": "a6777ee9-1cba-4d18-80a3-f6e95c0234ea",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2023-07-10T09:20:49+00:00",
      "updated_at": "2023-07-10T09:20:49+00:00",
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
            "id": "26236a95-79f5-4099-a090-7fc58ef0ab65"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "26236a95-79f5-4099-a090-7fc58ef0ab65",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-07-10T09:20:49+00:00",
        "updated_at": "2023-07-10T09:20:49+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "a6777ee9-1cba-4d18-80a3-f6e95c0234ea",
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






## Deleting a tax category



> How to delete a tax category with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/6675a4c6-3d7b-4059-9a5f-a585f0f21394' \
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

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_categories]=created_at,updated_at,archived`


### Includes

This request does not accept any includes