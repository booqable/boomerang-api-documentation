# Menus

Allows creating and managing menus for your shop.

## Endpoints
`DELETE /api/boomerang/menus/{id}`

`PUT /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

`GET /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

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
    --url 'https://example.booqable.com/api/boomerang/menus/5e5c4d1c-67c7-4f3c-bfaf-ee395350d9bd' \
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
## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/a24b4e99-de67-4f1d-9d04-0ee07b653531' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a24b4e99-de67-4f1d-9d04-0ee07b653531",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "77a83bab-0c38-4f56-917b-ca77da5c4323",
              "title": "Contact us"
            },
            {
              "id": "aee8ac3c-bb65-4a16-bcc9-e16834fa064f",
              "title": "Start"
            },
            {
              "id": "eda6ccd3-6438-4e59-807c-6ac4eaf595bb",
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
    "id": "a24b4e99-de67-4f1d-9d04-0ee07b653531",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-25T09:17:39+00:00",
      "updated_at": "2023-12-25T09:17:39+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "77a83bab-0c38-4f56-917b-ca77da5c4323"
          },
          {
            "type": "menu_items",
            "id": "aee8ac3c-bb65-4a16-bcc9-e16834fa064f"
          },
          {
            "type": "menu_items",
            "id": "eda6ccd3-6438-4e59-807c-6ac4eaf595bb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "77a83bab-0c38-4f56-917b-ca77da5c4323",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-25T09:17:39+00:00",
        "updated_at": "2023-12-25T09:17:39+00:00",
        "menu_id": "a24b4e99-de67-4f1d-9d04-0ee07b653531",
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
      "id": "aee8ac3c-bb65-4a16-bcc9-e16834fa064f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-25T09:17:39+00:00",
        "updated_at": "2023-12-25T09:17:39+00:00",
        "menu_id": "a24b4e99-de67-4f1d-9d04-0ee07b653531",
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
      "id": "eda6ccd3-6438-4e59-807c-6ac4eaf595bb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-25T09:17:39+00:00",
        "updated_at": "2023-12-25T09:17:39+00:00",
        "menu_id": "a24b4e99-de67-4f1d-9d04-0ee07b653531",
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
    "id": "00810bda-3c90-4e05-885c-1c7af3959ae3",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-25T09:17:39+00:00",
      "updated_at": "2023-12-25T09:17:39+00:00",
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










## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/25ae28b7-d292-4c3d-a185-2c79db06dc9b?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "25ae28b7-d292-4c3d-a185-2c79db06dc9b",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-25T09:17:40+00:00",
      "updated_at": "2023-12-25T09:17:40+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=25ae28b7-d292-4c3d-a185-2c79db06dc9b"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ffcbec84-e35f-41d1-9ee5-6e07b3fdac77"
          },
          {
            "type": "menu_items",
            "id": "7b2e7ab0-e52d-48c8-9f17-22d70459c887"
          },
          {
            "type": "menu_items",
            "id": "2382dec3-a745-4667-865c-e7bbe2d5402f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ffcbec84-e35f-41d1-9ee5-6e07b3fdac77",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-25T09:17:40+00:00",
        "updated_at": "2023-12-25T09:17:40+00:00",
        "menu_id": "25ae28b7-d292-4c3d-a185-2c79db06dc9b",
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
            "related": "api/boomerang/menus/25ae28b7-d292-4c3d-a185-2c79db06dc9b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ffcbec84-e35f-41d1-9ee5-6e07b3fdac77"
          }
        }
      }
    },
    {
      "id": "7b2e7ab0-e52d-48c8-9f17-22d70459c887",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-25T09:17:40+00:00",
        "updated_at": "2023-12-25T09:17:40+00:00",
        "menu_id": "25ae28b7-d292-4c3d-a185-2c79db06dc9b",
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
            "related": "api/boomerang/menus/25ae28b7-d292-4c3d-a185-2c79db06dc9b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7b2e7ab0-e52d-48c8-9f17-22d70459c887"
          }
        }
      }
    },
    {
      "id": "2382dec3-a745-4667-865c-e7bbe2d5402f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-25T09:17:40+00:00",
        "updated_at": "2023-12-25T09:17:40+00:00",
        "menu_id": "25ae28b7-d292-4c3d-a185-2c79db06dc9b",
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
            "related": "api/boomerang/menus/25ae28b7-d292-4c3d-a185-2c79db06dc9b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2382dec3-a745-4667-865c-e7bbe2d5402f"
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
      "id": "7fb47bc6-2702-4be6-9b97-faf930ba35e0",
      "type": "menus",
      "attributes": {
        "created_at": "2023-12-25T09:17:41+00:00",
        "updated_at": "2023-12-25T09:17:41+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=7fb47bc6-2702-4be6-9b97-faf930ba35e0"
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









