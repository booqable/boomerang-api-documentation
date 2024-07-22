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
      "id": "4c58e243-083e-48cc-8343-bcafc80a4b76",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-07-22T09:29:24.037584+00:00",
        "updated_at": "2024-07-22T09:29:24.044100+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/be9d1126-d1c1-43f1-a114-39854fcd3b14?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "be9d1126-d1c1-43f1-a114-39854fcd3b14",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-07-22T09:29:21.653349+00:00",
      "updated_at": "2024-07-22T09:29:21.664841+00:00",
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
            "id": "2be98a41-313b-4f0e-b3f7-2b4edb2f1678"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2be98a41-313b-4f0e-b3f7-2b4edb2f1678",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-07-22T09:29:21.658955+00:00",
        "updated_at": "2024-07-22T09:29:21.658955+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "be9d1126-d1c1-43f1-a114-39854fcd3b14",
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
    "id": "a63c45a9-8d63-431f-99f2-8124cecbff6b",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-07-22T09:29:22.800576+00:00",
      "updated_at": "2024-07-22T09:29:22.808039+00:00",
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
            "id": "a0c4f4b4-58e8-48db-a475-161c8d0d52de"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a0c4f4b4-58e8-48db-a475-161c8d0d52de",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-07-22T09:29:22.804320+00:00",
        "updated_at": "2024-07-22T09:29:22.804320+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "a63c45a9-8d63-431f-99f2-8124cecbff6b",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/9c3e5ee8-1281-48f7-bca5-f81458466fbb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9c3e5ee8-1281-48f7-bca5-f81458466fbb",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "2e410e22-fcae-4dd5-9916-978cf7884eea",
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
    "id": "9c3e5ee8-1281-48f7-bca5-f81458466fbb",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-07-22T09:29:23.418470+00:00",
      "updated_at": "2024-07-22T09:29:23.523054+00:00",
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
            "id": "49d5483f-6fca-4289-9ff8-b8c56d703ce3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "49d5483f-6fca-4289-9ff8-b8c56d703ce3",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-07-22T09:29:23.519178+00:00",
        "updated_at": "2024-07-22T09:29:23.519178+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "9c3e5ee8-1281-48f7-bca5-f81458466fbb",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/f82e95f2-26c5-4a37-bc8e-493ca36c8d32' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f82e95f2-26c5-4a37-bc8e-493ca36c8d32",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-07-22T09:29:24.576786+00:00",
      "updated_at": "2024-07-22T09:29:24.622324+00:00",
      "archived": true,
      "archived_at": "2024-07-22T09:29:24.622324+00:00",
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