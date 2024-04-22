# Tax categories

You can create different tax categories and assign them according to the tax requirements of a product. The tax rates in the category are charged over a product when it's added to an order. An order's total tax rate is the sum of all product taxes on that order.

## Endpoints
`GET /api/boomerang/tax_categories`

`POST /api/boomerang/tax_categories`

`DELETE /api/boomerang/tax_categories/{id}`

`PUT /api/boomerang/tax_categories/{id}`

`GET /api/boomerang/tax_categories/{id}`

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
      "id": "026d552f-d3db-420a-8af9-04e6fbbba898",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-04-22T09:24:53+00:00",
        "updated_at": "2024-04-22T09:24:53+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=026d552f-d3db-420a-8af9-04e6fbbba898&filter[owner_type]=tax_categories"
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
    "id": "b21fe517-ca40-4e38-8a62-fe9ae0f9e1c9",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-04-22T09:24:54+00:00",
      "updated_at": "2024-04-22T09:24:54+00:00",
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
            "id": "3ed29cb8-1432-45f6-97ea-156798e913e1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3ed29cb8-1432-45f6-97ea-156798e913e1",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-04-22T09:24:54+00:00",
        "updated_at": "2024-04-22T09:24:54+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "b21fe517-ca40-4e38-8a62-fe9ae0f9e1c9",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/d87eddf3-0ba2-49a1-b510-f876ce29b2a4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d87eddf3-0ba2-49a1-b510-f876ce29b2a4",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-04-22T09:24:55+00:00",
      "updated_at": "2024-04-22T09:24:55+00:00",
      "archived": true,
      "archived_at": "2024-04-22T09:24:55+00:00",
      "name": "Sales Tax (Deleted)",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=d87eddf3-0ba2-49a1-b510-f876ce29b2a4&filter[owner_type]=tax_categories"
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
## Updating a tax category



> How to update a tax category with tax rates:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/d079862a-d443-468d-9f9c-28c7178f078f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d079862a-d443-468d-9f9c-28c7178f078f",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "fd16c908-4d88-4ffa-9dd4-7ad9814af36e",
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
    "id": "d079862a-d443-468d-9f9c-28c7178f078f",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-04-22T09:24:55+00:00",
      "updated_at": "2024-04-22T09:24:55+00:00",
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
            "id": "1b175b5a-c5b7-44f7-91b3-88b42605dc12"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1b175b5a-c5b7-44f7-91b3-88b42605dc12",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-04-22T09:24:55+00:00",
        "updated_at": "2024-04-22T09:24:55+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "d079862a-d443-468d-9f9c-28c7178f078f",
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






## Fetching a tax category



> How to fetch a tax categories with it's tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/51d355f2-a2ff-4763-acaa-4a3030286bb0?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "51d355f2-a2ff-4763-acaa-4a3030286bb0",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-04-22T09:24:56+00:00",
      "updated_at": "2024-04-22T09:24:56+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=51d355f2-a2ff-4763-acaa-4a3030286bb0&filter[owner_type]=tax_categories"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "ec878aaf-6a69-4e68-9338-f92eaa3604b4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ec878aaf-6a69-4e68-9338-f92eaa3604b4",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-04-22T09:24:56+00:00",
        "updated_at": "2024-04-22T09:24:56+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "51d355f2-a2ff-4763-acaa-4a3030286bb0",
        "owner_type": "tax_categories"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/51d355f2-a2ff-4763-acaa-4a3030286bb0"
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





