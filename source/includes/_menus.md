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
      "id": "4ca84f5c-427d-4d3f-a60e-18aec1500fcc",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-21T16:15:21+00:00",
        "updated_at": "2023-02-21T16:15:21+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=4ca84f5c-427d-4d3f-a60e-18aec1500fcc"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T16:13:02Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/2002406d-073d-4157-a19f-9affa66d0845?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2002406d-073d-4157-a19f-9affa66d0845",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-21T16:15:21+00:00",
      "updated_at": "2023-02-21T16:15:21+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=2002406d-073d-4157-a19f-9affa66d0845"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "25522b03-f486-4666-8836-f0c6da0edf9b"
          },
          {
            "type": "menu_items",
            "id": "7b65dc86-72e8-4cd0-b83a-a9eea79e0b30"
          },
          {
            "type": "menu_items",
            "id": "7f0e79ba-7816-4034-9807-e1fa946f017e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "25522b03-f486-4666-8836-f0c6da0edf9b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-21T16:15:21+00:00",
        "updated_at": "2023-02-21T16:15:21+00:00",
        "menu_id": "2002406d-073d-4157-a19f-9affa66d0845",
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
            "related": "api/boomerang/menus/2002406d-073d-4157-a19f-9affa66d0845"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=25522b03-f486-4666-8836-f0c6da0edf9b"
          }
        }
      }
    },
    {
      "id": "7b65dc86-72e8-4cd0-b83a-a9eea79e0b30",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-21T16:15:21+00:00",
        "updated_at": "2023-02-21T16:15:21+00:00",
        "menu_id": "2002406d-073d-4157-a19f-9affa66d0845",
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
            "related": "api/boomerang/menus/2002406d-073d-4157-a19f-9affa66d0845"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7b65dc86-72e8-4cd0-b83a-a9eea79e0b30"
          }
        }
      }
    },
    {
      "id": "7f0e79ba-7816-4034-9807-e1fa946f017e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-21T16:15:21+00:00",
        "updated_at": "2023-02-21T16:15:21+00:00",
        "menu_id": "2002406d-073d-4157-a19f-9affa66d0845",
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
            "related": "api/boomerang/menus/2002406d-073d-4157-a19f-9affa66d0845"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7f0e79ba-7816-4034-9807-e1fa946f017e"
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
    "id": "c15cbc04-ba9f-4d63-86e2-cfb845156788",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-21T16:15:22+00:00",
      "updated_at": "2023-02-21T16:15:22+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/429b61c4-ca57-45bd-b220-805337746972' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "429b61c4-ca57-45bd-b220-805337746972",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "9b2f43df-d09d-4c6d-8ec8-92d0b5d3ec09",
              "title": "Contact us"
            },
            {
              "id": "bedb23f0-937d-4c35-bdd6-c8dc4b4f2d7f",
              "title": "Start"
            },
            {
              "id": "12ee3e26-a786-4b26-ac89-8303068d7376",
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
    "id": "429b61c4-ca57-45bd-b220-805337746972",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-21T16:15:23+00:00",
      "updated_at": "2023-02-21T16:15:23+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "9b2f43df-d09d-4c6d-8ec8-92d0b5d3ec09"
          },
          {
            "type": "menu_items",
            "id": "bedb23f0-937d-4c35-bdd6-c8dc4b4f2d7f"
          },
          {
            "type": "menu_items",
            "id": "12ee3e26-a786-4b26-ac89-8303068d7376"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9b2f43df-d09d-4c6d-8ec8-92d0b5d3ec09",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-21T16:15:23+00:00",
        "updated_at": "2023-02-21T16:15:23+00:00",
        "menu_id": "429b61c4-ca57-45bd-b220-805337746972",
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
      "id": "bedb23f0-937d-4c35-bdd6-c8dc4b4f2d7f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-21T16:15:23+00:00",
        "updated_at": "2023-02-21T16:15:23+00:00",
        "menu_id": "429b61c4-ca57-45bd-b220-805337746972",
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
      "id": "12ee3e26-a786-4b26-ac89-8303068d7376",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-21T16:15:23+00:00",
        "updated_at": "2023-02-21T16:15:23+00:00",
        "menu_id": "429b61c4-ca57-45bd-b220-805337746972",
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
    --url 'https://example.booqable.com/api/boomerang/menus/39358db8-a5aa-4a69-a49d-0a14d03dc502' \
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