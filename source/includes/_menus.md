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
      "id": "e7dbfb2c-39df-442f-92e9-a31921a6c142",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-10T08:38:38+00:00",
        "updated_at": "2023-03-10T08:38:38+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=e7dbfb2c-39df-442f-92e9-a31921a6c142"
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-10T08:36:23Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/45bf70e0-3f3e-4941-af5c-1a249a378b98?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "45bf70e0-3f3e-4941-af5c-1a249a378b98",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-10T08:38:39+00:00",
      "updated_at": "2023-03-10T08:38:39+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=45bf70e0-3f3e-4941-af5c-1a249a378b98"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "f860a14e-c2b7-458a-9954-dde89304ddf9"
          },
          {
            "type": "menu_items",
            "id": "0fc17a14-5531-4af5-889d-3c1aef3a60f5"
          },
          {
            "type": "menu_items",
            "id": "d0200fb3-3fa5-423b-bcb0-6fe9148767c9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f860a14e-c2b7-458a-9954-dde89304ddf9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-10T08:38:39+00:00",
        "updated_at": "2023-03-10T08:38:39+00:00",
        "menu_id": "45bf70e0-3f3e-4941-af5c-1a249a378b98",
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
            "related": "api/boomerang/menus/45bf70e0-3f3e-4941-af5c-1a249a378b98"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f860a14e-c2b7-458a-9954-dde89304ddf9"
          }
        }
      }
    },
    {
      "id": "0fc17a14-5531-4af5-889d-3c1aef3a60f5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-10T08:38:39+00:00",
        "updated_at": "2023-03-10T08:38:39+00:00",
        "menu_id": "45bf70e0-3f3e-4941-af5c-1a249a378b98",
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
            "related": "api/boomerang/menus/45bf70e0-3f3e-4941-af5c-1a249a378b98"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0fc17a14-5531-4af5-889d-3c1aef3a60f5"
          }
        }
      }
    },
    {
      "id": "d0200fb3-3fa5-423b-bcb0-6fe9148767c9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-10T08:38:39+00:00",
        "updated_at": "2023-03-10T08:38:39+00:00",
        "menu_id": "45bf70e0-3f3e-4941-af5c-1a249a378b98",
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
            "related": "api/boomerang/menus/45bf70e0-3f3e-4941-af5c-1a249a378b98"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d0200fb3-3fa5-423b-bcb0-6fe9148767c9"
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
    "id": "8bb27483-8726-4055-ae10-972e2f9fad20",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-10T08:38:39+00:00",
      "updated_at": "2023-03-10T08:38:39+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/8769c152-1782-4a63-bcba-19c6cda053f2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8769c152-1782-4a63-bcba-19c6cda053f2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "ea516bba-3097-4aa4-ac20-9524a3b9169b",
              "title": "Contact us"
            },
            {
              "id": "1fab5997-15fa-4a29-bb33-21e9670d3eea",
              "title": "Start"
            },
            {
              "id": "3e5d5bd5-c0aa-419c-9658-58eedb68bca4",
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
    "id": "8769c152-1782-4a63-bcba-19c6cda053f2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-10T08:38:40+00:00",
      "updated_at": "2023-03-10T08:38:40+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "ea516bba-3097-4aa4-ac20-9524a3b9169b"
          },
          {
            "type": "menu_items",
            "id": "1fab5997-15fa-4a29-bb33-21e9670d3eea"
          },
          {
            "type": "menu_items",
            "id": "3e5d5bd5-c0aa-419c-9658-58eedb68bca4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ea516bba-3097-4aa4-ac20-9524a3b9169b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-10T08:38:40+00:00",
        "updated_at": "2023-03-10T08:38:40+00:00",
        "menu_id": "8769c152-1782-4a63-bcba-19c6cda053f2",
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
      "id": "1fab5997-15fa-4a29-bb33-21e9670d3eea",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-10T08:38:40+00:00",
        "updated_at": "2023-03-10T08:38:40+00:00",
        "menu_id": "8769c152-1782-4a63-bcba-19c6cda053f2",
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
      "id": "3e5d5bd5-c0aa-419c-9658-58eedb68bca4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-10T08:38:40+00:00",
        "updated_at": "2023-03-10T08:38:40+00:00",
        "menu_id": "8769c152-1782-4a63-bcba-19c6cda053f2",
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
    --url 'https://example.booqable.com/api/boomerang/menus/20b6e14d-421b-485d-bbd6-bdaf063c3678' \
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes