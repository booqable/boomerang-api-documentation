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
      "id": "13bf1279-1374-490c-b799-f2b3bd9cb59d",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-05T11:27:44+00:00",
        "updated_at": "2023-01-05T11:27:44+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=13bf1279-1374-490c-b799-f2b3bd9cb59d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T11:25:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/9224a1ab-1f28-4d07-98ed-4431abdbab2b?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9224a1ab-1f28-4d07-98ed-4431abdbab2b",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T11:27:45+00:00",
      "updated_at": "2023-01-05T11:27:45+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=9224a1ab-1f28-4d07-98ed-4431abdbab2b"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "aed3dc0a-c1ac-4e0e-b69d-26d45680fac1"
          },
          {
            "type": "menu_items",
            "id": "94c58a9a-8034-4a0f-ac82-4327164ac4fc"
          },
          {
            "type": "menu_items",
            "id": "7d9dd5f9-4408-49b9-a138-1c96bc55456f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "aed3dc0a-c1ac-4e0e-b69d-26d45680fac1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T11:27:45+00:00",
        "updated_at": "2023-01-05T11:27:45+00:00",
        "menu_id": "9224a1ab-1f28-4d07-98ed-4431abdbab2b",
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
            "related": "api/boomerang/menus/9224a1ab-1f28-4d07-98ed-4431abdbab2b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=aed3dc0a-c1ac-4e0e-b69d-26d45680fac1"
          }
        }
      }
    },
    {
      "id": "94c58a9a-8034-4a0f-ac82-4327164ac4fc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T11:27:45+00:00",
        "updated_at": "2023-01-05T11:27:45+00:00",
        "menu_id": "9224a1ab-1f28-4d07-98ed-4431abdbab2b",
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
            "related": "api/boomerang/menus/9224a1ab-1f28-4d07-98ed-4431abdbab2b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=94c58a9a-8034-4a0f-ac82-4327164ac4fc"
          }
        }
      }
    },
    {
      "id": "7d9dd5f9-4408-49b9-a138-1c96bc55456f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T11:27:45+00:00",
        "updated_at": "2023-01-05T11:27:45+00:00",
        "menu_id": "9224a1ab-1f28-4d07-98ed-4431abdbab2b",
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
            "related": "api/boomerang/menus/9224a1ab-1f28-4d07-98ed-4431abdbab2b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7d9dd5f9-4408-49b9-a138-1c96bc55456f"
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
    "id": "5f367584-5bca-4955-bcb0-540ec4b3e94a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T11:27:45+00:00",
      "updated_at": "2023-01-05T11:27:45+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/4e3faccd-b9e7-4c41-a242-9bf8ba73d8ea' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4e3faccd-b9e7-4c41-a242-9bf8ba73d8ea",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "6211ac49-41ef-49b6-b7d5-e998bbdd39dc",
              "title": "Contact us"
            },
            {
              "id": "a653753c-8f2d-4c9c-b623-fc899562c2ad",
              "title": "Start"
            },
            {
              "id": "dcdf5604-fc6d-4e4d-9cb7-1cd017553b5b",
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
    "id": "4e3faccd-b9e7-4c41-a242-9bf8ba73d8ea",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T11:27:45+00:00",
      "updated_at": "2023-01-05T11:27:45+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "6211ac49-41ef-49b6-b7d5-e998bbdd39dc"
          },
          {
            "type": "menu_items",
            "id": "a653753c-8f2d-4c9c-b623-fc899562c2ad"
          },
          {
            "type": "menu_items",
            "id": "dcdf5604-fc6d-4e4d-9cb7-1cd017553b5b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6211ac49-41ef-49b6-b7d5-e998bbdd39dc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T11:27:45+00:00",
        "updated_at": "2023-01-05T11:27:45+00:00",
        "menu_id": "4e3faccd-b9e7-4c41-a242-9bf8ba73d8ea",
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
      "id": "a653753c-8f2d-4c9c-b623-fc899562c2ad",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T11:27:45+00:00",
        "updated_at": "2023-01-05T11:27:45+00:00",
        "menu_id": "4e3faccd-b9e7-4c41-a242-9bf8ba73d8ea",
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
      "id": "dcdf5604-fc6d-4e4d-9cb7-1cd017553b5b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T11:27:45+00:00",
        "updated_at": "2023-01-05T11:27:45+00:00",
        "menu_id": "4e3faccd-b9e7-4c41-a242-9bf8ba73d8ea",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d1c2ab11-2a8e-43dc-8d81-b0bdce1913bf' \
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