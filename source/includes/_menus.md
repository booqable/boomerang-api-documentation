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
      "id": "b3afd7d7-aa97-410f-a3de-52eff1372bdb",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-22T08:41:21+00:00",
        "updated_at": "2023-02-22T08:41:21+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=b3afd7d7-aa97-410f-a3de-52eff1372bdb"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T08:39:28Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/74b9e621-f8a2-434d-93b6-b134b3261292?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "74b9e621-f8a2-434d-93b6-b134b3261292",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-22T08:41:21+00:00",
      "updated_at": "2023-02-22T08:41:21+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=74b9e621-f8a2-434d-93b6-b134b3261292"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "03e7c977-600f-4ce0-ada7-2cb8c385406c"
          },
          {
            "type": "menu_items",
            "id": "fa8a5beb-961b-4e33-b1f6-8fe26acb2f75"
          },
          {
            "type": "menu_items",
            "id": "b4430378-0f91-4527-9d56-9a00b619b95c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "03e7c977-600f-4ce0-ada7-2cb8c385406c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T08:41:21+00:00",
        "updated_at": "2023-02-22T08:41:21+00:00",
        "menu_id": "74b9e621-f8a2-434d-93b6-b134b3261292",
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
            "related": "api/boomerang/menus/74b9e621-f8a2-434d-93b6-b134b3261292"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=03e7c977-600f-4ce0-ada7-2cb8c385406c"
          }
        }
      }
    },
    {
      "id": "fa8a5beb-961b-4e33-b1f6-8fe26acb2f75",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T08:41:21+00:00",
        "updated_at": "2023-02-22T08:41:21+00:00",
        "menu_id": "74b9e621-f8a2-434d-93b6-b134b3261292",
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
            "related": "api/boomerang/menus/74b9e621-f8a2-434d-93b6-b134b3261292"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fa8a5beb-961b-4e33-b1f6-8fe26acb2f75"
          }
        }
      }
    },
    {
      "id": "b4430378-0f91-4527-9d56-9a00b619b95c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T08:41:21+00:00",
        "updated_at": "2023-02-22T08:41:21+00:00",
        "menu_id": "74b9e621-f8a2-434d-93b6-b134b3261292",
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
            "related": "api/boomerang/menus/74b9e621-f8a2-434d-93b6-b134b3261292"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b4430378-0f91-4527-9d56-9a00b619b95c"
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
    "id": "48b143b7-a298-487e-822e-a1e68c786f6e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-22T08:41:22+00:00",
      "updated_at": "2023-02-22T08:41:22+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6075a844-ef81-42df-8be0-baabb1ef33ea' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6075a844-ef81-42df-8be0-baabb1ef33ea",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e5a930ca-475d-4e45-8cb5-1c46621d10e1",
              "title": "Contact us"
            },
            {
              "id": "d8e30074-2762-452a-aba1-384d4deedf55",
              "title": "Start"
            },
            {
              "id": "cea33db9-8ffc-4f19-921e-72663dffdb4d",
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
    "id": "6075a844-ef81-42df-8be0-baabb1ef33ea",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-22T08:41:22+00:00",
      "updated_at": "2023-02-22T08:41:22+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e5a930ca-475d-4e45-8cb5-1c46621d10e1"
          },
          {
            "type": "menu_items",
            "id": "d8e30074-2762-452a-aba1-384d4deedf55"
          },
          {
            "type": "menu_items",
            "id": "cea33db9-8ffc-4f19-921e-72663dffdb4d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e5a930ca-475d-4e45-8cb5-1c46621d10e1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T08:41:22+00:00",
        "updated_at": "2023-02-22T08:41:22+00:00",
        "menu_id": "6075a844-ef81-42df-8be0-baabb1ef33ea",
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
      "id": "d8e30074-2762-452a-aba1-384d4deedf55",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T08:41:22+00:00",
        "updated_at": "2023-02-22T08:41:22+00:00",
        "menu_id": "6075a844-ef81-42df-8be0-baabb1ef33ea",
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
      "id": "cea33db9-8ffc-4f19-921e-72663dffdb4d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T08:41:22+00:00",
        "updated_at": "2023-02-22T08:41:22+00:00",
        "menu_id": "6075a844-ef81-42df-8be0-baabb1ef33ea",
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
    --url 'https://example.booqable.com/api/boomerang/menus/4d8b62ea-e63b-4c03-8dfc-14ad96812031' \
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