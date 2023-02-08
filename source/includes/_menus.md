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
      "id": "fb89eed9-c617-4316-ba9b-527984f91052",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-08T13:01:31+00:00",
        "updated_at": "2023-02-08T13:01:31+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=fb89eed9-c617-4316-ba9b-527984f91052"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T12:59:53Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/a062547a-00ae-462b-adac-28c9911898a2?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a062547a-00ae-462b-adac-28c9911898a2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T13:01:31+00:00",
      "updated_at": "2023-02-08T13:01:31+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a062547a-00ae-462b-adac-28c9911898a2"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "3407c52c-2da0-4a4c-a99f-0b402b693830"
          },
          {
            "type": "menu_items",
            "id": "e8e459e6-17e1-4ac7-b9a2-a982525e245b"
          },
          {
            "type": "menu_items",
            "id": "2787cdfe-9c80-45cf-b79e-a2a4096fed06"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3407c52c-2da0-4a4c-a99f-0b402b693830",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T13:01:31+00:00",
        "updated_at": "2023-02-08T13:01:31+00:00",
        "menu_id": "a062547a-00ae-462b-adac-28c9911898a2",
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
            "related": "api/boomerang/menus/a062547a-00ae-462b-adac-28c9911898a2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3407c52c-2da0-4a4c-a99f-0b402b693830"
          }
        }
      }
    },
    {
      "id": "e8e459e6-17e1-4ac7-b9a2-a982525e245b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T13:01:31+00:00",
        "updated_at": "2023-02-08T13:01:31+00:00",
        "menu_id": "a062547a-00ae-462b-adac-28c9911898a2",
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
            "related": "api/boomerang/menus/a062547a-00ae-462b-adac-28c9911898a2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e8e459e6-17e1-4ac7-b9a2-a982525e245b"
          }
        }
      }
    },
    {
      "id": "2787cdfe-9c80-45cf-b79e-a2a4096fed06",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T13:01:31+00:00",
        "updated_at": "2023-02-08T13:01:31+00:00",
        "menu_id": "a062547a-00ae-462b-adac-28c9911898a2",
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
            "related": "api/boomerang/menus/a062547a-00ae-462b-adac-28c9911898a2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2787cdfe-9c80-45cf-b79e-a2a4096fed06"
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
    "id": "ab1c4b24-2fc0-4634-aabd-8be2341cd098",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T13:01:32+00:00",
      "updated_at": "2023-02-08T13:01:32+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c9891db6-38a3-4f2b-8515-a3d993e2ed3f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c9891db6-38a3-4f2b-8515-a3d993e2ed3f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "8956e3ad-c121-4941-9bdf-99b3e4ee553b",
              "title": "Contact us"
            },
            {
              "id": "e4a1ba72-2d38-49fb-85c0-0c303885fdd9",
              "title": "Start"
            },
            {
              "id": "315362c7-8548-4636-a9a6-43b177b7ae08",
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
    "id": "c9891db6-38a3-4f2b-8515-a3d993e2ed3f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T13:01:32+00:00",
      "updated_at": "2023-02-08T13:01:32+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "8956e3ad-c121-4941-9bdf-99b3e4ee553b"
          },
          {
            "type": "menu_items",
            "id": "e4a1ba72-2d38-49fb-85c0-0c303885fdd9"
          },
          {
            "type": "menu_items",
            "id": "315362c7-8548-4636-a9a6-43b177b7ae08"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8956e3ad-c121-4941-9bdf-99b3e4ee553b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T13:01:32+00:00",
        "updated_at": "2023-02-08T13:01:32+00:00",
        "menu_id": "c9891db6-38a3-4f2b-8515-a3d993e2ed3f",
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
      "id": "e4a1ba72-2d38-49fb-85c0-0c303885fdd9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T13:01:32+00:00",
        "updated_at": "2023-02-08T13:01:32+00:00",
        "menu_id": "c9891db6-38a3-4f2b-8515-a3d993e2ed3f",
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
      "id": "315362c7-8548-4636-a9a6-43b177b7ae08",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T13:01:32+00:00",
        "updated_at": "2023-02-08T13:01:32+00:00",
        "menu_id": "c9891db6-38a3-4f2b-8515-a3d993e2ed3f",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d23152b5-72b0-46d0-b7ef-4d5e4913ecd5' \
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