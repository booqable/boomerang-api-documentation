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
      "id": "2ee0c8b0-763f-49a4-8b94-d92e108a7993",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-02T14:15:46+00:00",
        "updated_at": "2023-02-02T14:15:46+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=2ee0c8b0-763f-49a4-8b94-d92e108a7993"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T14:13:30Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/03ec7fc6-ae19-4925-9aa8-297b8d25adec?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "03ec7fc6-ae19-4925-9aa8-297b8d25adec",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T14:15:46+00:00",
      "updated_at": "2023-02-02T14:15:46+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=03ec7fc6-ae19-4925-9aa8-297b8d25adec"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "4af10d2a-b6e6-4bd5-b916-8e42091fd6c9"
          },
          {
            "type": "menu_items",
            "id": "06bb0572-5a1e-47a5-97a6-fb9307b32621"
          },
          {
            "type": "menu_items",
            "id": "3d3fc3f1-e790-4043-a33e-af0db7ea6596"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4af10d2a-b6e6-4bd5-b916-8e42091fd6c9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T14:15:46+00:00",
        "updated_at": "2023-02-02T14:15:46+00:00",
        "menu_id": "03ec7fc6-ae19-4925-9aa8-297b8d25adec",
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
            "related": "api/boomerang/menus/03ec7fc6-ae19-4925-9aa8-297b8d25adec"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4af10d2a-b6e6-4bd5-b916-8e42091fd6c9"
          }
        }
      }
    },
    {
      "id": "06bb0572-5a1e-47a5-97a6-fb9307b32621",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T14:15:46+00:00",
        "updated_at": "2023-02-02T14:15:46+00:00",
        "menu_id": "03ec7fc6-ae19-4925-9aa8-297b8d25adec",
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
            "related": "api/boomerang/menus/03ec7fc6-ae19-4925-9aa8-297b8d25adec"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=06bb0572-5a1e-47a5-97a6-fb9307b32621"
          }
        }
      }
    },
    {
      "id": "3d3fc3f1-e790-4043-a33e-af0db7ea6596",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T14:15:46+00:00",
        "updated_at": "2023-02-02T14:15:46+00:00",
        "menu_id": "03ec7fc6-ae19-4925-9aa8-297b8d25adec",
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
            "related": "api/boomerang/menus/03ec7fc6-ae19-4925-9aa8-297b8d25adec"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3d3fc3f1-e790-4043-a33e-af0db7ea6596"
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
    "id": "4b07fe9e-2736-4782-bb60-a1c4b26ac8f9",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T14:15:46+00:00",
      "updated_at": "2023-02-02T14:15:46+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7f58de4c-7857-4935-925b-7506db823ead' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7f58de4c-7857-4935-925b-7506db823ead",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "30b77787-bc1d-4a8b-8de7-5d3d09c5adf7",
              "title": "Contact us"
            },
            {
              "id": "843bd946-0ea7-4e87-8d7d-8dc76c31f7c5",
              "title": "Start"
            },
            {
              "id": "f7eed0ce-b21b-42de-b02f-5dbf80c8c0a9",
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
    "id": "7f58de4c-7857-4935-925b-7506db823ead",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T14:15:47+00:00",
      "updated_at": "2023-02-02T14:15:47+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "30b77787-bc1d-4a8b-8de7-5d3d09c5adf7"
          },
          {
            "type": "menu_items",
            "id": "843bd946-0ea7-4e87-8d7d-8dc76c31f7c5"
          },
          {
            "type": "menu_items",
            "id": "f7eed0ce-b21b-42de-b02f-5dbf80c8c0a9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "30b77787-bc1d-4a8b-8de7-5d3d09c5adf7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T14:15:47+00:00",
        "updated_at": "2023-02-02T14:15:47+00:00",
        "menu_id": "7f58de4c-7857-4935-925b-7506db823ead",
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
      "id": "843bd946-0ea7-4e87-8d7d-8dc76c31f7c5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T14:15:47+00:00",
        "updated_at": "2023-02-02T14:15:47+00:00",
        "menu_id": "7f58de4c-7857-4935-925b-7506db823ead",
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
      "id": "f7eed0ce-b21b-42de-b02f-5dbf80c8c0a9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T14:15:47+00:00",
        "updated_at": "2023-02-02T14:15:47+00:00",
        "menu_id": "7f58de4c-7857-4935-925b-7506db823ead",
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
    --url 'https://example.booqable.com/api/boomerang/menus/cca0df49-0f5e-40c3-9e0b-07ce91cf6d40' \
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