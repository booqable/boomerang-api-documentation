# Menus

Allows creating and managing menus for your shop.

## Endpoints
`DELETE /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

`GET /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

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


## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/14b93f14-ceaa-4150-bc23-3295ba1c15da' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "14b93f14-ceaa-4150-bc23-3295ba1c15da",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-27T09:25:05.145670+00:00",
      "updated_at": "2024-05-27T09:25:05.145670+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=14b93f14-ceaa-4150-bc23-3295ba1c15da"
        }
      }
    }
  },
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
    "id": "bd55286b-2f69-4ab1-a5eb-fc172725b816",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-27T09:25:05.916603+00:00",
      "updated_at": "2024-05-27T09:25:05.916603+00:00",
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










## Fetching a menu



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/45126bc7-488e-4acf-bec2-51834b962315?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "45126bc7-488e-4acf-bec2-51834b962315",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-27T09:25:06.635838+00:00",
      "updated_at": "2024-05-27T09:25:06.635838+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=45126bc7-488e-4acf-bec2-51834b962315"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "a7f496e8-0572-43e5-bfcf-c3491e5938df"
          },
          {
            "type": "menu_items",
            "id": "6039f739-08b9-4a53-a85a-557518f5713c"
          },
          {
            "type": "menu_items",
            "id": "4a7f9768-d98c-4a25-9ddf-9eb82cae35d4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a7f496e8-0572-43e5-bfcf-c3491e5938df",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-27T09:25:06.640158+00:00",
        "updated_at": "2024-05-27T09:25:06.640158+00:00",
        "menu_id": "45126bc7-488e-4acf-bec2-51834b962315",
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
            "related": "api/boomerang/menus/45126bc7-488e-4acf-bec2-51834b962315"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a7f496e8-0572-43e5-bfcf-c3491e5938df"
          }
        }
      }
    },
    {
      "id": "6039f739-08b9-4a53-a85a-557518f5713c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-27T09:25:06.644744+00:00",
        "updated_at": "2024-05-27T09:25:06.644744+00:00",
        "menu_id": "45126bc7-488e-4acf-bec2-51834b962315",
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
            "related": "api/boomerang/menus/45126bc7-488e-4acf-bec2-51834b962315"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6039f739-08b9-4a53-a85a-557518f5713c"
          }
        }
      }
    },
    {
      "id": "4a7f9768-d98c-4a25-9ddf-9eb82cae35d4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-27T09:25:06.648924+00:00",
        "updated_at": "2024-05-27T09:25:06.648924+00:00",
        "menu_id": "45126bc7-488e-4acf-bec2-51834b962315",
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
            "related": "api/boomerang/menus/45126bc7-488e-4acf-bec2-51834b962315"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4a7f9768-d98c-4a25-9ddf-9eb82cae35d4"
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
      "id": "f3c28c8a-359e-401f-b0a0-af0622fc90a7",
      "type": "menus",
      "attributes": {
        "created_at": "2024-05-27T09:25:07.307435+00:00",
        "updated_at": "2024-05-27T09:25:07.307435+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=f3c28c8a-359e-401f-b0a0-af0622fc90a7"
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










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/9971a3cb-1ffd-40bf-87b8-40eeb0b61231' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9971a3cb-1ffd-40bf-87b8-40eeb0b61231",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "b5b21615-f1df-4d50-bfb1-adc0ea12be54",
              "title": "Contact us"
            },
            {
              "id": "e967f57f-5025-4b38-bc39-c518990db8a7",
              "title": "Start"
            },
            {
              "id": "b2cbc0a9-d5f9-449b-a3b8-d051a2c3a924",
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
    "id": "9971a3cb-1ffd-40bf-87b8-40eeb0b61231",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-27T09:25:08.060559+00:00",
      "updated_at": "2024-05-27T09:25:08.135190+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "b5b21615-f1df-4d50-bfb1-adc0ea12be54"
          },
          {
            "type": "menu_items",
            "id": "e967f57f-5025-4b38-bc39-c518990db8a7"
          },
          {
            "type": "menu_items",
            "id": "b2cbc0a9-d5f9-449b-a3b8-d051a2c3a924"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b5b21615-f1df-4d50-bfb1-adc0ea12be54",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-27T09:25:08.064261+00:00",
        "updated_at": "2024-05-27T09:25:08.139261+00:00",
        "menu_id": "9971a3cb-1ffd-40bf-87b8-40eeb0b61231",
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
      "id": "e967f57f-5025-4b38-bc39-c518990db8a7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-27T09:25:08.068239+00:00",
        "updated_at": "2024-05-27T09:25:08.143855+00:00",
        "menu_id": "9971a3cb-1ffd-40bf-87b8-40eeb0b61231",
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
      "id": "b2cbc0a9-d5f9-449b-a3b8-d051a2c3a924",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-27T09:25:08.071520+00:00",
        "updated_at": "2024-05-27T09:25:08.147510+00:00",
        "menu_id": "9971a3cb-1ffd-40bf-87b8-40eeb0b61231",
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









