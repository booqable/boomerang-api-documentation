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
      "id": "4602a192-5cd6-40c9-8546-25b1def51d06",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-23T00:25:18+00:00",
        "updated_at": "2023-02-23T00:25:18+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=4602a192-5cd6-40c9-8546-25b1def51d06"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T00:22:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/29bfa92c-ef68-4223-9fea-b8c7630395a6?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "29bfa92c-ef68-4223-9fea-b8c7630395a6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T00:25:18+00:00",
      "updated_at": "2023-02-23T00:25:18+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=29bfa92c-ef68-4223-9fea-b8c7630395a6"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "9a2e2d0f-a59e-46cb-b1f5-85029df24d02"
          },
          {
            "type": "menu_items",
            "id": "0e26e6cd-ddb8-4ff4-a88f-297b05d2a77c"
          },
          {
            "type": "menu_items",
            "id": "8b3e97b7-ca5f-4726-849c-6be066d102da"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9a2e2d0f-a59e-46cb-b1f5-85029df24d02",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T00:25:18+00:00",
        "updated_at": "2023-02-23T00:25:18+00:00",
        "menu_id": "29bfa92c-ef68-4223-9fea-b8c7630395a6",
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
            "related": "api/boomerang/menus/29bfa92c-ef68-4223-9fea-b8c7630395a6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9a2e2d0f-a59e-46cb-b1f5-85029df24d02"
          }
        }
      }
    },
    {
      "id": "0e26e6cd-ddb8-4ff4-a88f-297b05d2a77c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T00:25:18+00:00",
        "updated_at": "2023-02-23T00:25:18+00:00",
        "menu_id": "29bfa92c-ef68-4223-9fea-b8c7630395a6",
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
            "related": "api/boomerang/menus/29bfa92c-ef68-4223-9fea-b8c7630395a6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0e26e6cd-ddb8-4ff4-a88f-297b05d2a77c"
          }
        }
      }
    },
    {
      "id": "8b3e97b7-ca5f-4726-849c-6be066d102da",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T00:25:18+00:00",
        "updated_at": "2023-02-23T00:25:18+00:00",
        "menu_id": "29bfa92c-ef68-4223-9fea-b8c7630395a6",
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
            "related": "api/boomerang/menus/29bfa92c-ef68-4223-9fea-b8c7630395a6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8b3e97b7-ca5f-4726-849c-6be066d102da"
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
    "id": "188c0029-ec1a-438a-9c66-777abe0c6ac8",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T00:25:18+00:00",
      "updated_at": "2023-02-23T00:25:18+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a3570769-0546-4ef0-9ab0-f5a6d07456c2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a3570769-0546-4ef0-9ab0-f5a6d07456c2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "7b2d48e3-21df-448c-b4e5-916a603756ee",
              "title": "Contact us"
            },
            {
              "id": "e523ff92-993c-4a8d-8690-e17a3be38ff7",
              "title": "Start"
            },
            {
              "id": "3311aeaa-440f-4dd4-808b-ce1861c243f7",
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
    "id": "a3570769-0546-4ef0-9ab0-f5a6d07456c2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T00:25:19+00:00",
      "updated_at": "2023-02-23T00:25:19+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "7b2d48e3-21df-448c-b4e5-916a603756ee"
          },
          {
            "type": "menu_items",
            "id": "e523ff92-993c-4a8d-8690-e17a3be38ff7"
          },
          {
            "type": "menu_items",
            "id": "3311aeaa-440f-4dd4-808b-ce1861c243f7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7b2d48e3-21df-448c-b4e5-916a603756ee",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T00:25:19+00:00",
        "updated_at": "2023-02-23T00:25:19+00:00",
        "menu_id": "a3570769-0546-4ef0-9ab0-f5a6d07456c2",
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
      "id": "e523ff92-993c-4a8d-8690-e17a3be38ff7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T00:25:19+00:00",
        "updated_at": "2023-02-23T00:25:19+00:00",
        "menu_id": "a3570769-0546-4ef0-9ab0-f5a6d07456c2",
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
      "id": "3311aeaa-440f-4dd4-808b-ce1861c243f7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T00:25:19+00:00",
        "updated_at": "2023-02-23T00:25:19+00:00",
        "menu_id": "a3570769-0546-4ef0-9ab0-f5a6d07456c2",
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
    --url 'https://example.booqable.com/api/boomerang/menus/2d260587-ef09-4937-be81-6c54a9623249' \
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