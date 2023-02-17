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
      "id": "8346b2a9-955b-4d44-9fcf-cc7079e258f1",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-17T10:33:58+00:00",
        "updated_at": "2023-02-17T10:33:58+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=8346b2a9-955b-4d44-9fcf-cc7079e258f1"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-17T10:31:31Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/45d614ea-adc5-4c90-a6b7-802ae9ad3f31?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "45d614ea-adc5-4c90-a6b7-802ae9ad3f31",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-17T10:33:59+00:00",
      "updated_at": "2023-02-17T10:33:59+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=45d614ea-adc5-4c90-a6b7-802ae9ad3f31"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "cad5fb28-268e-4a7f-8ea7-c52b13e2172c"
          },
          {
            "type": "menu_items",
            "id": "20a37530-de50-47eb-900f-8fd69b1b9b0c"
          },
          {
            "type": "menu_items",
            "id": "781e93e8-0031-4c26-9e4c-82364e8ce7ce"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cad5fb28-268e-4a7f-8ea7-c52b13e2172c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-17T10:33:59+00:00",
        "updated_at": "2023-02-17T10:33:59+00:00",
        "menu_id": "45d614ea-adc5-4c90-a6b7-802ae9ad3f31",
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
            "related": "api/boomerang/menus/45d614ea-adc5-4c90-a6b7-802ae9ad3f31"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cad5fb28-268e-4a7f-8ea7-c52b13e2172c"
          }
        }
      }
    },
    {
      "id": "20a37530-de50-47eb-900f-8fd69b1b9b0c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-17T10:33:59+00:00",
        "updated_at": "2023-02-17T10:33:59+00:00",
        "menu_id": "45d614ea-adc5-4c90-a6b7-802ae9ad3f31",
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
            "related": "api/boomerang/menus/45d614ea-adc5-4c90-a6b7-802ae9ad3f31"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=20a37530-de50-47eb-900f-8fd69b1b9b0c"
          }
        }
      }
    },
    {
      "id": "781e93e8-0031-4c26-9e4c-82364e8ce7ce",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-17T10:33:59+00:00",
        "updated_at": "2023-02-17T10:33:59+00:00",
        "menu_id": "45d614ea-adc5-4c90-a6b7-802ae9ad3f31",
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
            "related": "api/boomerang/menus/45d614ea-adc5-4c90-a6b7-802ae9ad3f31"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=781e93e8-0031-4c26-9e4c-82364e8ce7ce"
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
    "id": "355d2d0b-d498-4bcb-bbfd-707ab67457fd",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-17T10:33:59+00:00",
      "updated_at": "2023-02-17T10:33:59+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/01706833-5b44-4d17-a091-cb768e397a68' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "01706833-5b44-4d17-a091-cb768e397a68",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "655329e5-f915-41ea-a914-35ddfa3e2ecc",
              "title": "Contact us"
            },
            {
              "id": "ec45cd2a-4ff0-4ab3-bf9a-42fa62c27d2f",
              "title": "Start"
            },
            {
              "id": "8f4fc817-439e-4acb-91af-cfe1289a0eb8",
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
    "id": "01706833-5b44-4d17-a091-cb768e397a68",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-17T10:33:59+00:00",
      "updated_at": "2023-02-17T10:34:00+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "655329e5-f915-41ea-a914-35ddfa3e2ecc"
          },
          {
            "type": "menu_items",
            "id": "ec45cd2a-4ff0-4ab3-bf9a-42fa62c27d2f"
          },
          {
            "type": "menu_items",
            "id": "8f4fc817-439e-4acb-91af-cfe1289a0eb8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "655329e5-f915-41ea-a914-35ddfa3e2ecc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-17T10:33:59+00:00",
        "updated_at": "2023-02-17T10:34:00+00:00",
        "menu_id": "01706833-5b44-4d17-a091-cb768e397a68",
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
      "id": "ec45cd2a-4ff0-4ab3-bf9a-42fa62c27d2f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-17T10:33:59+00:00",
        "updated_at": "2023-02-17T10:34:00+00:00",
        "menu_id": "01706833-5b44-4d17-a091-cb768e397a68",
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
      "id": "8f4fc817-439e-4acb-91af-cfe1289a0eb8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-17T10:33:59+00:00",
        "updated_at": "2023-02-17T10:34:00+00:00",
        "menu_id": "01706833-5b44-4d17-a091-cb768e397a68",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7543c00e-8938-4e0f-afb3-cabb7ba8a2ad' \
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