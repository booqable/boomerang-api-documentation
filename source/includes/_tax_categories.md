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
      "id": "4bca51ae-46e9-4df3-901d-e4b90bd70c9d",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-08-19T09:27:05.552280+00:00",
        "updated_at": "2024-08-19T09:27:05.555418+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/172f950e-bc93-49ff-9143-f44d90481039?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "172f950e-bc93-49ff-9143-f44d90481039",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-08-19T09:27:05.030871+00:00",
      "updated_at": "2024-08-19T09:27:05.034616+00:00",
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
            "id": "3ca2a866-3e8a-4a89-8a6d-ae63fafd35f6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3ca2a866-3e8a-4a89-8a6d-ae63fafd35f6",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-08-19T09:27:05.032793+00:00",
        "updated_at": "2024-08-19T09:27:05.032793+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "172f950e-bc93-49ff-9143-f44d90481039",
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
    "id": "7e404fe3-7884-4cea-a90a-7d8cc2d138a7",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-08-19T09:27:04.461043+00:00",
      "updated_at": "2024-08-19T09:27:04.464851+00:00",
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
            "id": "bd4f8218-c735-4b9e-828a-77efed6d32b5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bd4f8218-c735-4b9e-828a-77efed6d32b5",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-08-19T09:27:04.463107+00:00",
        "updated_at": "2024-08-19T09:27:04.463107+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "7e404fe3-7884-4cea-a90a-7d8cc2d138a7",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/e7e36288-7c48-4a6d-baec-71d7885bbf89' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e7e36288-7c48-4a6d-baec-71d7885bbf89",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "0e82452c-4afc-4624-bc7e-bec84376cfd1",
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
    "id": "e7e36288-7c48-4a6d-baec-71d7885bbf89",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-08-19T09:27:03.869381+00:00",
      "updated_at": "2024-08-19T09:27:03.911375+00:00",
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
            "id": "b12a5f28-fb90-465c-91bf-dcd3b551cebd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b12a5f28-fb90-465c-91bf-dcd3b551cebd",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-08-19T09:27:03.909974+00:00",
        "updated_at": "2024-08-19T09:27:03.909974+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "e7e36288-7c48-4a6d-baec-71d7885bbf89",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/9c801490-509d-477b-8dcb-3073ac675c89' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9c801490-509d-477b-8dcb-3073ac675c89",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-08-19T09:27:03.362679+00:00",
      "updated_at": "2024-08-19T09:27:03.383976+00:00",
      "archived": true,
      "archived_at": "2024-08-19T09:27:03.383976+00:00",
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