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
      "id": "66ed3896-bcd2-4fa9-8465-9c9a1620304c",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-24T14:56:59+00:00",
        "updated_at": "2023-02-24T14:56:59+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=66ed3896-bcd2-4fa9-8465-9c9a1620304c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T14:54:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/235928ba-aa13-4240-a09f-f9598d3565e6?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "235928ba-aa13-4240-a09f-f9598d3565e6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T14:57:00+00:00",
      "updated_at": "2023-02-24T14:57:00+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=235928ba-aa13-4240-a09f-f9598d3565e6"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "9573862a-38fc-4503-ada9-9a6ceb917ace"
          },
          {
            "type": "menu_items",
            "id": "8e3b81cb-b95f-4fda-a26b-1d2b735b0a41"
          },
          {
            "type": "menu_items",
            "id": "637cba2d-1b79-421a-97e2-190ed69d13ac"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9573862a-38fc-4503-ada9-9a6ceb917ace",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T14:57:00+00:00",
        "updated_at": "2023-02-24T14:57:00+00:00",
        "menu_id": "235928ba-aa13-4240-a09f-f9598d3565e6",
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
            "related": "api/boomerang/menus/235928ba-aa13-4240-a09f-f9598d3565e6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9573862a-38fc-4503-ada9-9a6ceb917ace"
          }
        }
      }
    },
    {
      "id": "8e3b81cb-b95f-4fda-a26b-1d2b735b0a41",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T14:57:00+00:00",
        "updated_at": "2023-02-24T14:57:00+00:00",
        "menu_id": "235928ba-aa13-4240-a09f-f9598d3565e6",
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
            "related": "api/boomerang/menus/235928ba-aa13-4240-a09f-f9598d3565e6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8e3b81cb-b95f-4fda-a26b-1d2b735b0a41"
          }
        }
      }
    },
    {
      "id": "637cba2d-1b79-421a-97e2-190ed69d13ac",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T14:57:00+00:00",
        "updated_at": "2023-02-24T14:57:00+00:00",
        "menu_id": "235928ba-aa13-4240-a09f-f9598d3565e6",
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
            "related": "api/boomerang/menus/235928ba-aa13-4240-a09f-f9598d3565e6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=637cba2d-1b79-421a-97e2-190ed69d13ac"
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
    "id": "5dd58675-0292-483e-a37a-119e20911d0c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T14:57:00+00:00",
      "updated_at": "2023-02-24T14:57:00+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/e7290ed5-02a4-4216-8482-18a0d93cf5f6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e7290ed5-02a4-4216-8482-18a0d93cf5f6",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d81016c5-4bc4-4ab9-901c-5bcbfaf4db33",
              "title": "Contact us"
            },
            {
              "id": "93f230e4-ec91-45e3-a9fc-a83521552c5a",
              "title": "Start"
            },
            {
              "id": "a70971c3-d059-45b6-9235-a7a3bc7234f2",
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
    "id": "e7290ed5-02a4-4216-8482-18a0d93cf5f6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T14:57:00+00:00",
      "updated_at": "2023-02-24T14:57:00+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d81016c5-4bc4-4ab9-901c-5bcbfaf4db33"
          },
          {
            "type": "menu_items",
            "id": "93f230e4-ec91-45e3-a9fc-a83521552c5a"
          },
          {
            "type": "menu_items",
            "id": "a70971c3-d059-45b6-9235-a7a3bc7234f2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d81016c5-4bc4-4ab9-901c-5bcbfaf4db33",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T14:57:00+00:00",
        "updated_at": "2023-02-24T14:57:00+00:00",
        "menu_id": "e7290ed5-02a4-4216-8482-18a0d93cf5f6",
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
      "id": "93f230e4-ec91-45e3-a9fc-a83521552c5a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T14:57:00+00:00",
        "updated_at": "2023-02-24T14:57:00+00:00",
        "menu_id": "e7290ed5-02a4-4216-8482-18a0d93cf5f6",
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
      "id": "a70971c3-d059-45b6-9235-a7a3bc7234f2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T14:57:00+00:00",
        "updated_at": "2023-02-24T14:57:00+00:00",
        "menu_id": "e7290ed5-02a4-4216-8482-18a0d93cf5f6",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c0868b87-437c-4e2a-9c89-99270e5f05f5' \
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