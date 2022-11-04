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
      "id": "7e458feb-3bfb-4db4-badc-35fbd07f7407",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2022-11-04T15:26:54+00:00",
        "updated_at": "2022-11-04T15:26:54+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=7e458feb-3bfb-4db4-badc-35fbd07f7407&filter[owner_type]=tax_categories"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-04T15:22:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/751fd114-3f72-4a9f-88c6-e52deb9a1d08?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "751fd114-3f72-4a9f-88c6-e52deb9a1d08",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2022-11-04T15:26:54+00:00",
      "updated_at": "2022-11-04T15:26:54+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=751fd114-3f72-4a9f-88c6-e52deb9a1d08&filter[owner_type]=tax_categories"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "cdb41d88-63ca-4375-8e02-5f09117b7d90"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cdb41d88-63ca-4375-8e02-5f09117b7d90",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-11-04T15:26:54+00:00",
        "updated_at": "2022-11-04T15:26:54+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "751fd114-3f72-4a9f-88c6-e52deb9a1d08",
        "owner_type": "tax_categories"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/751fd114-3f72-4a9f-88c6-e52deb9a1d08"
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
    "id": "f65d1909-7cd9-43a9-b4d6-bc8a26f49b97",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2022-11-04T15:26:55+00:00",
      "updated_at": "2022-11-04T15:26:55+00:00",
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
            "id": "977d4895-c2c0-45d8-9c5b-b579b862ef44"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "977d4895-c2c0-45d8-9c5b-b579b862ef44",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-11-04T15:26:55+00:00",
        "updated_at": "2022-11-04T15:26:55+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "f65d1909-7cd9-43a9-b4d6-bc8a26f49b97",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/f5baa74e-468c-4386-b105-5fb54536cc4f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f5baa74e-468c-4386-b105-5fb54536cc4f",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "b77dd5ca-c509-4ec7-aa7f-bc634b0939d0",
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
    "id": "f5baa74e-468c-4386-b105-5fb54536cc4f",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2022-11-04T15:26:55+00:00",
      "updated_at": "2022-11-04T15:26:55+00:00",
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
            "id": "7aabd84e-4df8-4221-a023-de24139c8a4c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7aabd84e-4df8-4221-a023-de24139c8a4c",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-11-04T15:26:55+00:00",
        "updated_at": "2022-11-04T15:26:55+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "f5baa74e-468c-4386-b105-5fb54536cc4f",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/20761131-b37a-4698-a796-1f89c9ff5d7a' \
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