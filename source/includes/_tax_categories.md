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
Tax categories have the following relationships:

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
      "id": "52e56339-0b57-419a-8e2a-93fe0784ee75",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-11-15T07:46:50+00:00",
        "updated_at": "2021-11-15T07:46:50+00:00",
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=52e56339-0b57-419a-8e2a-93fe0784ee75&filter[owner_type]=TaxCategory"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/tax_categories?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/tax_categories?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/tax_categories?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-15T07:45:26Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/d5f1e302-093d-4cc3-aeb8-e238f83b8b25?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d5f1e302-093d-4cc3-aeb8-e238f83b8b25",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-11-15T07:46:51+00:00",
      "updated_at": "2021-11-15T07:46:51+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=d5f1e302-093d-4cc3-aeb8-e238f83b8b25&filter[owner_type]=TaxCategory"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "bb1f71e1-75ac-4b22-b790-4e25717bc509"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bb1f71e1-75ac-4b22-b790-4e25717bc509",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-11-15T07:46:51+00:00",
        "updated_at": "2021-11-15T07:46:51+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "d5f1e302-093d-4cc3-aeb8-e238f83b8b25",
        "owner_type": "TaxCategory"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/d5f1e302-093d-4cc3-aeb8-e238f83b8b25"
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
    "id": "923f4237-bc10-4b9c-8094-d94ae4f37f37",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-11-15T07:46:52+00:00",
      "updated_at": "2021-11-15T07:46:52+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "3ef6ad59-1917-44b2-9f2a-f927236270be"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3ef6ad59-1917-44b2-9f2a-f927236270be",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-11-15T07:46:52+00:00",
        "updated_at": "2021-11-15T07:46:52+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "923f4237-bc10-4b9c-8094-d94ae4f37f37",
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
  "links": {
    "self": "api/boomerang/tax_categories?data%5Battributes%5D%5Bname%5D=Sales+Tax&data%5Battributes%5D%5Btax_rates_attributes%5D%5B%5D%5Bname%5D=VAT&data%5Battributes%5D%5Btax_rates_attributes%5D%5B%5D%5Bvalue%5D=21&data%5Btype%5D=tax_categories&include=tax_rates&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/tax_categories?data%5Battributes%5D%5Bname%5D=Sales+Tax&data%5Battributes%5D%5Btax_rates_attributes%5D%5B%5D%5Bname%5D=VAT&data%5Battributes%5D%5Btax_rates_attributes%5D%5B%5D%5Bvalue%5D=21&data%5Btype%5D=tax_categories&include=tax_rates&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/tax_categories?data%5Battributes%5D%5Bname%5D=Sales+Tax&data%5Battributes%5D%5Btax_rates_attributes%5D%5B%5D%5Bname%5D=VAT&data%5Battributes%5D%5Btax_rates_attributes%5D%5B%5D%5Bvalue%5D=21&data%5Btype%5D=tax_categories&include=tax_rates&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/43a52828-c1b5-4dda-aef4-c5948291b186' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "43a52828-c1b5-4dda-aef4-c5948291b186",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "af8c840e-b465-4b08-8436-76a0d29d362a",
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
    "id": "43a52828-c1b5-4dda-aef4-c5948291b186",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-11-15T07:46:52+00:00",
      "updated_at": "2021-11-15T07:46:52+00:00",
      "name": "State Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "abc582fb-2c9e-42b7-8d77-f4a9dfcd8b3b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "abc582fb-2c9e-42b7-8d77-f4a9dfcd8b3b",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-11-15T07:46:52+00:00",
        "updated_at": "2021-11-15T07:46:52+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "43a52828-c1b5-4dda-aef4-c5948291b186",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/034efe42-3a8f-4679-a04e-5dc9229ce391' \
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