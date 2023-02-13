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
      "id": "85608bc1-3a97-40c5-9b31-0f96f95b3866",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-13T12:14:56+00:00",
        "updated_at": "2023-02-13T12:14:56+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=85608bc1-3a97-40c5-9b31-0f96f95b3866"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:13:06Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/85e47a69-7c2d-4f8d-b100-4b27d69fb629?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "85e47a69-7c2d-4f8d-b100-4b27d69fb629",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T12:14:57+00:00",
      "updated_at": "2023-02-13T12:14:57+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=85e47a69-7c2d-4f8d-b100-4b27d69fb629"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "974ee8d4-cccc-4fc4-9057-6c901042edc0"
          },
          {
            "type": "menu_items",
            "id": "d2ab932a-ebc3-428d-8d63-8b5db527eae5"
          },
          {
            "type": "menu_items",
            "id": "570b21fa-9c54-4093-81cb-0a44bdbea962"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "974ee8d4-cccc-4fc4-9057-6c901042edc0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:14:57+00:00",
        "updated_at": "2023-02-13T12:14:57+00:00",
        "menu_id": "85e47a69-7c2d-4f8d-b100-4b27d69fb629",
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
            "related": "api/boomerang/menus/85e47a69-7c2d-4f8d-b100-4b27d69fb629"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=974ee8d4-cccc-4fc4-9057-6c901042edc0"
          }
        }
      }
    },
    {
      "id": "d2ab932a-ebc3-428d-8d63-8b5db527eae5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:14:57+00:00",
        "updated_at": "2023-02-13T12:14:57+00:00",
        "menu_id": "85e47a69-7c2d-4f8d-b100-4b27d69fb629",
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
            "related": "api/boomerang/menus/85e47a69-7c2d-4f8d-b100-4b27d69fb629"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d2ab932a-ebc3-428d-8d63-8b5db527eae5"
          }
        }
      }
    },
    {
      "id": "570b21fa-9c54-4093-81cb-0a44bdbea962",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:14:57+00:00",
        "updated_at": "2023-02-13T12:14:57+00:00",
        "menu_id": "85e47a69-7c2d-4f8d-b100-4b27d69fb629",
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
            "related": "api/boomerang/menus/85e47a69-7c2d-4f8d-b100-4b27d69fb629"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=570b21fa-9c54-4093-81cb-0a44bdbea962"
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
    "id": "a40eb179-0127-438d-a36f-01918d5e40d4",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T12:14:57+00:00",
      "updated_at": "2023-02-13T12:14:57+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d8f7e613-9e5d-41b9-963d-22fab8653e3d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d8f7e613-9e5d-41b9-963d-22fab8653e3d",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "f12f10cc-e509-4c8c-9600-a154ad5c707a",
              "title": "Contact us"
            },
            {
              "id": "c30501b0-4495-486f-b3d2-780613880521",
              "title": "Start"
            },
            {
              "id": "53cafba4-b980-44fa-ab7e-5c2178f25e6b",
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
    "id": "d8f7e613-9e5d-41b9-963d-22fab8653e3d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T12:14:58+00:00",
      "updated_at": "2023-02-13T12:14:58+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "f12f10cc-e509-4c8c-9600-a154ad5c707a"
          },
          {
            "type": "menu_items",
            "id": "c30501b0-4495-486f-b3d2-780613880521"
          },
          {
            "type": "menu_items",
            "id": "53cafba4-b980-44fa-ab7e-5c2178f25e6b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f12f10cc-e509-4c8c-9600-a154ad5c707a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:14:58+00:00",
        "updated_at": "2023-02-13T12:14:58+00:00",
        "menu_id": "d8f7e613-9e5d-41b9-963d-22fab8653e3d",
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
      "id": "c30501b0-4495-486f-b3d2-780613880521",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:14:58+00:00",
        "updated_at": "2023-02-13T12:14:58+00:00",
        "menu_id": "d8f7e613-9e5d-41b9-963d-22fab8653e3d",
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
      "id": "53cafba4-b980-44fa-ab7e-5c2178f25e6b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:14:58+00:00",
        "updated_at": "2023-02-13T12:14:58+00:00",
        "menu_id": "d8f7e613-9e5d-41b9-963d-22fab8653e3d",
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
    --url 'https://example.booqable.com/api/boomerang/menus/4a012da1-c9e8-4518-9d6a-8cf070f77f3d' \
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