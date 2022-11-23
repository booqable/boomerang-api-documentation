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
      "id": "db349b06-5a64-4e4b-9468-113336cb6659",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-23T11:35:16+00:00",
        "updated_at": "2022-11-23T11:35:16+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=db349b06-5a64-4e4b-9468-113336cb6659"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-23T11:33:06Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/ddd06c83-4817-491e-8426-58a418890dcb?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ddd06c83-4817-491e-8426-58a418890dcb",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-23T11:35:17+00:00",
      "updated_at": "2022-11-23T11:35:17+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=ddd06c83-4817-491e-8426-58a418890dcb"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "2f655fcc-537d-45b7-8bff-5e30e7bd0aca"
          },
          {
            "type": "menu_items",
            "id": "9c2e24dd-4cfb-4e6c-a5ae-86bad8941e21"
          },
          {
            "type": "menu_items",
            "id": "6a520589-d2fd-4ea3-a856-b79317923bb7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2f655fcc-537d-45b7-8bff-5e30e7bd0aca",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-23T11:35:17+00:00",
        "updated_at": "2022-11-23T11:35:17+00:00",
        "menu_id": "ddd06c83-4817-491e-8426-58a418890dcb",
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
            "related": "api/boomerang/menus/ddd06c83-4817-491e-8426-58a418890dcb"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2f655fcc-537d-45b7-8bff-5e30e7bd0aca"
          }
        }
      }
    },
    {
      "id": "9c2e24dd-4cfb-4e6c-a5ae-86bad8941e21",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-23T11:35:17+00:00",
        "updated_at": "2022-11-23T11:35:17+00:00",
        "menu_id": "ddd06c83-4817-491e-8426-58a418890dcb",
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
            "related": "api/boomerang/menus/ddd06c83-4817-491e-8426-58a418890dcb"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9c2e24dd-4cfb-4e6c-a5ae-86bad8941e21"
          }
        }
      }
    },
    {
      "id": "6a520589-d2fd-4ea3-a856-b79317923bb7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-23T11:35:17+00:00",
        "updated_at": "2022-11-23T11:35:17+00:00",
        "menu_id": "ddd06c83-4817-491e-8426-58a418890dcb",
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
            "related": "api/boomerang/menus/ddd06c83-4817-491e-8426-58a418890dcb"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6a520589-d2fd-4ea3-a856-b79317923bb7"
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
    "id": "f8e77cff-3190-4c7b-a597-84a38ab76d05",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-23T11:35:17+00:00",
      "updated_at": "2022-11-23T11:35:17+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/aa92183f-5083-4674-b447-abcdec3f8616' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "aa92183f-5083-4674-b447-abcdec3f8616",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "1dc41374-2c82-4b97-8f2a-e6ead4efe8d1",
              "title": "Contact us"
            },
            {
              "id": "ec4ccdb4-fde4-48d7-a3f2-77fa4d0c7b07",
              "title": "Start"
            },
            {
              "id": "ccefa287-4e7b-46ab-aa38-a7e8b67e8c4c",
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
    "id": "aa92183f-5083-4674-b447-abcdec3f8616",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-23T11:35:18+00:00",
      "updated_at": "2022-11-23T11:35:18+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "1dc41374-2c82-4b97-8f2a-e6ead4efe8d1"
          },
          {
            "type": "menu_items",
            "id": "ec4ccdb4-fde4-48d7-a3f2-77fa4d0c7b07"
          },
          {
            "type": "menu_items",
            "id": "ccefa287-4e7b-46ab-aa38-a7e8b67e8c4c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1dc41374-2c82-4b97-8f2a-e6ead4efe8d1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-23T11:35:18+00:00",
        "updated_at": "2022-11-23T11:35:18+00:00",
        "menu_id": "aa92183f-5083-4674-b447-abcdec3f8616",
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
      "id": "ec4ccdb4-fde4-48d7-a3f2-77fa4d0c7b07",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-23T11:35:18+00:00",
        "updated_at": "2022-11-23T11:35:18+00:00",
        "menu_id": "aa92183f-5083-4674-b447-abcdec3f8616",
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
      "id": "ccefa287-4e7b-46ab-aa38-a7e8b67e8c4c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-23T11:35:18+00:00",
        "updated_at": "2022-11-23T11:35:18+00:00",
        "menu_id": "aa92183f-5083-4674-b447-abcdec3f8616",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c17d8092-fe17-4c7d-afbe-d5642d94e94a' \
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