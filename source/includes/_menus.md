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
      "id": "69f3bed4-c73d-490c-8986-f3efdf51229f",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-09T09:34:56+00:00",
        "updated_at": "2023-03-09T09:34:56+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=69f3bed4-c73d-490c-8986-f3efdf51229f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T09:33:05Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/569c54df-7193-4377-82d1-1cab15d930a4?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "569c54df-7193-4377-82d1-1cab15d930a4",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-09T09:34:56+00:00",
      "updated_at": "2023-03-09T09:34:56+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=569c54df-7193-4377-82d1-1cab15d930a4"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "08e0c0ac-a4a9-43ff-904a-815cac079a4f"
          },
          {
            "type": "menu_items",
            "id": "948327ce-e7d0-4108-b569-fa5ca8f7c931"
          },
          {
            "type": "menu_items",
            "id": "fbbb6ae5-1152-4199-9a3f-9a05d9380de5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "08e0c0ac-a4a9-43ff-904a-815cac079a4f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T09:34:56+00:00",
        "updated_at": "2023-03-09T09:34:56+00:00",
        "menu_id": "569c54df-7193-4377-82d1-1cab15d930a4",
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
            "related": "api/boomerang/menus/569c54df-7193-4377-82d1-1cab15d930a4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=08e0c0ac-a4a9-43ff-904a-815cac079a4f"
          }
        }
      }
    },
    {
      "id": "948327ce-e7d0-4108-b569-fa5ca8f7c931",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T09:34:56+00:00",
        "updated_at": "2023-03-09T09:34:56+00:00",
        "menu_id": "569c54df-7193-4377-82d1-1cab15d930a4",
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
            "related": "api/boomerang/menus/569c54df-7193-4377-82d1-1cab15d930a4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=948327ce-e7d0-4108-b569-fa5ca8f7c931"
          }
        }
      }
    },
    {
      "id": "fbbb6ae5-1152-4199-9a3f-9a05d9380de5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T09:34:56+00:00",
        "updated_at": "2023-03-09T09:34:56+00:00",
        "menu_id": "569c54df-7193-4377-82d1-1cab15d930a4",
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
            "related": "api/boomerang/menus/569c54df-7193-4377-82d1-1cab15d930a4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fbbb6ae5-1152-4199-9a3f-9a05d9380de5"
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
    "id": "142931f8-f166-453d-bdcb-41d854797f72",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-09T09:34:57+00:00",
      "updated_at": "2023-03-09T09:34:57+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b1c3d712-9ac9-494e-aafc-b4d2d8ca4c1d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b1c3d712-9ac9-494e-aafc-b4d2d8ca4c1d",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "139ef236-5252-4abe-a89d-13038d7d7ccf",
              "title": "Contact us"
            },
            {
              "id": "9a4ab41c-7f39-4469-a4a2-c378370404fc",
              "title": "Start"
            },
            {
              "id": "97e599cb-ea29-46ae-8c57-8735d90c6cfe",
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
    "id": "b1c3d712-9ac9-494e-aafc-b4d2d8ca4c1d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-09T09:34:57+00:00",
      "updated_at": "2023-03-09T09:34:57+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "139ef236-5252-4abe-a89d-13038d7d7ccf"
          },
          {
            "type": "menu_items",
            "id": "9a4ab41c-7f39-4469-a4a2-c378370404fc"
          },
          {
            "type": "menu_items",
            "id": "97e599cb-ea29-46ae-8c57-8735d90c6cfe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "139ef236-5252-4abe-a89d-13038d7d7ccf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T09:34:57+00:00",
        "updated_at": "2023-03-09T09:34:57+00:00",
        "menu_id": "b1c3d712-9ac9-494e-aafc-b4d2d8ca4c1d",
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
      "id": "9a4ab41c-7f39-4469-a4a2-c378370404fc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T09:34:57+00:00",
        "updated_at": "2023-03-09T09:34:57+00:00",
        "menu_id": "b1c3d712-9ac9-494e-aafc-b4d2d8ca4c1d",
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
      "id": "97e599cb-ea29-46ae-8c57-8735d90c6cfe",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T09:34:57+00:00",
        "updated_at": "2023-03-09T09:34:57+00:00",
        "menu_id": "b1c3d712-9ac9-494e-aafc-b4d2d8ca4c1d",
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
    --url 'https://example.booqable.com/api/boomerang/menus/73899204-5745-4b1d-b63f-493dbaa6dbfa' \
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