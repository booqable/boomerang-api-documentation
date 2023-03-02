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
      "id": "b4b5904e-eaf8-4f12-b49f-534eced1e2eb",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-02T13:56:12+00:00",
        "updated_at": "2023-03-02T13:56:12+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=b4b5904e-eaf8-4f12-b49f-534eced1e2eb"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T13:53:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/d6abc0df-14b3-4859-befd-2b672f19958a?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d6abc0df-14b3-4859-befd-2b672f19958a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-02T13:56:12+00:00",
      "updated_at": "2023-03-02T13:56:12+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=d6abc0df-14b3-4859-befd-2b672f19958a"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "9d1ffbb7-af03-478f-8aad-6ddf12b7b409"
          },
          {
            "type": "menu_items",
            "id": "446a81cd-b60a-4a98-a10b-82e110c7be70"
          },
          {
            "type": "menu_items",
            "id": "80e076d8-4c2d-43f6-a5fb-bd0e8d861825"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9d1ffbb7-af03-478f-8aad-6ddf12b7b409",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T13:56:12+00:00",
        "updated_at": "2023-03-02T13:56:12+00:00",
        "menu_id": "d6abc0df-14b3-4859-befd-2b672f19958a",
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
            "related": "api/boomerang/menus/d6abc0df-14b3-4859-befd-2b672f19958a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9d1ffbb7-af03-478f-8aad-6ddf12b7b409"
          }
        }
      }
    },
    {
      "id": "446a81cd-b60a-4a98-a10b-82e110c7be70",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T13:56:12+00:00",
        "updated_at": "2023-03-02T13:56:12+00:00",
        "menu_id": "d6abc0df-14b3-4859-befd-2b672f19958a",
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
            "related": "api/boomerang/menus/d6abc0df-14b3-4859-befd-2b672f19958a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=446a81cd-b60a-4a98-a10b-82e110c7be70"
          }
        }
      }
    },
    {
      "id": "80e076d8-4c2d-43f6-a5fb-bd0e8d861825",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T13:56:12+00:00",
        "updated_at": "2023-03-02T13:56:12+00:00",
        "menu_id": "d6abc0df-14b3-4859-befd-2b672f19958a",
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
            "related": "api/boomerang/menus/d6abc0df-14b3-4859-befd-2b672f19958a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=80e076d8-4c2d-43f6-a5fb-bd0e8d861825"
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
    "id": "992ed4eb-cd1c-4e53-85ef-61ef4099c2b5",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-02T13:56:13+00:00",
      "updated_at": "2023-03-02T13:56:13+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/298e005f-b596-421a-9108-7186c5c9a361' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "298e005f-b596-421a-9108-7186c5c9a361",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "b7d33c09-8008-4b1f-8526-e1ba396ebe90",
              "title": "Contact us"
            },
            {
              "id": "163e87ec-5502-4dc5-b447-0fec89659623",
              "title": "Start"
            },
            {
              "id": "fade59ca-6306-4e23-9328-d2fa856b1cde",
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
    "id": "298e005f-b596-421a-9108-7186c5c9a361",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-02T13:56:13+00:00",
      "updated_at": "2023-03-02T13:56:13+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "b7d33c09-8008-4b1f-8526-e1ba396ebe90"
          },
          {
            "type": "menu_items",
            "id": "163e87ec-5502-4dc5-b447-0fec89659623"
          },
          {
            "type": "menu_items",
            "id": "fade59ca-6306-4e23-9328-d2fa856b1cde"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b7d33c09-8008-4b1f-8526-e1ba396ebe90",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T13:56:13+00:00",
        "updated_at": "2023-03-02T13:56:13+00:00",
        "menu_id": "298e005f-b596-421a-9108-7186c5c9a361",
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
      "id": "163e87ec-5502-4dc5-b447-0fec89659623",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T13:56:13+00:00",
        "updated_at": "2023-03-02T13:56:13+00:00",
        "menu_id": "298e005f-b596-421a-9108-7186c5c9a361",
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
      "id": "fade59ca-6306-4e23-9328-d2fa856b1cde",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T13:56:13+00:00",
        "updated_at": "2023-03-02T13:56:13+00:00",
        "menu_id": "298e005f-b596-421a-9108-7186c5c9a361",
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
    --url 'https://example.booqable.com/api/boomerang/menus/421c66f2-2cc8-4783-8738-e2776a33eabd' \
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