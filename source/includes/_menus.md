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
      "id": "c77669d7-1c5d-4592-8911-394ee4564278",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-01T14:49:31+00:00",
        "updated_at": "2023-03-01T14:49:31+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=c77669d7-1c5d-4592-8911-394ee4564278"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T14:47:52Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/84a6fefb-8cca-42e1-9c6e-ffeb2733fdfe?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "84a6fefb-8cca-42e1-9c6e-ffeb2733fdfe",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T14:49:31+00:00",
      "updated_at": "2023-03-01T14:49:31+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=84a6fefb-8cca-42e1-9c6e-ffeb2733fdfe"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "53c308e2-fe21-49b8-9bf6-2ac4648cffc1"
          },
          {
            "type": "menu_items",
            "id": "3872400e-fcab-48d6-a695-1e08c2d0abe4"
          },
          {
            "type": "menu_items",
            "id": "0a726d53-a5c0-4db3-8b10-8d4243d220b4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "53c308e2-fe21-49b8-9bf6-2ac4648cffc1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T14:49:31+00:00",
        "updated_at": "2023-03-01T14:49:31+00:00",
        "menu_id": "84a6fefb-8cca-42e1-9c6e-ffeb2733fdfe",
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
            "related": "api/boomerang/menus/84a6fefb-8cca-42e1-9c6e-ffeb2733fdfe"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=53c308e2-fe21-49b8-9bf6-2ac4648cffc1"
          }
        }
      }
    },
    {
      "id": "3872400e-fcab-48d6-a695-1e08c2d0abe4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T14:49:31+00:00",
        "updated_at": "2023-03-01T14:49:31+00:00",
        "menu_id": "84a6fefb-8cca-42e1-9c6e-ffeb2733fdfe",
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
            "related": "api/boomerang/menus/84a6fefb-8cca-42e1-9c6e-ffeb2733fdfe"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3872400e-fcab-48d6-a695-1e08c2d0abe4"
          }
        }
      }
    },
    {
      "id": "0a726d53-a5c0-4db3-8b10-8d4243d220b4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T14:49:31+00:00",
        "updated_at": "2023-03-01T14:49:31+00:00",
        "menu_id": "84a6fefb-8cca-42e1-9c6e-ffeb2733fdfe",
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
            "related": "api/boomerang/menus/84a6fefb-8cca-42e1-9c6e-ffeb2733fdfe"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0a726d53-a5c0-4db3-8b10-8d4243d220b4"
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
    "id": "6ff65202-b7aa-4c01-97ab-0d9c26a816e9",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T14:49:32+00:00",
      "updated_at": "2023-03-01T14:49:32+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/90d379c3-e24c-4722-aca6-83bbdd43ac4d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "90d379c3-e24c-4722-aca6-83bbdd43ac4d",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "6b9386c8-3771-40b2-9243-017f3d3ee7a0",
              "title": "Contact us"
            },
            {
              "id": "f926960e-c2b5-4326-b2c3-f4c5947e7945",
              "title": "Start"
            },
            {
              "id": "c821f20f-c58e-4ff0-b0a7-6ee70a4350e5",
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
    "id": "90d379c3-e24c-4722-aca6-83bbdd43ac4d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T14:49:32+00:00",
      "updated_at": "2023-03-01T14:49:32+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "6b9386c8-3771-40b2-9243-017f3d3ee7a0"
          },
          {
            "type": "menu_items",
            "id": "f926960e-c2b5-4326-b2c3-f4c5947e7945"
          },
          {
            "type": "menu_items",
            "id": "c821f20f-c58e-4ff0-b0a7-6ee70a4350e5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6b9386c8-3771-40b2-9243-017f3d3ee7a0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T14:49:32+00:00",
        "updated_at": "2023-03-01T14:49:32+00:00",
        "menu_id": "90d379c3-e24c-4722-aca6-83bbdd43ac4d",
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
      "id": "f926960e-c2b5-4326-b2c3-f4c5947e7945",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T14:49:32+00:00",
        "updated_at": "2023-03-01T14:49:32+00:00",
        "menu_id": "90d379c3-e24c-4722-aca6-83bbdd43ac4d",
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
      "id": "c821f20f-c58e-4ff0-b0a7-6ee70a4350e5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T14:49:32+00:00",
        "updated_at": "2023-03-01T14:49:32+00:00",
        "menu_id": "90d379c3-e24c-4722-aca6-83bbdd43ac4d",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d59d6181-c813-4824-9edd-2c3d757dcf05' \
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