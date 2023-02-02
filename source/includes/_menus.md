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
      "id": "03b30030-2178-4e96-b2e0-ac04763bd054",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-02T19:27:20+00:00",
        "updated_at": "2023-02-02T19:27:20+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=03b30030-2178-4e96-b2e0-ac04763bd054"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T19:24:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/3d78f8bb-073f-4b82-8636-01f8c9ea0b92?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3d78f8bb-073f-4b82-8636-01f8c9ea0b92",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T19:27:21+00:00",
      "updated_at": "2023-02-02T19:27:21+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=3d78f8bb-073f-4b82-8636-01f8c9ea0b92"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "97d424a0-cdce-4df8-a433-a06e3cf0d9e6"
          },
          {
            "type": "menu_items",
            "id": "55769f9c-2c12-4102-aa9e-9744affef3e0"
          },
          {
            "type": "menu_items",
            "id": "bf7b06c4-54b8-40f7-b6ba-677df35f8c36"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "97d424a0-cdce-4df8-a433-a06e3cf0d9e6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T19:27:21+00:00",
        "updated_at": "2023-02-02T19:27:21+00:00",
        "menu_id": "3d78f8bb-073f-4b82-8636-01f8c9ea0b92",
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
            "related": "api/boomerang/menus/3d78f8bb-073f-4b82-8636-01f8c9ea0b92"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=97d424a0-cdce-4df8-a433-a06e3cf0d9e6"
          }
        }
      }
    },
    {
      "id": "55769f9c-2c12-4102-aa9e-9744affef3e0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T19:27:21+00:00",
        "updated_at": "2023-02-02T19:27:21+00:00",
        "menu_id": "3d78f8bb-073f-4b82-8636-01f8c9ea0b92",
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
            "related": "api/boomerang/menus/3d78f8bb-073f-4b82-8636-01f8c9ea0b92"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=55769f9c-2c12-4102-aa9e-9744affef3e0"
          }
        }
      }
    },
    {
      "id": "bf7b06c4-54b8-40f7-b6ba-677df35f8c36",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T19:27:21+00:00",
        "updated_at": "2023-02-02T19:27:21+00:00",
        "menu_id": "3d78f8bb-073f-4b82-8636-01f8c9ea0b92",
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
            "related": "api/boomerang/menus/3d78f8bb-073f-4b82-8636-01f8c9ea0b92"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bf7b06c4-54b8-40f7-b6ba-677df35f8c36"
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
    "id": "b7289b5a-9441-4520-9ab7-952a0772ad0d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T19:27:21+00:00",
      "updated_at": "2023-02-02T19:27:21+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/48985a26-f87c-4b47-8547-b21778b42a06' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "48985a26-f87c-4b47-8547-b21778b42a06",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "9ff68943-df1d-414e-83bc-ae33d02d6ed0",
              "title": "Contact us"
            },
            {
              "id": "cc9935b0-34ca-40a5-b064-0663c625c5e2",
              "title": "Start"
            },
            {
              "id": "1a404e4a-8de8-4752-b247-83df4bfa2ffd",
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
    "id": "48985a26-f87c-4b47-8547-b21778b42a06",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T19:27:22+00:00",
      "updated_at": "2023-02-02T19:27:22+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "9ff68943-df1d-414e-83bc-ae33d02d6ed0"
          },
          {
            "type": "menu_items",
            "id": "cc9935b0-34ca-40a5-b064-0663c625c5e2"
          },
          {
            "type": "menu_items",
            "id": "1a404e4a-8de8-4752-b247-83df4bfa2ffd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9ff68943-df1d-414e-83bc-ae33d02d6ed0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T19:27:22+00:00",
        "updated_at": "2023-02-02T19:27:22+00:00",
        "menu_id": "48985a26-f87c-4b47-8547-b21778b42a06",
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
      "id": "cc9935b0-34ca-40a5-b064-0663c625c5e2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T19:27:22+00:00",
        "updated_at": "2023-02-02T19:27:22+00:00",
        "menu_id": "48985a26-f87c-4b47-8547-b21778b42a06",
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
      "id": "1a404e4a-8de8-4752-b247-83df4bfa2ffd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T19:27:22+00:00",
        "updated_at": "2023-02-02T19:27:22+00:00",
        "menu_id": "48985a26-f87c-4b47-8547-b21778b42a06",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d424ec49-c2a6-468a-b0cc-2b4ee75ebb3f' \
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