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
      "id": "80188612-a069-471a-88be-5692b4903fbc",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-12-08T11:26:33+00:00",
        "updated_at": "2021-12-08T11:26:33+00:00",
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=80188612-a069-471a-88be-5692b4903fbc&filter[owner_type]=tax_categories"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T11:24:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/b9a597c5-6fe2-4487-85d2-570e95f79c07?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b9a597c5-6fe2-4487-85d2-570e95f79c07",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-12-08T11:26:33+00:00",
      "updated_at": "2021-12-08T11:26:33+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=b9a597c5-6fe2-4487-85d2-570e95f79c07&filter[owner_type]=tax_categories"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "5fcc4fb6-ee8f-4209-97ff-351395b73e59"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5fcc4fb6-ee8f-4209-97ff-351395b73e59",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-12-08T11:26:33+00:00",
        "updated_at": "2021-12-08T11:26:33+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "b9a597c5-6fe2-4487-85d2-570e95f79c07",
        "owner_type": "tax_categories"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/b9a597c5-6fe2-4487-85d2-570e95f79c07"
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
    "id": "99729abf-59ae-4535-84b3-d159bdac61ca",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-12-08T11:26:33+00:00",
      "updated_at": "2021-12-08T11:26:33+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "880a1c9f-67c3-4fa3-bd89-49616e9da3c5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "880a1c9f-67c3-4fa3-bd89-49616e9da3c5",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-12-08T11:26:33+00:00",
        "updated_at": "2021-12-08T11:26:33+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "99729abf-59ae-4535-84b3-d159bdac61ca",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/2f8079aa-d3b2-4e03-94ef-4d8800bb883e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2f8079aa-d3b2-4e03-94ef-4d8800bb883e",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "6968014d-4556-4d52-b5f6-28bea7fcf9a2",
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
    "id": "2f8079aa-d3b2-4e03-94ef-4d8800bb883e",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-12-08T11:26:33+00:00",
      "updated_at": "2021-12-08T11:26:33+00:00",
      "name": "State Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "268ae3ca-2340-4920-8cef-8fc14ea3b0c1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "268ae3ca-2340-4920-8cef-8fc14ea3b0c1",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-12-08T11:26:33+00:00",
        "updated_at": "2021-12-08T11:26:33+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "2f8079aa-d3b2-4e03-94ef-4d8800bb883e",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/364aa2c8-edba-4276-a53b-a65366a32104' \
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