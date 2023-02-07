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
      "id": "635e6157-ff5b-436e-b1d0-034dd3148dd8",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-07T09:28:22+00:00",
        "updated_at": "2023-02-07T09:28:22+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=635e6157-ff5b-436e-b1d0-034dd3148dd8"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T09:26:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/ccb79ecd-42bb-4a29-be5a-45bc25757efc?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ccb79ecd-42bb-4a29-be5a-45bc25757efc",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T09:28:23+00:00",
      "updated_at": "2023-02-07T09:28:23+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=ccb79ecd-42bb-4a29-be5a-45bc25757efc"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "7b3aa4a6-9916-4ed7-af7c-1b83193cf81b"
          },
          {
            "type": "menu_items",
            "id": "61b212a7-2f95-4e50-a369-6b8cbacbc8e6"
          },
          {
            "type": "menu_items",
            "id": "6cea450c-3a67-415b-940e-adb090363c5f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7b3aa4a6-9916-4ed7-af7c-1b83193cf81b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T09:28:23+00:00",
        "updated_at": "2023-02-07T09:28:23+00:00",
        "menu_id": "ccb79ecd-42bb-4a29-be5a-45bc25757efc",
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
            "related": "api/boomerang/menus/ccb79ecd-42bb-4a29-be5a-45bc25757efc"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7b3aa4a6-9916-4ed7-af7c-1b83193cf81b"
          }
        }
      }
    },
    {
      "id": "61b212a7-2f95-4e50-a369-6b8cbacbc8e6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T09:28:23+00:00",
        "updated_at": "2023-02-07T09:28:23+00:00",
        "menu_id": "ccb79ecd-42bb-4a29-be5a-45bc25757efc",
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
            "related": "api/boomerang/menus/ccb79ecd-42bb-4a29-be5a-45bc25757efc"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=61b212a7-2f95-4e50-a369-6b8cbacbc8e6"
          }
        }
      }
    },
    {
      "id": "6cea450c-3a67-415b-940e-adb090363c5f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T09:28:23+00:00",
        "updated_at": "2023-02-07T09:28:23+00:00",
        "menu_id": "ccb79ecd-42bb-4a29-be5a-45bc25757efc",
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
            "related": "api/boomerang/menus/ccb79ecd-42bb-4a29-be5a-45bc25757efc"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6cea450c-3a67-415b-940e-adb090363c5f"
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
    "id": "0ab68290-7412-4047-be47-1fa18195ed03",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T09:28:23+00:00",
      "updated_at": "2023-02-07T09:28:23+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6be3d1ea-36f8-4b8f-9d9a-87e84064db8b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6be3d1ea-36f8-4b8f-9d9a-87e84064db8b",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e8a97188-9681-46c0-baab-74b4b032fe90",
              "title": "Contact us"
            },
            {
              "id": "79f7b620-f9f7-43d1-9ce5-4263f9375be4",
              "title": "Start"
            },
            {
              "id": "fdbdd996-dbc6-4419-b37c-8a3dda3910fc",
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
    "id": "6be3d1ea-36f8-4b8f-9d9a-87e84064db8b",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T09:28:23+00:00",
      "updated_at": "2023-02-07T09:28:23+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e8a97188-9681-46c0-baab-74b4b032fe90"
          },
          {
            "type": "menu_items",
            "id": "79f7b620-f9f7-43d1-9ce5-4263f9375be4"
          },
          {
            "type": "menu_items",
            "id": "fdbdd996-dbc6-4419-b37c-8a3dda3910fc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e8a97188-9681-46c0-baab-74b4b032fe90",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T09:28:23+00:00",
        "updated_at": "2023-02-07T09:28:23+00:00",
        "menu_id": "6be3d1ea-36f8-4b8f-9d9a-87e84064db8b",
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
      "id": "79f7b620-f9f7-43d1-9ce5-4263f9375be4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T09:28:23+00:00",
        "updated_at": "2023-02-07T09:28:23+00:00",
        "menu_id": "6be3d1ea-36f8-4b8f-9d9a-87e84064db8b",
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
      "id": "fdbdd996-dbc6-4419-b37c-8a3dda3910fc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T09:28:23+00:00",
        "updated_at": "2023-02-07T09:28:23+00:00",
        "menu_id": "6be3d1ea-36f8-4b8f-9d9a-87e84064db8b",
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
    --url 'https://example.booqable.com/api/boomerang/menus/588b5ead-ee20-4f6b-9fcc-1e5471165a7e' \
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