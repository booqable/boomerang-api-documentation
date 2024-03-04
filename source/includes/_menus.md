# Menus

Allows creating and managing menus for your shop.

## Endpoints
`POST /api/boomerang/menus`

`DELETE /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

`GET /api/boomerang/menus/{id}`

`PUT /api/boomerang/menus/{id}`

## Fields
Every menu has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`title` | **String** <br>Name of the menu.
`key` | **String** <br>Key the menu can be referenced by.
`menu_items_attributes` | **Array** `writeonly`<br>Attributes of child menu items to be created or changed.


## Relationships
Menus have the following relationships:

Name | Description
-- | --
`menu_items` | **Menu items** `readonly`<br>Associated Menu items


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
    "id": "59fc0b98-2553-42f3-86e0-36ce6dbcbbfe",
    "type": "menus",
    "attributes": {
      "created_at": "2024-03-04T09:18:03+00:00",
      "updated_at": "2024-03-04T09:18:03+00:00",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/menus/2dfd36a2-0c9e-4965-bceb-26ea27892989' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request does not accept any includes
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
      "id": "388995b5-bb87-4117-975b-bbb4c1c3e828",
      "type": "menus",
      "attributes": {
        "created_at": "2024-03-04T09:18:05+00:00",
        "updated_at": "2024-03-04T09:18:05+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=388995b5-bb87-4117-975b-bbb4c1c3e828"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/99e4b48b-6168-4956-8e9a-4e1320dc6b9b?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "99e4b48b-6168-4956-8e9a-4e1320dc6b9b",
    "type": "menus",
    "attributes": {
      "created_at": "2024-03-04T09:18:06+00:00",
      "updated_at": "2024-03-04T09:18:06+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=99e4b48b-6168-4956-8e9a-4e1320dc6b9b"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "a81ed3fa-22d4-4485-b26d-2117e2434c45"
          },
          {
            "type": "menu_items",
            "id": "67bac6f9-9808-4141-9d14-8ce5d272a512"
          },
          {
            "type": "menu_items",
            "id": "9ee5f432-8a6a-4629-8d13-6cb13eca1e15"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a81ed3fa-22d4-4485-b26d-2117e2434c45",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-03-04T09:18:06+00:00",
        "updated_at": "2024-03-04T09:18:06+00:00",
        "menu_id": "99e4b48b-6168-4956-8e9a-4e1320dc6b9b",
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
            "related": "api/boomerang/menus/99e4b48b-6168-4956-8e9a-4e1320dc6b9b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a81ed3fa-22d4-4485-b26d-2117e2434c45"
          }
        }
      }
    },
    {
      "id": "67bac6f9-9808-4141-9d14-8ce5d272a512",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-03-04T09:18:06+00:00",
        "updated_at": "2024-03-04T09:18:06+00:00",
        "menu_id": "99e4b48b-6168-4956-8e9a-4e1320dc6b9b",
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
            "related": "api/boomerang/menus/99e4b48b-6168-4956-8e9a-4e1320dc6b9b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=67bac6f9-9808-4141-9d14-8ce5d272a512"
          }
        }
      }
    },
    {
      "id": "9ee5f432-8a6a-4629-8d13-6cb13eca1e15",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-03-04T09:18:06+00:00",
        "updated_at": "2024-03-04T09:18:06+00:00",
        "menu_id": "99e4b48b-6168-4956-8e9a-4e1320dc6b9b",
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
            "related": "api/boomerang/menus/99e4b48b-6168-4956-8e9a-4e1320dc6b9b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9ee5f432-8a6a-4629-8d13-6cb13eca1e15"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request accepts the following includes:

`menu_items`






## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/5c2251f1-2103-4df9-92b7-fb7167a4a7e9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5c2251f1-2103-4df9-92b7-fb7167a4a7e9",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "76f4da24-2ad9-4195-a9e2-4a89708a8f90",
              "title": "Contact us"
            },
            {
              "id": "4810485b-64d5-4aa8-9005-5eda67ddc09b",
              "title": "Start"
            },
            {
              "id": "e3f8c2c6-7b7f-40db-9a26-6dd8f57a3fcb",
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
    "id": "5c2251f1-2103-4df9-92b7-fb7167a4a7e9",
    "type": "menus",
    "attributes": {
      "created_at": "2024-03-04T09:18:07+00:00",
      "updated_at": "2024-03-04T09:18:07+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "76f4da24-2ad9-4195-a9e2-4a89708a8f90"
          },
          {
            "type": "menu_items",
            "id": "4810485b-64d5-4aa8-9005-5eda67ddc09b"
          },
          {
            "type": "menu_items",
            "id": "e3f8c2c6-7b7f-40db-9a26-6dd8f57a3fcb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "76f4da24-2ad9-4195-a9e2-4a89708a8f90",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-03-04T09:18:07+00:00",
        "updated_at": "2024-03-04T09:18:07+00:00",
        "menu_id": "5c2251f1-2103-4df9-92b7-fb7167a4a7e9",
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
      "id": "4810485b-64d5-4aa8-9005-5eda67ddc09b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-03-04T09:18:07+00:00",
        "updated_at": "2024-03-04T09:18:07+00:00",
        "menu_id": "5c2251f1-2103-4df9-92b7-fb7167a4a7e9",
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
      "id": "e3f8c2c6-7b7f-40db-9a26-6dd8f57a3fcb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-03-04T09:18:07+00:00",
        "updated_at": "2024-03-04T09:18:07+00:00",
        "menu_id": "5c2251f1-2103-4df9-92b7-fb7167a4a7e9",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][title]` | **String** <br>Name of the menu.
`data[attributes][key]` | **String** <br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array** <br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`









