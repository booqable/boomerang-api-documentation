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
      "id": "e8e819f1-5cea-45d9-b4a8-63733e514f71",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-07T15:01:04+00:00",
        "updated_at": "2023-02-07T15:01:04+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=e8e819f1-5cea-45d9-b4a8-63733e514f71"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:59:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/8758e78f-df50-4b1a-9a28-c99e7ff8f848?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8758e78f-df50-4b1a-9a28-c99e7ff8f848",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T15:01:04+00:00",
      "updated_at": "2023-02-07T15:01:04+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=8758e78f-df50-4b1a-9a28-c99e7ff8f848"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "0cf18606-781a-4069-bbc2-0777f314d048"
          },
          {
            "type": "menu_items",
            "id": "23f19c03-2935-47b2-93d9-72e5200ad99f"
          },
          {
            "type": "menu_items",
            "id": "e69f54d8-eb06-495d-9e4e-fe42c8498e06"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0cf18606-781a-4069-bbc2-0777f314d048",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T15:01:04+00:00",
        "updated_at": "2023-02-07T15:01:04+00:00",
        "menu_id": "8758e78f-df50-4b1a-9a28-c99e7ff8f848",
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
            "related": "api/boomerang/menus/8758e78f-df50-4b1a-9a28-c99e7ff8f848"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0cf18606-781a-4069-bbc2-0777f314d048"
          }
        }
      }
    },
    {
      "id": "23f19c03-2935-47b2-93d9-72e5200ad99f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T15:01:04+00:00",
        "updated_at": "2023-02-07T15:01:04+00:00",
        "menu_id": "8758e78f-df50-4b1a-9a28-c99e7ff8f848",
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
            "related": "api/boomerang/menus/8758e78f-df50-4b1a-9a28-c99e7ff8f848"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=23f19c03-2935-47b2-93d9-72e5200ad99f"
          }
        }
      }
    },
    {
      "id": "e69f54d8-eb06-495d-9e4e-fe42c8498e06",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T15:01:04+00:00",
        "updated_at": "2023-02-07T15:01:04+00:00",
        "menu_id": "8758e78f-df50-4b1a-9a28-c99e7ff8f848",
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
            "related": "api/boomerang/menus/8758e78f-df50-4b1a-9a28-c99e7ff8f848"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e69f54d8-eb06-495d-9e4e-fe42c8498e06"
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
    "id": "4e114eb9-cbc5-44f9-8b1a-b357400547b3",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T15:01:05+00:00",
      "updated_at": "2023-02-07T15:01:05+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f79c2176-3056-410e-8399-515859a16a20' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f79c2176-3056-410e-8399-515859a16a20",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "39624f7c-cf5a-42cf-a5f0-21eb0f8fc5ad",
              "title": "Contact us"
            },
            {
              "id": "cd5ce691-4f00-4977-8b5e-45b9ca8a1b50",
              "title": "Start"
            },
            {
              "id": "46576191-7f86-43a2-acf8-5d55d8bc0d6b",
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
    "id": "f79c2176-3056-410e-8399-515859a16a20",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T15:01:05+00:00",
      "updated_at": "2023-02-07T15:01:05+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "39624f7c-cf5a-42cf-a5f0-21eb0f8fc5ad"
          },
          {
            "type": "menu_items",
            "id": "cd5ce691-4f00-4977-8b5e-45b9ca8a1b50"
          },
          {
            "type": "menu_items",
            "id": "46576191-7f86-43a2-acf8-5d55d8bc0d6b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "39624f7c-cf5a-42cf-a5f0-21eb0f8fc5ad",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T15:01:05+00:00",
        "updated_at": "2023-02-07T15:01:05+00:00",
        "menu_id": "f79c2176-3056-410e-8399-515859a16a20",
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
      "id": "cd5ce691-4f00-4977-8b5e-45b9ca8a1b50",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T15:01:05+00:00",
        "updated_at": "2023-02-07T15:01:05+00:00",
        "menu_id": "f79c2176-3056-410e-8399-515859a16a20",
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
      "id": "46576191-7f86-43a2-acf8-5d55d8bc0d6b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T15:01:05+00:00",
        "updated_at": "2023-02-07T15:01:05+00:00",
        "menu_id": "f79c2176-3056-410e-8399-515859a16a20",
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
    --url 'https://example.booqable.com/api/boomerang/menus/e5295fb2-9911-4dfe-929b-cec67e61be16' \
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