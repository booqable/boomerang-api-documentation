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
      "id": "057b912f-32d9-46bb-bfb3-140b29e31114",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-07T16:05:52+00:00",
        "updated_at": "2023-02-07T16:05:52+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=057b912f-32d9-46bb-bfb3-140b29e31114"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T16:04:23Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/f7f4793c-bce9-40e6-b95c-ecb5f21a33a6?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f7f4793c-bce9-40e6-b95c-ecb5f21a33a6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T16:05:52+00:00",
      "updated_at": "2023-02-07T16:05:52+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=f7f4793c-bce9-40e6-b95c-ecb5f21a33a6"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "7b5590d3-7a21-433e-8799-0b6322124051"
          },
          {
            "type": "menu_items",
            "id": "325c4f73-de68-4f46-8869-6dc99ab3b31d"
          },
          {
            "type": "menu_items",
            "id": "3b0fa132-ada5-4f53-aa53-28e195d68737"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7b5590d3-7a21-433e-8799-0b6322124051",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T16:05:52+00:00",
        "updated_at": "2023-02-07T16:05:52+00:00",
        "menu_id": "f7f4793c-bce9-40e6-b95c-ecb5f21a33a6",
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
            "related": "api/boomerang/menus/f7f4793c-bce9-40e6-b95c-ecb5f21a33a6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7b5590d3-7a21-433e-8799-0b6322124051"
          }
        }
      }
    },
    {
      "id": "325c4f73-de68-4f46-8869-6dc99ab3b31d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T16:05:52+00:00",
        "updated_at": "2023-02-07T16:05:52+00:00",
        "menu_id": "f7f4793c-bce9-40e6-b95c-ecb5f21a33a6",
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
            "related": "api/boomerang/menus/f7f4793c-bce9-40e6-b95c-ecb5f21a33a6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=325c4f73-de68-4f46-8869-6dc99ab3b31d"
          }
        }
      }
    },
    {
      "id": "3b0fa132-ada5-4f53-aa53-28e195d68737",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T16:05:52+00:00",
        "updated_at": "2023-02-07T16:05:52+00:00",
        "menu_id": "f7f4793c-bce9-40e6-b95c-ecb5f21a33a6",
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
            "related": "api/boomerang/menus/f7f4793c-bce9-40e6-b95c-ecb5f21a33a6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3b0fa132-ada5-4f53-aa53-28e195d68737"
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
    "id": "183bb642-df65-4ad8-ad60-31817d709177",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T16:05:53+00:00",
      "updated_at": "2023-02-07T16:05:53+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7fac3203-99e0-45fb-b636-9aa9f67b6b8e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7fac3203-99e0-45fb-b636-9aa9f67b6b8e",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "62bbb8b4-fa7b-4464-824e-01c649a3c96d",
              "title": "Contact us"
            },
            {
              "id": "a9b4f28f-ae2e-4790-aff3-208bc3f278c3",
              "title": "Start"
            },
            {
              "id": "ce1c8761-835f-4bbd-a1a2-4666dd8535fa",
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
    "id": "7fac3203-99e0-45fb-b636-9aa9f67b6b8e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T16:05:54+00:00",
      "updated_at": "2023-02-07T16:05:54+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "62bbb8b4-fa7b-4464-824e-01c649a3c96d"
          },
          {
            "type": "menu_items",
            "id": "a9b4f28f-ae2e-4790-aff3-208bc3f278c3"
          },
          {
            "type": "menu_items",
            "id": "ce1c8761-835f-4bbd-a1a2-4666dd8535fa"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "62bbb8b4-fa7b-4464-824e-01c649a3c96d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T16:05:54+00:00",
        "updated_at": "2023-02-07T16:05:54+00:00",
        "menu_id": "7fac3203-99e0-45fb-b636-9aa9f67b6b8e",
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
      "id": "a9b4f28f-ae2e-4790-aff3-208bc3f278c3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T16:05:54+00:00",
        "updated_at": "2023-02-07T16:05:54+00:00",
        "menu_id": "7fac3203-99e0-45fb-b636-9aa9f67b6b8e",
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
      "id": "ce1c8761-835f-4bbd-a1a2-4666dd8535fa",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T16:05:54+00:00",
        "updated_at": "2023-02-07T16:05:54+00:00",
        "menu_id": "7fac3203-99e0-45fb-b636-9aa9f67b6b8e",
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
    --url 'https://example.booqable.com/api/boomerang/menus/664fa7aa-eee2-4bbc-8a41-6174f29554cc' \
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