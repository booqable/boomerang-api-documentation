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
`title` | **String**<br>Name of the menu.
`key` | **String**<br>Key the menu can be referenced by.
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
      "id": "88158c82-2adb-4686-8942-54fbc735c06b",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-18T07:35:52+00:00",
        "updated_at": "2022-07-18T07:35:52+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=88158c82-2adb-4686-8942-54fbc735c06b"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-18T07:33:57Z`
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
`title` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/646a085b-c71f-4f82-9ec9-017e2c45040d?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "646a085b-c71f-4f82-9ec9-017e2c45040d",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-18T07:35:52+00:00",
      "updated_at": "2022-07-18T07:35:52+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=646a085b-c71f-4f82-9ec9-017e2c45040d"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "d4c49f99-65ed-48d6-9f38-905c26bc9b80"
          },
          {
            "type": "menu_items",
            "id": "134653d1-ffa8-45c9-b2b1-b9913285be04"
          },
          {
            "type": "menu_items",
            "id": "f8e72a45-7e17-44af-a105-593fc95445e4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d4c49f99-65ed-48d6-9f38-905c26bc9b80",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-18T07:35:52+00:00",
        "updated_at": "2022-07-18T07:35:52+00:00",
        "menu_id": "646a085b-c71f-4f82-9ec9-017e2c45040d",
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
            "related": "api/boomerang/menus/646a085b-c71f-4f82-9ec9-017e2c45040d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d4c49f99-65ed-48d6-9f38-905c26bc9b80"
          }
        }
      }
    },
    {
      "id": "134653d1-ffa8-45c9-b2b1-b9913285be04",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-18T07:35:52+00:00",
        "updated_at": "2022-07-18T07:35:52+00:00",
        "menu_id": "646a085b-c71f-4f82-9ec9-017e2c45040d",
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
            "related": "api/boomerang/menus/646a085b-c71f-4f82-9ec9-017e2c45040d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=134653d1-ffa8-45c9-b2b1-b9913285be04"
          }
        }
      }
    },
    {
      "id": "f8e72a45-7e17-44af-a105-593fc95445e4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-18T07:35:52+00:00",
        "updated_at": "2022-07-18T07:35:52+00:00",
        "menu_id": "646a085b-c71f-4f82-9ec9-017e2c45040d",
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
            "related": "api/boomerang/menus/646a085b-c71f-4f82-9ec9-017e2c45040d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f8e72a45-7e17-44af-a105-593fc95445e4"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


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
    "id": "88b99fab-a27b-4249-a8b3-6c51e990b2d8",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-18T07:35:52+00:00",
      "updated_at": "2022-07-18T07:35:52+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/8f89f345-0b5f-4f53-8cd2-9c4e6aa66e52' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8f89f345-0b5f-4f53-8cd2-9c4e6aa66e52",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "467d7056-dd4b-4630-aeb7-9567a7c0bf76",
              "title": "Contact us"
            },
            {
              "id": "29bd4feb-6fb2-45d9-b584-83bebb6b60db",
              "title": "Start"
            },
            {
              "id": "3d6e8db0-ffc6-4898-9c61-188c53a100bd",
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
    "id": "8f89f345-0b5f-4f53-8cd2-9c4e6aa66e52",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-18T07:35:53+00:00",
      "updated_at": "2022-07-18T07:35:53+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "467d7056-dd4b-4630-aeb7-9567a7c0bf76"
          },
          {
            "type": "menu_items",
            "id": "29bd4feb-6fb2-45d9-b584-83bebb6b60db"
          },
          {
            "type": "menu_items",
            "id": "3d6e8db0-ffc6-4898-9c61-188c53a100bd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "467d7056-dd4b-4630-aeb7-9567a7c0bf76",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-18T07:35:53+00:00",
        "updated_at": "2022-07-18T07:35:53+00:00",
        "menu_id": "8f89f345-0b5f-4f53-8cd2-9c4e6aa66e52",
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
      "id": "29bd4feb-6fb2-45d9-b584-83bebb6b60db",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-18T07:35:53+00:00",
        "updated_at": "2022-07-18T07:35:53+00:00",
        "menu_id": "8f89f345-0b5f-4f53-8cd2-9c4e6aa66e52",
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
      "id": "3d6e8db0-ffc6-4898-9c61-188c53a100bd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-18T07:35:53+00:00",
        "updated_at": "2022-07-18T07:35:53+00:00",
        "menu_id": "8f89f345-0b5f-4f53-8cd2-9c4e6aa66e52",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/c33460df-7f1a-44fc-905d-22e071a9a4a9' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes