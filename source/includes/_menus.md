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
      "id": "3be0353c-23de-4735-a172-6eb1b01bd548",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-12T14:27:56+00:00",
        "updated_at": "2023-01-12T14:27:56+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=3be0353c-23de-4735-a172-6eb1b01bd548"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-12T14:26:09Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/03ce1ccd-00a3-447b-b1e7-4930f0eed66a?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "03ce1ccd-00a3-447b-b1e7-4930f0eed66a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-12T14:27:56+00:00",
      "updated_at": "2023-01-12T14:27:56+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=03ce1ccd-00a3-447b-b1e7-4930f0eed66a"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "8cc0ef23-6060-4fdb-9b8b-ad233e3fa21e"
          },
          {
            "type": "menu_items",
            "id": "e4aa3536-bf56-4e7a-a0fe-bd47bcbf5295"
          },
          {
            "type": "menu_items",
            "id": "886d7d28-8e45-4919-889f-a4f72935d66e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8cc0ef23-6060-4fdb-9b8b-ad233e3fa21e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-12T14:27:56+00:00",
        "updated_at": "2023-01-12T14:27:56+00:00",
        "menu_id": "03ce1ccd-00a3-447b-b1e7-4930f0eed66a",
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
            "related": "api/boomerang/menus/03ce1ccd-00a3-447b-b1e7-4930f0eed66a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8cc0ef23-6060-4fdb-9b8b-ad233e3fa21e"
          }
        }
      }
    },
    {
      "id": "e4aa3536-bf56-4e7a-a0fe-bd47bcbf5295",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-12T14:27:56+00:00",
        "updated_at": "2023-01-12T14:27:56+00:00",
        "menu_id": "03ce1ccd-00a3-447b-b1e7-4930f0eed66a",
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
            "related": "api/boomerang/menus/03ce1ccd-00a3-447b-b1e7-4930f0eed66a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e4aa3536-bf56-4e7a-a0fe-bd47bcbf5295"
          }
        }
      }
    },
    {
      "id": "886d7d28-8e45-4919-889f-a4f72935d66e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-12T14:27:56+00:00",
        "updated_at": "2023-01-12T14:27:56+00:00",
        "menu_id": "03ce1ccd-00a3-447b-b1e7-4930f0eed66a",
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
            "related": "api/boomerang/menus/03ce1ccd-00a3-447b-b1e7-4930f0eed66a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=886d7d28-8e45-4919-889f-a4f72935d66e"
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
    "id": "3c41dedb-3c05-4899-8beb-575434028246",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-12T14:27:57+00:00",
      "updated_at": "2023-01-12T14:27:57+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/cbed0df7-ccdd-4a74-8b69-41dd670849b0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cbed0df7-ccdd-4a74-8b69-41dd670849b0",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "9d1e1e81-8129-4bfb-a47b-bac5bc7cbf55",
              "title": "Contact us"
            },
            {
              "id": "7dcd6ec9-56de-408a-a7ec-b565aeb13fa8",
              "title": "Start"
            },
            {
              "id": "fca3f419-3075-4372-8098-a05da7f80b78",
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
    "id": "cbed0df7-ccdd-4a74-8b69-41dd670849b0",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-12T14:27:57+00:00",
      "updated_at": "2023-01-12T14:27:57+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "9d1e1e81-8129-4bfb-a47b-bac5bc7cbf55"
          },
          {
            "type": "menu_items",
            "id": "7dcd6ec9-56de-408a-a7ec-b565aeb13fa8"
          },
          {
            "type": "menu_items",
            "id": "fca3f419-3075-4372-8098-a05da7f80b78"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9d1e1e81-8129-4bfb-a47b-bac5bc7cbf55",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-12T14:27:57+00:00",
        "updated_at": "2023-01-12T14:27:57+00:00",
        "menu_id": "cbed0df7-ccdd-4a74-8b69-41dd670849b0",
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
      "id": "7dcd6ec9-56de-408a-a7ec-b565aeb13fa8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-12T14:27:57+00:00",
        "updated_at": "2023-01-12T14:27:57+00:00",
        "menu_id": "cbed0df7-ccdd-4a74-8b69-41dd670849b0",
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
      "id": "fca3f419-3075-4372-8098-a05da7f80b78",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-12T14:27:57+00:00",
        "updated_at": "2023-01-12T14:27:57+00:00",
        "menu_id": "cbed0df7-ccdd-4a74-8b69-41dd670849b0",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0a43539f-5cbe-48d7-8564-5951b5988124' \
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