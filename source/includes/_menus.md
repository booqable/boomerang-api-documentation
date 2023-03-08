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
      "id": "8a129011-ab26-43ed-9a12-61aa9669c49f",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-08T09:19:39+00:00",
        "updated_at": "2023-03-08T09:19:39+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=8a129011-ab26-43ed-9a12-61aa9669c49f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T09:17:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/dc2d3b7b-c884-4f53-a5c4-e451b36a916f?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dc2d3b7b-c884-4f53-a5c4-e451b36a916f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-08T09:19:39+00:00",
      "updated_at": "2023-03-08T09:19:39+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=dc2d3b7b-c884-4f53-a5c4-e451b36a916f"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "3f4994bc-e7e1-4e24-97b6-cef50535c74b"
          },
          {
            "type": "menu_items",
            "id": "725dc540-13a3-47fa-958e-0bc659fb6495"
          },
          {
            "type": "menu_items",
            "id": "9a7116e5-ed23-4b10-8c26-1f60904ce236"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3f4994bc-e7e1-4e24-97b6-cef50535c74b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T09:19:39+00:00",
        "updated_at": "2023-03-08T09:19:39+00:00",
        "menu_id": "dc2d3b7b-c884-4f53-a5c4-e451b36a916f",
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
            "related": "api/boomerang/menus/dc2d3b7b-c884-4f53-a5c4-e451b36a916f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3f4994bc-e7e1-4e24-97b6-cef50535c74b"
          }
        }
      }
    },
    {
      "id": "725dc540-13a3-47fa-958e-0bc659fb6495",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T09:19:39+00:00",
        "updated_at": "2023-03-08T09:19:39+00:00",
        "menu_id": "dc2d3b7b-c884-4f53-a5c4-e451b36a916f",
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
            "related": "api/boomerang/menus/dc2d3b7b-c884-4f53-a5c4-e451b36a916f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=725dc540-13a3-47fa-958e-0bc659fb6495"
          }
        }
      }
    },
    {
      "id": "9a7116e5-ed23-4b10-8c26-1f60904ce236",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T09:19:39+00:00",
        "updated_at": "2023-03-08T09:19:39+00:00",
        "menu_id": "dc2d3b7b-c884-4f53-a5c4-e451b36a916f",
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
            "related": "api/boomerang/menus/dc2d3b7b-c884-4f53-a5c4-e451b36a916f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9a7116e5-ed23-4b10-8c26-1f60904ce236"
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
    "id": "c75a7f1b-9940-4f5a-9db3-55cdd38e0701",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-08T09:19:39+00:00",
      "updated_at": "2023-03-08T09:19:39+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/30329532-f39f-4fb1-8b4a-9f81405f5733' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "30329532-f39f-4fb1-8b4a-9f81405f5733",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "753dbe17-63c1-4167-8545-2b760aa3015e",
              "title": "Contact us"
            },
            {
              "id": "928b9300-90fb-4658-9f10-81b1ace149f1",
              "title": "Start"
            },
            {
              "id": "1a8c2c6f-8d48-42e0-ab5f-eb0d1874c6ee",
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
    "id": "30329532-f39f-4fb1-8b4a-9f81405f5733",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-08T09:19:41+00:00",
      "updated_at": "2023-03-08T09:19:41+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "753dbe17-63c1-4167-8545-2b760aa3015e"
          },
          {
            "type": "menu_items",
            "id": "928b9300-90fb-4658-9f10-81b1ace149f1"
          },
          {
            "type": "menu_items",
            "id": "1a8c2c6f-8d48-42e0-ab5f-eb0d1874c6ee"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "753dbe17-63c1-4167-8545-2b760aa3015e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T09:19:41+00:00",
        "updated_at": "2023-03-08T09:19:41+00:00",
        "menu_id": "30329532-f39f-4fb1-8b4a-9f81405f5733",
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
      "id": "928b9300-90fb-4658-9f10-81b1ace149f1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T09:19:41+00:00",
        "updated_at": "2023-03-08T09:19:41+00:00",
        "menu_id": "30329532-f39f-4fb1-8b4a-9f81405f5733",
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
      "id": "1a8c2c6f-8d48-42e0-ab5f-eb0d1874c6ee",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T09:19:41+00:00",
        "updated_at": "2023-03-08T09:19:41+00:00",
        "menu_id": "30329532-f39f-4fb1-8b4a-9f81405f5733",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c94480da-5a07-413b-9bf5-4026c8f8e1ee' \
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