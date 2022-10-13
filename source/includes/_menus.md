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
      "id": "639657c5-8232-474f-a801-f378440865a2",
      "type": "menus",
      "attributes": {
        "created_at": "2022-10-13T14:30:14+00:00",
        "updated_at": "2022-10-13T14:30:14+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=639657c5-8232-474f-a801-f378440865a2"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T14:28:03Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/38df79d0-1b3e-4676-af4f-c0f6dd7a8973?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "38df79d0-1b3e-4676-af4f-c0f6dd7a8973",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-13T14:30:15+00:00",
      "updated_at": "2022-10-13T14:30:15+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=38df79d0-1b3e-4676-af4f-c0f6dd7a8973"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "54fd3884-84d6-41ab-a672-31c7d5662037"
          },
          {
            "type": "menu_items",
            "id": "ed2d4d86-3d3f-4c4e-beda-5659819174b9"
          },
          {
            "type": "menu_items",
            "id": "53ee7cea-8a9d-4e9b-ba98-d6012435a396"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "54fd3884-84d6-41ab-a672-31c7d5662037",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T14:30:15+00:00",
        "updated_at": "2022-10-13T14:30:15+00:00",
        "menu_id": "38df79d0-1b3e-4676-af4f-c0f6dd7a8973",
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
            "related": "api/boomerang/menus/38df79d0-1b3e-4676-af4f-c0f6dd7a8973"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=54fd3884-84d6-41ab-a672-31c7d5662037"
          }
        }
      }
    },
    {
      "id": "ed2d4d86-3d3f-4c4e-beda-5659819174b9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T14:30:15+00:00",
        "updated_at": "2022-10-13T14:30:15+00:00",
        "menu_id": "38df79d0-1b3e-4676-af4f-c0f6dd7a8973",
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
            "related": "api/boomerang/menus/38df79d0-1b3e-4676-af4f-c0f6dd7a8973"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ed2d4d86-3d3f-4c4e-beda-5659819174b9"
          }
        }
      }
    },
    {
      "id": "53ee7cea-8a9d-4e9b-ba98-d6012435a396",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T14:30:15+00:00",
        "updated_at": "2022-10-13T14:30:15+00:00",
        "menu_id": "38df79d0-1b3e-4676-af4f-c0f6dd7a8973",
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
            "related": "api/boomerang/menus/38df79d0-1b3e-4676-af4f-c0f6dd7a8973"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=53ee7cea-8a9d-4e9b-ba98-d6012435a396"
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
    "id": "7b17fe3b-c339-48f8-91ee-2741708b7453",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-13T14:30:15+00:00",
      "updated_at": "2022-10-13T14:30:15+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ad39da76-d211-48a4-ab0c-6a8d5fb7ec5a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ad39da76-d211-48a4-ab0c-6a8d5fb7ec5a",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "5ffa34f8-c312-4c6a-998e-2ffb66ba7095",
              "title": "Contact us"
            },
            {
              "id": "c0765692-23ca-40d6-a959-e2f1269c1ba7",
              "title": "Start"
            },
            {
              "id": "fa5654fc-0908-49c4-87db-9fe85e6f4cdb",
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
    "id": "ad39da76-d211-48a4-ab0c-6a8d5fb7ec5a",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-13T14:30:16+00:00",
      "updated_at": "2022-10-13T14:30:16+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "5ffa34f8-c312-4c6a-998e-2ffb66ba7095"
          },
          {
            "type": "menu_items",
            "id": "c0765692-23ca-40d6-a959-e2f1269c1ba7"
          },
          {
            "type": "menu_items",
            "id": "fa5654fc-0908-49c4-87db-9fe85e6f4cdb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5ffa34f8-c312-4c6a-998e-2ffb66ba7095",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T14:30:16+00:00",
        "updated_at": "2022-10-13T14:30:16+00:00",
        "menu_id": "ad39da76-d211-48a4-ab0c-6a8d5fb7ec5a",
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
      "id": "c0765692-23ca-40d6-a959-e2f1269c1ba7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T14:30:16+00:00",
        "updated_at": "2022-10-13T14:30:16+00:00",
        "menu_id": "ad39da76-d211-48a4-ab0c-6a8d5fb7ec5a",
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
      "id": "fa5654fc-0908-49c4-87db-9fe85e6f4cdb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T14:30:16+00:00",
        "updated_at": "2022-10-13T14:30:16+00:00",
        "menu_id": "ad39da76-d211-48a4-ab0c-6a8d5fb7ec5a",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d155610a-a67b-4a0b-a2c9-9eead0468912' \
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