# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

`PUT /api/boomerang/menus/{id}`

`DELETE /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

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


## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/38f9003c-1d29-42c3-a8c4-c8eb867c5954?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "38f9003c-1d29-42c3-a8c4-c8eb867c5954",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-07T13:58:47+00:00",
      "updated_at": "2023-12-07T13:58:47+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=38f9003c-1d29-42c3-a8c4-c8eb867c5954"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "4bf032c4-64bc-44d9-b03d-8cf3344d9fe2"
          },
          {
            "type": "menu_items",
            "id": "14f48bce-4288-4cf7-a1ba-4696793e3cbb"
          },
          {
            "type": "menu_items",
            "id": "d7b89a41-28a9-41aa-990d-b3b793d5ec1e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4bf032c4-64bc-44d9-b03d-8cf3344d9fe2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-07T13:58:47+00:00",
        "updated_at": "2023-12-07T13:58:47+00:00",
        "menu_id": "38f9003c-1d29-42c3-a8c4-c8eb867c5954",
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
            "related": "api/boomerang/menus/38f9003c-1d29-42c3-a8c4-c8eb867c5954"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4bf032c4-64bc-44d9-b03d-8cf3344d9fe2"
          }
        }
      }
    },
    {
      "id": "14f48bce-4288-4cf7-a1ba-4696793e3cbb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-07T13:58:47+00:00",
        "updated_at": "2023-12-07T13:58:47+00:00",
        "menu_id": "38f9003c-1d29-42c3-a8c4-c8eb867c5954",
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
            "related": "api/boomerang/menus/38f9003c-1d29-42c3-a8c4-c8eb867c5954"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=14f48bce-4288-4cf7-a1ba-4696793e3cbb"
          }
        }
      }
    },
    {
      "id": "d7b89a41-28a9-41aa-990d-b3b793d5ec1e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-07T13:58:47+00:00",
        "updated_at": "2023-12-07T13:58:47+00:00",
        "menu_id": "38f9003c-1d29-42c3-a8c4-c8eb867c5954",
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
            "related": "api/boomerang/menus/38f9003c-1d29-42c3-a8c4-c8eb867c5954"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d7b89a41-28a9-41aa-990d-b3b793d5ec1e"
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
      "id": "97991ef4-cebc-4532-a60d-9d91e45497ad",
      "type": "menus",
      "attributes": {
        "created_at": "2023-12-07T13:58:48+00:00",
        "updated_at": "2023-12-07T13:58:48+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=97991ef4-cebc-4532-a60d-9d91e45497ad"
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










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/ca412eab-566a-498d-9664-50695c46240f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ca412eab-566a-498d-9664-50695c46240f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d094b6a7-ff8a-47ea-9a70-b0502de95f74",
              "title": "Contact us"
            },
            {
              "id": "5dfbf308-4132-43ed-992e-a86f1bcc392b",
              "title": "Start"
            },
            {
              "id": "cdf944e2-4da1-4379-8cd8-eb15baafae8b",
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
    "id": "ca412eab-566a-498d-9664-50695c46240f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-07T13:58:49+00:00",
      "updated_at": "2023-12-07T13:58:50+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d094b6a7-ff8a-47ea-9a70-b0502de95f74"
          },
          {
            "type": "menu_items",
            "id": "5dfbf308-4132-43ed-992e-a86f1bcc392b"
          },
          {
            "type": "menu_items",
            "id": "cdf944e2-4da1-4379-8cd8-eb15baafae8b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d094b6a7-ff8a-47ea-9a70-b0502de95f74",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-07T13:58:49+00:00",
        "updated_at": "2023-12-07T13:58:50+00:00",
        "menu_id": "ca412eab-566a-498d-9664-50695c46240f",
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
      "id": "5dfbf308-4132-43ed-992e-a86f1bcc392b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-07T13:58:49+00:00",
        "updated_at": "2023-12-07T13:58:50+00:00",
        "menu_id": "ca412eab-566a-498d-9664-50695c46240f",
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
      "id": "cdf944e2-4da1-4379-8cd8-eb15baafae8b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-07T13:58:49+00:00",
        "updated_at": "2023-12-07T13:58:50+00:00",
        "menu_id": "ca412eab-566a-498d-9664-50695c46240f",
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










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/ffb5c3b8-4c1d-4213-b978-2b7fd81662de' \
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
    "id": "13ce6318-dda2-405b-bd94-9dba6d6678fb",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-07T13:58:53+00:00",
      "updated_at": "2023-12-07T13:58:53+00:00",
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









