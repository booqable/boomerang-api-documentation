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
      "id": "02ef1da8-28d6-483d-8569-a2ac5592bc2e",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-03T11:10:47+00:00",
        "updated_at": "2023-02-03T11:10:47+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=02ef1da8-28d6-483d-8569-a2ac5592bc2e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T11:09:11Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/edcc6630-7182-4cd5-8260-faef9ff29f6e?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "edcc6630-7182-4cd5-8260-faef9ff29f6e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T11:10:47+00:00",
      "updated_at": "2023-02-03T11:10:47+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=edcc6630-7182-4cd5-8260-faef9ff29f6e"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "2dd08fac-7d19-48d1-86fc-4a772ba950ce"
          },
          {
            "type": "menu_items",
            "id": "dfb7515a-9184-4bf6-bc51-7e79f00b79f8"
          },
          {
            "type": "menu_items",
            "id": "2c74a8d8-8aca-4a0a-b581-bf9d928fb0e4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2dd08fac-7d19-48d1-86fc-4a772ba950ce",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T11:10:47+00:00",
        "updated_at": "2023-02-03T11:10:47+00:00",
        "menu_id": "edcc6630-7182-4cd5-8260-faef9ff29f6e",
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
            "related": "api/boomerang/menus/edcc6630-7182-4cd5-8260-faef9ff29f6e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2dd08fac-7d19-48d1-86fc-4a772ba950ce"
          }
        }
      }
    },
    {
      "id": "dfb7515a-9184-4bf6-bc51-7e79f00b79f8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T11:10:47+00:00",
        "updated_at": "2023-02-03T11:10:47+00:00",
        "menu_id": "edcc6630-7182-4cd5-8260-faef9ff29f6e",
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
            "related": "api/boomerang/menus/edcc6630-7182-4cd5-8260-faef9ff29f6e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=dfb7515a-9184-4bf6-bc51-7e79f00b79f8"
          }
        }
      }
    },
    {
      "id": "2c74a8d8-8aca-4a0a-b581-bf9d928fb0e4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T11:10:47+00:00",
        "updated_at": "2023-02-03T11:10:47+00:00",
        "menu_id": "edcc6630-7182-4cd5-8260-faef9ff29f6e",
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
            "related": "api/boomerang/menus/edcc6630-7182-4cd5-8260-faef9ff29f6e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2c74a8d8-8aca-4a0a-b581-bf9d928fb0e4"
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
    "id": "e61ba4f4-76df-4c6e-9dd1-93b828ce636b",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T11:10:48+00:00",
      "updated_at": "2023-02-03T11:10:48+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/65b275b4-1c07-488b-b4ca-18b2cfa228dd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "65b275b4-1c07-488b-b4ca-18b2cfa228dd",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "3b1297d1-fcb1-4cd2-a15c-3b55dd0fd237",
              "title": "Contact us"
            },
            {
              "id": "329e1650-96de-47d0-92ea-2e9128e72495",
              "title": "Start"
            },
            {
              "id": "cb35cbc7-e1e4-46a2-b710-5ded9091f406",
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
    "id": "65b275b4-1c07-488b-b4ca-18b2cfa228dd",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T11:10:48+00:00",
      "updated_at": "2023-02-03T11:10:48+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "3b1297d1-fcb1-4cd2-a15c-3b55dd0fd237"
          },
          {
            "type": "menu_items",
            "id": "329e1650-96de-47d0-92ea-2e9128e72495"
          },
          {
            "type": "menu_items",
            "id": "cb35cbc7-e1e4-46a2-b710-5ded9091f406"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3b1297d1-fcb1-4cd2-a15c-3b55dd0fd237",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T11:10:48+00:00",
        "updated_at": "2023-02-03T11:10:48+00:00",
        "menu_id": "65b275b4-1c07-488b-b4ca-18b2cfa228dd",
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
      "id": "329e1650-96de-47d0-92ea-2e9128e72495",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T11:10:48+00:00",
        "updated_at": "2023-02-03T11:10:48+00:00",
        "menu_id": "65b275b4-1c07-488b-b4ca-18b2cfa228dd",
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
      "id": "cb35cbc7-e1e4-46a2-b710-5ded9091f406",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T11:10:48+00:00",
        "updated_at": "2023-02-03T11:10:48+00:00",
        "menu_id": "65b275b4-1c07-488b-b4ca-18b2cfa228dd",
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
    --url 'https://example.booqable.com/api/boomerang/menus/e461421f-6d8f-4289-98f3-8b08414f8b4d' \
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