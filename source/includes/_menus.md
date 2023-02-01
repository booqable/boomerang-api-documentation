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
      "id": "b90b391d-6add-4e72-a9d4-e5647161e26c",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-01T13:00:57+00:00",
        "updated_at": "2023-02-01T13:00:57+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=b90b391d-6add-4e72-a9d4-e5647161e26c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T12:58:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/b1d806c1-5dfb-4b34-a988-b5f7dfcc0baa?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b1d806c1-5dfb-4b34-a988-b5f7dfcc0baa",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-01T13:01:01+00:00",
      "updated_at": "2023-02-01T13:01:01+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b1d806c1-5dfb-4b34-a988-b5f7dfcc0baa"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "131ce247-fd4c-4118-b864-04fb4a59acb8"
          },
          {
            "type": "menu_items",
            "id": "9d4565f2-6854-4be0-85df-3ac22a396796"
          },
          {
            "type": "menu_items",
            "id": "6be5d1d1-d677-454f-bc81-88a330b1d2a7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "131ce247-fd4c-4118-b864-04fb4a59acb8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T13:01:01+00:00",
        "updated_at": "2023-02-01T13:01:01+00:00",
        "menu_id": "b1d806c1-5dfb-4b34-a988-b5f7dfcc0baa",
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
            "related": "api/boomerang/menus/b1d806c1-5dfb-4b34-a988-b5f7dfcc0baa"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=131ce247-fd4c-4118-b864-04fb4a59acb8"
          }
        }
      }
    },
    {
      "id": "9d4565f2-6854-4be0-85df-3ac22a396796",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T13:01:01+00:00",
        "updated_at": "2023-02-01T13:01:01+00:00",
        "menu_id": "b1d806c1-5dfb-4b34-a988-b5f7dfcc0baa",
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
            "related": "api/boomerang/menus/b1d806c1-5dfb-4b34-a988-b5f7dfcc0baa"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9d4565f2-6854-4be0-85df-3ac22a396796"
          }
        }
      }
    },
    {
      "id": "6be5d1d1-d677-454f-bc81-88a330b1d2a7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T13:01:01+00:00",
        "updated_at": "2023-02-01T13:01:01+00:00",
        "menu_id": "b1d806c1-5dfb-4b34-a988-b5f7dfcc0baa",
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
            "related": "api/boomerang/menus/b1d806c1-5dfb-4b34-a988-b5f7dfcc0baa"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6be5d1d1-d677-454f-bc81-88a330b1d2a7"
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
    "id": "334a25f3-fd20-47f7-9925-21b21bcacbbd",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-01T13:01:02+00:00",
      "updated_at": "2023-02-01T13:01:02+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a27aba58-ba95-4ac7-bc4d-2d270675da53' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a27aba58-ba95-4ac7-bc4d-2d270675da53",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "7149c3b9-915e-4ec1-86e0-2171cf5c8f50",
              "title": "Contact us"
            },
            {
              "id": "29d00039-c78e-4d39-a209-7b640ddfd0cc",
              "title": "Start"
            },
            {
              "id": "a3d0d3ae-cfa1-4a74-bfb8-5a2a04f7398b",
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
    "id": "a27aba58-ba95-4ac7-bc4d-2d270675da53",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-01T13:01:03+00:00",
      "updated_at": "2023-02-01T13:01:03+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "7149c3b9-915e-4ec1-86e0-2171cf5c8f50"
          },
          {
            "type": "menu_items",
            "id": "29d00039-c78e-4d39-a209-7b640ddfd0cc"
          },
          {
            "type": "menu_items",
            "id": "a3d0d3ae-cfa1-4a74-bfb8-5a2a04f7398b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7149c3b9-915e-4ec1-86e0-2171cf5c8f50",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T13:01:03+00:00",
        "updated_at": "2023-02-01T13:01:03+00:00",
        "menu_id": "a27aba58-ba95-4ac7-bc4d-2d270675da53",
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
      "id": "29d00039-c78e-4d39-a209-7b640ddfd0cc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T13:01:03+00:00",
        "updated_at": "2023-02-01T13:01:03+00:00",
        "menu_id": "a27aba58-ba95-4ac7-bc4d-2d270675da53",
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
      "id": "a3d0d3ae-cfa1-4a74-bfb8-5a2a04f7398b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T13:01:03+00:00",
        "updated_at": "2023-02-01T13:01:03+00:00",
        "menu_id": "a27aba58-ba95-4ac7-bc4d-2d270675da53",
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
    --url 'https://example.booqable.com/api/boomerang/menus/bf2a9520-243f-426f-830f-09a9caa9ef5c' \
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