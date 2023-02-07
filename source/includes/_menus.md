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
      "id": "f65a70b6-ad33-4a75-b3da-88793680b0ab",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-07T14:34:00+00:00",
        "updated_at": "2023-02-07T14:34:00+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=f65a70b6-ad33-4a75-b3da-88793680b0ab"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:31:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/3bc845d0-e8d1-498a-8434-e748862864d2?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3bc845d0-e8d1-498a-8434-e748862864d2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T14:34:01+00:00",
      "updated_at": "2023-02-07T14:34:01+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=3bc845d0-e8d1-498a-8434-e748862864d2"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "7f07d765-2526-42a3-8e58-d505ac7fffdd"
          },
          {
            "type": "menu_items",
            "id": "5b14bd72-028b-4aac-933b-8942b825cede"
          },
          {
            "type": "menu_items",
            "id": "c40d01a8-5b12-40f1-b874-553a420e58e3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7f07d765-2526-42a3-8e58-d505ac7fffdd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T14:34:01+00:00",
        "updated_at": "2023-02-07T14:34:01+00:00",
        "menu_id": "3bc845d0-e8d1-498a-8434-e748862864d2",
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
            "related": "api/boomerang/menus/3bc845d0-e8d1-498a-8434-e748862864d2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7f07d765-2526-42a3-8e58-d505ac7fffdd"
          }
        }
      }
    },
    {
      "id": "5b14bd72-028b-4aac-933b-8942b825cede",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T14:34:01+00:00",
        "updated_at": "2023-02-07T14:34:01+00:00",
        "menu_id": "3bc845d0-e8d1-498a-8434-e748862864d2",
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
            "related": "api/boomerang/menus/3bc845d0-e8d1-498a-8434-e748862864d2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5b14bd72-028b-4aac-933b-8942b825cede"
          }
        }
      }
    },
    {
      "id": "c40d01a8-5b12-40f1-b874-553a420e58e3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T14:34:01+00:00",
        "updated_at": "2023-02-07T14:34:01+00:00",
        "menu_id": "3bc845d0-e8d1-498a-8434-e748862864d2",
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
            "related": "api/boomerang/menus/3bc845d0-e8d1-498a-8434-e748862864d2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c40d01a8-5b12-40f1-b874-553a420e58e3"
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
    "id": "f9281c9e-b418-44df-99c5-3ad1d3630cde",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T14:34:01+00:00",
      "updated_at": "2023-02-07T14:34:01+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/35c9b60c-f8bd-43eb-860e-91ef1234da2c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "35c9b60c-f8bd-43eb-860e-91ef1234da2c",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "f2d02a77-0e8c-493d-a5db-0d3bebf057ae",
              "title": "Contact us"
            },
            {
              "id": "f1435ad1-5017-435a-b0c0-0774e2e71691",
              "title": "Start"
            },
            {
              "id": "804dd767-fe8a-4d05-95b1-66a1c0be3c85",
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
    "id": "35c9b60c-f8bd-43eb-860e-91ef1234da2c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T14:34:02+00:00",
      "updated_at": "2023-02-07T14:34:02+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "f2d02a77-0e8c-493d-a5db-0d3bebf057ae"
          },
          {
            "type": "menu_items",
            "id": "f1435ad1-5017-435a-b0c0-0774e2e71691"
          },
          {
            "type": "menu_items",
            "id": "804dd767-fe8a-4d05-95b1-66a1c0be3c85"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f2d02a77-0e8c-493d-a5db-0d3bebf057ae",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T14:34:02+00:00",
        "updated_at": "2023-02-07T14:34:02+00:00",
        "menu_id": "35c9b60c-f8bd-43eb-860e-91ef1234da2c",
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
      "id": "f1435ad1-5017-435a-b0c0-0774e2e71691",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T14:34:02+00:00",
        "updated_at": "2023-02-07T14:34:02+00:00",
        "menu_id": "35c9b60c-f8bd-43eb-860e-91ef1234da2c",
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
      "id": "804dd767-fe8a-4d05-95b1-66a1c0be3c85",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T14:34:02+00:00",
        "updated_at": "2023-02-07T14:34:02+00:00",
        "menu_id": "35c9b60c-f8bd-43eb-860e-91ef1234da2c",
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
    --url 'https://example.booqable.com/api/boomerang/menus/972a107e-edd0-44b4-8a59-256724b27d4e' \
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