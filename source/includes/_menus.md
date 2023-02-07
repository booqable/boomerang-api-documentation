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
      "id": "623618e9-88a0-403b-a90b-9e0fe7ce3d3f",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-07T15:18:52+00:00",
        "updated_at": "2023-02-07T15:18:52+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=623618e9-88a0-403b-a90b-9e0fe7ce3d3f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T15:17:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/a0a2cf09-db31-4067-869a-6cfb9489fa60?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a0a2cf09-db31-4067-869a-6cfb9489fa60",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T15:18:52+00:00",
      "updated_at": "2023-02-07T15:18:52+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a0a2cf09-db31-4067-869a-6cfb9489fa60"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "034a821b-0a84-4bdc-b183-c8527bddac91"
          },
          {
            "type": "menu_items",
            "id": "384d2a77-c9ae-4405-b29c-d0c6b72d6e4b"
          },
          {
            "type": "menu_items",
            "id": "190fb970-c168-4b08-80b6-cf03c8a60105"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "034a821b-0a84-4bdc-b183-c8527bddac91",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T15:18:52+00:00",
        "updated_at": "2023-02-07T15:18:52+00:00",
        "menu_id": "a0a2cf09-db31-4067-869a-6cfb9489fa60",
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
            "related": "api/boomerang/menus/a0a2cf09-db31-4067-869a-6cfb9489fa60"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=034a821b-0a84-4bdc-b183-c8527bddac91"
          }
        }
      }
    },
    {
      "id": "384d2a77-c9ae-4405-b29c-d0c6b72d6e4b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T15:18:52+00:00",
        "updated_at": "2023-02-07T15:18:52+00:00",
        "menu_id": "a0a2cf09-db31-4067-869a-6cfb9489fa60",
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
            "related": "api/boomerang/menus/a0a2cf09-db31-4067-869a-6cfb9489fa60"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=384d2a77-c9ae-4405-b29c-d0c6b72d6e4b"
          }
        }
      }
    },
    {
      "id": "190fb970-c168-4b08-80b6-cf03c8a60105",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T15:18:52+00:00",
        "updated_at": "2023-02-07T15:18:52+00:00",
        "menu_id": "a0a2cf09-db31-4067-869a-6cfb9489fa60",
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
            "related": "api/boomerang/menus/a0a2cf09-db31-4067-869a-6cfb9489fa60"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=190fb970-c168-4b08-80b6-cf03c8a60105"
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
    "id": "7b0f53e2-b94d-4c60-a690-08a95b05cbc2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T15:18:52+00:00",
      "updated_at": "2023-02-07T15:18:52+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/803e82e1-2db5-4c5b-a556-f606495d41d9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "803e82e1-2db5-4c5b-a556-f606495d41d9",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "b4746365-ee63-4219-9533-00f1399fdfdc",
              "title": "Contact us"
            },
            {
              "id": "a63e0636-289b-4f71-9963-832e3518e744",
              "title": "Start"
            },
            {
              "id": "5ae2483a-bb23-4416-bc9c-b527b75bd48a",
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
    "id": "803e82e1-2db5-4c5b-a556-f606495d41d9",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T15:18:53+00:00",
      "updated_at": "2023-02-07T15:18:53+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "b4746365-ee63-4219-9533-00f1399fdfdc"
          },
          {
            "type": "menu_items",
            "id": "a63e0636-289b-4f71-9963-832e3518e744"
          },
          {
            "type": "menu_items",
            "id": "5ae2483a-bb23-4416-bc9c-b527b75bd48a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b4746365-ee63-4219-9533-00f1399fdfdc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T15:18:53+00:00",
        "updated_at": "2023-02-07T15:18:53+00:00",
        "menu_id": "803e82e1-2db5-4c5b-a556-f606495d41d9",
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
      "id": "a63e0636-289b-4f71-9963-832e3518e744",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T15:18:53+00:00",
        "updated_at": "2023-02-07T15:18:53+00:00",
        "menu_id": "803e82e1-2db5-4c5b-a556-f606495d41d9",
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
      "id": "5ae2483a-bb23-4416-bc9c-b527b75bd48a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T15:18:53+00:00",
        "updated_at": "2023-02-07T15:18:53+00:00",
        "menu_id": "803e82e1-2db5-4c5b-a556-f606495d41d9",
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
    --url 'https://example.booqable.com/api/boomerang/menus/11d9e94a-970c-45b4-9f6e-82e4522025bf' \
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