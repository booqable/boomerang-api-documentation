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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=6de2d92b-efcf-4231-b59c-7bd61ae47fa2' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "403e7acb-b361-4c3c-b796-470060ee2f19",
      "type": "bundle_items",
      "attributes": {
        "quantity": "2",
        "discount_percentage": 15,
        "position": 1,
        "bundle_id": "6de2d92b-efcf-4231-b59c-7bd61ae47fa2",
        "product_group_id": "9d39d4b9-d475-4083-b91c-aad9024fbfc0",
        "product_id": "4c7440ef-ac37-4bba-b65e-7c9e8bdc33f5"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/6de2d92b-efcf-4231-b59c-7bd61ae47fa2"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/9d39d4b9-d475-4083-b91c-aad9024fbfc0"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/4c7440ef-ac37-4bba-b65e-7c9e8bdc33f5"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=6de2d92b-efcf-4231-b59c-7bd61ae47fa2&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=6de2d92b-efcf-4231-b59c-7bd61ae47fa2&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=6de2d92b-efcf-4231-b59c-7bd61ae47fa2&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-08T09:21:28Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/4862e923-93d9-4bdc-980f-bd2d05008f7a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4862e923-93d9-4bdc-980f-bd2d05008f7a",
    "type": "bundle_items",
    "attributes": {
      "quantity": "2",
      "discount_percentage": 15,
      "position": 1,
      "bundle_id": "6c7b5a22-9a78-4d10-af7e-7af3855db98d",
      "product_group_id": "c5e2f938-6642-4d04-955b-8b3f9618e991",
      "product_id": "84a78311-9112-4f50-a070-6977fab9a604"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/6c7b5a22-9a78-4d10-af7e-7af3855db98d"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/c5e2f938-6642-4d04-955b-8b3f9618e991"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/84a78311-9112-4f50-a070-6977fab9a604"
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
          "bundle_id": "40d9bfd8-604f-4be2-95a4-d070da23ee7d",
          "product_group_id": "61fb6d1c-3796-4cc1-9194-51c1e57fe893",
          "product_id": "9d15aacd-e59b-4c54-b1aa-ad038f7993df",
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
    "id": "d25108ba-13ce-4a42-a3cf-542dc306a045",
    "type": "bundle_items",
    "attributes": {
      "quantity": "2",
      "discount_percentage": 15,
      "position": 2,
      "bundle_id": "40d9bfd8-604f-4be2-95a4-d070da23ee7d",
      "product_group_id": "61fb6d1c-3796-4cc1-9194-51c1e57fe893",
      "product_id": "9d15aacd-e59b-4c54-b1aa-ad038f7993df"
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
    "self": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=40d9bfd8-604f-4be2-95a4-d070da23ee7d&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=61fb6d1c-3796-4cc1-9194-51c1e57fe893&data%5Battributes%5D%5Bproduct_id%5D=9d15aacd-e59b-4c54-b1aa-ad038f7993df&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=40d9bfd8-604f-4be2-95a4-d070da23ee7d&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=61fb6d1c-3796-4cc1-9194-51c1e57fe893&data%5Battributes%5D%5Bproduct_id%5D=9d15aacd-e59b-4c54-b1aa-ad038f7993df&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=40d9bfd8-604f-4be2-95a4-d070da23ee7d&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=61fb6d1c-3796-4cc1-9194-51c1e57fe893&data%5Battributes%5D%5Bproduct_id%5D=9d15aacd-e59b-4c54-b1aa-ad038f7993df&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/76518bf5-f34d-427c-be7c-a5fea9dde5c1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "76518bf5-f34d-427c-be7c-a5fea9dde5c1",
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
    "id": "76518bf5-f34d-427c-be7c-a5fea9dde5c1",
    "type": "bundle_items",
    "attributes": {
      "quantity": "3",
      "discount_percentage": 20,
      "position": 1,
      "bundle_id": "1c2f6821-1f32-44cc-9618-6b41c7b0b867",
      "product_group_id": "e2964e9a-a982-4718-9adc-f5710e5cd806",
      "product_id": "23b1c7c5-3186-4d5d-91db-83f1b763e7de"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/6de58a69-1fe7-4aee-a576-d18ad95c5e47' \
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