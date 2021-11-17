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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=5b0ee42b-0665-4d0d-b5ad-eab48b10517c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "93d61ea0-2dc9-4f7c-9f8d-98b22371b3b7",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2021-11-17T09:29:52+00:00",
        "updated_at": "2021-11-17T09:29:52+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 1,
        "bundle_id": "5b0ee42b-0665-4d0d-b5ad-eab48b10517c",
        "product_group_id": "976ea2b8-4c6e-4514-9f7f-1a8e7615aad5",
        "product_id": "c514874e-0ca9-46de-9d8d-8cfb72e0d841"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/5b0ee42b-0665-4d0d-b5ad-eab48b10517c"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/976ea2b8-4c6e-4514-9f7f-1a8e7615aad5"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/c514874e-0ca9-46de-9d8d-8cfb72e0d841"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=5b0ee42b-0665-4d0d-b5ad-eab48b10517c&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=5b0ee42b-0665-4d0d-b5ad-eab48b10517c&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=5b0ee42b-0665-4d0d-b5ad-eab48b10517c&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-17T09:29:36Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/2167a854-c2e3-4c22-a840-c248777b467c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2167a854-c2e3-4c22-a840-c248777b467c",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-11-17T09:29:52+00:00",
      "updated_at": "2021-11-17T09:29:52+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 1,
      "bundle_id": "619eeefe-0f3f-45d6-9e59-b93ee5ae51d8",
      "product_group_id": "a7881f72-2519-4f71-83fe-0e4314a7403d",
      "product_id": "ca881222-b56d-44ad-8930-2844c33eb910"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/619eeefe-0f3f-45d6-9e59-b93ee5ae51d8"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/a7881f72-2519-4f71-83fe-0e4314a7403d"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/ca881222-b56d-44ad-8930-2844c33eb910"
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
          "bundle_id": "33746684-26af-4f82-8c3d-3cd698fe61b9",
          "product_group_id": "7cecd5ef-03fa-4aed-9b4a-bb55d7d8a8f7",
          "product_id": "6f79f969-eb69-4285-998f-957ab2839a3c",
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
    "id": "2d6e218f-ea86-4603-bc1f-0d2ec02aa750",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-11-17T09:29:53+00:00",
      "updated_at": "2021-11-17T09:29:53+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 2,
      "bundle_id": "33746684-26af-4f82-8c3d-3cd698fe61b9",
      "product_group_id": "7cecd5ef-03fa-4aed-9b4a-bb55d7d8a8f7",
      "product_id": "6f79f969-eb69-4285-998f-957ab2839a3c"
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
    "self": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=33746684-26af-4f82-8c3d-3cd698fe61b9&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=7cecd5ef-03fa-4aed-9b4a-bb55d7d8a8f7&data%5Battributes%5D%5Bproduct_id%5D=6f79f969-eb69-4285-998f-957ab2839a3c&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=33746684-26af-4f82-8c3d-3cd698fe61b9&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=7cecd5ef-03fa-4aed-9b4a-bb55d7d8a8f7&data%5Battributes%5D%5Bproduct_id%5D=6f79f969-eb69-4285-998f-957ab2839a3c&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=33746684-26af-4f82-8c3d-3cd698fe61b9&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=7cecd5ef-03fa-4aed-9b4a-bb55d7d8a8f7&data%5Battributes%5D%5Bproduct_id%5D=6f79f969-eb69-4285-998f-957ab2839a3c&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/b19a58f0-ad24-4af5-90f6-add5c402fa1d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b19a58f0-ad24-4af5-90f6-add5c402fa1d",
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
    "id": "b19a58f0-ad24-4af5-90f6-add5c402fa1d",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-11-17T09:29:53+00:00",
      "updated_at": "2021-11-17T09:29:53+00:00",
      "quantity": "3",
      "discount_percentage": 20,
      "position": 1,
      "bundle_id": "04d2e33f-db26-441a-aa99-d0f4721a3316",
      "product_group_id": "be3d6f5c-2e65-4da8-a48b-9a261bb01c65",
      "product_id": "573391d0-403a-41cf-9cf2-a0a40563a148"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/ad7bc8e3-fae7-49f6-94b6-5911020a9fda' \
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