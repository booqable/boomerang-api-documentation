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
      "id": "6cd8ae95-de88-4c65-84e4-b1573e820881",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-16T15:49:29+00:00",
        "updated_at": "2023-02-16T15:49:29+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=6cd8ae95-de88-4c65-84e4-b1573e820881"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T15:47:29Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/bfb0dc44-d9ff-4208-9633-fda2c7d79e9d?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bfb0dc44-d9ff-4208-9633-fda2c7d79e9d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T15:49:29+00:00",
      "updated_at": "2023-02-16T15:49:29+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=bfb0dc44-d9ff-4208-9633-fda2c7d79e9d"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "cb057487-4040-4727-8e20-1623eaf18164"
          },
          {
            "type": "menu_items",
            "id": "4a9d4c67-30ee-4025-8d5b-1eaa11861af8"
          },
          {
            "type": "menu_items",
            "id": "f4806927-82c2-4064-96f3-a96e273c1177"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cb057487-4040-4727-8e20-1623eaf18164",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T15:49:29+00:00",
        "updated_at": "2023-02-16T15:49:29+00:00",
        "menu_id": "bfb0dc44-d9ff-4208-9633-fda2c7d79e9d",
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
            "related": "api/boomerang/menus/bfb0dc44-d9ff-4208-9633-fda2c7d79e9d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cb057487-4040-4727-8e20-1623eaf18164"
          }
        }
      }
    },
    {
      "id": "4a9d4c67-30ee-4025-8d5b-1eaa11861af8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T15:49:29+00:00",
        "updated_at": "2023-02-16T15:49:29+00:00",
        "menu_id": "bfb0dc44-d9ff-4208-9633-fda2c7d79e9d",
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
            "related": "api/boomerang/menus/bfb0dc44-d9ff-4208-9633-fda2c7d79e9d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4a9d4c67-30ee-4025-8d5b-1eaa11861af8"
          }
        }
      }
    },
    {
      "id": "f4806927-82c2-4064-96f3-a96e273c1177",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T15:49:29+00:00",
        "updated_at": "2023-02-16T15:49:29+00:00",
        "menu_id": "bfb0dc44-d9ff-4208-9633-fda2c7d79e9d",
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
            "related": "api/boomerang/menus/bfb0dc44-d9ff-4208-9633-fda2c7d79e9d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f4806927-82c2-4064-96f3-a96e273c1177"
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
    "id": "07b8f013-50cf-484b-a38a-61577dc8f1e8",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T15:49:29+00:00",
      "updated_at": "2023-02-16T15:49:29+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6942e0cf-f580-45e6-b0e1-77ddc61aa4b4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6942e0cf-f580-45e6-b0e1-77ddc61aa4b4",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "0421971f-9770-4f26-a121-f84927939f7a",
              "title": "Contact us"
            },
            {
              "id": "8660274f-3620-4177-a21e-e8d284321a34",
              "title": "Start"
            },
            {
              "id": "ed941f15-a0fb-405e-94cd-0880fe27dd35",
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
    "id": "6942e0cf-f580-45e6-b0e1-77ddc61aa4b4",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T15:49:30+00:00",
      "updated_at": "2023-02-16T15:49:30+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "0421971f-9770-4f26-a121-f84927939f7a"
          },
          {
            "type": "menu_items",
            "id": "8660274f-3620-4177-a21e-e8d284321a34"
          },
          {
            "type": "menu_items",
            "id": "ed941f15-a0fb-405e-94cd-0880fe27dd35"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0421971f-9770-4f26-a121-f84927939f7a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T15:49:30+00:00",
        "updated_at": "2023-02-16T15:49:30+00:00",
        "menu_id": "6942e0cf-f580-45e6-b0e1-77ddc61aa4b4",
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
      "id": "8660274f-3620-4177-a21e-e8d284321a34",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T15:49:30+00:00",
        "updated_at": "2023-02-16T15:49:30+00:00",
        "menu_id": "6942e0cf-f580-45e6-b0e1-77ddc61aa4b4",
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
      "id": "ed941f15-a0fb-405e-94cd-0880fe27dd35",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T15:49:30+00:00",
        "updated_at": "2023-02-16T15:49:30+00:00",
        "menu_id": "6942e0cf-f580-45e6-b0e1-77ddc61aa4b4",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1bb8da9c-2700-4dd3-b2b3-8d60ba793c28' \
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