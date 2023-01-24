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
      "id": "b97c620c-5678-4b77-a35d-8f035dcd4d66",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-24T14:01:46+00:00",
        "updated_at": "2023-01-24T14:01:46+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=b97c620c-5678-4b77-a35d-8f035dcd4d66"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T13:59:47Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/0954b7ce-ffc5-4ff1-bb10-ef9bfc41f0d7?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0954b7ce-ffc5-4ff1-bb10-ef9bfc41f0d7",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-24T14:01:47+00:00",
      "updated_at": "2023-01-24T14:01:47+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=0954b7ce-ffc5-4ff1-bb10-ef9bfc41f0d7"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "9b59a989-7524-46d6-a320-d5c8f30124ba"
          },
          {
            "type": "menu_items",
            "id": "9711fcac-5981-4653-bdf8-c16802c8d0eb"
          },
          {
            "type": "menu_items",
            "id": "db16c783-61d1-401f-9dc2-3fefbbb0e198"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9b59a989-7524-46d6-a320-d5c8f30124ba",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T14:01:47+00:00",
        "updated_at": "2023-01-24T14:01:47+00:00",
        "menu_id": "0954b7ce-ffc5-4ff1-bb10-ef9bfc41f0d7",
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
            "related": "api/boomerang/menus/0954b7ce-ffc5-4ff1-bb10-ef9bfc41f0d7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9b59a989-7524-46d6-a320-d5c8f30124ba"
          }
        }
      }
    },
    {
      "id": "9711fcac-5981-4653-bdf8-c16802c8d0eb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T14:01:47+00:00",
        "updated_at": "2023-01-24T14:01:47+00:00",
        "menu_id": "0954b7ce-ffc5-4ff1-bb10-ef9bfc41f0d7",
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
            "related": "api/boomerang/menus/0954b7ce-ffc5-4ff1-bb10-ef9bfc41f0d7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9711fcac-5981-4653-bdf8-c16802c8d0eb"
          }
        }
      }
    },
    {
      "id": "db16c783-61d1-401f-9dc2-3fefbbb0e198",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T14:01:47+00:00",
        "updated_at": "2023-01-24T14:01:47+00:00",
        "menu_id": "0954b7ce-ffc5-4ff1-bb10-ef9bfc41f0d7",
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
            "related": "api/boomerang/menus/0954b7ce-ffc5-4ff1-bb10-ef9bfc41f0d7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=db16c783-61d1-401f-9dc2-3fefbbb0e198"
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
    "id": "4eec8007-a09e-4c24-b3c6-7c1f66351402",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-24T14:01:47+00:00",
      "updated_at": "2023-01-24T14:01:47+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/134a1efc-9b0b-4938-a682-d425d06f10a6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "134a1efc-9b0b-4938-a682-d425d06f10a6",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "2cb793e2-f55f-4fd6-b616-ef37bae45b46",
              "title": "Contact us"
            },
            {
              "id": "dbf1d48e-0306-42b8-a5e4-c522015c1465",
              "title": "Start"
            },
            {
              "id": "f9ffa516-fc8d-4397-897d-71b800339057",
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
    "id": "134a1efc-9b0b-4938-a682-d425d06f10a6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-24T14:01:47+00:00",
      "updated_at": "2023-01-24T14:01:47+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "2cb793e2-f55f-4fd6-b616-ef37bae45b46"
          },
          {
            "type": "menu_items",
            "id": "dbf1d48e-0306-42b8-a5e4-c522015c1465"
          },
          {
            "type": "menu_items",
            "id": "f9ffa516-fc8d-4397-897d-71b800339057"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2cb793e2-f55f-4fd6-b616-ef37bae45b46",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T14:01:47+00:00",
        "updated_at": "2023-01-24T14:01:47+00:00",
        "menu_id": "134a1efc-9b0b-4938-a682-d425d06f10a6",
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
      "id": "dbf1d48e-0306-42b8-a5e4-c522015c1465",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T14:01:47+00:00",
        "updated_at": "2023-01-24T14:01:47+00:00",
        "menu_id": "134a1efc-9b0b-4938-a682-d425d06f10a6",
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
      "id": "f9ffa516-fc8d-4397-897d-71b800339057",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T14:01:47+00:00",
        "updated_at": "2023-01-24T14:01:47+00:00",
        "menu_id": "134a1efc-9b0b-4938-a682-d425d06f10a6",
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
    --url 'https://example.booqable.com/api/boomerang/menus/68df0e24-421a-4eb7-8723-b604b3be12b3' \
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