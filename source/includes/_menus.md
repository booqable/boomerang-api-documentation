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
      "id": "26b827f7-0bcf-474f-82e9-d469609f6f16",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-27T10:47:38+00:00",
        "updated_at": "2023-02-27T10:47:38+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=26b827f7-0bcf-474f-82e9-d469609f6f16"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-27T10:45:14Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/3dfabd31-3cb1-4e57-ac31-c0f8c9cb8505?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3dfabd31-3cb1-4e57-ac31-c0f8c9cb8505",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-27T10:47:38+00:00",
      "updated_at": "2023-02-27T10:47:38+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=3dfabd31-3cb1-4e57-ac31-c0f8c9cb8505"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "5ef4836d-6f75-42bf-8483-56c2247cb3d9"
          },
          {
            "type": "menu_items",
            "id": "db4e8bb1-8dfc-4172-a19b-a2e38a28db28"
          },
          {
            "type": "menu_items",
            "id": "3713fa3a-476e-45a1-bb34-bcfb60849922"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5ef4836d-6f75-42bf-8483-56c2247cb3d9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-27T10:47:38+00:00",
        "updated_at": "2023-02-27T10:47:38+00:00",
        "menu_id": "3dfabd31-3cb1-4e57-ac31-c0f8c9cb8505",
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
            "related": "api/boomerang/menus/3dfabd31-3cb1-4e57-ac31-c0f8c9cb8505"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5ef4836d-6f75-42bf-8483-56c2247cb3d9"
          }
        }
      }
    },
    {
      "id": "db4e8bb1-8dfc-4172-a19b-a2e38a28db28",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-27T10:47:38+00:00",
        "updated_at": "2023-02-27T10:47:38+00:00",
        "menu_id": "3dfabd31-3cb1-4e57-ac31-c0f8c9cb8505",
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
            "related": "api/boomerang/menus/3dfabd31-3cb1-4e57-ac31-c0f8c9cb8505"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=db4e8bb1-8dfc-4172-a19b-a2e38a28db28"
          }
        }
      }
    },
    {
      "id": "3713fa3a-476e-45a1-bb34-bcfb60849922",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-27T10:47:38+00:00",
        "updated_at": "2023-02-27T10:47:38+00:00",
        "menu_id": "3dfabd31-3cb1-4e57-ac31-c0f8c9cb8505",
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
            "related": "api/boomerang/menus/3dfabd31-3cb1-4e57-ac31-c0f8c9cb8505"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3713fa3a-476e-45a1-bb34-bcfb60849922"
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
    "id": "2ebeb96b-83bc-42fc-8822-7f67cf9aa9d1",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-27T10:47:39+00:00",
      "updated_at": "2023-02-27T10:47:39+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fa84d433-3552-4db3-8f8c-78ee1bdfa51d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fa84d433-3552-4db3-8f8c-78ee1bdfa51d",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "a5373148-ca28-4d6a-8e42-a33476d5fbf7",
              "title": "Contact us"
            },
            {
              "id": "9d309293-bb3a-4726-b226-968fe5925a73",
              "title": "Start"
            },
            {
              "id": "27931502-e7cb-4169-9fe2-76f2ff811314",
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
    "id": "fa84d433-3552-4db3-8f8c-78ee1bdfa51d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-27T10:47:39+00:00",
      "updated_at": "2023-02-27T10:47:39+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "a5373148-ca28-4d6a-8e42-a33476d5fbf7"
          },
          {
            "type": "menu_items",
            "id": "9d309293-bb3a-4726-b226-968fe5925a73"
          },
          {
            "type": "menu_items",
            "id": "27931502-e7cb-4169-9fe2-76f2ff811314"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a5373148-ca28-4d6a-8e42-a33476d5fbf7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-27T10:47:39+00:00",
        "updated_at": "2023-02-27T10:47:39+00:00",
        "menu_id": "fa84d433-3552-4db3-8f8c-78ee1bdfa51d",
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
      "id": "9d309293-bb3a-4726-b226-968fe5925a73",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-27T10:47:39+00:00",
        "updated_at": "2023-02-27T10:47:39+00:00",
        "menu_id": "fa84d433-3552-4db3-8f8c-78ee1bdfa51d",
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
      "id": "27931502-e7cb-4169-9fe2-76f2ff811314",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-27T10:47:39+00:00",
        "updated_at": "2023-02-27T10:47:39+00:00",
        "menu_id": "fa84d433-3552-4db3-8f8c-78ee1bdfa51d",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a2135f94-adc2-432a-97f5-ac60907433f4' \
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