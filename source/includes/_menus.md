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
      "id": "3f5e70fc-3295-4457-8b71-c6fb28231f93",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-28T08:45:38+00:00",
        "updated_at": "2023-02-28T08:45:38+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=3f5e70fc-3295-4457-8b71-c6fb28231f93"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T08:43:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/0fb760cf-48f1-4a61-b87b-4e540e2cb4e5?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0fb760cf-48f1-4a61-b87b-4e540e2cb4e5",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-28T08:45:38+00:00",
      "updated_at": "2023-02-28T08:45:38+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=0fb760cf-48f1-4a61-b87b-4e540e2cb4e5"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "cffb68e2-f911-475b-9135-7104562f7cf6"
          },
          {
            "type": "menu_items",
            "id": "7df526fb-ac44-4032-8a20-e72e14cbdb56"
          },
          {
            "type": "menu_items",
            "id": "bbf59e71-e8f1-4978-869c-4666bddcbbf2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cffb68e2-f911-475b-9135-7104562f7cf6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T08:45:38+00:00",
        "updated_at": "2023-02-28T08:45:38+00:00",
        "menu_id": "0fb760cf-48f1-4a61-b87b-4e540e2cb4e5",
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
            "related": "api/boomerang/menus/0fb760cf-48f1-4a61-b87b-4e540e2cb4e5"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cffb68e2-f911-475b-9135-7104562f7cf6"
          }
        }
      }
    },
    {
      "id": "7df526fb-ac44-4032-8a20-e72e14cbdb56",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T08:45:38+00:00",
        "updated_at": "2023-02-28T08:45:38+00:00",
        "menu_id": "0fb760cf-48f1-4a61-b87b-4e540e2cb4e5",
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
            "related": "api/boomerang/menus/0fb760cf-48f1-4a61-b87b-4e540e2cb4e5"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7df526fb-ac44-4032-8a20-e72e14cbdb56"
          }
        }
      }
    },
    {
      "id": "bbf59e71-e8f1-4978-869c-4666bddcbbf2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T08:45:38+00:00",
        "updated_at": "2023-02-28T08:45:38+00:00",
        "menu_id": "0fb760cf-48f1-4a61-b87b-4e540e2cb4e5",
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
            "related": "api/boomerang/menus/0fb760cf-48f1-4a61-b87b-4e540e2cb4e5"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bbf59e71-e8f1-4978-869c-4666bddcbbf2"
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
    "id": "2ba118a7-12d9-47be-ada9-1dff9886c689",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-28T08:45:39+00:00",
      "updated_at": "2023-02-28T08:45:39+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/486bd911-c717-478f-9547-c9a6fac24765' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "486bd911-c717-478f-9547-c9a6fac24765",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "06414391-92db-4f18-beca-c588b703deb2",
              "title": "Contact us"
            },
            {
              "id": "e68b1e49-108c-46d1-b817-a889100c571e",
              "title": "Start"
            },
            {
              "id": "444c6e12-7a3f-4293-b79c-26892fbda01f",
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
    "id": "486bd911-c717-478f-9547-c9a6fac24765",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-28T08:45:39+00:00",
      "updated_at": "2023-02-28T08:45:39+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "06414391-92db-4f18-beca-c588b703deb2"
          },
          {
            "type": "menu_items",
            "id": "e68b1e49-108c-46d1-b817-a889100c571e"
          },
          {
            "type": "menu_items",
            "id": "444c6e12-7a3f-4293-b79c-26892fbda01f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "06414391-92db-4f18-beca-c588b703deb2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T08:45:39+00:00",
        "updated_at": "2023-02-28T08:45:39+00:00",
        "menu_id": "486bd911-c717-478f-9547-c9a6fac24765",
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
      "id": "e68b1e49-108c-46d1-b817-a889100c571e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T08:45:39+00:00",
        "updated_at": "2023-02-28T08:45:39+00:00",
        "menu_id": "486bd911-c717-478f-9547-c9a6fac24765",
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
      "id": "444c6e12-7a3f-4293-b79c-26892fbda01f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T08:45:39+00:00",
        "updated_at": "2023-02-28T08:45:39+00:00",
        "menu_id": "486bd911-c717-478f-9547-c9a6fac24765",
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
    --url 'https://example.booqable.com/api/boomerang/menus/74ec01fb-e621-4122-8e22-cca4d3fc1fca' \
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