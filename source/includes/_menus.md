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
      "id": "628debfe-42c6-4c80-a409-53b61253075a",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-08T07:53:31+00:00",
        "updated_at": "2023-03-08T07:53:31+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=628debfe-42c6-4c80-a409-53b61253075a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T07:51:48Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/6e907821-b0b0-47af-995c-e419ce2209e1?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6e907821-b0b0-47af-995c-e419ce2209e1",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-08T07:53:31+00:00",
      "updated_at": "2023-03-08T07:53:31+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=6e907821-b0b0-47af-995c-e419ce2209e1"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "37024317-2ca0-422f-aad1-6ad42a66a6a6"
          },
          {
            "type": "menu_items",
            "id": "b899ce1b-8bad-456b-9bc3-ae148f919d97"
          },
          {
            "type": "menu_items",
            "id": "2809457d-7322-495b-b817-641379abd219"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "37024317-2ca0-422f-aad1-6ad42a66a6a6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T07:53:31+00:00",
        "updated_at": "2023-03-08T07:53:31+00:00",
        "menu_id": "6e907821-b0b0-47af-995c-e419ce2209e1",
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
            "related": "api/boomerang/menus/6e907821-b0b0-47af-995c-e419ce2209e1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=37024317-2ca0-422f-aad1-6ad42a66a6a6"
          }
        }
      }
    },
    {
      "id": "b899ce1b-8bad-456b-9bc3-ae148f919d97",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T07:53:31+00:00",
        "updated_at": "2023-03-08T07:53:31+00:00",
        "menu_id": "6e907821-b0b0-47af-995c-e419ce2209e1",
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
            "related": "api/boomerang/menus/6e907821-b0b0-47af-995c-e419ce2209e1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b899ce1b-8bad-456b-9bc3-ae148f919d97"
          }
        }
      }
    },
    {
      "id": "2809457d-7322-495b-b817-641379abd219",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T07:53:31+00:00",
        "updated_at": "2023-03-08T07:53:31+00:00",
        "menu_id": "6e907821-b0b0-47af-995c-e419ce2209e1",
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
            "related": "api/boomerang/menus/6e907821-b0b0-47af-995c-e419ce2209e1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2809457d-7322-495b-b817-641379abd219"
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
    "id": "26a68310-cabc-48ea-8231-7a382d87e7f2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-08T07:53:32+00:00",
      "updated_at": "2023-03-08T07:53:32+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a69d271f-3b4e-4a8c-ba12-442626a05669' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a69d271f-3b4e-4a8c-ba12-442626a05669",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d95ec38a-dde2-473d-90d2-4fe8e9f41b31",
              "title": "Contact us"
            },
            {
              "id": "a2959a60-f37c-4b47-ad83-5af474e4beb9",
              "title": "Start"
            },
            {
              "id": "e19d10af-d91a-4b30-9e2b-727c3e9cc372",
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
    "id": "a69d271f-3b4e-4a8c-ba12-442626a05669",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-08T07:53:32+00:00",
      "updated_at": "2023-03-08T07:53:32+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d95ec38a-dde2-473d-90d2-4fe8e9f41b31"
          },
          {
            "type": "menu_items",
            "id": "a2959a60-f37c-4b47-ad83-5af474e4beb9"
          },
          {
            "type": "menu_items",
            "id": "e19d10af-d91a-4b30-9e2b-727c3e9cc372"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d95ec38a-dde2-473d-90d2-4fe8e9f41b31",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T07:53:32+00:00",
        "updated_at": "2023-03-08T07:53:32+00:00",
        "menu_id": "a69d271f-3b4e-4a8c-ba12-442626a05669",
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
      "id": "a2959a60-f37c-4b47-ad83-5af474e4beb9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T07:53:32+00:00",
        "updated_at": "2023-03-08T07:53:32+00:00",
        "menu_id": "a69d271f-3b4e-4a8c-ba12-442626a05669",
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
      "id": "e19d10af-d91a-4b30-9e2b-727c3e9cc372",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T07:53:32+00:00",
        "updated_at": "2023-03-08T07:53:32+00:00",
        "menu_id": "a69d271f-3b4e-4a8c-ba12-442626a05669",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7cefd17f-8105-40b8-afcf-8876c56a0288' \
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