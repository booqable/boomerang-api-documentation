# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus/{id}`

`DELETE /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

`PUT /api/boomerang/menus/{id}`

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


## Fetching a menu



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/d515cd36-5f95-484a-a4be-a728e612215b?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d515cd36-5f95-484a-a4be-a728e612215b",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-09T07:38:38+00:00",
      "updated_at": "2024-04-09T07:38:38+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=d515cd36-5f95-484a-a4be-a728e612215b"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "13cf6e07-283f-4d2d-b1df-2d23d35d49be"
          },
          {
            "type": "menu_items",
            "id": "8acf06df-d5a1-488f-b3f2-f2f93163c8d3"
          },
          {
            "type": "menu_items",
            "id": "23e2072e-8ad2-4225-8ff9-ef6bb28bee1f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "13cf6e07-283f-4d2d-b1df-2d23d35d49be",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-09T07:38:38+00:00",
        "updated_at": "2024-04-09T07:38:38+00:00",
        "menu_id": "d515cd36-5f95-484a-a4be-a728e612215b",
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
            "related": "api/boomerang/menus/d515cd36-5f95-484a-a4be-a728e612215b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=13cf6e07-283f-4d2d-b1df-2d23d35d49be"
          }
        }
      }
    },
    {
      "id": "8acf06df-d5a1-488f-b3f2-f2f93163c8d3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-09T07:38:38+00:00",
        "updated_at": "2024-04-09T07:38:38+00:00",
        "menu_id": "d515cd36-5f95-484a-a4be-a728e612215b",
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
            "related": "api/boomerang/menus/d515cd36-5f95-484a-a4be-a728e612215b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8acf06df-d5a1-488f-b3f2-f2f93163c8d3"
          }
        }
      }
    },
    {
      "id": "23e2072e-8ad2-4225-8ff9-ef6bb28bee1f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-09T07:38:38+00:00",
        "updated_at": "2024-04-09T07:38:38+00:00",
        "menu_id": "d515cd36-5f95-484a-a4be-a728e612215b",
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
            "related": "api/boomerang/menus/d515cd36-5f95-484a-a4be-a728e612215b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=23e2072e-8ad2-4225-8ff9-ef6bb28bee1f"
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
    --url 'https://example.booqable.com/api/boomerang/menus/ff6d1f4e-b454-4f11-b20a-b4d2f91c333e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ff6d1f4e-b454-4f11-b20a-b4d2f91c333e",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-09T07:38:39+00:00",
      "updated_at": "2024-04-09T07:38:39+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=ff6d1f4e-b454-4f11-b20a-b4d2f91c333e"
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
      "id": "88410d61-b393-4d06-9215-5843221071e0",
      "type": "menus",
      "attributes": {
        "created_at": "2024-04-09T07:38:40+00:00",
        "updated_at": "2024-04-09T07:38:40+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=88410d61-b393-4d06-9215-5843221071e0"
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
    --url 'https://example.booqable.com/api/boomerang/menus/ddcc1488-b54a-4378-9b93-89d24d345dc2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ddcc1488-b54a-4378-9b93-89d24d345dc2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d17e2be0-9e9b-4137-8211-5aba86d6cdc1",
              "title": "Contact us"
            },
            {
              "id": "21465983-0422-49af-a9cc-ff8b55ba3060",
              "title": "Start"
            },
            {
              "id": "a2134e89-3c32-4de2-998d-f19e671f8380",
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
    "id": "ddcc1488-b54a-4378-9b93-89d24d345dc2",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-09T07:38:40+00:00",
      "updated_at": "2024-04-09T07:38:40+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d17e2be0-9e9b-4137-8211-5aba86d6cdc1"
          },
          {
            "type": "menu_items",
            "id": "21465983-0422-49af-a9cc-ff8b55ba3060"
          },
          {
            "type": "menu_items",
            "id": "a2134e89-3c32-4de2-998d-f19e671f8380"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d17e2be0-9e9b-4137-8211-5aba86d6cdc1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-09T07:38:40+00:00",
        "updated_at": "2024-04-09T07:38:40+00:00",
        "menu_id": "ddcc1488-b54a-4378-9b93-89d24d345dc2",
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
      "id": "21465983-0422-49af-a9cc-ff8b55ba3060",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-09T07:38:40+00:00",
        "updated_at": "2024-04-09T07:38:40+00:00",
        "menu_id": "ddcc1488-b54a-4378-9b93-89d24d345dc2",
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
      "id": "a2134e89-3c32-4de2-998d-f19e671f8380",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-09T07:38:40+00:00",
        "updated_at": "2024-04-09T07:38:40+00:00",
        "menu_id": "ddcc1488-b54a-4378-9b93-89d24d345dc2",
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
    "id": "c03f977c-3e81-4ae4-b9cd-b9f959ef7071",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-09T07:38:41+00:00",
      "updated_at": "2024-04-09T07:38:41+00:00",
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









