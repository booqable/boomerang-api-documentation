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
      "id": "3100cb9a-a006-4b8c-b650-eed5ad1c2932",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-09T13:20:28+00:00",
        "updated_at": "2023-02-09T13:20:28+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=3100cb9a-a006-4b8c-b650-eed5ad1c2932"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T13:18:37Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/2aed1105-cc97-48bc-a4d7-a25308eb9733?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2aed1105-cc97-48bc-a4d7-a25308eb9733",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T13:20:28+00:00",
      "updated_at": "2023-02-09T13:20:28+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=2aed1105-cc97-48bc-a4d7-a25308eb9733"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "fe1420e3-6a74-420c-97e3-aef4c75c46e7"
          },
          {
            "type": "menu_items",
            "id": "dd57cb9c-9817-47e3-a41d-b28d8b2a9e4d"
          },
          {
            "type": "menu_items",
            "id": "41dc6cc4-92a0-4830-b5f7-f848402e981c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fe1420e3-6a74-420c-97e3-aef4c75c46e7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:20:28+00:00",
        "updated_at": "2023-02-09T13:20:28+00:00",
        "menu_id": "2aed1105-cc97-48bc-a4d7-a25308eb9733",
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
            "related": "api/boomerang/menus/2aed1105-cc97-48bc-a4d7-a25308eb9733"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fe1420e3-6a74-420c-97e3-aef4c75c46e7"
          }
        }
      }
    },
    {
      "id": "dd57cb9c-9817-47e3-a41d-b28d8b2a9e4d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:20:28+00:00",
        "updated_at": "2023-02-09T13:20:28+00:00",
        "menu_id": "2aed1105-cc97-48bc-a4d7-a25308eb9733",
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
            "related": "api/boomerang/menus/2aed1105-cc97-48bc-a4d7-a25308eb9733"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=dd57cb9c-9817-47e3-a41d-b28d8b2a9e4d"
          }
        }
      }
    },
    {
      "id": "41dc6cc4-92a0-4830-b5f7-f848402e981c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:20:28+00:00",
        "updated_at": "2023-02-09T13:20:28+00:00",
        "menu_id": "2aed1105-cc97-48bc-a4d7-a25308eb9733",
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
            "related": "api/boomerang/menus/2aed1105-cc97-48bc-a4d7-a25308eb9733"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=41dc6cc4-92a0-4830-b5f7-f848402e981c"
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
    "id": "960f144c-f7d0-4012-97ae-7ba4fd846a28",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T13:20:29+00:00",
      "updated_at": "2023-02-09T13:20:29+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1f84d54b-386b-4ddc-a7af-f3c06e11ea1e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1f84d54b-386b-4ddc-a7af-f3c06e11ea1e",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "92329a5a-9189-4baf-9f32-bafe9e42c04d",
              "title": "Contact us"
            },
            {
              "id": "2c031d01-3d22-41e3-9460-c800359e4a30",
              "title": "Start"
            },
            {
              "id": "bb10191f-f2bc-4882-a40a-1140063e62c2",
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
    "id": "1f84d54b-386b-4ddc-a7af-f3c06e11ea1e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T13:20:29+00:00",
      "updated_at": "2023-02-09T13:20:29+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "92329a5a-9189-4baf-9f32-bafe9e42c04d"
          },
          {
            "type": "menu_items",
            "id": "2c031d01-3d22-41e3-9460-c800359e4a30"
          },
          {
            "type": "menu_items",
            "id": "bb10191f-f2bc-4882-a40a-1140063e62c2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "92329a5a-9189-4baf-9f32-bafe9e42c04d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:20:29+00:00",
        "updated_at": "2023-02-09T13:20:29+00:00",
        "menu_id": "1f84d54b-386b-4ddc-a7af-f3c06e11ea1e",
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
      "id": "2c031d01-3d22-41e3-9460-c800359e4a30",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:20:29+00:00",
        "updated_at": "2023-02-09T13:20:29+00:00",
        "menu_id": "1f84d54b-386b-4ddc-a7af-f3c06e11ea1e",
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
      "id": "bb10191f-f2bc-4882-a40a-1140063e62c2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:20:29+00:00",
        "updated_at": "2023-02-09T13:20:29+00:00",
        "menu_id": "1f84d54b-386b-4ddc-a7af-f3c06e11ea1e",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0a57482a-bdce-40a8-ba30-3d5b9574cd8a' \
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