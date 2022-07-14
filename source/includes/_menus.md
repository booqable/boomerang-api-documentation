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
      "id": "2ac28daf-97d2-4b0f-8643-850ce455c33f",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-14T14:27:53+00:00",
        "updated_at": "2022-07-14T14:27:53+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=2ac28daf-97d2-4b0f-8643-850ce455c33f"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T14:26:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/7d0beebd-35ac-41c2-9c67-931be948da17?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7d0beebd-35ac-41c2-9c67-931be948da17",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T14:27:53+00:00",
      "updated_at": "2022-07-14T14:27:53+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=7d0beebd-35ac-41c2-9c67-931be948da17"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "94253e4c-1fc3-4697-adb8-bd87d83ab19e"
          },
          {
            "type": "menu_items",
            "id": "5ef24dab-7d36-4107-9123-7251fc548b1c"
          },
          {
            "type": "menu_items",
            "id": "671485ac-92e5-46a1-a0df-b5838a815ea7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "94253e4c-1fc3-4697-adb8-bd87d83ab19e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T14:27:54+00:00",
        "updated_at": "2022-07-14T14:27:54+00:00",
        "menu_id": "7d0beebd-35ac-41c2-9c67-931be948da17",
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
            "related": "api/boomerang/menus/7d0beebd-35ac-41c2-9c67-931be948da17"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=94253e4c-1fc3-4697-adb8-bd87d83ab19e"
          }
        }
      }
    },
    {
      "id": "5ef24dab-7d36-4107-9123-7251fc548b1c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T14:27:54+00:00",
        "updated_at": "2022-07-14T14:27:54+00:00",
        "menu_id": "7d0beebd-35ac-41c2-9c67-931be948da17",
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
            "related": "api/boomerang/menus/7d0beebd-35ac-41c2-9c67-931be948da17"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5ef24dab-7d36-4107-9123-7251fc548b1c"
          }
        }
      }
    },
    {
      "id": "671485ac-92e5-46a1-a0df-b5838a815ea7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T14:27:54+00:00",
        "updated_at": "2022-07-14T14:27:54+00:00",
        "menu_id": "7d0beebd-35ac-41c2-9c67-931be948da17",
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
            "related": "api/boomerang/menus/7d0beebd-35ac-41c2-9c67-931be948da17"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=671485ac-92e5-46a1-a0df-b5838a815ea7"
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
    "id": "74958452-34b8-48f7-95a7-31cc737a3c27",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T14:27:54+00:00",
      "updated_at": "2022-07-14T14:27:54+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d841cbdc-1edf-4147-bd56-ecdf9f438b3b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d841cbdc-1edf-4147-bd56-ecdf9f438b3b",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "ccef5ad4-2fb7-4717-92d6-3d92d4c00bf8",
              "title": "Contact us"
            },
            {
              "id": "c365704c-7372-4752-9581-00d52d79a1cc",
              "title": "Start"
            },
            {
              "id": "1853d772-fb1d-4c68-9f3e-09ad490e34b8",
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
    "id": "d841cbdc-1edf-4147-bd56-ecdf9f438b3b",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T14:27:54+00:00",
      "updated_at": "2022-07-14T14:27:54+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "ccef5ad4-2fb7-4717-92d6-3d92d4c00bf8"
          },
          {
            "type": "menu_items",
            "id": "c365704c-7372-4752-9581-00d52d79a1cc"
          },
          {
            "type": "menu_items",
            "id": "1853d772-fb1d-4c68-9f3e-09ad490e34b8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ccef5ad4-2fb7-4717-92d6-3d92d4c00bf8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T14:27:54+00:00",
        "updated_at": "2022-07-14T14:27:54+00:00",
        "menu_id": "d841cbdc-1edf-4147-bd56-ecdf9f438b3b",
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
      "id": "c365704c-7372-4752-9581-00d52d79a1cc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T14:27:54+00:00",
        "updated_at": "2022-07-14T14:27:54+00:00",
        "menu_id": "d841cbdc-1edf-4147-bd56-ecdf9f438b3b",
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
      "id": "1853d772-fb1d-4c68-9f3e-09ad490e34b8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T14:27:54+00:00",
        "updated_at": "2022-07-14T14:27:54+00:00",
        "menu_id": "d841cbdc-1edf-4147-bd56-ecdf9f438b3b",
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
    --url 'https://example.booqable.com/api/boomerang/menus/2f09e365-a1e5-49bc-bb2c-94d0e85eafe2' \
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