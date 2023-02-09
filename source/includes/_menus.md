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
      "id": "76b0448a-dd67-4736-98a2-ac9956f2df59",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-09T11:07:47+00:00",
        "updated_at": "2023-02-09T11:07:47+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=76b0448a-dd67-4736-98a2-ac9956f2df59"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T11:05:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/bec156a1-3c5a-485c-9157-1defc35c984b?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bec156a1-3c5a-485c-9157-1defc35c984b",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T11:07:48+00:00",
      "updated_at": "2023-02-09T11:07:48+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=bec156a1-3c5a-485c-9157-1defc35c984b"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "3a8043e1-dddf-4a02-929b-010817f2292a"
          },
          {
            "type": "menu_items",
            "id": "cf3e7e2c-2b80-4caf-8578-e37ab8924239"
          },
          {
            "type": "menu_items",
            "id": "37e2dbc2-57a4-49c8-a9b0-06e44d0b50a0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3a8043e1-dddf-4a02-929b-010817f2292a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T11:07:48+00:00",
        "updated_at": "2023-02-09T11:07:48+00:00",
        "menu_id": "bec156a1-3c5a-485c-9157-1defc35c984b",
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
            "related": "api/boomerang/menus/bec156a1-3c5a-485c-9157-1defc35c984b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3a8043e1-dddf-4a02-929b-010817f2292a"
          }
        }
      }
    },
    {
      "id": "cf3e7e2c-2b80-4caf-8578-e37ab8924239",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T11:07:48+00:00",
        "updated_at": "2023-02-09T11:07:48+00:00",
        "menu_id": "bec156a1-3c5a-485c-9157-1defc35c984b",
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
            "related": "api/boomerang/menus/bec156a1-3c5a-485c-9157-1defc35c984b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cf3e7e2c-2b80-4caf-8578-e37ab8924239"
          }
        }
      }
    },
    {
      "id": "37e2dbc2-57a4-49c8-a9b0-06e44d0b50a0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T11:07:48+00:00",
        "updated_at": "2023-02-09T11:07:48+00:00",
        "menu_id": "bec156a1-3c5a-485c-9157-1defc35c984b",
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
            "related": "api/boomerang/menus/bec156a1-3c5a-485c-9157-1defc35c984b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=37e2dbc2-57a4-49c8-a9b0-06e44d0b50a0"
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
    "id": "e9392628-da54-42c9-925d-57d7a59a7912",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T11:07:48+00:00",
      "updated_at": "2023-02-09T11:07:48+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5dedc257-ba2c-4d29-8282-6df65bc4491d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5dedc257-ba2c-4d29-8282-6df65bc4491d",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "051668d8-5b07-47eb-aad9-b24a8385c806",
              "title": "Contact us"
            },
            {
              "id": "9467c97b-655d-4db6-8fa1-ca992396d69b",
              "title": "Start"
            },
            {
              "id": "a3361dad-3d25-4ac1-8541-e28262fc3a17",
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
    "id": "5dedc257-ba2c-4d29-8282-6df65bc4491d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T11:07:48+00:00",
      "updated_at": "2023-02-09T11:07:49+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "051668d8-5b07-47eb-aad9-b24a8385c806"
          },
          {
            "type": "menu_items",
            "id": "9467c97b-655d-4db6-8fa1-ca992396d69b"
          },
          {
            "type": "menu_items",
            "id": "a3361dad-3d25-4ac1-8541-e28262fc3a17"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "051668d8-5b07-47eb-aad9-b24a8385c806",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T11:07:48+00:00",
        "updated_at": "2023-02-09T11:07:49+00:00",
        "menu_id": "5dedc257-ba2c-4d29-8282-6df65bc4491d",
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
      "id": "9467c97b-655d-4db6-8fa1-ca992396d69b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T11:07:48+00:00",
        "updated_at": "2023-02-09T11:07:49+00:00",
        "menu_id": "5dedc257-ba2c-4d29-8282-6df65bc4491d",
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
      "id": "a3361dad-3d25-4ac1-8541-e28262fc3a17",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T11:07:48+00:00",
        "updated_at": "2023-02-09T11:07:49+00:00",
        "menu_id": "5dedc257-ba2c-4d29-8282-6df65bc4491d",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d7483e94-cec1-4318-a9b6-86f689c1308c' \
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