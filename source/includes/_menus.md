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
      "id": "cb478b60-f472-4bdb-8e6b-7059aada340c",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-09T13:50:12+00:00",
        "updated_at": "2023-03-09T13:50:12+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=cb478b60-f472-4bdb-8e6b-7059aada340c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T13:48:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/e90d18b1-ab8b-48bf-8e2f-7e4b38245f92?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e90d18b1-ab8b-48bf-8e2f-7e4b38245f92",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-09T13:50:12+00:00",
      "updated_at": "2023-03-09T13:50:12+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=e90d18b1-ab8b-48bf-8e2f-7e4b38245f92"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "f75a3677-f5ed-4cf2-b19a-e7a909980224"
          },
          {
            "type": "menu_items",
            "id": "d9a67b87-fd88-4466-8ec7-951e9e1cf06b"
          },
          {
            "type": "menu_items",
            "id": "2aea0dbc-54bf-422e-8ace-263a0a809220"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f75a3677-f5ed-4cf2-b19a-e7a909980224",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T13:50:12+00:00",
        "updated_at": "2023-03-09T13:50:12+00:00",
        "menu_id": "e90d18b1-ab8b-48bf-8e2f-7e4b38245f92",
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
            "related": "api/boomerang/menus/e90d18b1-ab8b-48bf-8e2f-7e4b38245f92"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f75a3677-f5ed-4cf2-b19a-e7a909980224"
          }
        }
      }
    },
    {
      "id": "d9a67b87-fd88-4466-8ec7-951e9e1cf06b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T13:50:12+00:00",
        "updated_at": "2023-03-09T13:50:12+00:00",
        "menu_id": "e90d18b1-ab8b-48bf-8e2f-7e4b38245f92",
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
            "related": "api/boomerang/menus/e90d18b1-ab8b-48bf-8e2f-7e4b38245f92"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d9a67b87-fd88-4466-8ec7-951e9e1cf06b"
          }
        }
      }
    },
    {
      "id": "2aea0dbc-54bf-422e-8ace-263a0a809220",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T13:50:12+00:00",
        "updated_at": "2023-03-09T13:50:12+00:00",
        "menu_id": "e90d18b1-ab8b-48bf-8e2f-7e4b38245f92",
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
            "related": "api/boomerang/menus/e90d18b1-ab8b-48bf-8e2f-7e4b38245f92"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2aea0dbc-54bf-422e-8ace-263a0a809220"
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
    "id": "b16d4d8b-f5c8-4c84-b32a-640977fa583d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-09T13:50:13+00:00",
      "updated_at": "2023-03-09T13:50:13+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/230e177a-2155-4a1c-9715-825c0a3598f2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "230e177a-2155-4a1c-9715-825c0a3598f2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "bf418edf-0309-49c7-a000-503c219a6d32",
              "title": "Contact us"
            },
            {
              "id": "ce123b18-464a-4b02-bba5-02ac26ff0c8e",
              "title": "Start"
            },
            {
              "id": "9643df16-2c2b-40b3-abbf-6a2753d2cd39",
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
    "id": "230e177a-2155-4a1c-9715-825c0a3598f2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-09T13:50:13+00:00",
      "updated_at": "2023-03-09T13:50:13+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "bf418edf-0309-49c7-a000-503c219a6d32"
          },
          {
            "type": "menu_items",
            "id": "ce123b18-464a-4b02-bba5-02ac26ff0c8e"
          },
          {
            "type": "menu_items",
            "id": "9643df16-2c2b-40b3-abbf-6a2753d2cd39"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bf418edf-0309-49c7-a000-503c219a6d32",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T13:50:13+00:00",
        "updated_at": "2023-03-09T13:50:13+00:00",
        "menu_id": "230e177a-2155-4a1c-9715-825c0a3598f2",
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
      "id": "ce123b18-464a-4b02-bba5-02ac26ff0c8e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T13:50:13+00:00",
        "updated_at": "2023-03-09T13:50:13+00:00",
        "menu_id": "230e177a-2155-4a1c-9715-825c0a3598f2",
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
      "id": "9643df16-2c2b-40b3-abbf-6a2753d2cd39",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T13:50:13+00:00",
        "updated_at": "2023-03-09T13:50:13+00:00",
        "menu_id": "230e177a-2155-4a1c-9715-825c0a3598f2",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b267c381-fb4d-4481-bd6d-908e350d1465' \
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