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
      "id": "519b0e6d-8441-493e-947b-fc7607c436ce",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-14T11:05:23+00:00",
        "updated_at": "2023-02-14T11:05:23+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=519b0e6d-8441-493e-947b-fc7607c436ce"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T11:03:31Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/c2745645-2d73-40a2-ac18-61185233e8d3?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c2745645-2d73-40a2-ac18-61185233e8d3",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T11:05:24+00:00",
      "updated_at": "2023-02-14T11:05:24+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=c2745645-2d73-40a2-ac18-61185233e8d3"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "a06d3ec8-e57b-465d-8086-1db60c0f4f94"
          },
          {
            "type": "menu_items",
            "id": "40324550-b26a-4ff5-ac3d-eb71e3772397"
          },
          {
            "type": "menu_items",
            "id": "f28b0497-7e02-422e-bc14-09b62796d0c4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a06d3ec8-e57b-465d-8086-1db60c0f4f94",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:05:24+00:00",
        "updated_at": "2023-02-14T11:05:24+00:00",
        "menu_id": "c2745645-2d73-40a2-ac18-61185233e8d3",
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
            "related": "api/boomerang/menus/c2745645-2d73-40a2-ac18-61185233e8d3"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a06d3ec8-e57b-465d-8086-1db60c0f4f94"
          }
        }
      }
    },
    {
      "id": "40324550-b26a-4ff5-ac3d-eb71e3772397",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:05:24+00:00",
        "updated_at": "2023-02-14T11:05:24+00:00",
        "menu_id": "c2745645-2d73-40a2-ac18-61185233e8d3",
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
            "related": "api/boomerang/menus/c2745645-2d73-40a2-ac18-61185233e8d3"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=40324550-b26a-4ff5-ac3d-eb71e3772397"
          }
        }
      }
    },
    {
      "id": "f28b0497-7e02-422e-bc14-09b62796d0c4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:05:24+00:00",
        "updated_at": "2023-02-14T11:05:24+00:00",
        "menu_id": "c2745645-2d73-40a2-ac18-61185233e8d3",
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
            "related": "api/boomerang/menus/c2745645-2d73-40a2-ac18-61185233e8d3"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f28b0497-7e02-422e-bc14-09b62796d0c4"
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
    "id": "5f2fb1bd-7e98-4d2d-8987-d10c27d10b8b",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T11:05:24+00:00",
      "updated_at": "2023-02-14T11:05:24+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/866cfdd6-d9c6-4fc5-90b4-6e3dab087490' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "866cfdd6-d9c6-4fc5-90b4-6e3dab087490",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "2108443c-8039-4e15-aa73-18fc6dd84616",
              "title": "Contact us"
            },
            {
              "id": "7074f524-7429-4c03-907a-c3a291352f98",
              "title": "Start"
            },
            {
              "id": "9136c455-84bb-4dfd-8884-3b30b77fdfa2",
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
    "id": "866cfdd6-d9c6-4fc5-90b4-6e3dab087490",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T11:05:25+00:00",
      "updated_at": "2023-02-14T11:05:25+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "2108443c-8039-4e15-aa73-18fc6dd84616"
          },
          {
            "type": "menu_items",
            "id": "7074f524-7429-4c03-907a-c3a291352f98"
          },
          {
            "type": "menu_items",
            "id": "9136c455-84bb-4dfd-8884-3b30b77fdfa2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2108443c-8039-4e15-aa73-18fc6dd84616",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:05:25+00:00",
        "updated_at": "2023-02-14T11:05:25+00:00",
        "menu_id": "866cfdd6-d9c6-4fc5-90b4-6e3dab087490",
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
      "id": "7074f524-7429-4c03-907a-c3a291352f98",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:05:25+00:00",
        "updated_at": "2023-02-14T11:05:25+00:00",
        "menu_id": "866cfdd6-d9c6-4fc5-90b4-6e3dab087490",
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
      "id": "9136c455-84bb-4dfd-8884-3b30b77fdfa2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:05:25+00:00",
        "updated_at": "2023-02-14T11:05:25+00:00",
        "menu_id": "866cfdd6-d9c6-4fc5-90b4-6e3dab087490",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1d27592a-8a6e-4dcb-806b-fd282c6de20f' \
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