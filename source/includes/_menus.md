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
      "id": "e75a20c2-7839-4a6d-8dd1-921882c4156d",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-07T08:07:30+00:00",
        "updated_at": "2023-02-07T08:07:30+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=e75a20c2-7839-4a6d-8dd1-921882c4156d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T08:05:40Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/6231654c-da85-430d-85ae-702048794db6?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6231654c-da85-430d-85ae-702048794db6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T08:07:31+00:00",
      "updated_at": "2023-02-07T08:07:31+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=6231654c-da85-430d-85ae-702048794db6"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "4624e152-7821-4f3f-a265-9ebabb6d132e"
          },
          {
            "type": "menu_items",
            "id": "8dbc1285-7e77-4618-b5f9-5b8fb3a9372a"
          },
          {
            "type": "menu_items",
            "id": "5a374682-35b7-45f8-9cb5-1fafe36ba5fe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4624e152-7821-4f3f-a265-9ebabb6d132e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T08:07:31+00:00",
        "updated_at": "2023-02-07T08:07:31+00:00",
        "menu_id": "6231654c-da85-430d-85ae-702048794db6",
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
            "related": "api/boomerang/menus/6231654c-da85-430d-85ae-702048794db6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4624e152-7821-4f3f-a265-9ebabb6d132e"
          }
        }
      }
    },
    {
      "id": "8dbc1285-7e77-4618-b5f9-5b8fb3a9372a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T08:07:31+00:00",
        "updated_at": "2023-02-07T08:07:31+00:00",
        "menu_id": "6231654c-da85-430d-85ae-702048794db6",
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
            "related": "api/boomerang/menus/6231654c-da85-430d-85ae-702048794db6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8dbc1285-7e77-4618-b5f9-5b8fb3a9372a"
          }
        }
      }
    },
    {
      "id": "5a374682-35b7-45f8-9cb5-1fafe36ba5fe",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T08:07:31+00:00",
        "updated_at": "2023-02-07T08:07:31+00:00",
        "menu_id": "6231654c-da85-430d-85ae-702048794db6",
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
            "related": "api/boomerang/menus/6231654c-da85-430d-85ae-702048794db6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5a374682-35b7-45f8-9cb5-1fafe36ba5fe"
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
    "id": "ea136d11-81fe-472e-aa3a-7add9890b292",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T08:07:31+00:00",
      "updated_at": "2023-02-07T08:07:31+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ccd53cc1-afb3-4654-87dc-a254bc1e16f6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ccd53cc1-afb3-4654-87dc-a254bc1e16f6",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "2cb897e0-bf16-48ef-b655-58ff4601779d",
              "title": "Contact us"
            },
            {
              "id": "07b5c2af-defb-4038-a9e3-21c418efec34",
              "title": "Start"
            },
            {
              "id": "5132292a-a6f2-417a-b361-a70f332c6bbe",
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
    "id": "ccd53cc1-afb3-4654-87dc-a254bc1e16f6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T08:07:31+00:00",
      "updated_at": "2023-02-07T08:07:31+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "2cb897e0-bf16-48ef-b655-58ff4601779d"
          },
          {
            "type": "menu_items",
            "id": "07b5c2af-defb-4038-a9e3-21c418efec34"
          },
          {
            "type": "menu_items",
            "id": "5132292a-a6f2-417a-b361-a70f332c6bbe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2cb897e0-bf16-48ef-b655-58ff4601779d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T08:07:31+00:00",
        "updated_at": "2023-02-07T08:07:31+00:00",
        "menu_id": "ccd53cc1-afb3-4654-87dc-a254bc1e16f6",
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
      "id": "07b5c2af-defb-4038-a9e3-21c418efec34",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T08:07:31+00:00",
        "updated_at": "2023-02-07T08:07:31+00:00",
        "menu_id": "ccd53cc1-afb3-4654-87dc-a254bc1e16f6",
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
      "id": "5132292a-a6f2-417a-b361-a70f332c6bbe",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T08:07:31+00:00",
        "updated_at": "2023-02-07T08:07:31+00:00",
        "menu_id": "ccd53cc1-afb3-4654-87dc-a254bc1e16f6",
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
    --url 'https://example.booqable.com/api/boomerang/menus/133f7529-a6e1-4b64-a813-d337af4fd49a' \
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