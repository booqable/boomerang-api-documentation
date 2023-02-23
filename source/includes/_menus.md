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
      "id": "34f4fe68-1591-4dc7-9889-db94fc2d7918",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-23T08:55:58+00:00",
        "updated_at": "2023-02-23T08:55:58+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=34f4fe68-1591-4dc7-9889-db94fc2d7918"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T08:53:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/040bd7cc-7f0f-4a14-bd18-581f4855b1da?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "040bd7cc-7f0f-4a14-bd18-581f4855b1da",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T08:55:58+00:00",
      "updated_at": "2023-02-23T08:55:58+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=040bd7cc-7f0f-4a14-bd18-581f4855b1da"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "d00c8d3d-c1c1-4251-a5a2-937596433549"
          },
          {
            "type": "menu_items",
            "id": "e8bc5d38-7664-49c1-9842-7e33a89ea02f"
          },
          {
            "type": "menu_items",
            "id": "f8adfe08-3b24-4314-97d0-a6e7ecfc98c7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d00c8d3d-c1c1-4251-a5a2-937596433549",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T08:55:58+00:00",
        "updated_at": "2023-02-23T08:55:58+00:00",
        "menu_id": "040bd7cc-7f0f-4a14-bd18-581f4855b1da",
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
            "related": "api/boomerang/menus/040bd7cc-7f0f-4a14-bd18-581f4855b1da"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d00c8d3d-c1c1-4251-a5a2-937596433549"
          }
        }
      }
    },
    {
      "id": "e8bc5d38-7664-49c1-9842-7e33a89ea02f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T08:55:58+00:00",
        "updated_at": "2023-02-23T08:55:58+00:00",
        "menu_id": "040bd7cc-7f0f-4a14-bd18-581f4855b1da",
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
            "related": "api/boomerang/menus/040bd7cc-7f0f-4a14-bd18-581f4855b1da"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e8bc5d38-7664-49c1-9842-7e33a89ea02f"
          }
        }
      }
    },
    {
      "id": "f8adfe08-3b24-4314-97d0-a6e7ecfc98c7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T08:55:58+00:00",
        "updated_at": "2023-02-23T08:55:58+00:00",
        "menu_id": "040bd7cc-7f0f-4a14-bd18-581f4855b1da",
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
            "related": "api/boomerang/menus/040bd7cc-7f0f-4a14-bd18-581f4855b1da"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f8adfe08-3b24-4314-97d0-a6e7ecfc98c7"
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
    "id": "230039b8-3eae-4717-b0ac-f64d9ab18a10",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T08:55:59+00:00",
      "updated_at": "2023-02-23T08:55:59+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/e5d27c6f-3169-4f95-829b-aec37716bbd2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e5d27c6f-3169-4f95-829b-aec37716bbd2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e14e7109-4498-49eb-ab88-6dfd5955201b",
              "title": "Contact us"
            },
            {
              "id": "a5627208-cf37-48a9-ac39-0c5d0c911ec7",
              "title": "Start"
            },
            {
              "id": "c3478b88-faf1-4a7e-ac5e-d618d4bb3b27",
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
    "id": "e5d27c6f-3169-4f95-829b-aec37716bbd2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T08:55:59+00:00",
      "updated_at": "2023-02-23T08:55:59+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e14e7109-4498-49eb-ab88-6dfd5955201b"
          },
          {
            "type": "menu_items",
            "id": "a5627208-cf37-48a9-ac39-0c5d0c911ec7"
          },
          {
            "type": "menu_items",
            "id": "c3478b88-faf1-4a7e-ac5e-d618d4bb3b27"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e14e7109-4498-49eb-ab88-6dfd5955201b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T08:55:59+00:00",
        "updated_at": "2023-02-23T08:55:59+00:00",
        "menu_id": "e5d27c6f-3169-4f95-829b-aec37716bbd2",
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
      "id": "a5627208-cf37-48a9-ac39-0c5d0c911ec7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T08:55:59+00:00",
        "updated_at": "2023-02-23T08:55:59+00:00",
        "menu_id": "e5d27c6f-3169-4f95-829b-aec37716bbd2",
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
      "id": "c3478b88-faf1-4a7e-ac5e-d618d4bb3b27",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T08:55:59+00:00",
        "updated_at": "2023-02-23T08:55:59+00:00",
        "menu_id": "e5d27c6f-3169-4f95-829b-aec37716bbd2",
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
    --url 'https://example.booqable.com/api/boomerang/menus/de1587b7-5334-4eb5-8817-eccd1eb0b4d2' \
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