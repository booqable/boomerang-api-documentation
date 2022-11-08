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
      "id": "69f529a5-2913-4301-99da-7a3ce403d13a",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-08T13:53:27+00:00",
        "updated_at": "2022-11-08T13:53:27+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=69f529a5-2913-4301-99da-7a3ce403d13a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-08T13:51:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/645b9b85-a31a-44d0-9304-e216a5a0a052?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "645b9b85-a31a-44d0-9304-e216a5a0a052",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-08T13:53:28+00:00",
      "updated_at": "2022-11-08T13:53:28+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=645b9b85-a31a-44d0-9304-e216a5a0a052"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "d5d40e53-4b99-4245-8a4b-eb19900df2eb"
          },
          {
            "type": "menu_items",
            "id": "a1e23f08-11e6-441c-9146-33ba1aeaa3e9"
          },
          {
            "type": "menu_items",
            "id": "d703899b-8a6b-426d-b289-2e9d4cdb03fe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d5d40e53-4b99-4245-8a4b-eb19900df2eb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-08T13:53:28+00:00",
        "updated_at": "2022-11-08T13:53:28+00:00",
        "menu_id": "645b9b85-a31a-44d0-9304-e216a5a0a052",
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
            "related": "api/boomerang/menus/645b9b85-a31a-44d0-9304-e216a5a0a052"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d5d40e53-4b99-4245-8a4b-eb19900df2eb"
          }
        }
      }
    },
    {
      "id": "a1e23f08-11e6-441c-9146-33ba1aeaa3e9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-08T13:53:28+00:00",
        "updated_at": "2022-11-08T13:53:28+00:00",
        "menu_id": "645b9b85-a31a-44d0-9304-e216a5a0a052",
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
            "related": "api/boomerang/menus/645b9b85-a31a-44d0-9304-e216a5a0a052"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a1e23f08-11e6-441c-9146-33ba1aeaa3e9"
          }
        }
      }
    },
    {
      "id": "d703899b-8a6b-426d-b289-2e9d4cdb03fe",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-08T13:53:28+00:00",
        "updated_at": "2022-11-08T13:53:28+00:00",
        "menu_id": "645b9b85-a31a-44d0-9304-e216a5a0a052",
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
            "related": "api/boomerang/menus/645b9b85-a31a-44d0-9304-e216a5a0a052"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d703899b-8a6b-426d-b289-2e9d4cdb03fe"
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
    "id": "3f8d13a5-96c8-4a9a-a494-cde829dc1b75",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-08T13:53:28+00:00",
      "updated_at": "2022-11-08T13:53:28+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d4dd3ddd-4939-460b-ad30-b54d46c0fe6b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d4dd3ddd-4939-460b-ad30-b54d46c0fe6b",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "6ab1e00e-2dc0-4d52-81e2-960b4df82de3",
              "title": "Contact us"
            },
            {
              "id": "72c57acb-6729-428f-90e7-c7da9031e8db",
              "title": "Start"
            },
            {
              "id": "4fada9ba-ec11-4d9d-9a55-9a5dfc077d6b",
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
    "id": "d4dd3ddd-4939-460b-ad30-b54d46c0fe6b",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-08T13:53:29+00:00",
      "updated_at": "2022-11-08T13:53:29+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "6ab1e00e-2dc0-4d52-81e2-960b4df82de3"
          },
          {
            "type": "menu_items",
            "id": "72c57acb-6729-428f-90e7-c7da9031e8db"
          },
          {
            "type": "menu_items",
            "id": "4fada9ba-ec11-4d9d-9a55-9a5dfc077d6b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6ab1e00e-2dc0-4d52-81e2-960b4df82de3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-08T13:53:29+00:00",
        "updated_at": "2022-11-08T13:53:29+00:00",
        "menu_id": "d4dd3ddd-4939-460b-ad30-b54d46c0fe6b",
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
      "id": "72c57acb-6729-428f-90e7-c7da9031e8db",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-08T13:53:29+00:00",
        "updated_at": "2022-11-08T13:53:29+00:00",
        "menu_id": "d4dd3ddd-4939-460b-ad30-b54d46c0fe6b",
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
      "id": "4fada9ba-ec11-4d9d-9a55-9a5dfc077d6b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-08T13:53:29+00:00",
        "updated_at": "2022-11-08T13:53:29+00:00",
        "menu_id": "d4dd3ddd-4939-460b-ad30-b54d46c0fe6b",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f2bb2c8c-f587-49cd-bf66-b86e4cf84f73' \
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