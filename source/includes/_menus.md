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
      "id": "96f0a605-e3f3-4869-bda1-41dbe6ba9599",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-02T16:59:27+00:00",
        "updated_at": "2023-02-02T16:59:27+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=96f0a605-e3f3-4869-bda1-41dbe6ba9599"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:57:52Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/18188dcf-3f8b-42f2-b0cc-96da5b808b55?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "18188dcf-3f8b-42f2-b0cc-96da5b808b55",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T16:59:27+00:00",
      "updated_at": "2023-02-02T16:59:27+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=18188dcf-3f8b-42f2-b0cc-96da5b808b55"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "729ea3c8-e3c3-4d40-b030-a86d81957a0f"
          },
          {
            "type": "menu_items",
            "id": "15f6d68e-d113-43c7-b84e-cdfb6d2a6991"
          },
          {
            "type": "menu_items",
            "id": "ab8a8cc8-1a72-407d-9e79-6fd249432d02"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "729ea3c8-e3c3-4d40-b030-a86d81957a0f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:59:27+00:00",
        "updated_at": "2023-02-02T16:59:27+00:00",
        "menu_id": "18188dcf-3f8b-42f2-b0cc-96da5b808b55",
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
            "related": "api/boomerang/menus/18188dcf-3f8b-42f2-b0cc-96da5b808b55"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=729ea3c8-e3c3-4d40-b030-a86d81957a0f"
          }
        }
      }
    },
    {
      "id": "15f6d68e-d113-43c7-b84e-cdfb6d2a6991",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:59:27+00:00",
        "updated_at": "2023-02-02T16:59:27+00:00",
        "menu_id": "18188dcf-3f8b-42f2-b0cc-96da5b808b55",
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
            "related": "api/boomerang/menus/18188dcf-3f8b-42f2-b0cc-96da5b808b55"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=15f6d68e-d113-43c7-b84e-cdfb6d2a6991"
          }
        }
      }
    },
    {
      "id": "ab8a8cc8-1a72-407d-9e79-6fd249432d02",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:59:27+00:00",
        "updated_at": "2023-02-02T16:59:27+00:00",
        "menu_id": "18188dcf-3f8b-42f2-b0cc-96da5b808b55",
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
            "related": "api/boomerang/menus/18188dcf-3f8b-42f2-b0cc-96da5b808b55"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ab8a8cc8-1a72-407d-9e79-6fd249432d02"
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
    "id": "3825dd53-41db-4192-a378-87bdd9abc957",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T16:59:27+00:00",
      "updated_at": "2023-02-02T16:59:27+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/547547b5-a242-48c8-9513-b0ef583b34eb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "547547b5-a242-48c8-9513-b0ef583b34eb",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "af911f51-a30e-4f49-aa61-5709e48920a0",
              "title": "Contact us"
            },
            {
              "id": "5417e048-2ee2-4b66-9125-669d6bbb9b5f",
              "title": "Start"
            },
            {
              "id": "c3b301fc-af79-489d-b45b-e1a5ea563609",
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
    "id": "547547b5-a242-48c8-9513-b0ef583b34eb",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-02T16:59:28+00:00",
      "updated_at": "2023-02-02T16:59:28+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "af911f51-a30e-4f49-aa61-5709e48920a0"
          },
          {
            "type": "menu_items",
            "id": "5417e048-2ee2-4b66-9125-669d6bbb9b5f"
          },
          {
            "type": "menu_items",
            "id": "c3b301fc-af79-489d-b45b-e1a5ea563609"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "af911f51-a30e-4f49-aa61-5709e48920a0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:59:28+00:00",
        "updated_at": "2023-02-02T16:59:28+00:00",
        "menu_id": "547547b5-a242-48c8-9513-b0ef583b34eb",
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
      "id": "5417e048-2ee2-4b66-9125-669d6bbb9b5f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:59:28+00:00",
        "updated_at": "2023-02-02T16:59:28+00:00",
        "menu_id": "547547b5-a242-48c8-9513-b0ef583b34eb",
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
      "id": "c3b301fc-af79-489d-b45b-e1a5ea563609",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-02T16:59:28+00:00",
        "updated_at": "2023-02-02T16:59:28+00:00",
        "menu_id": "547547b5-a242-48c8-9513-b0ef583b34eb",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9587bc68-accf-4719-8f5e-3cb9a1a43235' \
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