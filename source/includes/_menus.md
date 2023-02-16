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
      "id": "a55a7f5d-8715-4abe-b6ef-23505a9261c1",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-16T08:13:17+00:00",
        "updated_at": "2023-02-16T08:13:17+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=a55a7f5d-8715-4abe-b6ef-23505a9261c1"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T08:11:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/eab01442-2f5b-4781-8c6c-ec84e0eefca2?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eab01442-2f5b-4781-8c6c-ec84e0eefca2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T08:13:17+00:00",
      "updated_at": "2023-02-16T08:13:17+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=eab01442-2f5b-4781-8c6c-ec84e0eefca2"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "f07985dd-e377-4d0e-aaa9-e52fdbfb86d7"
          },
          {
            "type": "menu_items",
            "id": "c5816571-e05c-4f79-ae11-a3f72d61216f"
          },
          {
            "type": "menu_items",
            "id": "ecb22c86-31a9-4e59-b4d8-80f908e1d86e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f07985dd-e377-4d0e-aaa9-e52fdbfb86d7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T08:13:17+00:00",
        "updated_at": "2023-02-16T08:13:17+00:00",
        "menu_id": "eab01442-2f5b-4781-8c6c-ec84e0eefca2",
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
            "related": "api/boomerang/menus/eab01442-2f5b-4781-8c6c-ec84e0eefca2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f07985dd-e377-4d0e-aaa9-e52fdbfb86d7"
          }
        }
      }
    },
    {
      "id": "c5816571-e05c-4f79-ae11-a3f72d61216f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T08:13:17+00:00",
        "updated_at": "2023-02-16T08:13:17+00:00",
        "menu_id": "eab01442-2f5b-4781-8c6c-ec84e0eefca2",
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
            "related": "api/boomerang/menus/eab01442-2f5b-4781-8c6c-ec84e0eefca2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c5816571-e05c-4f79-ae11-a3f72d61216f"
          }
        }
      }
    },
    {
      "id": "ecb22c86-31a9-4e59-b4d8-80f908e1d86e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T08:13:17+00:00",
        "updated_at": "2023-02-16T08:13:17+00:00",
        "menu_id": "eab01442-2f5b-4781-8c6c-ec84e0eefca2",
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
            "related": "api/boomerang/menus/eab01442-2f5b-4781-8c6c-ec84e0eefca2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ecb22c86-31a9-4e59-b4d8-80f908e1d86e"
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
    "id": "304e3f59-0228-4fae-881c-e0cb4398f59c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T08:13:17+00:00",
      "updated_at": "2023-02-16T08:13:17+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d8cbfe66-2b2e-47c2-953d-10dd195f4ae5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d8cbfe66-2b2e-47c2-953d-10dd195f4ae5",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "1ea39bb4-3518-4313-b0f6-bd01adbc6d85",
              "title": "Contact us"
            },
            {
              "id": "aec95b76-e312-4617-813d-f42067b04dcf",
              "title": "Start"
            },
            {
              "id": "b9b05875-3d21-427b-888a-2c33d2c58f6b",
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
    "id": "d8cbfe66-2b2e-47c2-953d-10dd195f4ae5",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T08:13:18+00:00",
      "updated_at": "2023-02-16T08:13:18+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "1ea39bb4-3518-4313-b0f6-bd01adbc6d85"
          },
          {
            "type": "menu_items",
            "id": "aec95b76-e312-4617-813d-f42067b04dcf"
          },
          {
            "type": "menu_items",
            "id": "b9b05875-3d21-427b-888a-2c33d2c58f6b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1ea39bb4-3518-4313-b0f6-bd01adbc6d85",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T08:13:18+00:00",
        "updated_at": "2023-02-16T08:13:18+00:00",
        "menu_id": "d8cbfe66-2b2e-47c2-953d-10dd195f4ae5",
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
      "id": "aec95b76-e312-4617-813d-f42067b04dcf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T08:13:18+00:00",
        "updated_at": "2023-02-16T08:13:18+00:00",
        "menu_id": "d8cbfe66-2b2e-47c2-953d-10dd195f4ae5",
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
      "id": "b9b05875-3d21-427b-888a-2c33d2c58f6b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T08:13:18+00:00",
        "updated_at": "2023-02-16T08:13:18+00:00",
        "menu_id": "d8cbfe66-2b2e-47c2-953d-10dd195f4ae5",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6dcfafea-afec-4d81-bb9d-a8979f84d074' \
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