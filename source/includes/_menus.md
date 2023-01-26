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
      "id": "21d05204-668a-4dd9-b624-e1773b463035",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-26T12:17:44+00:00",
        "updated_at": "2023-01-26T12:17:44+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=21d05204-668a-4dd9-b624-e1773b463035"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-26T12:15:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/c37a4d9c-f9a0-48d3-ab00-854b49c7138e?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c37a4d9c-f9a0-48d3-ab00-854b49c7138e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-26T12:17:44+00:00",
      "updated_at": "2023-01-26T12:17:44+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=c37a4d9c-f9a0-48d3-ab00-854b49c7138e"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "7e2d84bb-12eb-4088-a62e-ab0574187446"
          },
          {
            "type": "menu_items",
            "id": "b90c9911-429e-4c96-9cd5-9d983ade0e1a"
          },
          {
            "type": "menu_items",
            "id": "549df9dd-d63f-425b-a78d-e24e34f2e32d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7e2d84bb-12eb-4088-a62e-ab0574187446",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-26T12:17:44+00:00",
        "updated_at": "2023-01-26T12:17:44+00:00",
        "menu_id": "c37a4d9c-f9a0-48d3-ab00-854b49c7138e",
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
            "related": "api/boomerang/menus/c37a4d9c-f9a0-48d3-ab00-854b49c7138e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7e2d84bb-12eb-4088-a62e-ab0574187446"
          }
        }
      }
    },
    {
      "id": "b90c9911-429e-4c96-9cd5-9d983ade0e1a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-26T12:17:44+00:00",
        "updated_at": "2023-01-26T12:17:44+00:00",
        "menu_id": "c37a4d9c-f9a0-48d3-ab00-854b49c7138e",
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
            "related": "api/boomerang/menus/c37a4d9c-f9a0-48d3-ab00-854b49c7138e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b90c9911-429e-4c96-9cd5-9d983ade0e1a"
          }
        }
      }
    },
    {
      "id": "549df9dd-d63f-425b-a78d-e24e34f2e32d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-26T12:17:44+00:00",
        "updated_at": "2023-01-26T12:17:44+00:00",
        "menu_id": "c37a4d9c-f9a0-48d3-ab00-854b49c7138e",
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
            "related": "api/boomerang/menus/c37a4d9c-f9a0-48d3-ab00-854b49c7138e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=549df9dd-d63f-425b-a78d-e24e34f2e32d"
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
    "id": "d9a12c84-f719-4395-b97d-d9993b2bd102",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-26T12:17:45+00:00",
      "updated_at": "2023-01-26T12:17:45+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fc770f61-0536-4f50-a3a7-dfd5c46a37d9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fc770f61-0536-4f50-a3a7-dfd5c46a37d9",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "8e0e5c0e-8742-4cf9-99c9-e6c701292d6d",
              "title": "Contact us"
            },
            {
              "id": "ee3b33db-2dd3-4867-8bcd-8433f56fcd75",
              "title": "Start"
            },
            {
              "id": "42394b33-fee7-4ec9-b3ce-b0a05458fbd7",
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
    "id": "fc770f61-0536-4f50-a3a7-dfd5c46a37d9",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-26T12:17:45+00:00",
      "updated_at": "2023-01-26T12:17:45+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "8e0e5c0e-8742-4cf9-99c9-e6c701292d6d"
          },
          {
            "type": "menu_items",
            "id": "ee3b33db-2dd3-4867-8bcd-8433f56fcd75"
          },
          {
            "type": "menu_items",
            "id": "42394b33-fee7-4ec9-b3ce-b0a05458fbd7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8e0e5c0e-8742-4cf9-99c9-e6c701292d6d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-26T12:17:45+00:00",
        "updated_at": "2023-01-26T12:17:45+00:00",
        "menu_id": "fc770f61-0536-4f50-a3a7-dfd5c46a37d9",
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
      "id": "ee3b33db-2dd3-4867-8bcd-8433f56fcd75",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-26T12:17:45+00:00",
        "updated_at": "2023-01-26T12:17:45+00:00",
        "menu_id": "fc770f61-0536-4f50-a3a7-dfd5c46a37d9",
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
      "id": "42394b33-fee7-4ec9-b3ce-b0a05458fbd7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-26T12:17:45+00:00",
        "updated_at": "2023-01-26T12:17:45+00:00",
        "menu_id": "fc770f61-0536-4f50-a3a7-dfd5c46a37d9",
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
    --url 'https://example.booqable.com/api/boomerang/menus/79643d3a-6b35-452b-b324-d9f6996f92fb' \
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