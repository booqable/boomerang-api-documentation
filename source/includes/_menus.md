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
      "id": "98790bc7-c445-444a-a7f7-15bded7c7e22",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-08T08:35:53+00:00",
        "updated_at": "2023-02-08T08:35:53+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=98790bc7-c445-444a-a7f7-15bded7c7e22"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T08:33:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/a3fced53-89f2-4c59-92f1-aea3c5e91a4e?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a3fced53-89f2-4c59-92f1-aea3c5e91a4e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T08:35:54+00:00",
      "updated_at": "2023-02-08T08:35:54+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a3fced53-89f2-4c59-92f1-aea3c5e91a4e"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "d0b49bac-3e43-4b80-82b4-c34d15efbb5c"
          },
          {
            "type": "menu_items",
            "id": "c3151043-27b8-4a37-ba9a-495a62bc01c7"
          },
          {
            "type": "menu_items",
            "id": "401c4587-eca7-4c30-b2b7-9d02ba39aafb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d0b49bac-3e43-4b80-82b4-c34d15efbb5c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T08:35:54+00:00",
        "updated_at": "2023-02-08T08:35:54+00:00",
        "menu_id": "a3fced53-89f2-4c59-92f1-aea3c5e91a4e",
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
            "related": "api/boomerang/menus/a3fced53-89f2-4c59-92f1-aea3c5e91a4e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d0b49bac-3e43-4b80-82b4-c34d15efbb5c"
          }
        }
      }
    },
    {
      "id": "c3151043-27b8-4a37-ba9a-495a62bc01c7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T08:35:54+00:00",
        "updated_at": "2023-02-08T08:35:54+00:00",
        "menu_id": "a3fced53-89f2-4c59-92f1-aea3c5e91a4e",
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
            "related": "api/boomerang/menus/a3fced53-89f2-4c59-92f1-aea3c5e91a4e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c3151043-27b8-4a37-ba9a-495a62bc01c7"
          }
        }
      }
    },
    {
      "id": "401c4587-eca7-4c30-b2b7-9d02ba39aafb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T08:35:54+00:00",
        "updated_at": "2023-02-08T08:35:54+00:00",
        "menu_id": "a3fced53-89f2-4c59-92f1-aea3c5e91a4e",
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
            "related": "api/boomerang/menus/a3fced53-89f2-4c59-92f1-aea3c5e91a4e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=401c4587-eca7-4c30-b2b7-9d02ba39aafb"
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
    "id": "cd724a07-fe25-4f4c-8f10-458514c61879",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T08:35:54+00:00",
      "updated_at": "2023-02-08T08:35:54+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/11205897-c153-450b-8547-9a73ecff2f47' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "11205897-c153-450b-8547-9a73ecff2f47",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "32ea90a7-9572-434d-8645-1e6a86628bab",
              "title": "Contact us"
            },
            {
              "id": "a1bb103c-2de4-4a10-a644-dc353dbf2bcc",
              "title": "Start"
            },
            {
              "id": "b2947ce3-eb7a-487d-ad1d-a437a31ce290",
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
    "id": "11205897-c153-450b-8547-9a73ecff2f47",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T08:35:54+00:00",
      "updated_at": "2023-02-08T08:35:54+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "32ea90a7-9572-434d-8645-1e6a86628bab"
          },
          {
            "type": "menu_items",
            "id": "a1bb103c-2de4-4a10-a644-dc353dbf2bcc"
          },
          {
            "type": "menu_items",
            "id": "b2947ce3-eb7a-487d-ad1d-a437a31ce290"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "32ea90a7-9572-434d-8645-1e6a86628bab",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T08:35:54+00:00",
        "updated_at": "2023-02-08T08:35:54+00:00",
        "menu_id": "11205897-c153-450b-8547-9a73ecff2f47",
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
      "id": "a1bb103c-2de4-4a10-a644-dc353dbf2bcc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T08:35:54+00:00",
        "updated_at": "2023-02-08T08:35:54+00:00",
        "menu_id": "11205897-c153-450b-8547-9a73ecff2f47",
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
      "id": "b2947ce3-eb7a-487d-ad1d-a437a31ce290",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T08:35:54+00:00",
        "updated_at": "2023-02-08T08:35:54+00:00",
        "menu_id": "11205897-c153-450b-8547-9a73ecff2f47",
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
    --url 'https://example.booqable.com/api/boomerang/menus/02302125-a9fe-46e1-89af-7d0eaaf901dc' \
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