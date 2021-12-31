# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the variation needs to be specified when adding this bundle to an order (see [order bookings](#order-bookings) for more information).

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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=2455b6ea-1188-4d27-8c45-bcb69467b8fc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "05e14bcd-5509-46d3-b1e8-161e1b4593f1",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2021-12-30T11:20:48+00:00",
        "updated_at": "2021-12-30T11:20:48+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 1,
        "bundle_id": "2455b6ea-1188-4d27-8c45-bcb69467b8fc",
        "product_group_id": "1f91d6c5-2dcd-4218-a155-049339e6518a",
        "product_id": "43680995-f168-4a12-bf64-179c1aebdfbe"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/2455b6ea-1188-4d27-8c45-bcb69467b8fc"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/1f91d6c5-2dcd-4218-a155-049339e6518a"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/43680995-f168-4a12-bf64-179c1aebdfbe"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=2455b6ea-1188-4d27-8c45-bcb69467b8fc&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=2455b6ea-1188-4d27-8c45-bcb69467b8fc&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=2455b6ea-1188-4d27-8c45-bcb69467b8fc&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-30T11:20:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/f72d37ca-119b-4afa-abaa-ab322a9ac567' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f72d37ca-119b-4afa-abaa-ab322a9ac567",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-12-30T11:20:48+00:00",
      "updated_at": "2021-12-30T11:20:48+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 1,
      "bundle_id": "b3e2ee37-2fbf-41ab-ae47-34e70135fea2",
      "product_group_id": "7eec430a-0175-48d7-aacb-18973aef183e",
      "product_id": "bd4f00f0-a49c-4c3e-91d2-b3b0ae3d23ec"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/b3e2ee37-2fbf-41ab-ae47-34e70135fea2"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/7eec430a-0175-48d7-aacb-18973aef183e"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/bd4f00f0-a49c-4c3e-91d2-b3b0ae3d23ec"
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
          "bundle_id": "8f201906-5164-4c91-97d4-4e1417313be0",
          "product_group_id": "bf5a2907-c35a-4920-adc0-80314a04b24a",
          "product_id": "3c8d8532-089d-426f-a893-7136b37840ed",
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
    "id": "2fb49802-68bc-436c-9963-28d884ce6edc",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-12-30T11:20:49+00:00",
      "updated_at": "2021-12-30T11:20:49+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 2,
      "bundle_id": "8f201906-5164-4c91-97d4-4e1417313be0",
      "product_group_id": "bf5a2907-c35a-4920-adc0-80314a04b24a",
      "product_id": "3c8d8532-089d-426f-a893-7136b37840ed"
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
    "self": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=8f201906-5164-4c91-97d4-4e1417313be0&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=bf5a2907-c35a-4920-adc0-80314a04b24a&data%5Battributes%5D%5Bproduct_id%5D=3c8d8532-089d-426f-a893-7136b37840ed&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=8f201906-5164-4c91-97d4-4e1417313be0&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=bf5a2907-c35a-4920-adc0-80314a04b24a&data%5Battributes%5D%5Bproduct_id%5D=3c8d8532-089d-426f-a893-7136b37840ed&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=8f201906-5164-4c91-97d4-4e1417313be0&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=bf5a2907-c35a-4920-adc0-80314a04b24a&data%5Battributes%5D%5Bproduct_id%5D=3c8d8532-089d-426f-a893-7136b37840ed&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/94d12c00-d1b7-49cc-abca-a0a5107a2a23' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "94d12c00-d1b7-49cc-abca-a0a5107a2a23",
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
    "id": "94d12c00-d1b7-49cc-abca-a0a5107a2a23",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-12-30T11:20:50+00:00",
      "updated_at": "2021-12-30T11:20:50+00:00",
      "quantity": "3",
      "discount_percentage": 20,
      "position": 1,
      "bundle_id": "230878bb-2f36-4465-b66d-4d149a324e1a",
      "product_group_id": "48aa75d6-b56b-4a81-9945-d4679d21e7ef",
      "product_id": "f9445ed2-7aea-4e44-b7da-23ca1e913ed6"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/8aa9d2f1-69fa-40c1-ba46-2f1b1282a4a6' \
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