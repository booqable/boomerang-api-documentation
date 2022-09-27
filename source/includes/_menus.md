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
      "id": "bec82706-1a94-4c56-afd3-e0ca191b0cd1",
      "type": "menus",
      "attributes": {
        "created_at": "2022-09-27T06:43:36+00:00",
        "updated_at": "2022-09-27T06:43:36+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=bec82706-1a94-4c56-afd3-e0ca191b0cd1"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-27T06:41:48Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/4508b0e8-c8e6-4aee-be24-6950636da7c6?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4508b0e8-c8e6-4aee-be24-6950636da7c6",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-27T06:43:36+00:00",
      "updated_at": "2022-09-27T06:43:36+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=4508b0e8-c8e6-4aee-be24-6950636da7c6"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "4299c7af-8fd4-4ea6-b188-d751a25d2b43"
          },
          {
            "type": "menu_items",
            "id": "94629b9c-44fc-448d-ac6b-cc16e7488d2e"
          },
          {
            "type": "menu_items",
            "id": "2e2b4e5b-db90-4275-9fce-7a3e76275a93"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4299c7af-8fd4-4ea6-b188-d751a25d2b43",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-27T06:43:36+00:00",
        "updated_at": "2022-09-27T06:43:36+00:00",
        "menu_id": "4508b0e8-c8e6-4aee-be24-6950636da7c6",
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
            "related": "api/boomerang/menus/4508b0e8-c8e6-4aee-be24-6950636da7c6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4299c7af-8fd4-4ea6-b188-d751a25d2b43"
          }
        }
      }
    },
    {
      "id": "94629b9c-44fc-448d-ac6b-cc16e7488d2e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-27T06:43:36+00:00",
        "updated_at": "2022-09-27T06:43:36+00:00",
        "menu_id": "4508b0e8-c8e6-4aee-be24-6950636da7c6",
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
            "related": "api/boomerang/menus/4508b0e8-c8e6-4aee-be24-6950636da7c6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=94629b9c-44fc-448d-ac6b-cc16e7488d2e"
          }
        }
      }
    },
    {
      "id": "2e2b4e5b-db90-4275-9fce-7a3e76275a93",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-27T06:43:36+00:00",
        "updated_at": "2022-09-27T06:43:36+00:00",
        "menu_id": "4508b0e8-c8e6-4aee-be24-6950636da7c6",
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
            "related": "api/boomerang/menus/4508b0e8-c8e6-4aee-be24-6950636da7c6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2e2b4e5b-db90-4275-9fce-7a3e76275a93"
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
    "id": "dd01c2cc-75d1-415b-b29b-deac4fc40ddf",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-27T06:43:37+00:00",
      "updated_at": "2022-09-27T06:43:37+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c02d677f-240e-494c-bfb4-437ca7164dbd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c02d677f-240e-494c-bfb4-437ca7164dbd",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "23276b23-9b79-4d48-9c6a-9041fa47101c",
              "title": "Contact us"
            },
            {
              "id": "fec6f6d1-4423-42ad-a364-b5ef8e5b5833",
              "title": "Start"
            },
            {
              "id": "1e1c2ef1-3930-48ee-a1b0-1a34fcb81d76",
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
    "id": "c02d677f-240e-494c-bfb4-437ca7164dbd",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-27T06:43:37+00:00",
      "updated_at": "2022-09-27T06:43:37+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "23276b23-9b79-4d48-9c6a-9041fa47101c"
          },
          {
            "type": "menu_items",
            "id": "fec6f6d1-4423-42ad-a364-b5ef8e5b5833"
          },
          {
            "type": "menu_items",
            "id": "1e1c2ef1-3930-48ee-a1b0-1a34fcb81d76"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "23276b23-9b79-4d48-9c6a-9041fa47101c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-27T06:43:37+00:00",
        "updated_at": "2022-09-27T06:43:37+00:00",
        "menu_id": "c02d677f-240e-494c-bfb4-437ca7164dbd",
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
      "id": "fec6f6d1-4423-42ad-a364-b5ef8e5b5833",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-27T06:43:37+00:00",
        "updated_at": "2022-09-27T06:43:37+00:00",
        "menu_id": "c02d677f-240e-494c-bfb4-437ca7164dbd",
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
      "id": "1e1c2ef1-3930-48ee-a1b0-1a34fcb81d76",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-27T06:43:37+00:00",
        "updated_at": "2022-09-27T06:43:37+00:00",
        "menu_id": "c02d677f-240e-494c-bfb4-437ca7164dbd",
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
    --url 'https://example.booqable.com/api/boomerang/menus/49c87b39-f715-45bc-8e2a-9761ccb1f47b' \
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