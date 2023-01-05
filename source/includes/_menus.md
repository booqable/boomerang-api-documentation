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
      "id": "283688ce-c373-410e-9163-2ae22a8e8f20",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-05T11:03:59+00:00",
        "updated_at": "2023-01-05T11:03:59+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=283688ce-c373-410e-9163-2ae22a8e8f20"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T11:02:34Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/60bdb4cd-0023-48d6-bb05-1198264d9f27?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "60bdb4cd-0023-48d6-bb05-1198264d9f27",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T11:03:59+00:00",
      "updated_at": "2023-01-05T11:03:59+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=60bdb4cd-0023-48d6-bb05-1198264d9f27"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "bd301c1e-b2d1-48f8-ad75-1b3b5e9e4567"
          },
          {
            "type": "menu_items",
            "id": "54495945-61f1-4af3-b68e-980e61b8048a"
          },
          {
            "type": "menu_items",
            "id": "b01b4359-9fa8-4a75-9044-d8745b15b52b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bd301c1e-b2d1-48f8-ad75-1b3b5e9e4567",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T11:03:59+00:00",
        "updated_at": "2023-01-05T11:03:59+00:00",
        "menu_id": "60bdb4cd-0023-48d6-bb05-1198264d9f27",
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
            "related": "api/boomerang/menus/60bdb4cd-0023-48d6-bb05-1198264d9f27"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bd301c1e-b2d1-48f8-ad75-1b3b5e9e4567"
          }
        }
      }
    },
    {
      "id": "54495945-61f1-4af3-b68e-980e61b8048a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T11:03:59+00:00",
        "updated_at": "2023-01-05T11:03:59+00:00",
        "menu_id": "60bdb4cd-0023-48d6-bb05-1198264d9f27",
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
            "related": "api/boomerang/menus/60bdb4cd-0023-48d6-bb05-1198264d9f27"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=54495945-61f1-4af3-b68e-980e61b8048a"
          }
        }
      }
    },
    {
      "id": "b01b4359-9fa8-4a75-9044-d8745b15b52b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T11:03:59+00:00",
        "updated_at": "2023-01-05T11:03:59+00:00",
        "menu_id": "60bdb4cd-0023-48d6-bb05-1198264d9f27",
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
            "related": "api/boomerang/menus/60bdb4cd-0023-48d6-bb05-1198264d9f27"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b01b4359-9fa8-4a75-9044-d8745b15b52b"
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
    "id": "3ac4049a-60f6-4f4f-9d27-3a391c5b6cc5",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T11:04:00+00:00",
      "updated_at": "2023-01-05T11:04:00+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6b1254c1-100e-4e24-a6b1-ae885b8d3a5f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6b1254c1-100e-4e24-a6b1-ae885b8d3a5f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "78a9faa4-588b-456d-880a-bfc55450e92a",
              "title": "Contact us"
            },
            {
              "id": "2b0d851b-2ab7-4e50-a342-24319938e7bb",
              "title": "Start"
            },
            {
              "id": "8a0711c1-fec2-49f6-8559-f484c9ab547c",
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
    "id": "6b1254c1-100e-4e24-a6b1-ae885b8d3a5f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T11:04:00+00:00",
      "updated_at": "2023-01-05T11:04:00+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "78a9faa4-588b-456d-880a-bfc55450e92a"
          },
          {
            "type": "menu_items",
            "id": "2b0d851b-2ab7-4e50-a342-24319938e7bb"
          },
          {
            "type": "menu_items",
            "id": "8a0711c1-fec2-49f6-8559-f484c9ab547c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "78a9faa4-588b-456d-880a-bfc55450e92a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T11:04:00+00:00",
        "updated_at": "2023-01-05T11:04:00+00:00",
        "menu_id": "6b1254c1-100e-4e24-a6b1-ae885b8d3a5f",
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
      "id": "2b0d851b-2ab7-4e50-a342-24319938e7bb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T11:04:00+00:00",
        "updated_at": "2023-01-05T11:04:00+00:00",
        "menu_id": "6b1254c1-100e-4e24-a6b1-ae885b8d3a5f",
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
      "id": "8a0711c1-fec2-49f6-8559-f484c9ab547c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T11:04:00+00:00",
        "updated_at": "2023-01-05T11:04:00+00:00",
        "menu_id": "6b1254c1-100e-4e24-a6b1-ae885b8d3a5f",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ee56776e-477e-441d-8ba0-8bd9880c452a' \
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