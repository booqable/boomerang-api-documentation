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
`title` | **String**<br>Name of the menu.
`key` | **String**<br>Key the menu can be referenced by.
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
      "id": "a9c8e797-fd08-4146-8360-55df4fe0278b",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-12T08:48:30+00:00",
        "updated_at": "2022-07-12T08:48:30+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=a9c8e797-fd08-4146-8360-55df4fe0278b"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-12T08:46:39Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/2bb35eb9-8488-45ef-8119-59ce52570061?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2bb35eb9-8488-45ef-8119-59ce52570061",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-12T08:48:31+00:00",
      "updated_at": "2022-07-12T08:48:31+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=2bb35eb9-8488-45ef-8119-59ce52570061"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "bdf8a8c2-537b-4657-9b31-cbad691be866"
          },
          {
            "type": "menu_items",
            "id": "b0f27a5d-142e-495b-aac3-c9e3ab3794af"
          },
          {
            "type": "menu_items",
            "id": "cf6bb0e0-f461-44c6-b18b-9d3f3fee69a0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bdf8a8c2-537b-4657-9b31-cbad691be866",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-12T08:48:31+00:00",
        "updated_at": "2022-07-12T08:48:31+00:00",
        "menu_id": "2bb35eb9-8488-45ef-8119-59ce52570061",
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
            "related": "api/boomerang/menus/2bb35eb9-8488-45ef-8119-59ce52570061"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bdf8a8c2-537b-4657-9b31-cbad691be866"
          }
        }
      }
    },
    {
      "id": "b0f27a5d-142e-495b-aac3-c9e3ab3794af",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-12T08:48:31+00:00",
        "updated_at": "2022-07-12T08:48:31+00:00",
        "menu_id": "2bb35eb9-8488-45ef-8119-59ce52570061",
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
            "related": "api/boomerang/menus/2bb35eb9-8488-45ef-8119-59ce52570061"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b0f27a5d-142e-495b-aac3-c9e3ab3794af"
          }
        }
      }
    },
    {
      "id": "cf6bb0e0-f461-44c6-b18b-9d3f3fee69a0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-12T08:48:31+00:00",
        "updated_at": "2022-07-12T08:48:31+00:00",
        "menu_id": "2bb35eb9-8488-45ef-8119-59ce52570061",
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
            "related": "api/boomerang/menus/2bb35eb9-8488-45ef-8119-59ce52570061"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cf6bb0e0-f461-44c6-b18b-9d3f3fee69a0"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


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
    "id": "7f8688f3-14a4-4577-b330-4212a047c9f5",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-12T08:48:31+00:00",
      "updated_at": "2022-07-12T08:48:31+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/539bdc57-8b76-4c69-bec5-1f90c6e67dd2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "539bdc57-8b76-4c69-bec5-1f90c6e67dd2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "65bd1a9c-6a3f-4ecc-89a0-986edfdef928",
              "title": "Contact us"
            },
            {
              "id": "72f1cfe1-fc52-4afe-91df-2bcf023a4b09",
              "title": "Start"
            },
            {
              "id": "1b6d5b9f-0691-485c-91f9-95b5fccf42bb",
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
    "id": "539bdc57-8b76-4c69-bec5-1f90c6e67dd2",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-12T08:48:32+00:00",
      "updated_at": "2022-07-12T08:48:32+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "65bd1a9c-6a3f-4ecc-89a0-986edfdef928"
          },
          {
            "type": "menu_items",
            "id": "72f1cfe1-fc52-4afe-91df-2bcf023a4b09"
          },
          {
            "type": "menu_items",
            "id": "1b6d5b9f-0691-485c-91f9-95b5fccf42bb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "65bd1a9c-6a3f-4ecc-89a0-986edfdef928",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-12T08:48:32+00:00",
        "updated_at": "2022-07-12T08:48:32+00:00",
        "menu_id": "539bdc57-8b76-4c69-bec5-1f90c6e67dd2",
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
      "id": "72f1cfe1-fc52-4afe-91df-2bcf023a4b09",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-12T08:48:32+00:00",
        "updated_at": "2022-07-12T08:48:32+00:00",
        "menu_id": "539bdc57-8b76-4c69-bec5-1f90c6e67dd2",
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
      "id": "1b6d5b9f-0691-485c-91f9-95b5fccf42bb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-12T08:48:32+00:00",
        "updated_at": "2022-07-12T08:48:32+00:00",
        "menu_id": "539bdc57-8b76-4c69-bec5-1f90c6e67dd2",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/bca55aa0-d6a3-432d-a442-545dbded0963' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes