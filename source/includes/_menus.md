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
      "id": "b4efe7ca-77f8-4fe7-acf3-96e24e108cbd",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-23T13:51:36+00:00",
        "updated_at": "2023-02-23T13:51:36+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=b4efe7ca-77f8-4fe7-acf3-96e24e108cbd"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T13:49:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/b971a1d4-1bdd-4475-b2da-6568e9e90863?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b971a1d4-1bdd-4475-b2da-6568e9e90863",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T13:51:36+00:00",
      "updated_at": "2023-02-23T13:51:36+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b971a1d4-1bdd-4475-b2da-6568e9e90863"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "34e99eef-0a87-4e62-8df3-00361be794b6"
          },
          {
            "type": "menu_items",
            "id": "97f95881-30e4-4ca6-a903-1ff23d3044d8"
          },
          {
            "type": "menu_items",
            "id": "3ae8c048-2bd7-4ff2-8deb-dee6e2803578"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "34e99eef-0a87-4e62-8df3-00361be794b6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T13:51:36+00:00",
        "updated_at": "2023-02-23T13:51:36+00:00",
        "menu_id": "b971a1d4-1bdd-4475-b2da-6568e9e90863",
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
            "related": "api/boomerang/menus/b971a1d4-1bdd-4475-b2da-6568e9e90863"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=34e99eef-0a87-4e62-8df3-00361be794b6"
          }
        }
      }
    },
    {
      "id": "97f95881-30e4-4ca6-a903-1ff23d3044d8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T13:51:36+00:00",
        "updated_at": "2023-02-23T13:51:36+00:00",
        "menu_id": "b971a1d4-1bdd-4475-b2da-6568e9e90863",
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
            "related": "api/boomerang/menus/b971a1d4-1bdd-4475-b2da-6568e9e90863"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=97f95881-30e4-4ca6-a903-1ff23d3044d8"
          }
        }
      }
    },
    {
      "id": "3ae8c048-2bd7-4ff2-8deb-dee6e2803578",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T13:51:36+00:00",
        "updated_at": "2023-02-23T13:51:36+00:00",
        "menu_id": "b971a1d4-1bdd-4475-b2da-6568e9e90863",
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
            "related": "api/boomerang/menus/b971a1d4-1bdd-4475-b2da-6568e9e90863"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3ae8c048-2bd7-4ff2-8deb-dee6e2803578"
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
    "id": "aa3329a0-fa8f-49b6-8500-3cb5ad4a3725",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T13:51:37+00:00",
      "updated_at": "2023-02-23T13:51:37+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/580e0298-51dc-442a-8172-9ad66f21e642' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "580e0298-51dc-442a-8172-9ad66f21e642",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "2f787cb3-ace1-4d5b-9946-0d40f2abda7e",
              "title": "Contact us"
            },
            {
              "id": "151bbc59-9689-40da-9052-20c95ce5dac4",
              "title": "Start"
            },
            {
              "id": "4701ea01-05c9-4c1d-98da-52fbf3215eeb",
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
    "id": "580e0298-51dc-442a-8172-9ad66f21e642",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T13:51:37+00:00",
      "updated_at": "2023-02-23T13:51:37+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "2f787cb3-ace1-4d5b-9946-0d40f2abda7e"
          },
          {
            "type": "menu_items",
            "id": "151bbc59-9689-40da-9052-20c95ce5dac4"
          },
          {
            "type": "menu_items",
            "id": "4701ea01-05c9-4c1d-98da-52fbf3215eeb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2f787cb3-ace1-4d5b-9946-0d40f2abda7e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T13:51:37+00:00",
        "updated_at": "2023-02-23T13:51:37+00:00",
        "menu_id": "580e0298-51dc-442a-8172-9ad66f21e642",
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
      "id": "151bbc59-9689-40da-9052-20c95ce5dac4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T13:51:37+00:00",
        "updated_at": "2023-02-23T13:51:37+00:00",
        "menu_id": "580e0298-51dc-442a-8172-9ad66f21e642",
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
      "id": "4701ea01-05c9-4c1d-98da-52fbf3215eeb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T13:51:37+00:00",
        "updated_at": "2023-02-23T13:51:37+00:00",
        "menu_id": "580e0298-51dc-442a-8172-9ad66f21e642",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b222f61f-6b26-4562-8874-515e1c440eae' \
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