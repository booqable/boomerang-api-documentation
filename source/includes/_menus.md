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
      "id": "8e6cfa2d-c597-480e-a6dc-c480ef73e09e",
      "type": "menus",
      "attributes": {
        "created_at": "2022-10-13T12:38:38+00:00",
        "updated_at": "2022-10-13T12:38:38+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=8e6cfa2d-c597-480e-a6dc-c480ef73e09e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T12:36:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/a0c5b951-307a-42ef-8e9b-3ad689d7939f?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a0c5b951-307a-42ef-8e9b-3ad689d7939f",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-13T12:38:39+00:00",
      "updated_at": "2022-10-13T12:38:39+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a0c5b951-307a-42ef-8e9b-3ad689d7939f"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "60a52e4c-4992-4b58-a32c-ba7faf5018cf"
          },
          {
            "type": "menu_items",
            "id": "c7d88bfa-b9e1-441f-ace7-6da239d6ac57"
          },
          {
            "type": "menu_items",
            "id": "01f2502e-44c8-4720-9109-2cd568134f9e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "60a52e4c-4992-4b58-a32c-ba7faf5018cf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T12:38:39+00:00",
        "updated_at": "2022-10-13T12:38:39+00:00",
        "menu_id": "a0c5b951-307a-42ef-8e9b-3ad689d7939f",
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
            "related": "api/boomerang/menus/a0c5b951-307a-42ef-8e9b-3ad689d7939f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=60a52e4c-4992-4b58-a32c-ba7faf5018cf"
          }
        }
      }
    },
    {
      "id": "c7d88bfa-b9e1-441f-ace7-6da239d6ac57",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T12:38:39+00:00",
        "updated_at": "2022-10-13T12:38:39+00:00",
        "menu_id": "a0c5b951-307a-42ef-8e9b-3ad689d7939f",
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
            "related": "api/boomerang/menus/a0c5b951-307a-42ef-8e9b-3ad689d7939f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c7d88bfa-b9e1-441f-ace7-6da239d6ac57"
          }
        }
      }
    },
    {
      "id": "01f2502e-44c8-4720-9109-2cd568134f9e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T12:38:39+00:00",
        "updated_at": "2022-10-13T12:38:39+00:00",
        "menu_id": "a0c5b951-307a-42ef-8e9b-3ad689d7939f",
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
            "related": "api/boomerang/menus/a0c5b951-307a-42ef-8e9b-3ad689d7939f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=01f2502e-44c8-4720-9109-2cd568134f9e"
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
    "id": "ed10fdbd-d13e-45ca-aaa4-0b69c5e64453",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-13T12:38:39+00:00",
      "updated_at": "2022-10-13T12:38:39+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/336d0f73-c4fb-42a8-85f7-017d470b79b6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "336d0f73-c4fb-42a8-85f7-017d470b79b6",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "6d352725-3437-4e63-ac56-de62f600cdc6",
              "title": "Contact us"
            },
            {
              "id": "4e8e1300-32f7-493f-a753-d25091786fe5",
              "title": "Start"
            },
            {
              "id": "1bfcc69d-2562-4d73-9268-27146e1385d9",
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
    "id": "336d0f73-c4fb-42a8-85f7-017d470b79b6",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-13T12:38:40+00:00",
      "updated_at": "2022-10-13T12:38:40+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "6d352725-3437-4e63-ac56-de62f600cdc6"
          },
          {
            "type": "menu_items",
            "id": "4e8e1300-32f7-493f-a753-d25091786fe5"
          },
          {
            "type": "menu_items",
            "id": "1bfcc69d-2562-4d73-9268-27146e1385d9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6d352725-3437-4e63-ac56-de62f600cdc6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T12:38:40+00:00",
        "updated_at": "2022-10-13T12:38:40+00:00",
        "menu_id": "336d0f73-c4fb-42a8-85f7-017d470b79b6",
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
      "id": "4e8e1300-32f7-493f-a753-d25091786fe5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T12:38:40+00:00",
        "updated_at": "2022-10-13T12:38:40+00:00",
        "menu_id": "336d0f73-c4fb-42a8-85f7-017d470b79b6",
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
      "id": "1bfcc69d-2562-4d73-9268-27146e1385d9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T12:38:40+00:00",
        "updated_at": "2022-10-13T12:38:40+00:00",
        "menu_id": "336d0f73-c4fb-42a8-85f7-017d470b79b6",
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
    --url 'https://example.booqable.com/api/boomerang/menus/52e331d7-a172-43a2-955c-6e2e2597ccd6' \
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