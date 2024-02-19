# Menus

Allows creating and managing menus for your shop.

## Endpoints
`DELETE /api/boomerang/menus/{id}`

`GET /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

`POST /api/boomerang/menus`

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


## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/c84440b5-a43a-40eb-bbac-de2cbe9acdaa' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/683f8583-d0e0-4a13-82f7-e4b2d16e662c?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "683f8583-d0e0-4a13-82f7-e4b2d16e662c",
    "type": "menus",
    "attributes": {
      "created_at": "2024-02-19T09:20:25+00:00",
      "updated_at": "2024-02-19T09:20:25+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=683f8583-d0e0-4a13-82f7-e4b2d16e662c"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "0022b406-1172-4f43-8b5f-2d05f57d98e6"
          },
          {
            "type": "menu_items",
            "id": "970b5733-263b-40cc-a09d-6fcefd3de77d"
          },
          {
            "type": "menu_items",
            "id": "3a0cddbd-eb5e-483e-82e8-92d7bbfc47b7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0022b406-1172-4f43-8b5f-2d05f57d98e6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-19T09:20:25+00:00",
        "updated_at": "2024-02-19T09:20:25+00:00",
        "menu_id": "683f8583-d0e0-4a13-82f7-e4b2d16e662c",
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
            "related": "api/boomerang/menus/683f8583-d0e0-4a13-82f7-e4b2d16e662c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0022b406-1172-4f43-8b5f-2d05f57d98e6"
          }
        }
      }
    },
    {
      "id": "970b5733-263b-40cc-a09d-6fcefd3de77d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-19T09:20:25+00:00",
        "updated_at": "2024-02-19T09:20:25+00:00",
        "menu_id": "683f8583-d0e0-4a13-82f7-e4b2d16e662c",
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
            "related": "api/boomerang/menus/683f8583-d0e0-4a13-82f7-e4b2d16e662c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=970b5733-263b-40cc-a09d-6fcefd3de77d"
          }
        }
      }
    },
    {
      "id": "3a0cddbd-eb5e-483e-82e8-92d7bbfc47b7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-19T09:20:25+00:00",
        "updated_at": "2024-02-19T09:20:25+00:00",
        "menu_id": "683f8583-d0e0-4a13-82f7-e4b2d16e662c",
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
            "related": "api/boomerang/menus/683f8583-d0e0-4a13-82f7-e4b2d16e662c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3a0cddbd-eb5e-483e-82e8-92d7bbfc47b7"
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
      "id": "7ae12135-90ce-4a17-b4bf-97e60ea606ff",
      "type": "menus",
      "attributes": {
        "created_at": "2024-02-19T09:20:26+00:00",
        "updated_at": "2024-02-19T09:20:26+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=7ae12135-90ce-4a17-b4bf-97e60ea606ff"
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
    "id": "c2e9efed-7896-4e2d-9173-3bb9110111fd",
    "type": "menus",
    "attributes": {
      "created_at": "2024-02-19T09:20:28+00:00",
      "updated_at": "2024-02-19T09:20:28+00:00",
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










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/123aa4d5-a4f8-42e5-9b7d-b4209dfe03b2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "123aa4d5-a4f8-42e5-9b7d-b4209dfe03b2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "5447c805-704a-4831-9065-ced55796a70b",
              "title": "Contact us"
            },
            {
              "id": "18256aa2-fab1-4651-b30d-145341c43663",
              "title": "Start"
            },
            {
              "id": "d86bc233-5716-40ab-addb-8d16b8ecbf81",
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
    "id": "123aa4d5-a4f8-42e5-9b7d-b4209dfe03b2",
    "type": "menus",
    "attributes": {
      "created_at": "2024-02-19T09:20:29+00:00",
      "updated_at": "2024-02-19T09:20:29+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "5447c805-704a-4831-9065-ced55796a70b"
          },
          {
            "type": "menu_items",
            "id": "18256aa2-fab1-4651-b30d-145341c43663"
          },
          {
            "type": "menu_items",
            "id": "d86bc233-5716-40ab-addb-8d16b8ecbf81"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5447c805-704a-4831-9065-ced55796a70b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-19T09:20:29+00:00",
        "updated_at": "2024-02-19T09:20:29+00:00",
        "menu_id": "123aa4d5-a4f8-42e5-9b7d-b4209dfe03b2",
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
      "id": "18256aa2-fab1-4651-b30d-145341c43663",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-19T09:20:29+00:00",
        "updated_at": "2024-02-19T09:20:29+00:00",
        "menu_id": "123aa4d5-a4f8-42e5-9b7d-b4209dfe03b2",
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
      "id": "d86bc233-5716-40ab-addb-8d16b8ecbf81",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-19T09:20:29+00:00",
        "updated_at": "2024-02-19T09:20:29+00:00",
        "menu_id": "123aa4d5-a4f8-42e5-9b7d-b4209dfe03b2",
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









