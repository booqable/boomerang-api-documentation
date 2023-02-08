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
      "id": "b84444b0-0a70-4b0d-a4f6-b9b1192064e6",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-08T09:46:00+00:00",
        "updated_at": "2023-02-08T09:46:00+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=b84444b0-0a70-4b0d-a4f6-b9b1192064e6"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T09:43:44Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/7d083102-300f-40a3-9e51-4b06734973ee?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7d083102-300f-40a3-9e51-4b06734973ee",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T09:46:00+00:00",
      "updated_at": "2023-02-08T09:46:00+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=7d083102-300f-40a3-9e51-4b06734973ee"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "6ef47c41-7ee4-4d80-a553-cb24fbcbc843"
          },
          {
            "type": "menu_items",
            "id": "a35caba0-6965-47c8-aab4-2e0de25863d4"
          },
          {
            "type": "menu_items",
            "id": "3aa37c0a-e925-45c8-922d-24380fbb2950"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6ef47c41-7ee4-4d80-a553-cb24fbcbc843",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T09:46:00+00:00",
        "updated_at": "2023-02-08T09:46:00+00:00",
        "menu_id": "7d083102-300f-40a3-9e51-4b06734973ee",
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
            "related": "api/boomerang/menus/7d083102-300f-40a3-9e51-4b06734973ee"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6ef47c41-7ee4-4d80-a553-cb24fbcbc843"
          }
        }
      }
    },
    {
      "id": "a35caba0-6965-47c8-aab4-2e0de25863d4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T09:46:00+00:00",
        "updated_at": "2023-02-08T09:46:00+00:00",
        "menu_id": "7d083102-300f-40a3-9e51-4b06734973ee",
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
            "related": "api/boomerang/menus/7d083102-300f-40a3-9e51-4b06734973ee"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a35caba0-6965-47c8-aab4-2e0de25863d4"
          }
        }
      }
    },
    {
      "id": "3aa37c0a-e925-45c8-922d-24380fbb2950",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T09:46:00+00:00",
        "updated_at": "2023-02-08T09:46:00+00:00",
        "menu_id": "7d083102-300f-40a3-9e51-4b06734973ee",
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
            "related": "api/boomerang/menus/7d083102-300f-40a3-9e51-4b06734973ee"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3aa37c0a-e925-45c8-922d-24380fbb2950"
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
    "id": "8027cbd4-1158-4ce6-9867-b1da9143325c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T09:46:01+00:00",
      "updated_at": "2023-02-08T09:46:01+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/29d3bce5-fe5a-46a9-8c7a-21e574660bf4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "29d3bce5-fe5a-46a9-8c7a-21e574660bf4",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "71e44186-4957-4fe0-95f0-d1db5e6dd76f",
              "title": "Contact us"
            },
            {
              "id": "01094607-e82f-4031-96cd-68fdd573ccbf",
              "title": "Start"
            },
            {
              "id": "9ce25e43-b371-44f8-917b-e34fb2d7390d",
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
    "id": "29d3bce5-fe5a-46a9-8c7a-21e574660bf4",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T09:46:01+00:00",
      "updated_at": "2023-02-08T09:46:01+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "71e44186-4957-4fe0-95f0-d1db5e6dd76f"
          },
          {
            "type": "menu_items",
            "id": "01094607-e82f-4031-96cd-68fdd573ccbf"
          },
          {
            "type": "menu_items",
            "id": "9ce25e43-b371-44f8-917b-e34fb2d7390d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "71e44186-4957-4fe0-95f0-d1db5e6dd76f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T09:46:01+00:00",
        "updated_at": "2023-02-08T09:46:01+00:00",
        "menu_id": "29d3bce5-fe5a-46a9-8c7a-21e574660bf4",
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
      "id": "01094607-e82f-4031-96cd-68fdd573ccbf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T09:46:01+00:00",
        "updated_at": "2023-02-08T09:46:01+00:00",
        "menu_id": "29d3bce5-fe5a-46a9-8c7a-21e574660bf4",
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
      "id": "9ce25e43-b371-44f8-917b-e34fb2d7390d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T09:46:01+00:00",
        "updated_at": "2023-02-08T09:46:01+00:00",
        "menu_id": "29d3bce5-fe5a-46a9-8c7a-21e574660bf4",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7cd6a1dd-ab42-4919-8bad-f47610157b29' \
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