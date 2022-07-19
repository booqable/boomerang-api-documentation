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
`title` | **String**<br>Name of the menu.
`key` | **String**<br>Key the menu can be referenced by.
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
      "id": "ede71b67-6fb1-4710-b31f-a2611b6ff291",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-19T12:36:51+00:00",
        "updated_at": "2022-07-19T12:36:51+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=ede71b67-6fb1-4710-b31f-a2611b6ff291"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-19T12:34:46Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/a9d06c82-3ca2-41a5-9c77-c699b20f9689?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a9d06c82-3ca2-41a5-9c77-c699b20f9689",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-19T12:36:51+00:00",
      "updated_at": "2022-07-19T12:36:51+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a9d06c82-3ca2-41a5-9c77-c699b20f9689"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "9cf01681-2976-409d-820b-2f7ffdcfde96"
          },
          {
            "type": "menu_items",
            "id": "3173e76b-15e3-4f71-b3dd-0c29aa73edf8"
          },
          {
            "type": "menu_items",
            "id": "f5c52b49-2bdc-4829-a1d0-d5e1bc0b574c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9cf01681-2976-409d-820b-2f7ffdcfde96",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-19T12:36:51+00:00",
        "updated_at": "2022-07-19T12:36:51+00:00",
        "menu_id": "a9d06c82-3ca2-41a5-9c77-c699b20f9689",
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
            "related": "api/boomerang/menus/a9d06c82-3ca2-41a5-9c77-c699b20f9689"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9cf01681-2976-409d-820b-2f7ffdcfde96"
          }
        }
      }
    },
    {
      "id": "3173e76b-15e3-4f71-b3dd-0c29aa73edf8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-19T12:36:51+00:00",
        "updated_at": "2022-07-19T12:36:51+00:00",
        "menu_id": "a9d06c82-3ca2-41a5-9c77-c699b20f9689",
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
            "related": "api/boomerang/menus/a9d06c82-3ca2-41a5-9c77-c699b20f9689"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3173e76b-15e3-4f71-b3dd-0c29aa73edf8"
          }
        }
      }
    },
    {
      "id": "f5c52b49-2bdc-4829-a1d0-d5e1bc0b574c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-19T12:36:51+00:00",
        "updated_at": "2022-07-19T12:36:51+00:00",
        "menu_id": "a9d06c82-3ca2-41a5-9c77-c699b20f9689",
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
            "related": "api/boomerang/menus/a9d06c82-3ca2-41a5-9c77-c699b20f9689"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f5c52b49-2bdc-4829-a1d0-d5e1bc0b574c"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


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
    "id": "938372ce-852c-4a6c-9523-2ad42ab5cb8f",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-19T12:36:52+00:00",
      "updated_at": "2022-07-19T12:36:52+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/797c0e77-f8a6-4b7a-b828-63c8fdbd7918' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "797c0e77-f8a6-4b7a-b828-63c8fdbd7918",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e53ded6c-a189-454b-9831-57c506085539",
              "title": "Contact us"
            },
            {
              "id": "8d63094d-2347-4ba7-82be-d208ce9f5cd3",
              "title": "Start"
            },
            {
              "id": "f511b405-9d5a-43e6-a06b-e8f5699701b3",
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
    "id": "797c0e77-f8a6-4b7a-b828-63c8fdbd7918",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-19T12:36:52+00:00",
      "updated_at": "2022-07-19T12:36:52+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e53ded6c-a189-454b-9831-57c506085539"
          },
          {
            "type": "menu_items",
            "id": "8d63094d-2347-4ba7-82be-d208ce9f5cd3"
          },
          {
            "type": "menu_items",
            "id": "f511b405-9d5a-43e6-a06b-e8f5699701b3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e53ded6c-a189-454b-9831-57c506085539",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-19T12:36:52+00:00",
        "updated_at": "2022-07-19T12:36:52+00:00",
        "menu_id": "797c0e77-f8a6-4b7a-b828-63c8fdbd7918",
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
      "id": "8d63094d-2347-4ba7-82be-d208ce9f5cd3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-19T12:36:52+00:00",
        "updated_at": "2022-07-19T12:36:52+00:00",
        "menu_id": "797c0e77-f8a6-4b7a-b828-63c8fdbd7918",
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
      "id": "f511b405-9d5a-43e6-a06b-e8f5699701b3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-19T12:36:52+00:00",
        "updated_at": "2022-07-19T12:36:52+00:00",
        "menu_id": "797c0e77-f8a6-4b7a-b828-63c8fdbd7918",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/afbb64c7-13aa-4888-8e12-6b08a3890b06' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes