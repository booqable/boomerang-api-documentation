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
      "id": "340263bb-e6b0-4814-9354-4ba04c590fff",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-14T13:04:43+00:00",
        "updated_at": "2022-07-14T13:04:43+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=340263bb-e6b0-4814-9354-4ba04c590fff"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T13:03:03Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/6c02ecfb-5bd1-4993-afe4-06eba9b84377?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6c02ecfb-5bd1-4993-afe4-06eba9b84377",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T13:04:44+00:00",
      "updated_at": "2022-07-14T13:04:44+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=6c02ecfb-5bd1-4993-afe4-06eba9b84377"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "c392cdd8-92d4-4947-bad4-9b36dcee224f"
          },
          {
            "type": "menu_items",
            "id": "45e24663-96e5-4301-b91a-30be4daa8c4f"
          },
          {
            "type": "menu_items",
            "id": "a7b7d325-20b4-45ce-ba1a-6fa00cf4a5d9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c392cdd8-92d4-4947-bad4-9b36dcee224f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T13:04:44+00:00",
        "updated_at": "2022-07-14T13:04:44+00:00",
        "menu_id": "6c02ecfb-5bd1-4993-afe4-06eba9b84377",
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
            "related": "api/boomerang/menus/6c02ecfb-5bd1-4993-afe4-06eba9b84377"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c392cdd8-92d4-4947-bad4-9b36dcee224f"
          }
        }
      }
    },
    {
      "id": "45e24663-96e5-4301-b91a-30be4daa8c4f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T13:04:44+00:00",
        "updated_at": "2022-07-14T13:04:44+00:00",
        "menu_id": "6c02ecfb-5bd1-4993-afe4-06eba9b84377",
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
            "related": "api/boomerang/menus/6c02ecfb-5bd1-4993-afe4-06eba9b84377"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=45e24663-96e5-4301-b91a-30be4daa8c4f"
          }
        }
      }
    },
    {
      "id": "a7b7d325-20b4-45ce-ba1a-6fa00cf4a5d9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T13:04:44+00:00",
        "updated_at": "2022-07-14T13:04:44+00:00",
        "menu_id": "6c02ecfb-5bd1-4993-afe4-06eba9b84377",
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
            "related": "api/boomerang/menus/6c02ecfb-5bd1-4993-afe4-06eba9b84377"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a7b7d325-20b4-45ce-ba1a-6fa00cf4a5d9"
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
    "id": "abb0ae31-00cd-4b59-a449-e8cc8696ef6a",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T13:04:44+00:00",
      "updated_at": "2022-07-14T13:04:44+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9ede95dd-1262-4da5-b2c0-df19a9472d34' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9ede95dd-1262-4da5-b2c0-df19a9472d34",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "2f349306-3d3c-461f-ab67-0c1a40b485d9",
              "title": "Contact us"
            },
            {
              "id": "ecadc13a-f562-4fbc-982d-15c504a39cea",
              "title": "Start"
            },
            {
              "id": "85fac26c-9f72-4589-816b-1615d83a9649",
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
    "id": "9ede95dd-1262-4da5-b2c0-df19a9472d34",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T13:04:44+00:00",
      "updated_at": "2022-07-14T13:04:44+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "2f349306-3d3c-461f-ab67-0c1a40b485d9"
          },
          {
            "type": "menu_items",
            "id": "ecadc13a-f562-4fbc-982d-15c504a39cea"
          },
          {
            "type": "menu_items",
            "id": "85fac26c-9f72-4589-816b-1615d83a9649"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2f349306-3d3c-461f-ab67-0c1a40b485d9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T13:04:44+00:00",
        "updated_at": "2022-07-14T13:04:44+00:00",
        "menu_id": "9ede95dd-1262-4da5-b2c0-df19a9472d34",
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
      "id": "ecadc13a-f562-4fbc-982d-15c504a39cea",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T13:04:44+00:00",
        "updated_at": "2022-07-14T13:04:44+00:00",
        "menu_id": "9ede95dd-1262-4da5-b2c0-df19a9472d34",
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
      "id": "85fac26c-9f72-4589-816b-1615d83a9649",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T13:04:44+00:00",
        "updated_at": "2022-07-14T13:04:44+00:00",
        "menu_id": "9ede95dd-1262-4da5-b2c0-df19a9472d34",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a7e1c19e-83c9-4bb3-966e-ef19fa51acd6' \
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