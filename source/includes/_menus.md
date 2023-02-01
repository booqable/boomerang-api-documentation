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
      "id": "8132e90e-dbf1-4afe-8ce5-f5988be6fda7",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-01T15:18:52+00:00",
        "updated_at": "2023-02-01T15:18:52+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=8132e90e-dbf1-4afe-8ce5-f5988be6fda7"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T15:17:11Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/163f6713-241d-4416-8e0c-9b214de74eb5?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "163f6713-241d-4416-8e0c-9b214de74eb5",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-01T15:18:53+00:00",
      "updated_at": "2023-02-01T15:18:53+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=163f6713-241d-4416-8e0c-9b214de74eb5"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "276cfb70-8b0e-48eb-bca1-b236d2eb0534"
          },
          {
            "type": "menu_items",
            "id": "399f77a3-d2d9-4874-8ae9-9f5f406b66ad"
          },
          {
            "type": "menu_items",
            "id": "1e208b4e-f770-428b-978a-4bc8a573a996"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "276cfb70-8b0e-48eb-bca1-b236d2eb0534",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T15:18:53+00:00",
        "updated_at": "2023-02-01T15:18:53+00:00",
        "menu_id": "163f6713-241d-4416-8e0c-9b214de74eb5",
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
            "related": "api/boomerang/menus/163f6713-241d-4416-8e0c-9b214de74eb5"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=276cfb70-8b0e-48eb-bca1-b236d2eb0534"
          }
        }
      }
    },
    {
      "id": "399f77a3-d2d9-4874-8ae9-9f5f406b66ad",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T15:18:53+00:00",
        "updated_at": "2023-02-01T15:18:53+00:00",
        "menu_id": "163f6713-241d-4416-8e0c-9b214de74eb5",
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
            "related": "api/boomerang/menus/163f6713-241d-4416-8e0c-9b214de74eb5"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=399f77a3-d2d9-4874-8ae9-9f5f406b66ad"
          }
        }
      }
    },
    {
      "id": "1e208b4e-f770-428b-978a-4bc8a573a996",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T15:18:53+00:00",
        "updated_at": "2023-02-01T15:18:53+00:00",
        "menu_id": "163f6713-241d-4416-8e0c-9b214de74eb5",
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
            "related": "api/boomerang/menus/163f6713-241d-4416-8e0c-9b214de74eb5"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1e208b4e-f770-428b-978a-4bc8a573a996"
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
    "id": "85b85ac5-0554-40ff-abdc-57b90a58cc38",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-01T15:18:54+00:00",
      "updated_at": "2023-02-01T15:18:54+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9047161d-13b5-4a77-af36-2d03c2b599a8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9047161d-13b5-4a77-af36-2d03c2b599a8",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "dfd1f2cb-04b1-4f2b-8115-5802c66e58aa",
              "title": "Contact us"
            },
            {
              "id": "82d5eae1-b6af-4ec0-880d-b289de39fe32",
              "title": "Start"
            },
            {
              "id": "60b9e9ef-6d1b-4543-995a-cd39a8862179",
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
    "id": "9047161d-13b5-4a77-af36-2d03c2b599a8",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-01T15:18:54+00:00",
      "updated_at": "2023-02-01T15:18:54+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "dfd1f2cb-04b1-4f2b-8115-5802c66e58aa"
          },
          {
            "type": "menu_items",
            "id": "82d5eae1-b6af-4ec0-880d-b289de39fe32"
          },
          {
            "type": "menu_items",
            "id": "60b9e9ef-6d1b-4543-995a-cd39a8862179"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dfd1f2cb-04b1-4f2b-8115-5802c66e58aa",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T15:18:54+00:00",
        "updated_at": "2023-02-01T15:18:54+00:00",
        "menu_id": "9047161d-13b5-4a77-af36-2d03c2b599a8",
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
      "id": "82d5eae1-b6af-4ec0-880d-b289de39fe32",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T15:18:54+00:00",
        "updated_at": "2023-02-01T15:18:54+00:00",
        "menu_id": "9047161d-13b5-4a77-af36-2d03c2b599a8",
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
      "id": "60b9e9ef-6d1b-4543-995a-cd39a8862179",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T15:18:54+00:00",
        "updated_at": "2023-02-01T15:18:54+00:00",
        "menu_id": "9047161d-13b5-4a77-af36-2d03c2b599a8",
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
    --url 'https://example.booqable.com/api/boomerang/menus/2574332a-d7d2-4cf0-9547-b53f7b0f7402' \
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