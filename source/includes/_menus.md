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
      "id": "6b126373-f46c-4af5-91db-83d9f759acbb",
      "type": "menus",
      "attributes": {
        "created_at": "2022-09-16T09:02:57+00:00",
        "updated_at": "2022-09-16T09:02:57+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=6b126373-f46c-4af5-91db-83d9f759acbb"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T09:00:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/4d8c8a96-2a37-4635-b915-b478634d59f0?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4d8c8a96-2a37-4635-b915-b478634d59f0",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-16T09:02:57+00:00",
      "updated_at": "2022-09-16T09:02:57+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=4d8c8a96-2a37-4635-b915-b478634d59f0"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ea05e0ed-7783-4ebb-b12f-2fec441c9084"
          },
          {
            "type": "menu_items",
            "id": "ea68ba65-bee6-464e-8442-81524b93d236"
          },
          {
            "type": "menu_items",
            "id": "6bc13114-5713-4105-8c3d-edf1558c9e8a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ea05e0ed-7783-4ebb-b12f-2fec441c9084",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T09:02:57+00:00",
        "updated_at": "2022-09-16T09:02:57+00:00",
        "menu_id": "4d8c8a96-2a37-4635-b915-b478634d59f0",
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
            "related": "api/boomerang/menus/4d8c8a96-2a37-4635-b915-b478634d59f0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ea05e0ed-7783-4ebb-b12f-2fec441c9084"
          }
        }
      }
    },
    {
      "id": "ea68ba65-bee6-464e-8442-81524b93d236",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T09:02:57+00:00",
        "updated_at": "2022-09-16T09:02:57+00:00",
        "menu_id": "4d8c8a96-2a37-4635-b915-b478634d59f0",
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
            "related": "api/boomerang/menus/4d8c8a96-2a37-4635-b915-b478634d59f0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ea68ba65-bee6-464e-8442-81524b93d236"
          }
        }
      }
    },
    {
      "id": "6bc13114-5713-4105-8c3d-edf1558c9e8a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T09:02:57+00:00",
        "updated_at": "2022-09-16T09:02:57+00:00",
        "menu_id": "4d8c8a96-2a37-4635-b915-b478634d59f0",
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
            "related": "api/boomerang/menus/4d8c8a96-2a37-4635-b915-b478634d59f0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6bc13114-5713-4105-8c3d-edf1558c9e8a"
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
    "id": "533ed24b-f3b0-4475-b5f1-dd3db3aaa248",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-16T09:02:57+00:00",
      "updated_at": "2022-09-16T09:02:57+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6c426ea7-5d56-4462-9d7a-bd095dfb743f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6c426ea7-5d56-4462-9d7a-bd095dfb743f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "aaef7b68-0ff7-4acb-9648-33d7580c7301",
              "title": "Contact us"
            },
            {
              "id": "f78e6ad7-26db-4f0f-b0de-3ca4ffa4f960",
              "title": "Start"
            },
            {
              "id": "f6781e87-064a-4aa0-bc2c-a8083a89745a",
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
    "id": "6c426ea7-5d56-4462-9d7a-bd095dfb743f",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-16T09:02:58+00:00",
      "updated_at": "2022-09-16T09:02:58+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "aaef7b68-0ff7-4acb-9648-33d7580c7301"
          },
          {
            "type": "menu_items",
            "id": "f78e6ad7-26db-4f0f-b0de-3ca4ffa4f960"
          },
          {
            "type": "menu_items",
            "id": "f6781e87-064a-4aa0-bc2c-a8083a89745a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "aaef7b68-0ff7-4acb-9648-33d7580c7301",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T09:02:58+00:00",
        "updated_at": "2022-09-16T09:02:58+00:00",
        "menu_id": "6c426ea7-5d56-4462-9d7a-bd095dfb743f",
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
      "id": "f78e6ad7-26db-4f0f-b0de-3ca4ffa4f960",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T09:02:58+00:00",
        "updated_at": "2022-09-16T09:02:58+00:00",
        "menu_id": "6c426ea7-5d56-4462-9d7a-bd095dfb743f",
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
      "id": "f6781e87-064a-4aa0-bc2c-a8083a89745a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T09:02:58+00:00",
        "updated_at": "2022-09-16T09:02:58+00:00",
        "menu_id": "6c426ea7-5d56-4462-9d7a-bd095dfb743f",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f51a090b-6c39-4c05-adaa-4ec7aa36bc3d' \
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