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
      "id": "fcd3ed77-a95b-49cd-b0b4-1d7f5df24576",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-16T11:21:20+00:00",
        "updated_at": "2023-02-16T11:21:20+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=fcd3ed77-a95b-49cd-b0b4-1d7f5df24576"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T11:19:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/64f97a18-27b1-43d3-944e-2fc334065f61?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "64f97a18-27b1-43d3-944e-2fc334065f61",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T11:21:20+00:00",
      "updated_at": "2023-02-16T11:21:20+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=64f97a18-27b1-43d3-944e-2fc334065f61"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "01af2c9d-6573-4405-801a-6b2a11d20ddb"
          },
          {
            "type": "menu_items",
            "id": "3ff5d8ac-31d1-488c-9dab-0b44bb8ad502"
          },
          {
            "type": "menu_items",
            "id": "aa48a6ad-b0d6-4e57-9d09-093cf05b2473"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "01af2c9d-6573-4405-801a-6b2a11d20ddb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T11:21:20+00:00",
        "updated_at": "2023-02-16T11:21:20+00:00",
        "menu_id": "64f97a18-27b1-43d3-944e-2fc334065f61",
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
            "related": "api/boomerang/menus/64f97a18-27b1-43d3-944e-2fc334065f61"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=01af2c9d-6573-4405-801a-6b2a11d20ddb"
          }
        }
      }
    },
    {
      "id": "3ff5d8ac-31d1-488c-9dab-0b44bb8ad502",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T11:21:20+00:00",
        "updated_at": "2023-02-16T11:21:20+00:00",
        "menu_id": "64f97a18-27b1-43d3-944e-2fc334065f61",
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
            "related": "api/boomerang/menus/64f97a18-27b1-43d3-944e-2fc334065f61"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3ff5d8ac-31d1-488c-9dab-0b44bb8ad502"
          }
        }
      }
    },
    {
      "id": "aa48a6ad-b0d6-4e57-9d09-093cf05b2473",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T11:21:20+00:00",
        "updated_at": "2023-02-16T11:21:20+00:00",
        "menu_id": "64f97a18-27b1-43d3-944e-2fc334065f61",
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
            "related": "api/boomerang/menus/64f97a18-27b1-43d3-944e-2fc334065f61"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=aa48a6ad-b0d6-4e57-9d09-093cf05b2473"
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
    "id": "b8236020-e73c-429b-b928-0dacbe03d26c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T11:21:21+00:00",
      "updated_at": "2023-02-16T11:21:21+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/e5cd39e7-4a58-449d-ac70-11851bec108a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e5cd39e7-4a58-449d-ac70-11851bec108a",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "c18808e1-c235-4861-8a79-a028f3e199ca",
              "title": "Contact us"
            },
            {
              "id": "17982cad-24bc-42ca-b14d-140c603b69fa",
              "title": "Start"
            },
            {
              "id": "a888edc7-783e-49ec-9fe2-a4e4fe3e3045",
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
    "id": "e5cd39e7-4a58-449d-ac70-11851bec108a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T11:21:21+00:00",
      "updated_at": "2023-02-16T11:21:21+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "c18808e1-c235-4861-8a79-a028f3e199ca"
          },
          {
            "type": "menu_items",
            "id": "17982cad-24bc-42ca-b14d-140c603b69fa"
          },
          {
            "type": "menu_items",
            "id": "a888edc7-783e-49ec-9fe2-a4e4fe3e3045"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c18808e1-c235-4861-8a79-a028f3e199ca",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T11:21:21+00:00",
        "updated_at": "2023-02-16T11:21:21+00:00",
        "menu_id": "e5cd39e7-4a58-449d-ac70-11851bec108a",
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
      "id": "17982cad-24bc-42ca-b14d-140c603b69fa",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T11:21:21+00:00",
        "updated_at": "2023-02-16T11:21:21+00:00",
        "menu_id": "e5cd39e7-4a58-449d-ac70-11851bec108a",
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
      "id": "a888edc7-783e-49ec-9fe2-a4e4fe3e3045",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T11:21:21+00:00",
        "updated_at": "2023-02-16T11:21:21+00:00",
        "menu_id": "e5cd39e7-4a58-449d-ac70-11851bec108a",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b32280a8-9f28-4068-8253-ef7b6cccc76b' \
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