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
      "id": "ba39cee7-f4ba-40dc-8fae-bd7a7a4e0cc5",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-13T11:51:01+00:00",
        "updated_at": "2022-07-13T11:51:01+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=ba39cee7-f4ba-40dc-8fae-bd7a7a4e0cc5"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-13T11:49:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/1d373b56-8a7c-4d24-a9c6-cf4473475c90?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1d373b56-8a7c-4d24-a9c6-cf4473475c90",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-13T11:51:01+00:00",
      "updated_at": "2022-07-13T11:51:01+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=1d373b56-8a7c-4d24-a9c6-cf4473475c90"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "1e83bc65-954e-4e85-9ed2-0db70b659e13"
          },
          {
            "type": "menu_items",
            "id": "42116752-c569-4ca3-82cf-4d647868e673"
          },
          {
            "type": "menu_items",
            "id": "edc0f0c8-0767-4e68-a4a3-63d46a743565"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1e83bc65-954e-4e85-9ed2-0db70b659e13",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T11:51:01+00:00",
        "updated_at": "2022-07-13T11:51:01+00:00",
        "menu_id": "1d373b56-8a7c-4d24-a9c6-cf4473475c90",
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
            "related": "api/boomerang/menus/1d373b56-8a7c-4d24-a9c6-cf4473475c90"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1e83bc65-954e-4e85-9ed2-0db70b659e13"
          }
        }
      }
    },
    {
      "id": "42116752-c569-4ca3-82cf-4d647868e673",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T11:51:01+00:00",
        "updated_at": "2022-07-13T11:51:01+00:00",
        "menu_id": "1d373b56-8a7c-4d24-a9c6-cf4473475c90",
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
            "related": "api/boomerang/menus/1d373b56-8a7c-4d24-a9c6-cf4473475c90"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=42116752-c569-4ca3-82cf-4d647868e673"
          }
        }
      }
    },
    {
      "id": "edc0f0c8-0767-4e68-a4a3-63d46a743565",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T11:51:01+00:00",
        "updated_at": "2022-07-13T11:51:01+00:00",
        "menu_id": "1d373b56-8a7c-4d24-a9c6-cf4473475c90",
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
            "related": "api/boomerang/menus/1d373b56-8a7c-4d24-a9c6-cf4473475c90"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=edc0f0c8-0767-4e68-a4a3-63d46a743565"
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
    "id": "f3f44195-b212-45fb-b46f-48431f608c82",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-13T11:51:03+00:00",
      "updated_at": "2022-07-13T11:51:03+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/38e770e5-ff96-4262-b414-c66edf6e7da9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "38e770e5-ff96-4262-b414-c66edf6e7da9",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "b52c9f17-f968-4cac-99d8-b45d31c267c4",
              "title": "Contact us"
            },
            {
              "id": "8220ab6d-4859-4d47-9d7f-0f2c8f5d867a",
              "title": "Start"
            },
            {
              "id": "1c93cdcb-df26-47f9-be7e-46e168c067e4",
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
    "id": "38e770e5-ff96-4262-b414-c66edf6e7da9",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-13T11:51:03+00:00",
      "updated_at": "2022-07-13T11:51:03+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "b52c9f17-f968-4cac-99d8-b45d31c267c4"
          },
          {
            "type": "menu_items",
            "id": "8220ab6d-4859-4d47-9d7f-0f2c8f5d867a"
          },
          {
            "type": "menu_items",
            "id": "1c93cdcb-df26-47f9-be7e-46e168c067e4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b52c9f17-f968-4cac-99d8-b45d31c267c4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T11:51:03+00:00",
        "updated_at": "2022-07-13T11:51:03+00:00",
        "menu_id": "38e770e5-ff96-4262-b414-c66edf6e7da9",
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
      "id": "8220ab6d-4859-4d47-9d7f-0f2c8f5d867a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T11:51:03+00:00",
        "updated_at": "2022-07-13T11:51:03+00:00",
        "menu_id": "38e770e5-ff96-4262-b414-c66edf6e7da9",
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
      "id": "1c93cdcb-df26-47f9-be7e-46e168c067e4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T11:51:03+00:00",
        "updated_at": "2022-07-13T11:51:03+00:00",
        "menu_id": "38e770e5-ff96-4262-b414-c66edf6e7da9",
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
    --url 'https://example.booqable.com/api/boomerang/menus/3b02fa59-5974-43c4-a971-d7c7d6e57bf2' \
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