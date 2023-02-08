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
      "id": "f4eb3f3f-2846-4d78-9d61-7260370b1f9e",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-08T15:00:37+00:00",
        "updated_at": "2023-02-08T15:00:37+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=f4eb3f3f-2846-4d78-9d61-7260370b1f9e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T14:59:07Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/a14606a4-01a2-4b60-accb-fdae92a765d9?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a14606a4-01a2-4b60-accb-fdae92a765d9",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T15:00:37+00:00",
      "updated_at": "2023-02-08T15:00:37+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a14606a4-01a2-4b60-accb-fdae92a765d9"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "4d439d02-1246-4ab7-b450-2d12c1e7d3af"
          },
          {
            "type": "menu_items",
            "id": "1d5ba8d9-07be-40e5-aa04-82a57c10f31f"
          },
          {
            "type": "menu_items",
            "id": "b3a09990-65bc-4c6a-af05-f1b748131a8f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4d439d02-1246-4ab7-b450-2d12c1e7d3af",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T15:00:37+00:00",
        "updated_at": "2023-02-08T15:00:37+00:00",
        "menu_id": "a14606a4-01a2-4b60-accb-fdae92a765d9",
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
            "related": "api/boomerang/menus/a14606a4-01a2-4b60-accb-fdae92a765d9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4d439d02-1246-4ab7-b450-2d12c1e7d3af"
          }
        }
      }
    },
    {
      "id": "1d5ba8d9-07be-40e5-aa04-82a57c10f31f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T15:00:37+00:00",
        "updated_at": "2023-02-08T15:00:37+00:00",
        "menu_id": "a14606a4-01a2-4b60-accb-fdae92a765d9",
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
            "related": "api/boomerang/menus/a14606a4-01a2-4b60-accb-fdae92a765d9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1d5ba8d9-07be-40e5-aa04-82a57c10f31f"
          }
        }
      }
    },
    {
      "id": "b3a09990-65bc-4c6a-af05-f1b748131a8f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T15:00:37+00:00",
        "updated_at": "2023-02-08T15:00:37+00:00",
        "menu_id": "a14606a4-01a2-4b60-accb-fdae92a765d9",
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
            "related": "api/boomerang/menus/a14606a4-01a2-4b60-accb-fdae92a765d9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b3a09990-65bc-4c6a-af05-f1b748131a8f"
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
    "id": "d3f15fb1-5011-4b9b-bba0-013b74de5dbf",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T15:00:37+00:00",
      "updated_at": "2023-02-08T15:00:37+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/99f2054b-3786-42a6-815c-47edab793c3e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "99f2054b-3786-42a6-815c-47edab793c3e",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "8f4fcca1-157f-47a4-87f3-248efebe5c2d",
              "title": "Contact us"
            },
            {
              "id": "59bad1d4-5fe4-40dc-a60a-6848fffb72bb",
              "title": "Start"
            },
            {
              "id": "34569536-f367-4cc4-95be-c9de824ce618",
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
    "id": "99f2054b-3786-42a6-815c-47edab793c3e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T15:00:38+00:00",
      "updated_at": "2023-02-08T15:00:38+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "8f4fcca1-157f-47a4-87f3-248efebe5c2d"
          },
          {
            "type": "menu_items",
            "id": "59bad1d4-5fe4-40dc-a60a-6848fffb72bb"
          },
          {
            "type": "menu_items",
            "id": "34569536-f367-4cc4-95be-c9de824ce618"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8f4fcca1-157f-47a4-87f3-248efebe5c2d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T15:00:38+00:00",
        "updated_at": "2023-02-08T15:00:38+00:00",
        "menu_id": "99f2054b-3786-42a6-815c-47edab793c3e",
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
      "id": "59bad1d4-5fe4-40dc-a60a-6848fffb72bb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T15:00:38+00:00",
        "updated_at": "2023-02-08T15:00:38+00:00",
        "menu_id": "99f2054b-3786-42a6-815c-47edab793c3e",
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
      "id": "34569536-f367-4cc4-95be-c9de824ce618",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T15:00:38+00:00",
        "updated_at": "2023-02-08T15:00:38+00:00",
        "menu_id": "99f2054b-3786-42a6-815c-47edab793c3e",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f4b0927e-7673-4f75-807e-c1030ba48fc7' \
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