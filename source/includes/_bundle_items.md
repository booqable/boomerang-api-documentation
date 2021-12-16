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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=aa36fcef-d99b-4b91-92da-1bf6d143f481' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b4e55943-4f7d-4712-8b1c-b93cd5b7e2e1",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2021-12-16T09:37:58+00:00",
        "updated_at": "2021-12-16T09:37:58+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 1,
        "bundle_id": "aa36fcef-d99b-4b91-92da-1bf6d143f481",
        "product_group_id": "7493fbad-d3c2-42e8-818c-68f21b16895b",
        "product_id": "fd1b0721-1aa3-445d-b699-ed1db8340a9e"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/aa36fcef-d99b-4b91-92da-1bf6d143f481"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/7493fbad-d3c2-42e8-818c-68f21b16895b"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/fd1b0721-1aa3-445d-b699-ed1db8340a9e"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=aa36fcef-d99b-4b91-92da-1bf6d143f481&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=aa36fcef-d99b-4b91-92da-1bf6d143f481&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=aa36fcef-d99b-4b91-92da-1bf6d143f481&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-16T09:37:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/7b941c0a-e703-4e09-8e1e-2a7d1dd8fa1c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7b941c0a-e703-4e09-8e1e-2a7d1dd8fa1c",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-12-16T09:37:58+00:00",
      "updated_at": "2021-12-16T09:37:58+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 1,
      "bundle_id": "562c4a67-a4c5-41a0-bd58-d7cfbbccf2fb",
      "product_group_id": "a90515c1-3440-45e4-977c-0604d49aebbe",
      "product_id": "5633c625-fb6e-4980-801f-236a2525ab66"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/562c4a67-a4c5-41a0-bd58-d7cfbbccf2fb"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/a90515c1-3440-45e4-977c-0604d49aebbe"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/5633c625-fb6e-4980-801f-236a2525ab66"
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
          "bundle_id": "98676810-16a6-4d04-a145-191d67ab5868",
          "product_group_id": "ed009d5f-c7e6-4678-8d18-f4978763f503",
          "product_id": "ec34390b-ac08-4a00-8b91-883629204a43",
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
    "id": "a3f95ba1-8ffb-4665-8740-12f12e840d3d",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-12-16T09:37:59+00:00",
      "updated_at": "2021-12-16T09:37:59+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 2,
      "bundle_id": "98676810-16a6-4d04-a145-191d67ab5868",
      "product_group_id": "ed009d5f-c7e6-4678-8d18-f4978763f503",
      "product_id": "ec34390b-ac08-4a00-8b91-883629204a43"
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
    "self": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=98676810-16a6-4d04-a145-191d67ab5868&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=ed009d5f-c7e6-4678-8d18-f4978763f503&data%5Battributes%5D%5Bproduct_id%5D=ec34390b-ac08-4a00-8b91-883629204a43&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=98676810-16a6-4d04-a145-191d67ab5868&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=ed009d5f-c7e6-4678-8d18-f4978763f503&data%5Battributes%5D%5Bproduct_id%5D=ec34390b-ac08-4a00-8b91-883629204a43&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=98676810-16a6-4d04-a145-191d67ab5868&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=ed009d5f-c7e6-4678-8d18-f4978763f503&data%5Battributes%5D%5Bproduct_id%5D=ec34390b-ac08-4a00-8b91-883629204a43&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/ddfec96d-1014-4962-ac7f-a702881b9acc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ddfec96d-1014-4962-ac7f-a702881b9acc",
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
    "id": "ddfec96d-1014-4962-ac7f-a702881b9acc",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-12-16T09:37:59+00:00",
      "updated_at": "2021-12-16T09:38:00+00:00",
      "quantity": "3",
      "discount_percentage": 20,
      "position": 1,
      "bundle_id": "bc3957ba-ec74-44ab-914b-6fca0843821b",
      "product_group_id": "e3d94a26-c175-4c97-9c68-a3791e909bd6",
      "product_id": "01884b25-ba3b-4127-8805-3681b94028f9"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/261f5936-5d2e-47bf-958d-78a65063cf84' \
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