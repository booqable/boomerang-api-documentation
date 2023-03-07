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
      "id": "1ebb6e0d-6c8b-4919-b741-8c2862af804d",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-07T11:20:01+00:00",
        "updated_at": "2023-03-07T11:20:01+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=1ebb6e0d-6c8b-4919-b741-8c2862af804d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T11:18:07Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/b7008161-e18f-44c6-a65a-eee00a4079c9?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b7008161-e18f-44c6-a65a-eee00a4079c9",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T11:20:01+00:00",
      "updated_at": "2023-03-07T11:20:01+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b7008161-e18f-44c6-a65a-eee00a4079c9"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ada0a5f0-c414-4bef-9701-762d451db228"
          },
          {
            "type": "menu_items",
            "id": "560c9b45-68f4-4c76-9984-e4afe31405e8"
          },
          {
            "type": "menu_items",
            "id": "4a33eb80-4e13-42c8-be14-119a454a8f0c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ada0a5f0-c414-4bef-9701-762d451db228",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T11:20:01+00:00",
        "updated_at": "2023-03-07T11:20:01+00:00",
        "menu_id": "b7008161-e18f-44c6-a65a-eee00a4079c9",
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
            "related": "api/boomerang/menus/b7008161-e18f-44c6-a65a-eee00a4079c9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ada0a5f0-c414-4bef-9701-762d451db228"
          }
        }
      }
    },
    {
      "id": "560c9b45-68f4-4c76-9984-e4afe31405e8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T11:20:01+00:00",
        "updated_at": "2023-03-07T11:20:01+00:00",
        "menu_id": "b7008161-e18f-44c6-a65a-eee00a4079c9",
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
            "related": "api/boomerang/menus/b7008161-e18f-44c6-a65a-eee00a4079c9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=560c9b45-68f4-4c76-9984-e4afe31405e8"
          }
        }
      }
    },
    {
      "id": "4a33eb80-4e13-42c8-be14-119a454a8f0c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T11:20:01+00:00",
        "updated_at": "2023-03-07T11:20:01+00:00",
        "menu_id": "b7008161-e18f-44c6-a65a-eee00a4079c9",
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
            "related": "api/boomerang/menus/b7008161-e18f-44c6-a65a-eee00a4079c9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4a33eb80-4e13-42c8-be14-119a454a8f0c"
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
    "id": "90029559-e036-4df2-ac30-671d2fe19317",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T11:20:01+00:00",
      "updated_at": "2023-03-07T11:20:01+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/66af3cb4-cd85-4cb5-b9c0-b7d91e3115c2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "66af3cb4-cd85-4cb5-b9c0-b7d91e3115c2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "14febd7d-7f76-467c-8abf-e0791d876241",
              "title": "Contact us"
            },
            {
              "id": "d9bb04b2-8919-4296-8bf1-3d6756e4793f",
              "title": "Start"
            },
            {
              "id": "a90d68c5-e9d3-4bc2-bee7-6a57d2019119",
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
    "id": "66af3cb4-cd85-4cb5-b9c0-b7d91e3115c2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T11:20:02+00:00",
      "updated_at": "2023-03-07T11:20:02+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "14febd7d-7f76-467c-8abf-e0791d876241"
          },
          {
            "type": "menu_items",
            "id": "d9bb04b2-8919-4296-8bf1-3d6756e4793f"
          },
          {
            "type": "menu_items",
            "id": "a90d68c5-e9d3-4bc2-bee7-6a57d2019119"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "14febd7d-7f76-467c-8abf-e0791d876241",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T11:20:02+00:00",
        "updated_at": "2023-03-07T11:20:02+00:00",
        "menu_id": "66af3cb4-cd85-4cb5-b9c0-b7d91e3115c2",
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
      "id": "d9bb04b2-8919-4296-8bf1-3d6756e4793f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T11:20:02+00:00",
        "updated_at": "2023-03-07T11:20:02+00:00",
        "menu_id": "66af3cb4-cd85-4cb5-b9c0-b7d91e3115c2",
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
      "id": "a90d68c5-e9d3-4bc2-bee7-6a57d2019119",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T11:20:02+00:00",
        "updated_at": "2023-03-07T11:20:02+00:00",
        "menu_id": "66af3cb4-cd85-4cb5-b9c0-b7d91e3115c2",
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
    --url 'https://example.booqable.com/api/boomerang/menus/992d2f6d-d8d3-4120-a6a8-0d3ff241db0f' \
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