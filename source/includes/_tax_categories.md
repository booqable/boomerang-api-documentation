# Tax categories

You can create different tax categories and assign them according to the tax requirements of a product. The tax rates in the category are charged over a product when it's added to an order. An order's total tax rate is the sum of all product taxes on that order.

## Endpoints
`GET /api/boomerang/tax_categories`

`POST /api/boomerang/tax_categories`

`DELETE /api/boomerang/tax_categories/{id}`

`GET /api/boomerang/tax_categories/{id}`

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
      "id": "9f6db36b-e7ce-47b7-a650-a1f82415b377",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-05-06T09:25:20+00:00",
        "updated_at": "2024-05-06T09:25:20+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=9f6db36b-e7ce-47b7-a650-a1f82415b377&filter[owner_type]=tax_categories"
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
    "id": "6a021c32-f484-4b52-a5d9-40d1546d132b",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-05-06T09:25:20+00:00",
      "updated_at": "2024-05-06T09:25:20+00:00",
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
            "id": "4e18b1e9-61d3-4add-9dfe-0e0648da67c8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4e18b1e9-61d3-4add-9dfe-0e0648da67c8",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-05-06T09:25:20+00:00",
        "updated_at": "2024-05-06T09:25:20+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "6a021c32-f484-4b52-a5d9-40d1546d132b",
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






## Deleting a tax category



> How to delete a tax category with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/80d4c5bc-9baa-4326-a63a-f0f0a4e2d77b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "80d4c5bc-9baa-4326-a63a-f0f0a4e2d77b",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-05-06T09:25:21+00:00",
      "updated_at": "2024-05-06T09:25:21+00:00",
      "archived": true,
      "archived_at": "2024-05-06T09:25:21+00:00",
      "name": "Sales Tax (Deleted)",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=80d4c5bc-9baa-4326-a63a-f0f0a4e2d77b&filter[owner_type]=tax_categories"
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
## Fetching a tax category



> How to fetch a tax categories with it's tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/db108d09-111f-4edc-b565-69a461d3b04e?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "db108d09-111f-4edc-b565-69a461d3b04e",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-05-06T09:25:21+00:00",
      "updated_at": "2024-05-06T09:25:21+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=db108d09-111f-4edc-b565-69a461d3b04e&filter[owner_type]=tax_categories"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "237d7ec2-769e-4082-a291-735462528e3e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "237d7ec2-769e-4082-a291-735462528e3e",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-05-06T09:25:21+00:00",
        "updated_at": "2024-05-06T09:25:21+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "db108d09-111f-4edc-b565-69a461d3b04e",
        "owner_type": "tax_categories"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/db108d09-111f-4edc-b565-69a461d3b04e"
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






## Updating a tax category



> How to update a tax category with tax rates:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/bcf80bf0-f344-4f0c-98f6-89005ff81427' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bcf80bf0-f344-4f0c-98f6-89005ff81427",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "1c4b5cc2-8909-4325-a523-456b14caad2f",
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
    "id": "bcf80bf0-f344-4f0c-98f6-89005ff81427",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-05-06T09:25:22+00:00",
      "updated_at": "2024-05-06T09:25:22+00:00",
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
            "id": "30b5fdb2-3cd2-435a-9a19-e882bbe92595"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "30b5fdb2-3cd2-435a-9a19-e882bbe92595",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-05-06T09:25:22+00:00",
        "updated_at": "2024-05-06T09:25:22+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "bcf80bf0-f344-4f0c-98f6-89005ff81427",
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





