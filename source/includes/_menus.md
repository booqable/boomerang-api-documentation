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
      "id": "2f7ab01c-37da-41ee-998f-54307e49a603",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-08T15:00:10+00:00",
        "updated_at": "2023-02-08T15:00:10+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=2f7ab01c-37da-41ee-998f-54307e49a603"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T14:57:58Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/ee0698ca-b214-4c87-97a8-b3231d904ab8?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ee0698ca-b214-4c87-97a8-b3231d904ab8",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T15:00:10+00:00",
      "updated_at": "2023-02-08T15:00:10+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=ee0698ca-b214-4c87-97a8-b3231d904ab8"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "c611f282-e748-425c-806d-1ad8d9330db7"
          },
          {
            "type": "menu_items",
            "id": "2413be2d-2a8a-4859-864f-7b95faea6dc5"
          },
          {
            "type": "menu_items",
            "id": "00969bb3-db79-424d-8631-cdac85b6a0eb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c611f282-e748-425c-806d-1ad8d9330db7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T15:00:10+00:00",
        "updated_at": "2023-02-08T15:00:10+00:00",
        "menu_id": "ee0698ca-b214-4c87-97a8-b3231d904ab8",
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
            "related": "api/boomerang/menus/ee0698ca-b214-4c87-97a8-b3231d904ab8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c611f282-e748-425c-806d-1ad8d9330db7"
          }
        }
      }
    },
    {
      "id": "2413be2d-2a8a-4859-864f-7b95faea6dc5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T15:00:10+00:00",
        "updated_at": "2023-02-08T15:00:10+00:00",
        "menu_id": "ee0698ca-b214-4c87-97a8-b3231d904ab8",
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
            "related": "api/boomerang/menus/ee0698ca-b214-4c87-97a8-b3231d904ab8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2413be2d-2a8a-4859-864f-7b95faea6dc5"
          }
        }
      }
    },
    {
      "id": "00969bb3-db79-424d-8631-cdac85b6a0eb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T15:00:10+00:00",
        "updated_at": "2023-02-08T15:00:10+00:00",
        "menu_id": "ee0698ca-b214-4c87-97a8-b3231d904ab8",
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
            "related": "api/boomerang/menus/ee0698ca-b214-4c87-97a8-b3231d904ab8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=00969bb3-db79-424d-8631-cdac85b6a0eb"
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
    "id": "86387938-44af-464a-8c9c-97372b410695",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T15:00:11+00:00",
      "updated_at": "2023-02-08T15:00:11+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/37904f22-5714-4cb7-996a-50d29dea9795' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "37904f22-5714-4cb7-996a-50d29dea9795",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "39072644-2c1e-4af5-b535-59308abf7a05",
              "title": "Contact us"
            },
            {
              "id": "2c153f6c-697e-4252-9ed7-ae96a357a436",
              "title": "Start"
            },
            {
              "id": "0fe400e4-a8b2-417d-9da1-ef22c21545b5",
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
    "id": "37904f22-5714-4cb7-996a-50d29dea9795",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T15:00:11+00:00",
      "updated_at": "2023-02-08T15:00:11+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "39072644-2c1e-4af5-b535-59308abf7a05"
          },
          {
            "type": "menu_items",
            "id": "2c153f6c-697e-4252-9ed7-ae96a357a436"
          },
          {
            "type": "menu_items",
            "id": "0fe400e4-a8b2-417d-9da1-ef22c21545b5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "39072644-2c1e-4af5-b535-59308abf7a05",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T15:00:11+00:00",
        "updated_at": "2023-02-08T15:00:11+00:00",
        "menu_id": "37904f22-5714-4cb7-996a-50d29dea9795",
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
      "id": "2c153f6c-697e-4252-9ed7-ae96a357a436",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T15:00:11+00:00",
        "updated_at": "2023-02-08T15:00:11+00:00",
        "menu_id": "37904f22-5714-4cb7-996a-50d29dea9795",
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
      "id": "0fe400e4-a8b2-417d-9da1-ef22c21545b5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T15:00:11+00:00",
        "updated_at": "2023-02-08T15:00:11+00:00",
        "menu_id": "37904f22-5714-4cb7-996a-50d29dea9795",
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
    --url 'https://example.booqable.com/api/boomerang/menus/06ba5dd3-d83c-4516-bcdf-7b99e3a86868' \
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