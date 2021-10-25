# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the user needs to specify a variation when adding this bundle to an order.

## Endpoints
`GET /api/boomerang/bundle_items`

`GET /api/boomerang/bundle_items/{id}`

`POST /api/boomerang/bundle_items`

`PUT /api/boomerang/bundle_items/{id}`

`DELETE /api/boomerang/bundle_items/{id}`

## Fields
Every bundle item has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`quantity` | **String**<br>The quantity of the item
`discount_percentage` | **Integer**<br>The discount percentage for this product when rented out in a bundle
`position` | **Integer**<br>Position of the product in bundle list
`bundle_id` | **Uuid**<br>The associated Bundle
`product_group_id` | **Uuid**<br>The associated Product group
`product_id` | **Uuid** `nullable`<br>The associated Product


## Relationships
Bundle items have the following relationships:

Name | Description
- | -
`bundle` | **Bundles** `readonly`<br>Associated Bundle
`product_group` | **Product groups**<br>Associated Product group
`product` | **Products** `readonly`<br>Associated Product


## Listing bundle items



> How to fetch a list of bundle items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=1056c02e-002b-4b92-b212-22d69b6862fa' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8021abc7-0a05-44bb-9b33-a7a0ef6ecb76",
      "type": "bundle_items",
      "attributes": {
        "quantity": "2",
        "discount_percentage": 15,
        "position": 1,
        "bundle_id": "1056c02e-002b-4b92-b212-22d69b6862fa",
        "product_group_id": "4f54669c-fbaf-4bb6-a007-7fb75043b9ae",
        "product_id": "3a2a3e5f-ec14-4b39-b261-4dc11631adbf"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/1056c02e-002b-4b92-b212-22d69b6862fa"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/4f54669c-fbaf-4bb6-a007-7fb75043b9ae"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/3a2a3e5f-ec14-4b39-b261-4dc11631adbf"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=1056c02e-002b-4b92-b212-22d69b6862fa&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=1056c02e-002b-4b92-b212-22d69b6862fa&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=1056c02e-002b-4b92-b212-22d69b6862fa&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/bundle_items`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-25T12:33:46Z`
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
`quantity` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`discount_percentage` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`position` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`bundle_id` | **Uuid**<br>`eq`, `not_eq`
`product_group_id` | **Uuid**<br>`eq`, `not_eq`
`product_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`bundle`


`product`


`product_group`






## Fetching a bundle item



> How to fetch a bundle item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/7648524b-bd7c-42f3-ac0a-6863aad6295a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7648524b-bd7c-42f3-ac0a-6863aad6295a",
    "type": "bundle_items",
    "attributes": {
      "quantity": "2",
      "discount_percentage": 15,
      "position": 1,
      "bundle_id": "4dceff76-c289-452a-8618-a244d25bbd3e",
      "product_group_id": "73d35044-d8fd-4a2c-b59f-c05238245b00",
      "product_id": "97ae6355-be22-4773-ac68-d45c881863a9"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/4dceff76-c289-452a-8618-a244d25bbd3e"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/73d35044-d8fd-4a2c-b59f-c05238245b00"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/97ae6355-be22-4773-ac68-d45c881863a9"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/bundle_items/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`bundle`


`product`


`product_group`






## Creating a bundle item



> How to create a bundle item:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bundle_items' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bundle_items",
        "attributes": {
          "bundle_id": "161af7d3-a11b-4bd6-b9c5-720c50295e6e",
          "product_group_id": "caab9272-bc2f-4eb5-a8fd-8eacb9967ab3",
          "product_id": "c9e1d1d5-4e61-44a5-a3b5-07f257d5dcd5",
          "quantity": 2,
          "discount_percentage": 15
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5ff02b93-b310-4031-af38-b7da21ed06dc",
    "type": "bundle_items",
    "attributes": {
      "quantity": "2",
      "discount_percentage": 15,
      "position": 2,
      "bundle_id": "161af7d3-a11b-4bd6-b9c5-720c50295e6e",
      "product_group_id": "caab9272-bc2f-4eb5-a8fd-8eacb9967ab3",
      "product_id": "c9e1d1d5-4e61-44a5-a3b5-07f257d5dcd5"
    },
    "relationships": {
      "bundle": {
        "meta": {
          "included": false
        }
      },
      "product_group": {
        "meta": {
          "included": false
        }
      },
      "product": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=161af7d3-a11b-4bd6-b9c5-720c50295e6e&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=caab9272-bc2f-4eb5-a8fd-8eacb9967ab3&data%5Battributes%5D%5Bproduct_id%5D=c9e1d1d5-4e61-44a5-a3b5-07f257d5dcd5&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=161af7d3-a11b-4bd6-b9c5-720c50295e6e&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=caab9272-bc2f-4eb5-a8fd-8eacb9967ab3&data%5Battributes%5D%5Bproduct_id%5D=c9e1d1d5-4e61-44a5-a3b5-07f257d5dcd5&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=161af7d3-a11b-4bd6-b9c5-720c50295e6e&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=caab9272-bc2f-4eb5-a8fd-8eacb9967ab3&data%5Battributes%5D%5Bproduct_id%5D=c9e1d1d5-4e61-44a5-a3b5-07f257d5dcd5&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/bundle_items`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][quantity]` | **String**<br>The quantity of the item
`data[attributes][discount_percentage]` | **Integer**<br>The discount percentage for this product when rented out in a bundle
`data[attributes][position]` | **Integer**<br>Position of the product in bundle list
`data[attributes][bundle_id]` | **Uuid**<br>The associated Bundle
`data[attributes][product_group_id]` | **Uuid**<br>The associated Product group
`data[attributes][product_id]` | **Uuid**<br>The associated Product


### Includes

This request accepts the following includes:

`bundle`


`product`


`product_group`






## Updating a bundle item



> How to update a bundle item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/ef3a164e-66fe-4178-960b-83d78e408adc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ef3a164e-66fe-4178-960b-83d78e408adc",
        "type": "bundle_items",
        "attributes": {
          "quantity": 3,
          "discount_percentage": 20
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ef3a164e-66fe-4178-960b-83d78e408adc",
    "type": "bundle_items",
    "attributes": {
      "quantity": "3",
      "discount_percentage": 20,
      "position": 1,
      "bundle_id": "fa5077aa-aa02-4b60-8b0b-c25923cfd9a8",
      "product_group_id": "c8b9f5ce-8937-4654-9b04-8944cc911b5b",
      "product_id": "24d349c8-cc3b-42ca-ab3e-07e3cb06a60d"
    },
    "relationships": {
      "bundle": {
        "meta": {
          "included": false
        }
      },
      "product_group": {
        "meta": {
          "included": false
        }
      },
      "product": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/bundle_items/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][quantity]` | **String**<br>The quantity of the item
`data[attributes][discount_percentage]` | **Integer**<br>The discount percentage for this product when rented out in a bundle
`data[attributes][position]` | **Integer**<br>Position of the product in bundle list
`data[attributes][bundle_id]` | **Uuid**<br>The associated Bundle
`data[attributes][product_group_id]` | **Uuid**<br>The associated Product group
`data[attributes][product_id]` | **Uuid**<br>The associated Product


### Includes

This request accepts the following includes:

`bundle`


`product`


`product_group`






## Deleting a bundle item



> How to delete a bundle item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/0b45e86b-16fd-4e2a-8325-5fa61fe49455' \
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

`DELETE /api/boomerang/bundle_items/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`


### Includes

This request does not accept any includes