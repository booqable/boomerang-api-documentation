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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=6a2bf1eb-2bac-44ba-a9f8-aa25f1d266b1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5304d875-02a4-48d7-acf1-e79c0bbba6bf",
      "type": "bundle_items",
      "attributes": {
        "quantity": "2",
        "discount_percentage": 15,
        "position": 1,
        "bundle_id": "6a2bf1eb-2bac-44ba-a9f8-aa25f1d266b1",
        "product_group_id": "3e91cf7b-97b6-42a7-9b6f-ec0d703223f8",
        "product_id": "a8222210-b703-49d3-924a-faf8c574e524"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/6a2bf1eb-2bac-44ba-a9f8-aa25f1d266b1"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/3e91cf7b-97b6-42a7-9b6f-ec0d703223f8"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/a8222210-b703-49d3-924a-faf8c574e524"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=6a2bf1eb-2bac-44ba-a9f8-aa25f1d266b1&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=6a2bf1eb-2bac-44ba-a9f8-aa25f1d266b1&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=6a2bf1eb-2bac-44ba-a9f8-aa25f1d266b1&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-08T12:27:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/229baed3-7ad3-4394-bcb7-c2bbc106aaf5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "229baed3-7ad3-4394-bcb7-c2bbc106aaf5",
    "type": "bundle_items",
    "attributes": {
      "quantity": "2",
      "discount_percentage": 15,
      "position": 1,
      "bundle_id": "64eb71a7-a8bb-4759-913a-678ada076177",
      "product_group_id": "f20b15f4-749b-4e00-badb-39b6b350c6c4",
      "product_id": "74a0838b-20aa-477a-9ffc-4a1f40068bd1"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/64eb71a7-a8bb-4759-913a-678ada076177"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/f20b15f4-749b-4e00-badb-39b6b350c6c4"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/74a0838b-20aa-477a-9ffc-4a1f40068bd1"
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
          "bundle_id": "9633be8b-e121-44b9-bce6-de0fb13dcb1d",
          "product_group_id": "cacfad86-e8b9-43ff-926b-e463dc47fc84",
          "product_id": "e17e8188-0eb2-4795-9be0-bd567a60dabf",
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
    "id": "437b8125-169e-4255-99b9-f5b819229bca",
    "type": "bundle_items",
    "attributes": {
      "quantity": "2",
      "discount_percentage": 15,
      "position": 2,
      "bundle_id": "9633be8b-e121-44b9-bce6-de0fb13dcb1d",
      "product_group_id": "cacfad86-e8b9-43ff-926b-e463dc47fc84",
      "product_id": "e17e8188-0eb2-4795-9be0-bd567a60dabf"
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
    "self": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=9633be8b-e121-44b9-bce6-de0fb13dcb1d&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=cacfad86-e8b9-43ff-926b-e463dc47fc84&data%5Battributes%5D%5Bproduct_id%5D=e17e8188-0eb2-4795-9be0-bd567a60dabf&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=9633be8b-e121-44b9-bce6-de0fb13dcb1d&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=cacfad86-e8b9-43ff-926b-e463dc47fc84&data%5Battributes%5D%5Bproduct_id%5D=e17e8188-0eb2-4795-9be0-bd567a60dabf&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=9633be8b-e121-44b9-bce6-de0fb13dcb1d&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=cacfad86-e8b9-43ff-926b-e463dc47fc84&data%5Battributes%5D%5Bproduct_id%5D=e17e8188-0eb2-4795-9be0-bd567a60dabf&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/704840ae-ebfe-4820-afca-31e3c89c0fe4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "704840ae-ebfe-4820-afca-31e3c89c0fe4",
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
    "id": "704840ae-ebfe-4820-afca-31e3c89c0fe4",
    "type": "bundle_items",
    "attributes": {
      "quantity": "3",
      "discount_percentage": 20,
      "position": 1,
      "bundle_id": "08ab6f0e-d460-434b-b79c-a8197ae6f446",
      "product_group_id": "22282bf5-b547-4cc7-aa9c-9150ddad5ed2",
      "product_id": "35bd429b-3770-415f-b583-af45c6166d22"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/c1265155-f81b-4d5a-aa89-6282f1364448' \
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