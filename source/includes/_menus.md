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
      "id": "83695ff6-0e06-4e1f-b2c3-d7077773211f",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-21T10:58:09+00:00",
        "updated_at": "2022-07-21T10:58:09+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=83695ff6-0e06-4e1f-b2c3-d7077773211f"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-21T10:55:43Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/ac242b41-ec1e-4bcd-8fa1-262d50f2f51e?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ac242b41-ec1e-4bcd-8fa1-262d50f2f51e",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-21T10:58:09+00:00",
      "updated_at": "2022-07-21T10:58:09+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=ac242b41-ec1e-4bcd-8fa1-262d50f2f51e"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "478d8a62-64e3-4c4e-8d9f-797e2cc42707"
          },
          {
            "type": "menu_items",
            "id": "bcb29e08-2916-4703-95f9-2ae37dec777c"
          },
          {
            "type": "menu_items",
            "id": "a4d1a1e4-6ab2-4931-9836-547b532dda8c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "478d8a62-64e3-4c4e-8d9f-797e2cc42707",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-21T10:58:09+00:00",
        "updated_at": "2022-07-21T10:58:09+00:00",
        "menu_id": "ac242b41-ec1e-4bcd-8fa1-262d50f2f51e",
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
            "related": "api/boomerang/menus/ac242b41-ec1e-4bcd-8fa1-262d50f2f51e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=478d8a62-64e3-4c4e-8d9f-797e2cc42707"
          }
        }
      }
    },
    {
      "id": "bcb29e08-2916-4703-95f9-2ae37dec777c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-21T10:58:09+00:00",
        "updated_at": "2022-07-21T10:58:09+00:00",
        "menu_id": "ac242b41-ec1e-4bcd-8fa1-262d50f2f51e",
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
            "related": "api/boomerang/menus/ac242b41-ec1e-4bcd-8fa1-262d50f2f51e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bcb29e08-2916-4703-95f9-2ae37dec777c"
          }
        }
      }
    },
    {
      "id": "a4d1a1e4-6ab2-4931-9836-547b532dda8c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-21T10:58:09+00:00",
        "updated_at": "2022-07-21T10:58:09+00:00",
        "menu_id": "ac242b41-ec1e-4bcd-8fa1-262d50f2f51e",
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
            "related": "api/boomerang/menus/ac242b41-ec1e-4bcd-8fa1-262d50f2f51e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a4d1a1e4-6ab2-4931-9836-547b532dda8c"
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
    "id": "885b013c-fe0e-440a-9847-d51ab4ae934a",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-21T10:58:10+00:00",
      "updated_at": "2022-07-21T10:58:10+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/292c3f1a-00c2-4329-950e-720c4db7ea66' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "292c3f1a-00c2-4329-950e-720c4db7ea66",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "9d7da7a0-d1e4-4567-ab98-1c9bbc0c7841",
              "title": "Contact us"
            },
            {
              "id": "43f67609-600e-4e49-acfe-246e755d939d",
              "title": "Start"
            },
            {
              "id": "0b45bcc2-dc47-4df3-971c-1e730e1b16f4",
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
    "id": "292c3f1a-00c2-4329-950e-720c4db7ea66",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-21T10:58:10+00:00",
      "updated_at": "2022-07-21T10:58:10+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "9d7da7a0-d1e4-4567-ab98-1c9bbc0c7841"
          },
          {
            "type": "menu_items",
            "id": "43f67609-600e-4e49-acfe-246e755d939d"
          },
          {
            "type": "menu_items",
            "id": "0b45bcc2-dc47-4df3-971c-1e730e1b16f4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9d7da7a0-d1e4-4567-ab98-1c9bbc0c7841",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-21T10:58:10+00:00",
        "updated_at": "2022-07-21T10:58:10+00:00",
        "menu_id": "292c3f1a-00c2-4329-950e-720c4db7ea66",
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
      "id": "43f67609-600e-4e49-acfe-246e755d939d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-21T10:58:10+00:00",
        "updated_at": "2022-07-21T10:58:10+00:00",
        "menu_id": "292c3f1a-00c2-4329-950e-720c4db7ea66",
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
      "id": "0b45bcc2-dc47-4df3-971c-1e730e1b16f4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-21T10:58:10+00:00",
        "updated_at": "2022-07-21T10:58:10+00:00",
        "menu_id": "292c3f1a-00c2-4329-950e-720c4db7ea66",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7c5f38ca-35a1-490e-9ab9-7747c9b70135' \
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