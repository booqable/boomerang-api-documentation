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
      "id": "fb2b411a-d5cb-4bd1-a4ea-cd455bbfe350",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-03T09:53:00+00:00",
        "updated_at": "2023-02-03T09:53:00+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=fb2b411a-d5cb-4bd1-a4ea-cd455bbfe350"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T09:50:47Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/d2c8837d-64a4-4a46-bb81-675e40d07f29?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d2c8837d-64a4-4a46-bb81-675e40d07f29",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T09:53:00+00:00",
      "updated_at": "2023-02-03T09:53:00+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=d2c8837d-64a4-4a46-bb81-675e40d07f29"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "f5e8f0c5-d72e-4702-8a7d-505fb22b378a"
          },
          {
            "type": "menu_items",
            "id": "cf90c10a-6610-432b-8bff-e99f7005f746"
          },
          {
            "type": "menu_items",
            "id": "e3965512-8d49-4daf-9a0f-21928b057b4c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f5e8f0c5-d72e-4702-8a7d-505fb22b378a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T09:53:00+00:00",
        "updated_at": "2023-02-03T09:53:00+00:00",
        "menu_id": "d2c8837d-64a4-4a46-bb81-675e40d07f29",
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
            "related": "api/boomerang/menus/d2c8837d-64a4-4a46-bb81-675e40d07f29"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f5e8f0c5-d72e-4702-8a7d-505fb22b378a"
          }
        }
      }
    },
    {
      "id": "cf90c10a-6610-432b-8bff-e99f7005f746",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T09:53:00+00:00",
        "updated_at": "2023-02-03T09:53:00+00:00",
        "menu_id": "d2c8837d-64a4-4a46-bb81-675e40d07f29",
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
            "related": "api/boomerang/menus/d2c8837d-64a4-4a46-bb81-675e40d07f29"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cf90c10a-6610-432b-8bff-e99f7005f746"
          }
        }
      }
    },
    {
      "id": "e3965512-8d49-4daf-9a0f-21928b057b4c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T09:53:00+00:00",
        "updated_at": "2023-02-03T09:53:00+00:00",
        "menu_id": "d2c8837d-64a4-4a46-bb81-675e40d07f29",
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
            "related": "api/boomerang/menus/d2c8837d-64a4-4a46-bb81-675e40d07f29"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e3965512-8d49-4daf-9a0f-21928b057b4c"
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
    "id": "abaa385c-eec4-4630-9a8e-90bf763c428d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T09:53:01+00:00",
      "updated_at": "2023-02-03T09:53:01+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ffdebbe4-2cf1-451b-8fb5-b62334f0e8e5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ffdebbe4-2cf1-451b-8fb5-b62334f0e8e5",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "f2bfa902-c2d2-4882-8ff7-44c30131e1d8",
              "title": "Contact us"
            },
            {
              "id": "0245395d-87c9-4d52-b42a-e133ddcb092b",
              "title": "Start"
            },
            {
              "id": "069cb7a3-e3d1-4a00-ae08-b15897ae9f96",
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
    "id": "ffdebbe4-2cf1-451b-8fb5-b62334f0e8e5",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T09:53:01+00:00",
      "updated_at": "2023-02-03T09:53:01+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "f2bfa902-c2d2-4882-8ff7-44c30131e1d8"
          },
          {
            "type": "menu_items",
            "id": "0245395d-87c9-4d52-b42a-e133ddcb092b"
          },
          {
            "type": "menu_items",
            "id": "069cb7a3-e3d1-4a00-ae08-b15897ae9f96"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f2bfa902-c2d2-4882-8ff7-44c30131e1d8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T09:53:01+00:00",
        "updated_at": "2023-02-03T09:53:01+00:00",
        "menu_id": "ffdebbe4-2cf1-451b-8fb5-b62334f0e8e5",
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
      "id": "0245395d-87c9-4d52-b42a-e133ddcb092b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T09:53:01+00:00",
        "updated_at": "2023-02-03T09:53:01+00:00",
        "menu_id": "ffdebbe4-2cf1-451b-8fb5-b62334f0e8e5",
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
      "id": "069cb7a3-e3d1-4a00-ae08-b15897ae9f96",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T09:53:01+00:00",
        "updated_at": "2023-02-03T09:53:01+00:00",
        "menu_id": "ffdebbe4-2cf1-451b-8fb5-b62334f0e8e5",
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
    --url 'https://example.booqable.com/api/boomerang/menus/2c3d1194-aa90-4c56-b714-acd78bac0bcc' \
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