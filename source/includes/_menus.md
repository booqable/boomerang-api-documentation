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
`title` | **String**<br>Name of the menu.
`key` | **String**<br>Key the menu can be referenced by.
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
      "id": "a87d52e4-0f0f-4d28-9789-12c74b92fee7",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-13T11:19:24+00:00",
        "updated_at": "2022-07-13T11:19:24+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=a87d52e4-0f0f-4d28-9789-12c74b92fee7"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-13T11:17:17Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/b113e2a3-5832-4910-b92a-aa7f1a05c6ac?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b113e2a3-5832-4910-b92a-aa7f1a05c6ac",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-13T11:19:25+00:00",
      "updated_at": "2022-07-13T11:19:25+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b113e2a3-5832-4910-b92a-aa7f1a05c6ac"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "794264b6-c97f-48c0-98ad-b028d770d6a7"
          },
          {
            "type": "menu_items",
            "id": "6f341834-efa4-4444-b067-0a73922af34a"
          },
          {
            "type": "menu_items",
            "id": "421543ac-117a-40ee-ae38-3e605bb66ae4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "794264b6-c97f-48c0-98ad-b028d770d6a7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T11:19:25+00:00",
        "updated_at": "2022-07-13T11:19:25+00:00",
        "menu_id": "b113e2a3-5832-4910-b92a-aa7f1a05c6ac",
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
            "related": "api/boomerang/menus/b113e2a3-5832-4910-b92a-aa7f1a05c6ac"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=794264b6-c97f-48c0-98ad-b028d770d6a7"
          }
        }
      }
    },
    {
      "id": "6f341834-efa4-4444-b067-0a73922af34a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T11:19:25+00:00",
        "updated_at": "2022-07-13T11:19:25+00:00",
        "menu_id": "b113e2a3-5832-4910-b92a-aa7f1a05c6ac",
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
            "related": "api/boomerang/menus/b113e2a3-5832-4910-b92a-aa7f1a05c6ac"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6f341834-efa4-4444-b067-0a73922af34a"
          }
        }
      }
    },
    {
      "id": "421543ac-117a-40ee-ae38-3e605bb66ae4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T11:19:25+00:00",
        "updated_at": "2022-07-13T11:19:25+00:00",
        "menu_id": "b113e2a3-5832-4910-b92a-aa7f1a05c6ac",
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
            "related": "api/boomerang/menus/b113e2a3-5832-4910-b92a-aa7f1a05c6ac"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=421543ac-117a-40ee-ae38-3e605bb66ae4"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


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
    "id": "d4f3993e-f640-420b-b1af-fa0d3d1cede2",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-13T11:19:26+00:00",
      "updated_at": "2022-07-13T11:19:26+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/454cd0f4-f08a-4409-9213-606fcf070b3b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "454cd0f4-f08a-4409-9213-606fcf070b3b",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "febc66ef-78ca-4512-80ce-919424325657",
              "title": "Contact us"
            },
            {
              "id": "3e3d52f6-e9d2-4be0-ad1e-79cc753208ae",
              "title": "Start"
            },
            {
              "id": "e62a428b-1128-4767-9ed8-e1e48bdc32dc",
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
    "id": "454cd0f4-f08a-4409-9213-606fcf070b3b",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-13T11:19:26+00:00",
      "updated_at": "2022-07-13T11:19:26+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "febc66ef-78ca-4512-80ce-919424325657"
          },
          {
            "type": "menu_items",
            "id": "3e3d52f6-e9d2-4be0-ad1e-79cc753208ae"
          },
          {
            "type": "menu_items",
            "id": "e62a428b-1128-4767-9ed8-e1e48bdc32dc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "febc66ef-78ca-4512-80ce-919424325657",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T11:19:26+00:00",
        "updated_at": "2022-07-13T11:19:26+00:00",
        "menu_id": "454cd0f4-f08a-4409-9213-606fcf070b3b",
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
      "id": "3e3d52f6-e9d2-4be0-ad1e-79cc753208ae",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T11:19:26+00:00",
        "updated_at": "2022-07-13T11:19:26+00:00",
        "menu_id": "454cd0f4-f08a-4409-9213-606fcf070b3b",
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
      "id": "e62a428b-1128-4767-9ed8-e1e48bdc32dc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T11:19:26+00:00",
        "updated_at": "2022-07-13T11:19:26+00:00",
        "menu_id": "454cd0f4-f08a-4409-9213-606fcf070b3b",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/37c3cdb3-de39-4ab2-96ef-76abda6b9f26' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes