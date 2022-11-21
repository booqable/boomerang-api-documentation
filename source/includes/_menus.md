# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus`

`GET /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

`PUT /api/boomerang/menus/{id}`

`DELETE /api/boomerang/menus/{id}`

## Fields
Every menu has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`title` | **String** <br>Name of the menu.
`key` | **String** <br>Key the menu can be referenced by.
`menu_items_attributes` | **Array** `writeonly`<br>Attributes of child menu items to be created or changed.


## Relationships
Menus have the following relationships:

Name | Description
- | -
`menu_items` | **Menu items** `readonly`<br>Associated Menu items


## Listing menus



> How to fetch a list of menus:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0a0fc953-5d17-4f27-8c8b-49845dfc9900",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-21T10:29:50+00:00",
        "updated_at": "2022-11-21T10:29:50+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=0a0fc953-5d17-4f27-8c8b-49845dfc9900"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/menus`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-21T10:28:05Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/b0669de3-9657-441c-8f43-4a262c6095d1?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b0669de3-9657-441c-8f43-4a262c6095d1",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-21T10:29:51+00:00",
      "updated_at": "2022-11-21T10:29:51+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b0669de3-9657-441c-8f43-4a262c6095d1"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "4f90100b-51db-4e08-841e-ae13984016ce"
          },
          {
            "type": "menu_items",
            "id": "add1542b-5cd5-40f7-98b4-1443fae71598"
          },
          {
            "type": "menu_items",
            "id": "fd5cc823-036c-44bc-9345-a8e749024ccf"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4f90100b-51db-4e08-841e-ae13984016ce",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-21T10:29:51+00:00",
        "updated_at": "2022-11-21T10:29:51+00:00",
        "menu_id": "b0669de3-9657-441c-8f43-4a262c6095d1",
        "parent_menu_item_id": null,
        "title": "About us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "links": {
            "related": "api/boomerang/menus/b0669de3-9657-441c-8f43-4a262c6095d1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4f90100b-51db-4e08-841e-ae13984016ce"
          }
        }
      }
    },
    {
      "id": "add1542b-5cd5-40f7-98b4-1443fae71598",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-21T10:29:51+00:00",
        "updated_at": "2022-11-21T10:29:51+00:00",
        "menu_id": "b0669de3-9657-441c-8f43-4a262c6095d1",
        "parent_menu_item_id": null,
        "title": "Home",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "links": {
            "related": "api/boomerang/menus/b0669de3-9657-441c-8f43-4a262c6095d1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=add1542b-5cd5-40f7-98b4-1443fae71598"
          }
        }
      }
    },
    {
      "id": "fd5cc823-036c-44bc-9345-a8e749024ccf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-21T10:29:51+00:00",
        "updated_at": "2022-11-21T10:29:51+00:00",
        "menu_id": "b0669de3-9657-441c-8f43-4a262c6095d1",
        "parent_menu_item_id": null,
        "title": "Rentals",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "links": {
            "related": "api/boomerang/menus/b0669de3-9657-441c-8f43-4a262c6095d1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fd5cc823-036c-44bc-9345-a8e749024ccf"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/menus/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`menu_items`






## Creating a menu with items



> How to create a menu with menu items:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/menus' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "key": "header",
          "menu_items_attributes": [
            {
              "title": "Home",
              "target_type": "Static",
              "value": "/"
            },
            {
              "title": "Resources",
              "target_type": "Static",
              "value": "/resources",
              "menu_items_attributes": [
                {
                  "title": "Blog",
                  "target_type": "Static",
                  "value": "/resources/blog",
                  "menu_items_attributes": [
                    {
                      "title": "Customer stories",
                      "target_type": "Static",
                      "value": "/resources/blog/customer-stories"
                    }
                  ]
                }
              ]
            }
          ]
        }
      },
      "include": "menus"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7b27e80b-7dff-4a31-92cf-83319977a200",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-21T10:29:51+00:00",
      "updated_at": "2022-11-21T10:29:51+00:00",
      "title": "Header menu",
      "key": "header"
    },
    "relationships": {
      "menu_items": {
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

`POST /api/boomerang/menus`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String** <br>Name of the menu.
`data[attributes][key]` | **String** <br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array** <br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/b2a25e47-b5eb-4e6a-8110-f28fcfda97dc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b2a25e47-b5eb-4e6a-8110-f28fcfda97dc",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "f17b85f7-e992-4736-8977-14ff950934fd",
              "title": "Contact us"
            },
            {
              "id": "cff305bc-7946-4416-9dde-1244af9726ca",
              "title": "Start"
            },
            {
              "id": "e41b4ca9-3d00-4518-8399-9a129fde1666",
              "title": "Rent from us"
            }
          ]
        }
      },
      "include": "menu_items"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b2a25e47-b5eb-4e6a-8110-f28fcfda97dc",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-21T10:29:52+00:00",
      "updated_at": "2022-11-21T10:29:52+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "f17b85f7-e992-4736-8977-14ff950934fd"
          },
          {
            "type": "menu_items",
            "id": "cff305bc-7946-4416-9dde-1244af9726ca"
          },
          {
            "type": "menu_items",
            "id": "e41b4ca9-3d00-4518-8399-9a129fde1666"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f17b85f7-e992-4736-8977-14ff950934fd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-21T10:29:52+00:00",
        "updated_at": "2022-11-21T10:29:52+00:00",
        "menu_id": "b2a25e47-b5eb-4e6a-8110-f28fcfda97dc",
        "parent_menu_item_id": null,
        "title": "Contact us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "meta": {
            "included": false
          }
        },
        "menu_items": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "cff305bc-7946-4416-9dde-1244af9726ca",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-21T10:29:52+00:00",
        "updated_at": "2022-11-21T10:29:52+00:00",
        "menu_id": "b2a25e47-b5eb-4e6a-8110-f28fcfda97dc",
        "parent_menu_item_id": null,
        "title": "Start",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "meta": {
            "included": false
          }
        },
        "menu_items": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "e41b4ca9-3d00-4518-8399-9a129fde1666",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-21T10:29:52+00:00",
        "updated_at": "2022-11-21T10:29:52+00:00",
        "menu_id": "b2a25e47-b5eb-4e6a-8110-f28fcfda97dc",
        "parent_menu_item_id": null,
        "title": "Rent from us",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "meta": {
            "included": false
          }
        },
        "menu_items": {
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

`PUT /api/boomerang/menus/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String** <br>Name of the menu.
`data[attributes][key]` | **String** <br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array** <br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/693e961e-6554-4a42-8cd3-28a83bcf5f12' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/menus/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes