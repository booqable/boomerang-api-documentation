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
      "id": "923c17c7-e9ec-43e5-a1f2-3b77ef50f404",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-09T13:01:12+00:00",
        "updated_at": "2023-02-09T13:01:12+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=923c17c7-e9ec-43e5-a1f2-3b77ef50f404"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T12:59:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/19764bd0-8587-4199-b6d5-e1e853a0e983?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "19764bd0-8587-4199-b6d5-e1e853a0e983",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T13:01:12+00:00",
      "updated_at": "2023-02-09T13:01:12+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=19764bd0-8587-4199-b6d5-e1e853a0e983"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "52cdba8e-7527-4442-897a-669c3f7bec8c"
          },
          {
            "type": "menu_items",
            "id": "f929848c-c87a-4628-934b-77e94b2b11cf"
          },
          {
            "type": "menu_items",
            "id": "3ff9cdc8-1dae-44c9-b443-0f1973dd51da"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "52cdba8e-7527-4442-897a-669c3f7bec8c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:01:12+00:00",
        "updated_at": "2023-02-09T13:01:12+00:00",
        "menu_id": "19764bd0-8587-4199-b6d5-e1e853a0e983",
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
            "related": "api/boomerang/menus/19764bd0-8587-4199-b6d5-e1e853a0e983"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=52cdba8e-7527-4442-897a-669c3f7bec8c"
          }
        }
      }
    },
    {
      "id": "f929848c-c87a-4628-934b-77e94b2b11cf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:01:12+00:00",
        "updated_at": "2023-02-09T13:01:12+00:00",
        "menu_id": "19764bd0-8587-4199-b6d5-e1e853a0e983",
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
            "related": "api/boomerang/menus/19764bd0-8587-4199-b6d5-e1e853a0e983"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f929848c-c87a-4628-934b-77e94b2b11cf"
          }
        }
      }
    },
    {
      "id": "3ff9cdc8-1dae-44c9-b443-0f1973dd51da",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:01:12+00:00",
        "updated_at": "2023-02-09T13:01:12+00:00",
        "menu_id": "19764bd0-8587-4199-b6d5-e1e853a0e983",
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
            "related": "api/boomerang/menus/19764bd0-8587-4199-b6d5-e1e853a0e983"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3ff9cdc8-1dae-44c9-b443-0f1973dd51da"
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
    "id": "f14c3b91-41ff-4760-8db4-c1b54bf8e60a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T13:01:12+00:00",
      "updated_at": "2023-02-09T13:01:12+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f75436bb-968b-4f53-a441-685257361549' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f75436bb-968b-4f53-a441-685257361549",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "0fcf90c6-eca1-4810-bc15-6283364baadc",
              "title": "Contact us"
            },
            {
              "id": "bca39b38-e092-426a-8832-1db4c633dc54",
              "title": "Start"
            },
            {
              "id": "3df27585-041c-474a-a710-754b908955bb",
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
    "id": "f75436bb-968b-4f53-a441-685257361549",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T13:01:13+00:00",
      "updated_at": "2023-02-09T13:01:13+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "0fcf90c6-eca1-4810-bc15-6283364baadc"
          },
          {
            "type": "menu_items",
            "id": "bca39b38-e092-426a-8832-1db4c633dc54"
          },
          {
            "type": "menu_items",
            "id": "3df27585-041c-474a-a710-754b908955bb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0fcf90c6-eca1-4810-bc15-6283364baadc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:01:13+00:00",
        "updated_at": "2023-02-09T13:01:13+00:00",
        "menu_id": "f75436bb-968b-4f53-a441-685257361549",
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
      "id": "bca39b38-e092-426a-8832-1db4c633dc54",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:01:13+00:00",
        "updated_at": "2023-02-09T13:01:13+00:00",
        "menu_id": "f75436bb-968b-4f53-a441-685257361549",
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
      "id": "3df27585-041c-474a-a710-754b908955bb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:01:13+00:00",
        "updated_at": "2023-02-09T13:01:13+00:00",
        "menu_id": "f75436bb-968b-4f53-a441-685257361549",
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
    --url 'https://example.booqable.com/api/boomerang/menus/8a5139ef-6dbb-4c0d-af81-f0b23678eb03' \
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