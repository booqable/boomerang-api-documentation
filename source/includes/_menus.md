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
      "id": "e9a7287e-345f-4e42-9f4d-c47014d14467",
      "type": "menus",
      "attributes": {
        "created_at": "2022-10-07T15:07:59+00:00",
        "updated_at": "2022-10-07T15:07:59+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=e9a7287e-345f-4e42-9f4d-c47014d14467"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T15:04:27Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/6a29a715-1b7e-467a-91fe-157b5363f90c?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6a29a715-1b7e-467a-91fe-157b5363f90c",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-07T15:08:00+00:00",
      "updated_at": "2022-10-07T15:08:00+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=6a29a715-1b7e-467a-91fe-157b5363f90c"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ce7864d5-2d14-4911-b5a5-f19aaca7a092"
          },
          {
            "type": "menu_items",
            "id": "493e961f-c7eb-4a20-a193-91c67fc4f7bd"
          },
          {
            "type": "menu_items",
            "id": "447d4f08-f2c9-43f4-8391-43d397f50325"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ce7864d5-2d14-4911-b5a5-f19aaca7a092",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T15:08:00+00:00",
        "updated_at": "2022-10-07T15:08:00+00:00",
        "menu_id": "6a29a715-1b7e-467a-91fe-157b5363f90c",
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
            "related": "api/boomerang/menus/6a29a715-1b7e-467a-91fe-157b5363f90c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ce7864d5-2d14-4911-b5a5-f19aaca7a092"
          }
        }
      }
    },
    {
      "id": "493e961f-c7eb-4a20-a193-91c67fc4f7bd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T15:08:00+00:00",
        "updated_at": "2022-10-07T15:08:00+00:00",
        "menu_id": "6a29a715-1b7e-467a-91fe-157b5363f90c",
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
            "related": "api/boomerang/menus/6a29a715-1b7e-467a-91fe-157b5363f90c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=493e961f-c7eb-4a20-a193-91c67fc4f7bd"
          }
        }
      }
    },
    {
      "id": "447d4f08-f2c9-43f4-8391-43d397f50325",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T15:08:00+00:00",
        "updated_at": "2022-10-07T15:08:00+00:00",
        "menu_id": "6a29a715-1b7e-467a-91fe-157b5363f90c",
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
            "related": "api/boomerang/menus/6a29a715-1b7e-467a-91fe-157b5363f90c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=447d4f08-f2c9-43f4-8391-43d397f50325"
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
    "id": "afad97b4-4b70-4fc4-9bb3-dc9bea447c8b",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-07T15:08:01+00:00",
      "updated_at": "2022-10-07T15:08:01+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c8d5d6f3-b715-488c-9e28-9286b5711227' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c8d5d6f3-b715-488c-9e28-9286b5711227",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e51ec4a6-aa1d-4c9b-bb38-d5f776f1d516",
              "title": "Contact us"
            },
            {
              "id": "57102c29-b391-40df-8989-c7c4a95376ee",
              "title": "Start"
            },
            {
              "id": "413bacd0-f420-4db4-acef-51222e9dbc56",
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
    "id": "c8d5d6f3-b715-488c-9e28-9286b5711227",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-07T15:08:01+00:00",
      "updated_at": "2022-10-07T15:08:01+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e51ec4a6-aa1d-4c9b-bb38-d5f776f1d516"
          },
          {
            "type": "menu_items",
            "id": "57102c29-b391-40df-8989-c7c4a95376ee"
          },
          {
            "type": "menu_items",
            "id": "413bacd0-f420-4db4-acef-51222e9dbc56"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e51ec4a6-aa1d-4c9b-bb38-d5f776f1d516",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T15:08:01+00:00",
        "updated_at": "2022-10-07T15:08:01+00:00",
        "menu_id": "c8d5d6f3-b715-488c-9e28-9286b5711227",
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
      "id": "57102c29-b391-40df-8989-c7c4a95376ee",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T15:08:01+00:00",
        "updated_at": "2022-10-07T15:08:01+00:00",
        "menu_id": "c8d5d6f3-b715-488c-9e28-9286b5711227",
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
      "id": "413bacd0-f420-4db4-acef-51222e9dbc56",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T15:08:01+00:00",
        "updated_at": "2022-10-07T15:08:01+00:00",
        "menu_id": "c8d5d6f3-b715-488c-9e28-9286b5711227",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d8c6d3fc-223f-4af5-8b74-2ae962b73c32' \
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