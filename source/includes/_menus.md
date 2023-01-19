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
      "id": "3e21c5d1-bf23-4a07-bfcb-3b952a469877",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-19T10:29:06+00:00",
        "updated_at": "2023-01-19T10:29:06+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=3e21c5d1-bf23-4a07-bfcb-3b952a469877"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-19T10:27:22Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/07274abf-e016-4623-b99e-d8d2bb7efd1d?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "07274abf-e016-4623-b99e-d8d2bb7efd1d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-19T10:29:06+00:00",
      "updated_at": "2023-01-19T10:29:06+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=07274abf-e016-4623-b99e-d8d2bb7efd1d"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "30e4f532-14af-4d01-800c-15efb4276805"
          },
          {
            "type": "menu_items",
            "id": "936051cd-1539-4da7-9a79-4c46fef2e96c"
          },
          {
            "type": "menu_items",
            "id": "333337d8-7fff-4291-9c7c-e84d25bee7e0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "30e4f532-14af-4d01-800c-15efb4276805",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-19T10:29:06+00:00",
        "updated_at": "2023-01-19T10:29:06+00:00",
        "menu_id": "07274abf-e016-4623-b99e-d8d2bb7efd1d",
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
            "related": "api/boomerang/menus/07274abf-e016-4623-b99e-d8d2bb7efd1d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=30e4f532-14af-4d01-800c-15efb4276805"
          }
        }
      }
    },
    {
      "id": "936051cd-1539-4da7-9a79-4c46fef2e96c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-19T10:29:06+00:00",
        "updated_at": "2023-01-19T10:29:06+00:00",
        "menu_id": "07274abf-e016-4623-b99e-d8d2bb7efd1d",
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
            "related": "api/boomerang/menus/07274abf-e016-4623-b99e-d8d2bb7efd1d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=936051cd-1539-4da7-9a79-4c46fef2e96c"
          }
        }
      }
    },
    {
      "id": "333337d8-7fff-4291-9c7c-e84d25bee7e0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-19T10:29:06+00:00",
        "updated_at": "2023-01-19T10:29:06+00:00",
        "menu_id": "07274abf-e016-4623-b99e-d8d2bb7efd1d",
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
            "related": "api/boomerang/menus/07274abf-e016-4623-b99e-d8d2bb7efd1d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=333337d8-7fff-4291-9c7c-e84d25bee7e0"
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
    "id": "47253810-31ba-43c0-ab7c-2a121bdd61a2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-19T10:29:07+00:00",
      "updated_at": "2023-01-19T10:29:07+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f3635346-61f7-42d6-b851-0ea024b9267d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f3635346-61f7-42d6-b851-0ea024b9267d",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "26ab0f92-c3d6-4b44-bf57-a099d08ddcee",
              "title": "Contact us"
            },
            {
              "id": "269c10d6-c163-4034-b963-70751801abbb",
              "title": "Start"
            },
            {
              "id": "1fe15d30-9e31-4875-bf27-346955f0068e",
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
    "id": "f3635346-61f7-42d6-b851-0ea024b9267d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-19T10:29:07+00:00",
      "updated_at": "2023-01-19T10:29:07+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "26ab0f92-c3d6-4b44-bf57-a099d08ddcee"
          },
          {
            "type": "menu_items",
            "id": "269c10d6-c163-4034-b963-70751801abbb"
          },
          {
            "type": "menu_items",
            "id": "1fe15d30-9e31-4875-bf27-346955f0068e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "26ab0f92-c3d6-4b44-bf57-a099d08ddcee",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-19T10:29:07+00:00",
        "updated_at": "2023-01-19T10:29:07+00:00",
        "menu_id": "f3635346-61f7-42d6-b851-0ea024b9267d",
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
      "id": "269c10d6-c163-4034-b963-70751801abbb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-19T10:29:07+00:00",
        "updated_at": "2023-01-19T10:29:07+00:00",
        "menu_id": "f3635346-61f7-42d6-b851-0ea024b9267d",
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
      "id": "1fe15d30-9e31-4875-bf27-346955f0068e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-19T10:29:07+00:00",
        "updated_at": "2023-01-19T10:29:07+00:00",
        "menu_id": "f3635346-61f7-42d6-b851-0ea024b9267d",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b81d14d4-dd61-41d2-bb12-74917dd73385' \
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