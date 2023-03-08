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
      "id": "a51fcc13-3b98-4280-a25a-af2e2e34aa54",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-08T15:24:15+00:00",
        "updated_at": "2023-03-08T15:24:15+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=a51fcc13-3b98-4280-a25a-af2e2e34aa54"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T15:21:50Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/9e9f6e1f-48db-43d5-b60f-178a1f46b22a?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9e9f6e1f-48db-43d5-b60f-178a1f46b22a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-08T15:24:15+00:00",
      "updated_at": "2023-03-08T15:24:15+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=9e9f6e1f-48db-43d5-b60f-178a1f46b22a"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "d15ba021-4867-47ff-8847-5189b4006fa3"
          },
          {
            "type": "menu_items",
            "id": "16855c68-a45a-435c-8a60-7edb234d859b"
          },
          {
            "type": "menu_items",
            "id": "348a93ac-fe4d-412a-9150-c9d87d663dde"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d15ba021-4867-47ff-8847-5189b4006fa3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T15:24:15+00:00",
        "updated_at": "2023-03-08T15:24:15+00:00",
        "menu_id": "9e9f6e1f-48db-43d5-b60f-178a1f46b22a",
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
            "related": "api/boomerang/menus/9e9f6e1f-48db-43d5-b60f-178a1f46b22a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d15ba021-4867-47ff-8847-5189b4006fa3"
          }
        }
      }
    },
    {
      "id": "16855c68-a45a-435c-8a60-7edb234d859b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T15:24:15+00:00",
        "updated_at": "2023-03-08T15:24:15+00:00",
        "menu_id": "9e9f6e1f-48db-43d5-b60f-178a1f46b22a",
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
            "related": "api/boomerang/menus/9e9f6e1f-48db-43d5-b60f-178a1f46b22a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=16855c68-a45a-435c-8a60-7edb234d859b"
          }
        }
      }
    },
    {
      "id": "348a93ac-fe4d-412a-9150-c9d87d663dde",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T15:24:15+00:00",
        "updated_at": "2023-03-08T15:24:15+00:00",
        "menu_id": "9e9f6e1f-48db-43d5-b60f-178a1f46b22a",
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
            "related": "api/boomerang/menus/9e9f6e1f-48db-43d5-b60f-178a1f46b22a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=348a93ac-fe4d-412a-9150-c9d87d663dde"
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
    "id": "87eb26a0-5bbd-472f-985f-2def356169c1",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-08T15:24:16+00:00",
      "updated_at": "2023-03-08T15:24:16+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/51b7f4df-25e9-495d-9245-9fdd09c4acf2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "51b7f4df-25e9-495d-9245-9fdd09c4acf2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "37861400-f416-4514-a2ee-d76182841e36",
              "title": "Contact us"
            },
            {
              "id": "67549e46-f9aa-423a-9ecc-63ca9067c155",
              "title": "Start"
            },
            {
              "id": "e382418e-a534-4676-9d8b-26b286f2a5fe",
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
    "id": "51b7f4df-25e9-495d-9245-9fdd09c4acf2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-08T15:24:16+00:00",
      "updated_at": "2023-03-08T15:24:16+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "37861400-f416-4514-a2ee-d76182841e36"
          },
          {
            "type": "menu_items",
            "id": "67549e46-f9aa-423a-9ecc-63ca9067c155"
          },
          {
            "type": "menu_items",
            "id": "e382418e-a534-4676-9d8b-26b286f2a5fe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "37861400-f416-4514-a2ee-d76182841e36",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T15:24:16+00:00",
        "updated_at": "2023-03-08T15:24:16+00:00",
        "menu_id": "51b7f4df-25e9-495d-9245-9fdd09c4acf2",
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
      "id": "67549e46-f9aa-423a-9ecc-63ca9067c155",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T15:24:16+00:00",
        "updated_at": "2023-03-08T15:24:16+00:00",
        "menu_id": "51b7f4df-25e9-495d-9245-9fdd09c4acf2",
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
      "id": "e382418e-a534-4676-9d8b-26b286f2a5fe",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T15:24:16+00:00",
        "updated_at": "2023-03-08T15:24:16+00:00",
        "menu_id": "51b7f4df-25e9-495d-9245-9fdd09c4acf2",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0aa4c351-966f-4082-bf7f-de33cabbecdd' \
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