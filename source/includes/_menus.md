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
      "id": "01f0de23-3d8f-4fbc-97f5-8cde9872c55b",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-17T13:26:57+00:00",
        "updated_at": "2023-02-17T13:26:57+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=01f0de23-3d8f-4fbc-97f5-8cde9872c55b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-17T13:25:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/87b3d002-715d-4d23-8064-a2795bdc29fa?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "87b3d002-715d-4d23-8064-a2795bdc29fa",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-17T13:26:58+00:00",
      "updated_at": "2023-02-17T13:26:58+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=87b3d002-715d-4d23-8064-a2795bdc29fa"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ef194135-3a02-42ed-8a09-a5e20b40dc60"
          },
          {
            "type": "menu_items",
            "id": "61cc983b-c639-43c6-a496-a716ebc1bfb1"
          },
          {
            "type": "menu_items",
            "id": "cbce17af-72c4-484b-ab53-e9a69d1f1316"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ef194135-3a02-42ed-8a09-a5e20b40dc60",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-17T13:26:58+00:00",
        "updated_at": "2023-02-17T13:26:58+00:00",
        "menu_id": "87b3d002-715d-4d23-8064-a2795bdc29fa",
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
            "related": "api/boomerang/menus/87b3d002-715d-4d23-8064-a2795bdc29fa"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ef194135-3a02-42ed-8a09-a5e20b40dc60"
          }
        }
      }
    },
    {
      "id": "61cc983b-c639-43c6-a496-a716ebc1bfb1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-17T13:26:58+00:00",
        "updated_at": "2023-02-17T13:26:58+00:00",
        "menu_id": "87b3d002-715d-4d23-8064-a2795bdc29fa",
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
            "related": "api/boomerang/menus/87b3d002-715d-4d23-8064-a2795bdc29fa"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=61cc983b-c639-43c6-a496-a716ebc1bfb1"
          }
        }
      }
    },
    {
      "id": "cbce17af-72c4-484b-ab53-e9a69d1f1316",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-17T13:26:58+00:00",
        "updated_at": "2023-02-17T13:26:58+00:00",
        "menu_id": "87b3d002-715d-4d23-8064-a2795bdc29fa",
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
            "related": "api/boomerang/menus/87b3d002-715d-4d23-8064-a2795bdc29fa"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cbce17af-72c4-484b-ab53-e9a69d1f1316"
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
    "id": "155dbca0-39ee-41ca-b5b9-bde5cc84d7d8",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-17T13:26:58+00:00",
      "updated_at": "2023-02-17T13:26:58+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/8a6ba174-7986-4db5-a743-b17aa4ca8cd4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8a6ba174-7986-4db5-a743-b17aa4ca8cd4",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "dab01f21-5905-49ef-b9a1-12bbeb778d93",
              "title": "Contact us"
            },
            {
              "id": "e9d03fa3-ee00-443d-8c7d-6813efb9cdde",
              "title": "Start"
            },
            {
              "id": "1fdd95fa-f90f-49a8-b479-afb31be33771",
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
    "id": "8a6ba174-7986-4db5-a743-b17aa4ca8cd4",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-17T13:26:58+00:00",
      "updated_at": "2023-02-17T13:26:59+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "dab01f21-5905-49ef-b9a1-12bbeb778d93"
          },
          {
            "type": "menu_items",
            "id": "e9d03fa3-ee00-443d-8c7d-6813efb9cdde"
          },
          {
            "type": "menu_items",
            "id": "1fdd95fa-f90f-49a8-b479-afb31be33771"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dab01f21-5905-49ef-b9a1-12bbeb778d93",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-17T13:26:58+00:00",
        "updated_at": "2023-02-17T13:26:59+00:00",
        "menu_id": "8a6ba174-7986-4db5-a743-b17aa4ca8cd4",
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
      "id": "e9d03fa3-ee00-443d-8c7d-6813efb9cdde",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-17T13:26:58+00:00",
        "updated_at": "2023-02-17T13:26:59+00:00",
        "menu_id": "8a6ba174-7986-4db5-a743-b17aa4ca8cd4",
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
      "id": "1fdd95fa-f90f-49a8-b479-afb31be33771",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-17T13:26:59+00:00",
        "updated_at": "2023-02-17T13:26:59+00:00",
        "menu_id": "8a6ba174-7986-4db5-a743-b17aa4ca8cd4",
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
    --url 'https://example.booqable.com/api/boomerang/menus/86b49cdc-3e9e-492a-8acf-12644a3a3f05' \
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