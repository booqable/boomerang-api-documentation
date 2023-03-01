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
      "id": "0208ea35-afeb-4209-9ba7-6127c25629c0",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-01T10:31:56+00:00",
        "updated_at": "2023-03-01T10:31:56+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=0208ea35-afeb-4209-9ba7-6127c25629c0"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T10:30:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/8dffef11-757f-45d1-b4b0-3d444aa619b6?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8dffef11-757f-45d1-b4b0-3d444aa619b6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T10:31:56+00:00",
      "updated_at": "2023-03-01T10:31:56+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=8dffef11-757f-45d1-b4b0-3d444aa619b6"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "82433082-2960-4e48-99e0-549ce5fb779c"
          },
          {
            "type": "menu_items",
            "id": "0ebfbd2c-5ab3-4287-8b92-219294199170"
          },
          {
            "type": "menu_items",
            "id": "628469f8-4206-469b-8233-b0823d8e7cac"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "82433082-2960-4e48-99e0-549ce5fb779c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T10:31:56+00:00",
        "updated_at": "2023-03-01T10:31:56+00:00",
        "menu_id": "8dffef11-757f-45d1-b4b0-3d444aa619b6",
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
            "related": "api/boomerang/menus/8dffef11-757f-45d1-b4b0-3d444aa619b6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=82433082-2960-4e48-99e0-549ce5fb779c"
          }
        }
      }
    },
    {
      "id": "0ebfbd2c-5ab3-4287-8b92-219294199170",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T10:31:56+00:00",
        "updated_at": "2023-03-01T10:31:56+00:00",
        "menu_id": "8dffef11-757f-45d1-b4b0-3d444aa619b6",
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
            "related": "api/boomerang/menus/8dffef11-757f-45d1-b4b0-3d444aa619b6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0ebfbd2c-5ab3-4287-8b92-219294199170"
          }
        }
      }
    },
    {
      "id": "628469f8-4206-469b-8233-b0823d8e7cac",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T10:31:57+00:00",
        "updated_at": "2023-03-01T10:31:57+00:00",
        "menu_id": "8dffef11-757f-45d1-b4b0-3d444aa619b6",
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
            "related": "api/boomerang/menus/8dffef11-757f-45d1-b4b0-3d444aa619b6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=628469f8-4206-469b-8233-b0823d8e7cac"
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
    "id": "04316729-a80f-41e2-bd6e-416c11d9158b",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T10:31:57+00:00",
      "updated_at": "2023-03-01T10:31:57+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1b4e207a-87d0-4a4c-8425-89a9e09a6f43' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1b4e207a-87d0-4a4c-8425-89a9e09a6f43",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "42583d4f-84f3-4d66-b174-8e75a60c5bb9",
              "title": "Contact us"
            },
            {
              "id": "5bef4335-165c-489c-8aea-d576d49f7d76",
              "title": "Start"
            },
            {
              "id": "84c19844-b3d1-4e99-a485-ad43bb28a802",
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
    "id": "1b4e207a-87d0-4a4c-8425-89a9e09a6f43",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T10:31:57+00:00",
      "updated_at": "2023-03-01T10:31:57+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "42583d4f-84f3-4d66-b174-8e75a60c5bb9"
          },
          {
            "type": "menu_items",
            "id": "5bef4335-165c-489c-8aea-d576d49f7d76"
          },
          {
            "type": "menu_items",
            "id": "84c19844-b3d1-4e99-a485-ad43bb28a802"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "42583d4f-84f3-4d66-b174-8e75a60c5bb9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T10:31:57+00:00",
        "updated_at": "2023-03-01T10:31:57+00:00",
        "menu_id": "1b4e207a-87d0-4a4c-8425-89a9e09a6f43",
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
      "id": "5bef4335-165c-489c-8aea-d576d49f7d76",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T10:31:57+00:00",
        "updated_at": "2023-03-01T10:31:57+00:00",
        "menu_id": "1b4e207a-87d0-4a4c-8425-89a9e09a6f43",
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
      "id": "84c19844-b3d1-4e99-a485-ad43bb28a802",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T10:31:57+00:00",
        "updated_at": "2023-03-01T10:31:57+00:00",
        "menu_id": "1b4e207a-87d0-4a4c-8425-89a9e09a6f43",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fe6b1848-e014-43d5-81b7-e612451320f3' \
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