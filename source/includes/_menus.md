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
      "id": "23bdd5a5-0571-43a4-9727-a6ba88975f3c",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-13T08:15:47+00:00",
        "updated_at": "2023-02-13T08:15:47+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=23bdd5a5-0571-43a4-9727-a6ba88975f3c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T08:13:41Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/a6b3e034-bb94-4fd3-a7fa-af2123afc1d6?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a6b3e034-bb94-4fd3-a7fa-af2123afc1d6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T08:15:48+00:00",
      "updated_at": "2023-02-13T08:15:48+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a6b3e034-bb94-4fd3-a7fa-af2123afc1d6"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "4bc873ea-739d-43f3-b889-acf448b42f35"
          },
          {
            "type": "menu_items",
            "id": "bf6ca9d2-ddb6-478e-b78f-9bfb65c6d246"
          },
          {
            "type": "menu_items",
            "id": "00599841-a9ab-4b61-92cd-1622ff2e3e09"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4bc873ea-739d-43f3-b889-acf448b42f35",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T08:15:48+00:00",
        "updated_at": "2023-02-13T08:15:48+00:00",
        "menu_id": "a6b3e034-bb94-4fd3-a7fa-af2123afc1d6",
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
            "related": "api/boomerang/menus/a6b3e034-bb94-4fd3-a7fa-af2123afc1d6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4bc873ea-739d-43f3-b889-acf448b42f35"
          }
        }
      }
    },
    {
      "id": "bf6ca9d2-ddb6-478e-b78f-9bfb65c6d246",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T08:15:48+00:00",
        "updated_at": "2023-02-13T08:15:48+00:00",
        "menu_id": "a6b3e034-bb94-4fd3-a7fa-af2123afc1d6",
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
            "related": "api/boomerang/menus/a6b3e034-bb94-4fd3-a7fa-af2123afc1d6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bf6ca9d2-ddb6-478e-b78f-9bfb65c6d246"
          }
        }
      }
    },
    {
      "id": "00599841-a9ab-4b61-92cd-1622ff2e3e09",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T08:15:48+00:00",
        "updated_at": "2023-02-13T08:15:48+00:00",
        "menu_id": "a6b3e034-bb94-4fd3-a7fa-af2123afc1d6",
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
            "related": "api/boomerang/menus/a6b3e034-bb94-4fd3-a7fa-af2123afc1d6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=00599841-a9ab-4b61-92cd-1622ff2e3e09"
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
    "id": "9955fd7d-4af3-471a-9e0c-18a7a4d3d9ec",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T08:15:48+00:00",
      "updated_at": "2023-02-13T08:15:48+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/3f0a62ee-c2da-4e02-9c0f-b1afe5560ba1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3f0a62ee-c2da-4e02-9c0f-b1afe5560ba1",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "b8d62500-6449-41c1-80f8-da1883afba15",
              "title": "Contact us"
            },
            {
              "id": "fe1ea20a-cc3a-4275-a1ea-353b4e820d4a",
              "title": "Start"
            },
            {
              "id": "ee49a1ae-63a9-463a-a5cd-722a49c8db3a",
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
    "id": "3f0a62ee-c2da-4e02-9c0f-b1afe5560ba1",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T08:15:49+00:00",
      "updated_at": "2023-02-13T08:15:49+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "b8d62500-6449-41c1-80f8-da1883afba15"
          },
          {
            "type": "menu_items",
            "id": "fe1ea20a-cc3a-4275-a1ea-353b4e820d4a"
          },
          {
            "type": "menu_items",
            "id": "ee49a1ae-63a9-463a-a5cd-722a49c8db3a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b8d62500-6449-41c1-80f8-da1883afba15",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T08:15:49+00:00",
        "updated_at": "2023-02-13T08:15:49+00:00",
        "menu_id": "3f0a62ee-c2da-4e02-9c0f-b1afe5560ba1",
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
      "id": "fe1ea20a-cc3a-4275-a1ea-353b4e820d4a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T08:15:49+00:00",
        "updated_at": "2023-02-13T08:15:49+00:00",
        "menu_id": "3f0a62ee-c2da-4e02-9c0f-b1afe5560ba1",
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
      "id": "ee49a1ae-63a9-463a-a5cd-722a49c8db3a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T08:15:49+00:00",
        "updated_at": "2023-02-13T08:15:49+00:00",
        "menu_id": "3f0a62ee-c2da-4e02-9c0f-b1afe5560ba1",
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
    --url 'https://example.booqable.com/api/boomerang/menus/bc49aa58-620c-4e9e-bbad-7ea00f7ee829' \
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