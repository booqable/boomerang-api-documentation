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
      "id": "f0998e72-0006-4656-a2ee-7702f913408f",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-08T09:19:36+00:00",
        "updated_at": "2023-02-08T09:19:36+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=f0998e72-0006-4656-a2ee-7702f913408f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T09:17:23Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/5aa76f7a-b41c-4daa-8f27-4fcdf10d9c85?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5aa76f7a-b41c-4daa-8f27-4fcdf10d9c85",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T09:19:36+00:00",
      "updated_at": "2023-02-08T09:19:36+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=5aa76f7a-b41c-4daa-8f27-4fcdf10d9c85"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "257d31aa-ff17-4500-85fa-3b8fbf67b9ca"
          },
          {
            "type": "menu_items",
            "id": "a71582ae-5258-4e93-b635-862ca96ba3e0"
          },
          {
            "type": "menu_items",
            "id": "bb0f1aa5-c31a-4d77-b957-bf632033d7b1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "257d31aa-ff17-4500-85fa-3b8fbf67b9ca",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T09:19:36+00:00",
        "updated_at": "2023-02-08T09:19:36+00:00",
        "menu_id": "5aa76f7a-b41c-4daa-8f27-4fcdf10d9c85",
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
            "related": "api/boomerang/menus/5aa76f7a-b41c-4daa-8f27-4fcdf10d9c85"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=257d31aa-ff17-4500-85fa-3b8fbf67b9ca"
          }
        }
      }
    },
    {
      "id": "a71582ae-5258-4e93-b635-862ca96ba3e0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T09:19:36+00:00",
        "updated_at": "2023-02-08T09:19:36+00:00",
        "menu_id": "5aa76f7a-b41c-4daa-8f27-4fcdf10d9c85",
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
            "related": "api/boomerang/menus/5aa76f7a-b41c-4daa-8f27-4fcdf10d9c85"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a71582ae-5258-4e93-b635-862ca96ba3e0"
          }
        }
      }
    },
    {
      "id": "bb0f1aa5-c31a-4d77-b957-bf632033d7b1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T09:19:36+00:00",
        "updated_at": "2023-02-08T09:19:36+00:00",
        "menu_id": "5aa76f7a-b41c-4daa-8f27-4fcdf10d9c85",
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
            "related": "api/boomerang/menus/5aa76f7a-b41c-4daa-8f27-4fcdf10d9c85"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bb0f1aa5-c31a-4d77-b957-bf632033d7b1"
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
    "id": "35c556c9-ac96-49d0-ab9a-e67bcf716516",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T09:19:37+00:00",
      "updated_at": "2023-02-08T09:19:37+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/4397fdea-dd2e-409f-a2a7-a42c87405e10' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4397fdea-dd2e-409f-a2a7-a42c87405e10",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "74d79adc-bbd2-4db0-a9c5-32bf7587e70b",
              "title": "Contact us"
            },
            {
              "id": "babc3532-4af0-4197-862e-08439c0efaa6",
              "title": "Start"
            },
            {
              "id": "4061c2e5-0ad1-4daa-9aa7-bdfd2988c353",
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
    "id": "4397fdea-dd2e-409f-a2a7-a42c87405e10",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T09:19:37+00:00",
      "updated_at": "2023-02-08T09:19:37+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "74d79adc-bbd2-4db0-a9c5-32bf7587e70b"
          },
          {
            "type": "menu_items",
            "id": "babc3532-4af0-4197-862e-08439c0efaa6"
          },
          {
            "type": "menu_items",
            "id": "4061c2e5-0ad1-4daa-9aa7-bdfd2988c353"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "74d79adc-bbd2-4db0-a9c5-32bf7587e70b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T09:19:37+00:00",
        "updated_at": "2023-02-08T09:19:37+00:00",
        "menu_id": "4397fdea-dd2e-409f-a2a7-a42c87405e10",
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
      "id": "babc3532-4af0-4197-862e-08439c0efaa6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T09:19:37+00:00",
        "updated_at": "2023-02-08T09:19:37+00:00",
        "menu_id": "4397fdea-dd2e-409f-a2a7-a42c87405e10",
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
      "id": "4061c2e5-0ad1-4daa-9aa7-bdfd2988c353",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T09:19:37+00:00",
        "updated_at": "2023-02-08T09:19:37+00:00",
        "menu_id": "4397fdea-dd2e-409f-a2a7-a42c87405e10",
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
    --url 'https://example.booqable.com/api/boomerang/menus/af42c3d8-d098-4ba5-8974-7fae6e169efd' \
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