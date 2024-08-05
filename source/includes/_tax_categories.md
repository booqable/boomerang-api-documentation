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
      "id": "febfe683-2a9c-41e2-8b39-ebbe031e418f",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-08-05T09:29:09.246015+00:00",
        "updated_at": "2024-08-05T09:29:09.249996+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/7f9d5e23-4f0e-49f7-8752-3d2eb14cf24a?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7f9d5e23-4f0e-49f7-8752-3d2eb14cf24a",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-08-05T09:29:10.185832+00:00",
      "updated_at": "2024-08-05T09:29:10.188956+00:00",
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
            "id": "f721f3f4-148d-47bc-a4da-6928e8febb5b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f721f3f4-148d-47bc-a4da-6928e8febb5b",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-08-05T09:29:10.187495+00:00",
        "updated_at": "2024-08-05T09:29:10.187495+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "7f9d5e23-4f0e-49f7-8752-3d2eb14cf24a",
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
    "id": "b971bb09-0412-4855-9122-88c4b34827b3",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-08-05T09:29:10.681636+00:00",
      "updated_at": "2024-08-05T09:29:10.684364+00:00",
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
            "id": "c8b3f67a-e86f-4dca-8e37-12651264f4e4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c8b3f67a-e86f-4dca-8e37-12651264f4e4",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-08-05T09:29:10.682979+00:00",
        "updated_at": "2024-08-05T09:29:10.682979+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "b971bb09-0412-4855-9122-88c4b34827b3",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/f0505c3e-0308-4afe-8fa1-9ba97a35624b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f0505c3e-0308-4afe-8fa1-9ba97a35624b",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "49a244f4-506b-4379-be01-0b59cfb64bc9",
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
    "id": "f0505c3e-0308-4afe-8fa1-9ba97a35624b",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-08-05T09:29:08.763020+00:00",
      "updated_at": "2024-08-05T09:29:08.809111+00:00",
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
            "id": "9b8c7281-ac31-41b1-9ff3-cb555642cb4f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9b8c7281-ac31-41b1-9ff3-cb555642cb4f",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-08-05T09:29:08.807665+00:00",
        "updated_at": "2024-08-05T09:29:08.807665+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "f0505c3e-0308-4afe-8fa1-9ba97a35624b",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/b7044dd2-51b0-4232-a30b-84eee5f4ae2b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b7044dd2-51b0-4232-a30b-84eee5f4ae2b",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-08-05T09:29:09.714115+00:00",
      "updated_at": "2024-08-05T09:29:09.733293+00:00",
      "archived": true,
      "archived_at": "2024-08-05T09:29:09.733293+00:00",
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