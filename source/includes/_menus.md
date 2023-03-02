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
      "id": "85026362-d391-4403-a693-c6fa2a277e5f",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-02T12:21:14+00:00",
        "updated_at": "2023-03-02T12:21:14+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=85026362-d391-4403-a693-c6fa2a277e5f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T12:18:43Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/8bc1cb42-fb85-4944-b5c8-de31317c1461?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8bc1cb42-fb85-4944-b5c8-de31317c1461",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-02T12:21:15+00:00",
      "updated_at": "2023-03-02T12:21:15+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=8bc1cb42-fb85-4944-b5c8-de31317c1461"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "bc81fc14-69f5-4912-afe5-4fdb93b6bd61"
          },
          {
            "type": "menu_items",
            "id": "4b4806b2-d63f-47e8-9494-61563bd1347b"
          },
          {
            "type": "menu_items",
            "id": "27a8fe5f-0615-409d-89ac-deac73fa91e3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bc81fc14-69f5-4912-afe5-4fdb93b6bd61",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T12:21:15+00:00",
        "updated_at": "2023-03-02T12:21:15+00:00",
        "menu_id": "8bc1cb42-fb85-4944-b5c8-de31317c1461",
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
            "related": "api/boomerang/menus/8bc1cb42-fb85-4944-b5c8-de31317c1461"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bc81fc14-69f5-4912-afe5-4fdb93b6bd61"
          }
        }
      }
    },
    {
      "id": "4b4806b2-d63f-47e8-9494-61563bd1347b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T12:21:15+00:00",
        "updated_at": "2023-03-02T12:21:15+00:00",
        "menu_id": "8bc1cb42-fb85-4944-b5c8-de31317c1461",
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
            "related": "api/boomerang/menus/8bc1cb42-fb85-4944-b5c8-de31317c1461"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4b4806b2-d63f-47e8-9494-61563bd1347b"
          }
        }
      }
    },
    {
      "id": "27a8fe5f-0615-409d-89ac-deac73fa91e3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T12:21:15+00:00",
        "updated_at": "2023-03-02T12:21:15+00:00",
        "menu_id": "8bc1cb42-fb85-4944-b5c8-de31317c1461",
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
            "related": "api/boomerang/menus/8bc1cb42-fb85-4944-b5c8-de31317c1461"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=27a8fe5f-0615-409d-89ac-deac73fa91e3"
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
    "id": "f31b2a04-be1f-4388-92cd-27bf687f8eec",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-02T12:21:15+00:00",
      "updated_at": "2023-03-02T12:21:15+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/76ea380e-04ce-4f9a-900e-32d46a7f937e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "76ea380e-04ce-4f9a-900e-32d46a7f937e",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "ecde7cd6-9026-45e6-bf2f-13bbe492a22e",
              "title": "Contact us"
            },
            {
              "id": "a47f0375-77ea-4e90-b4c4-87d1c19e311d",
              "title": "Start"
            },
            {
              "id": "d15aa41f-953b-44a7-8201-699b105ac879",
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
    "id": "76ea380e-04ce-4f9a-900e-32d46a7f937e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-02T12:21:15+00:00",
      "updated_at": "2023-03-02T12:21:15+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "ecde7cd6-9026-45e6-bf2f-13bbe492a22e"
          },
          {
            "type": "menu_items",
            "id": "a47f0375-77ea-4e90-b4c4-87d1c19e311d"
          },
          {
            "type": "menu_items",
            "id": "d15aa41f-953b-44a7-8201-699b105ac879"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ecde7cd6-9026-45e6-bf2f-13bbe492a22e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T12:21:15+00:00",
        "updated_at": "2023-03-02T12:21:15+00:00",
        "menu_id": "76ea380e-04ce-4f9a-900e-32d46a7f937e",
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
      "id": "a47f0375-77ea-4e90-b4c4-87d1c19e311d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T12:21:15+00:00",
        "updated_at": "2023-03-02T12:21:15+00:00",
        "menu_id": "76ea380e-04ce-4f9a-900e-32d46a7f937e",
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
      "id": "d15aa41f-953b-44a7-8201-699b105ac879",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T12:21:15+00:00",
        "updated_at": "2023-03-02T12:21:15+00:00",
        "menu_id": "76ea380e-04ce-4f9a-900e-32d46a7f937e",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5af7e649-7f7d-4fd6-8fc6-706ff97cb780' \
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