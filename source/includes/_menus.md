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
      "id": "2dc3aebe-ca9b-4680-972c-0629cc2d2f43",
      "type": "menus",
      "attributes": {
        "created_at": "2022-09-16T11:50:11+00:00",
        "updated_at": "2022-09-16T11:50:11+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=2dc3aebe-ca9b-4680-972c-0629cc2d2f43"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T11:48:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/fde8352d-8ce2-4d9e-b4a4-efd524a12a61?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fde8352d-8ce2-4d9e-b4a4-efd524a12a61",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-16T11:50:11+00:00",
      "updated_at": "2022-09-16T11:50:11+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=fde8352d-8ce2-4d9e-b4a4-efd524a12a61"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "f4467f23-31a7-4d47-a04e-a846f29b28bc"
          },
          {
            "type": "menu_items",
            "id": "4aff530c-346d-4978-8471-c67a4f0fb473"
          },
          {
            "type": "menu_items",
            "id": "7156e05d-b149-465e-8792-b76baecc27f7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f4467f23-31a7-4d47-a04e-a846f29b28bc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T11:50:11+00:00",
        "updated_at": "2022-09-16T11:50:11+00:00",
        "menu_id": "fde8352d-8ce2-4d9e-b4a4-efd524a12a61",
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
            "related": "api/boomerang/menus/fde8352d-8ce2-4d9e-b4a4-efd524a12a61"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f4467f23-31a7-4d47-a04e-a846f29b28bc"
          }
        }
      }
    },
    {
      "id": "4aff530c-346d-4978-8471-c67a4f0fb473",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T11:50:11+00:00",
        "updated_at": "2022-09-16T11:50:11+00:00",
        "menu_id": "fde8352d-8ce2-4d9e-b4a4-efd524a12a61",
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
            "related": "api/boomerang/menus/fde8352d-8ce2-4d9e-b4a4-efd524a12a61"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4aff530c-346d-4978-8471-c67a4f0fb473"
          }
        }
      }
    },
    {
      "id": "7156e05d-b149-465e-8792-b76baecc27f7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T11:50:11+00:00",
        "updated_at": "2022-09-16T11:50:11+00:00",
        "menu_id": "fde8352d-8ce2-4d9e-b4a4-efd524a12a61",
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
            "related": "api/boomerang/menus/fde8352d-8ce2-4d9e-b4a4-efd524a12a61"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7156e05d-b149-465e-8792-b76baecc27f7"
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
    "id": "396a6861-e627-475a-8a54-bab8696b1951",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-16T11:50:12+00:00",
      "updated_at": "2022-09-16T11:50:12+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1c0aacf0-855e-4400-9e21-d683ba29e7a3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1c0aacf0-855e-4400-9e21-d683ba29e7a3",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "7dadc995-3e85-488a-80d5-e8dc2c3455ab",
              "title": "Contact us"
            },
            {
              "id": "25d76642-a895-41c3-a9f1-134b41203f6b",
              "title": "Start"
            },
            {
              "id": "5851e04d-5752-471a-a74c-1e0f92f26dfe",
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
    "id": "1c0aacf0-855e-4400-9e21-d683ba29e7a3",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-16T11:50:12+00:00",
      "updated_at": "2022-09-16T11:50:12+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "7dadc995-3e85-488a-80d5-e8dc2c3455ab"
          },
          {
            "type": "menu_items",
            "id": "25d76642-a895-41c3-a9f1-134b41203f6b"
          },
          {
            "type": "menu_items",
            "id": "5851e04d-5752-471a-a74c-1e0f92f26dfe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7dadc995-3e85-488a-80d5-e8dc2c3455ab",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T11:50:12+00:00",
        "updated_at": "2022-09-16T11:50:12+00:00",
        "menu_id": "1c0aacf0-855e-4400-9e21-d683ba29e7a3",
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
      "id": "25d76642-a895-41c3-a9f1-134b41203f6b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T11:50:12+00:00",
        "updated_at": "2022-09-16T11:50:12+00:00",
        "menu_id": "1c0aacf0-855e-4400-9e21-d683ba29e7a3",
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
      "id": "5851e04d-5752-471a-a74c-1e0f92f26dfe",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-16T11:50:12+00:00",
        "updated_at": "2022-09-16T11:50:12+00:00",
        "menu_id": "1c0aacf0-855e-4400-9e21-d683ba29e7a3",
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
    --url 'https://example.booqable.com/api/boomerang/menus/18bb2c95-a6c6-4c53-a208-2c42e5f68dfd' \
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