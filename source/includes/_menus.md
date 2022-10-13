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
      "id": "475bdf28-58ef-4325-be8b-e25230caa987",
      "type": "menus",
      "attributes": {
        "created_at": "2022-10-13T15:43:54+00:00",
        "updated_at": "2022-10-13T15:43:54+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=475bdf28-58ef-4325-be8b-e25230caa987"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T15:41:57Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/4fb4cecf-ba41-4f1c-8d07-02257ab6bffe?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4fb4cecf-ba41-4f1c-8d07-02257ab6bffe",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-13T15:43:54+00:00",
      "updated_at": "2022-10-13T15:43:54+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=4fb4cecf-ba41-4f1c-8d07-02257ab6bffe"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "8beca49d-9812-42a1-957a-3faff879a75f"
          },
          {
            "type": "menu_items",
            "id": "d3ed9a69-9f76-459e-a38d-07f70c133c55"
          },
          {
            "type": "menu_items",
            "id": "546ce6f7-92a0-4819-9e5b-119f548ad61f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8beca49d-9812-42a1-957a-3faff879a75f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T15:43:54+00:00",
        "updated_at": "2022-10-13T15:43:54+00:00",
        "menu_id": "4fb4cecf-ba41-4f1c-8d07-02257ab6bffe",
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
            "related": "api/boomerang/menus/4fb4cecf-ba41-4f1c-8d07-02257ab6bffe"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8beca49d-9812-42a1-957a-3faff879a75f"
          }
        }
      }
    },
    {
      "id": "d3ed9a69-9f76-459e-a38d-07f70c133c55",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T15:43:54+00:00",
        "updated_at": "2022-10-13T15:43:54+00:00",
        "menu_id": "4fb4cecf-ba41-4f1c-8d07-02257ab6bffe",
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
            "related": "api/boomerang/menus/4fb4cecf-ba41-4f1c-8d07-02257ab6bffe"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d3ed9a69-9f76-459e-a38d-07f70c133c55"
          }
        }
      }
    },
    {
      "id": "546ce6f7-92a0-4819-9e5b-119f548ad61f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T15:43:54+00:00",
        "updated_at": "2022-10-13T15:43:54+00:00",
        "menu_id": "4fb4cecf-ba41-4f1c-8d07-02257ab6bffe",
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
            "related": "api/boomerang/menus/4fb4cecf-ba41-4f1c-8d07-02257ab6bffe"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=546ce6f7-92a0-4819-9e5b-119f548ad61f"
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
    "id": "e4066117-4fbd-40be-9eac-b774b0d92dfd",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-13T15:43:54+00:00",
      "updated_at": "2022-10-13T15:43:54+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/47c35cb0-57d4-4245-b0d2-dd036239ec58' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "47c35cb0-57d4-4245-b0d2-dd036239ec58",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "9d082a42-ab90-4171-aa39-345f962bd7f0",
              "title": "Contact us"
            },
            {
              "id": "0accb699-4c9b-416b-90f8-4fa385b736a3",
              "title": "Start"
            },
            {
              "id": "63552749-c926-487e-b753-f8ae3e2a3e76",
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
    "id": "47c35cb0-57d4-4245-b0d2-dd036239ec58",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-13T15:43:55+00:00",
      "updated_at": "2022-10-13T15:43:55+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "9d082a42-ab90-4171-aa39-345f962bd7f0"
          },
          {
            "type": "menu_items",
            "id": "0accb699-4c9b-416b-90f8-4fa385b736a3"
          },
          {
            "type": "menu_items",
            "id": "63552749-c926-487e-b753-f8ae3e2a3e76"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9d082a42-ab90-4171-aa39-345f962bd7f0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T15:43:55+00:00",
        "updated_at": "2022-10-13T15:43:55+00:00",
        "menu_id": "47c35cb0-57d4-4245-b0d2-dd036239ec58",
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
      "id": "0accb699-4c9b-416b-90f8-4fa385b736a3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T15:43:55+00:00",
        "updated_at": "2022-10-13T15:43:55+00:00",
        "menu_id": "47c35cb0-57d4-4245-b0d2-dd036239ec58",
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
      "id": "63552749-c926-487e-b753-f8ae3e2a3e76",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T15:43:55+00:00",
        "updated_at": "2022-10-13T15:43:55+00:00",
        "menu_id": "47c35cb0-57d4-4245-b0d2-dd036239ec58",
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
    --url 'https://example.booqable.com/api/boomerang/menus/502856fe-00d7-4e4a-b3c5-59379f7c5c66' \
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