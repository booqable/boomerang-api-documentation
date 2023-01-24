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
      "id": "f18fe631-1236-480f-97b1-5273933d294c",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-24T14:01:36+00:00",
        "updated_at": "2023-01-24T14:01:36+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=f18fe631-1236-480f-97b1-5273933d294c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T14:00:04Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/14212eac-12ac-4407-96c1-593fd7f5afc2?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "14212eac-12ac-4407-96c1-593fd7f5afc2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-24T14:01:36+00:00",
      "updated_at": "2023-01-24T14:01:36+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=14212eac-12ac-4407-96c1-593fd7f5afc2"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "84ff068b-83d8-4a9c-ae92-3f5ec61641a6"
          },
          {
            "type": "menu_items",
            "id": "4607a314-cb02-48c2-b160-1f3d1a8cb51c"
          },
          {
            "type": "menu_items",
            "id": "7d08d25d-b5a5-4aeb-9eeb-4bb4bd45e18d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "84ff068b-83d8-4a9c-ae92-3f5ec61641a6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T14:01:36+00:00",
        "updated_at": "2023-01-24T14:01:36+00:00",
        "menu_id": "14212eac-12ac-4407-96c1-593fd7f5afc2",
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
            "related": "api/boomerang/menus/14212eac-12ac-4407-96c1-593fd7f5afc2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=84ff068b-83d8-4a9c-ae92-3f5ec61641a6"
          }
        }
      }
    },
    {
      "id": "4607a314-cb02-48c2-b160-1f3d1a8cb51c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T14:01:36+00:00",
        "updated_at": "2023-01-24T14:01:36+00:00",
        "menu_id": "14212eac-12ac-4407-96c1-593fd7f5afc2",
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
            "related": "api/boomerang/menus/14212eac-12ac-4407-96c1-593fd7f5afc2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4607a314-cb02-48c2-b160-1f3d1a8cb51c"
          }
        }
      }
    },
    {
      "id": "7d08d25d-b5a5-4aeb-9eeb-4bb4bd45e18d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T14:01:36+00:00",
        "updated_at": "2023-01-24T14:01:36+00:00",
        "menu_id": "14212eac-12ac-4407-96c1-593fd7f5afc2",
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
            "related": "api/boomerang/menus/14212eac-12ac-4407-96c1-593fd7f5afc2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7d08d25d-b5a5-4aeb-9eeb-4bb4bd45e18d"
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
    "id": "fe73cc6b-ff15-4bc4-8970-f190f7875a4a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-24T14:01:37+00:00",
      "updated_at": "2023-01-24T14:01:37+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1b0a01b7-081d-41cb-88d0-432221740a79' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1b0a01b7-081d-41cb-88d0-432221740a79",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "afb4cc21-8ca6-4c02-bc0d-cf3053641baa",
              "title": "Contact us"
            },
            {
              "id": "2a819012-5903-4cdb-aa36-92de5bc8f478",
              "title": "Start"
            },
            {
              "id": "a42dad70-765e-4426-b5be-d9fdac673d28",
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
    "id": "1b0a01b7-081d-41cb-88d0-432221740a79",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-24T14:01:37+00:00",
      "updated_at": "2023-01-24T14:01:37+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "afb4cc21-8ca6-4c02-bc0d-cf3053641baa"
          },
          {
            "type": "menu_items",
            "id": "2a819012-5903-4cdb-aa36-92de5bc8f478"
          },
          {
            "type": "menu_items",
            "id": "a42dad70-765e-4426-b5be-d9fdac673d28"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "afb4cc21-8ca6-4c02-bc0d-cf3053641baa",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T14:01:37+00:00",
        "updated_at": "2023-01-24T14:01:37+00:00",
        "menu_id": "1b0a01b7-081d-41cb-88d0-432221740a79",
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
      "id": "2a819012-5903-4cdb-aa36-92de5bc8f478",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T14:01:37+00:00",
        "updated_at": "2023-01-24T14:01:37+00:00",
        "menu_id": "1b0a01b7-081d-41cb-88d0-432221740a79",
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
      "id": "a42dad70-765e-4426-b5be-d9fdac673d28",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T14:01:37+00:00",
        "updated_at": "2023-01-24T14:01:37+00:00",
        "menu_id": "1b0a01b7-081d-41cb-88d0-432221740a79",
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
    --url 'https://example.booqable.com/api/boomerang/menus/582e7bbf-8129-420c-9f4e-d1757a0759a1' \
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