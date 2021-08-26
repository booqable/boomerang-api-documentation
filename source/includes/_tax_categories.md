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
`name` | **String**<br>Name of the tax category
`default` | **Boolean**<br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`
`tax_rates_attributes` | **Array** `writeonly`<br>The tax rates to associate


## Relationships
A tax categories has the following relationships:

Name | Description
- | -
`tax_rates` | **Tax rates**<br>Associated Tax rates


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
      "id": "bebe7427-2b5e-4166-8dc9-1420385d4488",
      "created_at": "2021-08-26T11:11:29+00:00",
      "updated_at": "2021-08-26T11:11:29+00:00",
      "name": "Sales Tax",
      "default": false
    }
  ]
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-08-26T11:11:15Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/533c99a1-16d1-4f5f-8eb1-7c83d6ec4e99?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "533c99a1-16d1-4f5f-8eb1-7c83d6ec4e99",
    "created_at": "2021-08-26T11:11:29+00:00",
    "updated_at": "2021-08-26T11:11:29+00:00",
    "name": "Sales Tax",
    "default": false,
    "tax_rates": [
      {
        "id": "45229d99-e40c-4d6e-b12b-8dc200294069",
        "created_at": "2021-08-26T11:11:29+00:00",
        "updated_at": "2021-08-26T11:11:29+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "533c99a1-16d1-4f5f-8eb1-7c83d6ec4e99",
        "owner_type": "TaxCategory"
      }
    ]
  }
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
          "name": "Sales Tax"
        },
        "relationships": {
          "tax_rates": {
            "data": [
              {
                "temp-id": "d583b02b-e069-422c-bed6-d5c3bce1a1c1",
                "type": "tax_rates",
                "method": "create"
              }
            ]
          }
        }
      },
      "included": [
        {
          "temp-id": "d583b02b-e069-422c-bed6-d5c3bce1a1c1",
          "type": "tax_rates",
          "attributes": {
            "name": "VAT",
            "value": 21
          }
        }
      ],
      "include": "tax_rates"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a821783b-7d70-48a4-9f4c-110338c9843f",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-08-26T11:11:29+00:00",
      "updated_at": "2021-08-26T11:11:29+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "64b3fb57-83c3-4145-b85e-b7d3095c8fdb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "64b3fb57-83c3-4145-b85e-b7d3095c8fdb",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-08-26T11:11:29+00:00",
        "updated_at": "2021-08-26T11:11:29+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "a821783b-7d70-48a4-9f4c-110338c9843f",
        "owner_type": "TaxCategory"
      },
      "relationships": {
        "owner": {
          "meta": {
            "included": false
          }
        }
      },
      "temp-id": "d583b02b-e069-422c-bed6-d5c3bce1a1c1"
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/bb9a6439-9102-43bc-8f44-b30dd61d7e7d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bb9a6439-9102-43bc-8f44-b30dd61d7e7d",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax"
        },
        "relationships": {
          "tax_rates": {
            "data": [
              {
                "temp-id": "0051a375-00d8-4fb0-87cf-c83cf59f59e2",
                "type": "tax_rates",
                "method": "create"
              },
              {
                "id": "8eeff6e0-0b99-4859-864b-65c11565a64d",
                "type": "tax_rates",
                "method": "destroy"
              }
            ]
          }
        }
      },
      "included": [
        {
          "temp-id": "0051a375-00d8-4fb0-87cf-c83cf59f59e2",
          "type": "tax_rates",
          "attributes": {
            "name": "VAT",
            "value": 9
          }
        }
      ],
      "include": "tax_rates"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bb9a6439-9102-43bc-8f44-b30dd61d7e7d",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-08-26T11:11:30+00:00",
      "updated_at": "2021-08-26T11:11:30+00:00",
      "name": "State Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "c225ee6d-40cb-471c-82cd-0f3a3ec99469"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c225ee6d-40cb-471c-82cd-0f3a3ec99469",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-08-26T11:11:30+00:00",
        "updated_at": "2021-08-26T11:11:30+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "bb9a6439-9102-43bc-8f44-b30dd61d7e7d",
        "owner_type": "TaxCategory"
      },
      "relationships": {
        "owner": {
          "meta": {
            "included": false
          }
        }
      },
      "temp-id": "0051a375-00d8-4fb0-87cf-c83cf59f59e2"
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/39c07765-8ac2-4484-a162-a52d06c8c312' \
    --header 'content-type: application/json' \
    --data '{}'
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