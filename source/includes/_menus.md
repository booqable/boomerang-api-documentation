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
      "id": "f8f6d1c8-e20b-47f2-ab05-0fcf8a4702c9",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-09T08:58:47+00:00",
        "updated_at": "2023-03-09T08:58:47+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=f8f6d1c8-e20b-47f2-ab05-0fcf8a4702c9"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T08:56:25Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/39c87915-19b3-4525-a11e-abb34b796c1b?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "39c87915-19b3-4525-a11e-abb34b796c1b",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-09T08:58:47+00:00",
      "updated_at": "2023-03-09T08:58:47+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=39c87915-19b3-4525-a11e-abb34b796c1b"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "91d1060c-d71d-4c6b-a721-464007a17a1e"
          },
          {
            "type": "menu_items",
            "id": "b161d69b-9226-497e-bc8b-074f09706098"
          },
          {
            "type": "menu_items",
            "id": "e9d6b0e3-c136-4262-8fbd-3ec023107c58"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "91d1060c-d71d-4c6b-a721-464007a17a1e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T08:58:47+00:00",
        "updated_at": "2023-03-09T08:58:47+00:00",
        "menu_id": "39c87915-19b3-4525-a11e-abb34b796c1b",
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
            "related": "api/boomerang/menus/39c87915-19b3-4525-a11e-abb34b796c1b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=91d1060c-d71d-4c6b-a721-464007a17a1e"
          }
        }
      }
    },
    {
      "id": "b161d69b-9226-497e-bc8b-074f09706098",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T08:58:47+00:00",
        "updated_at": "2023-03-09T08:58:47+00:00",
        "menu_id": "39c87915-19b3-4525-a11e-abb34b796c1b",
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
            "related": "api/boomerang/menus/39c87915-19b3-4525-a11e-abb34b796c1b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b161d69b-9226-497e-bc8b-074f09706098"
          }
        }
      }
    },
    {
      "id": "e9d6b0e3-c136-4262-8fbd-3ec023107c58",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T08:58:47+00:00",
        "updated_at": "2023-03-09T08:58:47+00:00",
        "menu_id": "39c87915-19b3-4525-a11e-abb34b796c1b",
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
            "related": "api/boomerang/menus/39c87915-19b3-4525-a11e-abb34b796c1b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e9d6b0e3-c136-4262-8fbd-3ec023107c58"
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
    "id": "f1e4b410-9ec3-41ed-b331-cca0dcd792e0",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-09T08:58:48+00:00",
      "updated_at": "2023-03-09T08:58:48+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0e1e1659-a4aa-4930-9e44-37e4c9442c77' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0e1e1659-a4aa-4930-9e44-37e4c9442c77",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "58a8cba1-ef9d-4c7f-b085-1d534caf60c9",
              "title": "Contact us"
            },
            {
              "id": "b3a22720-7509-4c63-9aee-85ac4a2787bc",
              "title": "Start"
            },
            {
              "id": "9557d0f8-8d5b-40a6-8788-8752b3dd1360",
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
    "id": "0e1e1659-a4aa-4930-9e44-37e4c9442c77",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-09T08:58:48+00:00",
      "updated_at": "2023-03-09T08:58:48+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "58a8cba1-ef9d-4c7f-b085-1d534caf60c9"
          },
          {
            "type": "menu_items",
            "id": "b3a22720-7509-4c63-9aee-85ac4a2787bc"
          },
          {
            "type": "menu_items",
            "id": "9557d0f8-8d5b-40a6-8788-8752b3dd1360"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "58a8cba1-ef9d-4c7f-b085-1d534caf60c9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T08:58:48+00:00",
        "updated_at": "2023-03-09T08:58:48+00:00",
        "menu_id": "0e1e1659-a4aa-4930-9e44-37e4c9442c77",
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
      "id": "b3a22720-7509-4c63-9aee-85ac4a2787bc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T08:58:48+00:00",
        "updated_at": "2023-03-09T08:58:48+00:00",
        "menu_id": "0e1e1659-a4aa-4930-9e44-37e4c9442c77",
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
      "id": "9557d0f8-8d5b-40a6-8788-8752b3dd1360",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T08:58:48+00:00",
        "updated_at": "2023-03-09T08:58:48+00:00",
        "menu_id": "0e1e1659-a4aa-4930-9e44-37e4c9442c77",
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
    --url 'https://example.booqable.com/api/boomerang/menus/859d92a6-c8a4-4e4f-852c-980f560e41b5' \
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