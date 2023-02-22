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
      "id": "0e7d8c2a-0801-48dc-9f70-7e705c21667c",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-22T14:14:16+00:00",
        "updated_at": "2023-02-22T14:14:16+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=0e7d8c2a-0801-48dc-9f70-7e705c21667c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T14:12:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/488ca14b-ee41-41aa-ae87-816eb86b8b40?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "488ca14b-ee41-41aa-ae87-816eb86b8b40",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-22T14:14:16+00:00",
      "updated_at": "2023-02-22T14:14:16+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=488ca14b-ee41-41aa-ae87-816eb86b8b40"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "a87905e0-29ee-472f-a423-78ac3d509d5d"
          },
          {
            "type": "menu_items",
            "id": "986dd842-d430-43c2-a829-48adbab89859"
          },
          {
            "type": "menu_items",
            "id": "d6bd83fc-01ec-41f9-9b0a-56382fb623b3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a87905e0-29ee-472f-a423-78ac3d509d5d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T14:14:16+00:00",
        "updated_at": "2023-02-22T14:14:16+00:00",
        "menu_id": "488ca14b-ee41-41aa-ae87-816eb86b8b40",
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
            "related": "api/boomerang/menus/488ca14b-ee41-41aa-ae87-816eb86b8b40"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a87905e0-29ee-472f-a423-78ac3d509d5d"
          }
        }
      }
    },
    {
      "id": "986dd842-d430-43c2-a829-48adbab89859",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T14:14:16+00:00",
        "updated_at": "2023-02-22T14:14:16+00:00",
        "menu_id": "488ca14b-ee41-41aa-ae87-816eb86b8b40",
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
            "related": "api/boomerang/menus/488ca14b-ee41-41aa-ae87-816eb86b8b40"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=986dd842-d430-43c2-a829-48adbab89859"
          }
        }
      }
    },
    {
      "id": "d6bd83fc-01ec-41f9-9b0a-56382fb623b3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T14:14:16+00:00",
        "updated_at": "2023-02-22T14:14:16+00:00",
        "menu_id": "488ca14b-ee41-41aa-ae87-816eb86b8b40",
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
            "related": "api/boomerang/menus/488ca14b-ee41-41aa-ae87-816eb86b8b40"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d6bd83fc-01ec-41f9-9b0a-56382fb623b3"
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
    "id": "7a685690-45b8-45d1-a4c2-52ea2e5e7487",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-22T14:14:17+00:00",
      "updated_at": "2023-02-22T14:14:17+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/82f4c45a-b90f-4634-b818-0ac5c08a5b0e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "82f4c45a-b90f-4634-b818-0ac5c08a5b0e",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d41e241d-da6e-443c-a0d1-f6b874b6e70b",
              "title": "Contact us"
            },
            {
              "id": "2635aec9-1255-41d7-8f9a-53d04caa9a17",
              "title": "Start"
            },
            {
              "id": "b78cad11-dde5-4886-ab06-be58170bb170",
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
    "id": "82f4c45a-b90f-4634-b818-0ac5c08a5b0e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-22T14:14:17+00:00",
      "updated_at": "2023-02-22T14:14:17+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d41e241d-da6e-443c-a0d1-f6b874b6e70b"
          },
          {
            "type": "menu_items",
            "id": "2635aec9-1255-41d7-8f9a-53d04caa9a17"
          },
          {
            "type": "menu_items",
            "id": "b78cad11-dde5-4886-ab06-be58170bb170"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d41e241d-da6e-443c-a0d1-f6b874b6e70b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T14:14:17+00:00",
        "updated_at": "2023-02-22T14:14:17+00:00",
        "menu_id": "82f4c45a-b90f-4634-b818-0ac5c08a5b0e",
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
      "id": "2635aec9-1255-41d7-8f9a-53d04caa9a17",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T14:14:17+00:00",
        "updated_at": "2023-02-22T14:14:17+00:00",
        "menu_id": "82f4c45a-b90f-4634-b818-0ac5c08a5b0e",
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
      "id": "b78cad11-dde5-4886-ab06-be58170bb170",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T14:14:17+00:00",
        "updated_at": "2023-02-22T14:14:17+00:00",
        "menu_id": "82f4c45a-b90f-4634-b818-0ac5c08a5b0e",
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
    --url 'https://example.booqable.com/api/boomerang/menus/80cd7b3b-1d14-418e-be76-6837a555327b' \
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