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
      "id": "8962ba0f-f60d-4c18-bdc4-7fd6d621581e",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-24T14:57:58+00:00",
        "updated_at": "2023-02-24T14:57:58+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=8962ba0f-f60d-4c18-bdc4-7fd6d621581e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T14:55:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/15db9d4f-afc8-47ce-96b5-b7cc39fb57bd?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "15db9d4f-afc8-47ce-96b5-b7cc39fb57bd",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T14:57:59+00:00",
      "updated_at": "2023-02-24T14:57:59+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=15db9d4f-afc8-47ce-96b5-b7cc39fb57bd"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "03515ea1-da37-4498-acad-0b2ac1e7948a"
          },
          {
            "type": "menu_items",
            "id": "271359fe-f791-4d00-9517-1247e536ad72"
          },
          {
            "type": "menu_items",
            "id": "6744c781-7294-4b5a-a1c1-30bf304fddaf"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "03515ea1-da37-4498-acad-0b2ac1e7948a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T14:57:59+00:00",
        "updated_at": "2023-02-24T14:57:59+00:00",
        "menu_id": "15db9d4f-afc8-47ce-96b5-b7cc39fb57bd",
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
            "related": "api/boomerang/menus/15db9d4f-afc8-47ce-96b5-b7cc39fb57bd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=03515ea1-da37-4498-acad-0b2ac1e7948a"
          }
        }
      }
    },
    {
      "id": "271359fe-f791-4d00-9517-1247e536ad72",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T14:57:59+00:00",
        "updated_at": "2023-02-24T14:57:59+00:00",
        "menu_id": "15db9d4f-afc8-47ce-96b5-b7cc39fb57bd",
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
            "related": "api/boomerang/menus/15db9d4f-afc8-47ce-96b5-b7cc39fb57bd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=271359fe-f791-4d00-9517-1247e536ad72"
          }
        }
      }
    },
    {
      "id": "6744c781-7294-4b5a-a1c1-30bf304fddaf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T14:57:59+00:00",
        "updated_at": "2023-02-24T14:57:59+00:00",
        "menu_id": "15db9d4f-afc8-47ce-96b5-b7cc39fb57bd",
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
            "related": "api/boomerang/menus/15db9d4f-afc8-47ce-96b5-b7cc39fb57bd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6744c781-7294-4b5a-a1c1-30bf304fddaf"
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
    "id": "e8b5d290-ca9c-47a4-a4b0-e9bdfe55e4d7",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T14:57:59+00:00",
      "updated_at": "2023-02-24T14:57:59+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d3b04c65-9496-455f-a008-42f93f0b472a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d3b04c65-9496-455f-a008-42f93f0b472a",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "bdf63ea6-c2f8-494a-9c72-98e5eae90464",
              "title": "Contact us"
            },
            {
              "id": "b0e33220-b1a8-46d6-ae71-742aa00abac7",
              "title": "Start"
            },
            {
              "id": "d7a04bbf-cd4c-4574-8721-339b91003854",
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
    "id": "d3b04c65-9496-455f-a008-42f93f0b472a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T14:57:59+00:00",
      "updated_at": "2023-02-24T14:57:59+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "bdf63ea6-c2f8-494a-9c72-98e5eae90464"
          },
          {
            "type": "menu_items",
            "id": "b0e33220-b1a8-46d6-ae71-742aa00abac7"
          },
          {
            "type": "menu_items",
            "id": "d7a04bbf-cd4c-4574-8721-339b91003854"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bdf63ea6-c2f8-494a-9c72-98e5eae90464",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T14:57:59+00:00",
        "updated_at": "2023-02-24T14:57:59+00:00",
        "menu_id": "d3b04c65-9496-455f-a008-42f93f0b472a",
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
      "id": "b0e33220-b1a8-46d6-ae71-742aa00abac7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T14:57:59+00:00",
        "updated_at": "2023-02-24T14:57:59+00:00",
        "menu_id": "d3b04c65-9496-455f-a008-42f93f0b472a",
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
      "id": "d7a04bbf-cd4c-4574-8721-339b91003854",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T14:57:59+00:00",
        "updated_at": "2023-02-24T14:57:59+00:00",
        "menu_id": "d3b04c65-9496-455f-a008-42f93f0b472a",
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
    --url 'https://example.booqable.com/api/boomerang/menus/80464965-1a85-48a6-81de-5a18cfe19d13' \
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