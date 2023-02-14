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
      "id": "286c28bb-106f-4aba-b276-f046f8b15a98",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-14T11:05:29+00:00",
        "updated_at": "2023-02-14T11:05:29+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=286c28bb-106f-4aba-b276-f046f8b15a98"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T11:03:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/dfbaf37f-4e3e-40be-9a1a-c1d142df2db8?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dfbaf37f-4e3e-40be-9a1a-c1d142df2db8",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T11:05:30+00:00",
      "updated_at": "2023-02-14T11:05:30+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=dfbaf37f-4e3e-40be-9a1a-c1d142df2db8"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "9e993635-fbe6-412a-8d84-9c570f03169f"
          },
          {
            "type": "menu_items",
            "id": "158f5df3-ae19-41f0-b6cd-48c6fb8d2600"
          },
          {
            "type": "menu_items",
            "id": "b83af6bb-9c91-4a27-8174-68ebcf39462e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9e993635-fbe6-412a-8d84-9c570f03169f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:05:30+00:00",
        "updated_at": "2023-02-14T11:05:30+00:00",
        "menu_id": "dfbaf37f-4e3e-40be-9a1a-c1d142df2db8",
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
            "related": "api/boomerang/menus/dfbaf37f-4e3e-40be-9a1a-c1d142df2db8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9e993635-fbe6-412a-8d84-9c570f03169f"
          }
        }
      }
    },
    {
      "id": "158f5df3-ae19-41f0-b6cd-48c6fb8d2600",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:05:30+00:00",
        "updated_at": "2023-02-14T11:05:30+00:00",
        "menu_id": "dfbaf37f-4e3e-40be-9a1a-c1d142df2db8",
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
            "related": "api/boomerang/menus/dfbaf37f-4e3e-40be-9a1a-c1d142df2db8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=158f5df3-ae19-41f0-b6cd-48c6fb8d2600"
          }
        }
      }
    },
    {
      "id": "b83af6bb-9c91-4a27-8174-68ebcf39462e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:05:30+00:00",
        "updated_at": "2023-02-14T11:05:30+00:00",
        "menu_id": "dfbaf37f-4e3e-40be-9a1a-c1d142df2db8",
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
            "related": "api/boomerang/menus/dfbaf37f-4e3e-40be-9a1a-c1d142df2db8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b83af6bb-9c91-4a27-8174-68ebcf39462e"
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
    "id": "b1ae8e35-b21b-46f3-bc29-dfc90f531886",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T11:05:31+00:00",
      "updated_at": "2023-02-14T11:05:31+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/633758b3-bf16-42a1-83cc-ed032a07d8c5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "633758b3-bf16-42a1-83cc-ed032a07d8c5",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "68f2beac-2323-4586-ab32-22e505c76fc6",
              "title": "Contact us"
            },
            {
              "id": "6c22ab92-e574-4d5c-ab8b-c791c9a0db7d",
              "title": "Start"
            },
            {
              "id": "1b42f814-3356-421d-bfcb-4f43c849691e",
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
    "id": "633758b3-bf16-42a1-83cc-ed032a07d8c5",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T11:05:32+00:00",
      "updated_at": "2023-02-14T11:05:32+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "68f2beac-2323-4586-ab32-22e505c76fc6"
          },
          {
            "type": "menu_items",
            "id": "6c22ab92-e574-4d5c-ab8b-c791c9a0db7d"
          },
          {
            "type": "menu_items",
            "id": "1b42f814-3356-421d-bfcb-4f43c849691e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "68f2beac-2323-4586-ab32-22e505c76fc6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:05:32+00:00",
        "updated_at": "2023-02-14T11:05:32+00:00",
        "menu_id": "633758b3-bf16-42a1-83cc-ed032a07d8c5",
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
      "id": "6c22ab92-e574-4d5c-ab8b-c791c9a0db7d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:05:32+00:00",
        "updated_at": "2023-02-14T11:05:32+00:00",
        "menu_id": "633758b3-bf16-42a1-83cc-ed032a07d8c5",
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
      "id": "1b42f814-3356-421d-bfcb-4f43c849691e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:05:32+00:00",
        "updated_at": "2023-02-14T11:05:32+00:00",
        "menu_id": "633758b3-bf16-42a1-83cc-ed032a07d8c5",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fcdff273-0e9e-4dce-8445-69c5590d3199' \
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