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
      "id": "a9805864-e643-42f3-8fca-285463d24923",
      "type": "menus",
      "attributes": {
        "created_at": "2022-09-16T12:13:07+00:00",
        "updated_at": "2022-09-16T12:13:07+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=a9805864-e643-42f3-8fca-285463d24923"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T12:11:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/257be8eb-e439-4433-927f-e2adfa05dc76?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "257be8eb-e439-4433-927f-e2adfa05dc76",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-16T12:13:07+00:00",
      "updated_at": "2022-09-16T12:13:07+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=257be8eb-e439-4433-927f-e2adfa05dc76"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "da04a62c-fc84-4b02-80a2-3382fcadf0a8"
          },
          {
            "type": "menu_items",
            "id": "1585eb0e-984d-4908-aaa5-da9b30d731ec"
          },
          {
            "type": "menu_items",
            "id": "edb4c938-e45e-4922-af38-53640c1dcebb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "da04a62c-fc84-4b02-80a2-3382fcadf0a8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T12:13:07+00:00",
        "updated_at": "2022-09-16T12:13:07+00:00",
        "menu_id": "257be8eb-e439-4433-927f-e2adfa05dc76",
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
            "related": "api/boomerang/menus/257be8eb-e439-4433-927f-e2adfa05dc76"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=da04a62c-fc84-4b02-80a2-3382fcadf0a8"
          }
        }
      }
    },
    {
      "id": "1585eb0e-984d-4908-aaa5-da9b30d731ec",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T12:13:07+00:00",
        "updated_at": "2022-09-16T12:13:07+00:00",
        "menu_id": "257be8eb-e439-4433-927f-e2adfa05dc76",
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
            "related": "api/boomerang/menus/257be8eb-e439-4433-927f-e2adfa05dc76"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1585eb0e-984d-4908-aaa5-da9b30d731ec"
          }
        }
      }
    },
    {
      "id": "edb4c938-e45e-4922-af38-53640c1dcebb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T12:13:07+00:00",
        "updated_at": "2022-09-16T12:13:07+00:00",
        "menu_id": "257be8eb-e439-4433-927f-e2adfa05dc76",
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
            "related": "api/boomerang/menus/257be8eb-e439-4433-927f-e2adfa05dc76"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=edb4c938-e45e-4922-af38-53640c1dcebb"
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
    "id": "cee91eeb-8ffb-4688-9215-a697e29086bf",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-16T12:13:08+00:00",
      "updated_at": "2022-09-16T12:13:08+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b3f64176-74f0-4eb0-9503-738a3290042a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b3f64176-74f0-4eb0-9503-738a3290042a",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "8c37755b-a516-4633-addc-6d1f595a2981",
              "title": "Contact us"
            },
            {
              "id": "39d8c263-bd08-4999-835a-3bbc916bbadc",
              "title": "Start"
            },
            {
              "id": "0f818f1c-6764-433b-aab1-05d36272d090",
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
    "id": "b3f64176-74f0-4eb0-9503-738a3290042a",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-16T12:13:08+00:00",
      "updated_at": "2022-09-16T12:13:08+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "8c37755b-a516-4633-addc-6d1f595a2981"
          },
          {
            "type": "menu_items",
            "id": "39d8c263-bd08-4999-835a-3bbc916bbadc"
          },
          {
            "type": "menu_items",
            "id": "0f818f1c-6764-433b-aab1-05d36272d090"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8c37755b-a516-4633-addc-6d1f595a2981",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T12:13:08+00:00",
        "updated_at": "2022-09-16T12:13:08+00:00",
        "menu_id": "b3f64176-74f0-4eb0-9503-738a3290042a",
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
      "id": "39d8c263-bd08-4999-835a-3bbc916bbadc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T12:13:08+00:00",
        "updated_at": "2022-09-16T12:13:08+00:00",
        "menu_id": "b3f64176-74f0-4eb0-9503-738a3290042a",
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
      "id": "0f818f1c-6764-433b-aab1-05d36272d090",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T12:13:08+00:00",
        "updated_at": "2022-09-16T12:13:08+00:00",
        "menu_id": "b3f64176-74f0-4eb0-9503-738a3290042a",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6653c89c-70d4-48df-91de-96429f0baa2d' \
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