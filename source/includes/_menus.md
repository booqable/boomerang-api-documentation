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
      "id": "289107f1-ce41-49cd-9edc-3c1b919136fc",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-02T12:40:45+00:00",
        "updated_at": "2023-03-02T12:40:45+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=289107f1-ce41-49cd-9edc-3c1b919136fc"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T12:39:03Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/18a00a28-5198-4162-85d1-181e88be9add?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "18a00a28-5198-4162-85d1-181e88be9add",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-02T12:40:45+00:00",
      "updated_at": "2023-03-02T12:40:45+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=18a00a28-5198-4162-85d1-181e88be9add"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "f15f7389-9a3b-403c-9e73-2231c636338f"
          },
          {
            "type": "menu_items",
            "id": "f9d6e66b-4da5-4266-be15-23003d1313d8"
          },
          {
            "type": "menu_items",
            "id": "781a59a5-9e1e-4cf1-b153-4a3b328ca5fa"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f15f7389-9a3b-403c-9e73-2231c636338f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T12:40:45+00:00",
        "updated_at": "2023-03-02T12:40:45+00:00",
        "menu_id": "18a00a28-5198-4162-85d1-181e88be9add",
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
            "related": "api/boomerang/menus/18a00a28-5198-4162-85d1-181e88be9add"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f15f7389-9a3b-403c-9e73-2231c636338f"
          }
        }
      }
    },
    {
      "id": "f9d6e66b-4da5-4266-be15-23003d1313d8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T12:40:45+00:00",
        "updated_at": "2023-03-02T12:40:45+00:00",
        "menu_id": "18a00a28-5198-4162-85d1-181e88be9add",
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
            "related": "api/boomerang/menus/18a00a28-5198-4162-85d1-181e88be9add"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f9d6e66b-4da5-4266-be15-23003d1313d8"
          }
        }
      }
    },
    {
      "id": "781a59a5-9e1e-4cf1-b153-4a3b328ca5fa",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T12:40:45+00:00",
        "updated_at": "2023-03-02T12:40:45+00:00",
        "menu_id": "18a00a28-5198-4162-85d1-181e88be9add",
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
            "related": "api/boomerang/menus/18a00a28-5198-4162-85d1-181e88be9add"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=781a59a5-9e1e-4cf1-b153-4a3b328ca5fa"
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
    "id": "ae4b5760-3a7b-4a86-8a54-e4ddfee0aea2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-02T12:40:46+00:00",
      "updated_at": "2023-03-02T12:40:46+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9935dc1a-a0e2-46cb-bb43-f5c447522a63' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9935dc1a-a0e2-46cb-bb43-f5c447522a63",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "87e1a319-25ea-4c43-bf7d-967ee04229b0",
              "title": "Contact us"
            },
            {
              "id": "65e4ad90-de89-472e-a65f-967f083dd437",
              "title": "Start"
            },
            {
              "id": "35de3b76-dad3-4e49-90bb-233890080943",
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
    "id": "9935dc1a-a0e2-46cb-bb43-f5c447522a63",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-02T12:40:46+00:00",
      "updated_at": "2023-03-02T12:40:46+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "87e1a319-25ea-4c43-bf7d-967ee04229b0"
          },
          {
            "type": "menu_items",
            "id": "65e4ad90-de89-472e-a65f-967f083dd437"
          },
          {
            "type": "menu_items",
            "id": "35de3b76-dad3-4e49-90bb-233890080943"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "87e1a319-25ea-4c43-bf7d-967ee04229b0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T12:40:46+00:00",
        "updated_at": "2023-03-02T12:40:46+00:00",
        "menu_id": "9935dc1a-a0e2-46cb-bb43-f5c447522a63",
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
      "id": "65e4ad90-de89-472e-a65f-967f083dd437",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T12:40:46+00:00",
        "updated_at": "2023-03-02T12:40:46+00:00",
        "menu_id": "9935dc1a-a0e2-46cb-bb43-f5c447522a63",
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
      "id": "35de3b76-dad3-4e49-90bb-233890080943",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T12:40:46+00:00",
        "updated_at": "2023-03-02T12:40:46+00:00",
        "menu_id": "9935dc1a-a0e2-46cb-bb43-f5c447522a63",
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
    --url 'https://example.booqable.com/api/boomerang/menus/83e28097-7472-456f-bf3e-1d47a466494f' \
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