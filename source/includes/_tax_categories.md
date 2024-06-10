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
      "id": "f1468cd0-a35b-4f58-b202-ee1951a73323",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-06-10T09:24:05.772659+00:00",
        "updated_at": "2024-06-10T09:24:05.779752+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=f1468cd0-a35b-4f58-b202-ee1951a73323&filter[owner_type]=tax_categories"
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/4233eb1c-fc06-4d6c-9816-30f5efa89a3d?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4233eb1c-fc06-4d6c-9816-30f5efa89a3d",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-06-10T09:24:05.012446+00:00",
      "updated_at": "2024-06-10T09:24:05.025379+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=4233eb1c-fc06-4d6c-9816-30f5efa89a3d&filter[owner_type]=tax_categories"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "5d24a042-ead6-45db-99f4-c3bd604b355d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5d24a042-ead6-45db-99f4-c3bd604b355d",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-06-10T09:24:05.019927+00:00",
        "updated_at": "2024-06-10T09:24:05.019927+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "4233eb1c-fc06-4d6c-9816-30f5efa89a3d",
        "owner_type": "tax_categories"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/4233eb1c-fc06-4d6c-9816-30f5efa89a3d"
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
    "id": "563f560d-b9d5-4e1c-8e15-1f70111743c5",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-06-10T09:24:03.337800+00:00",
      "updated_at": "2024-06-10T09:24:03.344934+00:00",
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
            "id": "78bc6cff-336c-4c20-8ce5-e4f0bed36658"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "78bc6cff-336c-4c20-8ce5-e4f0bed36658",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-06-10T09:24:03.341383+00:00",
        "updated_at": "2024-06-10T09:24:03.341383+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "563f560d-b9d5-4e1c-8e15-1f70111743c5",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/926d72ed-a46f-4ea8-9e2f-a43e0a93e3c9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "926d72ed-a46f-4ea8-9e2f-a43e0a93e3c9",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "fc96004b-69d9-4718-aa59-f1e77859d17d",
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
    "id": "926d72ed-a46f-4ea8-9e2f-a43e0a93e3c9",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-06-10T09:24:04.242867+00:00",
      "updated_at": "2024-06-10T09:24:04.331765+00:00",
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
            "id": "9954d284-e81f-446e-a536-cd938ed92aba"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9954d284-e81f-446e-a536-cd938ed92aba",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-06-10T09:24:04.327584+00:00",
        "updated_at": "2024-06-10T09:24:04.327584+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "926d72ed-a46f-4ea8-9e2f-a43e0a93e3c9",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/dcfa3ca8-930b-49b2-af42-a5f407729fe6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dcfa3ca8-930b-49b2-af42-a5f407729fe6",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2024-06-10T09:24:06.447779+00:00",
      "updated_at": "2024-06-10T09:24:06.486126+00:00",
      "archived": true,
      "archived_at": "2024-06-10T09:24:06.486126+00:00",
      "name": "Sales Tax (Deleted)",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=dcfa3ca8-930b-49b2-af42-a5f407729fe6&filter[owner_type]=tax_categories"
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