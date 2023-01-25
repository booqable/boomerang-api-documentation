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
      "id": "24f39374-057c-44c3-8150-08be9d5dde21",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-25T12:35:51+00:00",
        "updated_at": "2023-01-25T12:35:51+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=24f39374-057c-44c3-8150-08be9d5dde21"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-25T12:33:37Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/56ec4713-120a-462f-bed6-c69b85fc80b4?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "56ec4713-120a-462f-bed6-c69b85fc80b4",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-25T12:35:51+00:00",
      "updated_at": "2023-01-25T12:35:51+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=56ec4713-120a-462f-bed6-c69b85fc80b4"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "7cc8e67c-1b67-4859-8a9f-e7d46433070b"
          },
          {
            "type": "menu_items",
            "id": "c447d02d-3c35-4dd8-82df-e9f701174453"
          },
          {
            "type": "menu_items",
            "id": "23c9ee2f-74e7-488b-9bcf-30a69af654b9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7cc8e67c-1b67-4859-8a9f-e7d46433070b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-25T12:35:51+00:00",
        "updated_at": "2023-01-25T12:35:51+00:00",
        "menu_id": "56ec4713-120a-462f-bed6-c69b85fc80b4",
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
            "related": "api/boomerang/menus/56ec4713-120a-462f-bed6-c69b85fc80b4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7cc8e67c-1b67-4859-8a9f-e7d46433070b"
          }
        }
      }
    },
    {
      "id": "c447d02d-3c35-4dd8-82df-e9f701174453",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-25T12:35:51+00:00",
        "updated_at": "2023-01-25T12:35:51+00:00",
        "menu_id": "56ec4713-120a-462f-bed6-c69b85fc80b4",
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
            "related": "api/boomerang/menus/56ec4713-120a-462f-bed6-c69b85fc80b4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c447d02d-3c35-4dd8-82df-e9f701174453"
          }
        }
      }
    },
    {
      "id": "23c9ee2f-74e7-488b-9bcf-30a69af654b9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-25T12:35:51+00:00",
        "updated_at": "2023-01-25T12:35:51+00:00",
        "menu_id": "56ec4713-120a-462f-bed6-c69b85fc80b4",
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
            "related": "api/boomerang/menus/56ec4713-120a-462f-bed6-c69b85fc80b4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=23c9ee2f-74e7-488b-9bcf-30a69af654b9"
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
    "id": "de8e4188-64be-47dc-ad86-aa6f6a18435d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-25T12:35:52+00:00",
      "updated_at": "2023-01-25T12:35:52+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f7331286-7899-41fa-b6ea-6c1bef4639ce' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f7331286-7899-41fa-b6ea-6c1bef4639ce",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "f9bd90b5-7549-4dfc-b045-097622ca2a0d",
              "title": "Contact us"
            },
            {
              "id": "f8e6f10a-ebff-4f45-8e61-3ced31df79de",
              "title": "Start"
            },
            {
              "id": "a46cddd4-38d9-46f8-9fdb-421a3c62948c",
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
    "id": "f7331286-7899-41fa-b6ea-6c1bef4639ce",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-25T12:35:52+00:00",
      "updated_at": "2023-01-25T12:35:52+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "f9bd90b5-7549-4dfc-b045-097622ca2a0d"
          },
          {
            "type": "menu_items",
            "id": "f8e6f10a-ebff-4f45-8e61-3ced31df79de"
          },
          {
            "type": "menu_items",
            "id": "a46cddd4-38d9-46f8-9fdb-421a3c62948c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f9bd90b5-7549-4dfc-b045-097622ca2a0d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-25T12:35:52+00:00",
        "updated_at": "2023-01-25T12:35:52+00:00",
        "menu_id": "f7331286-7899-41fa-b6ea-6c1bef4639ce",
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
      "id": "f8e6f10a-ebff-4f45-8e61-3ced31df79de",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-25T12:35:52+00:00",
        "updated_at": "2023-01-25T12:35:52+00:00",
        "menu_id": "f7331286-7899-41fa-b6ea-6c1bef4639ce",
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
      "id": "a46cddd4-38d9-46f8-9fdb-421a3c62948c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-25T12:35:52+00:00",
        "updated_at": "2023-01-25T12:35:52+00:00",
        "menu_id": "f7331286-7899-41fa-b6ea-6c1bef4639ce",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5a9b9261-721a-468a-8c1e-c05053f63d1c' \
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