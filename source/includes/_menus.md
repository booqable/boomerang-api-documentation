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
      "id": "12defcbd-60e7-4de1-aee9-69e71868ee08",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-28T08:12:05+00:00",
        "updated_at": "2023-02-28T08:12:05+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=12defcbd-60e7-4de1-aee9-69e71868ee08"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T08:10:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/50410d2c-740c-473a-8f4a-b056b0c9a3d0?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "50410d2c-740c-473a-8f4a-b056b0c9a3d0",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-28T08:12:05+00:00",
      "updated_at": "2023-02-28T08:12:05+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=50410d2c-740c-473a-8f4a-b056b0c9a3d0"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "0b58cfdb-77cd-4f00-930f-fb954fe21664"
          },
          {
            "type": "menu_items",
            "id": "449bedef-da1f-4e17-bc50-2e1da5d785be"
          },
          {
            "type": "menu_items",
            "id": "79507db7-66cf-464d-8b32-c9bbb4298984"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0b58cfdb-77cd-4f00-930f-fb954fe21664",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T08:12:05+00:00",
        "updated_at": "2023-02-28T08:12:05+00:00",
        "menu_id": "50410d2c-740c-473a-8f4a-b056b0c9a3d0",
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
            "related": "api/boomerang/menus/50410d2c-740c-473a-8f4a-b056b0c9a3d0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0b58cfdb-77cd-4f00-930f-fb954fe21664"
          }
        }
      }
    },
    {
      "id": "449bedef-da1f-4e17-bc50-2e1da5d785be",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T08:12:05+00:00",
        "updated_at": "2023-02-28T08:12:05+00:00",
        "menu_id": "50410d2c-740c-473a-8f4a-b056b0c9a3d0",
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
            "related": "api/boomerang/menus/50410d2c-740c-473a-8f4a-b056b0c9a3d0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=449bedef-da1f-4e17-bc50-2e1da5d785be"
          }
        }
      }
    },
    {
      "id": "79507db7-66cf-464d-8b32-c9bbb4298984",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T08:12:05+00:00",
        "updated_at": "2023-02-28T08:12:05+00:00",
        "menu_id": "50410d2c-740c-473a-8f4a-b056b0c9a3d0",
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
            "related": "api/boomerang/menus/50410d2c-740c-473a-8f4a-b056b0c9a3d0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=79507db7-66cf-464d-8b32-c9bbb4298984"
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
    "id": "769e876e-a795-4951-824b-861176f67732",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-28T08:12:06+00:00",
      "updated_at": "2023-02-28T08:12:06+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c121916b-168d-4522-a9d9-d3c23db5c75a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c121916b-168d-4522-a9d9-d3c23db5c75a",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d3b33053-dba9-4f68-a3ed-295c653b39a7",
              "title": "Contact us"
            },
            {
              "id": "47c907a5-edd2-4775-ac19-3db7a81ba0d7",
              "title": "Start"
            },
            {
              "id": "c1f256a6-0280-47e7-ada0-2da5b4564b71",
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
    "id": "c121916b-168d-4522-a9d9-d3c23db5c75a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-28T08:12:06+00:00",
      "updated_at": "2023-02-28T08:12:06+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d3b33053-dba9-4f68-a3ed-295c653b39a7"
          },
          {
            "type": "menu_items",
            "id": "47c907a5-edd2-4775-ac19-3db7a81ba0d7"
          },
          {
            "type": "menu_items",
            "id": "c1f256a6-0280-47e7-ada0-2da5b4564b71"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d3b33053-dba9-4f68-a3ed-295c653b39a7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T08:12:06+00:00",
        "updated_at": "2023-02-28T08:12:06+00:00",
        "menu_id": "c121916b-168d-4522-a9d9-d3c23db5c75a",
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
      "id": "47c907a5-edd2-4775-ac19-3db7a81ba0d7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T08:12:06+00:00",
        "updated_at": "2023-02-28T08:12:06+00:00",
        "menu_id": "c121916b-168d-4522-a9d9-d3c23db5c75a",
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
      "id": "c1f256a6-0280-47e7-ada0-2da5b4564b71",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T08:12:06+00:00",
        "updated_at": "2023-02-28T08:12:06+00:00",
        "menu_id": "c121916b-168d-4522-a9d9-d3c23db5c75a",
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
    --url 'https://example.booqable.com/api/boomerang/menus/3df4a75c-a070-46db-9a02-43cf79aafb50' \
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