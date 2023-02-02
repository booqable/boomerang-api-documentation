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
      "id": "4c09ec6a-32d1-4b2c-9506-b4bf070118c4",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-02T11:16:56+00:00",
        "updated_at": "2023-02-02T11:16:56+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=4c09ec6a-32d1-4b2c-9506-b4bf070118c4"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T11:14:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/01c642d5-93ba-488e-97e8-16d057e0dd23?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "01c642d5-93ba-488e-97e8-16d057e0dd23",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T11:16:56+00:00",
      "updated_at": "2023-02-02T11:16:56+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=01c642d5-93ba-488e-97e8-16d057e0dd23"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "9aac72c3-fb0b-470a-9d02-6b98e3b4fb29"
          },
          {
            "type": "menu_items",
            "id": "177e970d-9006-40df-89a7-45b8fe532c58"
          },
          {
            "type": "menu_items",
            "id": "a34df876-c94f-4eef-bb87-41275ea8f7f0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9aac72c3-fb0b-470a-9d02-6b98e3b4fb29",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T11:16:56+00:00",
        "updated_at": "2023-02-02T11:16:56+00:00",
        "menu_id": "01c642d5-93ba-488e-97e8-16d057e0dd23",
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
            "related": "api/boomerang/menus/01c642d5-93ba-488e-97e8-16d057e0dd23"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9aac72c3-fb0b-470a-9d02-6b98e3b4fb29"
          }
        }
      }
    },
    {
      "id": "177e970d-9006-40df-89a7-45b8fe532c58",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T11:16:56+00:00",
        "updated_at": "2023-02-02T11:16:56+00:00",
        "menu_id": "01c642d5-93ba-488e-97e8-16d057e0dd23",
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
            "related": "api/boomerang/menus/01c642d5-93ba-488e-97e8-16d057e0dd23"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=177e970d-9006-40df-89a7-45b8fe532c58"
          }
        }
      }
    },
    {
      "id": "a34df876-c94f-4eef-bb87-41275ea8f7f0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T11:16:56+00:00",
        "updated_at": "2023-02-02T11:16:56+00:00",
        "menu_id": "01c642d5-93ba-488e-97e8-16d057e0dd23",
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
            "related": "api/boomerang/menus/01c642d5-93ba-488e-97e8-16d057e0dd23"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a34df876-c94f-4eef-bb87-41275ea8f7f0"
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
    "id": "7ee7630b-dc56-4646-b982-f3d260343bb9",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T11:16:56+00:00",
      "updated_at": "2023-02-02T11:16:56+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/eeb77a1b-24d4-4cab-8fca-a02b19924746' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "eeb77a1b-24d4-4cab-8fca-a02b19924746",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "a1a55471-5732-4b6f-bb19-23b4064a852b",
              "title": "Contact us"
            },
            {
              "id": "a87d3295-2e19-4c91-a479-a0d03493f3c4",
              "title": "Start"
            },
            {
              "id": "6e15b11d-fd49-4905-86ae-2203f86c89db",
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
    "id": "eeb77a1b-24d4-4cab-8fca-a02b19924746",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T11:16:57+00:00",
      "updated_at": "2023-02-02T11:16:57+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "a1a55471-5732-4b6f-bb19-23b4064a852b"
          },
          {
            "type": "menu_items",
            "id": "a87d3295-2e19-4c91-a479-a0d03493f3c4"
          },
          {
            "type": "menu_items",
            "id": "6e15b11d-fd49-4905-86ae-2203f86c89db"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a1a55471-5732-4b6f-bb19-23b4064a852b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T11:16:57+00:00",
        "updated_at": "2023-02-02T11:16:57+00:00",
        "menu_id": "eeb77a1b-24d4-4cab-8fca-a02b19924746",
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
      "id": "a87d3295-2e19-4c91-a479-a0d03493f3c4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T11:16:57+00:00",
        "updated_at": "2023-02-02T11:16:57+00:00",
        "menu_id": "eeb77a1b-24d4-4cab-8fca-a02b19924746",
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
      "id": "6e15b11d-fd49-4905-86ae-2203f86c89db",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T11:16:57+00:00",
        "updated_at": "2023-02-02T11:16:57+00:00",
        "menu_id": "eeb77a1b-24d4-4cab-8fca-a02b19924746",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f8a4f8ed-1df6-4d09-867b-db34767bdb97' \
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