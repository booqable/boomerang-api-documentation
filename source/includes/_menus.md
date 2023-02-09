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
      "id": "cb221e04-51a7-4a10-8398-9109d37d7adf",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-09T12:17:46+00:00",
        "updated_at": "2023-02-09T12:17:46+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=cb221e04-51a7-4a10-8398-9109d37d7adf"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T12:15:53Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/f714a335-6c93-482c-a11a-957373c4da4f?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f714a335-6c93-482c-a11a-957373c4da4f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T12:17:47+00:00",
      "updated_at": "2023-02-09T12:17:47+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=f714a335-6c93-482c-a11a-957373c4da4f"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "18250eef-bab8-4930-8eae-987f95e36476"
          },
          {
            "type": "menu_items",
            "id": "2a85dcc9-4ada-4aad-9274-a9074a8d8875"
          },
          {
            "type": "menu_items",
            "id": "d08e9bd2-2f39-4349-bfe6-27d933d5e687"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "18250eef-bab8-4930-8eae-987f95e36476",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T12:17:47+00:00",
        "updated_at": "2023-02-09T12:17:47+00:00",
        "menu_id": "f714a335-6c93-482c-a11a-957373c4da4f",
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
            "related": "api/boomerang/menus/f714a335-6c93-482c-a11a-957373c4da4f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=18250eef-bab8-4930-8eae-987f95e36476"
          }
        }
      }
    },
    {
      "id": "2a85dcc9-4ada-4aad-9274-a9074a8d8875",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T12:17:47+00:00",
        "updated_at": "2023-02-09T12:17:47+00:00",
        "menu_id": "f714a335-6c93-482c-a11a-957373c4da4f",
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
            "related": "api/boomerang/menus/f714a335-6c93-482c-a11a-957373c4da4f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2a85dcc9-4ada-4aad-9274-a9074a8d8875"
          }
        }
      }
    },
    {
      "id": "d08e9bd2-2f39-4349-bfe6-27d933d5e687",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T12:17:47+00:00",
        "updated_at": "2023-02-09T12:17:47+00:00",
        "menu_id": "f714a335-6c93-482c-a11a-957373c4da4f",
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
            "related": "api/boomerang/menus/f714a335-6c93-482c-a11a-957373c4da4f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d08e9bd2-2f39-4349-bfe6-27d933d5e687"
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
    "id": "beb213ff-6264-43b7-8b6a-a3e4f42972d9",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T12:17:47+00:00",
      "updated_at": "2023-02-09T12:17:47+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/074ecfaa-be8b-400d-894d-0a2adeed7c34' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "074ecfaa-be8b-400d-894d-0a2adeed7c34",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "46072985-4315-4d3d-ac37-4bb2f4b153ef",
              "title": "Contact us"
            },
            {
              "id": "3aaae1b6-5323-449e-bc34-e927f54ee274",
              "title": "Start"
            },
            {
              "id": "530d0d27-174b-4197-860f-47e0afc8b65b",
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
    "id": "074ecfaa-be8b-400d-894d-0a2adeed7c34",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T12:17:47+00:00",
      "updated_at": "2023-02-09T12:17:47+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "46072985-4315-4d3d-ac37-4bb2f4b153ef"
          },
          {
            "type": "menu_items",
            "id": "3aaae1b6-5323-449e-bc34-e927f54ee274"
          },
          {
            "type": "menu_items",
            "id": "530d0d27-174b-4197-860f-47e0afc8b65b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "46072985-4315-4d3d-ac37-4bb2f4b153ef",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T12:17:47+00:00",
        "updated_at": "2023-02-09T12:17:47+00:00",
        "menu_id": "074ecfaa-be8b-400d-894d-0a2adeed7c34",
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
      "id": "3aaae1b6-5323-449e-bc34-e927f54ee274",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T12:17:47+00:00",
        "updated_at": "2023-02-09T12:17:47+00:00",
        "menu_id": "074ecfaa-be8b-400d-894d-0a2adeed7c34",
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
      "id": "530d0d27-174b-4197-860f-47e0afc8b65b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T12:17:47+00:00",
        "updated_at": "2023-02-09T12:17:47+00:00",
        "menu_id": "074ecfaa-be8b-400d-894d-0a2adeed7c34",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0fb7e083-157a-422e-b66f-86273c801d08' \
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