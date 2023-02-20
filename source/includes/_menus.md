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
      "id": "c21f4c7a-400c-4fb6-9106-f842f2168d90",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-20T11:47:37+00:00",
        "updated_at": "2023-02-20T11:47:37+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=c21f4c7a-400c-4fb6-9106-f842f2168d90"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-20T11:45:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/e74b1c07-5d19-499a-abf8-3f3cab4e0bab?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e74b1c07-5d19-499a-abf8-3f3cab4e0bab",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-20T11:47:37+00:00",
      "updated_at": "2023-02-20T11:47:37+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=e74b1c07-5d19-499a-abf8-3f3cab4e0bab"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "05f878b2-e115-421a-a9bb-600a60d01dbe"
          },
          {
            "type": "menu_items",
            "id": "e23986e9-7656-41b9-84cb-e2895d00b18d"
          },
          {
            "type": "menu_items",
            "id": "f9ed4da7-6200-497b-a7b7-8a37674e8e90"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "05f878b2-e115-421a-a9bb-600a60d01dbe",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-20T11:47:37+00:00",
        "updated_at": "2023-02-20T11:47:37+00:00",
        "menu_id": "e74b1c07-5d19-499a-abf8-3f3cab4e0bab",
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
            "related": "api/boomerang/menus/e74b1c07-5d19-499a-abf8-3f3cab4e0bab"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=05f878b2-e115-421a-a9bb-600a60d01dbe"
          }
        }
      }
    },
    {
      "id": "e23986e9-7656-41b9-84cb-e2895d00b18d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-20T11:47:37+00:00",
        "updated_at": "2023-02-20T11:47:37+00:00",
        "menu_id": "e74b1c07-5d19-499a-abf8-3f3cab4e0bab",
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
            "related": "api/boomerang/menus/e74b1c07-5d19-499a-abf8-3f3cab4e0bab"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e23986e9-7656-41b9-84cb-e2895d00b18d"
          }
        }
      }
    },
    {
      "id": "f9ed4da7-6200-497b-a7b7-8a37674e8e90",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-20T11:47:37+00:00",
        "updated_at": "2023-02-20T11:47:37+00:00",
        "menu_id": "e74b1c07-5d19-499a-abf8-3f3cab4e0bab",
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
            "related": "api/boomerang/menus/e74b1c07-5d19-499a-abf8-3f3cab4e0bab"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f9ed4da7-6200-497b-a7b7-8a37674e8e90"
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
    "id": "68f84525-bc05-4f7d-ad7a-1da91d67e503",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-20T11:47:38+00:00",
      "updated_at": "2023-02-20T11:47:38+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5d13bfc5-49ce-44b4-a2ab-88116d6e0f41' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5d13bfc5-49ce-44b4-a2ab-88116d6e0f41",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "cc604383-3e87-4da5-a237-1b3f0247181c",
              "title": "Contact us"
            },
            {
              "id": "0e73d30a-b37e-4cf7-a400-6caeefd0044c",
              "title": "Start"
            },
            {
              "id": "441e991d-ff99-453a-bf9d-55fe7b88572a",
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
    "id": "5d13bfc5-49ce-44b4-a2ab-88116d6e0f41",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-20T11:47:38+00:00",
      "updated_at": "2023-02-20T11:47:38+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "cc604383-3e87-4da5-a237-1b3f0247181c"
          },
          {
            "type": "menu_items",
            "id": "0e73d30a-b37e-4cf7-a400-6caeefd0044c"
          },
          {
            "type": "menu_items",
            "id": "441e991d-ff99-453a-bf9d-55fe7b88572a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cc604383-3e87-4da5-a237-1b3f0247181c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-20T11:47:38+00:00",
        "updated_at": "2023-02-20T11:47:38+00:00",
        "menu_id": "5d13bfc5-49ce-44b4-a2ab-88116d6e0f41",
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
      "id": "0e73d30a-b37e-4cf7-a400-6caeefd0044c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-20T11:47:38+00:00",
        "updated_at": "2023-02-20T11:47:38+00:00",
        "menu_id": "5d13bfc5-49ce-44b4-a2ab-88116d6e0f41",
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
      "id": "441e991d-ff99-453a-bf9d-55fe7b88572a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-20T11:47:38+00:00",
        "updated_at": "2023-02-20T11:47:38+00:00",
        "menu_id": "5d13bfc5-49ce-44b4-a2ab-88116d6e0f41",
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
    --url 'https://example.booqable.com/api/boomerang/menus/15c6569b-b4a1-4cc3-80b1-e41acda5902b' \
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