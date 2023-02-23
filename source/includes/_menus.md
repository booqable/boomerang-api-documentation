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
      "id": "244425b3-514c-48af-88de-03674d420c75",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-23T13:37:42+00:00",
        "updated_at": "2023-02-23T13:37:42+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=244425b3-514c-48af-88de-03674d420c75"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T13:35:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/40a8260a-89e5-4959-9fb3-03e6dc297060?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "40a8260a-89e5-4959-9fb3-03e6dc297060",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T13:37:42+00:00",
      "updated_at": "2023-02-23T13:37:42+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=40a8260a-89e5-4959-9fb3-03e6dc297060"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "cabd68d0-40f6-4418-a85c-fbcb3323a35d"
          },
          {
            "type": "menu_items",
            "id": "cf4322b7-260b-47d9-869f-e0d78323158c"
          },
          {
            "type": "menu_items",
            "id": "58277468-9077-419e-801f-b8c6ee050c31"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cabd68d0-40f6-4418-a85c-fbcb3323a35d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T13:37:42+00:00",
        "updated_at": "2023-02-23T13:37:42+00:00",
        "menu_id": "40a8260a-89e5-4959-9fb3-03e6dc297060",
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
            "related": "api/boomerang/menus/40a8260a-89e5-4959-9fb3-03e6dc297060"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cabd68d0-40f6-4418-a85c-fbcb3323a35d"
          }
        }
      }
    },
    {
      "id": "cf4322b7-260b-47d9-869f-e0d78323158c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T13:37:42+00:00",
        "updated_at": "2023-02-23T13:37:42+00:00",
        "menu_id": "40a8260a-89e5-4959-9fb3-03e6dc297060",
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
            "related": "api/boomerang/menus/40a8260a-89e5-4959-9fb3-03e6dc297060"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cf4322b7-260b-47d9-869f-e0d78323158c"
          }
        }
      }
    },
    {
      "id": "58277468-9077-419e-801f-b8c6ee050c31",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T13:37:42+00:00",
        "updated_at": "2023-02-23T13:37:42+00:00",
        "menu_id": "40a8260a-89e5-4959-9fb3-03e6dc297060",
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
            "related": "api/boomerang/menus/40a8260a-89e5-4959-9fb3-03e6dc297060"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=58277468-9077-419e-801f-b8c6ee050c31"
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
    "id": "f422cc8f-1c61-47d3-aade-b569d21c1752",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T13:37:42+00:00",
      "updated_at": "2023-02-23T13:37:42+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/69c6ce58-2e53-4fdc-b8d9-5fad0794062f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "69c6ce58-2e53-4fdc-b8d9-5fad0794062f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "0884458c-ae70-4ef3-a3d9-687c2c53396c",
              "title": "Contact us"
            },
            {
              "id": "c8d73b20-b516-4d92-b4f0-47f2e3e345c8",
              "title": "Start"
            },
            {
              "id": "3abc49ba-ad07-4f11-9869-6b59e56060e3",
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
    "id": "69c6ce58-2e53-4fdc-b8d9-5fad0794062f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T13:37:43+00:00",
      "updated_at": "2023-02-23T13:37:43+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "0884458c-ae70-4ef3-a3d9-687c2c53396c"
          },
          {
            "type": "menu_items",
            "id": "c8d73b20-b516-4d92-b4f0-47f2e3e345c8"
          },
          {
            "type": "menu_items",
            "id": "3abc49ba-ad07-4f11-9869-6b59e56060e3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0884458c-ae70-4ef3-a3d9-687c2c53396c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T13:37:43+00:00",
        "updated_at": "2023-02-23T13:37:43+00:00",
        "menu_id": "69c6ce58-2e53-4fdc-b8d9-5fad0794062f",
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
      "id": "c8d73b20-b516-4d92-b4f0-47f2e3e345c8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T13:37:43+00:00",
        "updated_at": "2023-02-23T13:37:43+00:00",
        "menu_id": "69c6ce58-2e53-4fdc-b8d9-5fad0794062f",
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
      "id": "3abc49ba-ad07-4f11-9869-6b59e56060e3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T13:37:43+00:00",
        "updated_at": "2023-02-23T13:37:43+00:00",
        "menu_id": "69c6ce58-2e53-4fdc-b8d9-5fad0794062f",
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
    --url 'https://example.booqable.com/api/boomerang/menus/95b591d4-b8d2-46e7-b805-04fca2fda022' \
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