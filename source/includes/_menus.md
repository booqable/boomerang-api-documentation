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
      "id": "bd397624-6d9a-4592-bab2-40ab8f654d23",
      "type": "menus",
      "attributes": {
        "created_at": "2022-12-08T11:04:13+00:00",
        "updated_at": "2022-12-08T11:04:13+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=bd397624-6d9a-4592-bab2-40ab8f654d23"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-08T11:02:05Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/872d7d1d-3ce0-427b-bb35-eab6138748f0?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "872d7d1d-3ce0-427b-bb35-eab6138748f0",
    "type": "menus",
    "attributes": {
      "created_at": "2022-12-08T11:04:14+00:00",
      "updated_at": "2022-12-08T11:04:14+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=872d7d1d-3ce0-427b-bb35-eab6138748f0"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ab37b737-f446-4b01-9ab1-bf0670321f12"
          },
          {
            "type": "menu_items",
            "id": "fbd1818d-0448-456a-9de0-cbcdf62b8869"
          },
          {
            "type": "menu_items",
            "id": "fd1e79da-c2a8-4fd2-8d20-454f07cc3604"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ab37b737-f446-4b01-9ab1-bf0670321f12",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-08T11:04:14+00:00",
        "updated_at": "2022-12-08T11:04:14+00:00",
        "menu_id": "872d7d1d-3ce0-427b-bb35-eab6138748f0",
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
            "related": "api/boomerang/menus/872d7d1d-3ce0-427b-bb35-eab6138748f0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ab37b737-f446-4b01-9ab1-bf0670321f12"
          }
        }
      }
    },
    {
      "id": "fbd1818d-0448-456a-9de0-cbcdf62b8869",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-08T11:04:14+00:00",
        "updated_at": "2022-12-08T11:04:14+00:00",
        "menu_id": "872d7d1d-3ce0-427b-bb35-eab6138748f0",
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
            "related": "api/boomerang/menus/872d7d1d-3ce0-427b-bb35-eab6138748f0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fbd1818d-0448-456a-9de0-cbcdf62b8869"
          }
        }
      }
    },
    {
      "id": "fd1e79da-c2a8-4fd2-8d20-454f07cc3604",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-08T11:04:14+00:00",
        "updated_at": "2022-12-08T11:04:14+00:00",
        "menu_id": "872d7d1d-3ce0-427b-bb35-eab6138748f0",
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
            "related": "api/boomerang/menus/872d7d1d-3ce0-427b-bb35-eab6138748f0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fd1e79da-c2a8-4fd2-8d20-454f07cc3604"
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
    "id": "32da034e-0a6f-43bf-a572-ccc371590c43",
    "type": "menus",
    "attributes": {
      "created_at": "2022-12-08T11:04:14+00:00",
      "updated_at": "2022-12-08T11:04:14+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/64d6fd87-5c47-4933-ab43-8218bb64716f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "64d6fd87-5c47-4933-ab43-8218bb64716f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "7e6b2516-79ff-42ae-b7e4-8ab388e0bb7a",
              "title": "Contact us"
            },
            {
              "id": "38699190-5c59-47ee-a135-5a6ae86c8303",
              "title": "Start"
            },
            {
              "id": "0dc6630b-f0ae-4890-8055-0f451d838f43",
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
    "id": "64d6fd87-5c47-4933-ab43-8218bb64716f",
    "type": "menus",
    "attributes": {
      "created_at": "2022-12-08T11:04:14+00:00",
      "updated_at": "2022-12-08T11:04:14+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "7e6b2516-79ff-42ae-b7e4-8ab388e0bb7a"
          },
          {
            "type": "menu_items",
            "id": "38699190-5c59-47ee-a135-5a6ae86c8303"
          },
          {
            "type": "menu_items",
            "id": "0dc6630b-f0ae-4890-8055-0f451d838f43"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7e6b2516-79ff-42ae-b7e4-8ab388e0bb7a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-08T11:04:14+00:00",
        "updated_at": "2022-12-08T11:04:14+00:00",
        "menu_id": "64d6fd87-5c47-4933-ab43-8218bb64716f",
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
      "id": "38699190-5c59-47ee-a135-5a6ae86c8303",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-08T11:04:14+00:00",
        "updated_at": "2022-12-08T11:04:14+00:00",
        "menu_id": "64d6fd87-5c47-4933-ab43-8218bb64716f",
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
      "id": "0dc6630b-f0ae-4890-8055-0f451d838f43",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-08T11:04:14+00:00",
        "updated_at": "2022-12-08T11:04:14+00:00",
        "menu_id": "64d6fd87-5c47-4933-ab43-8218bb64716f",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ea3b1c38-67aa-48b9-8902-ae3b94fc135c' \
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