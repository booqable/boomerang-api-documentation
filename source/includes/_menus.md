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
      "id": "571226f5-94e1-4974-85cc-1add15c83ba2",
      "type": "menus",
      "attributes": {
        "created_at": "2022-12-09T08:13:48+00:00",
        "updated_at": "2022-12-09T08:13:48+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=571226f5-94e1-4974-85cc-1add15c83ba2"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-09T08:11:55Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/2eee3120-bf69-42b1-8736-ee568cb8df17?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2eee3120-bf69-42b1-8736-ee568cb8df17",
    "type": "menus",
    "attributes": {
      "created_at": "2022-12-09T08:13:48+00:00",
      "updated_at": "2022-12-09T08:13:48+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=2eee3120-bf69-42b1-8736-ee568cb8df17"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "f302ed19-018d-4892-b1a4-b6a202d04f06"
          },
          {
            "type": "menu_items",
            "id": "28c6b0d3-ee73-4d1e-a1e8-1016fc43de14"
          },
          {
            "type": "menu_items",
            "id": "0a1881e5-a9e1-428a-a5ec-8db9e8c0b332"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f302ed19-018d-4892-b1a4-b6a202d04f06",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-09T08:13:48+00:00",
        "updated_at": "2022-12-09T08:13:48+00:00",
        "menu_id": "2eee3120-bf69-42b1-8736-ee568cb8df17",
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
            "related": "api/boomerang/menus/2eee3120-bf69-42b1-8736-ee568cb8df17"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f302ed19-018d-4892-b1a4-b6a202d04f06"
          }
        }
      }
    },
    {
      "id": "28c6b0d3-ee73-4d1e-a1e8-1016fc43de14",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-09T08:13:48+00:00",
        "updated_at": "2022-12-09T08:13:48+00:00",
        "menu_id": "2eee3120-bf69-42b1-8736-ee568cb8df17",
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
            "related": "api/boomerang/menus/2eee3120-bf69-42b1-8736-ee568cb8df17"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=28c6b0d3-ee73-4d1e-a1e8-1016fc43de14"
          }
        }
      }
    },
    {
      "id": "0a1881e5-a9e1-428a-a5ec-8db9e8c0b332",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-09T08:13:48+00:00",
        "updated_at": "2022-12-09T08:13:48+00:00",
        "menu_id": "2eee3120-bf69-42b1-8736-ee568cb8df17",
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
            "related": "api/boomerang/menus/2eee3120-bf69-42b1-8736-ee568cb8df17"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0a1881e5-a9e1-428a-a5ec-8db9e8c0b332"
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
    "id": "50cc508e-9f49-40b6-855b-3f82e30344ac",
    "type": "menus",
    "attributes": {
      "created_at": "2022-12-09T08:13:49+00:00",
      "updated_at": "2022-12-09T08:13:49+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/dc865996-c704-4e1e-b880-0fac8f4d3696' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dc865996-c704-4e1e-b880-0fac8f4d3696",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "3e90e85a-7047-4049-9471-4ee48261cdc2",
              "title": "Contact us"
            },
            {
              "id": "92726b7b-c9f2-4076-8f88-39b53361f401",
              "title": "Start"
            },
            {
              "id": "9f1cfc29-4a6c-4ca6-8e91-1a2ce7b5b1db",
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
    "id": "dc865996-c704-4e1e-b880-0fac8f4d3696",
    "type": "menus",
    "attributes": {
      "created_at": "2022-12-09T08:13:49+00:00",
      "updated_at": "2022-12-09T08:13:49+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "3e90e85a-7047-4049-9471-4ee48261cdc2"
          },
          {
            "type": "menu_items",
            "id": "92726b7b-c9f2-4076-8f88-39b53361f401"
          },
          {
            "type": "menu_items",
            "id": "9f1cfc29-4a6c-4ca6-8e91-1a2ce7b5b1db"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3e90e85a-7047-4049-9471-4ee48261cdc2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-09T08:13:49+00:00",
        "updated_at": "2022-12-09T08:13:49+00:00",
        "menu_id": "dc865996-c704-4e1e-b880-0fac8f4d3696",
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
      "id": "92726b7b-c9f2-4076-8f88-39b53361f401",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-09T08:13:49+00:00",
        "updated_at": "2022-12-09T08:13:49+00:00",
        "menu_id": "dc865996-c704-4e1e-b880-0fac8f4d3696",
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
      "id": "9f1cfc29-4a6c-4ca6-8e91-1a2ce7b5b1db",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-09T08:13:49+00:00",
        "updated_at": "2022-12-09T08:13:49+00:00",
        "menu_id": "dc865996-c704-4e1e-b880-0fac8f4d3696",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5e545c07-07bd-4be1-82c6-5cd224435a81' \
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