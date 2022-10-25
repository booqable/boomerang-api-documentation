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
      "id": "fb644d2a-047a-4629-8ed0-2b8906e0393b",
      "type": "menus",
      "attributes": {
        "created_at": "2022-10-25T17:52:52+00:00",
        "updated_at": "2022-10-25T17:52:52+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=fb644d2a-047a-4629-8ed0-2b8906e0393b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T17:50:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/e1ca3ffa-86b4-406b-ae18-5a91934f61c7?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e1ca3ffa-86b4-406b-ae18-5a91934f61c7",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-25T17:52:52+00:00",
      "updated_at": "2022-10-25T17:52:52+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=e1ca3ffa-86b4-406b-ae18-5a91934f61c7"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "e8c78b25-4aaa-48b5-8d23-6c4079723c96"
          },
          {
            "type": "menu_items",
            "id": "e2820d3e-5cee-4378-8a8f-5de66688e9be"
          },
          {
            "type": "menu_items",
            "id": "1bdfe85d-e5b1-4269-b349-0eed18e61c53"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e8c78b25-4aaa-48b5-8d23-6c4079723c96",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T17:52:52+00:00",
        "updated_at": "2022-10-25T17:52:52+00:00",
        "menu_id": "e1ca3ffa-86b4-406b-ae18-5a91934f61c7",
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
            "related": "api/boomerang/menus/e1ca3ffa-86b4-406b-ae18-5a91934f61c7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e8c78b25-4aaa-48b5-8d23-6c4079723c96"
          }
        }
      }
    },
    {
      "id": "e2820d3e-5cee-4378-8a8f-5de66688e9be",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T17:52:52+00:00",
        "updated_at": "2022-10-25T17:52:52+00:00",
        "menu_id": "e1ca3ffa-86b4-406b-ae18-5a91934f61c7",
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
            "related": "api/boomerang/menus/e1ca3ffa-86b4-406b-ae18-5a91934f61c7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e2820d3e-5cee-4378-8a8f-5de66688e9be"
          }
        }
      }
    },
    {
      "id": "1bdfe85d-e5b1-4269-b349-0eed18e61c53",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T17:52:52+00:00",
        "updated_at": "2022-10-25T17:52:52+00:00",
        "menu_id": "e1ca3ffa-86b4-406b-ae18-5a91934f61c7",
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
            "related": "api/boomerang/menus/e1ca3ffa-86b4-406b-ae18-5a91934f61c7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1bdfe85d-e5b1-4269-b349-0eed18e61c53"
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
    "id": "dbea0c23-6b63-4652-9810-cad5055bbdca",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-25T17:52:52+00:00",
      "updated_at": "2022-10-25T17:52:52+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f92e5d76-80a7-4bab-aad1-7aa589e626c7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f92e5d76-80a7-4bab-aad1-7aa589e626c7",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "7671a279-2523-4cf7-a785-17e2db4d243b",
              "title": "Contact us"
            },
            {
              "id": "f8319e40-9b89-48b7-8c5f-0fefe44aeaf4",
              "title": "Start"
            },
            {
              "id": "748dc865-c057-4797-a7bc-d4593e40605f",
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
    "id": "f92e5d76-80a7-4bab-aad1-7aa589e626c7",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-25T17:52:53+00:00",
      "updated_at": "2022-10-25T17:52:53+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "7671a279-2523-4cf7-a785-17e2db4d243b"
          },
          {
            "type": "menu_items",
            "id": "f8319e40-9b89-48b7-8c5f-0fefe44aeaf4"
          },
          {
            "type": "menu_items",
            "id": "748dc865-c057-4797-a7bc-d4593e40605f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7671a279-2523-4cf7-a785-17e2db4d243b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T17:52:53+00:00",
        "updated_at": "2022-10-25T17:52:53+00:00",
        "menu_id": "f92e5d76-80a7-4bab-aad1-7aa589e626c7",
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
      "id": "f8319e40-9b89-48b7-8c5f-0fefe44aeaf4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T17:52:53+00:00",
        "updated_at": "2022-10-25T17:52:53+00:00",
        "menu_id": "f92e5d76-80a7-4bab-aad1-7aa589e626c7",
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
      "id": "748dc865-c057-4797-a7bc-d4593e40605f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T17:52:53+00:00",
        "updated_at": "2022-10-25T17:52:53+00:00",
        "menu_id": "f92e5d76-80a7-4bab-aad1-7aa589e626c7",
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
    --url 'https://example.booqable.com/api/boomerang/menus/17d4f6d4-3043-464f-9cff-b03ce7f8b3a2' \
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