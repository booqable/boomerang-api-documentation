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
      "id": "9f9d9d7c-75ee-47fb-bf84-dd9287d97b21",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-23T08:20:52+00:00",
        "updated_at": "2023-02-23T08:20:52+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=9f9d9d7c-75ee-47fb-bf84-dd9287d97b21"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T08:18:42Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/b6572098-a205-484b-ac2e-91cfadbee0e4?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b6572098-a205-484b-ac2e-91cfadbee0e4",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T08:20:52+00:00",
      "updated_at": "2023-02-23T08:20:52+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b6572098-a205-484b-ac2e-91cfadbee0e4"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "666caca3-d71a-4e8b-bf6f-8a0867e89242"
          },
          {
            "type": "menu_items",
            "id": "c087c77f-64ed-43de-b02c-a49ae8716d40"
          },
          {
            "type": "menu_items",
            "id": "2ddabd3c-e53d-4826-9b03-8cb30df0b006"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "666caca3-d71a-4e8b-bf6f-8a0867e89242",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T08:20:52+00:00",
        "updated_at": "2023-02-23T08:20:52+00:00",
        "menu_id": "b6572098-a205-484b-ac2e-91cfadbee0e4",
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
            "related": "api/boomerang/menus/b6572098-a205-484b-ac2e-91cfadbee0e4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=666caca3-d71a-4e8b-bf6f-8a0867e89242"
          }
        }
      }
    },
    {
      "id": "c087c77f-64ed-43de-b02c-a49ae8716d40",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T08:20:52+00:00",
        "updated_at": "2023-02-23T08:20:52+00:00",
        "menu_id": "b6572098-a205-484b-ac2e-91cfadbee0e4",
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
            "related": "api/boomerang/menus/b6572098-a205-484b-ac2e-91cfadbee0e4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c087c77f-64ed-43de-b02c-a49ae8716d40"
          }
        }
      }
    },
    {
      "id": "2ddabd3c-e53d-4826-9b03-8cb30df0b006",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T08:20:52+00:00",
        "updated_at": "2023-02-23T08:20:52+00:00",
        "menu_id": "b6572098-a205-484b-ac2e-91cfadbee0e4",
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
            "related": "api/boomerang/menus/b6572098-a205-484b-ac2e-91cfadbee0e4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2ddabd3c-e53d-4826-9b03-8cb30df0b006"
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
    "id": "d365c47a-4dcd-45f7-91ee-d59de5296f17",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T08:20:53+00:00",
      "updated_at": "2023-02-23T08:20:53+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1695fe08-97ab-4365-853f-62851bee5530' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1695fe08-97ab-4365-853f-62851bee5530",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "8631d4c8-39a9-4b93-95c9-a1e313a45199",
              "title": "Contact us"
            },
            {
              "id": "d0ee6287-3fe4-441b-b0fd-9ba877d3ac45",
              "title": "Start"
            },
            {
              "id": "938bcd20-86cb-4413-910b-721d02886337",
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
    "id": "1695fe08-97ab-4365-853f-62851bee5530",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-23T08:20:53+00:00",
      "updated_at": "2023-02-23T08:20:53+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "8631d4c8-39a9-4b93-95c9-a1e313a45199"
          },
          {
            "type": "menu_items",
            "id": "d0ee6287-3fe4-441b-b0fd-9ba877d3ac45"
          },
          {
            "type": "menu_items",
            "id": "938bcd20-86cb-4413-910b-721d02886337"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8631d4c8-39a9-4b93-95c9-a1e313a45199",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T08:20:53+00:00",
        "updated_at": "2023-02-23T08:20:53+00:00",
        "menu_id": "1695fe08-97ab-4365-853f-62851bee5530",
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
      "id": "d0ee6287-3fe4-441b-b0fd-9ba877d3ac45",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T08:20:53+00:00",
        "updated_at": "2023-02-23T08:20:53+00:00",
        "menu_id": "1695fe08-97ab-4365-853f-62851bee5530",
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
      "id": "938bcd20-86cb-4413-910b-721d02886337",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-23T08:20:53+00:00",
        "updated_at": "2023-02-23T08:20:53+00:00",
        "menu_id": "1695fe08-97ab-4365-853f-62851bee5530",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9fba0d23-c8ec-4605-beea-45a4a044751c' \
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