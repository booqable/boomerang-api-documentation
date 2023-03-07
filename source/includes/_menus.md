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
      "id": "dddd9cfc-1f44-49d9-b043-c90e0b2ec28a",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-07T08:28:36+00:00",
        "updated_at": "2023-03-07T08:28:36+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=dddd9cfc-1f44-49d9-b043-c90e0b2ec28a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T08:26:43Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/00be6019-aeeb-4413-8799-8a1eaf58cd5d?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "00be6019-aeeb-4413-8799-8a1eaf58cd5d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T08:28:37+00:00",
      "updated_at": "2023-03-07T08:28:37+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=00be6019-aeeb-4413-8799-8a1eaf58cd5d"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "81fb0df4-fb62-41dd-8055-e8f194f2999e"
          },
          {
            "type": "menu_items",
            "id": "2cbedae0-fcbd-40e6-b302-d2f87deae98b"
          },
          {
            "type": "menu_items",
            "id": "35741bac-d717-461d-b90b-2567971bbbfc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "81fb0df4-fb62-41dd-8055-e8f194f2999e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T08:28:37+00:00",
        "updated_at": "2023-03-07T08:28:37+00:00",
        "menu_id": "00be6019-aeeb-4413-8799-8a1eaf58cd5d",
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
            "related": "api/boomerang/menus/00be6019-aeeb-4413-8799-8a1eaf58cd5d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=81fb0df4-fb62-41dd-8055-e8f194f2999e"
          }
        }
      }
    },
    {
      "id": "2cbedae0-fcbd-40e6-b302-d2f87deae98b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T08:28:37+00:00",
        "updated_at": "2023-03-07T08:28:37+00:00",
        "menu_id": "00be6019-aeeb-4413-8799-8a1eaf58cd5d",
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
            "related": "api/boomerang/menus/00be6019-aeeb-4413-8799-8a1eaf58cd5d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2cbedae0-fcbd-40e6-b302-d2f87deae98b"
          }
        }
      }
    },
    {
      "id": "35741bac-d717-461d-b90b-2567971bbbfc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T08:28:37+00:00",
        "updated_at": "2023-03-07T08:28:37+00:00",
        "menu_id": "00be6019-aeeb-4413-8799-8a1eaf58cd5d",
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
            "related": "api/boomerang/menus/00be6019-aeeb-4413-8799-8a1eaf58cd5d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=35741bac-d717-461d-b90b-2567971bbbfc"
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
    "id": "c7ca4d8d-fbab-4643-bc82-792443677e65",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T08:28:37+00:00",
      "updated_at": "2023-03-07T08:28:37+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f3742787-f27c-4fec-a621-09935eb050c6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f3742787-f27c-4fec-a621-09935eb050c6",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "38beaf57-05de-4375-a63c-e64963564e31",
              "title": "Contact us"
            },
            {
              "id": "aeaed2dc-ed9d-41f3-be48-f52b4dd79295",
              "title": "Start"
            },
            {
              "id": "467ea40c-79a3-44f0-8b8a-f83ead9262d6",
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
    "id": "f3742787-f27c-4fec-a621-09935eb050c6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T08:28:38+00:00",
      "updated_at": "2023-03-07T08:28:38+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "38beaf57-05de-4375-a63c-e64963564e31"
          },
          {
            "type": "menu_items",
            "id": "aeaed2dc-ed9d-41f3-be48-f52b4dd79295"
          },
          {
            "type": "menu_items",
            "id": "467ea40c-79a3-44f0-8b8a-f83ead9262d6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "38beaf57-05de-4375-a63c-e64963564e31",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T08:28:38+00:00",
        "updated_at": "2023-03-07T08:28:38+00:00",
        "menu_id": "f3742787-f27c-4fec-a621-09935eb050c6",
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
      "id": "aeaed2dc-ed9d-41f3-be48-f52b4dd79295",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T08:28:38+00:00",
        "updated_at": "2023-03-07T08:28:38+00:00",
        "menu_id": "f3742787-f27c-4fec-a621-09935eb050c6",
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
      "id": "467ea40c-79a3-44f0-8b8a-f83ead9262d6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T08:28:38+00:00",
        "updated_at": "2023-03-07T08:28:38+00:00",
        "menu_id": "f3742787-f27c-4fec-a621-09935eb050c6",
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
    --url 'https://example.booqable.com/api/boomerang/menus/99282cdc-0539-404f-858d-7a7e2fdffae8' \
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