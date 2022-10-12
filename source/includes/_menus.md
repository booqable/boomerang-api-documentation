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
      "id": "b73f99b4-dc8e-4f42-97bf-56f0e7ce3511",
      "type": "menus",
      "attributes": {
        "created_at": "2022-10-12T12:58:24+00:00",
        "updated_at": "2022-10-12T12:58:24+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=b73f99b4-dc8e-4f42-97bf-56f0e7ce3511"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-12T12:56:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/2666471a-16c6-4100-9c8b-a51b27079d03?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2666471a-16c6-4100-9c8b-a51b27079d03",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-12T12:58:25+00:00",
      "updated_at": "2022-10-12T12:58:25+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=2666471a-16c6-4100-9c8b-a51b27079d03"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ccc8b96d-6145-4aad-800d-05a287db0d6a"
          },
          {
            "type": "menu_items",
            "id": "0f9936a1-1149-425f-b25c-bbaa634e6c6e"
          },
          {
            "type": "menu_items",
            "id": "5b0c7e13-1701-403c-a1f3-6178967a1623"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ccc8b96d-6145-4aad-800d-05a287db0d6a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-12T12:58:25+00:00",
        "updated_at": "2022-10-12T12:58:25+00:00",
        "menu_id": "2666471a-16c6-4100-9c8b-a51b27079d03",
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
            "related": "api/boomerang/menus/2666471a-16c6-4100-9c8b-a51b27079d03"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ccc8b96d-6145-4aad-800d-05a287db0d6a"
          }
        }
      }
    },
    {
      "id": "0f9936a1-1149-425f-b25c-bbaa634e6c6e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-12T12:58:25+00:00",
        "updated_at": "2022-10-12T12:58:25+00:00",
        "menu_id": "2666471a-16c6-4100-9c8b-a51b27079d03",
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
            "related": "api/boomerang/menus/2666471a-16c6-4100-9c8b-a51b27079d03"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0f9936a1-1149-425f-b25c-bbaa634e6c6e"
          }
        }
      }
    },
    {
      "id": "5b0c7e13-1701-403c-a1f3-6178967a1623",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-12T12:58:25+00:00",
        "updated_at": "2022-10-12T12:58:25+00:00",
        "menu_id": "2666471a-16c6-4100-9c8b-a51b27079d03",
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
            "related": "api/boomerang/menus/2666471a-16c6-4100-9c8b-a51b27079d03"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5b0c7e13-1701-403c-a1f3-6178967a1623"
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
    "id": "ded216d7-e72d-481f-85a4-a0d22912ccf0",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-12T12:58:25+00:00",
      "updated_at": "2022-10-12T12:58:25+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ea7df5fa-e5b1-49f8-a30e-531f364538e9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ea7df5fa-e5b1-49f8-a30e-531f364538e9",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "48661fa9-b7a7-4758-bdb2-c9fe4c1ad948",
              "title": "Contact us"
            },
            {
              "id": "2ff1e61f-b033-43ac-8e6b-9ece3f7793da",
              "title": "Start"
            },
            {
              "id": "aa81e669-e133-438d-80d2-898a5ea107b4",
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
    "id": "ea7df5fa-e5b1-49f8-a30e-531f364538e9",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-12T12:58:26+00:00",
      "updated_at": "2022-10-12T12:58:26+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "48661fa9-b7a7-4758-bdb2-c9fe4c1ad948"
          },
          {
            "type": "menu_items",
            "id": "2ff1e61f-b033-43ac-8e6b-9ece3f7793da"
          },
          {
            "type": "menu_items",
            "id": "aa81e669-e133-438d-80d2-898a5ea107b4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "48661fa9-b7a7-4758-bdb2-c9fe4c1ad948",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-12T12:58:26+00:00",
        "updated_at": "2022-10-12T12:58:26+00:00",
        "menu_id": "ea7df5fa-e5b1-49f8-a30e-531f364538e9",
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
      "id": "2ff1e61f-b033-43ac-8e6b-9ece3f7793da",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-12T12:58:26+00:00",
        "updated_at": "2022-10-12T12:58:26+00:00",
        "menu_id": "ea7df5fa-e5b1-49f8-a30e-531f364538e9",
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
      "id": "aa81e669-e133-438d-80d2-898a5ea107b4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-12T12:58:26+00:00",
        "updated_at": "2022-10-12T12:58:26+00:00",
        "menu_id": "ea7df5fa-e5b1-49f8-a30e-531f364538e9",
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
    --url 'https://example.booqable.com/api/boomerang/menus/111cefed-2666-453c-9d03-5da0a6074b51' \
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