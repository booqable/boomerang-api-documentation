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
      "id": "e7245630-4a0c-4158-b956-d857e22fd6af",
      "type": "menus",
      "attributes": {
        "created_at": "2022-09-30T11:58:57+00:00",
        "updated_at": "2022-09-30T11:58:57+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=e7245630-4a0c-4158-b956-d857e22fd6af"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-30T11:57:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/b5460fa5-594f-494c-87d1-5c0335aff759?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b5460fa5-594f-494c-87d1-5c0335aff759",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-30T11:58:58+00:00",
      "updated_at": "2022-09-30T11:58:58+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b5460fa5-594f-494c-87d1-5c0335aff759"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "b3cbdfed-f400-4cda-be82-0edfc523f81c"
          },
          {
            "type": "menu_items",
            "id": "cd032af2-a198-4a64-8cb8-c4f4ac51ee24"
          },
          {
            "type": "menu_items",
            "id": "f1fac8b1-7fd7-4fee-96b4-aac18d7e2da2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b3cbdfed-f400-4cda-be82-0edfc523f81c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-30T11:58:58+00:00",
        "updated_at": "2022-09-30T11:58:58+00:00",
        "menu_id": "b5460fa5-594f-494c-87d1-5c0335aff759",
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
            "related": "api/boomerang/menus/b5460fa5-594f-494c-87d1-5c0335aff759"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b3cbdfed-f400-4cda-be82-0edfc523f81c"
          }
        }
      }
    },
    {
      "id": "cd032af2-a198-4a64-8cb8-c4f4ac51ee24",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-30T11:58:58+00:00",
        "updated_at": "2022-09-30T11:58:58+00:00",
        "menu_id": "b5460fa5-594f-494c-87d1-5c0335aff759",
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
            "related": "api/boomerang/menus/b5460fa5-594f-494c-87d1-5c0335aff759"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cd032af2-a198-4a64-8cb8-c4f4ac51ee24"
          }
        }
      }
    },
    {
      "id": "f1fac8b1-7fd7-4fee-96b4-aac18d7e2da2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-30T11:58:58+00:00",
        "updated_at": "2022-09-30T11:58:58+00:00",
        "menu_id": "b5460fa5-594f-494c-87d1-5c0335aff759",
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
            "related": "api/boomerang/menus/b5460fa5-594f-494c-87d1-5c0335aff759"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f1fac8b1-7fd7-4fee-96b4-aac18d7e2da2"
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
    "id": "1e89ad53-225f-461c-807c-da1f5a8d30a7",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-30T11:58:58+00:00",
      "updated_at": "2022-09-30T11:58:58+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/35cf9d5a-6ec3-4e55-8631-70d262910aea' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "35cf9d5a-6ec3-4e55-8631-70d262910aea",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "c742d3b3-4653-4e05-8bcb-94deefa116d1",
              "title": "Contact us"
            },
            {
              "id": "0e94618b-77ad-4e8b-980f-260948b1d7ec",
              "title": "Start"
            },
            {
              "id": "95f36b8b-908b-437d-ae9a-28e5b0b924db",
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
    "id": "35cf9d5a-6ec3-4e55-8631-70d262910aea",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-30T11:58:59+00:00",
      "updated_at": "2022-09-30T11:58:59+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "c742d3b3-4653-4e05-8bcb-94deefa116d1"
          },
          {
            "type": "menu_items",
            "id": "0e94618b-77ad-4e8b-980f-260948b1d7ec"
          },
          {
            "type": "menu_items",
            "id": "95f36b8b-908b-437d-ae9a-28e5b0b924db"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c742d3b3-4653-4e05-8bcb-94deefa116d1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-30T11:58:59+00:00",
        "updated_at": "2022-09-30T11:58:59+00:00",
        "menu_id": "35cf9d5a-6ec3-4e55-8631-70d262910aea",
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
      "id": "0e94618b-77ad-4e8b-980f-260948b1d7ec",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-30T11:58:59+00:00",
        "updated_at": "2022-09-30T11:58:59+00:00",
        "menu_id": "35cf9d5a-6ec3-4e55-8631-70d262910aea",
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
      "id": "95f36b8b-908b-437d-ae9a-28e5b0b924db",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-30T11:58:59+00:00",
        "updated_at": "2022-09-30T11:58:59+00:00",
        "menu_id": "35cf9d5a-6ec3-4e55-8631-70d262910aea",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1450f659-05af-4c32-9720-d0c80f35cb99' \
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