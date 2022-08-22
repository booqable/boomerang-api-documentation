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
      "id": "ac73ca6f-3f78-4a80-8847-a6cf9cf566e3",
      "type": "menus",
      "attributes": {
        "created_at": "2022-08-22T15:51:55+00:00",
        "updated_at": "2022-08-22T15:51:55+00:00",
        "title": "Main menu",
        "key": "main-menu"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=ac73ca6f-3f78-4a80-8847-a6cf9cf566e3"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-08-22T15:50:06Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/f7005dc9-3d83-4bed-a9b5-1a7c81466362?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f7005dc9-3d83-4bed-a9b5-1a7c81466362",
    "type": "menus",
    "attributes": {
      "created_at": "2022-08-22T15:51:56+00:00",
      "updated_at": "2022-08-22T15:51:56+00:00",
      "title": "Main menu",
      "key": "main-menu"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=f7005dc9-3d83-4bed-a9b5-1a7c81466362"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "dae22a05-9dc4-48ef-80f1-1d88f8a26c46"
          },
          {
            "type": "menu_items",
            "id": "9da8a9c2-57a9-4fec-87f6-1538c9083e66"
          },
          {
            "type": "menu_items",
            "id": "42f100d5-137e-4c36-b76d-c8768765d74d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dae22a05-9dc4-48ef-80f1-1d88f8a26c46",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-08-22T15:51:56+00:00",
        "updated_at": "2022-08-22T15:51:56+00:00",
        "menu_id": "f7005dc9-3d83-4bed-a9b5-1a7c81466362",
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
            "related": "api/boomerang/menus/f7005dc9-3d83-4bed-a9b5-1a7c81466362"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=dae22a05-9dc4-48ef-80f1-1d88f8a26c46"
          }
        }
      }
    },
    {
      "id": "9da8a9c2-57a9-4fec-87f6-1538c9083e66",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-08-22T15:51:56+00:00",
        "updated_at": "2022-08-22T15:51:56+00:00",
        "menu_id": "f7005dc9-3d83-4bed-a9b5-1a7c81466362",
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
            "related": "api/boomerang/menus/f7005dc9-3d83-4bed-a9b5-1a7c81466362"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9da8a9c2-57a9-4fec-87f6-1538c9083e66"
          }
        }
      }
    },
    {
      "id": "42f100d5-137e-4c36-b76d-c8768765d74d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-08-22T15:51:56+00:00",
        "updated_at": "2022-08-22T15:51:56+00:00",
        "menu_id": "f7005dc9-3d83-4bed-a9b5-1a7c81466362",
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
            "related": "api/boomerang/menus/f7005dc9-3d83-4bed-a9b5-1a7c81466362"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=42f100d5-137e-4c36-b76d-c8768765d74d"
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
    "id": "e4b456ea-68a7-4ed4-bc8d-c0682f703777",
    "type": "menus",
    "attributes": {
      "created_at": "2022-08-22T15:51:56+00:00",
      "updated_at": "2022-08-22T15:51:56+00:00",
      "title": "Header menu",
      "key": "header-menu"
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
    --url 'https://example.booqable.com/api/boomerang/menus/0b2f4655-86e6-40a8-b599-1e229e5662b4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0b2f4655-86e6-40a8-b599-1e229e5662b4",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "124c25ca-913f-46a0-98c8-4aab78ad4fa6",
              "title": "Contact us"
            },
            {
              "id": "dead726b-70e3-4f61-a03e-7aa7b448b725",
              "title": "Start"
            },
            {
              "id": "5a40fed7-97a9-468b-8fbf-629b3cb35ed9",
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
    "id": "0b2f4655-86e6-40a8-b599-1e229e5662b4",
    "type": "menus",
    "attributes": {
      "created_at": "2022-08-22T15:51:56+00:00",
      "updated_at": "2022-08-22T15:51:56+00:00",
      "title": "Header menu",
      "key": "header-menu"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "124c25ca-913f-46a0-98c8-4aab78ad4fa6"
          },
          {
            "type": "menu_items",
            "id": "dead726b-70e3-4f61-a03e-7aa7b448b725"
          },
          {
            "type": "menu_items",
            "id": "5a40fed7-97a9-468b-8fbf-629b3cb35ed9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "124c25ca-913f-46a0-98c8-4aab78ad4fa6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-08-22T15:51:56+00:00",
        "updated_at": "2022-08-22T15:51:56+00:00",
        "menu_id": "0b2f4655-86e6-40a8-b599-1e229e5662b4",
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
      "id": "dead726b-70e3-4f61-a03e-7aa7b448b725",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-08-22T15:51:56+00:00",
        "updated_at": "2022-08-22T15:51:56+00:00",
        "menu_id": "0b2f4655-86e6-40a8-b599-1e229e5662b4",
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
      "id": "5a40fed7-97a9-468b-8fbf-629b3cb35ed9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-08-22T15:51:56+00:00",
        "updated_at": "2022-08-22T15:51:56+00:00",
        "menu_id": "0b2f4655-86e6-40a8-b599-1e229e5662b4",
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
    --url 'https://example.booqable.com/api/boomerang/menus/74bcb414-3168-4f40-9ce5-5eee9341511c' \
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