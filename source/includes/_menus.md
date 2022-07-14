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
      "id": "75564d07-f164-43ed-a51b-faf22ada5e0c",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-14T21:14:44+00:00",
        "updated_at": "2022-07-14T21:14:44+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=75564d07-f164-43ed-a51b-faf22ada5e0c"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T21:13:00Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/b69890ff-2901-4dc2-99c1-98a3f56da5f4?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b69890ff-2901-4dc2-99c1-98a3f56da5f4",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T21:14:45+00:00",
      "updated_at": "2022-07-14T21:14:45+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b69890ff-2901-4dc2-99c1-98a3f56da5f4"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "e321c127-0fdc-4f16-8061-055de0584b78"
          },
          {
            "type": "menu_items",
            "id": "b53b24da-9590-4a74-a7e1-c9dfcead1080"
          },
          {
            "type": "menu_items",
            "id": "6c9efa83-388c-4590-91e9-d8ac66e9523f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e321c127-0fdc-4f16-8061-055de0584b78",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T21:14:45+00:00",
        "updated_at": "2022-07-14T21:14:45+00:00",
        "menu_id": "b69890ff-2901-4dc2-99c1-98a3f56da5f4",
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
            "related": "api/boomerang/menus/b69890ff-2901-4dc2-99c1-98a3f56da5f4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e321c127-0fdc-4f16-8061-055de0584b78"
          }
        }
      }
    },
    {
      "id": "b53b24da-9590-4a74-a7e1-c9dfcead1080",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T21:14:45+00:00",
        "updated_at": "2022-07-14T21:14:45+00:00",
        "menu_id": "b69890ff-2901-4dc2-99c1-98a3f56da5f4",
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
            "related": "api/boomerang/menus/b69890ff-2901-4dc2-99c1-98a3f56da5f4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b53b24da-9590-4a74-a7e1-c9dfcead1080"
          }
        }
      }
    },
    {
      "id": "6c9efa83-388c-4590-91e9-d8ac66e9523f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T21:14:45+00:00",
        "updated_at": "2022-07-14T21:14:45+00:00",
        "menu_id": "b69890ff-2901-4dc2-99c1-98a3f56da5f4",
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
            "related": "api/boomerang/menus/b69890ff-2901-4dc2-99c1-98a3f56da5f4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6c9efa83-388c-4590-91e9-d8ac66e9523f"
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
    "id": "d76b3a92-c1d8-4361-b719-ce882f45a918",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T21:14:45+00:00",
      "updated_at": "2022-07-14T21:14:45+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/57e22c0c-5d54-4fc0-b02b-ba280bc9ec02' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "57e22c0c-5d54-4fc0-b02b-ba280bc9ec02",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "66b0bdea-104c-4a84-8a34-2cc86cdc515e",
              "title": "Contact us"
            },
            {
              "id": "80584285-143d-40de-9c3c-9c9064832879",
              "title": "Start"
            },
            {
              "id": "b86429ef-d7f2-4f82-aa2a-5a4def858e74",
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
    "id": "57e22c0c-5d54-4fc0-b02b-ba280bc9ec02",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T21:14:46+00:00",
      "updated_at": "2022-07-14T21:14:46+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "66b0bdea-104c-4a84-8a34-2cc86cdc515e"
          },
          {
            "type": "menu_items",
            "id": "80584285-143d-40de-9c3c-9c9064832879"
          },
          {
            "type": "menu_items",
            "id": "b86429ef-d7f2-4f82-aa2a-5a4def858e74"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "66b0bdea-104c-4a84-8a34-2cc86cdc515e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T21:14:46+00:00",
        "updated_at": "2022-07-14T21:14:46+00:00",
        "menu_id": "57e22c0c-5d54-4fc0-b02b-ba280bc9ec02",
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
      "id": "80584285-143d-40de-9c3c-9c9064832879",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T21:14:46+00:00",
        "updated_at": "2022-07-14T21:14:46+00:00",
        "menu_id": "57e22c0c-5d54-4fc0-b02b-ba280bc9ec02",
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
      "id": "b86429ef-d7f2-4f82-aa2a-5a4def858e74",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T21:14:46+00:00",
        "updated_at": "2022-07-14T21:14:46+00:00",
        "menu_id": "57e22c0c-5d54-4fc0-b02b-ba280bc9ec02",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ffcc89eb-0f53-4be6-881c-c8ccb6c8179a' \
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