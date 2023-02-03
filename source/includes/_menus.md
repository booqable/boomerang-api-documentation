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
      "id": "731dcf6d-5986-4445-8ec2-7367b19d7e61",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-03T08:28:26+00:00",
        "updated_at": "2023-02-03T08:28:26+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=731dcf6d-5986-4445-8ec2-7367b19d7e61"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T08:25:52Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/e4d73bfa-1ca7-4104-a071-8319902b368f?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e4d73bfa-1ca7-4104-a071-8319902b368f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T08:28:27+00:00",
      "updated_at": "2023-02-03T08:28:27+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=e4d73bfa-1ca7-4104-a071-8319902b368f"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "2891d8e8-eadd-42f5-89e1-c2cb338b8621"
          },
          {
            "type": "menu_items",
            "id": "55c4d774-04ef-4f79-836a-967ff1f65149"
          },
          {
            "type": "menu_items",
            "id": "fa5c940e-8dce-4ac5-9a29-1b5e2eb2b71f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2891d8e8-eadd-42f5-89e1-c2cb338b8621",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T08:28:27+00:00",
        "updated_at": "2023-02-03T08:28:27+00:00",
        "menu_id": "e4d73bfa-1ca7-4104-a071-8319902b368f",
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
            "related": "api/boomerang/menus/e4d73bfa-1ca7-4104-a071-8319902b368f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2891d8e8-eadd-42f5-89e1-c2cb338b8621"
          }
        }
      }
    },
    {
      "id": "55c4d774-04ef-4f79-836a-967ff1f65149",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T08:28:27+00:00",
        "updated_at": "2023-02-03T08:28:27+00:00",
        "menu_id": "e4d73bfa-1ca7-4104-a071-8319902b368f",
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
            "related": "api/boomerang/menus/e4d73bfa-1ca7-4104-a071-8319902b368f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=55c4d774-04ef-4f79-836a-967ff1f65149"
          }
        }
      }
    },
    {
      "id": "fa5c940e-8dce-4ac5-9a29-1b5e2eb2b71f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T08:28:27+00:00",
        "updated_at": "2023-02-03T08:28:27+00:00",
        "menu_id": "e4d73bfa-1ca7-4104-a071-8319902b368f",
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
            "related": "api/boomerang/menus/e4d73bfa-1ca7-4104-a071-8319902b368f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fa5c940e-8dce-4ac5-9a29-1b5e2eb2b71f"
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
    "id": "fae9d148-f329-4a7f-8075-43d21c211e76",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T08:28:27+00:00",
      "updated_at": "2023-02-03T08:28:27+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f99bc21b-003c-456c-8f9b-fe296b84818f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f99bc21b-003c-456c-8f9b-fe296b84818f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "6356016e-bac5-41f3-a7db-eaefb6f4d4bf",
              "title": "Contact us"
            },
            {
              "id": "89366e1d-68ee-469a-9683-77738cce62f5",
              "title": "Start"
            },
            {
              "id": "2e7f3a8c-6c5b-4959-801e-f4ff777a907f",
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
    "id": "f99bc21b-003c-456c-8f9b-fe296b84818f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T08:28:28+00:00",
      "updated_at": "2023-02-03T08:28:28+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "6356016e-bac5-41f3-a7db-eaefb6f4d4bf"
          },
          {
            "type": "menu_items",
            "id": "89366e1d-68ee-469a-9683-77738cce62f5"
          },
          {
            "type": "menu_items",
            "id": "2e7f3a8c-6c5b-4959-801e-f4ff777a907f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6356016e-bac5-41f3-a7db-eaefb6f4d4bf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T08:28:28+00:00",
        "updated_at": "2023-02-03T08:28:28+00:00",
        "menu_id": "f99bc21b-003c-456c-8f9b-fe296b84818f",
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
      "id": "89366e1d-68ee-469a-9683-77738cce62f5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T08:28:28+00:00",
        "updated_at": "2023-02-03T08:28:28+00:00",
        "menu_id": "f99bc21b-003c-456c-8f9b-fe296b84818f",
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
      "id": "2e7f3a8c-6c5b-4959-801e-f4ff777a907f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T08:28:28+00:00",
        "updated_at": "2023-02-03T08:28:28+00:00",
        "menu_id": "f99bc21b-003c-456c-8f9b-fe296b84818f",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6058b69f-5c2f-47eb-9d1b-45f97dfa134f' \
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