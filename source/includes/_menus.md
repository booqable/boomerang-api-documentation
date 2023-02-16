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
      "id": "5113f331-57a7-4702-937f-dc3beb5a7050",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-16T09:22:05+00:00",
        "updated_at": "2023-02-16T09:22:05+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=5113f331-57a7-4702-937f-dc3beb5a7050"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T09:20:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/6a0cf01e-c4e3-4a66-95b6-4744217a6402?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6a0cf01e-c4e3-4a66-95b6-4744217a6402",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T09:22:05+00:00",
      "updated_at": "2023-02-16T09:22:05+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=6a0cf01e-c4e3-4a66-95b6-4744217a6402"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "f8fc37eb-b9ca-417f-b783-2e658153c789"
          },
          {
            "type": "menu_items",
            "id": "21d616ba-d9c2-413d-891e-ee56831ff2db"
          },
          {
            "type": "menu_items",
            "id": "fd923f75-9de6-4799-9561-6293520d038c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f8fc37eb-b9ca-417f-b783-2e658153c789",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T09:22:05+00:00",
        "updated_at": "2023-02-16T09:22:05+00:00",
        "menu_id": "6a0cf01e-c4e3-4a66-95b6-4744217a6402",
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
            "related": "api/boomerang/menus/6a0cf01e-c4e3-4a66-95b6-4744217a6402"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f8fc37eb-b9ca-417f-b783-2e658153c789"
          }
        }
      }
    },
    {
      "id": "21d616ba-d9c2-413d-891e-ee56831ff2db",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T09:22:05+00:00",
        "updated_at": "2023-02-16T09:22:05+00:00",
        "menu_id": "6a0cf01e-c4e3-4a66-95b6-4744217a6402",
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
            "related": "api/boomerang/menus/6a0cf01e-c4e3-4a66-95b6-4744217a6402"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=21d616ba-d9c2-413d-891e-ee56831ff2db"
          }
        }
      }
    },
    {
      "id": "fd923f75-9de6-4799-9561-6293520d038c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T09:22:05+00:00",
        "updated_at": "2023-02-16T09:22:05+00:00",
        "menu_id": "6a0cf01e-c4e3-4a66-95b6-4744217a6402",
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
            "related": "api/boomerang/menus/6a0cf01e-c4e3-4a66-95b6-4744217a6402"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fd923f75-9de6-4799-9561-6293520d038c"
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
    "id": "cc73a37b-4018-495c-951f-427244a7c2c2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T09:22:06+00:00",
      "updated_at": "2023-02-16T09:22:06+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5d54a930-68be-4e8b-878b-1632a8a6a789' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5d54a930-68be-4e8b-878b-1632a8a6a789",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "3c3f63ad-8ed7-4507-be77-3a913762e675",
              "title": "Contact us"
            },
            {
              "id": "23d85e5a-9667-4ddc-9ad7-3121835cc129",
              "title": "Start"
            },
            {
              "id": "46410e7e-a558-4106-9ffa-97d6c91c9d79",
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
    "id": "5d54a930-68be-4e8b-878b-1632a8a6a789",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T09:22:06+00:00",
      "updated_at": "2023-02-16T09:22:06+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "3c3f63ad-8ed7-4507-be77-3a913762e675"
          },
          {
            "type": "menu_items",
            "id": "23d85e5a-9667-4ddc-9ad7-3121835cc129"
          },
          {
            "type": "menu_items",
            "id": "46410e7e-a558-4106-9ffa-97d6c91c9d79"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3c3f63ad-8ed7-4507-be77-3a913762e675",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T09:22:06+00:00",
        "updated_at": "2023-02-16T09:22:06+00:00",
        "menu_id": "5d54a930-68be-4e8b-878b-1632a8a6a789",
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
      "id": "23d85e5a-9667-4ddc-9ad7-3121835cc129",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T09:22:06+00:00",
        "updated_at": "2023-02-16T09:22:06+00:00",
        "menu_id": "5d54a930-68be-4e8b-878b-1632a8a6a789",
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
      "id": "46410e7e-a558-4106-9ffa-97d6c91c9d79",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T09:22:06+00:00",
        "updated_at": "2023-02-16T09:22:06+00:00",
        "menu_id": "5d54a930-68be-4e8b-878b-1632a8a6a789",
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
    --url 'https://example.booqable.com/api/boomerang/menus/812b2016-2985-4cb2-bdb0-678ceedfc959' \
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