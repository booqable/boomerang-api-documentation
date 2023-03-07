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
      "id": "675829f3-584d-4299-b7c8-f9ef3f81c87a",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-07T08:09:41+00:00",
        "updated_at": "2023-03-07T08:09:41+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=675829f3-584d-4299-b7c8-f9ef3f81c87a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T08:07:14Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/78ef85da-8728-4105-b470-05aac377a2b0?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "78ef85da-8728-4105-b470-05aac377a2b0",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T08:09:41+00:00",
      "updated_at": "2023-03-07T08:09:41+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=78ef85da-8728-4105-b470-05aac377a2b0"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "27433cd7-b3a2-42f7-9bf9-41fafc029a20"
          },
          {
            "type": "menu_items",
            "id": "f0107fc8-f012-44ca-bacc-b53321a0710d"
          },
          {
            "type": "menu_items",
            "id": "a08e60c0-f164-41c8-b8d6-a2308b7b16a6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "27433cd7-b3a2-42f7-9bf9-41fafc029a20",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T08:09:41+00:00",
        "updated_at": "2023-03-07T08:09:41+00:00",
        "menu_id": "78ef85da-8728-4105-b470-05aac377a2b0",
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
            "related": "api/boomerang/menus/78ef85da-8728-4105-b470-05aac377a2b0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=27433cd7-b3a2-42f7-9bf9-41fafc029a20"
          }
        }
      }
    },
    {
      "id": "f0107fc8-f012-44ca-bacc-b53321a0710d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T08:09:41+00:00",
        "updated_at": "2023-03-07T08:09:41+00:00",
        "menu_id": "78ef85da-8728-4105-b470-05aac377a2b0",
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
            "related": "api/boomerang/menus/78ef85da-8728-4105-b470-05aac377a2b0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f0107fc8-f012-44ca-bacc-b53321a0710d"
          }
        }
      }
    },
    {
      "id": "a08e60c0-f164-41c8-b8d6-a2308b7b16a6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T08:09:41+00:00",
        "updated_at": "2023-03-07T08:09:41+00:00",
        "menu_id": "78ef85da-8728-4105-b470-05aac377a2b0",
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
            "related": "api/boomerang/menus/78ef85da-8728-4105-b470-05aac377a2b0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a08e60c0-f164-41c8-b8d6-a2308b7b16a6"
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
    "id": "de356338-81e9-475f-9702-128f18c03934",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T08:09:41+00:00",
      "updated_at": "2023-03-07T08:09:41+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/df2e7d42-353b-4c33-af8f-56519efe857e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "df2e7d42-353b-4c33-af8f-56519efe857e",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "4e3ee7cb-b2d9-45e5-9fd9-b21aff80f209",
              "title": "Contact us"
            },
            {
              "id": "4dc5761f-2589-466b-8cd6-77108370a1fc",
              "title": "Start"
            },
            {
              "id": "32a284ae-9b27-4287-ae57-547440394b30",
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
    "id": "df2e7d42-353b-4c33-af8f-56519efe857e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T08:09:42+00:00",
      "updated_at": "2023-03-07T08:09:42+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "4e3ee7cb-b2d9-45e5-9fd9-b21aff80f209"
          },
          {
            "type": "menu_items",
            "id": "4dc5761f-2589-466b-8cd6-77108370a1fc"
          },
          {
            "type": "menu_items",
            "id": "32a284ae-9b27-4287-ae57-547440394b30"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4e3ee7cb-b2d9-45e5-9fd9-b21aff80f209",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T08:09:42+00:00",
        "updated_at": "2023-03-07T08:09:42+00:00",
        "menu_id": "df2e7d42-353b-4c33-af8f-56519efe857e",
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
      "id": "4dc5761f-2589-466b-8cd6-77108370a1fc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T08:09:42+00:00",
        "updated_at": "2023-03-07T08:09:42+00:00",
        "menu_id": "df2e7d42-353b-4c33-af8f-56519efe857e",
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
      "id": "32a284ae-9b27-4287-ae57-547440394b30",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T08:09:42+00:00",
        "updated_at": "2023-03-07T08:09:42+00:00",
        "menu_id": "df2e7d42-353b-4c33-af8f-56519efe857e",
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
    --url 'https://example.booqable.com/api/boomerang/menus/70907538-97ca-444c-a9f3-faba16c40f95' \
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