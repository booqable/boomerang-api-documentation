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
`name` | **String**<br>Name of the tax category
`default` | **Boolean**<br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`
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
      "id": "e1a837c5-1743-4a7f-b369-23c4d4a90031",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2022-05-05T09:15:07+00:00",
        "updated_at": "2022-05-05T09:15:07+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=e1a837c5-1743-4a7f-b369-23c4d4a90031&filter[owner_type]=tax_categories"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-05T09:12:15Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`default` | **Boolean**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`tax_rates`






## Fetching a tax category



> How to fetch a tax categories with it's tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/550ab01b-5151-4568-aabc-6c50752ee55f?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "550ab01b-5151-4568-aabc-6c50752ee55f",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2022-05-05T09:15:07+00:00",
      "updated_at": "2022-05-05T09:15:07+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=550ab01b-5151-4568-aabc-6c50752ee55f&filter[owner_type]=tax_categories"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "2ddb6f66-bcf6-4e2b-b2d5-7476ef80d901"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2ddb6f66-bcf6-4e2b-b2d5-7476ef80d901",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-05-05T09:15:07+00:00",
        "updated_at": "2022-05-05T09:15:07+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "550ab01b-5151-4568-aabc-6c50752ee55f",
        "owner_type": "tax_categories"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/550ab01b-5151-4568-aabc-6c50752ee55f"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`


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
    "id": "c6a5e0f3-83e3-49a8-a61d-b2a0e4c8666c",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2022-05-05T09:15:08+00:00",
      "updated_at": "2022-05-05T09:15:08+00:00",
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
            "id": "4ba4290f-c7d2-42fa-8885-4e3cc5bd1fbf"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4ba4290f-c7d2-42fa-8885-4e3cc5bd1fbf",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-05-05T09:15:08+00:00",
        "updated_at": "2022-05-05T09:15:08+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "c6a5e0f3-83e3-49a8-a61d-b2a0e4c8666c",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the tax category
`data[attributes][default]` | **Boolean**<br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`
`data[attributes][tax_rates_attributes][]` | **Array**<br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Updating a tax category



> How to update a tax category with tax rates:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/340d3560-2a07-4d03-9af8-b2d101e615e0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "340d3560-2a07-4d03-9af8-b2d101e615e0",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "c8b58aea-7366-45c4-8d13-858eb14151d5",
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
    "id": "340d3560-2a07-4d03-9af8-b2d101e615e0",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2022-05-05T09:15:08+00:00",
      "updated_at": "2022-05-05T09:15:08+00:00",
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
            "id": "685a1edc-c196-4501-81f2-05b26ac11952"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "685a1edc-c196-4501-81f2-05b26ac11952",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-05-05T09:15:08+00:00",
        "updated_at": "2022-05-05T09:15:08+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "340d3560-2a07-4d03-9af8-b2d101e615e0",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the tax category
`data[attributes][default]` | **Boolean**<br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`
`data[attributes][tax_rates_attributes][]` | **Array**<br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Deleting a tax category



> How to delete a tax category with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/36a72690-6146-47db-8dae-143b2df2a924' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_categories]=id,created_at,updated_at`


### Includes

This request does not accept any includes