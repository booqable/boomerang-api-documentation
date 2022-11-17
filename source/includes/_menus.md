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
      "id": "4f85e227-c2cc-4943-9092-d5a772ac55c0",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-17T11:34:10+00:00",
        "updated_at": "2022-11-17T11:34:10+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=4f85e227-c2cc-4943-9092-d5a772ac55c0"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-17T11:32:25Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/efb5f30d-ae0a-4a0e-ae67-24bea9d64968?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "efb5f30d-ae0a-4a0e-ae67-24bea9d64968",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-17T11:34:10+00:00",
      "updated_at": "2022-11-17T11:34:10+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=efb5f30d-ae0a-4a0e-ae67-24bea9d64968"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "b30573f1-7af9-45f6-a9ba-375a46cdcaa7"
          },
          {
            "type": "menu_items",
            "id": "ca956f72-0b88-4a91-b603-fc8552802f23"
          },
          {
            "type": "menu_items",
            "id": "8d38382d-5a2a-4d36-913a-deee371b1144"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b30573f1-7af9-45f6-a9ba-375a46cdcaa7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-17T11:34:10+00:00",
        "updated_at": "2022-11-17T11:34:10+00:00",
        "menu_id": "efb5f30d-ae0a-4a0e-ae67-24bea9d64968",
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
            "related": "api/boomerang/menus/efb5f30d-ae0a-4a0e-ae67-24bea9d64968"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b30573f1-7af9-45f6-a9ba-375a46cdcaa7"
          }
        }
      }
    },
    {
      "id": "ca956f72-0b88-4a91-b603-fc8552802f23",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-17T11:34:10+00:00",
        "updated_at": "2022-11-17T11:34:10+00:00",
        "menu_id": "efb5f30d-ae0a-4a0e-ae67-24bea9d64968",
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
            "related": "api/boomerang/menus/efb5f30d-ae0a-4a0e-ae67-24bea9d64968"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ca956f72-0b88-4a91-b603-fc8552802f23"
          }
        }
      }
    },
    {
      "id": "8d38382d-5a2a-4d36-913a-deee371b1144",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-17T11:34:10+00:00",
        "updated_at": "2022-11-17T11:34:10+00:00",
        "menu_id": "efb5f30d-ae0a-4a0e-ae67-24bea9d64968",
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
            "related": "api/boomerang/menus/efb5f30d-ae0a-4a0e-ae67-24bea9d64968"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8d38382d-5a2a-4d36-913a-deee371b1144"
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
    "id": "570b4816-d792-4d42-93df-07dab7f3851d",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-17T11:34:11+00:00",
      "updated_at": "2022-11-17T11:34:11+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/3635a673-280e-4e6d-b8f7-586fbdeb7d2d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3635a673-280e-4e6d-b8f7-586fbdeb7d2d",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "ad26ef1a-1515-4d2a-91d1-154189bc2e62",
              "title": "Contact us"
            },
            {
              "id": "86539e9b-b379-46e9-ac91-03b9ba4a503a",
              "title": "Start"
            },
            {
              "id": "5d12ecd3-36b0-4cf0-8b2e-f8c87b0b2dcd",
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
    "id": "3635a673-280e-4e6d-b8f7-586fbdeb7d2d",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-17T11:34:11+00:00",
      "updated_at": "2022-11-17T11:34:11+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "ad26ef1a-1515-4d2a-91d1-154189bc2e62"
          },
          {
            "type": "menu_items",
            "id": "86539e9b-b379-46e9-ac91-03b9ba4a503a"
          },
          {
            "type": "menu_items",
            "id": "5d12ecd3-36b0-4cf0-8b2e-f8c87b0b2dcd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ad26ef1a-1515-4d2a-91d1-154189bc2e62",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-17T11:34:11+00:00",
        "updated_at": "2022-11-17T11:34:11+00:00",
        "menu_id": "3635a673-280e-4e6d-b8f7-586fbdeb7d2d",
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
      "id": "86539e9b-b379-46e9-ac91-03b9ba4a503a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-17T11:34:11+00:00",
        "updated_at": "2022-11-17T11:34:11+00:00",
        "menu_id": "3635a673-280e-4e6d-b8f7-586fbdeb7d2d",
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
      "id": "5d12ecd3-36b0-4cf0-8b2e-f8c87b0b2dcd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-17T11:34:11+00:00",
        "updated_at": "2022-11-17T11:34:11+00:00",
        "menu_id": "3635a673-280e-4e6d-b8f7-586fbdeb7d2d",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f718cc13-f262-4822-b658-3d3d84f33171' \
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