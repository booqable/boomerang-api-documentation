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
      "id": "d690f501-fa86-4922-b3b0-982a3e7d3516",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-22T16:34:50+00:00",
        "updated_at": "2022-11-22T16:34:50+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=d690f501-fa86-4922-b3b0-982a3e7d3516"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:33:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/9097d947-deef-4ab2-97e1-b98ca5f02b3e?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9097d947-deef-4ab2-97e1-b98ca5f02b3e",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T16:34:50+00:00",
      "updated_at": "2022-11-22T16:34:50+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=9097d947-deef-4ab2-97e1-b98ca5f02b3e"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "8711d7b1-1213-4243-bb48-82677d1697f6"
          },
          {
            "type": "menu_items",
            "id": "f90da5fc-16c1-4f66-a130-9f9e20fe81fe"
          },
          {
            "type": "menu_items",
            "id": "a44c0850-9fdb-4003-b540-01d76b8edf19"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8711d7b1-1213-4243-bb48-82677d1697f6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:34:50+00:00",
        "updated_at": "2022-11-22T16:34:50+00:00",
        "menu_id": "9097d947-deef-4ab2-97e1-b98ca5f02b3e",
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
            "related": "api/boomerang/menus/9097d947-deef-4ab2-97e1-b98ca5f02b3e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8711d7b1-1213-4243-bb48-82677d1697f6"
          }
        }
      }
    },
    {
      "id": "f90da5fc-16c1-4f66-a130-9f9e20fe81fe",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:34:50+00:00",
        "updated_at": "2022-11-22T16:34:50+00:00",
        "menu_id": "9097d947-deef-4ab2-97e1-b98ca5f02b3e",
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
            "related": "api/boomerang/menus/9097d947-deef-4ab2-97e1-b98ca5f02b3e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f90da5fc-16c1-4f66-a130-9f9e20fe81fe"
          }
        }
      }
    },
    {
      "id": "a44c0850-9fdb-4003-b540-01d76b8edf19",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:34:50+00:00",
        "updated_at": "2022-11-22T16:34:50+00:00",
        "menu_id": "9097d947-deef-4ab2-97e1-b98ca5f02b3e",
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
            "related": "api/boomerang/menus/9097d947-deef-4ab2-97e1-b98ca5f02b3e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a44c0850-9fdb-4003-b540-01d76b8edf19"
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
    "id": "93d53cad-441a-4206-845a-c5a2818a80c1",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T16:34:51+00:00",
      "updated_at": "2022-11-22T16:34:51+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5df61ba7-cce2-4529-861d-3cd168718bd6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5df61ba7-cce2-4529-861d-3cd168718bd6",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "f833ed07-d311-4e2d-9c50-d725749ed607",
              "title": "Contact us"
            },
            {
              "id": "aa26b7b5-5323-4297-8800-cea738bfdb64",
              "title": "Start"
            },
            {
              "id": "382225ae-c18f-4307-a6f6-3a0c6dca0f40",
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
    "id": "5df61ba7-cce2-4529-861d-3cd168718bd6",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T16:34:51+00:00",
      "updated_at": "2022-11-22T16:34:51+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "f833ed07-d311-4e2d-9c50-d725749ed607"
          },
          {
            "type": "menu_items",
            "id": "aa26b7b5-5323-4297-8800-cea738bfdb64"
          },
          {
            "type": "menu_items",
            "id": "382225ae-c18f-4307-a6f6-3a0c6dca0f40"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f833ed07-d311-4e2d-9c50-d725749ed607",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:34:51+00:00",
        "updated_at": "2022-11-22T16:34:51+00:00",
        "menu_id": "5df61ba7-cce2-4529-861d-3cd168718bd6",
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
      "id": "aa26b7b5-5323-4297-8800-cea738bfdb64",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:34:51+00:00",
        "updated_at": "2022-11-22T16:34:51+00:00",
        "menu_id": "5df61ba7-cce2-4529-861d-3cd168718bd6",
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
      "id": "382225ae-c18f-4307-a6f6-3a0c6dca0f40",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:34:51+00:00",
        "updated_at": "2022-11-22T16:34:51+00:00",
        "menu_id": "5df61ba7-cce2-4529-861d-3cd168718bd6",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f0eb6c3b-ce86-42fa-8750-524fb76dad2f' \
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