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
      "id": "4a6308a7-f640-46c6-89c3-ea9d5ba5838d",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-28T11:27:25+00:00",
        "updated_at": "2023-02-28T11:27:25+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=4a6308a7-f640-46c6-89c3-ea9d5ba5838d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T11:25:29Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/13e3df49-bb60-4d48-afcc-44c2c3305236?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "13e3df49-bb60-4d48-afcc-44c2c3305236",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-28T11:27:25+00:00",
      "updated_at": "2023-02-28T11:27:25+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=13e3df49-bb60-4d48-afcc-44c2c3305236"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "630d747e-8ff5-4a4c-a547-d1218a4a8e97"
          },
          {
            "type": "menu_items",
            "id": "72e95b00-20d4-41b8-91a2-c0fe4080595c"
          },
          {
            "type": "menu_items",
            "id": "a0a433b0-5fd7-4608-a64d-b2361a7d60d4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "630d747e-8ff5-4a4c-a547-d1218a4a8e97",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T11:27:25+00:00",
        "updated_at": "2023-02-28T11:27:25+00:00",
        "menu_id": "13e3df49-bb60-4d48-afcc-44c2c3305236",
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
            "related": "api/boomerang/menus/13e3df49-bb60-4d48-afcc-44c2c3305236"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=630d747e-8ff5-4a4c-a547-d1218a4a8e97"
          }
        }
      }
    },
    {
      "id": "72e95b00-20d4-41b8-91a2-c0fe4080595c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T11:27:25+00:00",
        "updated_at": "2023-02-28T11:27:25+00:00",
        "menu_id": "13e3df49-bb60-4d48-afcc-44c2c3305236",
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
            "related": "api/boomerang/menus/13e3df49-bb60-4d48-afcc-44c2c3305236"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=72e95b00-20d4-41b8-91a2-c0fe4080595c"
          }
        }
      }
    },
    {
      "id": "a0a433b0-5fd7-4608-a64d-b2361a7d60d4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T11:27:25+00:00",
        "updated_at": "2023-02-28T11:27:25+00:00",
        "menu_id": "13e3df49-bb60-4d48-afcc-44c2c3305236",
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
            "related": "api/boomerang/menus/13e3df49-bb60-4d48-afcc-44c2c3305236"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a0a433b0-5fd7-4608-a64d-b2361a7d60d4"
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
    "id": "51635a19-c07c-4e63-af1f-09205ee4d19a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-28T11:27:25+00:00",
      "updated_at": "2023-02-28T11:27:25+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0378960a-5994-4540-9286-a9999cdb7942' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0378960a-5994-4540-9286-a9999cdb7942",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "dab78b76-e941-41d6-a473-73ed2efefbff",
              "title": "Contact us"
            },
            {
              "id": "2940a337-4adf-48a5-a1f4-6b6773cce91b",
              "title": "Start"
            },
            {
              "id": "b3c828d0-895f-4a54-a5ed-6121592e6804",
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
    "id": "0378960a-5994-4540-9286-a9999cdb7942",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-28T11:27:26+00:00",
      "updated_at": "2023-02-28T11:27:26+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "dab78b76-e941-41d6-a473-73ed2efefbff"
          },
          {
            "type": "menu_items",
            "id": "2940a337-4adf-48a5-a1f4-6b6773cce91b"
          },
          {
            "type": "menu_items",
            "id": "b3c828d0-895f-4a54-a5ed-6121592e6804"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dab78b76-e941-41d6-a473-73ed2efefbff",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T11:27:26+00:00",
        "updated_at": "2023-02-28T11:27:26+00:00",
        "menu_id": "0378960a-5994-4540-9286-a9999cdb7942",
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
      "id": "2940a337-4adf-48a5-a1f4-6b6773cce91b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T11:27:26+00:00",
        "updated_at": "2023-02-28T11:27:26+00:00",
        "menu_id": "0378960a-5994-4540-9286-a9999cdb7942",
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
      "id": "b3c828d0-895f-4a54-a5ed-6121592e6804",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T11:27:26+00:00",
        "updated_at": "2023-02-28T11:27:26+00:00",
        "menu_id": "0378960a-5994-4540-9286-a9999cdb7942",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fe46eca3-deb1-4862-acd5-2d84ad518bb8' \
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