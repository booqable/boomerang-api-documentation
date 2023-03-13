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
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`title` | **String** <br>Name of the menu.
`key` | **String** <br>Key the menu can be referenced by.
`menu_items_attributes` | **Array** `writeonly`<br>Attributes of child menu items to be created or changed.


## Relationships
Menus have the following relationships:

Name | Description
-- | --
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
      "id": "4b6ad07a-cc0e-43a6-a9a4-04ffecfda25d",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-13T07:51:32+00:00",
        "updated_at": "2023-03-13T07:51:32+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=4b6ad07a-cc0e-43a6-a9a4-04ffecfda25d"
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-13T07:49:20Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/80e5bc8a-9334-42cb-88c0-8d558dd69ce5?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "80e5bc8a-9334-42cb-88c0-8d558dd69ce5",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-13T07:51:32+00:00",
      "updated_at": "2023-03-13T07:51:32+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=80e5bc8a-9334-42cb-88c0-8d558dd69ce5"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "20987c67-69be-4cc8-bb05-dc5e0afb321e"
          },
          {
            "type": "menu_items",
            "id": "4a53d710-882d-4a40-839a-3c5e91df1934"
          },
          {
            "type": "menu_items",
            "id": "6f4c3f53-3b0e-413c-84ca-96602a8a8e8f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "20987c67-69be-4cc8-bb05-dc5e0afb321e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-13T07:51:32+00:00",
        "updated_at": "2023-03-13T07:51:32+00:00",
        "menu_id": "80e5bc8a-9334-42cb-88c0-8d558dd69ce5",
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
            "related": "api/boomerang/menus/80e5bc8a-9334-42cb-88c0-8d558dd69ce5"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=20987c67-69be-4cc8-bb05-dc5e0afb321e"
          }
        }
      }
    },
    {
      "id": "4a53d710-882d-4a40-839a-3c5e91df1934",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-13T07:51:32+00:00",
        "updated_at": "2023-03-13T07:51:32+00:00",
        "menu_id": "80e5bc8a-9334-42cb-88c0-8d558dd69ce5",
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
            "related": "api/boomerang/menus/80e5bc8a-9334-42cb-88c0-8d558dd69ce5"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4a53d710-882d-4a40-839a-3c5e91df1934"
          }
        }
      }
    },
    {
      "id": "6f4c3f53-3b0e-413c-84ca-96602a8a8e8f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-13T07:51:32+00:00",
        "updated_at": "2023-03-13T07:51:32+00:00",
        "menu_id": "80e5bc8a-9334-42cb-88c0-8d558dd69ce5",
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
            "related": "api/boomerang/menus/80e5bc8a-9334-42cb-88c0-8d558dd69ce5"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6f4c3f53-3b0e-413c-84ca-96602a8a8e8f"
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
-- | --
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
    "id": "d4722583-add4-42f8-af27-d6452c575e72",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-13T07:51:33+00:00",
      "updated_at": "2023-03-13T07:51:33+00:00",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/menus/be33589f-3c92-4de0-85e0-e7ca0118f52c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "be33589f-3c92-4de0-85e0-e7ca0118f52c",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "74517c34-c2d1-46e4-b278-06cd64ee9cba",
              "title": "Contact us"
            },
            {
              "id": "6a9a517c-0fff-459e-a27c-112fac23c32a",
              "title": "Start"
            },
            {
              "id": "3fbc0a91-881c-4c27-8ac8-e926533964e7",
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
    "id": "be33589f-3c92-4de0-85e0-e7ca0118f52c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-13T07:51:35+00:00",
      "updated_at": "2023-03-13T07:51:35+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "74517c34-c2d1-46e4-b278-06cd64ee9cba"
          },
          {
            "type": "menu_items",
            "id": "6a9a517c-0fff-459e-a27c-112fac23c32a"
          },
          {
            "type": "menu_items",
            "id": "3fbc0a91-881c-4c27-8ac8-e926533964e7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "74517c34-c2d1-46e4-b278-06cd64ee9cba",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-13T07:51:35+00:00",
        "updated_at": "2023-03-13T07:51:35+00:00",
        "menu_id": "be33589f-3c92-4de0-85e0-e7ca0118f52c",
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
      "id": "6a9a517c-0fff-459e-a27c-112fac23c32a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-13T07:51:35+00:00",
        "updated_at": "2023-03-13T07:51:35+00:00",
        "menu_id": "be33589f-3c92-4de0-85e0-e7ca0118f52c",
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
      "id": "3fbc0a91-881c-4c27-8ac8-e926533964e7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-13T07:51:35+00:00",
        "updated_at": "2023-03-13T07:51:35+00:00",
        "menu_id": "be33589f-3c92-4de0-85e0-e7ca0118f52c",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/menus/ff6dd553-2cce-4552-a2be-80d41d6f04f8' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes