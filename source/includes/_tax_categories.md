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
      "id": "daea94eb-3571-4e28-bfae-0446715edc98",
      "created_at": "2021-08-24T12:40:57+00:00",
      "updated_at": "2021-08-24T12:40:57+00:00",
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-08-24T12:40:42Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/4a6cde37-cc02-4be4-beb8-1b6c84125d22?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4a6cde37-cc02-4be4-beb8-1b6c84125d22",
    "created_at": "2021-08-24T12:40:57+00:00",
    "updated_at": "2021-08-24T12:40:57+00:00",
    "name": "Sales Tax",
    "default": false,
    "tax_rates": [
      {
        "id": "d768ae90-80fb-4135-bcc8-3d5e588ca5af",
        "created_at": "2021-08-24T12:40:57+00:00",
        "updated_at": "2021-08-24T12:40:57+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "4a6cde37-cc02-4be4-beb8-1b6c84125d22",
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
                "temp-id": "b40ffcd1-651d-4981-a5af-c0b7eb0f8f60",
                "type": "tax_rates",
                "method": "create"
              }
            ]
          }
        }
      },
      "included": [
        {
          "temp-id": "b40ffcd1-651d-4981-a5af-c0b7eb0f8f60",
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
    "id": "ae42ca24-79e2-4dce-89fc-5eeee2c80ee6",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-08-24T12:40:57+00:00",
      "updated_at": "2021-08-24T12:40:57+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "ef78352c-ebd8-4398-abbd-b0cb89719eb5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ef78352c-ebd8-4398-abbd-b0cb89719eb5",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-08-24T12:40:57+00:00",
        "updated_at": "2021-08-24T12:40:57+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "ae42ca24-79e2-4dce-89fc-5eeee2c80ee6",
        "owner_type": "TaxCategory"
      },
      "relationships": {
        "owner": {
          "meta": {
            "included": false
          }
        }
      },
      "temp-id": "b40ffcd1-651d-4981-a5af-c0b7eb0f8f60"
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/7d712213-a7d1-407d-8df5-22ee7c5a05ae' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7d712213-a7d1-407d-8df5-22ee7c5a05ae",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax"
        },
        "relationships": {
          "tax_rates": {
            "data": [
              {
                "temp-id": "46dc29bf-c3e2-4eb8-8dde-eafd424e92ac",
                "type": "tax_rates",
                "method": "create"
              },
              {
                "id": "97f71bb8-4737-48f7-af75-11fe3549ac17",
                "type": "tax_rates",
                "method": "destroy"
              }
            ]
          }
        }
      },
      "included": [
        {
          "temp-id": "46dc29bf-c3e2-4eb8-8dde-eafd424e92ac",
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
    "id": "7d712213-a7d1-407d-8df5-22ee7c5a05ae",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-08-24T12:40:57+00:00",
      "updated_at": "2021-08-24T12:40:57+00:00",
      "name": "State Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "399b0191-8038-45c5-9b42-8bb4e44ac59c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "399b0191-8038-45c5-9b42-8bb4e44ac59c",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-08-24T12:40:57+00:00",
        "updated_at": "2021-08-24T12:40:57+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "7d712213-a7d1-407d-8df5-22ee7c5a05ae",
        "owner_type": "TaxCategory"
      },
      "relationships": {
        "owner": {
          "meta": {
            "included": false
          }
        }
      },
      "temp-id": "46dc29bf-c3e2-4eb8-8dde-eafd424e92ac"
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/a853cf07-84c8-4c1a-a52d-70e0e9e6da8b' \
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