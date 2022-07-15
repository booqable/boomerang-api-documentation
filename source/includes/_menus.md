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
      "id": "4f601354-0c20-41bf-81e1-9c952e208234",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-15T09:55:03+00:00",
        "updated_at": "2022-07-15T09:55:03+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=4f601354-0c20-41bf-81e1-9c952e208234"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T09:52:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/ac5f4fa3-fb09-48db-ba22-c1d54a5b4ef8?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ac5f4fa3-fb09-48db-ba22-c1d54a5b4ef8",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-15T09:55:04+00:00",
      "updated_at": "2022-07-15T09:55:04+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=ac5f4fa3-fb09-48db-ba22-c1d54a5b4ef8"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "2b66755f-3b33-4d33-811a-40bc15c404b5"
          },
          {
            "type": "menu_items",
            "id": "28f38c33-5d1f-4080-9949-048f5098f219"
          },
          {
            "type": "menu_items",
            "id": "f2ad9cb8-6d01-45b4-bd29-8123328eb6cb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2b66755f-3b33-4d33-811a-40bc15c404b5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-15T09:55:04+00:00",
        "updated_at": "2022-07-15T09:55:04+00:00",
        "menu_id": "ac5f4fa3-fb09-48db-ba22-c1d54a5b4ef8",
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
            "related": "api/boomerang/menus/ac5f4fa3-fb09-48db-ba22-c1d54a5b4ef8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2b66755f-3b33-4d33-811a-40bc15c404b5"
          }
        }
      }
    },
    {
      "id": "28f38c33-5d1f-4080-9949-048f5098f219",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-15T09:55:04+00:00",
        "updated_at": "2022-07-15T09:55:04+00:00",
        "menu_id": "ac5f4fa3-fb09-48db-ba22-c1d54a5b4ef8",
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
            "related": "api/boomerang/menus/ac5f4fa3-fb09-48db-ba22-c1d54a5b4ef8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=28f38c33-5d1f-4080-9949-048f5098f219"
          }
        }
      }
    },
    {
      "id": "f2ad9cb8-6d01-45b4-bd29-8123328eb6cb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-15T09:55:04+00:00",
        "updated_at": "2022-07-15T09:55:04+00:00",
        "menu_id": "ac5f4fa3-fb09-48db-ba22-c1d54a5b4ef8",
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
            "related": "api/boomerang/menus/ac5f4fa3-fb09-48db-ba22-c1d54a5b4ef8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f2ad9cb8-6d01-45b4-bd29-8123328eb6cb"
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
    "id": "52dc70be-88d8-4b5c-8260-f5eb9dab877b",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-15T09:55:05+00:00",
      "updated_at": "2022-07-15T09:55:05+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b15391a6-e7d1-4406-b6fe-78c25abac221' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b15391a6-e7d1-4406-b6fe-78c25abac221",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "ff58319a-897e-4006-ae78-337b0a15312f",
              "title": "Contact us"
            },
            {
              "id": "0640a463-ad49-4aa0-b49c-e722acd09e7f",
              "title": "Start"
            },
            {
              "id": "0e637726-4813-4736-97ec-4119a7411975",
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
    "id": "b15391a6-e7d1-4406-b6fe-78c25abac221",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-15T09:55:05+00:00",
      "updated_at": "2022-07-15T09:55:05+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "ff58319a-897e-4006-ae78-337b0a15312f"
          },
          {
            "type": "menu_items",
            "id": "0640a463-ad49-4aa0-b49c-e722acd09e7f"
          },
          {
            "type": "menu_items",
            "id": "0e637726-4813-4736-97ec-4119a7411975"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ff58319a-897e-4006-ae78-337b0a15312f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-15T09:55:05+00:00",
        "updated_at": "2022-07-15T09:55:05+00:00",
        "menu_id": "b15391a6-e7d1-4406-b6fe-78c25abac221",
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
      "id": "0640a463-ad49-4aa0-b49c-e722acd09e7f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-15T09:55:05+00:00",
        "updated_at": "2022-07-15T09:55:05+00:00",
        "menu_id": "b15391a6-e7d1-4406-b6fe-78c25abac221",
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
      "id": "0e637726-4813-4736-97ec-4119a7411975",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-15T09:55:05+00:00",
        "updated_at": "2022-07-15T09:55:05+00:00",
        "menu_id": "b15391a6-e7d1-4406-b6fe-78c25abac221",
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
    --url 'https://example.booqable.com/api/boomerang/menus/8d5e3953-844f-4f6b-ae2d-77ee9c366ab1' \
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