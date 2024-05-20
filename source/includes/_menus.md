# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

`POST /api/boomerang/menus`

`DELETE /api/boomerang/menus/{id}`

`PUT /api/boomerang/menus/{id}`

## Fields
Every menu has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`title` | **String** <br>Name of the menu.
`key` | **String** <br>Key the menu can be referenced by.
`menu_items_attributes` | **Array** `writeonly`<br>Attributes of child menu items to be created or changed.


## Relationships
Menus have the following relationships:

Name | Description
-- | --
`menu_items` | **Menu items** `readonly`<br>Associated Menu items


## Fetching a menu



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/2d78c324-2c41-4371-a82b-1ff1714d2305?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2d78c324-2c41-4371-a82b-1ff1714d2305",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-20T09:27:52+00:00",
      "updated_at": "2024-05-20T09:27:52+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=2d78c324-2c41-4371-a82b-1ff1714d2305"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "5cfb07e3-fae6-405b-b394-4eee45d9212d"
          },
          {
            "type": "menu_items",
            "id": "1c8d1381-dae3-4f79-91e1-f8d90746ab36"
          },
          {
            "type": "menu_items",
            "id": "2ecc20e0-44ae-4b69-bb16-8c282fcb4f57"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5cfb07e3-fae6-405b-b394-4eee45d9212d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-20T09:27:52+00:00",
        "updated_at": "2024-05-20T09:27:52+00:00",
        "menu_id": "2d78c324-2c41-4371-a82b-1ff1714d2305",
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
            "related": "api/boomerang/menus/2d78c324-2c41-4371-a82b-1ff1714d2305"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5cfb07e3-fae6-405b-b394-4eee45d9212d"
          }
        }
      }
    },
    {
      "id": "1c8d1381-dae3-4f79-91e1-f8d90746ab36",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-20T09:27:52+00:00",
        "updated_at": "2024-05-20T09:27:52+00:00",
        "menu_id": "2d78c324-2c41-4371-a82b-1ff1714d2305",
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
            "related": "api/boomerang/menus/2d78c324-2c41-4371-a82b-1ff1714d2305"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1c8d1381-dae3-4f79-91e1-f8d90746ab36"
          }
        }
      }
    },
    {
      "id": "2ecc20e0-44ae-4b69-bb16-8c282fcb4f57",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-20T09:27:52+00:00",
        "updated_at": "2024-05-20T09:27:52+00:00",
        "menu_id": "2d78c324-2c41-4371-a82b-1ff1714d2305",
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
            "related": "api/boomerang/menus/2d78c324-2c41-4371-a82b-1ff1714d2305"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2ecc20e0-44ae-4b69-bb16-8c282fcb4f57"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request accepts the following includes:

`menu_items`






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
      "id": "12dabc06-65cb-407c-87fb-789c92c8fab3",
      "type": "menus",
      "attributes": {
        "created_at": "2024-05-20T09:27:54+00:00",
        "updated_at": "2024-05-20T09:27:54+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=12dabc06-65cb-407c-87fb-789c92c8fab3"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
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
    "id": "98884d6e-1a3c-41b4-8eb5-ff17d3a7ec71",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-20T09:27:57+00:00",
      "updated_at": "2024-05-20T09:27:57+00:00",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/menus/49c57c90-4418-415d-82df-4403815586d3' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "49c57c90-4418-415d-82df-4403815586d3",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-20T09:27:59+00:00",
      "updated_at": "2024-05-20T09:27:59+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=49c57c90-4418-415d-82df-4403815586d3"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/menus/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request does not accept any includes
## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/5f679183-cc93-4da7-9a1b-72650cd7f9f8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5f679183-cc93-4da7-9a1b-72650cd7f9f8",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e8e6d765-bb13-4159-ae4e-a2db286f7f24",
              "title": "Contact us"
            },
            {
              "id": "f435cd6a-6601-424e-ba57-ac65d6419640",
              "title": "Start"
            },
            {
              "id": "24e9cce4-1ffe-44d6-83e6-0027e70a2640",
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
    "id": "5f679183-cc93-4da7-9a1b-72650cd7f9f8",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-20T09:28:00+00:00",
      "updated_at": "2024-05-20T09:28:00+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e8e6d765-bb13-4159-ae4e-a2db286f7f24"
          },
          {
            "type": "menu_items",
            "id": "f435cd6a-6601-424e-ba57-ac65d6419640"
          },
          {
            "type": "menu_items",
            "id": "24e9cce4-1ffe-44d6-83e6-0027e70a2640"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e8e6d765-bb13-4159-ae4e-a2db286f7f24",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-20T09:28:00+00:00",
        "updated_at": "2024-05-20T09:28:00+00:00",
        "menu_id": "5f679183-cc93-4da7-9a1b-72650cd7f9f8",
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
      "id": "f435cd6a-6601-424e-ba57-ac65d6419640",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-20T09:28:00+00:00",
        "updated_at": "2024-05-20T09:28:00+00:00",
        "menu_id": "5f679183-cc93-4da7-9a1b-72650cd7f9f8",
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
      "id": "24e9cce4-1ffe-44d6-83e6-0027e70a2640",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-20T09:28:00+00:00",
        "updated_at": "2024-05-20T09:28:00+00:00",
        "menu_id": "5f679183-cc93-4da7-9a1b-72650cd7f9f8",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][title]` | **String** <br>Name of the menu.
`data[attributes][key]` | **String** <br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array** <br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`









