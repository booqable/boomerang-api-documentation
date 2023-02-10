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
      "id": "6294d9af-a8a3-4048-8f99-2d6954cd0761",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-10T11:16:35+00:00",
        "updated_at": "2023-02-10T11:16:35+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=6294d9af-a8a3-4048-8f99-2d6954cd0761"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-10T11:14:43Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/1dcf1537-5eeb-4af4-af67-e2674a19c911?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1dcf1537-5eeb-4af4-af67-e2674a19c911",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-10T11:16:36+00:00",
      "updated_at": "2023-02-10T11:16:36+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=1dcf1537-5eeb-4af4-af67-e2674a19c911"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "974072a7-be98-46d4-91c2-f7310f998864"
          },
          {
            "type": "menu_items",
            "id": "71f9b16e-2965-4cc9-a301-5f049a4b9b2d"
          },
          {
            "type": "menu_items",
            "id": "5517ea2f-fe65-4185-bc1c-f3d49fc291d1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "974072a7-be98-46d4-91c2-f7310f998864",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-10T11:16:36+00:00",
        "updated_at": "2023-02-10T11:16:36+00:00",
        "menu_id": "1dcf1537-5eeb-4af4-af67-e2674a19c911",
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
            "related": "api/boomerang/menus/1dcf1537-5eeb-4af4-af67-e2674a19c911"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=974072a7-be98-46d4-91c2-f7310f998864"
          }
        }
      }
    },
    {
      "id": "71f9b16e-2965-4cc9-a301-5f049a4b9b2d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-10T11:16:36+00:00",
        "updated_at": "2023-02-10T11:16:36+00:00",
        "menu_id": "1dcf1537-5eeb-4af4-af67-e2674a19c911",
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
            "related": "api/boomerang/menus/1dcf1537-5eeb-4af4-af67-e2674a19c911"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=71f9b16e-2965-4cc9-a301-5f049a4b9b2d"
          }
        }
      }
    },
    {
      "id": "5517ea2f-fe65-4185-bc1c-f3d49fc291d1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-10T11:16:36+00:00",
        "updated_at": "2023-02-10T11:16:36+00:00",
        "menu_id": "1dcf1537-5eeb-4af4-af67-e2674a19c911",
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
            "related": "api/boomerang/menus/1dcf1537-5eeb-4af4-af67-e2674a19c911"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5517ea2f-fe65-4185-bc1c-f3d49fc291d1"
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
    "id": "b58a26e2-039a-4036-89f1-36d19c0623e5",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-10T11:16:36+00:00",
      "updated_at": "2023-02-10T11:16:36+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/70c63e49-c6cc-41c0-8a95-f605626119d7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "70c63e49-c6cc-41c0-8a95-f605626119d7",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "797f0070-bad1-4c83-86de-e580277b30ea",
              "title": "Contact us"
            },
            {
              "id": "b9284123-ee1f-44aa-9f69-408a070cea68",
              "title": "Start"
            },
            {
              "id": "71f433da-2b3f-43d1-b35e-16447ec67c9b",
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
    "id": "70c63e49-c6cc-41c0-8a95-f605626119d7",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-10T11:16:37+00:00",
      "updated_at": "2023-02-10T11:16:37+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "797f0070-bad1-4c83-86de-e580277b30ea"
          },
          {
            "type": "menu_items",
            "id": "b9284123-ee1f-44aa-9f69-408a070cea68"
          },
          {
            "type": "menu_items",
            "id": "71f433da-2b3f-43d1-b35e-16447ec67c9b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "797f0070-bad1-4c83-86de-e580277b30ea",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-10T11:16:37+00:00",
        "updated_at": "2023-02-10T11:16:37+00:00",
        "menu_id": "70c63e49-c6cc-41c0-8a95-f605626119d7",
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
      "id": "b9284123-ee1f-44aa-9f69-408a070cea68",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-10T11:16:37+00:00",
        "updated_at": "2023-02-10T11:16:37+00:00",
        "menu_id": "70c63e49-c6cc-41c0-8a95-f605626119d7",
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
      "id": "71f433da-2b3f-43d1-b35e-16447ec67c9b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-10T11:16:37+00:00",
        "updated_at": "2023-02-10T11:16:37+00:00",
        "menu_id": "70c63e49-c6cc-41c0-8a95-f605626119d7",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f49d106d-439a-49a6-8349-551ab22a697c' \
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