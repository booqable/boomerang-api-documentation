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
      "id": "c440aa83-73f0-4b0a-83ca-4cf644d68503",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-17T10:17:44+00:00",
        "updated_at": "2022-11-17T10:17:44+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=c440aa83-73f0-4b0a-83ca-4cf644d68503"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-17T10:15:41Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/2876b996-3d70-4e1a-be28-88febf35edc5?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2876b996-3d70-4e1a-be28-88febf35edc5",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-17T10:17:45+00:00",
      "updated_at": "2022-11-17T10:17:45+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=2876b996-3d70-4e1a-be28-88febf35edc5"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "fe0bb62a-5ebd-41b2-bd2e-42f7bc436c73"
          },
          {
            "type": "menu_items",
            "id": "92a258a2-7b40-4b7a-95ec-7727791f6454"
          },
          {
            "type": "menu_items",
            "id": "2d10f5d2-fa50-4569-acb6-3fad184a5b1a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fe0bb62a-5ebd-41b2-bd2e-42f7bc436c73",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-17T10:17:45+00:00",
        "updated_at": "2022-11-17T10:17:45+00:00",
        "menu_id": "2876b996-3d70-4e1a-be28-88febf35edc5",
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
            "related": "api/boomerang/menus/2876b996-3d70-4e1a-be28-88febf35edc5"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fe0bb62a-5ebd-41b2-bd2e-42f7bc436c73"
          }
        }
      }
    },
    {
      "id": "92a258a2-7b40-4b7a-95ec-7727791f6454",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-17T10:17:45+00:00",
        "updated_at": "2022-11-17T10:17:45+00:00",
        "menu_id": "2876b996-3d70-4e1a-be28-88febf35edc5",
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
            "related": "api/boomerang/menus/2876b996-3d70-4e1a-be28-88febf35edc5"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=92a258a2-7b40-4b7a-95ec-7727791f6454"
          }
        }
      }
    },
    {
      "id": "2d10f5d2-fa50-4569-acb6-3fad184a5b1a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-17T10:17:45+00:00",
        "updated_at": "2022-11-17T10:17:45+00:00",
        "menu_id": "2876b996-3d70-4e1a-be28-88febf35edc5",
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
            "related": "api/boomerang/menus/2876b996-3d70-4e1a-be28-88febf35edc5"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2d10f5d2-fa50-4569-acb6-3fad184a5b1a"
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
    "id": "f429fccf-7d79-42ab-8a30-7aebdc0ebab7",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-17T10:17:45+00:00",
      "updated_at": "2022-11-17T10:17:45+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7daf4169-f27c-4b7f-a041-659a9b64e0f5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7daf4169-f27c-4b7f-a041-659a9b64e0f5",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "4c1d7037-1e3f-442c-9dae-e5f756e4d6fb",
              "title": "Contact us"
            },
            {
              "id": "2e5ec186-820b-4ff6-882e-f329071d374a",
              "title": "Start"
            },
            {
              "id": "76e846fb-38ed-46ee-8786-5f3eb0823900",
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
    "id": "7daf4169-f27c-4b7f-a041-659a9b64e0f5",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-17T10:17:46+00:00",
      "updated_at": "2022-11-17T10:17:46+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "4c1d7037-1e3f-442c-9dae-e5f756e4d6fb"
          },
          {
            "type": "menu_items",
            "id": "2e5ec186-820b-4ff6-882e-f329071d374a"
          },
          {
            "type": "menu_items",
            "id": "76e846fb-38ed-46ee-8786-5f3eb0823900"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4c1d7037-1e3f-442c-9dae-e5f756e4d6fb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-17T10:17:46+00:00",
        "updated_at": "2022-11-17T10:17:46+00:00",
        "menu_id": "7daf4169-f27c-4b7f-a041-659a9b64e0f5",
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
      "id": "2e5ec186-820b-4ff6-882e-f329071d374a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-17T10:17:46+00:00",
        "updated_at": "2022-11-17T10:17:46+00:00",
        "menu_id": "7daf4169-f27c-4b7f-a041-659a9b64e0f5",
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
      "id": "76e846fb-38ed-46ee-8786-5f3eb0823900",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-17T10:17:46+00:00",
        "updated_at": "2022-11-17T10:17:46+00:00",
        "menu_id": "7daf4169-f27c-4b7f-a041-659a9b64e0f5",
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
    --url 'https://example.booqable.com/api/boomerang/menus/e5e96703-b638-4584-a5df-09f00ea0b0c8' \
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