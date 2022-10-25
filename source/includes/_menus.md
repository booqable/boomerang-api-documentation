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
      "id": "f2afb009-fb7c-48e7-8854-b7c942cff80a",
      "type": "menus",
      "attributes": {
        "created_at": "2022-10-25T18:50:05+00:00",
        "updated_at": "2022-10-25T18:50:05+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=f2afb009-fb7c-48e7-8854-b7c942cff80a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T18:48:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/b9210b11-34c0-4610-9b1b-cbc4e36af0df?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b9210b11-34c0-4610-9b1b-cbc4e36af0df",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-25T18:50:06+00:00",
      "updated_at": "2022-10-25T18:50:06+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b9210b11-34c0-4610-9b1b-cbc4e36af0df"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "8f296ca0-f725-443e-85bf-506b9db2e8a5"
          },
          {
            "type": "menu_items",
            "id": "ac2491a9-3c7f-4a56-a07f-68ab48ad50c2"
          },
          {
            "type": "menu_items",
            "id": "14a68f27-fe6e-470d-a23d-32eb5a5d88e8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8f296ca0-f725-443e-85bf-506b9db2e8a5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T18:50:06+00:00",
        "updated_at": "2022-10-25T18:50:06+00:00",
        "menu_id": "b9210b11-34c0-4610-9b1b-cbc4e36af0df",
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
            "related": "api/boomerang/menus/b9210b11-34c0-4610-9b1b-cbc4e36af0df"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8f296ca0-f725-443e-85bf-506b9db2e8a5"
          }
        }
      }
    },
    {
      "id": "ac2491a9-3c7f-4a56-a07f-68ab48ad50c2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T18:50:06+00:00",
        "updated_at": "2022-10-25T18:50:06+00:00",
        "menu_id": "b9210b11-34c0-4610-9b1b-cbc4e36af0df",
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
            "related": "api/boomerang/menus/b9210b11-34c0-4610-9b1b-cbc4e36af0df"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ac2491a9-3c7f-4a56-a07f-68ab48ad50c2"
          }
        }
      }
    },
    {
      "id": "14a68f27-fe6e-470d-a23d-32eb5a5d88e8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T18:50:06+00:00",
        "updated_at": "2022-10-25T18:50:06+00:00",
        "menu_id": "b9210b11-34c0-4610-9b1b-cbc4e36af0df",
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
            "related": "api/boomerang/menus/b9210b11-34c0-4610-9b1b-cbc4e36af0df"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=14a68f27-fe6e-470d-a23d-32eb5a5d88e8"
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
    "id": "2d5a75fd-93b2-4f45-a7bc-5582cb49e212",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-25T18:50:06+00:00",
      "updated_at": "2022-10-25T18:50:06+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d857a267-5465-4433-8183-dce24667abaf' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d857a267-5465-4433-8183-dce24667abaf",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "ecea25eb-761d-4145-8b42-4e47ddca1a52",
              "title": "Contact us"
            },
            {
              "id": "f700a50c-72a8-4970-ac90-5c63c6f28f77",
              "title": "Start"
            },
            {
              "id": "e2b2a3d1-d6e6-4c4e-9678-3a528be8aedd",
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
    "id": "d857a267-5465-4433-8183-dce24667abaf",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-25T18:50:07+00:00",
      "updated_at": "2022-10-25T18:50:07+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "ecea25eb-761d-4145-8b42-4e47ddca1a52"
          },
          {
            "type": "menu_items",
            "id": "f700a50c-72a8-4970-ac90-5c63c6f28f77"
          },
          {
            "type": "menu_items",
            "id": "e2b2a3d1-d6e6-4c4e-9678-3a528be8aedd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ecea25eb-761d-4145-8b42-4e47ddca1a52",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T18:50:07+00:00",
        "updated_at": "2022-10-25T18:50:07+00:00",
        "menu_id": "d857a267-5465-4433-8183-dce24667abaf",
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
      "id": "f700a50c-72a8-4970-ac90-5c63c6f28f77",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T18:50:07+00:00",
        "updated_at": "2022-10-25T18:50:07+00:00",
        "menu_id": "d857a267-5465-4433-8183-dce24667abaf",
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
      "id": "e2b2a3d1-d6e6-4c4e-9678-3a528be8aedd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T18:50:07+00:00",
        "updated_at": "2022-10-25T18:50:07+00:00",
        "menu_id": "d857a267-5465-4433-8183-dce24667abaf",
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
    --url 'https://example.booqable.com/api/boomerang/menus/77b1b923-fc9e-4094-a0d8-95adc67295a0' \
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