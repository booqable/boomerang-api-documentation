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
      "id": "eb0a843c-1bf4-46ac-af7c-22e60529405f",
      "created_at": "2021-08-19T12:09:19+00:00",
      "updated_at": "2021-08-19T12:09:19+00:00",
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-08-19T12:09:15Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/be9fc1b4-a515-4781-a4fa-bf319daa80c0?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "be9fc1b4-a515-4781-a4fa-bf319daa80c0",
    "created_at": "2021-08-19T12:09:20+00:00",
    "updated_at": "2021-08-19T12:09:20+00:00",
    "name": "Sales Tax",
    "default": false,
    "tax_rates": [
      {
        "id": "5ebb795f-2130-44f5-83ad-7072758ae69c",
        "created_at": "2021-08-19T12:09:20+00:00",
        "updated_at": "2021-08-19T12:09:20+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "be9fc1b4-a515-4781-a4fa-bf319daa80c0",
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
                "temp-id": "eb11d240-b819-4e39-9168-26655ffdc266",
                "type": "tax_rates",
                "method": "create"
              }
            ]
          }
        }
      },
      "included": [
        {
          "temp-id": "eb11d240-b819-4e39-9168-26655ffdc266",
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
    "id": "e36c25e6-65f6-4304-8794-dc2d1f768212",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-08-19T12:09:20+00:00",
      "updated_at": "2021-08-19T12:09:20+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "e3d1900d-d21b-4fa4-b7d1-cc23efb2b6f0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e3d1900d-d21b-4fa4-b7d1-cc23efb2b6f0",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-08-19T12:09:20+00:00",
        "updated_at": "2021-08-19T12:09:20+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "e36c25e6-65f6-4304-8794-dc2d1f768212",
        "owner_type": "TaxCategory"
      },
      "relationships": {
        "owner": {
          "meta": {
            "included": false
          }
        }
      },
      "temp-id": "eb11d240-b819-4e39-9168-26655ffdc266"
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
`data[attributes][tax_rates_attributes[]]` | **Array**<br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Updating a tax category

> How to update a tax category with tax rates:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/39152002-6d53-43bc-9448-bfd447719145' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "39152002-6d53-43bc-9448-bfd447719145",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax"
        },
        "relationships": {
          "tax_rates": {
            "data": [
              {
                "temp-id": "bf7c015c-695b-44d5-88db-c5175b8a85e4",
                "type": "tax_rates",
                "method": "create"
              },
              {
                "id": "7a3bdd30-2a71-47a8-be3f-16e6056349a2",
                "type": "tax_rates",
                "method": "destroy"
              }
            ]
          }
        }
      },
      "included": [
        {
          "temp-id": "bf7c015c-695b-44d5-88db-c5175b8a85e4",
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
    "id": "39152002-6d53-43bc-9448-bfd447719145",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-08-19T12:09:21+00:00",
      "updated_at": "2021-08-19T12:09:21+00:00",
      "name": "State Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "e6b88e40-4038-41c8-8a31-06f4e61b1255"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e6b88e40-4038-41c8-8a31-06f4e61b1255",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-08-19T12:09:21+00:00",
        "updated_at": "2021-08-19T12:09:21+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "39152002-6d53-43bc-9448-bfd447719145",
        "owner_type": "TaxCategory"
      },
      "relationships": {
        "owner": {
          "meta": {
            "included": false
          }
        }
      },
      "temp-id": "bf7c015c-695b-44d5-88db-c5175b8a85e4"
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
`data[attributes][tax_rates_attributes[]]` | **Array**<br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Deleting a tax category

> How to delete a tax category with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_categories/f94de3c1-e982-44c6-b6e6-d123de99dc3d' \
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