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
`tax_rates` | **[Tax rates](#tax-rates)** <br>Associated Tax rates


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
      "id": "360883bb-c908-4b22-b458-92ee8ecc14ec",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-12-02T13:04:48.545599+00:00",
        "updated_at": "2024-12-02T13:04:48.548867+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/15dbc2a7-19eb-4384-92c2-a6b1f3ac96a3?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "15dbc2a7-19eb-4384-92c2-a6b1f3ac96a3",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-12-02T13:04:48.062558+00:00",
      "updated_at": "2024-12-02T13:04:48.065928+00:00",
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
            "id": "bf6e112b-6861-41a8-ac3c-5648de40a6c6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bf6e112b-6861-41a8-ac3c-5648de40a6c6",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-12-02T13:04:48.064336+00:00",
        "updated_at": "2024-12-02T13:04:48.064336+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "15dbc2a7-19eb-4384-92c2-a6b1f3ac96a3",
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
    "id": "0f283b69-33b1-45cf-afa1-f20c8295cfd8",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-12-02T13:04:46.486721+00:00",
      "updated_at": "2024-12-02T13:04:46.490350+00:00",
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
            "id": "8007bb84-18aa-44a1-ba1b-5789746fcbab"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8007bb84-18aa-44a1-ba1b-5789746fcbab",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-12-02T13:04:46.488612+00:00",
        "updated_at": "2024-12-02T13:04:46.488612+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "0f283b69-33b1-45cf-afa1-f20c8295cfd8",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/80cdfe74-60f4-4094-8a41-1ac6be0e56c1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "80cdfe74-60f4-4094-8a41-1ac6be0e56c1",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "4c56e0d5-0db2-43da-a8a9-426350f3c355",
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
    "id": "80cdfe74-60f4-4094-8a41-1ac6be0e56c1",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-12-02T13:04:47.529560+00:00",
      "updated_at": "2024-12-02T13:04:47.570598+00:00",
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
            "id": "968dd69f-378d-4761-afca-9c9d9b38b111"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "968dd69f-378d-4761-afca-9c9d9b38b111",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-12-02T13:04:47.569098+00:00",
        "updated_at": "2024-12-02T13:04:47.569098+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "80cdfe74-60f4-4094-8a41-1ac6be0e56c1",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/6aa5a8bd-43bc-4c0d-9b54-9b197e5c0faa' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6aa5a8bd-43bc-4c0d-9b54-9b197e5c0faa",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-12-02T13:04:47.019174+00:00",
      "updated_at": "2024-12-02T13:04:47.040289+00:00",
      "archived": true,
      "archived_at": "2024-12-02T13:04:47.040289+00:00",
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