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
      "id": "f02d2860-39a6-41ed-ae76-26794a58176a",
      "type": "menus",
      "attributes": {
        "created_at": "2022-09-16T14:14:29+00:00",
        "updated_at": "2022-09-16T14:14:29+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=f02d2860-39a6-41ed-ae76-26794a58176a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T14:12:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/02c632df-4ea9-47af-8db2-e1087c90e1f8?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "02c632df-4ea9-47af-8db2-e1087c90e1f8",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-16T14:14:30+00:00",
      "updated_at": "2022-09-16T14:14:30+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=02c632df-4ea9-47af-8db2-e1087c90e1f8"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "7c49d931-17a8-4252-b098-2b58bca9bc20"
          },
          {
            "type": "menu_items",
            "id": "2d092794-fb42-4a67-a4e3-e762a3383b85"
          },
          {
            "type": "menu_items",
            "id": "e519536f-d738-4faf-ab5c-0579732de88f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7c49d931-17a8-4252-b098-2b58bca9bc20",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T14:14:30+00:00",
        "updated_at": "2022-09-16T14:14:30+00:00",
        "menu_id": "02c632df-4ea9-47af-8db2-e1087c90e1f8",
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
            "related": "api/boomerang/menus/02c632df-4ea9-47af-8db2-e1087c90e1f8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7c49d931-17a8-4252-b098-2b58bca9bc20"
          }
        }
      }
    },
    {
      "id": "2d092794-fb42-4a67-a4e3-e762a3383b85",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T14:14:30+00:00",
        "updated_at": "2022-09-16T14:14:30+00:00",
        "menu_id": "02c632df-4ea9-47af-8db2-e1087c90e1f8",
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
            "related": "api/boomerang/menus/02c632df-4ea9-47af-8db2-e1087c90e1f8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2d092794-fb42-4a67-a4e3-e762a3383b85"
          }
        }
      }
    },
    {
      "id": "e519536f-d738-4faf-ab5c-0579732de88f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T14:14:30+00:00",
        "updated_at": "2022-09-16T14:14:30+00:00",
        "menu_id": "02c632df-4ea9-47af-8db2-e1087c90e1f8",
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
            "related": "api/boomerang/menus/02c632df-4ea9-47af-8db2-e1087c90e1f8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e519536f-d738-4faf-ab5c-0579732de88f"
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
    "id": "c987dc25-b0d0-4079-a201-e7f870bfd680",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-16T14:14:30+00:00",
      "updated_at": "2022-09-16T14:14:30+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/418c31e5-0569-4add-ac82-76f789c22bda' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "418c31e5-0569-4add-ac82-76f789c22bda",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "dc4255e3-e4b4-4ba3-baf5-3f2585315034",
              "title": "Contact us"
            },
            {
              "id": "ed3521ed-3916-41c0-b9d3-17dcce73ce66",
              "title": "Start"
            },
            {
              "id": "ebfcc58d-2823-4992-9066-a7d0f87b5f21",
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
    "id": "418c31e5-0569-4add-ac82-76f789c22bda",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-16T14:14:30+00:00",
      "updated_at": "2022-09-16T14:14:30+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "dc4255e3-e4b4-4ba3-baf5-3f2585315034"
          },
          {
            "type": "menu_items",
            "id": "ed3521ed-3916-41c0-b9d3-17dcce73ce66"
          },
          {
            "type": "menu_items",
            "id": "ebfcc58d-2823-4992-9066-a7d0f87b5f21"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dc4255e3-e4b4-4ba3-baf5-3f2585315034",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T14:14:30+00:00",
        "updated_at": "2022-09-16T14:14:30+00:00",
        "menu_id": "418c31e5-0569-4add-ac82-76f789c22bda",
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
      "id": "ed3521ed-3916-41c0-b9d3-17dcce73ce66",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T14:14:30+00:00",
        "updated_at": "2022-09-16T14:14:30+00:00",
        "menu_id": "418c31e5-0569-4add-ac82-76f789c22bda",
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
      "id": "ebfcc58d-2823-4992-9066-a7d0f87b5f21",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T14:14:30+00:00",
        "updated_at": "2022-09-16T14:14:30+00:00",
        "menu_id": "418c31e5-0569-4add-ac82-76f789c22bda",
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
    --url 'https://example.booqable.com/api/boomerang/menus/38cc5976-c168-4733-9155-532550eb2192' \
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