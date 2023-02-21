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
      "id": "9c36de31-1d13-482f-8ea8-f4d4334ab281",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-21T16:22:44+00:00",
        "updated_at": "2023-02-21T16:22:44+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=9c36de31-1d13-482f-8ea8-f4d4334ab281"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T16:20:54Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/eb4ad50b-2868-4671-83ee-6d30f3d655ca?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eb4ad50b-2868-4671-83ee-6d30f3d655ca",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-21T16:22:44+00:00",
      "updated_at": "2023-02-21T16:22:44+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=eb4ad50b-2868-4671-83ee-6d30f3d655ca"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "e3cbbaa3-c071-410f-aec4-1d49363df541"
          },
          {
            "type": "menu_items",
            "id": "e45b4b10-b312-466c-b5d9-36ea1e583595"
          },
          {
            "type": "menu_items",
            "id": "1850f474-1b41-43f5-998c-6523eb26f75c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e3cbbaa3-c071-410f-aec4-1d49363df541",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-21T16:22:44+00:00",
        "updated_at": "2023-02-21T16:22:44+00:00",
        "menu_id": "eb4ad50b-2868-4671-83ee-6d30f3d655ca",
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
            "related": "api/boomerang/menus/eb4ad50b-2868-4671-83ee-6d30f3d655ca"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e3cbbaa3-c071-410f-aec4-1d49363df541"
          }
        }
      }
    },
    {
      "id": "e45b4b10-b312-466c-b5d9-36ea1e583595",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-21T16:22:44+00:00",
        "updated_at": "2023-02-21T16:22:44+00:00",
        "menu_id": "eb4ad50b-2868-4671-83ee-6d30f3d655ca",
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
            "related": "api/boomerang/menus/eb4ad50b-2868-4671-83ee-6d30f3d655ca"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e45b4b10-b312-466c-b5d9-36ea1e583595"
          }
        }
      }
    },
    {
      "id": "1850f474-1b41-43f5-998c-6523eb26f75c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-21T16:22:44+00:00",
        "updated_at": "2023-02-21T16:22:44+00:00",
        "menu_id": "eb4ad50b-2868-4671-83ee-6d30f3d655ca",
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
            "related": "api/boomerang/menus/eb4ad50b-2868-4671-83ee-6d30f3d655ca"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1850f474-1b41-43f5-998c-6523eb26f75c"
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
    "id": "7f2b9a39-fdd9-4ecf-963d-245dc2e9a695",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-21T16:22:45+00:00",
      "updated_at": "2023-02-21T16:22:45+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/42b51a96-4d98-4994-9ab4-1ca3b2f6c733' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "42b51a96-4d98-4994-9ab4-1ca3b2f6c733",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "489ef0f2-7c09-455a-b4c4-a96a55374e16",
              "title": "Contact us"
            },
            {
              "id": "4ac9b749-2f8c-4c7d-9c3c-3686442deb7a",
              "title": "Start"
            },
            {
              "id": "fe57b143-0786-43f9-8ca4-243a2944dbd0",
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
    "id": "42b51a96-4d98-4994-9ab4-1ca3b2f6c733",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-21T16:22:45+00:00",
      "updated_at": "2023-02-21T16:22:45+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "489ef0f2-7c09-455a-b4c4-a96a55374e16"
          },
          {
            "type": "menu_items",
            "id": "4ac9b749-2f8c-4c7d-9c3c-3686442deb7a"
          },
          {
            "type": "menu_items",
            "id": "fe57b143-0786-43f9-8ca4-243a2944dbd0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "489ef0f2-7c09-455a-b4c4-a96a55374e16",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-21T16:22:45+00:00",
        "updated_at": "2023-02-21T16:22:45+00:00",
        "menu_id": "42b51a96-4d98-4994-9ab4-1ca3b2f6c733",
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
      "id": "4ac9b749-2f8c-4c7d-9c3c-3686442deb7a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-21T16:22:45+00:00",
        "updated_at": "2023-02-21T16:22:45+00:00",
        "menu_id": "42b51a96-4d98-4994-9ab4-1ca3b2f6c733",
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
      "id": "fe57b143-0786-43f9-8ca4-243a2944dbd0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-21T16:22:45+00:00",
        "updated_at": "2023-02-21T16:22:45+00:00",
        "menu_id": "42b51a96-4d98-4994-9ab4-1ca3b2f6c733",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fdecc522-488f-4cf0-94b0-04aee5850586' \
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