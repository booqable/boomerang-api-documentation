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
      "id": "2c3dbad1-2465-409b-a7ee-90b0d699f24c",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-07T07:57:30+00:00",
        "updated_at": "2023-03-07T07:57:30+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=2c3dbad1-2465-409b-a7ee-90b0d699f24c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T07:55:09Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/6d06fd02-79c8-4255-a27b-add8d366eddf?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6d06fd02-79c8-4255-a27b-add8d366eddf",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T07:57:30+00:00",
      "updated_at": "2023-03-07T07:57:30+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=6d06fd02-79c8-4255-a27b-add8d366eddf"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "aa016d80-9c32-4327-bc4e-4ad0f23ddde3"
          },
          {
            "type": "menu_items",
            "id": "06385c72-7c7f-4f73-b5ef-b060b1072012"
          },
          {
            "type": "menu_items",
            "id": "a117c4f5-a292-4cfb-9079-5368f7a90764"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "aa016d80-9c32-4327-bc4e-4ad0f23ddde3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T07:57:30+00:00",
        "updated_at": "2023-03-07T07:57:30+00:00",
        "menu_id": "6d06fd02-79c8-4255-a27b-add8d366eddf",
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
            "related": "api/boomerang/menus/6d06fd02-79c8-4255-a27b-add8d366eddf"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=aa016d80-9c32-4327-bc4e-4ad0f23ddde3"
          }
        }
      }
    },
    {
      "id": "06385c72-7c7f-4f73-b5ef-b060b1072012",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T07:57:30+00:00",
        "updated_at": "2023-03-07T07:57:30+00:00",
        "menu_id": "6d06fd02-79c8-4255-a27b-add8d366eddf",
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
            "related": "api/boomerang/menus/6d06fd02-79c8-4255-a27b-add8d366eddf"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=06385c72-7c7f-4f73-b5ef-b060b1072012"
          }
        }
      }
    },
    {
      "id": "a117c4f5-a292-4cfb-9079-5368f7a90764",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T07:57:30+00:00",
        "updated_at": "2023-03-07T07:57:30+00:00",
        "menu_id": "6d06fd02-79c8-4255-a27b-add8d366eddf",
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
            "related": "api/boomerang/menus/6d06fd02-79c8-4255-a27b-add8d366eddf"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a117c4f5-a292-4cfb-9079-5368f7a90764"
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
    "id": "a37c2727-dd24-4d2b-b4d4-6eac9a9b9853",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T07:57:31+00:00",
      "updated_at": "2023-03-07T07:57:31+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f2584b04-b264-4f83-986a-ecb5d7145918' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f2584b04-b264-4f83-986a-ecb5d7145918",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "b5dd4bdf-9ce4-4290-bf86-b252428084f7",
              "title": "Contact us"
            },
            {
              "id": "dfff445c-2060-4a34-a939-4d0c4748fca2",
              "title": "Start"
            },
            {
              "id": "36d71c9a-cbca-44ea-918a-d45bbac0d3ea",
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
    "id": "f2584b04-b264-4f83-986a-ecb5d7145918",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T07:57:32+00:00",
      "updated_at": "2023-03-07T07:57:32+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "b5dd4bdf-9ce4-4290-bf86-b252428084f7"
          },
          {
            "type": "menu_items",
            "id": "dfff445c-2060-4a34-a939-4d0c4748fca2"
          },
          {
            "type": "menu_items",
            "id": "36d71c9a-cbca-44ea-918a-d45bbac0d3ea"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b5dd4bdf-9ce4-4290-bf86-b252428084f7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T07:57:32+00:00",
        "updated_at": "2023-03-07T07:57:32+00:00",
        "menu_id": "f2584b04-b264-4f83-986a-ecb5d7145918",
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
      "id": "dfff445c-2060-4a34-a939-4d0c4748fca2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T07:57:32+00:00",
        "updated_at": "2023-03-07T07:57:32+00:00",
        "menu_id": "f2584b04-b264-4f83-986a-ecb5d7145918",
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
      "id": "36d71c9a-cbca-44ea-918a-d45bbac0d3ea",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T07:57:32+00:00",
        "updated_at": "2023-03-07T07:57:32+00:00",
        "menu_id": "f2584b04-b264-4f83-986a-ecb5d7145918",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ba857a8c-4cbf-4b14-a072-3d7ccf31c96b' \
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