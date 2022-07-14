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
      "id": "bded0f78-7494-4df9-868c-af1cb24b113a",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-14T10:50:19+00:00",
        "updated_at": "2022-07-14T10:50:19+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=bded0f78-7494-4df9-868c-af1cb24b113a"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:48:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/fd4dc018-b23a-4718-a3e3-f04f6b2cbd58?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fd4dc018-b23a-4718-a3e3-f04f6b2cbd58",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T10:50:19+00:00",
      "updated_at": "2022-07-14T10:50:19+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=fd4dc018-b23a-4718-a3e3-f04f6b2cbd58"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "d3756df9-ec26-4fc6-9400-159feaaeaeb8"
          },
          {
            "type": "menu_items",
            "id": "1292439b-022c-4063-b464-a67cd1b28933"
          },
          {
            "type": "menu_items",
            "id": "892136b0-271d-45fb-bd57-dec85649ea35"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d3756df9-ec26-4fc6-9400-159feaaeaeb8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T10:50:19+00:00",
        "updated_at": "2022-07-14T10:50:19+00:00",
        "menu_id": "fd4dc018-b23a-4718-a3e3-f04f6b2cbd58",
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
            "related": "api/boomerang/menus/fd4dc018-b23a-4718-a3e3-f04f6b2cbd58"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d3756df9-ec26-4fc6-9400-159feaaeaeb8"
          }
        }
      }
    },
    {
      "id": "1292439b-022c-4063-b464-a67cd1b28933",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T10:50:19+00:00",
        "updated_at": "2022-07-14T10:50:19+00:00",
        "menu_id": "fd4dc018-b23a-4718-a3e3-f04f6b2cbd58",
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
            "related": "api/boomerang/menus/fd4dc018-b23a-4718-a3e3-f04f6b2cbd58"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1292439b-022c-4063-b464-a67cd1b28933"
          }
        }
      }
    },
    {
      "id": "892136b0-271d-45fb-bd57-dec85649ea35",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T10:50:19+00:00",
        "updated_at": "2022-07-14T10:50:19+00:00",
        "menu_id": "fd4dc018-b23a-4718-a3e3-f04f6b2cbd58",
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
            "related": "api/boomerang/menus/fd4dc018-b23a-4718-a3e3-f04f6b2cbd58"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=892136b0-271d-45fb-bd57-dec85649ea35"
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
    "id": "46fbfb5b-5c82-45ed-8105-6499d0b80ebb",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T10:50:20+00:00",
      "updated_at": "2022-07-14T10:50:20+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ed37eb34-135c-4ca5-a080-853552e068b5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ed37eb34-135c-4ca5-a080-853552e068b5",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "38eaf826-e4a6-4c7d-b8fc-34b9040a9b0c",
              "title": "Contact us"
            },
            {
              "id": "ed58adb1-b117-444a-a462-0ff6137a3835",
              "title": "Start"
            },
            {
              "id": "b7cddbd8-c977-4f07-8562-9c5acce3db37",
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
    "id": "ed37eb34-135c-4ca5-a080-853552e068b5",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T10:50:20+00:00",
      "updated_at": "2022-07-14T10:50:20+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "38eaf826-e4a6-4c7d-b8fc-34b9040a9b0c"
          },
          {
            "type": "menu_items",
            "id": "ed58adb1-b117-444a-a462-0ff6137a3835"
          },
          {
            "type": "menu_items",
            "id": "b7cddbd8-c977-4f07-8562-9c5acce3db37"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "38eaf826-e4a6-4c7d-b8fc-34b9040a9b0c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T10:50:20+00:00",
        "updated_at": "2022-07-14T10:50:20+00:00",
        "menu_id": "ed37eb34-135c-4ca5-a080-853552e068b5",
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
      "id": "ed58adb1-b117-444a-a462-0ff6137a3835",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T10:50:20+00:00",
        "updated_at": "2022-07-14T10:50:20+00:00",
        "menu_id": "ed37eb34-135c-4ca5-a080-853552e068b5",
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
      "id": "b7cddbd8-c977-4f07-8562-9c5acce3db37",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T10:50:20+00:00",
        "updated_at": "2022-07-14T10:50:20+00:00",
        "menu_id": "ed37eb34-135c-4ca5-a080-853552e068b5",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7da763d7-4c89-4fdc-b0e3-5b91266e19fc' \
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