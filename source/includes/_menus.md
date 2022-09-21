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
      "id": "938ee874-ac46-409a-8170-ee7c84936058",
      "type": "menus",
      "attributes": {
        "created_at": "2022-09-21T09:07:16+00:00",
        "updated_at": "2022-09-21T09:07:16+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=938ee874-ac46-409a-8170-ee7c84936058"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-21T09:04:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/d5e980bc-5c66-447d-8b4d-93316f048baf?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d5e980bc-5c66-447d-8b4d-93316f048baf",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-21T09:07:17+00:00",
      "updated_at": "2022-09-21T09:07:17+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=d5e980bc-5c66-447d-8b4d-93316f048baf"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "5ebcfcb7-6167-4762-8c9e-bc790f3b684c"
          },
          {
            "type": "menu_items",
            "id": "d78578f5-f55e-42ac-ac2f-3782438fc6b0"
          },
          {
            "type": "menu_items",
            "id": "70c496b6-8ad8-4cd1-ac89-1a2a4ae9a7b5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5ebcfcb7-6167-4762-8c9e-bc790f3b684c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-21T09:07:17+00:00",
        "updated_at": "2022-09-21T09:07:17+00:00",
        "menu_id": "d5e980bc-5c66-447d-8b4d-93316f048baf",
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
            "related": "api/boomerang/menus/d5e980bc-5c66-447d-8b4d-93316f048baf"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5ebcfcb7-6167-4762-8c9e-bc790f3b684c"
          }
        }
      }
    },
    {
      "id": "d78578f5-f55e-42ac-ac2f-3782438fc6b0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-21T09:07:17+00:00",
        "updated_at": "2022-09-21T09:07:17+00:00",
        "menu_id": "d5e980bc-5c66-447d-8b4d-93316f048baf",
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
            "related": "api/boomerang/menus/d5e980bc-5c66-447d-8b4d-93316f048baf"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d78578f5-f55e-42ac-ac2f-3782438fc6b0"
          }
        }
      }
    },
    {
      "id": "70c496b6-8ad8-4cd1-ac89-1a2a4ae9a7b5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-21T09:07:17+00:00",
        "updated_at": "2022-09-21T09:07:17+00:00",
        "menu_id": "d5e980bc-5c66-447d-8b4d-93316f048baf",
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
            "related": "api/boomerang/menus/d5e980bc-5c66-447d-8b4d-93316f048baf"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=70c496b6-8ad8-4cd1-ac89-1a2a4ae9a7b5"
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
    "id": "93b910e2-100d-4419-a117-f69c640cd4b8",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-21T09:07:18+00:00",
      "updated_at": "2022-09-21T09:07:18+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/dac6ffdd-49f6-4316-8930-068a9d6fd18f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dac6ffdd-49f6-4316-8930-068a9d6fd18f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "9ffd08c3-98aa-46e1-9ee4-01337e1cc361",
              "title": "Contact us"
            },
            {
              "id": "ace4ba05-0498-49cf-b7cd-a7cc1fbcb05e",
              "title": "Start"
            },
            {
              "id": "aed3969b-c9fa-4ac2-a20f-ab741a567eab",
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
    "id": "dac6ffdd-49f6-4316-8930-068a9d6fd18f",
    "type": "menus",
    "attributes": {
      "created_at": "2022-09-21T09:07:18+00:00",
      "updated_at": "2022-09-21T09:07:18+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "9ffd08c3-98aa-46e1-9ee4-01337e1cc361"
          },
          {
            "type": "menu_items",
            "id": "ace4ba05-0498-49cf-b7cd-a7cc1fbcb05e"
          },
          {
            "type": "menu_items",
            "id": "aed3969b-c9fa-4ac2-a20f-ab741a567eab"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9ffd08c3-98aa-46e1-9ee4-01337e1cc361",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-21T09:07:18+00:00",
        "updated_at": "2022-09-21T09:07:18+00:00",
        "menu_id": "dac6ffdd-49f6-4316-8930-068a9d6fd18f",
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
      "id": "ace4ba05-0498-49cf-b7cd-a7cc1fbcb05e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-21T09:07:18+00:00",
        "updated_at": "2022-09-21T09:07:18+00:00",
        "menu_id": "dac6ffdd-49f6-4316-8930-068a9d6fd18f",
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
      "id": "aed3969b-c9fa-4ac2-a20f-ab741a567eab",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-09-21T09:07:18+00:00",
        "updated_at": "2022-09-21T09:07:18+00:00",
        "menu_id": "dac6ffdd-49f6-4316-8930-068a9d6fd18f",
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
    --url 'https://example.booqable.com/api/boomerang/menus/40775a41-d6a5-4ba3-ad44-481930a32e0f' \
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