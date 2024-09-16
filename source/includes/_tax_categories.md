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
      "id": "b02ca36b-c118-4d74-bc4a-1a3d2c0ce1ab",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-09-16T09:23:34.480413+00:00",
        "updated_at": "2024-09-16T09:23:34.487192+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/c11ef6b8-c454-4c01-be13-cf3d938982fb?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c11ef6b8-c454-4c01-be13-cf3d938982fb",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-09-16T09:23:35.026172+00:00",
      "updated_at": "2024-09-16T09:23:35.031793+00:00",
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
            "id": "da5ed05b-e2d4-4e1d-8dac-506e6876e68d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "da5ed05b-e2d4-4e1d-8dac-506e6876e68d",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-09-16T09:23:35.028897+00:00",
        "updated_at": "2024-09-16T09:23:35.028897+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "c11ef6b8-c454-4c01-be13-cf3d938982fb",
        "owner_type": "tax_categories"
      },
      "relationships": {}
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
    "id": "c65f49e9-404a-475d-8d37-a65f4dd00b9a",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-09-16T09:23:35.605639+00:00",
      "updated_at": "2024-09-16T09:23:35.610649+00:00",
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
            "id": "b25b998d-75a5-4b31-a290-a9ef8ee02798"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b25b998d-75a5-4b31-a290-a9ef8ee02798",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-09-16T09:23:35.608424+00:00",
        "updated_at": "2024-09-16T09:23:35.608424+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "c65f49e9-404a-475d-8d37-a65f4dd00b9a",
        "owner_type": "tax_categories"
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/a577970f-54e1-43fa-9c71-3ffa6f6195b3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a577970f-54e1-43fa-9c71-3ffa6f6195b3",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "33fd7fbe-c8f6-4115-897a-ada612acbf65",
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
    "id": "a577970f-54e1-43fa-9c71-3ffa6f6195b3",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-09-16T09:23:36.788577+00:00",
      "updated_at": "2024-09-16T09:23:36.849816+00:00",
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
            "id": "b78fd239-de19-4f3a-92db-fd4bbd46cb36"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b78fd239-de19-4f3a-92db-fd4bbd46cb36",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-09-16T09:23:36.848114+00:00",
        "updated_at": "2024-09-16T09:23:36.848114+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "a577970f-54e1-43fa-9c71-3ffa6f6195b3",
        "owner_type": "tax_categories"
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/75112955-a116-49c3-848d-8924b8d6a4c4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "75112955-a116-49c3-848d-8924b8d6a4c4",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-09-16T09:23:36.129566+00:00",
      "updated_at": "2024-09-16T09:23:36.165900+00:00",
      "archived": true,
      "archived_at": "2024-09-16T09:23:36.165900+00:00",
      "name": "Sales Tax (Deleted)",
      "default": false
    },
    "relationships": {}
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