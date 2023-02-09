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
      "id": "1c04bc91-91ea-46a1-9ffc-92cb7476a370",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-09T10:19:54+00:00",
        "updated_at": "2023-02-09T10:19:54+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=1c04bc91-91ea-46a1-9ffc-92cb7476a370"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:17:41Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/39646baf-578d-4b68-9192-941cd063f241?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "39646baf-578d-4b68-9192-941cd063f241",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T10:19:55+00:00",
      "updated_at": "2023-02-09T10:19:55+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=39646baf-578d-4b68-9192-941cd063f241"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "0d7576d1-074e-4fc7-b7bf-245fdc3566cb"
          },
          {
            "type": "menu_items",
            "id": "b60e747e-2c34-4483-8ad2-40dbed69876f"
          },
          {
            "type": "menu_items",
            "id": "daef88c1-99d6-4ca7-822d-8a5d353217ac"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0d7576d1-074e-4fc7-b7bf-245fdc3566cb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T10:19:55+00:00",
        "updated_at": "2023-02-09T10:19:55+00:00",
        "menu_id": "39646baf-578d-4b68-9192-941cd063f241",
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
            "related": "api/boomerang/menus/39646baf-578d-4b68-9192-941cd063f241"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0d7576d1-074e-4fc7-b7bf-245fdc3566cb"
          }
        }
      }
    },
    {
      "id": "b60e747e-2c34-4483-8ad2-40dbed69876f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T10:19:55+00:00",
        "updated_at": "2023-02-09T10:19:55+00:00",
        "menu_id": "39646baf-578d-4b68-9192-941cd063f241",
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
            "related": "api/boomerang/menus/39646baf-578d-4b68-9192-941cd063f241"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b60e747e-2c34-4483-8ad2-40dbed69876f"
          }
        }
      }
    },
    {
      "id": "daef88c1-99d6-4ca7-822d-8a5d353217ac",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T10:19:55+00:00",
        "updated_at": "2023-02-09T10:19:55+00:00",
        "menu_id": "39646baf-578d-4b68-9192-941cd063f241",
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
            "related": "api/boomerang/menus/39646baf-578d-4b68-9192-941cd063f241"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=daef88c1-99d6-4ca7-822d-8a5d353217ac"
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
    "id": "b8ffead8-940b-41ff-82aa-cbc69e223da2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T10:19:56+00:00",
      "updated_at": "2023-02-09T10:19:56+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ce4db575-be31-440e-854f-fcbedd8bc8b1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ce4db575-be31-440e-854f-fcbedd8bc8b1",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "65ba67a0-efd7-4e49-a850-2ba3ae79addc",
              "title": "Contact us"
            },
            {
              "id": "fbc1229e-7c41-4626-9863-63be5c6c46ac",
              "title": "Start"
            },
            {
              "id": "a8e70b62-cafb-429b-afab-b080586c943c",
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
    "id": "ce4db575-be31-440e-854f-fcbedd8bc8b1",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T10:19:56+00:00",
      "updated_at": "2023-02-09T10:19:56+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "65ba67a0-efd7-4e49-a850-2ba3ae79addc"
          },
          {
            "type": "menu_items",
            "id": "fbc1229e-7c41-4626-9863-63be5c6c46ac"
          },
          {
            "type": "menu_items",
            "id": "a8e70b62-cafb-429b-afab-b080586c943c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "65ba67a0-efd7-4e49-a850-2ba3ae79addc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T10:19:56+00:00",
        "updated_at": "2023-02-09T10:19:56+00:00",
        "menu_id": "ce4db575-be31-440e-854f-fcbedd8bc8b1",
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
      "id": "fbc1229e-7c41-4626-9863-63be5c6c46ac",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T10:19:56+00:00",
        "updated_at": "2023-02-09T10:19:56+00:00",
        "menu_id": "ce4db575-be31-440e-854f-fcbedd8bc8b1",
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
      "id": "a8e70b62-cafb-429b-afab-b080586c943c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T10:19:56+00:00",
        "updated_at": "2023-02-09T10:19:56+00:00",
        "menu_id": "ce4db575-be31-440e-854f-fcbedd8bc8b1",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7c8ef963-4ed6-484d-a697-059e63f14814' \
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