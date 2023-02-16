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
      "id": "ce4dbb7c-b6fa-4c0d-aab7-ca2085a0643a",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-16T10:00:48+00:00",
        "updated_at": "2023-02-16T10:00:48+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=ce4dbb7c-b6fa-4c0d-aab7-ca2085a0643a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T09:58:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/7748630a-61f2-415e-953c-ca6a9a868eca?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7748630a-61f2-415e-953c-ca6a9a868eca",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T10:00:49+00:00",
      "updated_at": "2023-02-16T10:00:49+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=7748630a-61f2-415e-953c-ca6a9a868eca"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "dad31450-fc6c-454b-bb6d-1cd4003be774"
          },
          {
            "type": "menu_items",
            "id": "0c0338f9-0610-49c4-9a27-c4b7ed275d7a"
          },
          {
            "type": "menu_items",
            "id": "37d5a0e2-bc57-4a4f-a997-3c591fcdde62"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dad31450-fc6c-454b-bb6d-1cd4003be774",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T10:00:49+00:00",
        "updated_at": "2023-02-16T10:00:49+00:00",
        "menu_id": "7748630a-61f2-415e-953c-ca6a9a868eca",
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
            "related": "api/boomerang/menus/7748630a-61f2-415e-953c-ca6a9a868eca"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=dad31450-fc6c-454b-bb6d-1cd4003be774"
          }
        }
      }
    },
    {
      "id": "0c0338f9-0610-49c4-9a27-c4b7ed275d7a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T10:00:49+00:00",
        "updated_at": "2023-02-16T10:00:49+00:00",
        "menu_id": "7748630a-61f2-415e-953c-ca6a9a868eca",
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
            "related": "api/boomerang/menus/7748630a-61f2-415e-953c-ca6a9a868eca"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0c0338f9-0610-49c4-9a27-c4b7ed275d7a"
          }
        }
      }
    },
    {
      "id": "37d5a0e2-bc57-4a4f-a997-3c591fcdde62",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T10:00:49+00:00",
        "updated_at": "2023-02-16T10:00:49+00:00",
        "menu_id": "7748630a-61f2-415e-953c-ca6a9a868eca",
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
            "related": "api/boomerang/menus/7748630a-61f2-415e-953c-ca6a9a868eca"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=37d5a0e2-bc57-4a4f-a997-3c591fcdde62"
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
    "id": "7bbce687-f766-4e96-810c-ff9db265c32c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T10:00:49+00:00",
      "updated_at": "2023-02-16T10:00:49+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9da3305a-06dc-41ca-bdbe-9d3cce5c1cff' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9da3305a-06dc-41ca-bdbe-9d3cce5c1cff",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "768d9544-348f-4c55-af74-774437f14db9",
              "title": "Contact us"
            },
            {
              "id": "3e1dccf2-51f3-4dce-bbb0-03287b596848",
              "title": "Start"
            },
            {
              "id": "e632907c-7fbd-4fe7-a34e-147f25eeda5d",
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
    "id": "9da3305a-06dc-41ca-bdbe-9d3cce5c1cff",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T10:00:50+00:00",
      "updated_at": "2023-02-16T10:00:50+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "768d9544-348f-4c55-af74-774437f14db9"
          },
          {
            "type": "menu_items",
            "id": "3e1dccf2-51f3-4dce-bbb0-03287b596848"
          },
          {
            "type": "menu_items",
            "id": "e632907c-7fbd-4fe7-a34e-147f25eeda5d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "768d9544-348f-4c55-af74-774437f14db9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T10:00:50+00:00",
        "updated_at": "2023-02-16T10:00:50+00:00",
        "menu_id": "9da3305a-06dc-41ca-bdbe-9d3cce5c1cff",
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
      "id": "3e1dccf2-51f3-4dce-bbb0-03287b596848",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T10:00:50+00:00",
        "updated_at": "2023-02-16T10:00:50+00:00",
        "menu_id": "9da3305a-06dc-41ca-bdbe-9d3cce5c1cff",
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
      "id": "e632907c-7fbd-4fe7-a34e-147f25eeda5d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T10:00:50+00:00",
        "updated_at": "2023-02-16T10:00:50+00:00",
        "menu_id": "9da3305a-06dc-41ca-bdbe-9d3cce5c1cff",
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
    --url 'https://example.booqable.com/api/boomerang/menus/3aba33cc-f8ac-44c0-83d4-408d77b2987e' \
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