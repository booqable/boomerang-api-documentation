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
      "id": "78959aa5-4711-4e46-bdcb-a18c9f88d1ed",
      "type": "menus",
      "attributes": {
        "created_at": "2022-10-07T11:57:19+00:00",
        "updated_at": "2022-10-07T11:57:19+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=78959aa5-4711-4e46-bdcb-a18c9f88d1ed"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T11:55:30Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/966d608a-81ba-4b9d-960e-d5794f66dde9?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "966d608a-81ba-4b9d-960e-d5794f66dde9",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-07T11:57:19+00:00",
      "updated_at": "2022-10-07T11:57:19+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=966d608a-81ba-4b9d-960e-d5794f66dde9"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "1a34a452-2376-4bfa-a99d-0f4e52e67c69"
          },
          {
            "type": "menu_items",
            "id": "565c1001-1d06-4869-af67-1fd52304e589"
          },
          {
            "type": "menu_items",
            "id": "6a91d32d-ff37-484f-b76d-ce555e122925"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1a34a452-2376-4bfa-a99d-0f4e52e67c69",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T11:57:19+00:00",
        "updated_at": "2022-10-07T11:57:19+00:00",
        "menu_id": "966d608a-81ba-4b9d-960e-d5794f66dde9",
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
            "related": "api/boomerang/menus/966d608a-81ba-4b9d-960e-d5794f66dde9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1a34a452-2376-4bfa-a99d-0f4e52e67c69"
          }
        }
      }
    },
    {
      "id": "565c1001-1d06-4869-af67-1fd52304e589",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T11:57:19+00:00",
        "updated_at": "2022-10-07T11:57:19+00:00",
        "menu_id": "966d608a-81ba-4b9d-960e-d5794f66dde9",
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
            "related": "api/boomerang/menus/966d608a-81ba-4b9d-960e-d5794f66dde9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=565c1001-1d06-4869-af67-1fd52304e589"
          }
        }
      }
    },
    {
      "id": "6a91d32d-ff37-484f-b76d-ce555e122925",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T11:57:19+00:00",
        "updated_at": "2022-10-07T11:57:19+00:00",
        "menu_id": "966d608a-81ba-4b9d-960e-d5794f66dde9",
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
            "related": "api/boomerang/menus/966d608a-81ba-4b9d-960e-d5794f66dde9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6a91d32d-ff37-484f-b76d-ce555e122925"
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
    "id": "ca4e0855-11cc-44ae-a046-486279eed5f9",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-07T11:57:20+00:00",
      "updated_at": "2022-10-07T11:57:20+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/83efeb3d-0746-4733-9c21-73bfa6dd7674' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "83efeb3d-0746-4733-9c21-73bfa6dd7674",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e1a40a35-674b-440d-b99d-509d2490b7d6",
              "title": "Contact us"
            },
            {
              "id": "17928326-ed00-4baf-bce3-842f5c8da11b",
              "title": "Start"
            },
            {
              "id": "b8d25549-1037-4bd2-a646-6c2d924b50bf",
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
    "id": "83efeb3d-0746-4733-9c21-73bfa6dd7674",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-07T11:57:20+00:00",
      "updated_at": "2022-10-07T11:57:20+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e1a40a35-674b-440d-b99d-509d2490b7d6"
          },
          {
            "type": "menu_items",
            "id": "17928326-ed00-4baf-bce3-842f5c8da11b"
          },
          {
            "type": "menu_items",
            "id": "b8d25549-1037-4bd2-a646-6c2d924b50bf"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e1a40a35-674b-440d-b99d-509d2490b7d6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T11:57:20+00:00",
        "updated_at": "2022-10-07T11:57:20+00:00",
        "menu_id": "83efeb3d-0746-4733-9c21-73bfa6dd7674",
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
      "id": "17928326-ed00-4baf-bce3-842f5c8da11b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T11:57:20+00:00",
        "updated_at": "2022-10-07T11:57:20+00:00",
        "menu_id": "83efeb3d-0746-4733-9c21-73bfa6dd7674",
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
      "id": "b8d25549-1037-4bd2-a646-6c2d924b50bf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T11:57:20+00:00",
        "updated_at": "2022-10-07T11:57:20+00:00",
        "menu_id": "83efeb3d-0746-4733-9c21-73bfa6dd7674",
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
    --url 'https://example.booqable.com/api/boomerang/menus/340e7130-1710-4599-83bc-940317aa8b52' \
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