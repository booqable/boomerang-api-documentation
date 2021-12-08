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
      "id": "d1f7b9d9-1622-4753-8099-35441cf8b657",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-12-08T12:35:39+00:00",
        "updated_at": "2021-12-08T12:35:39+00:00",
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=d1f7b9d9-1622-4753-8099-35441cf8b657&filter[owner_type]=tax_categories"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T12:33:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/a61c24fd-6389-491b-b1e3-c0fecaac645c?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a61c24fd-6389-491b-b1e3-c0fecaac645c",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-12-08T12:35:40+00:00",
      "updated_at": "2021-12-08T12:35:40+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "links": {
          "related": "api/boomerang/tax_rates?filter[owner_id]=a61c24fd-6389-491b-b1e3-c0fecaac645c&filter[owner_type]=tax_categories"
        },
        "data": [
          {
            "type": "tax_rates",
            "id": "af779dcb-bbad-4df2-8c0c-d9696010b35c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "af779dcb-bbad-4df2-8c0c-d9696010b35c",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-12-08T12:35:40+00:00",
        "updated_at": "2021-12-08T12:35:40+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "a61c24fd-6389-491b-b1e3-c0fecaac645c",
        "owner_type": "tax_categories"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_categories/a61c24fd-6389-491b-b1e3-c0fecaac645c"
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
    "id": "89156faf-e78a-40b1-b9c7-ede10a491f8c",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-12-08T12:35:40+00:00",
      "updated_at": "2021-12-08T12:35:40+00:00",
      "name": "Sales Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "de8fb45b-d0df-4ae4-8364-66e1598e7dd0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "de8fb45b-d0df-4ae4-8364-66e1598e7dd0",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-12-08T12:35:40+00:00",
        "updated_at": "2021-12-08T12:35:40+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "89156faf-e78a-40b1-b9c7-ede10a491f8c",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/6abc2b96-5bfc-457e-a3c6-e9c697ab7ade' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6abc2b96-5bfc-457e-a3c6-e9c697ab7ade",
        "type": "tax_categories",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "29be7fb4-fee6-40f3-a384-aa6e4c24a0c8",
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
    "id": "6abc2b96-5bfc-457e-a3c6-e9c697ab7ade",
    "type": "tax_categories",
    "attributes": {
      "created_at": "2021-12-08T12:35:40+00:00",
      "updated_at": "2021-12-08T12:35:40+00:00",
      "name": "State Tax",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "7cd023b6-6a24-477f-af30-983269944403"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7cd023b6-6a24-477f-af30-983269944403",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-12-08T12:35:40+00:00",
        "updated_at": "2021-12-08T12:35:40+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "6abc2b96-5bfc-457e-a3c6-e9c697ab7ade",
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
    --url 'https://example.booqable.com/api/boomerang/tax_categories/31336c49-4e58-479d-ab06-c0fccfc08cdc' \
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