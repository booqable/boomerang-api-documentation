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
      "id": "6827708e-e116-4b4f-9f84-f26a02a7ecf5",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-05T16:28:09+00:00",
        "updated_at": "2023-01-05T16:28:09+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=6827708e-e116-4b4f-9f84-f26a02a7ecf5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T16:26:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/96d77368-89d5-4123-9588-df27e03abba3?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "96d77368-89d5-4123-9588-df27e03abba3",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T16:28:09+00:00",
      "updated_at": "2023-01-05T16:28:09+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=96d77368-89d5-4123-9588-df27e03abba3"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "4858c90a-7b9c-44ea-98b4-e4405abdf551"
          },
          {
            "type": "menu_items",
            "id": "615d28cd-0cf1-4699-90e7-df67adbbb705"
          },
          {
            "type": "menu_items",
            "id": "333013c7-b14a-41ba-9ff0-d26a6387d4b6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4858c90a-7b9c-44ea-98b4-e4405abdf551",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T16:28:09+00:00",
        "updated_at": "2023-01-05T16:28:09+00:00",
        "menu_id": "96d77368-89d5-4123-9588-df27e03abba3",
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
            "related": "api/boomerang/menus/96d77368-89d5-4123-9588-df27e03abba3"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4858c90a-7b9c-44ea-98b4-e4405abdf551"
          }
        }
      }
    },
    {
      "id": "615d28cd-0cf1-4699-90e7-df67adbbb705",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T16:28:09+00:00",
        "updated_at": "2023-01-05T16:28:09+00:00",
        "menu_id": "96d77368-89d5-4123-9588-df27e03abba3",
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
            "related": "api/boomerang/menus/96d77368-89d5-4123-9588-df27e03abba3"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=615d28cd-0cf1-4699-90e7-df67adbbb705"
          }
        }
      }
    },
    {
      "id": "333013c7-b14a-41ba-9ff0-d26a6387d4b6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T16:28:09+00:00",
        "updated_at": "2023-01-05T16:28:09+00:00",
        "menu_id": "96d77368-89d5-4123-9588-df27e03abba3",
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
            "related": "api/boomerang/menus/96d77368-89d5-4123-9588-df27e03abba3"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=333013c7-b14a-41ba-9ff0-d26a6387d4b6"
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
    "id": "a62b5964-2804-497f-8267-1760e8d55b9e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T16:28:09+00:00",
      "updated_at": "2023-01-05T16:28:09+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/52a7af09-459c-4407-a0e8-f67515ada8d7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "52a7af09-459c-4407-a0e8-f67515ada8d7",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d850a111-d843-43fa-bd81-da9becc73f7b",
              "title": "Contact us"
            },
            {
              "id": "a0e2b6ee-8f80-4e19-8978-0bd2fb69b7c9",
              "title": "Start"
            },
            {
              "id": "700fc9d2-c60e-46f2-84cf-4a35dfd7fd2b",
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
    "id": "52a7af09-459c-4407-a0e8-f67515ada8d7",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T16:28:10+00:00",
      "updated_at": "2023-01-05T16:28:10+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d850a111-d843-43fa-bd81-da9becc73f7b"
          },
          {
            "type": "menu_items",
            "id": "a0e2b6ee-8f80-4e19-8978-0bd2fb69b7c9"
          },
          {
            "type": "menu_items",
            "id": "700fc9d2-c60e-46f2-84cf-4a35dfd7fd2b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d850a111-d843-43fa-bd81-da9becc73f7b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T16:28:10+00:00",
        "updated_at": "2023-01-05T16:28:10+00:00",
        "menu_id": "52a7af09-459c-4407-a0e8-f67515ada8d7",
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
      "id": "a0e2b6ee-8f80-4e19-8978-0bd2fb69b7c9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T16:28:10+00:00",
        "updated_at": "2023-01-05T16:28:10+00:00",
        "menu_id": "52a7af09-459c-4407-a0e8-f67515ada8d7",
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
      "id": "700fc9d2-c60e-46f2-84cf-4a35dfd7fd2b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T16:28:10+00:00",
        "updated_at": "2023-01-05T16:28:10+00:00",
        "menu_id": "52a7af09-459c-4407-a0e8-f67515ada8d7",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a33b3fbe-a548-4a2d-bd54-6a430d047a55' \
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