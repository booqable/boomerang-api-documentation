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
      "id": "ab4d194f-e168-4064-ab3e-bf07f87ca4f4",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-06T10:41:16+00:00",
        "updated_at": "2023-03-06T10:41:16+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=ab4d194f-e168-4064-ab3e-bf07f87ca4f4"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-06T10:39:40Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/68511d15-e976-4e22-8bf1-95a60c1e5c60?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "68511d15-e976-4e22-8bf1-95a60c1e5c60",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-06T10:41:16+00:00",
      "updated_at": "2023-03-06T10:41:16+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=68511d15-e976-4e22-8bf1-95a60c1e5c60"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "33e659c9-bd3f-4e1d-a0af-836384c13f08"
          },
          {
            "type": "menu_items",
            "id": "a96cb323-2a21-4ee7-aaad-5de6ae22b5f9"
          },
          {
            "type": "menu_items",
            "id": "f13d968e-bc3d-4dac-a42a-413a66d54474"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "33e659c9-bd3f-4e1d-a0af-836384c13f08",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-06T10:41:16+00:00",
        "updated_at": "2023-03-06T10:41:16+00:00",
        "menu_id": "68511d15-e976-4e22-8bf1-95a60c1e5c60",
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
            "related": "api/boomerang/menus/68511d15-e976-4e22-8bf1-95a60c1e5c60"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=33e659c9-bd3f-4e1d-a0af-836384c13f08"
          }
        }
      }
    },
    {
      "id": "a96cb323-2a21-4ee7-aaad-5de6ae22b5f9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-06T10:41:16+00:00",
        "updated_at": "2023-03-06T10:41:16+00:00",
        "menu_id": "68511d15-e976-4e22-8bf1-95a60c1e5c60",
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
            "related": "api/boomerang/menus/68511d15-e976-4e22-8bf1-95a60c1e5c60"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a96cb323-2a21-4ee7-aaad-5de6ae22b5f9"
          }
        }
      }
    },
    {
      "id": "f13d968e-bc3d-4dac-a42a-413a66d54474",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-06T10:41:16+00:00",
        "updated_at": "2023-03-06T10:41:16+00:00",
        "menu_id": "68511d15-e976-4e22-8bf1-95a60c1e5c60",
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
            "related": "api/boomerang/menus/68511d15-e976-4e22-8bf1-95a60c1e5c60"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f13d968e-bc3d-4dac-a42a-413a66d54474"
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
    "id": "cde024cf-49f1-4971-ab2b-f3ba87c79531",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-06T10:41:17+00:00",
      "updated_at": "2023-03-06T10:41:17+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c991e000-e5bb-4718-b7a5-a9f67e959f7f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c991e000-e5bb-4718-b7a5-a9f67e959f7f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "c06ebc1a-99fd-47d1-bf2d-71f94c5a65c3",
              "title": "Contact us"
            },
            {
              "id": "83905450-5279-4359-b394-228ea1176a26",
              "title": "Start"
            },
            {
              "id": "361d643f-c0ed-4f18-81e6-9da7817f3e50",
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
    "id": "c991e000-e5bb-4718-b7a5-a9f67e959f7f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-06T10:41:17+00:00",
      "updated_at": "2023-03-06T10:41:17+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "c06ebc1a-99fd-47d1-bf2d-71f94c5a65c3"
          },
          {
            "type": "menu_items",
            "id": "83905450-5279-4359-b394-228ea1176a26"
          },
          {
            "type": "menu_items",
            "id": "361d643f-c0ed-4f18-81e6-9da7817f3e50"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c06ebc1a-99fd-47d1-bf2d-71f94c5a65c3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-06T10:41:17+00:00",
        "updated_at": "2023-03-06T10:41:17+00:00",
        "menu_id": "c991e000-e5bb-4718-b7a5-a9f67e959f7f",
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
      "id": "83905450-5279-4359-b394-228ea1176a26",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-06T10:41:17+00:00",
        "updated_at": "2023-03-06T10:41:17+00:00",
        "menu_id": "c991e000-e5bb-4718-b7a5-a9f67e959f7f",
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
      "id": "361d643f-c0ed-4f18-81e6-9da7817f3e50",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-06T10:41:17+00:00",
        "updated_at": "2023-03-06T10:41:17+00:00",
        "menu_id": "c991e000-e5bb-4718-b7a5-a9f67e959f7f",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c90ef5c4-0e1c-4176-8692-cbdeb21cb162' \
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