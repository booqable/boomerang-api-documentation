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
      "id": "5d26bf8d-579a-4b7a-87a3-1e971cddc5be",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-14T12:47:10+00:00",
        "updated_at": "2023-02-14T12:47:10+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=5d26bf8d-579a-4b7a-87a3-1e971cddc5be"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T12:45:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/76c4d397-fbe6-4287-9a18-12859ab93a73?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "76c4d397-fbe6-4287-9a18-12859ab93a73",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T12:47:11+00:00",
      "updated_at": "2023-02-14T12:47:11+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=76c4d397-fbe6-4287-9a18-12859ab93a73"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "762bfa8a-06a4-474c-8549-94c39968f2d0"
          },
          {
            "type": "menu_items",
            "id": "399d7379-1b48-409e-9dad-c35697e27e06"
          },
          {
            "type": "menu_items",
            "id": "27b1398e-a9e6-427d-b42c-c06b31d6ab38"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "762bfa8a-06a4-474c-8549-94c39968f2d0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T12:47:11+00:00",
        "updated_at": "2023-02-14T12:47:11+00:00",
        "menu_id": "76c4d397-fbe6-4287-9a18-12859ab93a73",
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
            "related": "api/boomerang/menus/76c4d397-fbe6-4287-9a18-12859ab93a73"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=762bfa8a-06a4-474c-8549-94c39968f2d0"
          }
        }
      }
    },
    {
      "id": "399d7379-1b48-409e-9dad-c35697e27e06",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T12:47:11+00:00",
        "updated_at": "2023-02-14T12:47:11+00:00",
        "menu_id": "76c4d397-fbe6-4287-9a18-12859ab93a73",
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
            "related": "api/boomerang/menus/76c4d397-fbe6-4287-9a18-12859ab93a73"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=399d7379-1b48-409e-9dad-c35697e27e06"
          }
        }
      }
    },
    {
      "id": "27b1398e-a9e6-427d-b42c-c06b31d6ab38",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T12:47:11+00:00",
        "updated_at": "2023-02-14T12:47:11+00:00",
        "menu_id": "76c4d397-fbe6-4287-9a18-12859ab93a73",
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
            "related": "api/boomerang/menus/76c4d397-fbe6-4287-9a18-12859ab93a73"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=27b1398e-a9e6-427d-b42c-c06b31d6ab38"
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
    "id": "c6e2cb53-49da-4046-9dca-0a082a330b20",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T12:47:11+00:00",
      "updated_at": "2023-02-14T12:47:11+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/bd4eff59-4e59-473a-a8fa-fb05ae822d27' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bd4eff59-4e59-473a-a8fa-fb05ae822d27",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "282b13ff-20b3-4d88-84b4-dbaaaf607d7c",
              "title": "Contact us"
            },
            {
              "id": "17a91410-6dc6-4477-bb9b-fca9dbd1b7c3",
              "title": "Start"
            },
            {
              "id": "65e44c1b-d629-4b5e-936e-c1e1a17eedbb",
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
    "id": "bd4eff59-4e59-473a-a8fa-fb05ae822d27",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T12:47:11+00:00",
      "updated_at": "2023-02-14T12:47:11+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "282b13ff-20b3-4d88-84b4-dbaaaf607d7c"
          },
          {
            "type": "menu_items",
            "id": "17a91410-6dc6-4477-bb9b-fca9dbd1b7c3"
          },
          {
            "type": "menu_items",
            "id": "65e44c1b-d629-4b5e-936e-c1e1a17eedbb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "282b13ff-20b3-4d88-84b4-dbaaaf607d7c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T12:47:11+00:00",
        "updated_at": "2023-02-14T12:47:11+00:00",
        "menu_id": "bd4eff59-4e59-473a-a8fa-fb05ae822d27",
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
      "id": "17a91410-6dc6-4477-bb9b-fca9dbd1b7c3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T12:47:11+00:00",
        "updated_at": "2023-02-14T12:47:11+00:00",
        "menu_id": "bd4eff59-4e59-473a-a8fa-fb05ae822d27",
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
      "id": "65e44c1b-d629-4b5e-936e-c1e1a17eedbb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T12:47:11+00:00",
        "updated_at": "2023-02-14T12:47:11+00:00",
        "menu_id": "bd4eff59-4e59-473a-a8fa-fb05ae822d27",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7062c5c4-3fce-4c3c-a12b-37d25bbb9964' \
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