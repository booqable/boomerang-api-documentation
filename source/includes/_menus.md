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
      "id": "11d21a00-5249-4f90-944c-6ffa1bc267c7",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-06T18:58:25+00:00",
        "updated_at": "2023-02-06T18:58:25+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=11d21a00-5249-4f90-944c-6ffa1bc267c7"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T18:56:36Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/c8bc3ceb-8e43-4703-88ca-d78dff496f45?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c8bc3ceb-8e43-4703-88ca-d78dff496f45",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-06T18:58:26+00:00",
      "updated_at": "2023-02-06T18:58:26+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=c8bc3ceb-8e43-4703-88ca-d78dff496f45"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ab528250-1aa3-4cfc-b674-a92316ce97ff"
          },
          {
            "type": "menu_items",
            "id": "a9a8188b-e605-4558-b2f0-11a6b5ac2ebc"
          },
          {
            "type": "menu_items",
            "id": "73e77615-5a67-4c28-8e2d-7921446f070c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ab528250-1aa3-4cfc-b674-a92316ce97ff",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T18:58:26+00:00",
        "updated_at": "2023-02-06T18:58:26+00:00",
        "menu_id": "c8bc3ceb-8e43-4703-88ca-d78dff496f45",
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
            "related": "api/boomerang/menus/c8bc3ceb-8e43-4703-88ca-d78dff496f45"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ab528250-1aa3-4cfc-b674-a92316ce97ff"
          }
        }
      }
    },
    {
      "id": "a9a8188b-e605-4558-b2f0-11a6b5ac2ebc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T18:58:26+00:00",
        "updated_at": "2023-02-06T18:58:26+00:00",
        "menu_id": "c8bc3ceb-8e43-4703-88ca-d78dff496f45",
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
            "related": "api/boomerang/menus/c8bc3ceb-8e43-4703-88ca-d78dff496f45"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a9a8188b-e605-4558-b2f0-11a6b5ac2ebc"
          }
        }
      }
    },
    {
      "id": "73e77615-5a67-4c28-8e2d-7921446f070c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T18:58:26+00:00",
        "updated_at": "2023-02-06T18:58:26+00:00",
        "menu_id": "c8bc3ceb-8e43-4703-88ca-d78dff496f45",
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
            "related": "api/boomerang/menus/c8bc3ceb-8e43-4703-88ca-d78dff496f45"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=73e77615-5a67-4c28-8e2d-7921446f070c"
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
    "id": "7ab6222f-a223-4454-972a-5e3e0b2622e2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-06T18:58:26+00:00",
      "updated_at": "2023-02-06T18:58:26+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d74e88fe-2664-4880-93fe-746d9d51920d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d74e88fe-2664-4880-93fe-746d9d51920d",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "51f1ead7-ec02-4a48-97d4-8472c60bfff0",
              "title": "Contact us"
            },
            {
              "id": "038e6c84-6385-4015-9c69-ae7db2314768",
              "title": "Start"
            },
            {
              "id": "a8d9dc23-cfa4-4cb2-8f38-68178ef7a077",
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
    "id": "d74e88fe-2664-4880-93fe-746d9d51920d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-06T18:58:26+00:00",
      "updated_at": "2023-02-06T18:58:26+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "51f1ead7-ec02-4a48-97d4-8472c60bfff0"
          },
          {
            "type": "menu_items",
            "id": "038e6c84-6385-4015-9c69-ae7db2314768"
          },
          {
            "type": "menu_items",
            "id": "a8d9dc23-cfa4-4cb2-8f38-68178ef7a077"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "51f1ead7-ec02-4a48-97d4-8472c60bfff0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T18:58:26+00:00",
        "updated_at": "2023-02-06T18:58:26+00:00",
        "menu_id": "d74e88fe-2664-4880-93fe-746d9d51920d",
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
      "id": "038e6c84-6385-4015-9c69-ae7db2314768",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T18:58:26+00:00",
        "updated_at": "2023-02-06T18:58:26+00:00",
        "menu_id": "d74e88fe-2664-4880-93fe-746d9d51920d",
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
      "id": "a8d9dc23-cfa4-4cb2-8f38-68178ef7a077",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T18:58:26+00:00",
        "updated_at": "2023-02-06T18:58:26+00:00",
        "menu_id": "d74e88fe-2664-4880-93fe-746d9d51920d",
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
    --url 'https://example.booqable.com/api/boomerang/menus/708da669-c71d-4bd6-a6a8-bd50c97bea57' \
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