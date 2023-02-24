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
      "id": "36f97768-c33b-4959-9440-86c82c13e388",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-24T08:54:02+00:00",
        "updated_at": "2023-02-24T08:54:02+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=36f97768-c33b-4959-9440-86c82c13e388"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T08:52:15Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/eecd1d5e-ed13-43d1-a8ef-5b47570f48ce?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eecd1d5e-ed13-43d1-a8ef-5b47570f48ce",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T08:54:02+00:00",
      "updated_at": "2023-02-24T08:54:02+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=eecd1d5e-ed13-43d1-a8ef-5b47570f48ce"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "a59e0970-1d44-487a-9bbe-73f8b2b5e482"
          },
          {
            "type": "menu_items",
            "id": "2f7a9771-0eab-441c-b0f4-3e3800497b42"
          },
          {
            "type": "menu_items",
            "id": "b1876778-db77-476b-9a83-d121738fe22b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a59e0970-1d44-487a-9bbe-73f8b2b5e482",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T08:54:02+00:00",
        "updated_at": "2023-02-24T08:54:02+00:00",
        "menu_id": "eecd1d5e-ed13-43d1-a8ef-5b47570f48ce",
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
            "related": "api/boomerang/menus/eecd1d5e-ed13-43d1-a8ef-5b47570f48ce"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a59e0970-1d44-487a-9bbe-73f8b2b5e482"
          }
        }
      }
    },
    {
      "id": "2f7a9771-0eab-441c-b0f4-3e3800497b42",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T08:54:02+00:00",
        "updated_at": "2023-02-24T08:54:02+00:00",
        "menu_id": "eecd1d5e-ed13-43d1-a8ef-5b47570f48ce",
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
            "related": "api/boomerang/menus/eecd1d5e-ed13-43d1-a8ef-5b47570f48ce"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2f7a9771-0eab-441c-b0f4-3e3800497b42"
          }
        }
      }
    },
    {
      "id": "b1876778-db77-476b-9a83-d121738fe22b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T08:54:02+00:00",
        "updated_at": "2023-02-24T08:54:02+00:00",
        "menu_id": "eecd1d5e-ed13-43d1-a8ef-5b47570f48ce",
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
            "related": "api/boomerang/menus/eecd1d5e-ed13-43d1-a8ef-5b47570f48ce"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b1876778-db77-476b-9a83-d121738fe22b"
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
    "id": "8757c378-51a2-482f-a49e-b3e05326bd82",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T08:54:03+00:00",
      "updated_at": "2023-02-24T08:54:03+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d07bffcb-0ac2-4285-8a58-c83d77736ac8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d07bffcb-0ac2-4285-8a58-c83d77736ac8",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "dbe8b8e8-2b01-42c5-b063-796ef7aa76a8",
              "title": "Contact us"
            },
            {
              "id": "42f52032-3bd6-4227-b9c6-2266e04183d8",
              "title": "Start"
            },
            {
              "id": "b35b518f-315f-4f34-a969-a803ffa0445e",
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
    "id": "d07bffcb-0ac2-4285-8a58-c83d77736ac8",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T08:54:03+00:00",
      "updated_at": "2023-02-24T08:54:03+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "dbe8b8e8-2b01-42c5-b063-796ef7aa76a8"
          },
          {
            "type": "menu_items",
            "id": "42f52032-3bd6-4227-b9c6-2266e04183d8"
          },
          {
            "type": "menu_items",
            "id": "b35b518f-315f-4f34-a969-a803ffa0445e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dbe8b8e8-2b01-42c5-b063-796ef7aa76a8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T08:54:03+00:00",
        "updated_at": "2023-02-24T08:54:03+00:00",
        "menu_id": "d07bffcb-0ac2-4285-8a58-c83d77736ac8",
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
      "id": "42f52032-3bd6-4227-b9c6-2266e04183d8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T08:54:03+00:00",
        "updated_at": "2023-02-24T08:54:03+00:00",
        "menu_id": "d07bffcb-0ac2-4285-8a58-c83d77736ac8",
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
      "id": "b35b518f-315f-4f34-a969-a803ffa0445e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T08:54:03+00:00",
        "updated_at": "2023-02-24T08:54:03+00:00",
        "menu_id": "d07bffcb-0ac2-4285-8a58-c83d77736ac8",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1d130314-7553-456a-8739-12c0bf794fc7' \
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