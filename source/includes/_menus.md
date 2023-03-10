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
      "id": "844dc68d-5659-4879-b26e-f7b893b5e971",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-10T08:38:03+00:00",
        "updated_at": "2023-03-10T08:38:03+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=844dc68d-5659-4879-b26e-f7b893b5e971"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-10T08:36:03Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/6be5e4d1-707d-43b6-9cab-b7113b1f22a6?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6be5e4d1-707d-43b6-9cab-b7113b1f22a6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-10T08:38:04+00:00",
      "updated_at": "2023-03-10T08:38:04+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=6be5e4d1-707d-43b6-9cab-b7113b1f22a6"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "87dc4c39-57f7-4709-b8a8-421228bb99c0"
          },
          {
            "type": "menu_items",
            "id": "fa5887be-7ac7-46a5-b328-ec42cb844c1d"
          },
          {
            "type": "menu_items",
            "id": "c157f8c2-be9a-409b-beaf-bf6330d419ba"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "87dc4c39-57f7-4709-b8a8-421228bb99c0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-10T08:38:04+00:00",
        "updated_at": "2023-03-10T08:38:04+00:00",
        "menu_id": "6be5e4d1-707d-43b6-9cab-b7113b1f22a6",
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
            "related": "api/boomerang/menus/6be5e4d1-707d-43b6-9cab-b7113b1f22a6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=87dc4c39-57f7-4709-b8a8-421228bb99c0"
          }
        }
      }
    },
    {
      "id": "fa5887be-7ac7-46a5-b328-ec42cb844c1d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-10T08:38:04+00:00",
        "updated_at": "2023-03-10T08:38:04+00:00",
        "menu_id": "6be5e4d1-707d-43b6-9cab-b7113b1f22a6",
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
            "related": "api/boomerang/menus/6be5e4d1-707d-43b6-9cab-b7113b1f22a6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fa5887be-7ac7-46a5-b328-ec42cb844c1d"
          }
        }
      }
    },
    {
      "id": "c157f8c2-be9a-409b-beaf-bf6330d419ba",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-10T08:38:04+00:00",
        "updated_at": "2023-03-10T08:38:04+00:00",
        "menu_id": "6be5e4d1-707d-43b6-9cab-b7113b1f22a6",
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
            "related": "api/boomerang/menus/6be5e4d1-707d-43b6-9cab-b7113b1f22a6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c157f8c2-be9a-409b-beaf-bf6330d419ba"
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
    "id": "aac184e3-85ef-4e95-82a5-69fcf0235d76",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-10T08:38:04+00:00",
      "updated_at": "2023-03-10T08:38:04+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/11c93ccb-fe29-44cf-a708-471886199c70' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "11c93ccb-fe29-44cf-a708-471886199c70",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "56762c7c-443f-41a2-87d1-da6827d5c0c4",
              "title": "Contact us"
            },
            {
              "id": "1c746716-e20a-4420-a78f-51d4ff70d528",
              "title": "Start"
            },
            {
              "id": "114c21df-8003-4c3a-8976-192ddd70a715",
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
    "id": "11c93ccb-fe29-44cf-a708-471886199c70",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-10T08:38:05+00:00",
      "updated_at": "2023-03-10T08:38:05+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "56762c7c-443f-41a2-87d1-da6827d5c0c4"
          },
          {
            "type": "menu_items",
            "id": "1c746716-e20a-4420-a78f-51d4ff70d528"
          },
          {
            "type": "menu_items",
            "id": "114c21df-8003-4c3a-8976-192ddd70a715"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "56762c7c-443f-41a2-87d1-da6827d5c0c4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-10T08:38:05+00:00",
        "updated_at": "2023-03-10T08:38:05+00:00",
        "menu_id": "11c93ccb-fe29-44cf-a708-471886199c70",
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
      "id": "1c746716-e20a-4420-a78f-51d4ff70d528",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-10T08:38:05+00:00",
        "updated_at": "2023-03-10T08:38:05+00:00",
        "menu_id": "11c93ccb-fe29-44cf-a708-471886199c70",
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
      "id": "114c21df-8003-4c3a-8976-192ddd70a715",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-10T08:38:05+00:00",
        "updated_at": "2023-03-10T08:38:05+00:00",
        "menu_id": "11c93ccb-fe29-44cf-a708-471886199c70",
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
    --url 'https://example.booqable.com/api/boomerang/menus/08ece264-3ad7-4219-954d-ad0b9f23ca27' \
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