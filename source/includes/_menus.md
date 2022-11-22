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
      "id": "97115fc9-92f2-49cb-b894-bb53284c1abc",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-22T16:35:51+00:00",
        "updated_at": "2022-11-22T16:35:51+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=97115fc9-92f2-49cb-b894-bb53284c1abc"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:34:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/ec6b1883-bcfc-4828-a59c-5f7fcc2f6e64?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ec6b1883-bcfc-4828-a59c-5f7fcc2f6e64",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T16:35:51+00:00",
      "updated_at": "2022-11-22T16:35:51+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=ec6b1883-bcfc-4828-a59c-5f7fcc2f6e64"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "95b83dac-5e5c-497a-92d5-ab3982e1f120"
          },
          {
            "type": "menu_items",
            "id": "9b0479b2-10c3-48d4-a142-46870c4db7c4"
          },
          {
            "type": "menu_items",
            "id": "70f87d26-b130-4ccd-bd48-4bddf8c52d2f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "95b83dac-5e5c-497a-92d5-ab3982e1f120",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:35:51+00:00",
        "updated_at": "2022-11-22T16:35:51+00:00",
        "menu_id": "ec6b1883-bcfc-4828-a59c-5f7fcc2f6e64",
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
            "related": "api/boomerang/menus/ec6b1883-bcfc-4828-a59c-5f7fcc2f6e64"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=95b83dac-5e5c-497a-92d5-ab3982e1f120"
          }
        }
      }
    },
    {
      "id": "9b0479b2-10c3-48d4-a142-46870c4db7c4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:35:51+00:00",
        "updated_at": "2022-11-22T16:35:51+00:00",
        "menu_id": "ec6b1883-bcfc-4828-a59c-5f7fcc2f6e64",
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
            "related": "api/boomerang/menus/ec6b1883-bcfc-4828-a59c-5f7fcc2f6e64"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9b0479b2-10c3-48d4-a142-46870c4db7c4"
          }
        }
      }
    },
    {
      "id": "70f87d26-b130-4ccd-bd48-4bddf8c52d2f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:35:51+00:00",
        "updated_at": "2022-11-22T16:35:51+00:00",
        "menu_id": "ec6b1883-bcfc-4828-a59c-5f7fcc2f6e64",
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
            "related": "api/boomerang/menus/ec6b1883-bcfc-4828-a59c-5f7fcc2f6e64"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=70f87d26-b130-4ccd-bd48-4bddf8c52d2f"
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
    "id": "d46c4f57-7476-4d10-b897-d6fc256d9cca",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T16:35:51+00:00",
      "updated_at": "2022-11-22T16:35:51+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a515c172-6e2b-4b7b-9f17-fa70b1064d7f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a515c172-6e2b-4b7b-9f17-fa70b1064d7f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "17fe01cc-e6e8-47b6-ab12-352e078a9b52",
              "title": "Contact us"
            },
            {
              "id": "90b984dd-d0cd-4b01-bb92-f2e5c88335db",
              "title": "Start"
            },
            {
              "id": "af90e0f2-4394-4a05-9bf7-65b9f4d39e91",
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
    "id": "a515c172-6e2b-4b7b-9f17-fa70b1064d7f",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T16:35:52+00:00",
      "updated_at": "2022-11-22T16:35:52+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "17fe01cc-e6e8-47b6-ab12-352e078a9b52"
          },
          {
            "type": "menu_items",
            "id": "90b984dd-d0cd-4b01-bb92-f2e5c88335db"
          },
          {
            "type": "menu_items",
            "id": "af90e0f2-4394-4a05-9bf7-65b9f4d39e91"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "17fe01cc-e6e8-47b6-ab12-352e078a9b52",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:35:52+00:00",
        "updated_at": "2022-11-22T16:35:52+00:00",
        "menu_id": "a515c172-6e2b-4b7b-9f17-fa70b1064d7f",
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
      "id": "90b984dd-d0cd-4b01-bb92-f2e5c88335db",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:35:52+00:00",
        "updated_at": "2022-11-22T16:35:52+00:00",
        "menu_id": "a515c172-6e2b-4b7b-9f17-fa70b1064d7f",
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
      "id": "af90e0f2-4394-4a05-9bf7-65b9f4d39e91",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:35:52+00:00",
        "updated_at": "2022-11-22T16:35:52+00:00",
        "menu_id": "a515c172-6e2b-4b7b-9f17-fa70b1064d7f",
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
    --url 'https://example.booqable.com/api/boomerang/menus/cddf77f6-ffb8-4b58-9012-8d170a0c872a' \
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