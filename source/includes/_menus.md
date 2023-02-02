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
      "id": "fd8afd8a-03de-4392-ba7c-83bfd1628026",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-02T16:38:21+00:00",
        "updated_at": "2023-02-02T16:38:21+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=fd8afd8a-03de-4392-ba7c-83bfd1628026"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:36:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/5e2eb130-c19d-4d3d-8fcc-7cfb95d93454?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5e2eb130-c19d-4d3d-8fcc-7cfb95d93454",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T16:38:22+00:00",
      "updated_at": "2023-02-02T16:38:22+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=5e2eb130-c19d-4d3d-8fcc-7cfb95d93454"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "382306f4-6d1c-4c27-aa04-1beb9a562dd2"
          },
          {
            "type": "menu_items",
            "id": "e9ce0d46-5c11-47a8-aa3b-24f9eef97072"
          },
          {
            "type": "menu_items",
            "id": "e2413b6e-838f-43e4-931b-868c6d75a8c4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "382306f4-6d1c-4c27-aa04-1beb9a562dd2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:38:22+00:00",
        "updated_at": "2023-02-02T16:38:22+00:00",
        "menu_id": "5e2eb130-c19d-4d3d-8fcc-7cfb95d93454",
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
            "related": "api/boomerang/menus/5e2eb130-c19d-4d3d-8fcc-7cfb95d93454"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=382306f4-6d1c-4c27-aa04-1beb9a562dd2"
          }
        }
      }
    },
    {
      "id": "e9ce0d46-5c11-47a8-aa3b-24f9eef97072",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:38:22+00:00",
        "updated_at": "2023-02-02T16:38:22+00:00",
        "menu_id": "5e2eb130-c19d-4d3d-8fcc-7cfb95d93454",
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
            "related": "api/boomerang/menus/5e2eb130-c19d-4d3d-8fcc-7cfb95d93454"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e9ce0d46-5c11-47a8-aa3b-24f9eef97072"
          }
        }
      }
    },
    {
      "id": "e2413b6e-838f-43e4-931b-868c6d75a8c4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:38:22+00:00",
        "updated_at": "2023-02-02T16:38:22+00:00",
        "menu_id": "5e2eb130-c19d-4d3d-8fcc-7cfb95d93454",
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
            "related": "api/boomerang/menus/5e2eb130-c19d-4d3d-8fcc-7cfb95d93454"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e2413b6e-838f-43e4-931b-868c6d75a8c4"
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
    "id": "57f4d71f-4a6e-407e-b932-7bfa90b78e5e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T16:38:22+00:00",
      "updated_at": "2023-02-02T16:38:22+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/dc2275d0-76ae-4366-9cef-5ffb6f74521f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dc2275d0-76ae-4366-9cef-5ffb6f74521f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "eec5cad5-54fc-4080-8d90-45fafea9543d",
              "title": "Contact us"
            },
            {
              "id": "a9b589b5-a158-47f5-bba0-6ad88e50468d",
              "title": "Start"
            },
            {
              "id": "529de18a-eda7-44f7-93b0-c8ec1504447d",
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
    "id": "dc2275d0-76ae-4366-9cef-5ffb6f74521f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T16:38:22+00:00",
      "updated_at": "2023-02-02T16:38:23+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "eec5cad5-54fc-4080-8d90-45fafea9543d"
          },
          {
            "type": "menu_items",
            "id": "a9b589b5-a158-47f5-bba0-6ad88e50468d"
          },
          {
            "type": "menu_items",
            "id": "529de18a-eda7-44f7-93b0-c8ec1504447d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "eec5cad5-54fc-4080-8d90-45fafea9543d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:38:22+00:00",
        "updated_at": "2023-02-02T16:38:23+00:00",
        "menu_id": "dc2275d0-76ae-4366-9cef-5ffb6f74521f",
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
      "id": "a9b589b5-a158-47f5-bba0-6ad88e50468d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:38:22+00:00",
        "updated_at": "2023-02-02T16:38:23+00:00",
        "menu_id": "dc2275d0-76ae-4366-9cef-5ffb6f74521f",
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
      "id": "529de18a-eda7-44f7-93b0-c8ec1504447d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:38:22+00:00",
        "updated_at": "2023-02-02T16:38:23+00:00",
        "menu_id": "dc2275d0-76ae-4366-9cef-5ffb6f74521f",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9539d771-292d-49f7-9a89-7d9b18a98b04' \
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