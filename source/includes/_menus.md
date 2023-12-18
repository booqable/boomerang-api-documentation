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
    --url 'https://example.booqable.com/api/boomerang/menus/a8e5028b-a546-4fc8-82b5-a711cfbb58c8' \
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
    --url 'https://example.booqable.com/api/boomerang/menus/12b94956-38df-4d2c-ab02-5a340fc8d95c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "12b94956-38df-4d2c-ab02-5a340fc8d95c",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "ff2d6a3a-bdef-467f-bede-14a1f8f289b2",
              "title": "Contact us"
            },
            {
              "id": "951a83fa-539c-4454-af2a-fa53f4a41705",
              "title": "Start"
            },
            {
              "id": "34c9f1de-73aa-45a7-a619-938cceddebcc",
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
    "id": "12b94956-38df-4d2c-ab02-5a340fc8d95c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-18T09:15:42+00:00",
      "updated_at": "2023-12-18T09:15:42+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "ff2d6a3a-bdef-467f-bede-14a1f8f289b2"
          },
          {
            "type": "menu_items",
            "id": "951a83fa-539c-4454-af2a-fa53f4a41705"
          },
          {
            "type": "menu_items",
            "id": "34c9f1de-73aa-45a7-a619-938cceddebcc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ff2d6a3a-bdef-467f-bede-14a1f8f289b2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-18T09:15:42+00:00",
        "updated_at": "2023-12-18T09:15:42+00:00",
        "menu_id": "12b94956-38df-4d2c-ab02-5a340fc8d95c",
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
      "id": "951a83fa-539c-4454-af2a-fa53f4a41705",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-18T09:15:42+00:00",
        "updated_at": "2023-12-18T09:15:42+00:00",
        "menu_id": "12b94956-38df-4d2c-ab02-5a340fc8d95c",
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
      "id": "34c9f1de-73aa-45a7-a619-938cceddebcc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-18T09:15:42+00:00",
        "updated_at": "2023-12-18T09:15:42+00:00",
        "menu_id": "12b94956-38df-4d2c-ab02-5a340fc8d95c",
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
    "id": "f2e49c4c-e45d-4b8c-b7ae-ab0c837361f4",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-18T09:15:43+00:00",
      "updated_at": "2023-12-18T09:15:43+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/86d5dbc1-cfae-48c2-9e60-c55637025f50?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "86d5dbc1-cfae-48c2-9e60-c55637025f50",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-18T09:15:45+00:00",
      "updated_at": "2023-12-18T09:15:45+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=86d5dbc1-cfae-48c2-9e60-c55637025f50"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "52604157-ef87-48ef-8f23-e742ae686f84"
          },
          {
            "type": "menu_items",
            "id": "d5183f10-a5d0-491e-ae9e-b104599437b0"
          },
          {
            "type": "menu_items",
            "id": "0d68080e-316e-4b0c-9ab1-05ea4f2a5940"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "52604157-ef87-48ef-8f23-e742ae686f84",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-18T09:15:45+00:00",
        "updated_at": "2023-12-18T09:15:45+00:00",
        "menu_id": "86d5dbc1-cfae-48c2-9e60-c55637025f50",
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
            "related": "api/boomerang/menus/86d5dbc1-cfae-48c2-9e60-c55637025f50"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=52604157-ef87-48ef-8f23-e742ae686f84"
          }
        }
      }
    },
    {
      "id": "d5183f10-a5d0-491e-ae9e-b104599437b0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-18T09:15:45+00:00",
        "updated_at": "2023-12-18T09:15:45+00:00",
        "menu_id": "86d5dbc1-cfae-48c2-9e60-c55637025f50",
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
            "related": "api/boomerang/menus/86d5dbc1-cfae-48c2-9e60-c55637025f50"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d5183f10-a5d0-491e-ae9e-b104599437b0"
          }
        }
      }
    },
    {
      "id": "0d68080e-316e-4b0c-9ab1-05ea4f2a5940",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-18T09:15:45+00:00",
        "updated_at": "2023-12-18T09:15:45+00:00",
        "menu_id": "86d5dbc1-cfae-48c2-9e60-c55637025f50",
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
            "related": "api/boomerang/menus/86d5dbc1-cfae-48c2-9e60-c55637025f50"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0d68080e-316e-4b0c-9ab1-05ea4f2a5940"
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
      "id": "361d3706-f86c-4d20-a8e1-1f6b33df1064",
      "type": "menus",
      "attributes": {
        "created_at": "2023-12-18T09:15:46+00:00",
        "updated_at": "2023-12-18T09:15:46+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=361d3706-f86c-4d20-a8e1-1f6b33df1064"
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









