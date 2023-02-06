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
      "id": "c99f9c34-8c65-44f1-b176-5f3873c19924",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-06T19:29:59+00:00",
        "updated_at": "2023-02-06T19:29:59+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=c99f9c34-8c65-44f1-b176-5f3873c19924"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T19:28:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/ce58e289-ae82-460f-a4d8-5f2846768d49?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ce58e289-ae82-460f-a4d8-5f2846768d49",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-06T19:30:01+00:00",
      "updated_at": "2023-02-06T19:30:01+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=ce58e289-ae82-460f-a4d8-5f2846768d49"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "112cec5c-e396-4d6e-85e4-6fc92612bea8"
          },
          {
            "type": "menu_items",
            "id": "e3b72baf-e2ad-42e8-8231-4a088c87aba8"
          },
          {
            "type": "menu_items",
            "id": "4df4951d-1595-4987-bef8-27c1a8c13033"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "112cec5c-e396-4d6e-85e4-6fc92612bea8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T19:30:01+00:00",
        "updated_at": "2023-02-06T19:30:01+00:00",
        "menu_id": "ce58e289-ae82-460f-a4d8-5f2846768d49",
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
            "related": "api/boomerang/menus/ce58e289-ae82-460f-a4d8-5f2846768d49"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=112cec5c-e396-4d6e-85e4-6fc92612bea8"
          }
        }
      }
    },
    {
      "id": "e3b72baf-e2ad-42e8-8231-4a088c87aba8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T19:30:01+00:00",
        "updated_at": "2023-02-06T19:30:01+00:00",
        "menu_id": "ce58e289-ae82-460f-a4d8-5f2846768d49",
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
            "related": "api/boomerang/menus/ce58e289-ae82-460f-a4d8-5f2846768d49"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e3b72baf-e2ad-42e8-8231-4a088c87aba8"
          }
        }
      }
    },
    {
      "id": "4df4951d-1595-4987-bef8-27c1a8c13033",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T19:30:01+00:00",
        "updated_at": "2023-02-06T19:30:01+00:00",
        "menu_id": "ce58e289-ae82-460f-a4d8-5f2846768d49",
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
            "related": "api/boomerang/menus/ce58e289-ae82-460f-a4d8-5f2846768d49"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4df4951d-1595-4987-bef8-27c1a8c13033"
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
    "id": "f3673353-4edb-40cc-91ae-662351ac8ca4",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-06T19:30:02+00:00",
      "updated_at": "2023-02-06T19:30:02+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fd955f05-7934-433d-aa40-7bbec089ce42' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fd955f05-7934-433d-aa40-7bbec089ce42",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "0dffc6c8-4a66-4276-8ec7-8a65dc7fe1c3",
              "title": "Contact us"
            },
            {
              "id": "cd72bdc7-c7c2-4c25-960b-27c2a2b29be8",
              "title": "Start"
            },
            {
              "id": "498c6565-6663-4d02-a742-e705faf5e214",
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
    "id": "fd955f05-7934-433d-aa40-7bbec089ce42",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-06T19:30:02+00:00",
      "updated_at": "2023-02-06T19:30:02+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "0dffc6c8-4a66-4276-8ec7-8a65dc7fe1c3"
          },
          {
            "type": "menu_items",
            "id": "cd72bdc7-c7c2-4c25-960b-27c2a2b29be8"
          },
          {
            "type": "menu_items",
            "id": "498c6565-6663-4d02-a742-e705faf5e214"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0dffc6c8-4a66-4276-8ec7-8a65dc7fe1c3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T19:30:02+00:00",
        "updated_at": "2023-02-06T19:30:02+00:00",
        "menu_id": "fd955f05-7934-433d-aa40-7bbec089ce42",
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
      "id": "cd72bdc7-c7c2-4c25-960b-27c2a2b29be8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T19:30:02+00:00",
        "updated_at": "2023-02-06T19:30:02+00:00",
        "menu_id": "fd955f05-7934-433d-aa40-7bbec089ce42",
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
      "id": "498c6565-6663-4d02-a742-e705faf5e214",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T19:30:02+00:00",
        "updated_at": "2023-02-06T19:30:02+00:00",
        "menu_id": "fd955f05-7934-433d-aa40-7bbec089ce42",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c31881db-a37b-4878-bbb4-47e82afbbf97' \
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