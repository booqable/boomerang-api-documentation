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
      "id": "cddf6502-526c-4f65-b9c5-916d495c15d9",
      "type": "menus",
      "attributes": {
        "created_at": "2022-10-07T12:09:03+00:00",
        "updated_at": "2022-10-07T12:09:03+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=cddf6502-526c-4f65-b9c5-916d495c15d9"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T12:07:11Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/40b29a30-40d5-4a53-9f52-b2359599a483?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "40b29a30-40d5-4a53-9f52-b2359599a483",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-07T12:09:04+00:00",
      "updated_at": "2022-10-07T12:09:04+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=40b29a30-40d5-4a53-9f52-b2359599a483"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "a0783629-6c43-40bc-adef-a969831c089e"
          },
          {
            "type": "menu_items",
            "id": "fe7972d9-7b05-4d89-a288-b86e420a4788"
          },
          {
            "type": "menu_items",
            "id": "d56a4dc5-a7c5-491d-a4f1-a91c4d2f961e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a0783629-6c43-40bc-adef-a969831c089e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T12:09:04+00:00",
        "updated_at": "2022-10-07T12:09:04+00:00",
        "menu_id": "40b29a30-40d5-4a53-9f52-b2359599a483",
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
            "related": "api/boomerang/menus/40b29a30-40d5-4a53-9f52-b2359599a483"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a0783629-6c43-40bc-adef-a969831c089e"
          }
        }
      }
    },
    {
      "id": "fe7972d9-7b05-4d89-a288-b86e420a4788",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T12:09:04+00:00",
        "updated_at": "2022-10-07T12:09:04+00:00",
        "menu_id": "40b29a30-40d5-4a53-9f52-b2359599a483",
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
            "related": "api/boomerang/menus/40b29a30-40d5-4a53-9f52-b2359599a483"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fe7972d9-7b05-4d89-a288-b86e420a4788"
          }
        }
      }
    },
    {
      "id": "d56a4dc5-a7c5-491d-a4f1-a91c4d2f961e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T12:09:04+00:00",
        "updated_at": "2022-10-07T12:09:04+00:00",
        "menu_id": "40b29a30-40d5-4a53-9f52-b2359599a483",
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
            "related": "api/boomerang/menus/40b29a30-40d5-4a53-9f52-b2359599a483"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d56a4dc5-a7c5-491d-a4f1-a91c4d2f961e"
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
    "id": "09fc83c6-8dda-4ee3-a657-ea0d5d7d7d95",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-07T12:09:05+00:00",
      "updated_at": "2022-10-07T12:09:05+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b4f888eb-9b77-4959-b46a-597b0a54ae8c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b4f888eb-9b77-4959-b46a-597b0a54ae8c",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "8a6595ba-3096-4d5d-8f7f-957ad247575e",
              "title": "Contact us"
            },
            {
              "id": "59a0304d-5fe3-4ae0-bd08-e79d52516cad",
              "title": "Start"
            },
            {
              "id": "9ecc4e4e-8f80-43fa-90af-1ae7eab4a08f",
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
    "id": "b4f888eb-9b77-4959-b46a-597b0a54ae8c",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-07T12:09:06+00:00",
      "updated_at": "2022-10-07T12:09:06+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "8a6595ba-3096-4d5d-8f7f-957ad247575e"
          },
          {
            "type": "menu_items",
            "id": "59a0304d-5fe3-4ae0-bd08-e79d52516cad"
          },
          {
            "type": "menu_items",
            "id": "9ecc4e4e-8f80-43fa-90af-1ae7eab4a08f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8a6595ba-3096-4d5d-8f7f-957ad247575e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T12:09:06+00:00",
        "updated_at": "2022-10-07T12:09:06+00:00",
        "menu_id": "b4f888eb-9b77-4959-b46a-597b0a54ae8c",
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
      "id": "59a0304d-5fe3-4ae0-bd08-e79d52516cad",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T12:09:06+00:00",
        "updated_at": "2022-10-07T12:09:06+00:00",
        "menu_id": "b4f888eb-9b77-4959-b46a-597b0a54ae8c",
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
      "id": "9ecc4e4e-8f80-43fa-90af-1ae7eab4a08f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-07T12:09:06+00:00",
        "updated_at": "2022-10-07T12:09:06+00:00",
        "menu_id": "b4f888eb-9b77-4959-b46a-597b0a54ae8c",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fa7297a3-0eaf-4751-9c5d-b6adcd8e51d3' \
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