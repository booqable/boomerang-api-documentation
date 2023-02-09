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
      "id": "fc294e82-23da-4e23-9812-70efed515c5f",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-09T12:19:36+00:00",
        "updated_at": "2023-02-09T12:19:36+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=fc294e82-23da-4e23-9812-70efed515c5f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T12:16:55Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/9c407219-16dd-446f-979c-f3e01e86cab8?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9c407219-16dd-446f-979c-f3e01e86cab8",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T12:19:37+00:00",
      "updated_at": "2023-02-09T12:19:37+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=9c407219-16dd-446f-979c-f3e01e86cab8"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "e43b6a7b-e9bc-4d09-a66c-65f1ef3ff1dd"
          },
          {
            "type": "menu_items",
            "id": "543c64dc-f762-4899-b335-5046da627ac2"
          },
          {
            "type": "menu_items",
            "id": "eaa287e3-7c23-4dfa-b455-98072b5c4f8d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e43b6a7b-e9bc-4d09-a66c-65f1ef3ff1dd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T12:19:37+00:00",
        "updated_at": "2023-02-09T12:19:37+00:00",
        "menu_id": "9c407219-16dd-446f-979c-f3e01e86cab8",
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
            "related": "api/boomerang/menus/9c407219-16dd-446f-979c-f3e01e86cab8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e43b6a7b-e9bc-4d09-a66c-65f1ef3ff1dd"
          }
        }
      }
    },
    {
      "id": "543c64dc-f762-4899-b335-5046da627ac2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T12:19:37+00:00",
        "updated_at": "2023-02-09T12:19:37+00:00",
        "menu_id": "9c407219-16dd-446f-979c-f3e01e86cab8",
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
            "related": "api/boomerang/menus/9c407219-16dd-446f-979c-f3e01e86cab8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=543c64dc-f762-4899-b335-5046da627ac2"
          }
        }
      }
    },
    {
      "id": "eaa287e3-7c23-4dfa-b455-98072b5c4f8d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T12:19:37+00:00",
        "updated_at": "2023-02-09T12:19:37+00:00",
        "menu_id": "9c407219-16dd-446f-979c-f3e01e86cab8",
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
            "related": "api/boomerang/menus/9c407219-16dd-446f-979c-f3e01e86cab8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=eaa287e3-7c23-4dfa-b455-98072b5c4f8d"
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
    "id": "bbb9f87e-c243-40cc-9f88-edba3d08c49f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T12:19:37+00:00",
      "updated_at": "2023-02-09T12:19:37+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a1a019c4-3947-46b5-9019-90d4a70391b0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a1a019c4-3947-46b5-9019-90d4a70391b0",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "3bd361f5-bc93-4d25-a152-517239a88255",
              "title": "Contact us"
            },
            {
              "id": "aa0c6407-95c1-485a-aa3f-4a0ac6f26746",
              "title": "Start"
            },
            {
              "id": "5ede728d-4ed8-43fd-8c35-e1c601185914",
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
    "id": "a1a019c4-3947-46b5-9019-90d4a70391b0",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T12:19:38+00:00",
      "updated_at": "2023-02-09T12:19:38+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "3bd361f5-bc93-4d25-a152-517239a88255"
          },
          {
            "type": "menu_items",
            "id": "aa0c6407-95c1-485a-aa3f-4a0ac6f26746"
          },
          {
            "type": "menu_items",
            "id": "5ede728d-4ed8-43fd-8c35-e1c601185914"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3bd361f5-bc93-4d25-a152-517239a88255",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T12:19:38+00:00",
        "updated_at": "2023-02-09T12:19:38+00:00",
        "menu_id": "a1a019c4-3947-46b5-9019-90d4a70391b0",
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
      "id": "aa0c6407-95c1-485a-aa3f-4a0ac6f26746",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T12:19:38+00:00",
        "updated_at": "2023-02-09T12:19:38+00:00",
        "menu_id": "a1a019c4-3947-46b5-9019-90d4a70391b0",
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
      "id": "5ede728d-4ed8-43fd-8c35-e1c601185914",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T12:19:38+00:00",
        "updated_at": "2023-02-09T12:19:38+00:00",
        "menu_id": "a1a019c4-3947-46b5-9019-90d4a70391b0",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fb6b570f-a08c-4f60-a3c4-f44d9c715080' \
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