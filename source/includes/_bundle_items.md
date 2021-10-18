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
`product_id` | **Uuid**<br>The associated Product


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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=f4728b0f-a92d-4ea0-8286-53a6f564281a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2cb789d2-bb4d-4c13-a5fa-dba0a3237c9b",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2021-10-11T12:37:43+00:00",
        "updated_at": "2021-10-11T12:37:43+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 1,
        "bundle_id": "f4728b0f-a92d-4ea0-8286-53a6f564281a",
        "product_group_id": "d448ff90-56a3-4645-9aea-488cd3a0c94c",
        "product_id": "94058c35-280d-4deb-81f7-953f815f3e88"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/f4728b0f-a92d-4ea0-8286-53a6f564281a"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/d448ff90-56a3-4645-9aea-488cd3a0c94c"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/94058c35-280d-4deb-81f7-953f815f3e88"
          }
        }
      }
    }
  ],
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-11T12:37:41Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/792d761e-a44b-476a-b8c0-da16aff05d0c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "792d761e-a44b-476a-b8c0-da16aff05d0c",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-10-11T12:37:44+00:00",
      "updated_at": "2021-10-11T12:37:44+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 1,
      "bundle_id": "9a4da4ef-2da0-45ed-a3d6-47d0d5399d43",
      "product_group_id": "a23b7c47-1c58-45d0-9fb2-b2d8c726f347",
      "product_id": "a9c33650-3a4b-4fb4-92f9-ec44f6c7b401"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/9a4da4ef-2da0-45ed-a3d6-47d0d5399d43"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/a23b7c47-1c58-45d0-9fb2-b2d8c726f347"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/a9c33650-3a4b-4fb4-92f9-ec44f6c7b401"
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
          "bundle_id": "5ab797b6-b6dd-423e-94ba-f83dfbb7c0bb",
          "product_group_id": "44dee602-727a-4c4e-8ca7-9427f81b8a74",
          "product_id": "afff25d1-4bf1-4531-ac9d-f0c4a38fecb2",
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
    "id": "b1e01153-17bd-4fb5-919e-855353c2d107",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-10-11T12:37:45+00:00",
      "updated_at": "2021-10-11T12:37:45+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 2,
      "bundle_id": "5ab797b6-b6dd-423e-94ba-f83dfbb7c0bb",
      "product_group_id": "44dee602-727a-4c4e-8ca7-9427f81b8a74",
      "product_id": "afff25d1-4bf1-4531-ac9d-f0c4a38fecb2"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/36b8b190-cf7a-4912-88b4-f20ef765addf' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "36b8b190-cf7a-4912-88b4-f20ef765addf",
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
    "id": "36b8b190-cf7a-4912-88b4-f20ef765addf",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-10-11T12:37:46+00:00",
      "updated_at": "2021-10-11T12:37:46+00:00",
      "quantity": "3",
      "discount_percentage": 20,
      "position": 1,
      "bundle_id": "5fbe8254-5766-4a52-8c4d-8a9fa4a3ba2d",
      "product_group_id": "c6fdfccc-059f-4aef-ae65-8027501d95f2",
      "product_id": "e46fa80d-aac9-434e-bfbd-4c190602327a"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/d4052a5a-8d7a-403f-aa75-39ec8e0670eb' \
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