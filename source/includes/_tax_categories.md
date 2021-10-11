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
      "id": "e0860d0e-3fc5-4b91-ab6e-855d8c2db0ed",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-10-11T12:48:32+00:00",
        "updated_at": "2021-10-11T12:48:32+00:00",
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=e0860d0e-3fc5-4b91-ab6e-855d8c2db0ed&filter[owner_type]=TaxCategory"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-11T12:48:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/cf21c2fb-d450-4422-8ebb-419c446bed64?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cf21c2fb-d450-4422-8ebb-419c446bed64",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-10-11T12:48:32+00:00",
      "updated_at": "2021-10-11T12:48:32+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=cf21c2fb-d450-4422-8ebb-419c446bed64&filter[owner_type]=TaxCategory"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "7ef4d965-2230-496f-b896-c84accc16fea"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7ef4d965-2230-496f-b896-c84accc16fea",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-10-11T12:48:32+00:00",
        "updated_at": "2021-10-11T12:48:32+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "cf21c2fb-d450-4422-8ebb-419c446bed64",
        "owner_type": "TaxCategory"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/cf21c2fb-d450-4422-8ebb-419c446bed64"
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
    "id": "4f4ae84e-badb-476b-9892-bec6ae287ada",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-10-11T12:48:32+00:00",
      "updated_at": "2021-10-11T12:48:32+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "63ed0868-6376-48a7-8cba-f5d0b8cc1092"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "63ed0868-6376-48a7-8cba-f5d0b8cc1092",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-10-11T12:48:32+00:00",
        "updated_at": "2021-10-11T12:48:32+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "4f4ae84e-badb-476b-9892-bec6ae287ada",
        "owner_type": "TaxCategory"
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/0bb1f474-9584-4fd8-a167-7f576f51b938' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0bb1f474-9584-4fd8-a167-7f576f51b938",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "49cb1724-fccd-49ac-843a-ff10fbfece90",
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
    "id": "0bb1f474-9584-4fd8-a167-7f576f51b938",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-10-11T12:48:32+00:00",
      "updated_at": "2021-10-11T12:48:32+00:00",
      "name": "State Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "1c86d3fa-bd2b-449a-acb4-2de1d7f6cc8a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1c86d3fa-bd2b-449a-acb4-2de1d7f6cc8a",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-10-11T12:48:32+00:00",
        "updated_at": "2021-10-11T12:48:32+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "0bb1f474-9584-4fd8-a167-7f576f51b938",
        "owner_type": "TaxCategory"
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/77ce08be-ddb8-49af-83a1-f4c7fbec6d9b' \
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