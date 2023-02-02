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
      "id": "ba41ac34-21f0-4428-9284-36cbf4d12663",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-02T16:30:05+00:00",
        "updated_at": "2023-02-02T16:30:05+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=ba41ac34-21f0-4428-9284-36cbf4d12663"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:27:50Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/c2cae923-284e-4012-b6fb-71ecc08af33c?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c2cae923-284e-4012-b6fb-71ecc08af33c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T16:30:05+00:00",
      "updated_at": "2023-02-02T16:30:05+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=c2cae923-284e-4012-b6fb-71ecc08af33c"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "6832dde0-d6ed-4c96-b832-1e4f3df479a3"
          },
          {
            "type": "menu_items",
            "id": "9b7a791f-2311-43aa-8794-b1b040e6c4ad"
          },
          {
            "type": "menu_items",
            "id": "e7ea4b59-4ab4-4d75-826c-3a2ca62ba08c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6832dde0-d6ed-4c96-b832-1e4f3df479a3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:30:05+00:00",
        "updated_at": "2023-02-02T16:30:05+00:00",
        "menu_id": "c2cae923-284e-4012-b6fb-71ecc08af33c",
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
            "related": "api/boomerang/menus/c2cae923-284e-4012-b6fb-71ecc08af33c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6832dde0-d6ed-4c96-b832-1e4f3df479a3"
          }
        }
      }
    },
    {
      "id": "9b7a791f-2311-43aa-8794-b1b040e6c4ad",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:30:05+00:00",
        "updated_at": "2023-02-02T16:30:05+00:00",
        "menu_id": "c2cae923-284e-4012-b6fb-71ecc08af33c",
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
            "related": "api/boomerang/menus/c2cae923-284e-4012-b6fb-71ecc08af33c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9b7a791f-2311-43aa-8794-b1b040e6c4ad"
          }
        }
      }
    },
    {
      "id": "e7ea4b59-4ab4-4d75-826c-3a2ca62ba08c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:30:05+00:00",
        "updated_at": "2023-02-02T16:30:05+00:00",
        "menu_id": "c2cae923-284e-4012-b6fb-71ecc08af33c",
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
            "related": "api/boomerang/menus/c2cae923-284e-4012-b6fb-71ecc08af33c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e7ea4b59-4ab4-4d75-826c-3a2ca62ba08c"
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
    "id": "15cba524-bad7-474b-8c7a-09426cdefee6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T16:30:06+00:00",
      "updated_at": "2023-02-02T16:30:06+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ab91b386-bf17-4e54-954e-6a8adc24e194' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ab91b386-bf17-4e54-954e-6a8adc24e194",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "6ba2f77d-48e9-499e-8563-5d00bd09e293",
              "title": "Contact us"
            },
            {
              "id": "143ef32c-8812-4cd4-8c40-0c581e7213d3",
              "title": "Start"
            },
            {
              "id": "c2fb0503-d530-4666-8499-2fe263a0d156",
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
    "id": "ab91b386-bf17-4e54-954e-6a8adc24e194",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T16:30:06+00:00",
      "updated_at": "2023-02-02T16:30:06+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "6ba2f77d-48e9-499e-8563-5d00bd09e293"
          },
          {
            "type": "menu_items",
            "id": "143ef32c-8812-4cd4-8c40-0c581e7213d3"
          },
          {
            "type": "menu_items",
            "id": "c2fb0503-d530-4666-8499-2fe263a0d156"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6ba2f77d-48e9-499e-8563-5d00bd09e293",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:30:06+00:00",
        "updated_at": "2023-02-02T16:30:06+00:00",
        "menu_id": "ab91b386-bf17-4e54-954e-6a8adc24e194",
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
      "id": "143ef32c-8812-4cd4-8c40-0c581e7213d3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:30:06+00:00",
        "updated_at": "2023-02-02T16:30:06+00:00",
        "menu_id": "ab91b386-bf17-4e54-954e-6a8adc24e194",
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
      "id": "c2fb0503-d530-4666-8499-2fe263a0d156",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:30:06+00:00",
        "updated_at": "2023-02-02T16:30:06+00:00",
        "menu_id": "ab91b386-bf17-4e54-954e-6a8adc24e194",
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
    --url 'https://example.booqable.com/api/boomerang/menus/bc776b5f-208a-46e3-9e2b-bac4ac91a9f9' \
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