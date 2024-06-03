# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus`

`POST /api/boomerang/menus`

`PUT /api/boomerang/menus/{id}`

`GET /api/boomerang/menus/{id}`

`DELETE /api/boomerang/menus/{id}`

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
      "id": "1e1f8be5-0a06-4542-a1e3-73b2c7c0acd8",
      "type": "menus",
      "attributes": {
        "created_at": "2024-06-03T09:26:09.544227+00:00",
        "updated_at": "2024-06-03T09:26:09.544227+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=1e1f8be5-0a06-4542-a1e3-73b2c7c0acd8"
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
    "id": "28bc5fbe-cc3d-4882-869f-ff74b2376f9d",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-03T09:26:10.306952+00:00",
      "updated_at": "2024-06-03T09:26:10.306952+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9b8ac1fa-bae7-42b5-8b06-39968d44e82c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9b8ac1fa-bae7-42b5-8b06-39968d44e82c",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "bb8df81a-6ee9-464e-8ca2-61c6f9e444b7",
              "title": "Contact us"
            },
            {
              "id": "520158a2-caf3-420b-a5f5-b6f661c4dc62",
              "title": "Start"
            },
            {
              "id": "d93b003d-5c4a-46ae-a42f-3535b77f6bfc",
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
    "id": "9b8ac1fa-bae7-42b5-8b06-39968d44e82c",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-03T09:26:10.874546+00:00",
      "updated_at": "2024-06-03T09:26:10.950809+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "bb8df81a-6ee9-464e-8ca2-61c6f9e444b7"
          },
          {
            "type": "menu_items",
            "id": "520158a2-caf3-420b-a5f5-b6f661c4dc62"
          },
          {
            "type": "menu_items",
            "id": "d93b003d-5c4a-46ae-a42f-3535b77f6bfc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bb8df81a-6ee9-464e-8ca2-61c6f9e444b7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-03T09:26:10.878160+00:00",
        "updated_at": "2024-06-03T09:26:10.954892+00:00",
        "menu_id": "9b8ac1fa-bae7-42b5-8b06-39968d44e82c",
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
      "id": "520158a2-caf3-420b-a5f5-b6f661c4dc62",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-03T09:26:10.882109+00:00",
        "updated_at": "2024-06-03T09:26:10.958943+00:00",
        "menu_id": "9b8ac1fa-bae7-42b5-8b06-39968d44e82c",
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
      "id": "d93b003d-5c4a-46ae-a42f-3535b77f6bfc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-03T09:26:10.885770+00:00",
        "updated_at": "2024-06-03T09:26:10.962727+00:00",
        "menu_id": "9b8ac1fa-bae7-42b5-8b06-39968d44e82c",
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










## Fetching a menu



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/f848b36f-a641-4225-a7f7-e1b668561001?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f848b36f-a641-4225-a7f7-e1b668561001",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-03T09:26:11.522146+00:00",
      "updated_at": "2024-06-03T09:26:11.522146+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=f848b36f-a641-4225-a7f7-e1b668561001"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ab9efcd7-4824-44ba-8620-635e4fa398df"
          },
          {
            "type": "menu_items",
            "id": "f8a46f1b-a0e6-4930-b353-63acab009a2e"
          },
          {
            "type": "menu_items",
            "id": "40096a91-3e31-448c-a47b-6ba47fe96854"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ab9efcd7-4824-44ba-8620-635e4fa398df",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-03T09:26:11.525798+00:00",
        "updated_at": "2024-06-03T09:26:11.525798+00:00",
        "menu_id": "f848b36f-a641-4225-a7f7-e1b668561001",
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
            "related": "api/boomerang/menus/f848b36f-a641-4225-a7f7-e1b668561001"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ab9efcd7-4824-44ba-8620-635e4fa398df"
          }
        }
      }
    },
    {
      "id": "f8a46f1b-a0e6-4930-b353-63acab009a2e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-03T09:26:11.529907+00:00",
        "updated_at": "2024-06-03T09:26:11.529907+00:00",
        "menu_id": "f848b36f-a641-4225-a7f7-e1b668561001",
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
            "related": "api/boomerang/menus/f848b36f-a641-4225-a7f7-e1b668561001"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f8a46f1b-a0e6-4930-b353-63acab009a2e"
          }
        }
      }
    },
    {
      "id": "40096a91-3e31-448c-a47b-6ba47fe96854",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-03T09:26:11.533138+00:00",
        "updated_at": "2024-06-03T09:26:11.533138+00:00",
        "menu_id": "f848b36f-a641-4225-a7f7-e1b668561001",
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
            "related": "api/boomerang/menus/f848b36f-a641-4225-a7f7-e1b668561001"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=40096a91-3e31-448c-a47b-6ba47fe96854"
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






## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/3696f120-04af-441e-962b-21aa121a15c6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3696f120-04af-441e-962b-21aa121a15c6",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-03T09:26:12.178406+00:00",
      "updated_at": "2024-06-03T09:26:12.178406+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=3696f120-04af-441e-962b-21aa121a15c6"
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