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
      "id": "00d7bfa6-9bc5-468f-9732-e01e1146c450",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-16T22:57:04+00:00",
        "updated_at": "2023-02-16T22:57:04+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=00d7bfa6-9bc5-468f-9732-e01e1146c450"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T22:54:51Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/7ed7464e-63b2-47ef-a854-ca582f8ec4c9?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7ed7464e-63b2-47ef-a854-ca582f8ec4c9",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T22:57:05+00:00",
      "updated_at": "2023-02-16T22:57:05+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=7ed7464e-63b2-47ef-a854-ca582f8ec4c9"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "29bf5e4a-191b-4ce6-88ff-3eb92744524e"
          },
          {
            "type": "menu_items",
            "id": "1717a9d8-39d8-4e47-b41d-f06ea5487e84"
          },
          {
            "type": "menu_items",
            "id": "bd5de0f7-4fbe-4ecc-b3f4-a0b53a10e07b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "29bf5e4a-191b-4ce6-88ff-3eb92744524e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T22:57:05+00:00",
        "updated_at": "2023-02-16T22:57:05+00:00",
        "menu_id": "7ed7464e-63b2-47ef-a854-ca582f8ec4c9",
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
            "related": "api/boomerang/menus/7ed7464e-63b2-47ef-a854-ca582f8ec4c9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=29bf5e4a-191b-4ce6-88ff-3eb92744524e"
          }
        }
      }
    },
    {
      "id": "1717a9d8-39d8-4e47-b41d-f06ea5487e84",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T22:57:05+00:00",
        "updated_at": "2023-02-16T22:57:05+00:00",
        "menu_id": "7ed7464e-63b2-47ef-a854-ca582f8ec4c9",
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
            "related": "api/boomerang/menus/7ed7464e-63b2-47ef-a854-ca582f8ec4c9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1717a9d8-39d8-4e47-b41d-f06ea5487e84"
          }
        }
      }
    },
    {
      "id": "bd5de0f7-4fbe-4ecc-b3f4-a0b53a10e07b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T22:57:05+00:00",
        "updated_at": "2023-02-16T22:57:05+00:00",
        "menu_id": "7ed7464e-63b2-47ef-a854-ca582f8ec4c9",
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
            "related": "api/boomerang/menus/7ed7464e-63b2-47ef-a854-ca582f8ec4c9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bd5de0f7-4fbe-4ecc-b3f4-a0b53a10e07b"
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
    "id": "da20bcf0-33e6-4e4f-a7d8-d3a1feb96d36",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T22:57:05+00:00",
      "updated_at": "2023-02-16T22:57:05+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d1c5c31e-a4e7-46d3-aea3-0e5dea5928a2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d1c5c31e-a4e7-46d3-aea3-0e5dea5928a2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "177ecae4-63fe-47fe-8405-17d3f9617e50",
              "title": "Contact us"
            },
            {
              "id": "d2ff67e9-5727-42ad-9292-582c2e21811a",
              "title": "Start"
            },
            {
              "id": "51db4702-fd37-47e7-90be-c3455c948c6a",
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
    "id": "d1c5c31e-a4e7-46d3-aea3-0e5dea5928a2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T22:57:06+00:00",
      "updated_at": "2023-02-16T22:57:06+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "177ecae4-63fe-47fe-8405-17d3f9617e50"
          },
          {
            "type": "menu_items",
            "id": "d2ff67e9-5727-42ad-9292-582c2e21811a"
          },
          {
            "type": "menu_items",
            "id": "51db4702-fd37-47e7-90be-c3455c948c6a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "177ecae4-63fe-47fe-8405-17d3f9617e50",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T22:57:06+00:00",
        "updated_at": "2023-02-16T22:57:06+00:00",
        "menu_id": "d1c5c31e-a4e7-46d3-aea3-0e5dea5928a2",
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
      "id": "d2ff67e9-5727-42ad-9292-582c2e21811a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T22:57:06+00:00",
        "updated_at": "2023-02-16T22:57:06+00:00",
        "menu_id": "d1c5c31e-a4e7-46d3-aea3-0e5dea5928a2",
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
      "id": "51db4702-fd37-47e7-90be-c3455c948c6a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T22:57:06+00:00",
        "updated_at": "2023-02-16T22:57:06+00:00",
        "menu_id": "d1c5c31e-a4e7-46d3-aea3-0e5dea5928a2",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b9d20e60-0cb8-4cab-948c-55a725f6451c' \
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