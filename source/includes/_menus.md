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
      "id": "57180a3f-06e2-4f9b-8188-1517c10aef46",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-06T15:14:26+00:00",
        "updated_at": "2023-01-06T15:14:26+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=57180a3f-06e2-4f9b-8188-1517c10aef46"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-06T15:12:22Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/38be1609-aa15-47c1-a259-b4840c90dcf6?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "38be1609-aa15-47c1-a259-b4840c90dcf6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-06T15:14:27+00:00",
      "updated_at": "2023-01-06T15:14:27+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=38be1609-aa15-47c1-a259-b4840c90dcf6"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "1e627a62-df32-41b1-8218-1c77645295b4"
          },
          {
            "type": "menu_items",
            "id": "bfba4d72-6d67-4c5d-ac63-735424d51381"
          },
          {
            "type": "menu_items",
            "id": "4f2ac37f-5372-427f-b206-59e34f2b25e6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1e627a62-df32-41b1-8218-1c77645295b4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-06T15:14:27+00:00",
        "updated_at": "2023-01-06T15:14:27+00:00",
        "menu_id": "38be1609-aa15-47c1-a259-b4840c90dcf6",
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
            "related": "api/boomerang/menus/38be1609-aa15-47c1-a259-b4840c90dcf6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1e627a62-df32-41b1-8218-1c77645295b4"
          }
        }
      }
    },
    {
      "id": "bfba4d72-6d67-4c5d-ac63-735424d51381",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-06T15:14:27+00:00",
        "updated_at": "2023-01-06T15:14:27+00:00",
        "menu_id": "38be1609-aa15-47c1-a259-b4840c90dcf6",
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
            "related": "api/boomerang/menus/38be1609-aa15-47c1-a259-b4840c90dcf6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bfba4d72-6d67-4c5d-ac63-735424d51381"
          }
        }
      }
    },
    {
      "id": "4f2ac37f-5372-427f-b206-59e34f2b25e6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-06T15:14:27+00:00",
        "updated_at": "2023-01-06T15:14:27+00:00",
        "menu_id": "38be1609-aa15-47c1-a259-b4840c90dcf6",
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
            "related": "api/boomerang/menus/38be1609-aa15-47c1-a259-b4840c90dcf6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4f2ac37f-5372-427f-b206-59e34f2b25e6"
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
    "id": "599532f7-88d0-4894-8017-741d60bd0fdd",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-06T15:14:27+00:00",
      "updated_at": "2023-01-06T15:14:27+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f7a8a7f5-52c4-42b4-9db0-3b6336191a48' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f7a8a7f5-52c4-42b4-9db0-3b6336191a48",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "0585c681-7b00-425e-ae9e-bd6138ec8a74",
              "title": "Contact us"
            },
            {
              "id": "940c7fd2-3699-4efb-bd1c-ea041a523fb1",
              "title": "Start"
            },
            {
              "id": "d2340384-5c62-4b03-bf78-95e5fccef440",
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
    "id": "f7a8a7f5-52c4-42b4-9db0-3b6336191a48",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-06T15:14:27+00:00",
      "updated_at": "2023-01-06T15:14:27+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "0585c681-7b00-425e-ae9e-bd6138ec8a74"
          },
          {
            "type": "menu_items",
            "id": "940c7fd2-3699-4efb-bd1c-ea041a523fb1"
          },
          {
            "type": "menu_items",
            "id": "d2340384-5c62-4b03-bf78-95e5fccef440"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0585c681-7b00-425e-ae9e-bd6138ec8a74",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-06T15:14:27+00:00",
        "updated_at": "2023-01-06T15:14:27+00:00",
        "menu_id": "f7a8a7f5-52c4-42b4-9db0-3b6336191a48",
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
      "id": "940c7fd2-3699-4efb-bd1c-ea041a523fb1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-06T15:14:27+00:00",
        "updated_at": "2023-01-06T15:14:27+00:00",
        "menu_id": "f7a8a7f5-52c4-42b4-9db0-3b6336191a48",
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
      "id": "d2340384-5c62-4b03-bf78-95e5fccef440",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-06T15:14:27+00:00",
        "updated_at": "2023-01-06T15:14:28+00:00",
        "menu_id": "f7a8a7f5-52c4-42b4-9db0-3b6336191a48",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0aeb5713-96a2-4fb3-a733-278feb743247' \
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