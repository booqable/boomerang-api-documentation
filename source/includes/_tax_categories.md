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
`archived` | **Boolean** `readonly`<br>Whether tax category is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the tax category was archived
`name` | **String** <br>Name of the tax category
`default` | **Boolean** <br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`
`tax_rates_attributes` | **Array** `writeonly`<br>The tax rates to associate


## Relationships
Tax categories have the following relationships:

Name | Description
- | -
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
      "id": "87045422-fcd0-465d-bf2d-49ff4e2f7172",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2023-02-20T11:49:59+00:00",
        "updated_at": "2023-02-20T11:49:59+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=87045422-fcd0-465d-bf2d-49ff4e2f7172&filter[owner_type]=tax_categories"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`
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
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`default` | **Boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`tax_rates`






## Fetching a tax category



> How to fetch a tax categories with it's tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/3492c38b-bd6b-489f-b89d-605f9c787071?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3492c38b-bd6b-489f-b89d-605f9c787071",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2023-02-20T11:49:59+00:00",
      "updated_at": "2023-02-20T11:49:59+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=3492c38b-bd6b-489f-b89d-605f9c787071&filter[owner_type]=tax_categories"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "8738c945-fb73-4924-ac06-cb69489a6ab2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8738c945-fb73-4924-ac06-cb69489a6ab2",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-02-20T11:49:59+00:00",
        "updated_at": "2023-02-20T11:49:59+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "3492c38b-bd6b-489f-b89d-605f9c787071",
        "owner_type": "tax_categories"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/3492c38b-bd6b-489f-b89d-605f9c787071"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`


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
    "id": "1e65a5ef-a912-4e38-9600-2b5ce45a3a3b",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2023-02-20T11:49:59+00:00",
      "updated_at": "2023-02-20T11:49:59+00:00",
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
            "id": "b0e60443-0712-4419-a7ef-61e7ddcc1d56"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b0e60443-0712-4419-a7ef-61e7ddcc1d56",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-02-20T11:49:59+00:00",
        "updated_at": "2023-02-20T11:49:59+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "1e65a5ef-a912-4e38-9600-2b5ce45a3a3b",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/6461ccdb-7da6-400c-9bd2-5d77669dd8ed' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6461ccdb-7da6-400c-9bd2-5d77669dd8ed",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "37007f8f-7871-4784-81a7-758a7eb2c5da",
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
    "id": "6461ccdb-7da6-400c-9bd2-5d77669dd8ed",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2023-02-20T11:50:00+00:00",
      "updated_at": "2023-02-20T11:50:00+00:00",
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
            "id": "9c96dda0-e73d-4509-baae-88a1d0e6344e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9c96dda0-e73d-4509-baae-88a1d0e6344e",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-02-20T11:50:00+00:00",
        "updated_at": "2023-02-20T11:50:00+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "6461ccdb-7da6-400c-9bd2-5d77669dd8ed",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/ab5c11c1-f849-4dbd-9bf4-750b1199b0b0' \
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`


### Includes

This request does not accept any includes