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
      "id": "4eeba5a4-459a-4843-a7d8-099bf8a73b7a",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-14T11:08:23+00:00",
        "updated_at": "2023-02-14T11:08:23+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=4eeba5a4-459a-4843-a7d8-099bf8a73b7a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T11:06:07Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/6b88a49f-19ba-4ec4-be71-333517e3dcd2?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6b88a49f-19ba-4ec4-be71-333517e3dcd2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T11:08:23+00:00",
      "updated_at": "2023-02-14T11:08:23+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=6b88a49f-19ba-4ec4-be71-333517e3dcd2"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "e7c78d72-d135-4a44-b20b-a86473f68f95"
          },
          {
            "type": "menu_items",
            "id": "2de706df-2ded-42ee-917d-5c3568d5ec77"
          },
          {
            "type": "menu_items",
            "id": "3886fa56-5dec-4507-b4ab-832fa3d7c67e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e7c78d72-d135-4a44-b20b-a86473f68f95",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:08:23+00:00",
        "updated_at": "2023-02-14T11:08:23+00:00",
        "menu_id": "6b88a49f-19ba-4ec4-be71-333517e3dcd2",
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
            "related": "api/boomerang/menus/6b88a49f-19ba-4ec4-be71-333517e3dcd2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e7c78d72-d135-4a44-b20b-a86473f68f95"
          }
        }
      }
    },
    {
      "id": "2de706df-2ded-42ee-917d-5c3568d5ec77",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:08:23+00:00",
        "updated_at": "2023-02-14T11:08:23+00:00",
        "menu_id": "6b88a49f-19ba-4ec4-be71-333517e3dcd2",
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
            "related": "api/boomerang/menus/6b88a49f-19ba-4ec4-be71-333517e3dcd2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2de706df-2ded-42ee-917d-5c3568d5ec77"
          }
        }
      }
    },
    {
      "id": "3886fa56-5dec-4507-b4ab-832fa3d7c67e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:08:23+00:00",
        "updated_at": "2023-02-14T11:08:23+00:00",
        "menu_id": "6b88a49f-19ba-4ec4-be71-333517e3dcd2",
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
            "related": "api/boomerang/menus/6b88a49f-19ba-4ec4-be71-333517e3dcd2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3886fa56-5dec-4507-b4ab-832fa3d7c67e"
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
    "id": "1b9658a8-85da-47e1-b02c-d643fe9e5584",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T11:08:24+00:00",
      "updated_at": "2023-02-14T11:08:24+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1bfd1c78-c6fe-46f1-8793-db9d9795e77c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1bfd1c78-c6fe-46f1-8793-db9d9795e77c",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "75605833-a011-4c56-a4cf-11eb133f0a88",
              "title": "Contact us"
            },
            {
              "id": "5abf1eb8-7a0b-4e8e-9e58-1df995a11f38",
              "title": "Start"
            },
            {
              "id": "579c0630-e74b-4bed-a29d-6ac7cd6eb7c9",
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
    "id": "1bfd1c78-c6fe-46f1-8793-db9d9795e77c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T11:08:25+00:00",
      "updated_at": "2023-02-14T11:08:25+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "75605833-a011-4c56-a4cf-11eb133f0a88"
          },
          {
            "type": "menu_items",
            "id": "5abf1eb8-7a0b-4e8e-9e58-1df995a11f38"
          },
          {
            "type": "menu_items",
            "id": "579c0630-e74b-4bed-a29d-6ac7cd6eb7c9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "75605833-a011-4c56-a4cf-11eb133f0a88",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:08:25+00:00",
        "updated_at": "2023-02-14T11:08:25+00:00",
        "menu_id": "1bfd1c78-c6fe-46f1-8793-db9d9795e77c",
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
      "id": "5abf1eb8-7a0b-4e8e-9e58-1df995a11f38",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:08:25+00:00",
        "updated_at": "2023-02-14T11:08:25+00:00",
        "menu_id": "1bfd1c78-c6fe-46f1-8793-db9d9795e77c",
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
      "id": "579c0630-e74b-4bed-a29d-6ac7cd6eb7c9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:08:25+00:00",
        "updated_at": "2023-02-14T11:08:25+00:00",
        "menu_id": "1bfd1c78-c6fe-46f1-8793-db9d9795e77c",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6fbc28c9-ce6d-426f-b595-d313026b2f30' \
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