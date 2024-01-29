# Menus

Allows creating and managing menus for your shop.

## Endpoints
`POST /api/boomerang/menus`

`DELETE /api/boomerang/menus/{id}`

`PUT /api/boomerang/menus/{id}`

`GET /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

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
    "id": "663fc44e-fc45-41c7-a5aa-a702a9a68e8e",
    "type": "menus",
    "attributes": {
      "created_at": "2024-01-29T09:17:27+00:00",
      "updated_at": "2024-01-29T09:17:27+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6e19fd9e-b3c5-4d68-b193-b02bec6010ad' \
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
## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/7747cbbd-c4bc-4ef3-a5ac-4df83e4685b1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7747cbbd-c4bc-4ef3-a5ac-4df83e4685b1",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "a1edd728-bf76-4a9e-8fd2-feb99849228f",
              "title": "Contact us"
            },
            {
              "id": "a52d655b-0d0c-49c0-8f2c-5ec0cf52a162",
              "title": "Start"
            },
            {
              "id": "1c1492bf-e19a-4320-bee7-9f2dba255321",
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
    "id": "7747cbbd-c4bc-4ef3-a5ac-4df83e4685b1",
    "type": "menus",
    "attributes": {
      "created_at": "2024-01-29T09:17:29+00:00",
      "updated_at": "2024-01-29T09:17:29+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "a1edd728-bf76-4a9e-8fd2-feb99849228f"
          },
          {
            "type": "menu_items",
            "id": "a52d655b-0d0c-49c0-8f2c-5ec0cf52a162"
          },
          {
            "type": "menu_items",
            "id": "1c1492bf-e19a-4320-bee7-9f2dba255321"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a1edd728-bf76-4a9e-8fd2-feb99849228f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-29T09:17:29+00:00",
        "updated_at": "2024-01-29T09:17:29+00:00",
        "menu_id": "7747cbbd-c4bc-4ef3-a5ac-4df83e4685b1",
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
      "id": "a52d655b-0d0c-49c0-8f2c-5ec0cf52a162",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-29T09:17:29+00:00",
        "updated_at": "2024-01-29T09:17:29+00:00",
        "menu_id": "7747cbbd-c4bc-4ef3-a5ac-4df83e4685b1",
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
      "id": "1c1492bf-e19a-4320-bee7-9f2dba255321",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-29T09:17:29+00:00",
        "updated_at": "2024-01-29T09:17:29+00:00",
        "menu_id": "7747cbbd-c4bc-4ef3-a5ac-4df83e4685b1",
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










## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/669ad948-c713-4bfb-9e2d-016ade5e6a5f?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "669ad948-c713-4bfb-9e2d-016ade5e6a5f",
    "type": "menus",
    "attributes": {
      "created_at": "2024-01-29T09:17:29+00:00",
      "updated_at": "2024-01-29T09:17:29+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=669ad948-c713-4bfb-9e2d-016ade5e6a5f"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ed4b9834-8f78-48b2-a4dc-e311dda943b7"
          },
          {
            "type": "menu_items",
            "id": "71140b03-82bc-4345-9e9b-584c2f3ac3a4"
          },
          {
            "type": "menu_items",
            "id": "9b82f156-7601-401e-921f-013a58308353"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ed4b9834-8f78-48b2-a4dc-e311dda943b7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-29T09:17:29+00:00",
        "updated_at": "2024-01-29T09:17:29+00:00",
        "menu_id": "669ad948-c713-4bfb-9e2d-016ade5e6a5f",
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
            "related": "api/boomerang/menus/669ad948-c713-4bfb-9e2d-016ade5e6a5f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ed4b9834-8f78-48b2-a4dc-e311dda943b7"
          }
        }
      }
    },
    {
      "id": "71140b03-82bc-4345-9e9b-584c2f3ac3a4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-29T09:17:29+00:00",
        "updated_at": "2024-01-29T09:17:29+00:00",
        "menu_id": "669ad948-c713-4bfb-9e2d-016ade5e6a5f",
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
            "related": "api/boomerang/menus/669ad948-c713-4bfb-9e2d-016ade5e6a5f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=71140b03-82bc-4345-9e9b-584c2f3ac3a4"
          }
        }
      }
    },
    {
      "id": "9b82f156-7601-401e-921f-013a58308353",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-29T09:17:29+00:00",
        "updated_at": "2024-01-29T09:17:29+00:00",
        "menu_id": "669ad948-c713-4bfb-9e2d-016ade5e6a5f",
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
            "related": "api/boomerang/menus/669ad948-c713-4bfb-9e2d-016ade5e6a5f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9b82f156-7601-401e-921f-013a58308353"
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
      "id": "a2f9fb67-0f8c-45c7-8404-4aa1daa3f204",
      "type": "menus",
      "attributes": {
        "created_at": "2024-01-29T09:17:30+00:00",
        "updated_at": "2024-01-29T09:17:30+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=a2f9fb67-0f8c-45c7-8404-4aa1daa3f204"
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









