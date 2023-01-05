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
      "id": "28d87a27-64ee-4174-821d-c1e43afd4d67",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-05T13:10:14+00:00",
        "updated_at": "2023-01-05T13:10:14+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=28d87a27-64ee-4174-821d-c1e43afd4d67"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:07:32Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/216a43f2-0985-42a8-b5ae-1c1c118cb1b8?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "216a43f2-0985-42a8-b5ae-1c1c118cb1b8",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T13:10:14+00:00",
      "updated_at": "2023-01-05T13:10:14+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=216a43f2-0985-42a8-b5ae-1c1c118cb1b8"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "0d67c5f5-84ed-4076-bfaa-9b0c968ee4be"
          },
          {
            "type": "menu_items",
            "id": "1855155c-dac6-46cc-a301-50779d04852c"
          },
          {
            "type": "menu_items",
            "id": "3b81193c-a8e9-4f1f-bcd2-bf6a891ab35b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0d67c5f5-84ed-4076-bfaa-9b0c968ee4be",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T13:10:14+00:00",
        "updated_at": "2023-01-05T13:10:14+00:00",
        "menu_id": "216a43f2-0985-42a8-b5ae-1c1c118cb1b8",
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
            "related": "api/boomerang/menus/216a43f2-0985-42a8-b5ae-1c1c118cb1b8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0d67c5f5-84ed-4076-bfaa-9b0c968ee4be"
          }
        }
      }
    },
    {
      "id": "1855155c-dac6-46cc-a301-50779d04852c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T13:10:14+00:00",
        "updated_at": "2023-01-05T13:10:14+00:00",
        "menu_id": "216a43f2-0985-42a8-b5ae-1c1c118cb1b8",
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
            "related": "api/boomerang/menus/216a43f2-0985-42a8-b5ae-1c1c118cb1b8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1855155c-dac6-46cc-a301-50779d04852c"
          }
        }
      }
    },
    {
      "id": "3b81193c-a8e9-4f1f-bcd2-bf6a891ab35b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T13:10:14+00:00",
        "updated_at": "2023-01-05T13:10:14+00:00",
        "menu_id": "216a43f2-0985-42a8-b5ae-1c1c118cb1b8",
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
            "related": "api/boomerang/menus/216a43f2-0985-42a8-b5ae-1c1c118cb1b8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3b81193c-a8e9-4f1f-bcd2-bf6a891ab35b"
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
    "id": "180d32b5-fb86-44bc-af3b-64191095ba02",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T13:10:16+00:00",
      "updated_at": "2023-01-05T13:10:16+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b8d95b0c-9a32-432d-8d96-d1773001cdba' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b8d95b0c-9a32-432d-8d96-d1773001cdba",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "6b40e3f1-8f80-44f9-bb18-d0f743869b7f",
              "title": "Contact us"
            },
            {
              "id": "7dc1f444-3e31-44c4-92b2-0adf769b9443",
              "title": "Start"
            },
            {
              "id": "6142fff3-be49-4836-97de-3e5cc50eb103",
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
    "id": "b8d95b0c-9a32-432d-8d96-d1773001cdba",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T13:10:17+00:00",
      "updated_at": "2023-01-05T13:10:17+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "6b40e3f1-8f80-44f9-bb18-d0f743869b7f"
          },
          {
            "type": "menu_items",
            "id": "7dc1f444-3e31-44c4-92b2-0adf769b9443"
          },
          {
            "type": "menu_items",
            "id": "6142fff3-be49-4836-97de-3e5cc50eb103"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6b40e3f1-8f80-44f9-bb18-d0f743869b7f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T13:10:17+00:00",
        "updated_at": "2023-01-05T13:10:17+00:00",
        "menu_id": "b8d95b0c-9a32-432d-8d96-d1773001cdba",
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
      "id": "7dc1f444-3e31-44c4-92b2-0adf769b9443",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T13:10:17+00:00",
        "updated_at": "2023-01-05T13:10:17+00:00",
        "menu_id": "b8d95b0c-9a32-432d-8d96-d1773001cdba",
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
      "id": "6142fff3-be49-4836-97de-3e5cc50eb103",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T13:10:17+00:00",
        "updated_at": "2023-01-05T13:10:17+00:00",
        "menu_id": "b8d95b0c-9a32-432d-8d96-d1773001cdba",
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
    --url 'https://example.booqable.com/api/boomerang/menus/3b3a10e6-bed0-40e6-8adf-d9d9ac85aa05' \
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