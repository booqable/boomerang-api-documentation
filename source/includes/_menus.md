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
      "id": "012ef459-cd8b-4a3a-9e76-26fa364ebd17",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-05T13:03:42+00:00",
        "updated_at": "2023-01-05T13:03:42+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=012ef459-cd8b-4a3a-9e76-26fa364ebd17"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:01:30Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/2d83b60d-cbff-4dc2-9bff-d2765a32f61e?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2d83b60d-cbff-4dc2-9bff-d2765a32f61e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T13:03:42+00:00",
      "updated_at": "2023-01-05T13:03:42+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=2d83b60d-cbff-4dc2-9bff-d2765a32f61e"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "571c9d92-4e07-478f-aade-a56596aae28a"
          },
          {
            "type": "menu_items",
            "id": "8e667439-ad25-44e9-bef2-fabbdacea311"
          },
          {
            "type": "menu_items",
            "id": "c268e0c9-7674-41aa-97a7-28ab6254b166"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "571c9d92-4e07-478f-aade-a56596aae28a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T13:03:42+00:00",
        "updated_at": "2023-01-05T13:03:42+00:00",
        "menu_id": "2d83b60d-cbff-4dc2-9bff-d2765a32f61e",
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
            "related": "api/boomerang/menus/2d83b60d-cbff-4dc2-9bff-d2765a32f61e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=571c9d92-4e07-478f-aade-a56596aae28a"
          }
        }
      }
    },
    {
      "id": "8e667439-ad25-44e9-bef2-fabbdacea311",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T13:03:42+00:00",
        "updated_at": "2023-01-05T13:03:42+00:00",
        "menu_id": "2d83b60d-cbff-4dc2-9bff-d2765a32f61e",
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
            "related": "api/boomerang/menus/2d83b60d-cbff-4dc2-9bff-d2765a32f61e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8e667439-ad25-44e9-bef2-fabbdacea311"
          }
        }
      }
    },
    {
      "id": "c268e0c9-7674-41aa-97a7-28ab6254b166",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T13:03:43+00:00",
        "updated_at": "2023-01-05T13:03:43+00:00",
        "menu_id": "2d83b60d-cbff-4dc2-9bff-d2765a32f61e",
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
            "related": "api/boomerang/menus/2d83b60d-cbff-4dc2-9bff-d2765a32f61e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c268e0c9-7674-41aa-97a7-28ab6254b166"
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
    "id": "b93459fe-4daf-42a6-b6db-e6139aea5271",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T13:03:43+00:00",
      "updated_at": "2023-01-05T13:03:43+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/2397b7c4-4502-4cc4-9de8-efd0fa996434' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2397b7c4-4502-4cc4-9de8-efd0fa996434",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e93d07ea-8091-4ed4-b677-65785b881f71",
              "title": "Contact us"
            },
            {
              "id": "a179382f-999b-4b0e-8da4-1e78a55666af",
              "title": "Start"
            },
            {
              "id": "7779d61f-1e02-4a3c-b6a7-19a63064dd9c",
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
    "id": "2397b7c4-4502-4cc4-9de8-efd0fa996434",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T13:03:43+00:00",
      "updated_at": "2023-01-05T13:03:43+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e93d07ea-8091-4ed4-b677-65785b881f71"
          },
          {
            "type": "menu_items",
            "id": "a179382f-999b-4b0e-8da4-1e78a55666af"
          },
          {
            "type": "menu_items",
            "id": "7779d61f-1e02-4a3c-b6a7-19a63064dd9c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e93d07ea-8091-4ed4-b677-65785b881f71",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T13:03:43+00:00",
        "updated_at": "2023-01-05T13:03:43+00:00",
        "menu_id": "2397b7c4-4502-4cc4-9de8-efd0fa996434",
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
      "id": "a179382f-999b-4b0e-8da4-1e78a55666af",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T13:03:43+00:00",
        "updated_at": "2023-01-05T13:03:43+00:00",
        "menu_id": "2397b7c4-4502-4cc4-9de8-efd0fa996434",
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
      "id": "7779d61f-1e02-4a3c-b6a7-19a63064dd9c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T13:03:43+00:00",
        "updated_at": "2023-01-05T13:03:43+00:00",
        "menu_id": "2397b7c4-4502-4cc4-9de8-efd0fa996434",
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
    --url 'https://example.booqable.com/api/boomerang/menus/15a8c063-e0b2-405a-8c4c-a256a18f54a5' \
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