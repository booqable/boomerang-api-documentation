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
      "id": "b6d477d3-b85c-4380-b9c2-5696747bbbed",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-16T14:23:47+00:00",
        "updated_at": "2022-11-16T14:23:47+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=b6d477d3-b85c-4380-b9c2-5696747bbbed"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-16T14:21:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/dc6d4591-1ec5-4328-b9c8-0712d1cd812f?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dc6d4591-1ec5-4328-b9c8-0712d1cd812f",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-16T14:23:47+00:00",
      "updated_at": "2022-11-16T14:23:47+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=dc6d4591-1ec5-4328-b9c8-0712d1cd812f"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "7bb0ac7e-dff1-4ea5-a417-eef1c25ed421"
          },
          {
            "type": "menu_items",
            "id": "b9b48b74-6da7-459a-ac0b-14c1050539b3"
          },
          {
            "type": "menu_items",
            "id": "af18258b-7c4c-462b-acab-4a46875c6a0a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7bb0ac7e-dff1-4ea5-a417-eef1c25ed421",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-16T14:23:47+00:00",
        "updated_at": "2022-11-16T14:23:47+00:00",
        "menu_id": "dc6d4591-1ec5-4328-b9c8-0712d1cd812f",
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
            "related": "api/boomerang/menus/dc6d4591-1ec5-4328-b9c8-0712d1cd812f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7bb0ac7e-dff1-4ea5-a417-eef1c25ed421"
          }
        }
      }
    },
    {
      "id": "b9b48b74-6da7-459a-ac0b-14c1050539b3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-16T14:23:47+00:00",
        "updated_at": "2022-11-16T14:23:47+00:00",
        "menu_id": "dc6d4591-1ec5-4328-b9c8-0712d1cd812f",
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
            "related": "api/boomerang/menus/dc6d4591-1ec5-4328-b9c8-0712d1cd812f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b9b48b74-6da7-459a-ac0b-14c1050539b3"
          }
        }
      }
    },
    {
      "id": "af18258b-7c4c-462b-acab-4a46875c6a0a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-16T14:23:47+00:00",
        "updated_at": "2022-11-16T14:23:47+00:00",
        "menu_id": "dc6d4591-1ec5-4328-b9c8-0712d1cd812f",
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
            "related": "api/boomerang/menus/dc6d4591-1ec5-4328-b9c8-0712d1cd812f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=af18258b-7c4c-462b-acab-4a46875c6a0a"
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
    "id": "7870b453-e8ea-4a39-bd3b-4d1ab1ed6dbf",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-16T14:23:48+00:00",
      "updated_at": "2022-11-16T14:23:48+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/26c364a7-f129-40de-81e8-2c0eadf21400' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "26c364a7-f129-40de-81e8-2c0eadf21400",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "1f1ba51e-9470-4e80-9fcd-d1f1c02b0b3f",
              "title": "Contact us"
            },
            {
              "id": "67996517-3d00-4c02-9a93-72d1a810173c",
              "title": "Start"
            },
            {
              "id": "4a0c7a98-ba8a-47bc-89ce-f96006b82a31",
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
    "id": "26c364a7-f129-40de-81e8-2c0eadf21400",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-16T14:23:48+00:00",
      "updated_at": "2022-11-16T14:23:48+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "1f1ba51e-9470-4e80-9fcd-d1f1c02b0b3f"
          },
          {
            "type": "menu_items",
            "id": "67996517-3d00-4c02-9a93-72d1a810173c"
          },
          {
            "type": "menu_items",
            "id": "4a0c7a98-ba8a-47bc-89ce-f96006b82a31"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1f1ba51e-9470-4e80-9fcd-d1f1c02b0b3f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-16T14:23:48+00:00",
        "updated_at": "2022-11-16T14:23:48+00:00",
        "menu_id": "26c364a7-f129-40de-81e8-2c0eadf21400",
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
      "id": "67996517-3d00-4c02-9a93-72d1a810173c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-16T14:23:48+00:00",
        "updated_at": "2022-11-16T14:23:48+00:00",
        "menu_id": "26c364a7-f129-40de-81e8-2c0eadf21400",
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
      "id": "4a0c7a98-ba8a-47bc-89ce-f96006b82a31",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-16T14:23:48+00:00",
        "updated_at": "2022-11-16T14:23:48+00:00",
        "menu_id": "26c364a7-f129-40de-81e8-2c0eadf21400",
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
    --url 'https://example.booqable.com/api/boomerang/menus/8cdf5e88-eef5-4e83-b972-69c155587f44' \
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