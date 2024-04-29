# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

`DELETE /api/boomerang/menus/{id}`

`PUT /api/boomerang/menus/{id}`

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


## Fetching a menu



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/b4574178-fa7b-40e7-a78e-9719aa21f2bb?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b4574178-fa7b-40e7-a78e-9719aa21f2bb",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-29T09:27:56+00:00",
      "updated_at": "2024-04-29T09:27:56+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b4574178-fa7b-40e7-a78e-9719aa21f2bb"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "cfa16910-f942-4c1d-9826-b875d2cd3df8"
          },
          {
            "type": "menu_items",
            "id": "4ff02cd1-9b83-4d2b-bdb4-13964841be1e"
          },
          {
            "type": "menu_items",
            "id": "58296773-1cda-45a5-b156-417892bc2cf3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cfa16910-f942-4c1d-9826-b875d2cd3df8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-29T09:27:56+00:00",
        "updated_at": "2024-04-29T09:27:56+00:00",
        "menu_id": "b4574178-fa7b-40e7-a78e-9719aa21f2bb",
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
            "related": "api/boomerang/menus/b4574178-fa7b-40e7-a78e-9719aa21f2bb"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cfa16910-f942-4c1d-9826-b875d2cd3df8"
          }
        }
      }
    },
    {
      "id": "4ff02cd1-9b83-4d2b-bdb4-13964841be1e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-29T09:27:56+00:00",
        "updated_at": "2024-04-29T09:27:56+00:00",
        "menu_id": "b4574178-fa7b-40e7-a78e-9719aa21f2bb",
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
            "related": "api/boomerang/menus/b4574178-fa7b-40e7-a78e-9719aa21f2bb"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4ff02cd1-9b83-4d2b-bdb4-13964841be1e"
          }
        }
      }
    },
    {
      "id": "58296773-1cda-45a5-b156-417892bc2cf3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-29T09:27:56+00:00",
        "updated_at": "2024-04-29T09:27:56+00:00",
        "menu_id": "b4574178-fa7b-40e7-a78e-9719aa21f2bb",
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
            "related": "api/boomerang/menus/b4574178-fa7b-40e7-a78e-9719aa21f2bb"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=58296773-1cda-45a5-b156-417892bc2cf3"
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
    "id": "9faed7a7-2b10-4cd3-8f31-f8212dceecf0",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-29T09:27:56+00:00",
      "updated_at": "2024-04-29T09:27:56+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/41fd68bc-17b3-4365-96da-729ff7fe9ada' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "41fd68bc-17b3-4365-96da-729ff7fe9ada",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-29T09:27:57+00:00",
      "updated_at": "2024-04-29T09:27:57+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=41fd68bc-17b3-4365-96da-729ff7fe9ada"
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
    --url 'https://example.booqable.com/api/boomerang/menus/24c5d013-9a5b-403d-874a-99148b8d001d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "24c5d013-9a5b-403d-874a-99148b8d001d",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "ea1ac8e9-60a1-4ab4-ad7c-4fdf00057cec",
              "title": "Contact us"
            },
            {
              "id": "65234324-7f2e-43b7-a735-3a8d5c070f9c",
              "title": "Start"
            },
            {
              "id": "93a55876-f9f0-4b92-b4f2-8a90e61a7147",
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
    "id": "24c5d013-9a5b-403d-874a-99148b8d001d",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-29T09:27:58+00:00",
      "updated_at": "2024-04-29T09:27:58+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "ea1ac8e9-60a1-4ab4-ad7c-4fdf00057cec"
          },
          {
            "type": "menu_items",
            "id": "65234324-7f2e-43b7-a735-3a8d5c070f9c"
          },
          {
            "type": "menu_items",
            "id": "93a55876-f9f0-4b92-b4f2-8a90e61a7147"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ea1ac8e9-60a1-4ab4-ad7c-4fdf00057cec",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-29T09:27:58+00:00",
        "updated_at": "2024-04-29T09:27:58+00:00",
        "menu_id": "24c5d013-9a5b-403d-874a-99148b8d001d",
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
      "id": "65234324-7f2e-43b7-a735-3a8d5c070f9c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-29T09:27:58+00:00",
        "updated_at": "2024-04-29T09:27:58+00:00",
        "menu_id": "24c5d013-9a5b-403d-874a-99148b8d001d",
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
      "id": "93a55876-f9f0-4b92-b4f2-8a90e61a7147",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-29T09:27:58+00:00",
        "updated_at": "2024-04-29T09:27:58+00:00",
        "menu_id": "24c5d013-9a5b-403d-874a-99148b8d001d",
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
      "id": "c93eecf1-3fbe-4f66-93fa-383773af227f",
      "type": "menus",
      "attributes": {
        "created_at": "2024-04-29T09:27:59+00:00",
        "updated_at": "2024-04-29T09:27:59+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=c93eecf1-3fbe-4f66-93fa-383773af227f"
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









