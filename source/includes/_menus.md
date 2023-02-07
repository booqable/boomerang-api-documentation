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
      "id": "069697ae-5502-4773-adfd-12adc9ffe699",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-07T10:28:45+00:00",
        "updated_at": "2023-02-07T10:28:45+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=069697ae-5502-4773-adfd-12adc9ffe699"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T10:26:13Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/c74f17df-28b4-4c34-acdc-2aafe4380aa7?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c74f17df-28b4-4c34-acdc-2aafe4380aa7",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T10:28:46+00:00",
      "updated_at": "2023-02-07T10:28:46+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=c74f17df-28b4-4c34-acdc-2aafe4380aa7"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "c3b62ac0-697b-4375-aca8-432206319612"
          },
          {
            "type": "menu_items",
            "id": "7004f387-e84a-4ce9-9d5e-51332459437f"
          },
          {
            "type": "menu_items",
            "id": "d05ea493-d016-4498-bf29-88a78f9e0cca"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c3b62ac0-697b-4375-aca8-432206319612",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T10:28:46+00:00",
        "updated_at": "2023-02-07T10:28:46+00:00",
        "menu_id": "c74f17df-28b4-4c34-acdc-2aafe4380aa7",
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
            "related": "api/boomerang/menus/c74f17df-28b4-4c34-acdc-2aafe4380aa7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c3b62ac0-697b-4375-aca8-432206319612"
          }
        }
      }
    },
    {
      "id": "7004f387-e84a-4ce9-9d5e-51332459437f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T10:28:46+00:00",
        "updated_at": "2023-02-07T10:28:46+00:00",
        "menu_id": "c74f17df-28b4-4c34-acdc-2aafe4380aa7",
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
            "related": "api/boomerang/menus/c74f17df-28b4-4c34-acdc-2aafe4380aa7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7004f387-e84a-4ce9-9d5e-51332459437f"
          }
        }
      }
    },
    {
      "id": "d05ea493-d016-4498-bf29-88a78f9e0cca",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T10:28:46+00:00",
        "updated_at": "2023-02-07T10:28:46+00:00",
        "menu_id": "c74f17df-28b4-4c34-acdc-2aafe4380aa7",
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
            "related": "api/boomerang/menus/c74f17df-28b4-4c34-acdc-2aafe4380aa7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d05ea493-d016-4498-bf29-88a78f9e0cca"
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
    "id": "89e5a78d-ba18-487e-9481-1d865f332637",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T10:28:46+00:00",
      "updated_at": "2023-02-07T10:28:46+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/698d45d7-fac1-4157-abe4-9abb44a954f3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "698d45d7-fac1-4157-abe4-9abb44a954f3",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "b431433d-244f-4941-95cc-35f42accdc7b",
              "title": "Contact us"
            },
            {
              "id": "581e73bf-015c-48cb-8cac-b396bd9df81b",
              "title": "Start"
            },
            {
              "id": "e548481f-3e25-4c82-98fb-10c52f0a935a",
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
    "id": "698d45d7-fac1-4157-abe4-9abb44a954f3",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T10:28:47+00:00",
      "updated_at": "2023-02-07T10:28:47+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "b431433d-244f-4941-95cc-35f42accdc7b"
          },
          {
            "type": "menu_items",
            "id": "581e73bf-015c-48cb-8cac-b396bd9df81b"
          },
          {
            "type": "menu_items",
            "id": "e548481f-3e25-4c82-98fb-10c52f0a935a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b431433d-244f-4941-95cc-35f42accdc7b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T10:28:47+00:00",
        "updated_at": "2023-02-07T10:28:47+00:00",
        "menu_id": "698d45d7-fac1-4157-abe4-9abb44a954f3",
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
      "id": "581e73bf-015c-48cb-8cac-b396bd9df81b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T10:28:47+00:00",
        "updated_at": "2023-02-07T10:28:47+00:00",
        "menu_id": "698d45d7-fac1-4157-abe4-9abb44a954f3",
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
      "id": "e548481f-3e25-4c82-98fb-10c52f0a935a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T10:28:47+00:00",
        "updated_at": "2023-02-07T10:28:47+00:00",
        "menu_id": "698d45d7-fac1-4157-abe4-9abb44a954f3",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b4462d25-37bc-4b1a-8cfb-75144bd6bd2c' \
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